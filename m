Return-Path: <linux-kernel+bounces-729420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F82B03659
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F15172195
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355E213E7B;
	Mon, 14 Jul 2025 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J2JO1dvE"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2720D4FF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752472743; cv=none; b=hTg+EBKa4buX4reprCI05oj88KnPY4K0R2xJlrlvM9M53OC9g17omgtSeXjY5ouOTEeOAYFEt9yMn4mQmqLX/ygpjpomYxMtWOxC6oxlm0ohHWJgtxjEsNCBCGRYzBUhELeXcnYYSXUKhpqY7pfYPZTAecztKfAr/XUGV1Gx2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752472743; c=relaxed/simple;
	bh=ZX4Sj/8gihZS0yNpxG9qjEZ9uV/DMHh10wMZ7nATLxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=EmtHhrkWOyAsquoAFr/8qKgfziRSqIKYitsNkCdBHaM4swdSxUhRcFUtysAOdIO57TGbda+gZxfUOAwSXn1/ITKDdrvnRxH4JMq1QXJYcdxo6LfmDLXVvekvFQaHocX+uIQME/QBAQNL5MHFAGW5CsRI98+0jvVic0ce7OYeczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J2JO1dvE; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250714055858epoutp03772c9bcf47b527dc9436c0feef20f2e7~SCKvOChmz1536815368epoutp03g
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250714055858epoutp03772c9bcf47b527dc9436c0feef20f2e7~SCKvOChmz1536815368epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752472739;
	bh=Pbi2ramR8l7UZqKCJOrdKuItlZX/GmKvNFxVQLDc/nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2JO1dvEnxsmltSfd2BEwtKYDopCRx7wOpcxpHl/urO63Z+rDYaoRZL0eSFNAzClG
	 gXtb7QzZSn0hkKftKS56oMq5g9p7GSSs8g1+oBXkOPeH25oUtJAfd4/ZKxWTUaaXNh
	 0eEJz7NlfktPLhR6yTW2vPs2iFiqsw3FLUQIPeq0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250714055858epcas2p24a090b666afd311886f4e04b775007c9~SCKuyYWUf1914519145epcas2p26;
	Mon, 14 Jul 2025 05:58:58 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bgWpp1MZxz2SSKs; Mon, 14 Jul
	2025 05:58:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250714055857epcas2p18cb516424b84f972970eed1ac5726c54~SCKt5qB8F3217032170epcas2p1W;
	Mon, 14 Jul 2025 05:58:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.229.9.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250714055857epsmtip14b84532306385aa5f10258f158f9da0f~SCKt0fYvC0355503555epsmtip1Y;
	Mon, 14 Jul 2025 05:58:57 +0000 (GMT)
From: Sangwook Shin <sw617.shin@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Sangwook Shin
	<sw617.shin@samsung.com>
Subject: [PATCH v3 RESEND 2/5] watchdog: s3c2410_wdt: Fix max_timeout being
 calculated larger
Date: Mon, 14 Jul 2025 14:54:37 +0900
Message-Id: <20250714055440.3138135-3-sw617.shin@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250714055440.3138135-1-sw617.shin@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250714055857epcas2p18cb516424b84f972970eed1ac5726c54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250714055857epcas2p18cb516424b84f972970eed1ac5726c54
References: <20250714055440.3138135-1-sw617.shin@samsung.com>
	<CGME20250714055857epcas2p18cb516424b84f972970eed1ac5726c54@epcas2p1.samsung.com>

Fix the issue of max_timeout being calculated larger than actual value.
The calculation result of freq / (S3C2410_WTCON_PRESCALE_MAX + 1) /
S3C2410_WTCON_MAXDIV is smaller than the actual value because the remainder
is discarded during the calculation process. This leads to a larger
calculated value for max_timeout compared to the actual settable value.
A ceiling operation is applied in the calculation process to resolve this.

Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 95f7207e390a..31f7e1ec779e 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -411,8 +411,8 @@ static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wdt)
 {
 	const unsigned long freq = s3c2410wdt_get_freq(wdt);
 
-	return S3C2410_WTCNT_MAXCNT / (freq / (S3C2410_WTCON_PRESCALE_MAX + 1)
-				       / S3C2410_WTCON_MAXDIV);
+	return S3C2410_WTCNT_MAXCNT / DIV_ROUND_UP(freq,
+		(S3C2410_WTCON_PRESCALE_MAX + 1) * S3C2410_WTCON_MAXDIV);
 }
 
 static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
-- 
2.25.1


