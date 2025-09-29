Return-Path: <linux-kernel+bounces-836239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A103FBA9147
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5253A1C3CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EB3016E6;
	Mon, 29 Sep 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl1+Rm5i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CE3016F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146161; cv=none; b=Ua6nE3WRcb7naXKVQhgCTyJtX1ypsXbH26crPQH5eAxoEa6UlACNv2g/KJQZSKyroJN/mKlDDe3r5C/tU02dVV0vcMEwtfKJBJJKR5hQAHFSiWcp0sX1PdcOtk4f7xGSesorhIHuP16deTakp/5vVz9YSo+/utR1+C3Hz+lVUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146161; c=relaxed/simple;
	bh=1FwOfCKSfaRyXmFFuFKp53OjCRMkVx+Ih6UrjWDtrO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQ6zWfNLsbzWUGK0F3kWL2aNRNCOvrMEH/kW4YJXRSfc0TNpv1YXGrTdZlVgjCkPbCl9JqpbtIU+kUo1uhRqGsII6EmhadgiELOQVpHWPYCCJUQIEtDROqIWC9EsZyawbcRVkwOO9akRyOx5n5reL5o0Zs7hbvO/WevSIgATJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xl1+Rm5i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759146157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6e3ayQm5w7OSPmihD2mV/OEvV72d7X44Ut1VlkUg3so=;
	b=Xl1+Rm5iby/0QeV6MPbLmm2yKZlQHvQmkWYAG5/1D/ssemWPKSdTjWUXuNFqvwil/iFpCw
	z29LehZUBNuuU/PCtr/mKKYnev/U4XuiHZekvCF9ZsCgpDMVA9LpXLEcPpWPNvSUFT69Oa
	I5egySACePpSLy0sjFf/xt5V7aji/eU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-eH4tHHZ2N_iubkIeOnVAfw-1; Mon,
 29 Sep 2025 07:42:33 -0400
X-MC-Unique: eH4tHHZ2N_iubkIeOnVAfw-1
X-Mimecast-MFC-AGG-ID: eH4tHHZ2N_iubkIeOnVAfw_1759146152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94A61195608E;
	Mon, 29 Sep 2025 11:42:32 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46C4119560A2;
	Mon, 29 Sep 2025 11:42:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 0/4] sched: Run task_mm_cid_work in batches to lower latency
Date: Mon, 29 Sep 2025 13:42:21 +0200
Message-ID: <20250929114225.36172-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This V2 of [1] is a continuation of [2] but using a simpler approach.
The task_mm_cid_work runs as a task_work returning to userspace and
causes a non-negligible scheduling latency, mostly due to its iterations
over all cores.

Split the work into several batches, each call to task_mm_cid_work will
not run for all cpus but just for a configurable number of cpus. Next
runs will pick up where the previous left off.
The mechanism that avoids running too frequently (100ms) is enforced
only when finishing all cpus, that is when starting from 0.

Also improve the predictability of the scan on short running tasks by
scheduling it from rseq_sched_switch_event, which runs on every task
switch (similar behaviour to [2]), the same workaround on the tick for
long running tasks seen in [2] was ported also here.

The duration of a full scan depends now on the workload, where workloads
with less threads are more likely to take longer.
Tests with cyclictest (threads with 100us period) and hackbench
(processes) on a 128 CPUs machine measuring the time to complete the
scan as well as the time between non-complete scans showed the following
(batch size of 8: 16 iterations):

cyclictest: delay 0-400 us , complete scan 1.5-2 ms
hackbench: delay 5us - 3ms , complete scan 1.5-15 ms

With the observed worst case for hackbench, it would take more than 800
CPUs to reach the current 100ms limit.

The problematic latency observed on a full scan (128 CPUs), had a
duration of the call to task_mm_cid_scan around 35 us, where 20 us is
considered a relevant latency on this machine.

Measurements showed these durations for each call to task_mm_cid_scan:

batch size  8:  1-11 us (majority below 10)
batch size 16:  3-16 us (majority below 10)
batch size 32: 10-21 us (majority above 15)

This led to a choice of 16 as default batch size.

Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
sched_ext classes as it is supported by fair, this is required to avoid
calling rseq_preempt on tick if the runtime is below a threshold.

Patch 2 schedules the task_mm_cid_work from rseq_sched_switch_event().

Patch 3 splits the work into batches.

Patch 4 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids).

Changes since V2 [3]:
* Rebase on rseq rework [4].
* Revert to using task_work.
* Start the work in rseq_sched_switch_event().

Changes since V1 [1]:
* Use cpu_possible_mask in scan.
* Make sure batches have the same number of CPUs also if mask is sparse.
* Run the task on rseq_handle_notify_resume as in [2] but call directly.
* Schedule the work and mm_cid update on tick for long running tasks.
* Fix condition for need_scan only on first batch.
* Change RSEQ_CID_SCAN_BATCH default to be a power of 2.
* Rebase selftest on [2].
* Increase the selftest timeout on large systems.

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>

[1] - https://lore.kernel.org/lkml/20250217112317.258716-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250707144824.117014-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20250716160603.138385-6-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20250908212737.353775467@linutronix.de

Gabriele Monaco (4):
  sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
  rseq: Schedule the mm_cid_compaction from rseq_sched_switch_event()
  sched: Compact RSEQ concurrency IDs in batches
  selftests/rseq: Add test for mm_cid compaction

 include/linux/mm_types.h                      |  26 +++
 include/linux/rseq.h                          |   3 +
 include/linux/sched.h                         |   3 +
 init/Kconfig                                  |  12 ++
 kernel/sched/core.c                           |  79 ++++++-
 kernel/sched/deadline.c                       |   1 +
 kernel/sched/ext.c                            |   1 +
 kernel/sched/rt.c                             |   1 +
 kernel/sched/sched.h                          |   2 +
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 204 ++++++++++++++++++
 12 files changed, 324 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: 1822acbae2c9b8a6e6472809b42eab72cd7bf80c
-- 
2.51.0


