Return-Path: <linux-kernel+bounces-737665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D55B0AF15
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B8B17CEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA6238C1D;
	Sat, 19 Jul 2025 09:24:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778722DA0B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917063; cv=none; b=mO6cx9m+NsEl6ljzmS4CJub2mAH+IyClwGEMqV/H6KARnppH3lpX3TR69bzx/UkhNRMstrCy/YQWVeUCnkA/RfuSruk/2RLljddxhGBrDhbW523DhCVDRIaylH0deUm7pwLbEJknhI+90aHrt2UG34vgLyAVmDdhqorG6eQlOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917063; c=relaxed/simple;
	bh=xTGarU5eaFWUJ3ayYLDulkTuEmdKQwz739eUXkFFpXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EW2gviZI1ibgSRkSC/GQdbIqZtXiBLElxp8S3CkQVYVDki90C2xP64OmvstbDEy2OgW2zW0oxvIUE8Ae9bTkjcQ2xxmfSyhGNLnRPmeNXotYbYCVwXQEtXfjxNvUqyJxF7OQBkabkj0tB2Na8TVDK3XPEfzZcmFOWcNQpEHsN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bkh4r0p4Wz2RVr7;
	Sat, 19 Jul 2025 17:22:04 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 43A0F1800B2;
	Sat, 19 Jul 2025 17:24:12 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 17:24:12 +0800
Received: from [10.146.82.192] (10.146.82.192) by
 kwepemq100012.china.huawei.com (7.202.195.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 17:24:11 +0800
Message-ID: <e3defe08-85ef-411b-8a61-16686222b751@huawei.com>
Date: Sat, 19 Jul 2025 17:24:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/dl: Fix race in push_dl_task
To: Harshit Agarwal <harshit@nutanix.com>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "raistlin@linux.it" <raistlin@linux.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tanghui20@huawei.com" <tanghui20@huawei.com>, "zhangqiao22@huawei.com"
	<zhangqiao22@huawei.com>, "judy.chenhui@huawei.com" <judy.chenhui@huawei.com>
References: <20250716011516.3591655-1-quzicheng@huawei.com>
 <11E57357-EDAE-4C7A-B292-3BD41BCFA9CF@nutanix.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <11E57357-EDAE-4C7A-B292-3BD41BCFA9CF@nutanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100012.china.huawei.com (7.202.195.195)

Hi Harshit,

Thanks for your reminder.

This patch has been pending for three months, and I really think it is 
worth to work on due to most the groundwork done.

Juri had some small suggestions, so I want to modify a few things: just 
the commit message and some code comments.

I also add your sign-off and the ACK you got, but I will not add my 
sign-off since I suppose it would not be suitable.

Is this ok for you? I will reply to 
'https://lore.kernel.org/lkml/20250408045021.3283624-1-harshit@nutanix.com/' 
once I get your approval or you can send it directly. The patch I 
modified is below for your look:

--------------------patch begin--------------------
 From e61463fda85367fe5f6129bf9f327729b869c622 Mon Sep 17 00:00:00 2001
From: Zicheng Qu <quzicheng@huawei.com>
Date: Sat, 19 Jul 2025 08:15:00 +0000
Subject: [PATCH v3] sched/deadline: Fix race in push_dl_task

When a CPU chooses to call push_dl_task and picks a task to push to
another CPU's runqueue then it will call find_lock_later_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.
Please go through the original rt change for more details on the issue.

To fix this, after the lock is obtained inside the find_lock_later_rq,
it ensures that the task is still at the head of pushable tasks list.
Also removed some checks that are no longer needed with the addition of
this new check.
However, the new check of pushable tasks list only applies when
find_lock_later_rq is called by push_dl_task. For the other caller i.e.
dl_task_offline_migration, existing checks are used.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Improved commit message and removed reference to the rt change.
- Accept the comment regarding checks in find_lock_later_rq.

Changes in v2:
- Moved the check inside find_lock_later_rq.
- distinguish among the push_dl_task caller vs dl_task_offline_migration
   by checking if the task is throttled or not.
- Fixed the commit message to refer to rt change by title.
---
Previous discussion link:
https://lore.kernel.org/lkml/20250307204255.60640-1-harshit@nutanix.com/
https://lore.kernel.org/stable/20250317022325.52791-1-harshit@nutanix.com/
---
  kernel/sched/deadline.c | 73 +++++++++++++++++++++++++++--------------
  1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a140826..fb45449b13a1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2619,6 +2619,25 @@ static int find_later_rq(struct task_struct *task)
      return -1;
  }

