Return-Path: <linux-kernel+bounces-726987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20FEB013A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466485A1128
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CBC1DE8AE;
	Fri, 11 Jul 2025 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rrFWc25G"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16721DBB3A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215755; cv=none; b=ITmiWcMMjzSLYcME3N2/DAH0pqjpEue0MNZVQzH3gwa85eTm39gatL1yrLSSH57WBLm+4PiduHyRO9jpkW0TgHmM9hzNEe/zmgmOLvlEQiUSrxsFK3Kpz60KPbEhx98Un7X5gAgKd4B/5KdAmbhd9nqj2QHd4pMsYULAAWvQGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215755; c=relaxed/simple;
	bh=9cUGLw8eoDTkSdnHpo7uzjDyDXxI3QX782KtYf+IfVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KoN/ABmt6dYLdt0bJs83xdbCGbJSAwalijim5HOyOfBJdodxuobGZ6lcdAvRBx+CTvQUq9a0ZO8zI6EjjGj9PTMkQi7gdqId5rqJDa+e5wcR6XzUxAzJ6aUowbwFYrLiQ7DafhYSisWVwzsO5m7OYSu8Br4+2n5xnDPqz5olZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rrFWc25G; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250711063551epoutp02954bf66900396a6dfc512be2dfdd39d9~RHvFPEaOH1888318883epoutp02C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:35:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250711063551epoutp02954bf66900396a6dfc512be2dfdd39d9~RHvFPEaOH1888318883epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752215751;
	bh=z4l+MDSTZ2r2HMz/v67DtIs5pH+NnoP/SjYH2EZLuoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrFWc25Gnv/aHcMO8P2jNKyT9abbDHxg5+Kgm1MnN3XfxbtloZWfnvABqg/7grriv
	 s7SUT6P12iaj8bTJC9M+wcuejOpVCwuQMglzgI4jtrLZ/E1p2DR/Jpap/mGedF1/Uo
	 swn3Ok4aBh4Ckv7UlU2MiQGaKUkQRMlvi0pRT1Ts=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250711063551epcas5p298c51dca665271d9789048adfd7f6fd6~RHvEpdVV73228232282epcas5p2Z;
	Fri, 11 Jul 2025 06:35:51 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.176]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bdhmj1dqXz6B9mT; Fri, 11 Jul
	2025 06:35:49 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250710082534epcas5p40b49f5662ff36306349e6721fa9811fe~Q1ll7N7pz0133701337epcas5p4n;
	Thu, 10 Jul 2025 08:25:34 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710082533epsmtip13f65bde4bd8338ecd91d21a7064e403c~Q1lkcI3pM0630306303epsmtip1V;
	Thu, 10 Jul 2025 08:25:33 +0000 (GMT)
From: Devang Tailor <dev.tailor@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, alexandre.belloni@bootlin.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, faraz.ata@samsung.com
Cc: Devang Tailor <dev.tailor@samsung.com>
Subject: [PATCH v2 1/3] dt-bindings: rtc: s3c-rtc: add compatible for
 exynosautov9
Date: Thu, 10 Jul 2025 14:04:32 +0530
Message-Id: <20250710083434.1821671-2-dev.tailor@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710083434.1821671-1-dev.tailor@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710082534epcas5p40b49f5662ff36306349e6721fa9811fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710082534epcas5p40b49f5662ff36306349e6721fa9811fe
References: <20250710083434.1821671-1-dev.tailor@samsung.com>
	<CGME20250710082534epcas5p40b49f5662ff36306349e6721fa9811fe@epcas5p4.samsung.com>

Add "samsung,exynosautov9-rtc" dedicated compatible for
on-chip RTC found in ExynosAutov9 SoC.

Signed-off-by: Devang Tailor <dev.tailor@samsung.com>
---
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index bf4e11d6dffb..5daee2a5f866 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - samsung,exynosautov9-rtc
           - samsung,s3c2410-rtc
           - samsung,s3c2416-rtc
           - samsung,s3c2443-rtc
-- 
2.34.1


