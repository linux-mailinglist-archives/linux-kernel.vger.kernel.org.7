Return-Path: <linux-kernel+bounces-792070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A73B3BFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECDD175672
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C833EAF9;
	Fri, 29 Aug 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcVGpPnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B633EAF4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482555; cv=none; b=IW6eUEAo2kYIsTOheWgqB6NX8tBQdvDNveAcX30lb4KhkkagdSEephTPT4/pZV2PwYUz0D8xH3HHs3qxD9yyjVRpQMR7GHiMNuxCbpXcHBw1zV610+2tP98tQdF7zZwRfCsYyPWKUVrRNr2Flwt+EOSfol6bpJW7jAYX7VEQRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482555; c=relaxed/simple;
	bh=H42PRIJFhc68hczE5JFr8BulcuyrR8cWi/byZNSlUrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky+MNkhfKI1No9O95PwhHP4dcl09YgjujzPmNMnrPojP8i3YHJJIc+jTCP+FrFDVxm7O30U4Ss5jj3HRTG3ASwT1grMOGc77zgdWsm04Pazv1c3x/z1+A42WW7dGYD1ms9e+Tc1lLq3zz19Onn2VG6ts/yxPEBXWxE7ZX9A9sGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcVGpPnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D073C4CEF6;
	Fri, 29 Aug 2025 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482555;
	bh=H42PRIJFhc68hczE5JFr8BulcuyrR8cWi/byZNSlUrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AcVGpPnlQT1jwi8qC6n4TM2FJ2My5t5SfEz9687CXaAWzknU5wiIjteY3u8GtlXx2
	 samFbf8UAxUsyqIh0Q1QOfA1zvJajbFOjTi8VNRQMxB0Za5RVZtSATYa7Z0tU+MWfr
	 vvKop+2fRrFgEX5mff7dw6QQp7a0eaQZQ6cUU6k+4rEZInstCCOoyd3AZaQqWgryIB
	 oMn2ZWkfv11old8eEHmnu4gJfUFc9DO7A/GKgshtQRTIRZbYTdiYyJY9en1/1mvRa2
	 slBNBSCVOw1t+n1g31piiGuhIsjTFxHqD4HWpiyMhP6PUORSTiq/2b8/vD9zbL1v1+
	 ghf5Klfdxd+Xg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from cpu_is_isolated()
Date: Fri, 29 Aug 2025 17:48:00 +0200
Message-ID: <20250829154814.47015-20-frederic@kernel.org>
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

It doesn't make sense to use nohz_full without also isolating the
related CPUs from the domain topology, either through the use of
isolcpus= or cpuset isolated partitions.

And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.

This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
alias) is always a superset of HK_TYPE_DOMAIN.

Therefore if a CPU is not HK_TYPE_KERNEL_NOISE, it can't be
HK_TYPE_DOMAIN either. Testing the latter is then enough.

Simplify cpu_is_isolated() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index c02923ed4cbe..8d6d26d3fdf5 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -82,8 +82,7 @@ static inline void housekeeping_init(void) { }
 
 static inline bool cpu_is_isolated(int cpu)
 {
-	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
+	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
 }
 
 #endif /* _LINUX_SCHED_ISOLATION_H */
-- 
2.51.0


