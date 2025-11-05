Return-Path: <linux-kernel+bounces-886298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45CC3530A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 385EF34E047
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122C3090DC;
	Wed,  5 Nov 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Brlep/YT"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAA306B02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339640; cv=none; b=Z9ERgx9D0KmePmM/IDnsf4oxLzUGNABFxKSTajDtKPj3a2ikCDJMcyyK0WcR4VEDsXuepjc0HWtSRR7BDx4CqgYLm71QMtFqcMbU7lrvVKiyu+W6vYDVu6ZNz7AZFVnQyBGlkfnsIGPHnoQqnLg+tFFFKGPvNfAuKFC7UkvRCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339640; c=relaxed/simple;
	bh=HWDrc7B3s/679z0t+5WTv7hWZnudEP3v8VpEnAELeKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UwuXiymqJqUwEjhFVLP+BIcApHHD7zVSSc9yDubsD6Qkf2w4tIDDcMVLBouR0WKks3jYaH+zXL6ywtYEl0DqbGLCk8bmHVRuBjT/8d4yuj9dkoSyJ1OphPxBuyzOJglR3/a8qJAUl9QlcKnOWD2EeAPrieQdUVycMBxAYKLNTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Brlep/YT; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0MkUidTDQrcT4NR28ZpvDHGBcJ3d7TPB+iXE+zkYLzc=;
	b=Brlep/YTSPNF6VbVtOyFpkI32++B6oDbhj8O6RpUrjQPQAwqlOoZKKVxE/YX1v2ibmhlkLS2O
	YpwR7UrAI06rj12Cj/wu4auPDqxX/QoQ8tZNaP+gRIDGgJAc/IBQ6Pqi9/qiwCtDkFieyXnvLr6
	gWCgD0HmPLdGa+Gc8Fh+Uao=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d1hmy26ZnzcZyG;
	Wed,  5 Nov 2025 18:45:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E6D1180B63;
	Wed,  5 Nov 2025 18:47:15 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 18:47:14 +0800
Received: from [10.67.111.196] (10.67.111.196) by
 kwepemq100012.china.huawei.com (7.202.195.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 18:47:13 +0800
Message-ID: <7cdcc98e-990e-4408-ba75-57dd0229316e@huawei.com>
Date: Wed, 5 Nov 2025 18:47:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH EEVDF NULL deref] sched/eevdf: Fix NULL deref when
 avg_vruntime nears overflow
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wulibin163@126.com>, <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
References: <20251103130441.1013188-1-quzicheng@huawei.com>
 <20251103202611.GE3245006@noisy.programming.kicks-ass.net>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20251103202611.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100012.china.huawei.com (7.202.195.195)

 From 70bd6ca00976ab8ff42133f8189bc0a9ca77f62e Mon Sep 17 00:00:00 2001
From: Zicheng Qu <quzicheng@huawei.com>
Date: Tue, 4 Nov 2025 02:05:33 +0000
Subject: [PATCH for EEVDF NULL POINTER reproduction] EEVDF null pointer
  reproduction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

 > Right, so the problem is that min_vruntime doesn't follow (it only wants
 > to go up). I should have a patch for that, let me go find.
 >
 > /me rummages in the patch drawer for a bit...
 >
 > Also, do you have a reproducer for this? Your crash output says it is
 > running something called 'sched_test_2'.

This is the reproduction patch. We encountered a similar issue on a
normally running kernel, and after analysis, we deliberately constructed
a comparable scenario. Since it is difficult to control the conditions
from user space, we proactively modified certain parts of the kernel
code to simulate the issue (the code includes detailed explanations).

For the detailed reproduction case, please refer to the path
null_reproduction_test. First, run ./make.sh, and then execute ./test.sh
to start the test. We have tried different machines but have not yet
identified the root cause — on some machines, the issue cannot be
reproduced, while on others it may occur within a few hours.

