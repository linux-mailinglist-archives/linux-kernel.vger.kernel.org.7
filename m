Return-Path: <linux-kernel+bounces-720057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85130AFB671
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D9E16AF65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047BE2BD58F;
	Mon,  7 Jul 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkRw+8JR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466B28A719
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899721; cv=none; b=DdGwhhwgFb8yojOQbEQsw8pFLgOHAszyr43Rgky0kkEVluRQTikJ0smlY3MJXr6MB9718p3Q2l5X3ckWiCSrSj4mDTkc5FYDk1R59XBUqocZcAS+36iKydH/E8Qb4bqfTLxV995ZORVKu1f6ljDEvzmgMtJaCGSEKczbRPJoOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899721; c=relaxed/simple;
	bh=DQOjuwKfrmwOfRmZkubEzVHCNMscHy1lY3uXA8hpPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrVCpmXjAhkUC2/y1u+NANnRe8WehxtIyFYJDsBIURdyvA7AtnywVMnMyo4PiY2Silf/AmyhazTPfPndysFmMtRAlxjFhSDeznkb0laMNDpR766tJREn92a4v4XGtnOUgChy5B4xiZCXE1xB/L+7sIiRDBuWdc8pFGY41wW6ToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkRw+8JR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751899717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q+e4yj9hakLszzyFu+bwGnzgKBV5kxdiLq1fyzM0j0s=;
	b=ZkRw+8JREpIZy7tziodIUD2p0fdzcaa/XyP3223dMkDRE5K8d3YnNMJprvN+XL1y84VQ0E
	hctrqY7E+gnDo0O7XRvNrUd8pvQg/FGlZSeZC3QvxkzMMVrSlKMbR6iSUO2kALCshf1e9Z
	hwXdtV5oKhvfAIcdh0feOC8p0+aNJ20=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-QpZrlJbNM2uMtdfT131E4g-1; Mon,
 07 Jul 2025 10:48:34 -0400
X-MC-Unique: QpZrlJbNM2uMtdfT131E4g-1
X-Mimecast-MFC-AGG-ID: QpZrlJbNM2uMtdfT131E4g_1751899713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D402C19107EB;
	Mon,  7 Jul 2025 14:48:32 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E51618046C5;
	Mon,  7 Jul 2025 14:48:29 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v14 0/3] sched: Restructure task_mm_cid_work for predictability
Date: Mon,  7 Jul 2025 16:48:21 +0200
Message-ID: <20250707144824.117014-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patchset moves the task_mm_cid_work to a preemptible and migratable
context. This reduces the impact of this work to the scheduling latency
of real time tasks.
The change makes the recurrence of the task a bit more predictable.

The behaviour causing latency was introduced in commit 223baf9d17f2
("sched: Fix performance regression introduced by mm_cid") which
introduced a task work tied to the scheduler tick.
That approach presents two possible issues:
* the task work runs before returning to user and causes, in fact, a
  scheduling latency (with order of magnitude significant in PREEMPT_RT)
* periodic tasks with short runtime are less likely to run during the
  tick, hence they might not run the task work at all

Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
sched_ext classes as it is supported by fair, this is required to avoid
calling rseq_preempt on tick if the runtime is below a threshold.

Patch 2 contains the main changes, removing the task_work on the
scheduler tick and using a timer scheduled more reliably during
__rseq_handle_notify_resume.

Patch 3 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids).

Changes since V13:
* Use a timer instead of a work_struct to reduce switch overhead
* Enqueue the timer only if not pending
* Ensure the rseq_preempt on tick is done after the scan and only once
  (don't run on pending timer and always update last_cid_reset on get)

Changes since V12:
* Ensure the tick schedules the mm_cid compaction only once for tasks
  executing longer than 100ms (until the scan expires again)
* Execute an rseq_preempt from the tick only after compaction was done
  and the cid assignation changed

Changes since V11:
* Remove variable to make mm_cid_needs_scan more compact
* All patches reviewed

Changes since V10:
* Fix compilation errors with RSEQ and/or MM_CID disabled

Changes since V9:
* Simplify and move checks from task_queue_mm_cid to its call site

Changes since V8 [2]:
* Add support for prev_sum_exec_runtime to RT, deadline and sched_ext
* Avoid rseq_preempt on ticks unless executing for more than 100ms
* Queue the work on the unbound workqueue

Changes since V7:
* Schedule mm_cid compaction and update at every tick too
* mmgrab before scheduling the work

Changes since V6 [3]:
* Switch to a simple work_struct instead of a delayed work
* Schedule the work_struct in __rseq_handle_notify_resume
* Asynchronously disable the work but make sure mm is there while we run
* Remove first patch as merged independently
* Fix commit tag for test

Changes since V5:
* Punctuation

Changes since V4 [4]:
* Fixes on the selftest
    * Polished memory allocation and cleanup
    * Handle the test failure in main

Changes since V3 [5]:
* Fixes on the selftest
    * Minor style issues in comments and indentation
    * Use of perror where possible
    * Add a barrier to align threads execution
    * Improve test failure and error handling

Changes since V2 [6]:
* Change the order of the patches
* Merge patches changing the main delayed_work logic
* Improved self-test to spawn 1 less thread and use the main one instead

Changes since V1 [7]:
* Re-arm the delayed_work at each invocation
* Cancel the work synchronously at mmdrop
* Remove next scan fields and completely rely on the delayed_work
* Shrink mm_cid allocation with nr thread/affinity (Mathieu Desnoyers)
* Add self test

[1] - https://lore.kernel.org/lkml/20250414123630.177385-5-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250220102639.141314-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20250113074231.61638-4-gmonaco@redhat.com
[5] - https://lore.kernel.org/lkml/20241216130909.240042-1-gmonaco@redhat.com
[6] - https://lore.kernel.org/lkml/20241213095407.271357-1-gmonaco@redhat.com
[7] - https://lore.kernel.org/lkml/20241205083110.180134-2-gmonaco@redhat.com

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.org>

Gabriele Monaco (3):
  sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
  sched: Move task_mm_cid_work to mm timer
  selftests/rseq: Add test for mm_cid compaction

 include/linux/mm_types.h                      |  23 +-
 include/linux/sched.h                         |   8 +-
 kernel/rseq.c                                 |   2 +
 kernel/sched/core.c                           | 103 ++++-----
 kernel/sched/deadline.c                       |   1 +
 kernel/sched/ext.c                            |   1 +
 kernel/sched/rt.c                             |   1 +
 kernel/sched/sched.h                          |   8 +-
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 200 ++++++++++++++++++
 11 files changed, 293 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.50.0


