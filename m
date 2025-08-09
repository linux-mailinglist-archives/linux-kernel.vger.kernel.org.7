Return-Path: <linux-kernel+bounces-760933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091FB1F229
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1661AA13D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13471DC994;
	Sat,  9 Aug 2025 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iukhOLh1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391991DA3D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754715860; cv=none; b=NqFOUFy6tLcnNProOos12m5lJuAxnYzSugo16PEomsSYbWeqp1UZXKz9qmlykqj4oq1RMh65OOa1+sEIXAcflCYs83ZRymoPo8417vD6chJF+O3HBwLFBov5OQQCgQpywdP/4y72YiyIl/w9ivEmIdSA6BzsEghmsCUNjWyYBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754715860; c=relaxed/simple;
	bh=zs6fiWyeJxJW+P8PVnjE3ytrp0dBQbNN2f26oDJ4fdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrKjaOXNr2LclfM3eKjxdT4iaPICBsluqbs3olyWjvaTWpoNxtZDagy7dJ+Azqu4sfUmYGVcOLxSiQyTycJsceKGuUJLnCtyuTXXVS4YcqlJrWEWP83KZKctaPvkKYX5EbTmZNOjPLH1Lgvw1395CthNs5cHHssazRmAdw1gPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iukhOLh1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754715858; x=1786251858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zs6fiWyeJxJW+P8PVnjE3ytrp0dBQbNN2f26oDJ4fdE=;
  b=iukhOLh16KoDXVtfFvvVE+8TP1+g3SiDqeZmANvrTkp3UcoaQe5e3hHf
   Vf33Rd7DEebyy/jaTcSvm1jiTlWfuqUvYEfzfl0RVyDZKTlWjSKwTnV13
   T97T9h4cxGw2IsxHvckzAHskGlrqOerSajkS3XLc0EWB+3ATPt6cQtcq8
   +POdnk3UAmyyf+QvjizTOOzGOxDLoboUWVRU/kCA6GeO2B5ACCRsNOR32
   FyXLjn+5W487dFxQiAik2xx/8B0DsTfjwmtvqIiYCnSfSdxKVToNNNQFF
   Z1GLWX73mUupEMEAfC1C3bs6Vca3n7yfaH8uOcW6ewotjcgU+3QNqnTfz
   A==;
X-CSE-ConnectionGUID: bvp8HbdoSFSTTywbVK6YCA==
X-CSE-MsgGUID: Ezx+nXb8Rr66fePEX7OxwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56932300"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56932300"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:04:17 -0700
X-CSE-ConnectionGUID: 8vR11V8YSgaBuBlZWu0deg==
X-CSE-MsgGUID: SsrVP76qTZGs0Fn2Xw1Pjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196303036"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2025 22:04:11 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>,
	Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 00/28] Cache aware load-balancing
Date: Sat,  9 Aug 2025 12:57:50 +0800
Message-Id: <cover.1754712565.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Chen <tim.c.chen@linux.intel.com>

This is the forth revision of the cache aware scheduling
patches, based on the original patch proposed by Peter[1].

The main change in v4 is to address the performance regressions
reported in v3, which are caused by over-aggregation of tasks in
a single LLC, but they don't actually share data. Such aggregation
could cause regression on platforms with smaller LLC size. It can
also occur when running workloads with a large memory footprint
(e.g., stream) or when workloads involve too many threads
(e.g., hackbench).

Patches 1 to 20 are almost identical to those in v3; the key fixes
are included in patches 21 to 28. The approach involves tracking a
process's resident pages and comparing this to the LLC cache size.

To that effect, /sys/kernel/debug/sched/sched_cache_ignore_rss
is added where
0 turns off cache aware scheduling entirely
1 turns off cache aware scheduling when resident memory of process
  exceed LLC size (default)
100 RSS will not be taken into account during cache aware scheduling
N translates to turn off cache aware scheduling when RSS is
greater than (N-1) * 256 * LLC size

So for folks who want to make cache aware scheduling to
be aggressive and they know their process threads share lots of
data, they could set it to 100.

