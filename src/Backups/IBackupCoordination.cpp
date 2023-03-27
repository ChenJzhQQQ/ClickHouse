#include <Backups/IBackupCoordination.h>

#include <IO/ReadHelpers.h>
#include <IO/WriteHelpers.h>

namespace DB
{

String IBackupCoordination::FileInfo::describe() const
{
    String result;
    result += fmt::format("file_name: {};\n", file_name);
    result += fmt::format("size: {};\n", size);
    result += fmt::format("checksum: {};\n", getHexUIntLowercase(checksum));
    result += fmt::format("base_size: {};\n", base_size);
    result += fmt::format("base_checksum: {};\n", getHexUIntLowercase(checksum));
    result += fmt::format("data_file_name: {};\n", data_file_name);
    result += fmt::format("archive_suffix: {};\n", archive_suffix);
    result += fmt::format("pos_in_archive: {};\n", pos_in_archive);
    return result;
}


void IBackupCoordination::FileInfo::serialize(WriteBuffer & out) const
{
    writeBinary(file_name, out);
    writeBinary(size, out);
    writeBinary(checksum, out);
    writeBinary(base_size, out);
    writeBinary(base_checksum, out);
    writeBinary(data_file_name, out);
    writeBinary(archive_suffix, out);
    writeBinary(pos_in_archive, out);
}


void IBackupCoordination::FileInfo::deserialize(ReadBuffer & in)
{
    readBinary(file_name, in);
    readBinary(size, in);
    readBinary(checksum, in);
    readBinary(base_size, in);
    readBinary(base_checksum, in);
    readBinary(data_file_name, in);
    readBinary(archive_suffix, in);
    readBinary(pos_in_archive, in);
}

}
