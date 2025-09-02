Return-Path: <linux-kernel+bounces-796222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40333B3FD79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C890D4E2840
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBF2F6190;
	Tue,  2 Sep 2025 11:12:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D72F60C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811550; cv=none; b=qASJi21X1Ij0Mp8FPN5ghGjJ2u87BNCnUnHtzdrUOPUemzqUAbbVuv9lRro/Ua3jDQ8aOr14+g5bAphBaRjC4HiEIc7fxwz482ZoXbmvh0hscGQ5bVkArMg5f54c8I2+beNe6veRxpNrEOm1u9SubWpD625BF1ZGhGCNtVrDdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811550; c=relaxed/simple;
	bh=rWWZd7XItYTPoZRL+fgwWhMxqYXoYcDLlGPYszb8vlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nx9Y5ea8HG96NSacchsuDMplLASAr0t6RlC4OU/3cukqmeVqz6nhuTOkuTtQyFbDFm6nfxsm8dZcBLygokQdFl14VmKEBn91qEkAESeAq6u1dYiWB5Zcgsrhks8gDvBNB7ieWzVX8GdtfhwO6rOSIDDUpHYwmi0bZ3R1Cgivs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE0426BE;
	Tue,  2 Sep 2025 04:12:19 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.90.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D49C43F694;
	Tue,  2 Sep 2025 04:12:25 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v6 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Tue,  2 Sep 2025 12:11:40 +0100
Message-Id: <20250902111143.2667154-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() currently allows accessing struct rq fields without
holding the associated rq.
It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
scx_tickless. Fortunately it is only ever used to fetch rq->curr.
So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
/* ... Do something with p */

into:

p = scx_bpf_remote_curr(cpu);
/* ... Do something with p */

Changes since:
v5:
https://lore.kernel.org/lkml/20250901132605.2282650-2-christian.loehle@arm.com/
- Actually expose the RCU pointer in scx_bpf_remote_curr() as such (Andrea)
v4:
https://lore.kernel.org/lkml/20250811212150.85759-1-christian.loehle@arm.com/
- Remove cpu argument from scx_bpf_cpu_rq_locked() as SCX has a unique
locked_rq_state anyway. (Tejun)
- Expose RCU pointer in scx_bpf_remote_curr() (Peter)
v3:
https://lore.kernel.org/lkml/20250805111036.130121-1-christian.loehle@arm.com/
- Don't change scx_bpf_cpu_rq() do not break BPF schedulers without the
grace period. Just add the deprecation warning and do the hardening in
the new scx_bpf_cpu_rq_locked(). (Andrea, Tejun, Jake)
v2:
https://lore.kernel.org/lkml/20250804112743.711816-1-christian.loehle@arm.com/
- Open-code bpf_task_acquire() to avoid the forward declaration (Andrea)
- Rename scx_bpf_task_acquire_remote_curr() to make it more explicit it
behaves like bpf_task_acquire()
v1:
https://lore.kernel.org/lkml/20250801141741.355059-1-christian.loehle@arm.com/
- scx_bpf_cpu_rq() now errors when a not locked rq is requested. (Andrea)
- scx_bpf_remote_curr() calls bpf_task_acquire() which BPF user needs to
release. (Andrea)

Christian Loehle (3):
  sched_ext: Introduce scx_bpf_cpu_rq_locked()
  sched_ext: Introduce scx_bpf_remote_curr()
  sched_ext: deprecation warn for scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 40 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 2 files changed, 42 insertions(+)

--
2.34.1


