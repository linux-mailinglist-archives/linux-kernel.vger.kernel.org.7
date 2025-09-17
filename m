Return-Path: <linux-kernel+bounces-820114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA8B7F2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA824885E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05122F25E6;
	Wed, 17 Sep 2025 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IkhBcOsO"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606072DEA8F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093237; cv=none; b=S3s6/98iQiqjZ+r0W+zZJKSYLV9weUAWPpo/LDwSp5Xr0Q84wZNuXfLbIP+JOdcq+3klSQPNuce9v4E2AY/d55lLQgDu2hc1oV7wXg3HSs/+ZHtwNcfG8+4nItqBIdCQxZz6+T/VmtuaVlpguT7SIbRvhUhaAGSJ9de+PmaY96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093237; c=relaxed/simple;
	bh=Pw6SwIvC5HR9FxU8AOn+X7vEoKNviSLnMBUiSV7KSE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RhBe6u852wPCnJaHa3NIq6vN8gN1AqLLOpkxSPFp0jNPGcC7I5vE1Uh12X8eUNVNJFDgS4mAA7QvWdEZf9WlBHOy8/seDBFpS2dWtoG4Ao0+IFD8RPCjYQ6XxyLTIQVKOPO+wQRA7TZWqTYkKtOGF7XIqQb/k5L3BBLAGdXxrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IkhBcOsO; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250917071353epoutp0413d53756bf012e7072a76a54f0c8e031~mAHslXJ5p0063000630epoutp04F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250917071353epoutp0413d53756bf012e7072a76a54f0c8e031~mAHslXJ5p0063000630epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758093233;
	bh=fRXYlmwUu6J4W4Dm8/+PyXnDw1pO78eFLKDecT7iP3Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IkhBcOsO1SthYRbXoWHJz+2L9H/I4JO0BLwsHti1vnokQ98mdeefJSKq5BNsaqMRP
	 1Z5ros+Sq4hwj/GzIREwGGDFQEJPo5R/UzLlout+Ag5yhshDFoBy7HJquWG9T9jjmC
	 xL/HCImsuYxb2uxIqo6AKs+BMa5tXZ+p07oZZbTQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250917071352epcas5p1c5e369c59b060161eb5975ca16bb60cd~mAHrjoBOM3047430474epcas5p1R;
	Wed, 17 Sep 2025 07:13:52 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cRVPC1nfxz6B9mF; Wed, 17 Sep
	2025 07:13:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb~mAHqCzFfd1682016820epcas5p3x;
	Wed, 17 Sep 2025 07:13:50 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917071347epsmtip206f2559e389a17ba327d8aef0e18009d~mAHnOrkgR3178131781epsmtip2e;
	Wed, 17 Sep 2025 07:13:47 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, ksk4725@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, bread@coasia.com, jspark@coasia.com,
	limjh0823@coasia.com, lightwise@coasia.com, hgkim05@coasia.com,
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH] dt-bindings: serial: samsung: Add compatible for ARTPEC-9
 SoC
Date: Wed, 17 Sep 2025 12:43:42 +0530
Message-ID: <20250917071342.5637-1-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb
References: <CGME20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb@epcas5p3.samsung.com>

Add Axis ARTPEC-9 uart compatible to the bindings documentation.
It is similar to the older samsung,exynos8895-uart design.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5364..3895049c954c 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -48,6 +48,7 @@ properties:
           - const: samsung,exynos850-uart
       - items:
           - enum:
+              - axis,artpec9-uart
               - samsung,exynos7870-uart
           - const: samsung,exynos8895-uart

@@ -168,6 +169,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec9-uart
               - google,gs101-uart
               - samsung,exynos8895-uart
     then:
--
2.17.1