We need cfs_rq->avg_vruntime to drop near to the lower limit of s64
before the issue can potentially be reproduced. If other sched_entity
instances appear on the same cfs_rq, keeping its avg_vruntime stabilized
around a certain value, then it becomes difficult for the problem to
occur.

 > The below should work (unless you have CONFIG_SCHED_CORE=y), could you
 > please try? If it does work, I suppose I'll finally have to sit down
 > and work out the SCHED_CORE side of this.
 >
 > (Note the changelog doesn't talk about your problem, it was from a
 > previous issue and I just haven't bothered fixing it up)

As for the zero_vruntime patch, after applying it, we have not
observed any crashes over than 24 hours.

Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: wulibin163 <wulibin163@126.com>
---
  kernel/sched/fair.c                 | 106 ++++++++++++++++++++-
  kernel/sched/sched.h                |   3 +
  null_reproduction_test/Makefile     |   9 ++
  null_reproduction_test/fullcpu.c    |  12 +++
  null_reproduction_test/make.sh      |  17 ++++
  null_reproduction_test/test.sh      |  32 +++++++
  null_reproduction_test/test_sched.c | 141 ++++++++++++++++++++++++++++
  7 files changed, 319 insertions(+), 1 deletion(-)
  create mode 100644 null_reproduction_test/Makefile
  create mode 100644 null_reproduction_test/fullcpu.c
  create mode 100755 null_reproduction_test/make.sh
  create mode 100755 null_reproduction_test/test.sh
  create mode 100644 null_reproduction_test/test_sched.c

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..4e9fdfc732b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -58,6 +58,17 @@
  #include "stats.h"
  #include "autogroup.h"

+static int se_schedule_pid = 0; // the pid of task `test_sched_0` 
started in test_sched.c.
+module_param(se_schedule_pid, int, 0644);
+static int qzc_vlag_switch = 0; // switch to control the vlag for 
test_sched_0 in place_entity()
+module_param(qzc_vlag_switch, int, 0644);
+static int qzc_fixed_switch = 0; // switch to control whether to apply 
the old fix patch, not zero_vruntime patch
+module_param(qzc_fixed_switch, int, 0644);
+#define __FILENAME__ (__builtin_strrchr(__FILE__, '/') ? 
__builtin_strrchr(__FILE__, '/') + 1 : __FILE__)
+#define ENQUEUE_ENTITY_NONE 0
+#define ENQUEUE_ENTITY_BEGIN 1
+#define ENQUEUE_ENTITY_END 2
+
  /*
   * The initial- and re-scaling of tunables is configurable
   *
@@ -702,6 +713,16 @@ static void update_entity_lag(struct cfs_rq 
*cfs_rq, struct sched_entity *se)
      se->vlag = clamp(vlag, -limit, limit);
  }

+static s64 entity_lag(u64 avruntime, struct sched_entity *se)
+{
+    s64 vlag, limit;
+
+    vlag = avruntime - se->vruntime;
+    limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+
+    return clamp(vlag, -limit, limit);
+}
+
  /*
   * Entity is eligible once it received less service than it ought to have,
   * eg. lag >= 0.
@@ -3945,7 +3966,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
   * Recomputes the group entity based on the current state of its group
   * runqueue.
   */
-static void update_cfs_group(struct sched_entity *se)
+static void __update_cfs_group(struct sched_entity *se, int flag)
  {
      struct cfs_rq *gcfs_rq = group_cfs_rq(se);
      long shares;
@@ -3958,10 +3979,21 @@ static void update_cfs_group(struct sched_entity 
*se)
          return;

      shares = calc_group_shares(gcfs_rq);
+
+    if (flag == ENQUEUE_ENTITY_BEGIN)  // enqueue begin
+        shares = 111616;
+    else if (flag == ENQUEUE_ENTITY_END) // enqueue end
+        shares = 395264;
+
      if (unlikely(se->load.weight != shares))
          reweight_entity(cfs_rq_of(se), se, shares);
  }

+static void update_cfs_group(struct sched_entity *se)
+{
+       __update_cfs_group(se, ENQUEUE_ENTITY_NONE);
+}
+
  #else /* !CONFIG_FAIR_GROUP_SCHED: */
  static inline void update_cfs_group(struct sched_entity *se)
  {
@@ -5143,6 +5175,16 @@ place_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *se, int flags)
          struct sched_entity *curr = cfs_rq->curr;
          unsigned long load;

