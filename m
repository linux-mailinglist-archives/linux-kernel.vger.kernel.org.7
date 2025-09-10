Return-Path: <linux-kernel+bounces-809610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F735B50FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1B445B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDB30C37D;
	Wed, 10 Sep 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g1K7H1SU"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B330CD92
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490192; cv=none; b=NKj1BzXTe+lG/9ZQ5t9V1uVaHZNL9gLKAH7XbxHR+0pkr2ZEIr/3VAg0s167ktRIy1Iay6lyyulxT53D6lPfHA+ePIUVxkYjHyEsy/iDVpEFE8DEMAL1O7+zwaCpxiz5xaz5tBqDiw3qpD/xq9E8fcUaOEe4Hyp2zYBv2sZ8QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490192; c=relaxed/simple;
	bh=oYh90tcsDpw7CrDcG/7P8GueqMyroIAKQgKmfVUY8Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=g5ScFDzL+JFBZWzo2yvcnZ/V++5H96S7reaxhCHSyTKbjwJZwiGbUTS7q2EdWVwXNHtseAbW6UwIZGNONFrjsmhsXsQBjBbYnMwjwtR4TUCK11Hp53OERj0jK1Heh2ICgmEmSAKexxN3iXNPTT4g2pLiL1231F9f1FwKlH7zvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g1K7H1SU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250910074302epoutp0122706ffc51a65e6622092f089ab31734~j3AJeCKDl2707527075epoutp01F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250910074302epoutp0122706ffc51a65e6622092f089ab31734~j3AJeCKDl2707527075epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757490182;
	bh=9expbpYhVgObgPfAlnk7ZtalLHtzPTqZxjjfHnnvWUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1K7H1SU6dBatpr+nVZDuSvnVweadziYubv6VvWrbYUdErO4isxWKjE+t0m0F2S7x
	 xRokdIcLB6iGJH15yqGdvwYcQbZPDH81bkB30udnnuLew5+5vIYbwn93CXEq/CTb8o
	 3dHLk7pm9lzCCOM94o2JASGFp75N07/5luOOzJKg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250910074301epcas2p4adda38d3e6226f46dd5097b221807b46~j3AIfxcA_0054800548epcas2p4W;
	Wed, 10 Sep 2025 07:43:01 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.101]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cMCN44DMnz6B9mS; Wed, 10 Sep
	2025 07:43:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250910074259epcas2p294790d53f9e2c7a7b9ecea003ad66092~j3AHRKlPC2105321053epcas2p2P;
	Wed, 10 Sep 2025 07:42:59 +0000 (GMT)
Received: from KORCO190374.samsungds.net (unknown [12.36.160.50]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250910074259epsmtip14649612a61786e5a6a1da6aee4d8f6af~j3AHOfeQs2861828618epsmtip1O;
	Wed, 10 Sep 2025 07:42:59 +0000 (GMT)
From: Sehee Jeong <sehee1.jeong@samsung.com>
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	sehee1.jeong@samsung.com
Subject: [PATCH v2 1/1] timers/migration: add 'tmigr' kernel parameter to
 optionally disable timer migration
Date: Wed, 10 Sep 2025 16:42:51 +0900
Message-Id: <20250910074251.8148-2-sehee1.jeong@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910074251.8148-1-sehee1.jeong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250910074259epcas2p294790d53f9e2c7a7b9ecea003ad66092
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250910074259epcas2p294790d53f9e2c7a7b9ecea003ad66092
References: <20250910074251.8148-1-sehee1.jeong@samsung.com>
	<CGME20250910074259epcas2p294790d53f9e2c7a7b9ecea003ad66092@epcas2p2.samsung.com>

On heterogeneous systems with big.LITTLE architectures, timer migration
may cause timers from little cores to run on big cores, or vice versa,
because core type differences are not considered in the current timer
migration logic. This can be undesirable in systems that require
strict power management.

For example, if timers are frequently migrated to a big CPU, it must
handle callbacks that could have run on a little CPU. This reduces the
big CPU's idle residency and increases overall energy consumption due to
higher power draw on the big CPU.

To avoid this issue, introduce an early boot parameter to optionally
disable timer migration:

    tmigr=on|off	(default: on)

When set to "off", timer migration initialization is skipped entirely.

Signed-off-by: Sehee Jeong <sehee1.jeong@samsung.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++++
 kernel/time/timer_migration.c                 | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ab4c049faba9..0f5d42c046bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6783,6 +6783,10 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
+	tmigr		[KNL,EARLY] Enable/disable timer migration
+			Valid parameters: on, off
+			Default: on
+
 	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 72538baa7a1f..00e3740aec98 100644
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
@@ -1854,3 +1859,17 @@ static int __init tmigr_init(void)
 	return ret;
 }
 early_initcall(tmigr_init);
+
+static int __init tmigr_setup(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (!strcmp(str, "off"))
+		tmigr_enabled = false;
+	else if (!strcmp(str, "on"))
+		tmigr_enabled = true;
+
+	return 0;
+}
+early_param("tmigr", tmigr_setup);
-- 
2.49.0


