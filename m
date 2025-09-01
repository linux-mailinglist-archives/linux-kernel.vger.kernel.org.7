Return-Path: <linux-kernel+bounces-794291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42EB3DFAC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503AE188ABF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F083112DF;
	Mon,  1 Sep 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="euZIGU+W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QIlrpxbE"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110431062C;
	Mon,  1 Sep 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721105; cv=none; b=ld4HW2VUQnA11jdW5bLHY5ChOpHc0J7lTtvR2XZAX3O5kSTKPCGdoCrX95CGgMvdVV/Mi/8DUmdfBBZ/Ak6YClUmD99+IpziI7HwgyRKQ8O4c8hkzL0P6gekFyI29YhlE3UWsrVPIg9mJNDaeHfB8lka+4Q8Nxtu/JMjN8pFv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721105; c=relaxed/simple;
	bh=9iCEW9ajwL4/SXjhbjcIslU6VBGd1JqXs9Hzs/eCF40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BECWGZR+ZnFniI0wWPqAXQSG5/E9dVFVb4kHI4in8gsvzLUorr3s+3Rpi1kZFXodAuvpdbhjg3Jm1vSf6jd3RR5tyMV/6jXuPLJtuMyRiMg9fufkt3Z7ZVUENvo5xafkKmkV2Q5PCoPyb+j9aQNE58IuQPiWMUkSQzL/RbERxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=euZIGU+W; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QIlrpxbE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756721103; x=1788257103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pvs8350FZrxwBnqnkvx08YGeQyjKhwj9ElyMOBOm5qk=;
  b=euZIGU+WgNcOefQimS3aMl6UQ1hws0HHOYQMTtBKZGxTbH82+2acT+LM
   jnnX6yHYwvbr6EEB6eJq3YjSxwtHcAo15ZJmyUS/Zi5/5oqzJUKcRf7a5
   PUPtu1vkBiYfG1zeYpgucLJtXqzVwN2iNlUHdiGUkX1etk/CH6AK6k4iS
   HfVxQ7BiuqTuEWgbchGdUxwYp/cA0Tp0xWAfp4RLHI2Ia9ecI8BWBvute
   5JgrXnFFOTIEdFVH+aAdK8A9+sCW48Bl/IxuuVf4f9qWxabiHWfHsqXxO
   pVnlLgi7KhYkFu0284qNtlJha3Gk2iddTdU6P7BkgIEtmn7XeQv14Fdu0
   A==;
X-CSE-ConnectionGUID: FgzPcpssSvmPFu5NPxH+mg==
X-CSE-MsgGUID: b7IrLCzIR+GoNMJPJVpGAg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="46004685"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Sep 2025 12:04:54 +0200
X-CheckPoint: {68B56FC6-19-9821D066-F5C64F68}
X-MAIL-CPID: 88A8AB47C7CBFF3E8C2043CFAE755D90_2
X-Control-Analysis: str=0001.0A00210D.68B56F64.0063,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7516165AA3;
	Mon,  1 Sep 2025 12:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756721090; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pvs8350FZrxwBnqnkvx08YGeQyjKhwj9ElyMOBOm5qk=;
	b=QIlrpxbEeu1QHO2DvCXxe16cISymPAm0umc7j/LIxN84QcfmQl/9dFP7UMMMdC3s96CC4P
	g2xOsNVciHe/25Md4WleOBzDiwVwAtKLqcqmou5HFMdAujdfBFI9yyI4eSAckG4nvIwFxB
	d04HKIFWqrhFwszu+ES4nQIM4/yR1zkFncW5wZnfas2eDz4ElMTVSOl/8wcmMRBaW63jkr
	vivwlnwejqjHc+a3TFrW7gsyKh/87qIUgDz2RdhvapF4FgfyQLEvAGkQFAZDPMJyDLq350
	PWJy2bbS5rQ7IFp3Ph16Qtw/UcH1mqruhPx+cYR6UJNr1+EIe8TB8BmP1j3MoA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add TQMa91xx SOM series
Date: Mon,  1 Sep 2025 12:04:29 +0200
Message-ID: <20250901100432.139163-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901100432.139163-1-alexander.stein@ew.tq-group.com>
References: <20250901100432.139163-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQMa91xx series is using NXP i.MX91 CPU on an LGA or socketable type board.
MBa91xxCA is a starterkit base board for TQMa91xx on an adapter board.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* TQMa91xx series includes both CA & LA variant (socket & LGA)
  adjust commit message accordingly

 Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ebafa6ecbcb64..0843c5e9275be 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1433,6 +1433,24 @@ properties:
               - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
           - const: fsl,imxrt1170
 
+      - description:
+          TQMa91xxLA and TQMa91xxCA are two series of feature compatible SOM
+          using NXP i.MX91 SOC in 11x11 mm package.
+          TQMa91xxLA is designed to be soldered on different carrier boards.
+          TQMa91xxCA is a compatible variant using board to board connectors.
+          All SOM and CPU variants use the same device tree hence only one
+          compatible is needed. Bootloader disables all features not present
+          in the assembled SOC.
+          MBa91xxCA mainboard can be used as starterkit for the SOM
+          soldered on an adapter board or for the connector variant
+          MBa91xxLA mainboard is a single board computer using the solderable
+          SOM variant
+        items:
+          - enum:
+              - tq,imx91-tqma9131-mba91xxca # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM on MBa91xxCA
+          - const: tq,imx91-tqma9131        # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM
+          - const: fsl,imx91
+
       - description:
           TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
           using NXP i.MX93 SOC in 11x11 mm package.
-- 
2.43.0