Similarly, the number of active threads within each process is
monitored and compared to the number of cores (excluding SMT) in
each LLC.

The second update is to limit the scan of a process's occupancy
for new preferred LLC candidate to preferred NUMA node from NUMA
balancing, node of current preferred LLC and node of current CPU.
It is very likely that these nodes overlap and reduces the scanning
cost. We also check to see if there are no NUMA node with more than
one LLC, cache aware scheduling is turned off and we will strictly
let NUMA balancing consolidate the tasks of a process.

v4 of cache aware scheduling relies only on load balancing to do
task aggregation as doing that during wake up is expensive. By
default, LLC task aggregation during wake-up is disabled.
Conversely, cache-aware load balancing is enabled by default.
For easier comparison, two scheduler features are introduced:
SCHED_CACHE_WAKE and SCHED_CACHE_LB,
which control cache-aware wake up and cache-aware load
balancing, respectively. We plan to obsolete SCHED_CACHE_WAKE
in future.

The load balancing and migration policy are now implemented in
a single location within the function _get_migrate_hint().
Debugfs knobs are also introduced to fine-tune the cache aware
load balancing. Please refer to patch 7 for detail.

Test results:
Tested on a 2 socket Intel Sapphire Rapids with 30 cores per
socket. The DRAM interleaving is enabled in the BIOS so it
essential has one NUMA node with two last level caches.
AMD Milan is also tested. There are 4 Nodes and 32 CPUs per node.
Each node has 4 CCX(shared LLC) and each CCX has 8 CPUs.

[TL;DR]
Sappire Rapids:
hackbench shows significant improvement when there is 1 group
with different number of fd pairs(threads) within this process.
schbench shows overall wakeup latency improvement.
Other micro-workloads did not show much difference.

Milan:
Regression in v3 has been mitigated a lot. For hackbench
and schbench, we still saw some regressions, and it can
be further tuned via debugfs to inhibit the cache aware
scheduling when it is overloaded.

[Sapphire Rapids details]
[hackbench]
Hackbench show overall improvement when there is only 1
group, with different number of fd(pairs). This is the
expected behavior because this test scenario would benefit
from cache aware load balance most. Other number of groups
shows not much difference(using default fd = 20).
                           baseline            sched_cache
         groups            hackbench              hackbench
Min       1      35.2340 (   0.00%)     27.2560 (  22.64%)
Min       3      36.0700 (   0.00%)     38.1750 (  -5.84%)
Min       5      36.4790 (   0.00%)     39.6540 (  -8.70%)
Min       7      51.2000 (   0.00%)     52.9050 (  -3.33%)
Min       12     63.1010 (   0.00%)     64.2940 (  -1.89%)
Min       16     75.0700 (   0.00%)     77.1050 (  -2.71%)
Amean     1      37.3802 (   0.00%)     28.0908 *  24.85%*
Amean     3      40.3703 (   0.00%)     40.1250 (   0.61%)
Amean     5      42.1782 (   0.00%)     41.4368 (   1.76%)
Amean     7      51.4848 (   0.00%)     53.3075 *  -3.54%*
Amean     12     63.6612 (   0.00%)     65.4685 (  -2.84%)
Amean     16     75.3333 (   0.00%)     78.5802 *  -4.31%*

[stream]
No much difference is observed.
512MB:
                         baseline_512        sched_cache_512
                        baseline_512M       sched_cache_512M
GB/sec copy-2        34.34 (   0.00%)       35.14 (   2.32%)
GB/sec scale-2       23.80 (   0.00%)       23.91 (   0.44%)
GB/sec add-2         28.89 (   0.00%)       28.92 (   0.12%)
GB/sec triad-2       28.62 (   0.00%)       28.67 (   0.17%)

2GB: 
                           baseline_2          sched_cache_2
                          baseline_2G         sched_cache_2G
GB/sec copy-2        35.68 (   0.00%)       36.03 (   0.97%)
GB/sec scale-2       23.85 (   0.00%)       23.83 (  -0.07%)
GB/sec add-2         28.47 (   0.00%)       28.42 (  -0.18%)
GB/sec triad-2       28.38 (   0.00%)       28.34 (  -0.15%)

