Return-Path: <linux-kernel+bounces-753478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA27B18389
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D257584103
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798426E140;
	Fri,  1 Aug 2025 14:17:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4C26CE3A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057877; cv=none; b=QIb18JcYctzBMiM6DWDq8XZXdaGkTmmmrq5gC089VtdZsMaYMErvcWcjqsz6klZzniA0B7yAzpP5jP3tNxpEv0pN1SrDJpvhIF+hHRZAnArbalIShkofNPCjgkq2keMH+sMiz85t+WUKSGEVW0/mgsUxmOwhzgKsf7HAsSrV8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057877; c=relaxed/simple;
	bh=2sYU4jHFbjyd1yjtFmZkOj2kjSLSWAglphbzQJ89pv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbkHBigLRJbXcBZqwpIDh2MYTLgJG8q23xAeJPBc2Ey0Ob8pXIEMO/eCxm3lxISCDQUYGb1Ytl5cOi6bIV48xG2i9g4s3BI04tZuf4QfxUbWqh+7LtyI5gl/VXLAJawMdzYMrae2Ow7fxH0WXvKagZgsNcpjQkkYfTIrEasCMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5186716A3;
	Fri,  1 Aug 2025 07:17:47 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 627073F673;
	Fri,  1 Aug 2025 07:17:53 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH 1/3] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Date: Fri,  1 Aug 2025 15:17:39 +0100
Message-Id: <20250801141741.355059-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801141741.355059-1-christian.loehle@arm.com>
References: <20250801141741.355059-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
Mark it as such.
While kf_cpu_valid() will trigger scx_ops_error() that leads
to the BPF scheduler exiting, this isn't guaranteed to be immediate,
allowing for a dereference of a NULL scx_bpf_cpu_rq() return value.

Cc: stable@vger.kernel.org
Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dd5cbcb7a06..b734f55f3318 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7599,7 +7599,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
-- 
2.34.1


