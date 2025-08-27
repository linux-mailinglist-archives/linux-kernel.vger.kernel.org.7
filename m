Return-Path: <linux-kernel+bounces-787668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72061B3796C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779733664FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBEE30BBA7;
	Wed, 27 Aug 2025 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qqeX1/48"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569B30ACFA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270752; cv=none; b=u0XM9GOLZEazXQl1sqCh8V/HMyc7ZU6+ccTszTf52SlV+yBcfSl26mm8yAoc53cXYrR0NVTOyslAS3AHoM+LmcnWV6Nb8bzptO0PjNfD5kBaTtwIxAT8dRoAzJ1EmxjxCs3o6BFckw6F8gOBbbAa5Izfmaa0axM6YvRNdlgFf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270752; c=relaxed/simple;
	bh=jsRlyv6DKUvikuFJeohexYKL2CdD1pyDT+k65CB5tWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qks+5Zd2ef5bbiHMtU/CrMoxM7YOe2UVxEKIC7yf38U1MCh3WiNKbCp8l0SErv+wO2V+Yqe/Bosq+SihrnOwe6YTGNJR7jFOf/Mo51Kure8CtKvwZmdZ30pXHF/DvSpbKDYvMKLZZCrQmpSQfXauZaBgKIsoovhxhHPHrkqgh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qqeX1/48; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250827045907epoutp034d37e237d422a4eb6920ac4ff092bcfe~fhvCjjsRP2000120001epoutp03K
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:59:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250827045907epoutp034d37e237d422a4eb6920ac4ff092bcfe~fhvCjjsRP2000120001epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756270747;
	bh=8oixCpq4frQkHJU5kPDWHHO8FnB0bWWAyMSsLl8RP6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqeX1/48myY0kVClgM04MOHYWrhW8F/qrchPTWqSl6c4kWaC7c3nNK90Z1jSVzLnl
	 ekDDPBcjuFdjGAI1eABnCrmT2+XuXWT3WEu2qkDJs57VKik1fcxhGntrE1g0/ZP1Ga
	 NTa3VzzLbipMV2op+0JBsXeCfgJ9exYCXlcTpNLw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250827045907epcas2p14cd817aeb803e37481873e88e923355a~fhvCCg1GE1186511865epcas2p1f;
	Wed, 27 Aug 2025 04:59:07 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cBXPQ25Hmz3hhTD; Wed, 27 Aug
	2025 04:59:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250827045905epcas2p4b2cbd4b881af1c1be4b345861d1a635b~fhvAflIe82320923209epcas2p4t;
	Wed, 27 Aug 2025 04:59:05 +0000 (GMT)
Received: from mclaren.dsn.sec.samsung.com (unknown [10.229.9.108]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250827045905epsmtip2009f0b11b3909a6cc82fa31a646beeb5~fhvASaS5H1855818558epsmtip2h;
	Wed, 27 Aug 2025 04:59:05 +0000 (GMT)
From: Kisung Lee <kiisung.lee@samsung.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Inki Dae <inki.dae@samsung.com>
Cc: Kisung Lee <kiisung.lee@samsung.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: soc: samsung: scaler: exynos: Add
 ExynosAutov920 compatible
Date: Wed, 27 Aug 2025 04:47:17 +0000
Message-ID: <20250827044720.3751272-2-kiisung.lee@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827044720.3751272-1-kiisung.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250827045905epcas2p4b2cbd4b881af1c1be4b345861d1a635b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250827045905epcas2p4b2cbd4b881af1c1be4b345861d1a635b
References: <20250827044720.3751272-1-kiisung.lee@samsung.com>
	<CGME20250827045905epcas2p4b2cbd4b881af1c1be4b345861d1a635b@epcas2p4.samsung.com>

Add samsung,exynos5-scaler compatible for ExynosAutov920 SoC.

Signed-off-by: Kisung Lee <kiisung.lee@samsung.com>
---
 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
index 9fb530e65d0e..5a472e29dc8a 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - samsung,exynos5420-scaler
       - samsung,exynos5433-scaler
+      - samsung,exynos5-scaler
 
   reg:
     maxItems: 1
-- 
2.25.1


