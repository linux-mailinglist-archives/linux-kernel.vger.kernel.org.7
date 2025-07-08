Return-Path: <linux-kernel+bounces-721573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362AAFCB17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A57C1AA6F53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAE2DBF75;
	Tue,  8 Jul 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="brPIysX3"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44752221D87;
	Tue,  8 Jul 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979399; cv=none; b=Ukzdb2jKkQZGrvbG+CsUxcFxlovkVYE7yOtPet4D7poRm5NKwZ+KDJlLC4aQGgsdP3tw1r4C3squ0ykhViBqM9KM2RGWuTKv0sjc8uIKFktmE/OF6+t4XjrqDc0X59oeBIyw7+VHvjD41UZ2dceiQU29eVDhg+BrJt8ynfQvjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979399; c=relaxed/simple;
	bh=0QTdKFlAFA77pKiaNIl3vzWdlsCbyGAVQm6/j1X5Bss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuLDNqB81vi2/SZN08uM8ngwdf3FUjWAy7HcogjCxSqFTHe/mGYxqz3iFSMs1XqoN0uHYp0Jn6x5pNhZhcseFsIQbw3H1lqkmDucgcLEvPFxSJmfJZeu80Td6sNsmSkO2wSVP8yL+C7ES8gakN2/J5KtGO5Sjxk7cOA73c+xves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=brPIysX3; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 074BFC74CA;
	Tue,  8 Jul 2025 14:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1751979396; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=msbCU+F3wW1lAcU0MCNXjxoR6ouG8+m7lSEx0taLstY=;
	b=brPIysX3H5PCcmlveuaC/lc2v/0osIjezY1brbzDRooVlgdzMqes3uLDidM4i5yJemhulu
	09Q1Q5Aw6GRzv48jq2f/qknbLITL0s+arSb2i5+NyGPwujFbi9MhCjGV4YHYm9LnuCcigw
	TPuJLEmrNSkv6+RWzYayNqsXBGGZbrBv0HtjVw+Pf8ZCr734ADAkrSC5qZSHY5LMrAPhAQ
	Wn7n59J6dhqS2hIRwLB0+B7PRJ0I7/3aON2WLnXn6+LX6P52Y9+0Vr4FoofB1JXWhO2KOC
	wtEPHcUe4rTnl6/B+1mDspyeJLajrUg9sN7Sj8wcB/0oGQKPupoO0QTIQQiQ0w==
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
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 2/2] ARM: dts: imx6ul-kontron-sl-common: Fix QSPI NAND node name
Date: Tue,  8 Jul 2025 14:56:05 +0200
Message-ID: <20250708125607.66113-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708125607.66113-1-frieder@fris.de>
References: <20250708125607.66113-1-frieder@fris.de>
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
---
Changes for v2:
* None
---
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
index ab149c40a9cc1..793c95d44c7d0 100644
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


