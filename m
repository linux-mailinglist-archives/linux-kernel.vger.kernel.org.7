Return-Path: <linux-kernel+bounces-722953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD7AFE118
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C893AF086
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3D26F463;
	Wed,  9 Jul 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="HqDS+lIr"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5326E712;
	Wed,  9 Jul 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045396; cv=none; b=JnpNxCqZl+zwNUtNUIclbZuvnZKYU288F8eozsBAIp2p7Y3PA9zKTzftJ6Pt6pNZJtmfMAPvlDAJoGA7vrvfDkSZ6dMqpD1VfqfFkx89wv+JZa7Za7cL4c5OAsjg1ApsdthYf7qy+J2pNJ9DxaT4pE2ofZKSSGQne0cgIHmp41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045396; c=relaxed/simple;
	bh=Zy3phdcKvw4NI5hudzaAjZVwv0QpZo35Naaby45lfbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imRkJVfY9JTd59dIYqMvqBylJDWjKKG8BpTuR3p+hGLtvAIH2B7iAgyIH9FZkCji0JZ5uNYUdme6fDkfuABn2FAq6avQO/FPnd8DjvclEdUQTn8j4Z/1GkgtWMEVBRPdqX8J52pNzytpP6l0Na9rzSwYGWWkKkP0FXZ2yynVj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=HqDS+lIr; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7BEBC74CE;
	Wed,  9 Jul 2025 09:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752045392; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=53mmWhWTBcWWhTmzkcxS1iBXeRIgZB0MRCCtHtk+9xs=;
	b=HqDS+lIrVuhhhvL68VSssy6wxt+Q2sfqX4C7tZqOYipGltc7cMqzfGhGHidapDFH/dqpO0
	OJpsNy2hvrp6FxPY1JRCt9HPri7fYoCWUYlWP428AIpa6K0rVdDgngcZG0by7wvifDv6lb
	fCwMDpDSuKnDYqZVton8R31IKmNvir5+8SruaDObyR9HuafaZ7pW38eyqOdwVF2Y7+3A60
	+yw8IF1InqBar/5RG7LG9Tho65XIuQxEAfACWPPz97hy5nYM+MVXqYLH++P6xRa6BOoFxZ
	obPmjkHoYMX/LOgRnA6zpdSWs8FuKoWHLZxrPcFUG0uPxJuC9HsV249HO/7g0w==
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
	Frank Li <Frank.Li@nxp.com>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-sl-common: Fix QSPI NAND node name
Date: Wed,  9 Jul 2025 09:15:55 +0200
Message-ID: <20250709071557.20602-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709071557.20602-1-frieder@fris.de>
References: <20250709071557.20602-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Rename QSPI NAND node to 'flash@0' in order to fix the following
dt-schema warning:

spi-flash@0 (spi-nand): $nodename:0: 'spi-flash@0' does not match '^(flash|.*sram|nand)(@.*)?$'

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes for v3:
* Add Frank's R-b tag (thanks!)
Changes for v2:
* None
---
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
index 779723b04575a..4c0ac4d4df686 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
@@ -82,7 +82,7 @@ &qspi {
 	pinctrl-0 = <&pinctrl_qspi>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-nand";
-- 
2.50.0


