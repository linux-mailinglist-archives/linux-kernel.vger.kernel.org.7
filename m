Return-Path: <linux-kernel+bounces-882970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A439AC2C0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D65189575E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4925228D;
	Mon,  3 Nov 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0K65pVEg"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C023AE66
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176210; cv=none; b=PBMa/D7Fxiyes3QSAxmUPGP+l/mrunz6kwG5OjN7N+aZLTo1xS0KyvW3OkgO1Zg8g+r5lARlTKPh7EhsDp7Mw9n9brhCG0m19sdMPb149PQXKdZrehmoqZF8tnuMn/HbAsarWmBFsPFJmIgg9p/U3650MmbKuNgCf77EEeXEo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176210; c=relaxed/simple;
	bh=K69XJLznQDLrKLMaWKRt93LCeIY6uhwyk3mh++aGRRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SOAk4K451HJpGaJbZYLUJhYi37bmuyy7FHhv0buU0nbIpyAAAitHtxDEtUfsuzlguoAou9VkPCRzHB8UF/4W3RHyddlHcyX60lVzq3TuBBMUKB+a6/It7IsUVuH2oVrNzMNh4HZt6PbeItjQyLHQmb8JDXs2Kne3ogNVD7h3uXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0K65pVEg; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W212tq6sHp+Og5I2Qhy+B7FVHCdo4k/19I8DNvF1EbY=;
	b=0K65pVEguvfDD/dsrvzRguQrq/0P4dgUxsQV1otaynANykj7WoALYcJF2Fi1JmFsMFyRwud8h
	MRJNr4xo4vo2dOMynxP7yc0eYRXiiROywfsSVy+Rf4eSiPpjSKc40KQc9PewAYe3NNyEii4X6cn
	QEQVznysXhrWLTS0YsuIl5M=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d0XL609VKz1prLp;
	Mon,  3 Nov 2025 21:21:50 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B2D6D140279;
	Mon,  3 Nov 2025 21:23:24 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 21:23:24 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 21:23:23 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <wulibin163@126.com>, <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH EEVDF NULL deref] sched/eevdf: Fix NULL deref when avg_vruntime nears overflow
Date: Mon, 3 Nov 2025 13:04:41 +0000
Message-ID: <20251103130441.1013188-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100012.china.huawei.com (7.202.195.195)

Fix a kernel NULL pointer dereference in pick_next_task_fair() caused by
EEVDF scheduler arithmetic overflows when cfs_rq->avg_vruntime
approaches the s64 low.

The issue occurs when:
1. cfs_rq->avg_vruntime is driven downward by dynamic reweight
   operations on se->vruntime combined with frequent enqueue/dequeue of
another sched_entity with large se->vlag values. Note that the presence
of only one other sched_entity (besides the current one) is critical
because having more would average out the effect and prevent the
continuous and rapid decrease of cfs_rq->avg_vruntime.
2. These factors `reweight` and `frequent enqueue/dequeue` persistently
   suppress cfs_rq->min_vruntime, causing cfs_rq->avg_vruntime to
decrease rapidly toward S64_MIN.
3. In vruntime_eligible(), the calculation (int64_t)(vruntime -
   cfs_rq->min_vruntime) * load may overflow downward, becoming a large
positive value.
4. This causes vruntime_eligible() to incorrectly judge all tasks as
   ineligible, leading to NULL pointer dereference in
pick_next_task_fair().

The fix addresses this by adjusting the current sched_entity's vruntime
during reweight operations when:
- The entity is cfs_rq->curr and the only running task
- The entity is on the runqueue
- Its vruntime is below min_vruntime

The most straightforward fix would be to adjust the vruntime during
dequeue, but that would require checking and possibly modifying the
curr's vruntime on every dequeue, which has a broader impact and
concurrency concerns. Therefore, we choose to apply the fix in the
reweight path, which is one of the necessary conditions for the problem
to occur.

BUG: kernel NULL pointer dereference, address: 00000000000000a0
RIP: 0010:pick_next_task_fair+0x39b/0xab03

KERNEL: vmlinux  [TAINTED]
DUMPFILE: 127.0.0.1-2025-10-30-13:52:24/vmcore  [PARTIAL DUMP]
CPUS: 4
DATE: Thu Oct 30 05:52:18 UTC 2025
UPTIME: 02:02:50
LOAD AVERAGE: 15.00, 15.00, 15.00
TASKS: 151
NODENAME: SangforOS.localdomain
RELEASE: 6.6.0+
VERSION: #4 SMP Thu Oct 30 11:25:11 CST 2025
MACHINE: x86_64  (2194 Mhz)
MEMORY: 4 GB
PANIC: "Oops: 0000 [#1] SMP PTI" (check log for details)
 PID: 4702
COMMAND: "test_sched_2/-1"
TASK: ffff8881362dcf80  [THREAD_INFO: ffff8881362dcf80]
 CPU: 1
STATE: TASK_UNINTERRUPTIBLE (PANIC)

