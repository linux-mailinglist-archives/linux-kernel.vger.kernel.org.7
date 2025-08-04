Return-Path: <linux-kernel+bounces-755046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9EB1A092
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9978F7A4CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D5256C81;
	Mon,  4 Aug 2025 11:28:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5A25334B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306905; cv=none; b=FqPajnvN4QZJPzuD8q++OyVBZShZMks92Cb+xW48Hhvv3N+obThIcfnm6uer1LuJaSujBROW+cJ6rQfSnu4ui5KcMHO1RzxMWdDkLIIkSRw7bgEadhzszF+I8bO66OlpQbCaQQ47C0MtU0tQNd/0XyQtp6n9jCfvXD9gDBRx+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306905; c=relaxed/simple;
	bh=4y0ubXbM+sFWMUXk2AwlLJnNZtXbVDFA30Piw0OYsuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcQWpVNjIWSM1GwIzDbiAcPahBApABlfVtQ8gDFv4tpZdK5NUa3LA/n6d3PpIbT3CJ9+bFoYPnNuVWS+hKwzL7vvIWdbI0Z3iuvkhct6ZCfEvtURmVdK3pB546YgaFyyGvM5JOtoEvmK3zYQuVwp1d6qDKS1oK6LUMBlMm8Lcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37FD11424;
	Mon,  4 Aug 2025 04:28:15 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1B663F673;
	Mon,  4 Aug 2025 04:28:20 -0700 (PDT)
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Date: Mon,  4 Aug 2025 12:27:43 +0100
Message-Id: <20250804112743.711816-4-christian.loehle@arm.com>
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

Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
Furthermore they become meaningless without rq lock, too.
Only return scx_bpf_cpu_rq() if we hold rq lock of that rq.

All upstream scx schedulers can be converted into the new
scx_bpf_remote_curr() instead.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1d9d9cbed0aa..0b05ddc1f100 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7420,10 +7420,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
+	struct rq *rq;
+
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
-	return cpu_rq(cpu);
+	rq = cpu_rq(cpu);
+	if (rq != scx_locked_rq_state) {
+		scx_kf_error("Accessing not locked rq %d", cpu);
+		return NULL;
+	}
+
+	return rq;
 }
 
 struct task_struct *bpf_task_acquire(struct task_struct *p);
-- 
2.34.1


