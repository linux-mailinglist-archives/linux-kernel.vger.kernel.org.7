Return-Path: <linux-kernel+bounces-758668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E4B1D255
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BAA189EAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6F21CC64;
	Thu,  7 Aug 2025 06:09:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB33214A6A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546989; cv=none; b=kpyJSX1szT+B5ds4UodHsxRgNcqizYqyt5cotSnsnNTylwufilBnBxTsoS9oQqGQ/a6RzFbSszrCdM/2m3B/V+qoyacpdjIj0jmeVnW/wOxbWDp88G/MqnDG+iKau5kOgJ+d/c2lvNLgrydiQaTBjYmi7sklwvn44ltoBerbNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546989; c=relaxed/simple;
	bh=ewHuJwXGAVxGqoICJxvM4lr6uTeH0+lVV2Ql/973l6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOSgi6Wy9rvLQiSUFxT3FrSBM1os7JBBCYxREcXV7YL3EW9SH8HwELDuxZtFyXAYmzx0w3ZfAkbiOYdPxN0yRPESkpNs5ESml0PdR7IS4HKQc3vbLZCweWQt2ZcLyQFNvWnmMKJ9v3JWlhIm/5uUnDaqbPDH9MxiGP+L0ZGc/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtow-0001XD-2J
	for linux-kernel@vger.kernel.org; Thu, 07 Aug 2025 08:09:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-00CKY0-1c
	for linux-kernel@vger.kernel.org;
	Thu, 07 Aug 2025 08:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 30F98452517
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:09:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F26734524F0;
	Thu, 07 Aug 2025 06:09:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 15b8e7cf;
	Thu, 7 Aug 2025 06:09:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 07 Aug 2025 08:09:31 +0200
Subject: [PATCH v2 2/2] ARM: dts: stm32: add resets property to m_can nodes
 in the stm32mp153
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-stm32mp15-m_can-add-reset-v2-2-f69ebbfced1f@pengutronix.de>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ewHuJwXGAVxGqoICJxvM4lr6uTeH0+lVV2Ql/973l6U=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBolEMgnBvgWRLCFWIGLZ6HAxMAXSI6CFmUUCYFm
 u8o3aSzYRKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJRDIAAKCRAMdGXf+ZCR
 nEKTCACiSFdsMI3Cz12LYjKCVtfz9Zc/ybxosYzsgLLE4xlLWh8P1CCpjMooCo/Qt2p0ctwhvUg
 Xj+E06x/aHq+bgK5NG6RoLtj8j0XF3q9Qp7MuXreAyo/NxNJu5V4nEMCZ0391O/KcpedkOoHNjB
 F0brEpH5OoOCgHRvdmnvFLamDkiYDOA2DvBmbdkneijAow3po6NubYVFApM6Bf9V1IUDU9nyyhL
 oOW3Tx6JjG0z1c+nQBkch1zsFUkndjU8HjGaNXlah68xyehMdzX+D05e/dACGLnHJuPl+eKx7CB
 ASHalohBeAoGHCvSOUwbTmhZGT6CgylrHqByUcBkbteh2iX1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On the STM32MP153 the m_cam IP cores (a.k.a. FDCAN) have an external
shared reset in the RCC. Add the reset to both m_can nodes.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp153.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp153.dtsi b/arch/arm/boot/dts/st/stm32mp153.dtsi
index 4640dafb1598..92794b942ab2 100644
--- a/arch/arm/boot/dts/st/stm32mp153.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp153.dtsi
@@ -40,6 +40,7 @@ m_can1: can@4400e000 {
 		interrupt-names = "int0", "int1";
 		clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 		clock-names = "hclk", "cclk";
+		resets = <&rcc FDCAN_R>;
 		bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
 		access-controllers = <&etzpc 62>;
 		status = "disabled";
@@ -54,6 +55,7 @@ m_can2: can@4400f000 {
 		interrupt-names = "int0", "int1";
 		clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 		clock-names = "hclk", "cclk";
+		resets = <&rcc FDCAN_R>;
 		bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 		access-controllers = <&etzpc 62>;
 		status = "disabled";

-- 
2.47.2



