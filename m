Return-Path: <linux-kernel+bounces-730205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E8B04157
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217433BE4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7324A047;
	Mon, 14 Jul 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="Te8QgY08"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0C19ABC6;
	Mon, 14 Jul 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502820; cv=none; b=gInZc2i2FrzReDInTxDauKOL4STpZPKYbOl7cwqWOX/xbzzFgDgqKeIjPMHP5fEIBu4HrOUqOr5IKaBWtxah6OXmiOAtIsj5pce4KliCZmo+p6KdpoBPnVIr5fN3dXxN4tYcn5/nDKHg+sCmAU6eufZamvv1An/Y4/fMipjiBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502820; c=relaxed/simple;
	bh=YlMqV9K0VO+qrL5y6ZXQy+k0bzHkUIsVHeFAWRt+jUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NThH6lvVx//9wLsdnxcaFBHjGODerCodym1qEIfgZmGSnDXH+ra5FB1PdPpi5hMnFWLppy8PaCbGurXSdEQ3H67a76sfPV9CEGfRkiI3mr2xWCtlJ2/063pamtyIHj4mgDjBsxgeOZrozLDXqFVyYZzt5JQhavfak00PdIRG9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=Te8QgY08; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E09CC753E;
	Mon, 14 Jul 2025 16:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502814; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=G6t649V1EzrZ/HP6mEg0Xb/fiQdeIFETtkrsh9N4wsQ=;
	b=Te8QgY08U4XvOxm4ZVpJDRoJLBbiZ+ECk4RunC9wh5OpT1tbLc/Z6bLR9/d1FrXelpgc8M
	ITWfz/oG2/SEFmJPjcbKLzVlsdChI1XKPBeBaXckY0SPYJ7jF37Dxn1wa56TU/g6COjXrq
	SelXyRDxAPMl4kswwWZtKZgPyNoKj/oblUOr3DOVygbUiBK7USBXfPDtoCafE8O1G5x0RE
	4jZ8ulWc8wX9eyg7M++W0FxTxVyEzjg7KilXKOOzVfFymC4gqwLLm4dyls59ObjEYQOkuY
	uoD/zimYybps2N8CZBhcxGaAvgSTbceyFQK+t53YZhFCxcNOj1jxtiGa5R6TTw==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 02/12] arm64: dts: imx8mm-kontron: Remove unused regulator
Date: Mon, 14 Jul 2025 16:17:28 +0200
Message-ID: <20250714141852.116455-3-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714141852.116455-1-frieder@fris.de>
References: <20250714141852.116455-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This regulator is not used anywhere and is not available in hardware.
Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 33f8d7d1970e0..3a166cf0afcb7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -48,14 +48,6 @@ pwm-beeper {
 		pwms = <&pwm2 0 5000 0>;
 	};
 
-	reg_rst_eth2: regulator-rst-eth2 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-name = "rst-usb-eth2";
-	};
-
 	reg_vdd_5v: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-always-on;
-- 
2.50.1