+        /*
+         * To make the avg_vruntime() and cfs_rq->avg_vruntime lower 
and lower:
+         * The original goal is to migrate a large number (countless) 
of test_sched_0 type tasks
+         * with very positive high vlag one by one to a specific cfs_rq.
+         * However, it is difficult to control from user space,
+         * so we directly simulate it here to achieve this.
+         */
+        if (qzc_vlag_switch != 0 && se_schedule_pid > 0 && 
entity_is_task(se) && (task_of(se)->pid == se_schedule_pid))
+             se->vlag = qzc_vlag_switch == 1 ? 
calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se) : qzc_vlag_switch;
+
          lag = se->vlag;

          /*
@@ -5240,6 +5282,19 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *se, int flags)
  {
      bool curr = cfs_rq->curr == se;

+    /*
+     * At the very beginning and end of the enqueue process for task 
`test_sched_0`,
+     * we want to adjust the weight/shares of cfs_rq->curr simultaneously,
+     * which is actually the task `fullcpu` from test.sh in most cases.
+     *
+     * However, it is quite challenging to control from user space,
+     * so we intend to simulate this behavior here instead.
+     */
+    if (se_schedule_pid > 0 && entity_is_task(se) && (task_of(se)->pid 
== se_schedule_pid)) {
+         if (cfs_rq->curr)
+            __update_cfs_group(cfs_rq->curr, ENQUEUE_ENTITY_BEGIN);
+    }
+
      /*
       * If we're the current task, we must renormalise before calling
       * update_curr().
@@ -5299,6 +5354,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *se, int flags)
          }
  #endif
      }
+
+    if (se_schedule_pid > 0 && entity_is_task(se) && (task_of(se)->pid 
== se_schedule_pid)) {
+        if (cfs_rq->curr)
+            __update_cfs_group(cfs_rq->curr, ENQUEUE_ENTITY_END);
+    }
  }

  static void __clear_buddies_next(struct sched_entity *se)
@@ -13323,6 +13383,17 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
  {
      cfs_rq->tasks_timeline = RB_ROOT_CACHED;
      cfs_rq->min_vruntime = (u64)(-(1LL << 20));
+
+    /*
+     * We suppose the original intention of (u64)(-(1LL << 20)) was 
likely to
+     * force cfs_rq->min_vruntime to overflow as quickly as possible,
+     * thereby exposing related overflow issues early during the kernel 
initial phase.
+     *
+     * To accelerate the reproduction of these issues,
+     * we have temporarily modified the initial value of 
cfs_rq->min_vruntime.
+     */
+    cfs_rq->min_vruntime = (u64)(4596393947272479);
+
      raw_spin_lock_init(&cfs_rq->removed.lock);
  }

@@ -13728,3 +13799,36 @@ __init void init_sched_fair_class(void)
      zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
  #endif
  }
+
+u64 sched_debug_min_vruntime(struct cfs_rq *cfs_rq)
+{
+    return cfs_rq->min_vruntime;
+}
+EXPORT_SYMBOL(sched_debug_min_vruntime);
+
+void sched_debug_cfs_rq_info(struct cfs_rq *cfs_rq)
+{
+    u64 qzc_avruntime = avg_vruntime(cfs_rq);
+
+    printk("%s:%s:%d, 
cfs_rq=[%p]\tcfs_rq->nr_queued=[%d]\tcfs_rq->avg_vruntime=[%lld]\tcfs_rq->min_vruntime=[%llu]\tcfs_rq->avg_load=[%llu]\tavg_vruntime(cfs_rq)=[%llu]\n", 

+        __FILENAME__,__FUNCTION__, __LINE__,
+        cfs_rq, cfs_rq->nr_queued, cfs_rq->avg_vruntime, 
cfs_rq->min_vruntime, cfs_rq->avg_load, qzc_avruntime);
+
+    if (cfs_rq->curr) {
+        printk("%s:%s:%d, 
curr=[%p]\tpid=[%d]\ttgid=[%d]\tcurr->vruntime=[%llu]\tcurr->load.weight=[%lu]\tcurr->vlag=[%lld]\tcurr->slice=[%llu]\tcurr->deadline=[%llu]\tcurr->my_q=[%p]\treal_vlag=[%lld]\tvruntime_eligible=[%d]\n", 

+            __FILENAME__,__FUNCTION__, __LINE__,
+            cfs_rq->curr, entity_is_task(cfs_rq->curr) ? 
task_of(cfs_rq->curr)->pid : -1, entity_is_task(cfs_rq->curr) ? 
task_of(cfs_rq->curr)->tgid : -1,
+            cfs_rq->curr->vruntime, cfs_rq->curr->load.weight, 
cfs_rq->curr->vlag, cfs_rq->curr->slice, cfs_rq->curr->deadline, 
cfs_rq->curr->my_q, entity_lag(qzc_avruntime, cfs_rq->curr), 
vruntime_eligible(cfs_rq, cfs_rq->curr->vruntime));
+    }
+
+    struct rb_node *node = rb_first_cached(&cfs_rq->tasks_timeline);
+
+    for (; node; node = rb_next(node)) {
+        struct sched_entity *rb_se = __node_2_se(node);
+        printk("%s:%s:%d, 
rb_se=[%p]\tpid=[%d]\ttgid=[%d]\trb_se->vruntime=[%llu]\trb_se->load.weight=[%lu]\trb_se->vlag=[%lld]\trb_se->slice=[%llu]\trb_se->deadline=[%llu]\trb_se->my_q=[%p]\treal_vlag=[%lld]\tvruntime_eligible=[%d]\n", 

+            __FILENAME__,__FUNCTION__, __LINE__,
+            rb_se, entity_is_task(rb_se) ? task_of(rb_se)->pid : -1, 
entity_is_task(rb_se) ? task_of(rb_se)->tgid : -1,
+            rb_se->vruntime, rb_se->load.weight, rb_se->vlag, 
rb_se->slice, rb_se->deadline, rb_se->my_q, entity_lag(qzc_avruntime, 
rb_se), vruntime_eligible(cfs_rq, rb_se->vruntime));
+    }
+}
+EXPORT_SYMBOL(sched_debug_cfs_rq_info);
\ No newline at end of file
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index adfb6e3409d7..50342e003b27 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3904,4 +3904,7 @@ void sched_enq_and_set_task(struct 
sched_enq_and_set_ctx *ctx);

  #include "ext.h"

