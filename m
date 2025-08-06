Return-Path: <linux-kernel+bounces-757322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD00B1C0CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF731183577
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335D219313;
	Wed,  6 Aug 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r7dlNq/u"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960368821
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463636; cv=none; b=XuSmQ69l8MtRJiQHl5if/jo1g1HjqxQmJze7VH4Aeywnytp8m7h/wgau763Wna46VHSdeelzVEFQ/9VF3oCSkudtedJ8FmbktrLNpQfWSpjunpE8qsRJQ/2DgvIIbZomU8vWiUSU934OiBxtg2gyADpI4c/FgqpNCgfr9WpZJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463636; c=relaxed/simple;
	bh=l1zppUoGsgYQuvWfeE9ZII+mvExfI8uZ5tf9ENz9M9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JS0eiHNZFZJ5pTgkFhBnfCUO7OdWLhKNumc/Zb44BPGIkUvimdyL8II114eQN5VR50figbUDTMcoEMA4NoIzdVECKmvBCpQYSL1X/ftE90BCBEVu+r2SWmzlv5Xjohod+QZTXOQbAOerGG4183wExo38YZ+Ry2isx7CA+m+51iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r7dlNq/u; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250806070031epoutp02f7b8f795b46c68645384157426646143~ZG2CmWU9y0359403594epoutp02f
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:00:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250806070031epoutp02f7b8f795b46c68645384157426646143~ZG2CmWU9y0359403594epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754463631;
	bh=iF7XGLKPcudkWLwpYz/z12ZVFINWFvDEkKGpP/Zh/5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7dlNq/uMXoo3w1DXnptLLOpG3nzFYKhs0yXKGY8qmlXilOEPnRTo+vpoH94dBM/m
	 k9sCzy3cZUAwoE2iFddO75pSn21DgrER5HM99Sw4LHHBN56us/3oVMY1M4dkWGF0QV
	 mP1LNXjXi7Iyo/9NXPypXy2Hl5+NzXlngYfL4CgY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250806070031epcas2p17a262a7d137cb71fe22b980fbe93030a~ZG2COqlmH3143031430epcas2p1b;
	Wed,  6 Aug 2025 07:00:31 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.101]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bxh5B4c7Yz2SSKn; Wed,  6 Aug
	2025 07:00:30 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250806070029epcas2p3a937682ba1bdad1317ef62aab8f826ae~ZG2AzGAgf0509105091epcas2p3M;
	Wed,  6 Aug 2025 07:00:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.229.9.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806070029epsmtip225a7d2938714340a4c5feb1655141d0e~ZG2As9TKD1971119711epsmtip2V;
	Wed,  6 Aug 2025 07:00:29 +0000 (GMT)
From: Sangwook Shin <sw617.shin@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org,
	linux@roeck-us.net, semen.protsenko@linaro.org, dongil01.park@samsung.com,
	khwan.seo@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Sangwook Shin
	<sw617.shin@samsung.com>
Subject: [PATCH v5 1/5] watchdog: s3c2410_wdt: Replace hardcoded values with
 macro definitions
Date: Wed,  6 Aug 2025 15:55:10 +0900
Message-Id: <20250806065514.3688485-2-sw617.shin@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806065514.3688485-1-sw617.shin@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250806070029epcas2p3a937682ba1bdad1317ef62aab8f826ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250806070029epcas2p3a937682ba1bdad1317ef62aab8f826ae
References: <20250806065514.3688485-1-sw617.shin@samsung.com>
	<CGME20250806070029epcas2p3a937682ba1bdad1317ef62aab8f826ae@epcas2p3.samsung.com>

Modify the code to utilize macro-defined values instead of hardcoded
values. The value 0x100 in the s3c2410wdt_set_heartbeat function represents
S3C2410_WTCON_PRESCALE_MAX + 1, but it is hardcoded, making its meaning
difficult to understand and reducing code readability.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 40901bdac426..95f7207e390a 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -587,7 +587,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
 	if (count >= 0x10000) {
 		divisor = DIV_ROUND_UP(count, 0xffff);
 
-		if (divisor > 0x100) {
+		if (divisor > S3C2410_WTCON_PRESCALE_MAX + 1) {
 			dev_err(wdt->dev, "timeout %d too big\n", timeout);
 			return -EINVAL;
 		}
-- 
2.25.1


