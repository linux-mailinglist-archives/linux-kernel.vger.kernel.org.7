Return-Path: <linux-kernel+bounces-895722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D73C4EC43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1165D4FB85B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417623659F3;
	Tue, 11 Nov 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Nxjzr93o"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04915361DDF;
	Tue, 11 Nov 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874204; cv=none; b=Dl0hfKpt5Xc5oLWkjX9rsUGp1DxlsGwp6W66P1TRrg7euH4a+YU6Ged0E7oEmSsLh9x1v9yTNX8nh5VOCF6S+tfnaQAhlivrcUI12opx45RzT7oq21XcYQ0ItGREgqqHJ8q35Cj72pd4uw7xOqRaWYuI5XxFwlKJtXXfj4OTViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874204; c=relaxed/simple;
	bh=R5rNMknAEuBVx5Obbrtna1XjSJ6Rs4Z708KnFjzGOGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neVZGkr0obcLMl0VG1c3FsEVbASJRJjQ/2esQuZjdpF0+hTFFgy9M5xwbqVQ/mBb/N/k/4b1dA80NmgPkpxdntzpmVAgN9Ra+Fo0YpGcoaLQ7n+3JWdEG1mV00nEyrc2fekvd6KSxG2I/juFWNhdMAdwogq5SuUz+2tgC6AJcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Nxjzr93o; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id C7E08213E8;
	Tue, 11 Nov 2025 16:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762874192;
	bh=CNW6pVpgXkG7O+Kgp8YtS4/oYggLDHSWVvfCvakisrc=; h=From:To:Subject;
	b=Nxjzr93oD5jzSI9aeEOizp70cHgWsw4mpFSLTnz+AAN97vyqupIVxZh8PKYHOePxz
	 DlI2lM7UykQyj0+h81WyYw9nhhYOymdOi2KTj0ud5kHCdsW2h7/N+wcBSFCCvQGKw5
	 C+a3SJ52e2gtsK+30Wl6GmRjcM1scorM3HfnX1nfTRwfJR8j+WiueiHd7VJjfrLUng
	 tGGpkD4QWdj7WXSieKRymknOJidfbd6EK/WBpsAEk/4OaDKpYw2O6xZMdSANI5sTSD
	 3h3QZP/XRxN9+zXNcklUQfwX0ulwq8QpZ9jHAuR3XXTnYaRnVne9a0wSLzSk+iDUJj
	 0tJOHNlst3+Mw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add Toradex SMARC iMX95
Date: Tue, 11 Nov 2025 16:16:13 +0100
Message-ID: <20251111151618.70132-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111151618.70132-1-francesco@dolcini.it>
References: <20251111151618.70132-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add DT compatible strings for Toradex SMARC iMX95 SoM and
Toradex SMARC Development carrier board.

Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: Added acked-by conor
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 21b7168d61f5..ca42ddd95345 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1442,6 +1442,12 @@ properties:
           - const: phytec,imx95-phycore-fpsc  # phyCORE-i.MX 95 FPSC
           - const: fsl,imx95
 
+      - description: Toradex Boards with SMARC iMX95 Modules
+        items:
+          - const: toradex,smarc-imx95-dev # Toradex SMARC iMX95 on Toradex SMARC Development Board
+          - const: toradex,smarc-imx95     # Toradex SMARC iMX95 Module
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:
-- 
2.47.3


