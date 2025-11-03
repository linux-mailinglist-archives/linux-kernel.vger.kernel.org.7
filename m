Return-Path: <linux-kernel+bounces-882305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A08C2A21F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC4188EB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC2284684;
	Mon,  3 Nov 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="E7lCV6Gc"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF134D3A5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149738; cv=none; b=JdW2iWlN1ozTLvac91AN95wuIwmbDuccCIaRbdsZY89PmGaswTcOrrneYpihIHncrJlPuxiw+8coLNGQPa9zJZcm7iWBhIT0WdGVIvCnr78ZWJcMAn1lh8kLPiI44aObSztVpqMTDQyhwA6hEIWCABUErgdaN2AKuP0Q6vLWd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149738; c=relaxed/simple;
	bh=qpTk63b8UNhEFbL6yqmiSO4xwNn6qG1Tf0fryxb9Olg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pBzgfW3RQo2UgL47HiMS0j9WXd8QJl3yPWB/hHKlJo6nA1FVjp1VJiGMpAoNxpZf4cVd6sfONnQPgYL/GR4DEXmjNVLyYN7BBmA05HaRDaQlXL8PM1CrcKoVDPAn1UXOUxQvyRBUrz+AGWrwAuTj+OmEUdlrrM4h6YIy1hsZjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=E7lCV6Gc; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=6a5rZNRIcqhtRVQ
	o7Y7bKRtnLNapuGFcysX/6/9ZQ28=; b=E7lCV6GcBnBKP43pK0jUXwz4nmPZSXX
	jnYiq5KRm6wH51vSlqYkyED6CqYWeGqgJn+mJctk6WA2uv86MvB9kTchb0Hjp91/
	5UM2bj8c+ITR0b6q1DehENvUthmJHJ98nFNw3Ui22bU0Hsdibis3fML3BJryObeE
	np0E0VZrPwxY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHP7+3QghpWx45AQ--.11630S2;
	Mon, 03 Nov 2025 13:50:48 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	lw520203 <1823363429@qq.com>,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] PINCTRL: ENABLE_CONFIG_PINCTRL_INTEL
Date: Mon,  3 Nov 2025 13:50:44 +0800
Message-Id: <20251103055044.12207-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBHP7+3QghpWx45AQ--.11630S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45GrykAr4UZFy3Ar47Jwb_yoW8uw17pF
	1fAw43WFWkJr1UtrWj9F1kWr98twnrZ34UCrs8Ar1vvr4xA3yfJryktr1kJryUW3y7Gr4r
	Was3WF13ZFyjv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zET5lxUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWAX6xWkIPK97DwAAsk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: lw520203 <1823363429@qq.com>

huawei inclusion
category: feature
bugzilla: https://gitee.com/src-openeuler/calamares/issues/IBS0LG
CVE: NA

----------------------------------------------------------

This commit is enable CONFIG_PINCTRL to fix touchpad malfunction

Signed-off-by: lw520203 <1823363429@qq.com>

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 arch/x86/configs/openeuler_defconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/configs/openeuler_defconfig b/arch/x86/configs/openeuler_defconfig
index 6ece34678378..d5d3307a9290 100644
--- a/arch/x86/configs/openeuler_defconfig
+++ b/arch/x86/configs/openeuler_defconfig
@@ -1932,7 +1932,7 @@ CONFIG_BT_HCIBTUSB=m
 CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
 CONFIG_BT_HCIBTUSB_POLL_SYNC=y
 CONFIG_BT_HCIBTUSB_BCM=y
-# CONFIG_BT_HCIBTUSB_MTK is not set
+CONFIG_BT_HCIBTUSB_MTK=y
 CONFIG_BT_HCIBTUSB_RTL=y
 CONFIG_BT_HCIBTSDIO=m
 CONFIG_BT_HCIUART=m
@@ -4166,24 +4166,24 @@ CONFIG_PINCTRL_AMD=y
 # Intel pinctrl drivers
 #
 CONFIG_PINCTRL_BAYTRAIL=y
-# CONFIG_PINCTRL_CHERRYVIEW is not set
-# CONFIG_PINCTRL_LYNXPOINT is not set
+CONFIG_PINCTRL_CHERRYVIEW=y
+CONFIG_PINCTRL_LYNXPOINT=m
 CONFIG_PINCTRL_INTEL=y
-# CONFIG_PINCTRL_ALDERLAKE is not set
+CONFIG_PINCTRL_ALDERLAKE=m
 CONFIG_PINCTRL_BROXTON=m
 CONFIG_PINCTRL_CANNONLAKE=m
 CONFIG_PINCTRL_CEDARFORK=m
 CONFIG_PINCTRL_DENVERTON=m
-# CONFIG_PINCTRL_ELKHARTLAKE is not set
+CONFIG_PINCTRL_ELKHARTLAKE=m
 CONFIG_PINCTRL_EMMITSBURG=m
 CONFIG_PINCTRL_GEMINILAKE=m
 CONFIG_PINCTRL_ICELAKE=m
-# CONFIG_PINCTRL_JASPERLAKE is not set
-# CONFIG_PINCTRL_LAKEFIELD is not set
+CONFIG_PINCTRL_JASPERLAKE=m
+CONFIG_PINCTRL_LAKEFIELD=m
 CONFIG_PINCTRL_LEWISBURG=m
-# CONFIG_PINCTRL_METEORLAKE is not set
+CONFIG_PINCTRL_METEORLAKE=m
 CONFIG_PINCTRL_SUNRISEPOINT=m
-# CONFIG_PINCTRL_TIGERLAKE is not set
+CONFIG_PINCTRL_TIGERLAKE=m
 # end of Intel pinctrl drivers
 
 CONFIG_PINCTRL_ZHAOXIN=m
-- 
2.17.1


