Return-Path: <linux-kernel+bounces-873422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD9C13E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A21188EF35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBE3002C5;
	Tue, 28 Oct 2025 09:44:45 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD2176FB1;
	Tue, 28 Oct 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644685; cv=none; b=ggEtkIz7oSVJWUiMT1VSybMAoIWjv++Nae6bxzLlwvPlk5aav9RPyJgwlwm/rQsNSRkBlYq6TQgxQB2EBY4GLZx6kZjqMOb4llCA9vrsBhVxDZk9n88WdEnpLKaSwGLBf4Ks6qwLCwhrKr++jWLScf4EtzHooWZF/q18X36Vvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644685; c=relaxed/simple;
	bh=OB9YPbxCRmtSm3G4JSV74SWdWIsvBUkQAVn+6LOCmSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUyWJUOpSBIp35Xpq4XFWYcvG2mGORkRSEN6X5IWONXjawSQSvyL65flC8FrCrQugTDUmvi3QcyNqdZZQja6N9p98XfTrb0YatiwM/XKIl8cNdln5Dm6RwTxBLGaVvdZ+4PQ+JxN+DKJL7n6aCAMLs8wMzC8BKLZ00Eh5Vm7ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>
CC: <gpiccoli@igalia.com>, <peterz@infradead.org>,
	<davydov-max@yandex-team.ru>, <martin.petersen@oracle.com>,
	<jani.nikula@intel.com>, <joel.granados@kernel.org>, <xin@zytor.com>,
	<linux-doc@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH RESEND] x86/split_lock: Make split lock mitigation sleep duration configurable
Date: Tue, 28 Oct 2025 17:43:33 +0800
Message-ID: <20251028094333.49841-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Commit 727209376f49 ("x86/split_lock: Add sysctl to control the misery
mode") introduce a sysctl 'sysctl_sld_mitigate' to control the misery
mode for split lock detection (0 to disable, 1 to enable). However,
when enabled, the sleep duration for split lockers was fixed at 10 ms.

This patch extands 'sysctl_sld_mitigate' to allow configuring the sleep
duration in milliseconds. Now, when 'sysctl_sld_mitigate' is set to
N (N > 0), split lockers will sleep for N milliseconds.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
The last email wasn't delivered. So resend it.

 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 arch/x86/kernel/cpu/bus_lock.c              | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f3ee807b5d8b..92e34041ea73 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1472,8 +1472,8 @@ increase system exposure to denial of service attacks from split lock users.
 = ===================================================================
 0 Disable the mitigation mode - just warns the split lock on kernel log
   and exposes the system to denials of service from the split lockers.
-1 Enable the mitigation mode (this is the default) - penalizes the split
-  lockers with intentional performance degradation.
+N Enable the mitigation mode (default is 10) - penalizes the split lockers
+  by suspending their execution for N milliseconds.
 = ===================================================================
 
 
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 981f8b1f0792..a5f0ad1b5c24 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -46,7 +46,7 @@ static const struct {
 
 static struct ratelimit_state bld_ratelimit;
 
-static unsigned int sysctl_sld_mitigate = 1;
+static unsigned int sysctl_sld_mitigate = 10;
 static DEFINE_SEMAPHORE(buslock_sem, 1);
 
 #ifdef CONFIG_PROC_SYSCTL
@@ -58,7 +58,7 @@ static const struct ctl_table sld_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler	= proc_douintvec_minmax,
 		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.extra2         = SYSCTL_INT_MAX,
 	},
 };
 
@@ -252,9 +252,9 @@ static void split_lock_warn(unsigned long ip)
 	if (saved_sld_mitigate) {
 		/*
 		 * misery factor #1:
-		 * sleep 10ms before trying to execute split lock.
+		 * sleep 'saved_sld_mitigate' ms before trying to execute split lock.
 		 */
-		if (msleep_interruptible(10) > 0)
+		if (msleep_interruptible(saved_sld_mitigate) > 0)
 			return;
 		/*
 		 * Misery factor #2:
-- 
2.36.1