[netperf]
No much difference is observed.

                          baseline            sched_cache
         nr_pairs          netperf                netperf
Hmean     1     1343.86 (   0.00%)     1344.58 (   0.05%)
BHmean-99 1     1346.54 (   0.00%)     1345.66 (  -0.07%)
Hmean     2     1322.98 (   0.00%)     1324.21 (   0.09%)
BHmean-99 2     1324.14 (   0.00%)     1325.78 (   0.12%)
Hmean     4     1327.85 (   0.00%)     1330.82 (   0.22%)
BHmean-99 4     1328.92 (   0.00%)     1331.68 (   0.21%)
Hmean     8     1313.72 (   0.00%)     1314.35 (   0.05%)
BHmean-99 8     1316.47 (   0.00%)     1315.65 (  -0.06%)
Hmean     16     1288.49 (   0.00%)     1294.18 (   0.44%)
BHmean-99 16     1290.63 (   0.00%)     1295.03 (   0.34%)
Hmean     32     1254.83 (   0.00%)     1260.84 (   0.48%)
BHmean-99 32     1258.50 (   0.00%)     1264.73 (   0.49%)
Hmean     64     1128.96 (   0.00%)     1127.00 (  -0.17%)
BHmean-99 64     1131.06 (   0.00%)     1127.83 (  -0.29%)
Hmean     128      799.18 (   0.00%)      796.50 (  -0.33%)
BHmean-99 128      802.29 (   0.00%)      799.37 (  -0.36%)
Hmean     256      400.59 (   0.00%)      399.65 (  -0.24%)
BHmean-99 256      402.76 (   0.00%)      401.76 (  -0.25%)

[schbench]
Overall 99.0th wakeup latency improvement is observed.

Metric                         Base (mean std)      Compare (mean std)   Change    
-------------------------------------------------------------------------------------
schbench thread = 1
Wakeup Latencies 99.0th        15.80(2.39)          14.60(1.52)          +7.59%    
Request Latencies 99.0th       3924.00(24.66)       3935.20(23.73)       -0.29%    
RPS 50.0th                     267.40(1.34)         266.40(1.34)         -0.37%    
Average RPS                    268.53(1.68)         267.57(1.46)         -0.36%    

schbench thread = 2
Wakeup Latencies 99.0th        17.20(0.45)          15.80(0.45)          +8.14%    
Request Latencies 99.0th       3900.00(11.31)       3914.40(31.19)       -0.37%    
RPS 50.0th                     537.00(0.00)         536.20(1.10)         -0.15%    
Average RPS                    537.80(0.25)         535.08(1.93)         -0.51%    

schbench thread = 4
Wakeup Latencies 99.0th        12.80(0.84)          12.40(0.55)          +3.13%    
Request Latencies 99.0th       3864.80(36.04)       3839.20(36.49)       +0.66%    
RPS 50.0th                     1076.40(2.19)        1077.20(1.79)        +0.07%    
Average RPS                    1074.00(2.43)        1073.44(2.24)        -0.05%    

schbench thread = 8
Wakeup Latencies 99.0th        13.60(1.67)          9.80(0.84)           +27.94%   
Request Latencies 99.0th       3746.40(22.20)       3794.40(32.69)       -1.28%    
RPS 50.0th                     2159.20(4.38)        2159.20(4.38)        0.00%     
Average RPS                    2155.74(2.77)        2154.16(1.86)        -0.07%    

schbench thread = 16
Wakeup Latencies 99.0th        12.60(1.52)          9.00(0.71)           +28.57%   
Request Latencies 99.0th       3775.20(26.29)       3783.20(15.59)       -0.21%    
RPS 50.0th                     4318.40(8.76)        4312.00(0.00)        -0.15%    
Average RPS                    4311.62(5.94)        4308.49(3.69)        -0.07%    

schbench thread = 32
Wakeup Latencies 99.0th        12.20(0.45)          8.80(0.84)           +27.87%   
Request Latencies 99.0th       3781.60(27.36)       3812.00(23.32)       -0.80%    
RPS 50.0th                     8630.40(14.31)       8630.40(14.31)       0.00%     
Average RPS                    8621.32(3.34)        8614.98(8.24)        -0.07%    