crash> bt
PID: 4702   TASK: ffff8881362dcf80  CPU: 1   COMMAND: "test_sched_2/-1"
 #0 [ffffc90000fffab0] machine_kexec at ffffffffb567e767
 #1 [ffffc90000fffb10] __crash_kexec at ffffffffb580474a
 #2 [ffffc90000fffbd0] crash_kexec at ffffffffb5805768
 #3 [ffffc90000fffbd8] oops_end at ffffffffb5639599
 #4 [ffffc90000fffbf8] page_fault_oops at ffffffffb56954a8
 #5 [ffffc90000fffc50] exc_page_fault at ffffffffb63424a9
 #6 [ffffc90000fffcb0] asm_exc_page_fault at ffffffffb6400c12
    [exception RIP: pick_next_task_fair+923]
    RIP: ffffffffb576f22b  RSP: ffffc90000fffd60  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ffff8881340b4d80  RCX: 82a3cdbe7f1c7aed
    RDX: 01721730951583fc  RSI: 0000000000015f5f  RDI: 00105468401dc9e3
    RBP: ffffc90000fffe18   R8: 00000000000003fa   R9: 0000000000000002
    R10: 0000000000000002  R11: 0000000000000064  R12: ffff8881362dcf80
    R13: ffffc90000fffdc0  R14: ffff8881340b4e00  R15: ffff8881340b4e00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
 #7 [ffffc90000fffdb0] __schedule at ffffffffb6348cc8
 #8 [ffffc90000fffe20] schedule at ffffffffb63493ab
 #9 [ffffc90000fffe38] schedule_timeout at ffffffffb634eeaf
crash>
crash>
crash> p runqueues
PER-CPU DATA TYPE:
  struct rq runqueues;
PER-CPU ADDRESSES:
  [0]: ffff888134034d80
  [1]: ffff8881340b4d80
  [2]: ffff888134134d80
  [3]: ffff8881341b4d80
crash>
crash> struct -o rq.cfs ffff8881340b4d80
struct rq {
  [ffff8881340b4e00] struct cfs_rq cfs;
}
crash> struct cfs_rq.nr_running,curr,next,tasks_timeline,min_vruntime,avg_vruntime,avg_load,load,exec_clock ffff8881340b4e00
  nr_running = 3,
  curr = 0xffff888139b57c00,
  next = 0xffff888139b57c00,
  tasks_timeline = {
    rb_root = {
      rb_node = 0xffff8881362d80d0
    },
    rb_leftmost = 0xffff8881362d9b50
  },
  min_vruntime = 4596406356396515,
  avg_vruntime = -9137321448325056783,
  avg_load = 88933,
  load = {
    weight = 92109859,
    inv_weight = 0
  },
  exec_clock = 0,
crash> struct sched_entity.on_rq,deadline,min_vruntime,vruntime,load,vlag,slice,exec_start,sum_exec_runtime,prev_sum_exec_runtime,my_q,run_node 0xffff888139b57c00
  on_rq = 1,
  deadline = 4705706610399852,
  min_vruntime = 4493662477571149,
  vruntime = 4698735667604793,
  load = {
    weight = 1042467,
    inv_weight = 0
  },
  vlag = 4493662483537817,
  slice = 2250000,
  exec_start = 7308537586004,
  sum_exec_runtime = 7196457582967,
  prev_sum_exec_runtime = 7196456203065,
  my_q = 0xffff888139b55000,
  run_node = {
    __rb_parent_color = 1,
    rb_right = 0xffff8881362d80d0,
    rb_left = 0x0
  },
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag,slice,exec_start,sum_exec_runtime,prev_sum_exec_runtime,my_q,run_node -l sched_entity.run_node 0xffff8881362d80d0
  deadline = 4493662533339551,
  min_vruntime = 4493662476669436,
  vruntime = 4493662519944203,
  load = {
    weight = 176128,
    inv_weight = 24970740
  },
  vlag = 4493662519002535,
  slice = 2250000,
  exec_start = 7308527703195,
  sum_exec_runtime = 4759831,
  prev_sum_exec_runtime = 2351660,
  my_q = 0x0,
  run_node = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0xffff8881362d9b50
  },
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag,slice,exec_start,sum_exec_runtime,prev_sum_exec_runtime,my_q,run_node -l sched_entity.run_node 0xffff8881362d9b50
  deadline = 4493662476695393,
  min_vruntime = 4493662476669436,
  vruntime = 4493662476669436,
  load = {
    weight = 90891264,
    inv_weight = 48388
  },
  vlag = 51914,
  slice = 2250000,
  exec_start = 7308536206102,
  sum_exec_runtime = 2102797408,
  prev_sum_exec_runtime = 2102198648,
  my_q = 0x0,
  run_node = {
    __rb_parent_color = 18446612687273951440,
    rb_right = 0x0,
    rb_left = 0x0
  },
crash>

In vruntime_eligible():
	for sched_entity curr [0xffff888139b57c00]: 	avg [-9033150209515029779], (int64_t)(vruntime - cfs_rq->min_vruntime) * load [9204623872495814378], so return false
	for sched_entity root [0xffff8881362d80d0]: 	avg [-9033150209515029779], (int64_t)(vruntime - cfs_rq->min_vruntime) * load [9204833240987634904], so return false
	for sched_entity leftmost [0xffff8881362d9b50]: avg [-9033150209515029779], (int64_t)(vruntime - cfs_rq->min_vruntime) * load [9204829348379068487], so return false
Therefore, all sched_entities on this cfs_rq have no eligibility to run
to cause the NULL pointer dereference in pick_next_task_fair().

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: wulibin163 <wulibin163@126.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..963802d43f4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3772,6 +3772,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 {
 	bool curr = cfs_rq->curr == se;
 
+	if (curr && se->on_rq && cfs_rq->nr_queued == 1 &&
+		se->vruntime < cfs_rq->min_vruntime) {
+		s64 rel_deadline = se->deadline - se->vruntime;
+
+		se->vruntime = cfs_rq->min_vruntime;
+		se->deadline = se->vruntime + rel_deadline;
+	}
+
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
-- 
2.34.1


