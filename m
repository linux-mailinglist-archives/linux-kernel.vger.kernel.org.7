Return-Path: <linux-kernel+bounces-827103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F045B90522
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C482316C474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE7303A12;
	Mon, 22 Sep 2025 11:11:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9952FF650
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539487; cv=none; b=N9cyb3XKevUCwmzS8nGHEK4agcZ7VoaWKsLhAUKOmX9Vq7zAv9sNlet+y1eo9+6AdIbIFT5e4sVcpYU5LW/YIbndAg1yE2FwPvchTS8Y9Jemx2y3Z+IMI32hcGHtdVBahvKV8/85rf4pdtaERKd7RJ4VeQrxdk5osuxZSbWFvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539487; c=relaxed/simple;
	bh=xsmAq3dD8T1O9QBOvKaD4Sg+D6YePeRPaUCTw/xNkh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usHbVsmOt3Jw16oQb/5akOUdMIxZ/NMnBuEXFGOI/3fKOsv2Gv9O8TgX6n5mnH9NSnt2rwmC5e4rNBCmfxy1IdlNDGCa/ENkq8lvYlAv3qypnFr8CKqiv1LoAipjS5I8uz41fz/Y8MPKZjczVTceANJQ4YG9hRHs5X3ZRJ7Fwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1v0eRq-0002HM-Uy; Mon, 22 Sep 2025 13:11:11 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 22 Sep 2025 13:10:55 +0200
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: add compatible for Skov
 i.MX8MP variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-4-abbb759cf8ef@pengutronix.de>
References: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-0-abbb759cf8ef@pengutronix.de>
In-Reply-To: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-0-abbb759cf8ef@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In preparation for adding a new device tree variant with a different
panel, describe the DT compatible in the binding.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3e9f9e0735a8808721ebba713f14818ee49172a..95078d1a70b07e9c0d298f18ce4eaba3aebd4591 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1111,6 +1111,7 @@ properties:
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
               - skov,imx8mp-skov-revc-bd500 # SKOV i.MX8MP climate control with LED frontplate
+              - skov,imx8mp-skov-revc-jutouch-jt101tm023 # SKOV i.MX8MP climate control with 10" JuTouch panel
               - skov,imx8mp-skov-revc-tian-g07017 # SKOV i.MX8MP climate control with 7" panel
               - ysoft,imx8mp-iota2-lumpy  # Y Soft i.MX8MP IOTA2 Lumpy Board
           - const: fsl,imx8mp

-- 
2.49.0


