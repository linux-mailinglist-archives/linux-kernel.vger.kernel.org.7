Return-Path: <linux-kernel+bounces-758953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C225BB1D625
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C7A18C45C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF52777FD;
	Thu,  7 Aug 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XshrS32s"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43F27A10F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564034; cv=none; b=QDDTASuc5KjcCBlUJ4o5C8yG7jy7bz0+6vMDwNpLxdnl+fIy0LojKXh4my2aku/NcQ7E5pctAwmyZCmTnsE91FcxvUpN9UizmoAiZD8QE6z+4KaYatkzZz0kTz4E5lvnctgUsJhSwm0CU0XAxyhxjRmqKlUIq+xKpsYjli2g9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564034; c=relaxed/simple;
	bh=mO7KKyVbAAB6LIeT63La3wZfx8885Z7ITq97oad3Rsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=RVuEMAcmkh5MfFbVkQj+dcTiXTz+toIPabkExbLNj7iQUEggFoPnnwPkiTTaa7SVkInxDgxFTKuML3aAxvSOVdg4FiBlPFw7+WWa3pbogGGJtVeQVE98dKhp3ryo8yX5Vaz5mrHydQYqoynLlwdyYasBK3ivifq/9EIAzDqzvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XshrS32s; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250807105349epoutp0130629c86d81f625dd00634bc3f7165fa~ZdrBsrOUG1288612886epoutp01x
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:53:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250807105349epoutp0130629c86d81f625dd00634bc3f7165fa~ZdrBsrOUG1288612886epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754564029;
	bh=68xVvjXbi6ynymUb0K2pHdKhGYhDNv+h3kRgipI5AtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XshrS32skeKcznLRlgfF713BvYRbidj0KlEfhs5Y8CFtBRQEfp1D/Ehxl5daV4YJ4
	 2k9oWP/8zvFBYRIiCbRdhzvBhdx1ucKBpHnbDusJWQG6SOw1jnztsoPwx9RklmlEbR
	 TNtRe/Qhm7DdMuzGo6bPlfmVR6UytBqMp0bquJt0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250807105348epcas5p3065541de7991a0705ff5e9059865079e~ZdrAxgdxa2228622286epcas5p3Z;
	Thu,  7 Aug 2025 10:53:48 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4byPCv6Z6Zz3hhT3; Thu,  7 Aug
	2025 10:53:47 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250807032527epcas5p488b0eed9dcb260cad4f864d9ec6e8477~ZXjjK2EY50583105831epcas5p4M;
	Thu,  7 Aug 2025 03:25:27 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250807032525epsmtip212df53bafdf0fb26bd25845d81d27973~ZXjhND0eV1700017000epsmtip2j;
	Thu,  7 Aug 2025 03:25:25 +0000 (GMT)
From: Aakarsh Jain <aakarsh.jain@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	andrzej.hajda@intel.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
	alim.akhtar@samsung.com, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, aswani.reddy@samsung.com,
	anindya.sg@samsung.com, Aakarsh Jain <aakarsh.jain@samsung.com>
Subject: [PATCH 10/10] dt-bindings: media: s5p-mfc: Add SoC-specific
 compatible for 'samsung,mfc-v5'
Date: Thu,  7 Aug 2025 08:54:49 +0530
Message-ID: <20250807032449.92770-11-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807032449.92770-1-aakarsh.jain@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250807032527epcas5p488b0eed9dcb260cad4f864d9ec6e8477
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250807032527epcas5p488b0eed9dcb260cad4f864d9ec6e8477
References: <20250807032449.92770-1-aakarsh.jain@samsung.com>
	<CGME20250807032527epcas5p488b0eed9dcb260cad4f864d9ec6e8477@epcas5p4.samsung.com>

'samsung,mfc-v5' compatible string was getting used for both S5pv210
and Exynos4 SoC. Based on SoC-specific, modify existing 'samsung,mfc-v5'
compatible to 'samsung,exynos4-mfc'. Add new compatible for s5pv210.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../devicetree/bindings/media/samsung,s5p-mfc.yaml     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 6a711c8103ac..922b1de66736 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -18,10 +18,11 @@ properties:
   compatible:
     oneOf:
       - enum:
-          - samsung,exynos5433-mfc        # Exynos5433
-          - samsung,mfc-v5                # Exynos4
+          - samsung,s5pv210-mfc           # S5pv210
+          - samsung,exynos4-mfc           # Exynos4
           - samsung,exynos5250-mfc        # Exynos5
           - samsung,exynos5420-mfc        # Exynos5420
+          - samsung,exynos5433-mfc        # Exynos5433
           - samsung,exynos5800-mfc        # Exynos5800
           - samsung,exynos7880-mfc        # Exynos7880
           - tesla,fsd-mfc                 # Tesla FSD
@@ -114,7 +115,8 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,mfc-v5
+              - samsung,s5pv210-mfc
+              - samsung,exynos4-mfc
     then:
       properties:
         clocks:
@@ -184,7 +186,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     codec@13400000 {
-        compatible = "samsung,mfc-v5";
+        compatible = "samsung,exynos4-mfc";
         reg = <0x13400000 0x10000>;
         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&pd_mfc>;
-- 
2.49.0