+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+    struct task_struct *p;
+
+    if (!has_pushable_dl_tasks(rq))
+        return NULL;
+
+    p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+    WARN_ON_ONCE(rq->cpu != task_cpu(p));
+    WARN_ON_ONCE(task_current(rq, p));
+    WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+    WARN_ON_ONCE(!task_on_rq_queued(p));
+    WARN_ON_ONCE(!dl_task(p));
+
+    return p;
+}
+
  /* Locks the rq it finds */
  static struct rq *find_lock_later_rq(struct task_struct *task, struct 
rq *rq)
  {
@@ -2646,12 +2665,37 @@ static struct rq *find_lock_later_rq(struct 
task_struct *task, struct rq *rq)

          /* Retry if something changed. */
          if (double_lock_balance(rq, later_rq)) {
-            if (unlikely(task_rq(task) != rq ||
+            /*
+             * double_lock_balance might have released rq->lock.
+             * In meantime, the task may no longer be migratable.
+             * Check the following to ensure that the task is
+             * still suitable for migration:
+             * 1. It is possible the task was scheduled,
+             *    migrate_disabled was set and then got preempted,
+             *    so we must check the task migration disable
+             *    flag.
+             * 2. The CPU picked is in the task's affinity.
+             * 3. For throttled task (dl_task_offline_migration),
+             *    check the following:
+             *    a) the task is not on the rq anymore (it was
+             *      migrated)
+             *    b) the task is not on CPU anymore
+             *    c) the task is still a dl task
+             *    d) the task is not queued on the rq anymore
+             * 4. For the non-throttled task (push_dl_task), the
+             *    check to ensure that this task is still at the
+             *    head of the pushable tasks list is enough.
+             */
+            if (unlikely(is_migration_disabled(task) ||
                       !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-                     task_on_cpu(rq, task) ||
-                     !dl_task(task) ||
-                     is_migration_disabled(task) ||
-                     !task_on_rq_queued(task))) {
+                     (task->dl.dl_throttled &&
+                      (task_rq(task) != rq ||
+                       task_on_cpu(rq, task) ||
+                       !dl_task(task) ||
+                       !task_on_rq_queued(task))) ||
+                     (!task->dl.dl_throttled &&
+                      task != pick_next_pushable_dl_task(rq)))) {
+
                  double_unlock_balance(rq, later_rq);
                  later_rq = NULL;
                  break;
@@ -2674,25 +2718,6 @@ static struct rq *find_lock_later_rq(struct 
task_struct *task, struct rq *rq)
      return later_rq;
  }

-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-    struct task_struct *p;
-
-    if (!has_pushable_dl_tasks(rq))
-        return NULL;
-
-    p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-    WARN_ON_ONCE(rq->cpu != task_cpu(p));
-    WARN_ON_ONCE(task_current(rq, p));
-    WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-    WARN_ON_ONCE(!task_on_rq_queued(p));
-    WARN_ON_ONCE(!dl_task(p));
-
-    return p;
-}
-
  /*
   * See if the non running -deadline tasks on this rq
   * can be sent to some other CPU where they can preempt
-- 
2.34.1
--------------------patch end--------------------

Regards,
Zicheng


On 7/16/2025 10:47 AM, Harshit Agarwal wrote:
> Hi Zicheng,
>
> Thanks for this change.
> I already have the dl version of this patch reviewed by Juri.
> Not merged yet. You can find it here:
> https://lore.kernel.org/lkml/20250408045021.3283624-1-harshit@nutanix.com/
>
> Regards,
> Harshit
>
>> On Jul 15, 2025, at 6:15 PM, Zicheng Qu <quzicheng@huawei.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>   CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> push_dl_task() pick the first pushable task and find an eligible
>> lowest_rq, then double_lock_balance(rq, lowest_rq), so if
>> double_lock_balance() unlock the rq (when double_lock_balance() return
>> 1), we have to check if this task is still on the rq. We cannot rely on
>> these checks of this task to make sure it is still on the original rq,
>> even though we hold the rq->lock. This patch will repick the first
>> pushable task to be sure the task is still on the rq.
>>
>> This is very similar to the issue report in CVE-2025-38234, one is rt
>> and one is ddl. The patch for the rt bugfix is
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_20250225180553.167995-2D1-2Dharshit-40nutanix.com&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=QTPVhNgH716-zU_kPmte39o3vGFVupnGmmfiVBpq9PU&m=l-FlO7f0a0O4xMcW2cS-2txhwNCjsjmXNKh7uUiL3mugOfQ73eYCxijD81W2lPqd&s=yeTV_SZthzrBsGuZCPT9A_Ans4Ze6VVhWnk6IngUtg0&e=
>>
>> Fixes: 1baca4ce16b8 ("sched/deadline: Add SCHED_DEADLINE SMP-related data structures & logic")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
>> ---
>> kernel/sched/deadline.c | 53 ++++++++++++++++++++++-------------------
>> 1 file changed, 28 insertions(+), 25 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 89019a140826..3b53e71f2b86 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2619,6 +2619,25 @@ static int find_later_rq(struct task_struct *task)
>> return -1;
>> }
>>
>> +static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
>> +{
>> + struct task_struct *p;
>> +
>> + if (!has_pushable_dl_tasks(rq))
>> + return NULL;
>> +
>> + p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
>> +
>> + WARN_ON_ONCE(rq->cpu != task_cpu(p));
>> + WARN_ON_ONCE(task_current(rq, p));
>> + WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
>> +
>> + WARN_ON_ONCE(!task_on_rq_queued(p));
>> + WARN_ON_ONCE(!dl_task(p));
>> +
>> + return p;
>> +}
>> +
>> /* Locks the rq it finds */
>> static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>> {
>> @@ -2646,12 +2665,15 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>>
>> /* Retry if something changed. */
>> if (double_lock_balance(rq, later_rq)) {
>> - if (unlikely(task_rq(task) != rq ||
>> -     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
>> -     task_on_cpu(rq, task) ||
>> -     !dl_task(task) ||
>> -     is_migration_disabled(task) ||
>> -     !task_on_rq_queued(task))) {
>> + /*
>> + * We had to unlock the run queue. In
>> + * the mean time, task could have
>> + * migrated already or had its affinity changed.
>> + * Also make sure that it wasn't scheduled on its rq.
>> + */
>> + if (unlikely(is_migration_disabled(task) ||
>> + !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
>> + task != pick_next_pushable_dl_task(rq))) {
>> double_unlock_balance(rq, later_rq);
>> later_rq = NULL;
>> break;
>> @@ -2674,25 +2696,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>> return later_rq;
>> }
>>
>> -static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
>> -{
>> - struct task_struct *p;
>> -
>> - if (!has_pushable_dl_tasks(rq))
>> - return NULL;
>> -
>> - p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
>> -
>> - WARN_ON_ONCE(rq->cpu != task_cpu(p));
>> - WARN_ON_ONCE(task_current(rq, p));
>> - WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
>> -
>> - WARN_ON_ONCE(!task_on_rq_queued(p));
>> - WARN_ON_ONCE(!dl_task(p));
>> -
>> - return p;
>> -}
>> -
>> /*
>>   * See if the non running -deadline tasks on this rq
>>   * can be sent to some other CPU where they can preempt
>> -- 
>> 2.34.1
>>