schbench thread = 64
Wakeup Latencies 99.0th        12.60(0.55)          10.20(1.10)          +19.05%   
Request Latencies 99.0th       3778.40(19.10)       5498.40(2130.50)     -45.52%   
RPS 50.0th                     17248.00(0.00)       16774.40(560.98)     -2.75%    
Average RPS                    17249.44(6.83)       16727.70(544.81)     -3.02%    

schbench thread = 128
Wakeup Latencies 99.0th        14.00(0.00)          14.40(0.55)          -2.86%    
Request Latencies 99.0th       7860.80(7.16)        8123.20(20.86)       -3.34%    
RPS 50.0th                     32147.20(145.94)     29587.20(2081.43)    -7.96%    
Average RPS                    31546.92(444.17)     28827.07(1842.18)    -8.62%    

schbench thread = 239
Wakeup Latencies 99.0th        41.60(2.07)          39.20(2.05)          +5.77%    
Request Latencies 99.0th       8056.00(0.00)        8361.60(26.77)       -3.79%    
RPS 50.0th                     31020.80(28.62)      30137.60(57.24)      -2.85%    
Average RPS                    31052.18(32.53)      30158.53(47.73)      -2.88%    


[Milan details]
[hackbench]
Regressions are observed when many hackbench instances are
running simultaneously. Considering that the per-process
nr_running statistic is tracked in v4, reintroducing the
per-LLC nr_running statistic (as in v1/v2) might mitigate
the regression (and could be implemented in v5).

                           baseline            sched_cache
                          hackbench              hackbench
Min       1      50.8910 (   0.00%)     51.3470 (  -0.90%)
Min       3      51.1380 (   0.00%)     52.1710 (  -2.02%)
Min       5      75.5740 (   0.00%)     79.9060 (  -5.73%)
Min       7     106.0020 (   0.00%)    111.6930 (  -5.37%)
Min       12    177.3530 (   0.00%)    195.9230 ( -10.47%)
Min       16    238.8580 (   0.00%)    268.5540 ( -12.43%)
Amean     1      52.0164 (   0.00%)     52.0198 (  -0.01%)
Amean     3      51.6346 (   0.00%)     52.9120 (  -2.47%)
Amean     5      76.9840 (   0.00%)     81.1256 (  -5.38%)
Amean     7     107.1258 (   0.00%)    112.5528 *  -5.07%*
Amean     12    178.5502 (   0.00%)    197.8780 * -10.82%*
Amean     16    240.5200 (   0.00%)    270.3840 * -12.42%*

[stream]
No huge regression is observed, which was seen in v3.

512MB:
                         baseline_512        sched_cache_512
                        baseline_512M       sched_cache_512M
GB/sec copy-16       442.53 (   0.00%)      421.83 (  -4.68%)
GB/sec scale-16      387.74 (   0.00%)      377.00 (  -2.77%)
GB/sec add-16        413.29 (   0.00%)      410.84 (  -0.59%)
GB/sec triad-16      411.34 (   0.00%)      407.73 (  -0.88%)

2GB: 
                           baseline_2          sched_cache_2
                          baseline_2G         sched_cache_2G
GB/sec copy-16       309.30 (   0.00%)      315.93 (   2.15%)
GB/sec scale-16      208.16 (   0.00%)      209.99 (   0.88%)
GB/sec add-16        229.94 (   0.00%)      231.51 (   0.68%)
GB/sec triad-16      240.40 (   0.00%)      242.02 (   0.67%)


[netperf]
No much difference is observed.

                          baseline            sched_cache
         nr_pairs          netperf                netperf
