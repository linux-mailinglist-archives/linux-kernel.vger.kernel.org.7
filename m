Return-Path: <linux-kernel+bounces-753480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F043B1838C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9061AA8039C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1E26B756;
	Fri,  1 Aug 2025 14:18:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813F26E71C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057883; cv=none; b=C26dvybJ3VoDSryTLUtI3MXLpXoGiW7YkT1V+eO9SzQD/lI0SLSL11QGavSVv3Jvm8Z+ah7THPwLAvsuIVt8XNs7gKBtsib4x78RZIeX9VOKgvoituBkYzQPWHK+ICiAwEXEomH6idP43sXVfAo9QxKqB/u9QXjHSdlQvl9H4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057883; c=relaxed/simple;
	bh=Ym6ERqnzHQoUR3s3jCQ9RI780xASY9USRgCsxRkOzoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPZK6V0ZIu2P27ve+C0H8SAARgsJgnhNz0SV4DNifFzRWLEOAKHU6zrCPVaY93DmiALrvsKvTrs+p2jMjWTvHPX/lD2dEn4PE0p/j506Yvyjnqa6tGho4F6Nr3UcKxf/69HbPQixLVWiBJd3dHeFTCSehc9vo0KR3rR2i+XizcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A66981515;
	Fri,  1 Aug 2025 07:17:53 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0AA43F673;
	Fri,  1 Aug 2025 07:17:59 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Date: Fri,  1 Aug 2025 15:17:41 +0100
Message-Id: <20250801141741.355059-4-christian.loehle@arm.com>
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

Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
Furthermore they become meaningless without rq lock, too.
Only return scx_bpf_cpu_rq() when we hold rq lock of that rq.

All upstream scx schedulers can be converted into the new
scx_bpf_remote_curr() instead.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 92e66bb0b5f2..627df3088fd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7425,7 +7425,7 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 }
 
 /**
- * scx_bpf_cpu_rq - Fetch the rq of a CPU
+ * scx_bpf_cpu_rq - Fetch the rq of a CPU if its rq lock is currently held
  * @cpu: CPU of the rq
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
@@ -7433,7 +7433,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
-	return cpu_rq(cpu);
+	return this_cpu_read(locked_rq) == cpu_rq(cpu) ? cpu_rq(cpu) : NULL;
 }
 
 /**
-- 
2.34.1


