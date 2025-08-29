Return-Path: <linux-kernel+bounces-792075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A343B3BFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B932F1691C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79018341AA8;
	Fri, 29 Aug 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO/y6dOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A9341ADA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482567; cv=none; b=ipsuK2qFVcJPksd07xhyNyoB1Pdqj8XV7HBRBaBZrggSXwsI3U4rerKhfhIwrdtxGA6wkBmf0t8H2YpkzucWar8YY1+nZ++tUFVq+ktWAmnE32U8fSAhjM4s3u8k0bEs2dNiaYV49EfSeBObWMb5j2sRB8u8W9eUagANrOA65mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482567; c=relaxed/simple;
	bh=P4mvTUeHXF9en4Wc01ryvy7Y+w+A6mZbhGMT9VJdNo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k29xhYHDto+UriTw0npxd1td0RW2C2i2Zl34U7GrjGyllz+8rAme8ijjAPsUwp5S8taTrk+YLzX8VrMSNDCCmt3WDF/5FqZt3a+z7ASF/EWr9CbfHkbe206t0mWffiUoGFWP6WGGIC00fVvzDSUXg5054KVWKZYky427026xmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO/y6dOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B9C4CEF0;
	Fri, 29 Aug 2025 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482567;
	bh=P4mvTUeHXF9en4Wc01ryvy7Y+w+A6mZbhGMT9VJdNo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RO/y6dOr8F+Lq3WXvsHR5YmvrwTzpO7rcA3MaBc6GDXAtE1QoZ85775+mG1CRoAxI
	 q9A95Vtbp2tu4R0sq9Y0/ys2MWkKibTOawjb0TxHsc+6ZmjxdElhlagX04NtkCyMVa
	 j0FOfLo4SjYGAjRQ8zi0R2VKteaQO1uxdTQLRCTYIALN/xLYZzPc+Q4w3UvgfTxZwH
	 S/I09ib1vrJ0IJ17E8/co9qczeQxBBYkya41qi95QS6KKPj0TLu4lx9BjwFlgxFXvM
	 iHxA/nIiQo/71WsB/RS2RdJsyar7JM8gdxtluIddgG9JkiV2kRgpBL1ZUUJrGwE+h5
	 nQI0gOv0pEiCA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 24/33] kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management
Date: Fri, 29 Aug 2025 17:48:05 +0200
Message-ID: <20250829154814.47015-25-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbound kthreads want to run neither on nohz_full CPUs nor on domain
isolated CPUs. And since nohz_full implies domain isolation, checking
the latter is enough to verify both.

Therefore exclude kthreads from domain isolation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index cb0be05d6091..8d0c8c4c7e46 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -362,18 +362,20 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
 {
 	const struct cpumask *pref;
 
+	guard(rcu)();
+
 	if (kthread->preferred_affinity) {
 		pref = kthread->preferred_affinity;
 	} else {
 		if (kthread->node == NUMA_NO_NODE)
-			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
+			pref = housekeeping_cpumask(HK_TYPE_DOMAIN);
 		else
 			pref = cpumask_of_node(kthread->node);
 	}
 
-	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_DOMAIN));
 	if (cpumask_empty(cpumask))
-		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 }
 
 static void kthread_affine_node(void)
-- 
2.51.0


