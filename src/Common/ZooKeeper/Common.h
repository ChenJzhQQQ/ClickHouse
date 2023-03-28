#pragma once

#include "ZooKeeper.h"
#include <functional>
#include "Common/ZooKeeper/ZooKeeperWithFaultInjection.h"

namespace zkutil
{

using GetZooKeeper = std::function<ZooKeeperPtr()>;
using GetZooKeeperWithFaultInjection = std::function<Coordination::ZooKeeperWithFaultInjection::Ptr()>;

}