Hmean     1      919.00 (   0.00%)      923.82 (   0.52%)
BHmean-99 1      920.38 (   0.00%)      925.34 (   0.54%)
Hmean     2      917.23 (   0.00%)      916.01 (  -0.13%)
BHmean-99 2      918.99 (   0.00%)      918.08 (  -0.10%)
Hmean     4      908.65 (   0.00%)      908.47 (  -0.02%)
BHmean-99 4      910.04 (   0.00%)      909.56 (  -0.05%)
Hmean     8      911.31 (   0.00%)      909.19 (  -0.23%)
BHmean-99 8      911.97 (   0.00%)      910.23 (  -0.19%)
Hmean     16      905.37 (   0.00%)      901.83 (  -0.39%)
BHmean-99 16      905.92 (   0.00%)      902.43 (  -0.39%)
Hmean     32      865.56 (   0.00%)      860.52 (  -0.58%)
BHmean-99 32      866.40 (   0.00%)      863.23 (  -0.37%)
Hmean     64      734.50 (   0.00%)      729.11 (  -0.73%)
BHmean-99 64      737.50 (   0.00%)      732.97 (  -0.61%)
Hmean     128      735.01 (   0.00%)      728.00 (  -0.95%)
BHmean-99 128      738.62 (   0.00%)      731.48 (  -0.97%)
Hmean     256      335.52 (   0.00%)      335.57 (   0.01%)
BHmean-99 256      338.19 (   0.00%)      337.99 (  -0.06%)

[schbench]

No huge regression is observed(consider the std), which
was seen in v3.

Metric                         Base (mean std)      Compare (mean std)   Change    
-------------------------------------------------------------------------------------
schbench thread = 1
Wakeup Latencies 99.0th        14.80(1.10)          15.00(2.74)          -1.35%    
Request Latencies 99.0th       5310.40(18.24)       5342.40(56.11)       -0.60%    
RPS 50.0th                     384.20(3.27)         386.00(5.43)         +0.47%    
Average RPS                    385.94(1.98)         387.37(4.74)         +0.37%    

schbench thread = 2
Wakeup Latencies 99.0th        15.20(0.45)          16.80(1.30)          -10.53%   
Request Latencies 99.0th       5291.20(7.16)        5336.00(27.71)       -0.85%    
RPS 50.0th                     778.60(2.61)         772.20(7.01)         -0.82%    
Average RPS                    778.54(2.42)         773.14(6.19)         -0.69%    

schbench thread = 4
Wakeup Latencies 99.0th        16.60(1.52)          17.60(0.55)          -6.02%    
Request Latencies 99.0th       5233.60(8.76)        7432.00(2946.91)     -42.01%   
RPS 50.0th                     1578.80(1.79)        1570.00(9.38)        -0.56%    
Average RPS                    1576.94(1.88)        1544.12(44.90)       -2.08%    

schbench thread = 8
Wakeup Latencies 99.0th        18.40(0.89)          19.40(0.55)          -5.43%    
Request Latencies 99.0th       5236.80(7.16)        5236.80(7.16)        0.00%     
RPS 50.0th                     3152.80(4.38)        3148.00(0.00)        -0.15%    
Average RPS                    3150.89(2.71)        3145.30(1.21)        -0.18%    

schbench thread = 16
Wakeup Latencies 99.0th        16.80(1.64)          18.40(0.55)          -9.52%    
Request Latencies 99.0th       5224.00(0.00)        5195.20(47.19)       +0.55%    
RPS 50.0th                     6312.00(0.00)        6296.00(0.00)        -0.25%    
Average RPS                    6308.84(3.79)        6293.32(2.61)        -0.25%    

schbench thread = 32
Wakeup Latencies 99.0th        18.80(2.17)          21.00(0.71)          -11.70%   
Request Latencies 99.0th       9716.80(2458.04)     10806.40(35.05)      -11.21%   
RPS 50.0th                     12457.60(79.68)      12483.20(62.38)      +0.21%    
Average RPS                    12300.14(125.37)     12269.54(66.16)      -0.25%    

schbench thread = 63
Wakeup Latencies 99.0th        27.20(0.45)          29.00(0.71)          -6.62%    
Request Latencies 99.0th       11337.60(14.31)      11401.60(14.31)      -0.56%    
RPS 50.0th                     11632.00(0.00)       11600.00(0.00)       -0.28%    
Average RPS                    11628.59(1.85)       11597.09(2.17)       -0.27%    
-------------------------------------------------------------------------------------

