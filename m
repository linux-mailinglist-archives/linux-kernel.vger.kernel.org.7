Return-Path: <linux-kernel+bounces-755044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D69CB1A090
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9048F17BF46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E3225334B;
	Mon,  4 Aug 2025 11:28:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29E2417C2;
	Mon,  4 Aug 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306895; cv=none; b=tCRwTkkZUIulf0bjpQSR7DLnNiolGiER7UtczKDOYuo/sSZQAZZp4eH6OxpvUXl03T/hGlPYBzW0///m6hnH+vNEHJjC4T40v3V+Knhco+gD2+geZEnlm4yAXIQVxiZfde5qd9qXNkJH0zDT/UJnoivhGfPpXrKKDsrCc3cj6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306895; c=relaxed/simple;
	bh=hjOL3ON5fPPF6nNMGzaUMSvif7RbckVL3EFMwbn3B9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T89Uyg6CsYae3e95CT8/LGhQHaYjW2u0qtJHKxu6vCsgohZa7zKinXA9lApHMPKm/PXenN4cHOSbxkSwAtx4Grz3pt6V726B8pgcpgyWdy516YAaTYcOsrZ1qxDS83uQh8mXAXdUgdH6THpcmDYs9dp+YWORyqKiTg06vfnKkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447251424;
	Mon,  4 Aug 2025 04:28:05 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BFDF83F673;
	Mon,  4 Aug 2025 04:28:10 -0700 (PDT)
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
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Date: Mon,  4 Aug 2025 12:27:41 +0100
Message-Id: <20250804112743.711816-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112743.711816-1-christian.loehle@arm.com>
References: <20250804112743.711816-1-christian.loehle@arm.com>
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
index 7dedc9a16281..3ea3f0f18030 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7589,7 +7589,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
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


