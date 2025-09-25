Return-Path: <linux-kernel+bounces-833216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E5BA16F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FE417B2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE84321286;
	Thu, 25 Sep 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V3GEiR6K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XH3baMCn"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B9320CAB;
	Thu, 25 Sep 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833558; cv=none; b=GDzbYpMj9dV1GbdlE+c2jeXHxNC0rjOSbpy1UD0Yz55lu20gu3+tMK3WHqMM+0YcS83hcVC0ut4vsxGq5k9c4TSLTexx3/oRQqCQPjX8IHobycznAmMRLBxanPoLvL/ad+rAAk8P7zBdwqMvhknxnNfyz9fZ/yxwIzQu8OqzRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833558; c=relaxed/simple;
	bh=IQ4qZCtCZIYWIGaW2ha2qzV0BGFt1JnggjVVAl/goMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeQ2ULo1NJfzFYFj2zrN83HK4j60E7pwx8oEdYLFBr15uJ9HmJNTWYGwyCGFVGgRpoXRH2Ha9Ky3on06ygS2tACrt9amtyBrMHnqfln3wDY5jLcXitTrpC4TT3CCAmVrIWfFvn8kvaWs6T4sfwlAzTookQhps6RxdPYf6/qOIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=V3GEiR6K; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XH3baMCn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXmBB564Wz9sl7;
	Thu, 25 Sep 2025 22:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758833554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=di1Qn1dMYtgFxXZEmc2QHL5MDRrtBScA8er1ThtwkQ4=;
	b=V3GEiR6KdOTRLLE8u/AJMBWOS7sgqcU4LX2iX/Bqy0WO846bXalIVU3pxWXwlcR9md+8tg
	X2kUQhrNkvuZILmQ7MfQmYdW1HtS8eol2qXZS1JKJJ37rISqiSIAdNZDu1zPxv8lGZWWEu
	w/RwW5lFr5nU2DjhdOzivXCD/mI07YyAht+Eg6p6rrwKZ8RKnclrt2E6b6J/2ORaOyl//w
	nWQWtk7ixcaSwsIhnK9oplPVpj9k2WVoQyhtCG80KZDBeU5AXyNG1omz2MuHOog2McqmiP
	+Z5RMNKIdn+NPxUEOgCPNdw3lTr2mut0oWJkT2YCdLjLipep1qBIGe6DwQNFCQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=XH3baMCn;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758833552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=di1Qn1dMYtgFxXZEmc2QHL5MDRrtBScA8er1ThtwkQ4=;
	b=XH3baMCnljKn1CagYckEYHfmAAdIDrXTQLGILz/9UBAVajStTXC3RxtMksTd21PKpsE9j0
	adOeHyG9W15aUAE+R+qldBiVWS3rvkuYO/Z+9Zk54D9mXACI++FJHyu9yFaIaEzLMROkw7
	+UC/ZLjA3d0NwRio0M/2ugt3cNGa2trbasKfdI1C8dCyMA2soCSzUjnOfV6GEmhBJH4FUe
	MIZj2cI/xozEYq84EsGlLk2S28aMBTpT6ta+oP/R/LtUYbcwaA/FVnQCkrUEuddf1cGgxx
	wHHda7MDyNGHQC/ZHUKOI/5fX7kkhMCV4NLuq5W6D7vRlZd554V0E8Te9ys1gQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <joao.goncalves@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin Evaluation Kit (EVK)
Date: Thu, 25 Sep 2025 22:51:54 +0200
Message-ID: <20250925205211.171699-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jzfk9accpwdoyrj9oxc6athy3ng1m71p
X-MBO-RS-ID: c5eaf82e82a3ea441d2
X-Rspamd-Queue-Id: 4cXmBB564Wz9sl7

Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
used to be the Titan EVK.

Note that the SoM used in this EVK is a derivative SoM from Verdin
line of SoMs, an actual i.MX95 Verdin SoM is under development.

[1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Joao Goncalves <joao.goncalves@toradex.com>
Cc: Joao Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
V2: Add AB from Rob, RB from Daniel and Francesco
V3: No change
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b0620..b42240004d81c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1430,6 +1430,7 @@ properties:
           - enum:
               - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+              - toradex,verdin-imx95-19x19-evk  # i.MX95 Verdin Evaluation Kit (EVK)
           - const: fsl,imx95
 
       - description: PHYTEC i.MX 95 FPSC based Boards
-- 
2.51.0


