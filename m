Return-Path: <linux-kernel+bounces-733917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0BCB07AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D611C24209
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028EB2F532D;
	Wed, 16 Jul 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArlYSt5M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415331A238C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682006; cv=none; b=kG2pUZryfh+AtlkMVE3Kjl8OAL7Wu1pDc5NNVigR5/2/eUQZZow5R6dg+r2PifnTSi2ovLARSXOn0vqWYORgnrb5/DSxK7wFHlIkf1fXvqX9PYLK3zx3p6hcGjS10/p6R3JoTY//I2kOia4f7vL66cqQFEBSt2uJmRVWiBFW4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682006; c=relaxed/simple;
	bh=RDZ2mWTbje6hcyX2e5UzBfo7bV8KZYGf2bR9tlyCjaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DcCQe9Pmat9n1BFBhj7sfY/yFGWMb15JgvhmVWw/Ldr8deSIc5mnimpRbVzeJHDrGkX1e/DuzT3/jG7vdLeVhYFKeRBdeKQv2TJZZOEf6hPaaj8b4RvvqJJcTXd8n+CB0ZDr5R0+7lOkJWV6ramjLSmaY5MYbinHVT1N+EnKqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArlYSt5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DJweZ7HAhOTKs1636oOLj3qAauQsQxFHS9Twe1Kbvb4=;
	b=ArlYSt5MCyqT3E+uR7loVOb+seb1P8oa8LuPdEmyGw1TPzH1WL+gtnAq7Cv9alBJH67AwQ
	vQKUKR+0+T6nRHma5EG5M9RKx3bVn1LT5PcSCOt6JZbrXvyLEPFE9PGpgMlMYVkZICb3WQ
	Cy5FjWnUnEfk+SSHG4EV2ARjGKv/tjY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-oIzkRSOUM3OQqbGbgzI0QA-1; Wed,
 16 Jul 2025 12:06:40 -0400
X-MC-Unique: oIzkRSOUM3OQqbGbgzI0QA-1
X-Mimecast-MFC-AGG-ID: oIzkRSOUM3OQqbGbgzI0QA_1752681999
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5E291800371;
	Wed, 16 Jul 2025 16:06:39 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4678B19560AB;
	Wed, 16 Jul 2025 16:06:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 0/4] sched: Run task_mm_cid_work in batches to lower latency
Date: Wed, 16 Jul 2025 18:06:04 +0200
Message-ID: <20250716160603.138385-6-gmonaco@redhat.com>
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
running it from rseq_handle_notify_resume, which runs it on every task
switch (similar behaviour to [2]), the same workaround on the tick for
long running tasks seen in [2] was ported also here.

Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
sched_ext classes as it is supported by fair, this is required to avoid
calling rseq_preempt on tick if the runtime is below a threshold.

Patch 2 moves the directly calls task_mm_cid_work instead of relying on
a task_work, necessary to avoid rseq_handle_notify_resume being called
twice while enqueuing a task_work.

Patch 3 splits the work into batches.

Patch 4 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids).

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
To: Ingo Molnar <mingo@redhat.org>

[1] - https://lore.kernel.org/lkml/20250217112317.258716-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250707144824.117014-1-gmonaco@redhat.com

Gabriele Monaco (4):
  sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
  rseq: Run the mm_cid_compaction from rseq_handle_notify_resume()
  sched: Compact RSEQ concurrency IDs in batches
  selftests/rseq: Add test for mm_cid compaction

 include/linux/mm.h                            |   2 +
 include/linux/mm_types.h                      |  26 +++
 include/linux/sched.h                         |   2 +-
 init/Kconfig                                  |  12 ++
 kernel/rseq.c                                 |   2 +
 kernel/sched/core.c                           |  92 ++++++--
 kernel/sched/deadline.c                       |   1 +
 kernel/sched/ext.c                            |   1 +
 kernel/sched/rt.c                             |   1 +
 kernel/sched/sched.h                          |   2 +
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 204 ++++++++++++++++++
 13 files changed, 323 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
-- 
2.50.1


