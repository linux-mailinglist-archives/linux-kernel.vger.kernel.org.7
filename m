Return-Path: <linux-kernel+bounces-792456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D2B3C426
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926A47BD843
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030B34572E;
	Fri, 29 Aug 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqXMinr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2016230BDF;
	Fri, 29 Aug 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502006; cv=none; b=ZH6zdQLg75W8YQr0IqKolqpbq4+dCmxP1YSLyZnsex8AnUpb4tZu/d15joYh6oh81eH8UOujSNiK+EEupegG+k5w88rv2+s4ESLCcHvKlzzJejpBN9fKaAyyjNsBW2fasrTZuUcbCXnUENSROj60QLLmkZC4yVS2/mm9Ky4DiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502006; c=relaxed/simple;
	bh=JZ0CWieAD+hPk8tcHz5WX7FBAOxPPfeaj0F6aTNx4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSP7BN5LNhEvnKjwJpnTJVg0zgOYhpe8oe9tyLYqFDgFSrBHmQFfbPGpVfpni4YYygRAkh5depUgWcnv92eA77UVAmgfrd5KZg/H2n1dEQ9UTGJcl5yXrnOZExukgZJlTiCheNPX3mxT9+4xxS5iVuQY1I3QRTz8atatM14L7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqXMinr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADEDC4CEF0;
	Fri, 29 Aug 2025 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756502006;
	bh=JZ0CWieAD+hPk8tcHz5WX7FBAOxPPfeaj0F6aTNx4zg=;
	h=From:To:Cc:Subject:Date:From;
	b=aqXMinr0mzFFf3X/Qxc61FXYoalDlBqS+T9E1Unr43Jv3nAytC2tYjUPS8H7H6aVJ
	 GOOcOMlX0CXlYaFGiD27NXRr6HQ+SPdQtw0AWMhcAsTraMdIqeXvwt7wyAbxCUvIN0
	 Yfl4/n2cRQ25OMuhUDPlqNL5ICChxRmnh6CY5k70wMMb6ZrK42UyVCUsEJjV2NnoEo
	 YNJ9OFyNjVmn0mEL4PF5QprtjxR9P2jDbL/y0UA/oQ65w6ScBRIiajsb0shF1ITVaO
	 SjJ1Ix36+X83Zpk5cDCNdUhLYB4cGUQf30kfNc0U2n9TO3FefHDBroMbaItRVUnR3V
	 zrlPT9+9a6G9g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Drop "sdhci" compatibles
Date: Fri, 29 Aug 2025 16:13:17 -0500
Message-ID: <20250829211318.1335862-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "sdhci" compatible is not documented nor very useful on its own given
the various features and quirks of SDHCI implementations.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index acdb6ae74b27..61983feb2a4e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -662,7 +662,7 @@ sdc: sdc@1e740000 {
 				status = "disabled";
 
 				sdhci0: sdhci@1e740100 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x100 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
@@ -671,7 +671,7 @@ sdhci0: sdhci@1e740100 {
 				};
 
 				sdhci1: sdhci@1e740200 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x200 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
-- 
2.50.1


