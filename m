Return-Path: <linux-kernel+bounces-758687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4AB1D2A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12026725119
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE56226CEB;
	Thu,  7 Aug 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mNe57/tU"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6061DE3B7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549341; cv=none; b=j8xDBrVivjohmKI/aW03qKV8mKLOjVXeFMpdLkWZGXJ8iAPlwmsuAh+MVofZ+MD37KXWZDSOVe/NbLzD0zF51zDzQPZzoLhouZTZU9RYd/Pf5z165UeZ0UI7Do0cb+AB2xxuOGvANIf6mBnGVConSX/KaPWrEBwZGMHV7ixqbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549341; c=relaxed/simple;
	bh=T2LOZj2RtfSZDIETI52utHLg3XKuznfSzkCFMJ0ZTic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=gFgSvW5huKObpRL9sU3rWJRYSXpgIN4zhj1d9t4s0hpHBsjRBPOCGfu+QYlLrz6um70yXZFjqscwBpCTiHMJrF34UoiuZTX76aCd83Yv9IIEcEivPP50H0zDFxSp2eGhFSHWdep2O9JgWR5fDCWNx1ya/FfV4nFVmBUSmfuSrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mNe57/tU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250807064857epoutp03eba0cf3e646e5767cd13023bcdc2a9f5~ZaVN9QdPN2687526875epoutp03M
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250807064857epoutp03eba0cf3e646e5767cd13023bcdc2a9f5~ZaVN9QdPN2687526875epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754549337;
	bh=gENDsNiz8c+lxxAPMVk7aVyeTcOxXIGs6AZV1+YZ51s=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mNe57/tU/pkpeHIA/w22IzwnBAIiAD/Vb5hiCgjRhSxm0pXfxTY84eeFB3t+s2IAk
	 xG95X2WpztiwcjpPydSI8sjoH/J3+/Q6LD9dybVg6M9HrXTAX/J9+uZKuIuMZIU7ee
	 XKHJDsvcgNLMLP1vsoE7xqrLsn62jzDFDCESZcHc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250807064856epcas2p2a0239ad0d28d0f1d67f99a43b4faad8f~ZaVNb1MxW1997719977epcas2p2R;
	Thu,  7 Aug 2025 06:48:56 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.68]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4byHnN07Dpz6B9m6; Thu,  7 Aug
	2025 06:48:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250807064855epcas2p3079c241a4da07d478e713021ca488d13~ZaVMTENSc0483604836epcas2p3v;
	Thu,  7 Aug 2025 06:48:55 +0000 (GMT)
Received: from KORCO190374.samsungds.net (unknown [12.36.160.50]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250807064855epsmtip24ef157fdff63cc127cb1ee87da5c8ebd~ZaVMQDcwW1335913359epsmtip2H;
	Thu,  7 Aug 2025 06:48:55 +0000 (GMT)
From: Sehee Jeong <sehee1.jeong@samsung.com>
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	sehee1.jeong@samsung.com
Subject: timers/migration: add 'notmigr' kernel parameter to disable timer
 migration
Date: Thu,  7 Aug 2025 15:48:49 +0900
Message-Id: <20250807064849.3988-1-sehee1.jeong@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250807064855epcas2p3079c241a4da07d478e713021ca488d13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250807064855epcas2p3079c241a4da07d478e713021ca488d13
References: <CGME20250807064855epcas2p3079c241a4da07d478e713021ca488d13@epcas2p3.samsung.com>

On heterogeneous systems with big.LITTLE architectures, timer migration
may cause timers from little cores to run on big cores, or vice versa,
because core type differences are not taken into account in the current
timer migration logic. This can be undesirable in systems that require
strict power management, predictable latency, or core isolation.

This patch does not attempt to solve the structural limitation,
but provides a workaround by introducing an optional early boot parameter:

    notmigr

When specified, timer migration initialization is skipped entirely.

Signed-off-by: Sehee Jeong <sehee1.jeong@samsung.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 kernel/time/timer_migration.c                   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 85c27c97b826..4bb10ac574e5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4132,6 +4132,8 @@
 	no_timer_check	[X86,APIC] Disables the code which tests for
 			broken timer IRQ sources.
 
+	notmigr 	[KNL,EARLY] Disable timer migration.
+
 	no_uaccess_flush
 	                [PPC,EARLY] Don't flush the L1-D cache after accessing user data.
 
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 72538baa7a1f..7636a1b3ae6b 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -422,6 +422,8 @@ static unsigned int tmigr_crossnode_level __read_mostly;
 
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
+static bool tmigr_enabled = true;
+
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
 
@@ -1790,6 +1792,9 @@ static int __init tmigr_init(void)
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP);
 
+	if (!tmigr_enabled)
+		return 0;
+
 	/* Nothing to do if running on UP */
 	if (ncpus == 1)
 		return 0;
@@ -1854,3 +1859,12 @@ static int __init tmigr_init(void)
 	return ret;
 }
 early_initcall(tmigr_init);
+
+static int __init notmigr(char *str)
+{
+	tmigr_enabled = false;
+
+	return 0;
+}
+
+early_param("notmigr", notmigr);
-- 
2.49.0


