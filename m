Return-Path: <linux-kernel+bounces-792057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369CB3BFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E758E1C20AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC5322C9C;
	Fri, 29 Aug 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYqJB6IP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE823314A7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482517; cv=none; b=n/CA+QAFNfqKWGHPWpNxUby8RRQzwwEAj0MGQ9Aqk+yI8yQU9LfoD9QfYOSyqWf9vPn5PX/ckcWQ9uGgh4yEeeyfMLI8ijlFnxuAR9LWUMDkJsVVvQpFG8lWqfcMErbCdXWkMJ2vUxuNcfADMmVdRzCaM2YSMgoZkAjKsaLyg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482517; c=relaxed/simple;
	bh=YqIjpVaY5D0ks0POHkX9szyfGsLXZLStsFdd5bGAgPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6shwqHaoWmm18qXQT8YDJ5griLoxg7pM8+guKZ7mNFNlI+vlLl6gqydass3ejjy9UjS72RAPpZubj05TESBRskuATyDT9vJgLwERDrSqE1SX7KDP4l2byG3Kq88gpAerbxBvWzCMxVBwwRNXTzNWLRdjTzJ8sUReRz3Ys49whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYqJB6IP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E13C4CEF5;
	Fri, 29 Aug 2025 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482516;
	bh=YqIjpVaY5D0ks0POHkX9szyfGsLXZLStsFdd5bGAgPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYqJB6IPNNUciPYkOIHvqfSulF3gPDnDb22Q5YExqL+GXCfA3hr9bXcTxWXfK8NDy
	 fM4Dg0JRSqe3pMHJI3xTd74WnFm9s/nAHxTRypSuf6mazdlJQgRdQODOn4yZe8wIvV
	 3i3zZVVDiDgPJY8Gue2WRHq8fJHTAVdBDk1Wp0FUT/i5bbDFD0oG9AqMCp3+GuO1Ue
	 xbgidQrxS6ErGnHMXMEb6HZ8DdJ+gzhWBZMtAxdKihoNrCNp3kdbYZdembO7xsORlY
	 HivMSjCcJqj8nJXLJiTmFEpvxmWI4W4F0AHBk9bFC4Fox8PVbjoPKCK5cYao1ZiSR1
	 JrBQ69q2HPDmg==
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
Subject: [PATCH 06/33] sched/isolation: Save boot defined domain flags
Date: Fri, 29 Aug 2025 17:47:47 +0200
Message-ID: <20250829154814.47015-7-frederic@kernel.org>
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

HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
but also cpuset isolated partitions.

Housekeeping still needs a way to record what was initially passed
to isolcpus= in order to keep these CPUs isolated after a cpuset
isolated partition is modified or destroyed while containing some of
them.

Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index f98ba0d71c52..9262378760b1 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,6 +7,7 @@
 #include <linux/tick.h>
 
 enum hk_type {
+	HK_TYPE_DOMAIN_BOOT,
 	HK_TYPE_DOMAIN,
 	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_KERNEL_NOISE,
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 2a6fc6fc46fb..fb414e28706d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -11,6 +11,7 @@
 #include "sched.h"
 
 enum hk_flags {
+	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
@@ -204,7 +205,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "domain,", 7)) {
 			str += 7;
-			flags |= HK_FLAG_DOMAIN;
+			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 			continue;
 		}
 
@@ -234,7 +235,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 	/* Default behaviour for isolcpus without flags */
 	if (!flags)
-		flags |= HK_FLAG_DOMAIN;
+		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 
 	return housekeeping_setup(str, flags);
 }
-- 
2.51.0


