Return-Path: <linux-kernel+bounces-822736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A82B848C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512BA628161
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C82D0C94;
	Thu, 18 Sep 2025 12:20:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DDF1C5486
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197999; cv=none; b=VahbK3pqfU54MYKw3mnjD3hL1eblwMT883sBE2S+VptRGE2spQ9jyb40rZxmIqk0yFWPAsiHTz8jXclnfqCLhvXT99KHcyfGQA2RTFb82CS0s0p3+g20dkp563Cnk6oMrc1lvoL1FFAWVdrW8r2SOVjlfiYGbdBvoLT+8oKOfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197999; c=relaxed/simple;
	bh=fGRUWSeNNcgeqcHRkuxbrMGDyokBFOMlHiqs3FwB0qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGcsAMCuQ7F/gP6EIqZlfQM67dok2sIU+n6IOTkVLeRXWHc3I1LxkcRAwPxKCxr27DX7iNNrq0gWNTfMFr3hRBgqDBiTPbM+8JNw0CsXGIozh+qiWqpLFWdLjCVuvVkVV3GXUF9FfDYdaf3UyUdHYgMajh0kRDPDEQix/lMOa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uzDc7-0006mw-CD; Thu, 18 Sep 2025 14:19:51 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 18 Sep 2025 14:19:44 +0200
Subject: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
In-Reply-To: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=fGRUWSeNNcgeqcHRkuxbrMGDyokBFOMlHiqs3FwB0qs=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4/ePJrkCxDh6hXAdHxx22zupJIW+iUxpya/46RTQfr
 +u0UKzvKGVhEONikBVTZIlVk1MQMva/blZpFwszh5UJZAgDF6cATGTDR4Z/luKnlwbwz5fb5SOh
 e1Tnz7ZTM2f9W2miMmvFrPgnytPu2TEyLNvzs7Xl2NYFV//06C19WJVYvFAi10dd6nqkhkC5VCE
 nMwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
reset pin, rendering reset-gpios a valid property for all of the
nxp,sja1105 family.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 9432565f4f5d..e9dd914b0734 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -32,6 +32,15 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description:
+      A GPIO connected to the active-low RST_N pin of the SJA1105. Note that
+      reset of this chip is performed via SPI and the RST_N pin must be wired
+      to satisfy the power-up sequence documented in "SJA1105PQRS Application
+      Hints" (AH1704) sec. 2.4.4. Connecting the SJA1105 RST_N pin to a GPIO is
+      therefore discouraged.
+    maxItems: 1
+
   spi-cpha: true
   spi-cpol: true
 

-- 
2.51.0.178.g2462961280