This patch set is applied on vanilla v6.16 kernel.
Thanks to Yangyu Chen, K Prateek Nayak, Shrikanth Hegde, Libo Chen,
Jianyong Wu, and Madadi Vineeth Reddy for their testing and valuable
suggestions on v3. Since the code has been modified, Yangyu's Tested-by tag
has not been included in v4.

Comments and tests are much appreciated.

Patch 1:     Peter's original patch.
Patch 2-5:   Various fixes and tuning of the original v1 patch.
Patch 6-12:  Infrastructure and helper functions for load balancing to be cache aware.
Patch 13-18: Add logic to load balancing for preferred LLC aggregation.
Patch 19:    Add process LLC aggregation in load balancing sched feature.
Patch 20:    Add Process LLC aggregation in wake up sched feature (turn off by default).
Patch 21-28: Fix the performance regressions reported in v3, by checking
             the process's working set and number of active threads, finding
             the busiest CPU in the preferred NUMA node.

v1:
https://lore.kernel.org/lkml/20250325120952.GJ36322@noisy.programming.kicks-ass.net/
v2:
https://lore.kernel.org/lkml/cover.1745199017.git.yu.c.chen@intel.com/
v3:
https://lore.kernel.org/all/cover.1750268218.git.tim.c.chen@linux.intel.com/

Chen Yu (11):
  sched: Several fixes for cache aware scheduling
  sched: Avoid task migration within its preferred LLC
  sched: Save the per LLC utilization for better cache aware scheduling
  sched: Introduce a static key to enable cache aware only for multi
    LLCs
  sched: Turn EPOCH_PERIOD and EPOCH_OLD into tunnable debugfs
  sched: Scan a task's preferred node for preferred LLC
  sched: Record average number of runninhg tasks per process
  sched: Skip cache aware scheduling if the process has many active
    threads
  sched: Do not enable cache aware scheduling for process with large RSS
  sched: Allow the user space to tune the scale factor for RSS
    comparison
  sched: Add ftrace to track cache aware load balance and hottest CPU
    changes

K Prateek Nayak (1):
  sched: Avoid calculating the cpumask if the system is overloaded

Peter Zijlstra (1):
  sched: Cache aware load-balancing

Tim Chen (15):
  sched: Add hysteresis to switch a task's preferred LLC
  sched: Add helper function to decide whether to allow cache aware
    scheduling
  sched: Set up LLC indexing
  sched: Introduce task preferred LLC field
  sched: Calculate the number of tasks that have LLC preference on a
    runqueue
  sched: Introduce per runqueue task LLC preference counter
  sched: Calculate the total number of preferred LLC tasks during load
    balance
  sched: Tag the sched group as llc_balance if it has tasks prefer other
    LLC
  sched: Introduce update_llc_busiest() to deal with groups having
    preferred LLC tasks
  sched: Introduce a new migration_type to track the preferred LLC load
    balance
  sched: Consider LLC locality for active balance
  sched: Consider LLC preference when picking tasks from busiest queue
  sched: Do not migrate task if it is moving out of its preferred LLC
  sched: Introduce SCHED_CACHE_LB to control cache aware load balance
  sched: Introduce SCHED_CACHE_WAKE to control LLC aggregation on wake
    up

 include/linux/mm_types.h       |   45 ++
 include/linux/sched.h          |    8 +
 include/linux/sched/topology.h |    3 +
 include/trace/events/sched.h   |   93 +++
 init/Kconfig                   |    8 +
 init/init_task.c               |    3 +
 kernel/fork.c                  |    5 +
 kernel/sched/core.c            |   25 +-
 kernel/sched/debug.c           |   86 +++
 kernel/sched/fair.c            | 1022 +++++++++++++++++++++++++++++++-
 kernel/sched/features.h        |    3 +
 kernel/sched/sched.h           |   27 +
 kernel/sched/topology.c        |   51 +-
 13 files changed, 1348 insertions(+), 31 deletions(-)

-- 
2.25.1