+extern u64 sched_debug_min_vruntime(struct cfs_rq *cfs_rq);
+extern void sched_debug_cfs_rq_info(struct cfs_rq *cfs_rq);
+
  #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/null_reproduction_test/Makefile 
b/null_reproduction_test/Makefile
new file mode 100644
index 000000000000..48feb459e5ff
--- /dev/null
+++ b/null_reproduction_test/Makefile
@@ -0,0 +1,9 @@
+obj-m += test_sched.o
+KDIR := /lib/modules/$(shell uname -r)/build
+PWD := $(shell pwd)
+
+all:
+    $(MAKE) -C $(KDIR) M=$(PWD) modules
+
+clean:
+    $(MAKE) -C $(KDIR) M=$(PWD) clean
\ No newline at end of file
diff --git a/null_reproduction_test/fullcpu.c 
b/null_reproduction_test/fullcpu.c
new file mode 100644
index 000000000000..136c73671035
--- /dev/null
+++ b/null_reproduction_test/fullcpu.c
@@ -0,0 +1,12 @@
+#include <string.h>
+#include <unistd.h>
+
+int main()
+{
+    int a=9;
+    while(1) {
+            a*=9;
+    }
+
+    return 0;
+}
\ No newline at end of file
diff --git a/null_reproduction_test/make.sh b/null_reproduction_test/make.sh
new file mode 100755
index 000000000000..002385d17046
--- /dev/null
+++ b/null_reproduction_test/make.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+make clean
+
+cd ..
+
+make modules_prepare
+
+cd ./null_reproduction_test
+
+make -C ../ M=$(pwd)
+
+gcc fullcpu.c -o fullcpu
+
+echo "===================="
+echo 'please run test.sh'
+echo "===================="
\ No newline at end of file
diff --git a/null_reproduction_test/test.sh b/null_reproduction_test/test.sh
new file mode 100755
index 000000000000..d36de68c683b
--- /dev/null
+++ b/null_reproduction_test/test.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+
+test() {
+    cpu=$1
+    cgroup=test0
+
+    mkdir /sys/fs/cgroup/cpu/$cgroup/
+    mkdir /sys/fs/cgroup/memory/$cgroup/
+    echo 10000000 > /sys/fs/cgroup/memory/$cgroup/memory.limit_in_bytes
+
+    taskset -c $cpu ./fullcpu &
+    pid=$!
+
+    echo $pid > /sys/fs/cgroup/cpu/$cgroup/tasks
+    echo $pid > /sys/fs/cgroup/memory/$cgroup/tasks
+
+    let cpu1_count=0
+    for pid in $(ps -auxf | grep test_sched  | grep -v grep | grep -v 
test_sched_0 | grep -v test_sched_1 | awk '{print($2)}'); do
+            echo $pid > /sys/fs/cgroup/cpu/$cgroup/tasks
+    done
+}
+
+killall fullcpu
+rmmod test_sched
+insmod ./test_sched.ko bind_cpu=1 test_count=15
+
+pid0=$(ps -auxf | grep  'test_sched_0' | grep -v grep | awk '{print($2)}')
+echo $pid0 > /sys/module/fair/parameters/se_schedule_pid
+
+echo 1 > /sys/module/fair/parameters/qzc_vlag_switch
+
+test 1
diff --git a/null_reproduction_test/test_sched.c 
b/null_reproduction_test/test_sched.c
new file mode 100644
index 000000000000..7a33fa77c923
--- /dev/null
+++ b/null_reproduction_test/test_sched.c
@@ -0,0 +1,141 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+
+static DECLARE_COMPLETION(comp);
+
+#define THREAD_NUM 100000
+static struct task_struct *schedule_threads[THREAD_NUM];
+static int bind_cpu = 0;
+module_param(bind_cpu, int, 0644);
+MODULE_PARM_DESC(bind_cpu, "CPU core to bind the thread to");
+
+static int test_count = 1;
+module_param(test_count, int, 0644);
+MODULE_PARM_DESC(test_count, "test thread count (default: 1)");
+
+static int sched_debug_cfs_rq_info_print_cnt = 0;
+
+static int thread_function(void *data);
+static void start_one_thread(int id, int cpu);
+
+static int __init schedule_driver_init(void)
+{
+    printk(KERN_INFO "Schedule driver: Initializing\n");
+
+    start_one_thread(0, bind_cpu);
+    start_one_thread(1, bind_cpu);
+    for (int i=2; i<test_count; i++)
+        start_one_thread(i, -1);
+
+    return 0;
+}
+
+struct thread_data {
+    int id;
+};
+
+static void start_one_thread(int id, int cpu)
+{
+    char name[255];
+    sprintf(name, "test_sched_%u/%d", id, cpu);
+
+    struct thread_data  *tdata = kmalloc(sizeof(struct thread_data), 
GFP_KERNEL);
+    tdata->id = id;
+
+    // create kthread but not run immediately
+    schedule_threads[id] = kthread_create(thread_function, tdata, name);
+    if (IS_ERR(schedule_threads[id])) {
+        schedule_threads[id] = 0;
+        printk("Failed to create %s, %ld\n", name, 
PTR_ERR(schedule_threads[id]));
+        return;
+    }
+
+    if (cpu > 0)
+        kthread_bind(schedule_threads[id], cpu);
+    // run the kthread
+    wake_up_process(schedule_threads[id]);
+
+    printk(KERN_INFO "create %s success\n", name);
+    return;
+}
+
+u64 sched_debug_min_vruntime(struct cfs_rq *cfs);
+void sched_debug_cfs_rq_info(struct cfs_rq *cfs_rq);
+
+static int thread_function(void *data)
+{
+    printk(KERN_INFO "Schedule thread: Started on CPU %d\n", 
smp_processor_id());
+    struct task_struct *task = current;
+
+    set_current_state(TASK_RUNNING);
+
+    struct thread_data  *tdata = data;
+    // test_sched_1 wait
+    if (tdata->id == 1) {
+        set_user_nice(task, 8);
+        wait_for_completion_interruptible(&comp);
+    }
+
+    while (!kthread_should_stop()) {
+        // test_sched_0 check the condition
+        if (tdata->id == 0) {
+            struct sched_entity *se = &task->se;
+            struct cfs_rq *cfs = se->cfs_rq;
+            u64 vruntime = se->vruntime;
+            u64 min_vruntime = sched_debug_min_vruntime(cfs);
+
+            if (sched_debug_cfs_rq_info_print_cnt % 10000 == 0) {
+                sched_debug_cfs_rq_info(cfs);
+            }
+            sched_debug_cfs_rq_info_print_cnt += 1;
+
+            if (-102743846405689 > (s64)(vruntime - min_vruntime)) {
+                int old_nice = task_nice(task);
+                set_user_nice(task, -20);
+
+                complete(&comp); // wake up test_sched_1
+                printk("vruntime: %llu, min_vruntime: %llu, renice: 
%d->%d\n",
+                    vruntime, min_vruntime, old_nice, -20);
+            }
+        } else if (tdata->id == 1) {
+            int a = 1;
+            for (int i=0; i<1000000; i++) {
+                a += tdata->id;
+            }
+        }
+
+        if (tdata->id == 1)
+            cond_resched();
+        else {
+            schedule_timeout_uninterruptible(1);
+        }
+    }
+
+    printk(KERN_INFO "Schedule thread: Exiting from CPU %d\n", 
smp_processor_id());
+    return 0;
+}
+
+static void __exit schedule_driver_exit(void)
+{
+    for (int i=0; i<test_count; i++) {
+        if (schedule_threads[i]) {
+            kthread_stop(schedule_threads[i]);
+            printk(KERN_INFO "Schedule driver: Thread stopped\n");
+        }
+    }
+}
+
+module_init(schedule_driver_init);
+module_exit(schedule_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Your Name");
+MODULE_DESCRIPTION("A driver that creates a thread calling schedule() 
in a loop with CPU binding");
+MODULE_VERSION("1.0");
-- 
2.34.1



