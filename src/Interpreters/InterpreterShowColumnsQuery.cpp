#include <Interpreters/InterpreterShowColumnsQuery.h>

// TODO
#include <IO/ReadBufferFromString.h>
#include <Parsers/ASTShowColumnsQuery.h>
#include <Parsers/formatAST.h>
#include <Interpreters/Context.h>
#include <Interpreters/DatabaseCatalog.h>
#include <Interpreters/executeQuery.h>
#include <DataTypes/DataTypeString.h>
#include <Storages/ColumnsDescription.h>
#include <Interpreters/Cache/FileCacheFactory.h>
#include <Processors/Sources/SourceFromSingleChunk.h>
#include <Access/Common/AccessFlags.h>
#include <Common/typeid_cast.h>
#include <IO/Operators.h>


namespace DB
{

namespace ErrorCodes
{
    extern const int SYNTAX_ERROR;
}


InterpreterShowColumnsQuery::InterpreterShowColumnsQuery(const ASTPtr & query_ptr_, ContextMutablePtr context_)
    : WithMutableContext(context_)
    , query_ptr(query_ptr_)
{
}


String InterpreterShowColumnsQuery::getRewrittenQuery()
{
    const auto & query = query_ptr->as<ASTShowColumnsQuery &>();

    /// String database = getContext()->resolveDatabase(query.from);
    /// DatabaseCatalog::instance().assertDatabaseExists(database);

    WriteBufferFromOwnString rewritten_query;

    rewritten_query << "SELECT name AS field, type AS type, startsWith(type, 'Nullable') AS null, if(is_in_partition_key, 'PRI', '') AS key, if(default_kind IN ('ALIAS', 'DEFAULT', 'MATERIALIZED'), default_expression, NULL) AS default, '' AS extra ";

    if (query.full)
        rewritten_query << ", comment ";

    rewritten_query << "FROM system.columns WHERE ";

    rewritten_query << "table = " << DB::quote << query.from; // TODO database

    if (!query.like.empty())
        rewritten_query
            << "AND name "
            << (query.not_like ? "NOT " : "")
            << (query.case_insensitive_like ? "ILIKE " : "LIKE ")
            << DB::quote << query.like;
    else if (query.where_expression)
        rewritten_query << " AND (" << query.where_expression << ")";

    // TODO interpret query.extended ... fetch virtual column names from IStorage::getVirtuals()

    if (query.limit_length)
        rewritten_query << " LIMIT " << query.limit_length;

    return rewritten_query.str();

}


BlockIO InterpreterShowColumnsQuery::execute()
{
    return executeQuery(getRewrittenQuery(), getContext(), true);
}


}
