Return-Path: <linux-kernel+bounces-772737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9490B296F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CF93BCB05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88C25484B;
	Mon, 18 Aug 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H6PLsc0k"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3925392C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483879; cv=none; b=WbhxxKuXLporHB9pQkIrLWycQkKOumamCrvMUqC5MkKjZ12dIgKe86D06jvowdA47KiM2uY2US6i22/meZBAI9MSRPBmMCtRb2uBEcI7tB8tpz4Hh7cPzF+wqwjYv3bILlTdUgAdxFkFVOX0ljgl37A4gf7ZokHHsQZOgOofhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483879; c=relaxed/simple;
	bh=l1zppUoGsgYQuvWfeE9ZII+mvExfI8uZ5tf9ENz9M9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WuKTiZHGK9wCPhooHp+CM0+K58BgR9mzHSOnHvak9ccn1D8HX678jPNQZRk+hiWn/Nd2Q47GqKWsDWpx32oTeFkgLOvtMhHoBLNgFl7ET6SERroMfVAHW9On9vGSTq70FpyC+jrFFUJQf1gXagoLa9AGl++Wv8UigVsr426wXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H6PLsc0k; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250818022435epoutp047767b31e857cca3c12da9ee6ae4c0fcd~cu0iWRf9e2896428964epoutp04r
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:24:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250818022435epoutp047767b31e857cca3c12da9ee6ae4c0fcd~cu0iWRf9e2896428964epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755483875;
	bh=iF7XGLKPcudkWLwpYz/z12ZVFINWFvDEkKGpP/Zh/5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6PLsc0k88J2COkoanK5Vft9WABSgOSO3zR0u4+q/N1NUI47saqrGEYR+0KDxyik1
	 t0KsP588+QQ15pN3yDaL5DOoQgAHjYbAOIC6DZ7BkmEe/kPxQqyAuYmtz4Gg7RxqlS
	 EQ2OTsaTh8cUOHFk9pTuP4w1CWOQxFlfQ0G7B4SI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250818022434epcas2p1aa372480dd5834f5b2f2e63737219b49~cu0h1Any60956809568epcas2p15;
	Mon, 18 Aug 2025 02:24:34 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c4xPG0fpfz2SSKh; Mon, 18 Aug
	2025 02:24:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250818022433epcas2p2a14d0a2ebe8c421dc63ddc8371f8bc50~cu0gr7DFt3096330963epcas2p2y;
	Mon, 18 Aug 2025 02:24:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.229.9.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250818022433epsmtip1b7f6a2586034e6291a0000e252656057~cu0glYO2z2174121741epsmtip1N;
	Mon, 18 Aug 2025 02:24:33 +0000 (GMT)
From: Sangwook Shin <sw617.shin@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org,
	linux@roeck-us.net, semen.protsenko@linaro.org, dongil01.park@samsung.com,
	khwan.seo@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Sangwook Shin
	<sw617.shin@samsung.com>
Subject: [PATCH v6 1/5] watchdog: s3c2410_wdt: Replace hardcoded values with
 macro definitions
Date: Mon, 18 Aug 2025 11:18:22 +0900
Message-Id: <20250818021826.623830-2-sw617.shin@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818021826.623830-1-sw617.shin@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250818022433epcas2p2a14d0a2ebe8c421dc63ddc8371f8bc50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250818022433epcas2p2a14d0a2ebe8c421dc63ddc8371f8bc50
References: <20250818021826.623830-1-sw617.shin@samsung.com>
	<CGME20250818022433epcas2p2a14d0a2ebe8c421dc63ddc8371f8bc50@epcas2p2.samsung.com>

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


