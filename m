Return-Path: <linux-kernel+bounces-819226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C6B59D13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FA84E02D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836D29AB05;
	Tue, 16 Sep 2025 16:05:32 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4D274643;
	Tue, 16 Sep 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038731; cv=none; b=PsDHyazxXz6SZbsjdF8xc2Z4g/C9FMkP1VXx/dAkUwKJTcdoK2dWuWcFjdK/6pWPdHW+93AAeXqcI1cTchCl1hfSuK2rsYzVnYywk310ZUnLL85NOERNii0W8q4dn8DqnVBBEjvNYqVgDFaI3U3X5McWdbUp902XZ5CMnKd1XPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038731; c=relaxed/simple;
	bh=eddMiSph/zd3jIVYpg5zyAqPWnt8zQcr86+7GTSlCUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Asi6xdF4GayI+hfdAKXCn1rpvPJwmWQgnDaooCJQFDFneuN3aRZU63RB45EaDiMJVKnZ3vY7WSx8FZyLasexFk932zyuh5M5GlS5/K/oSrNRrPV6Qwd4FE6q+i3FXCEHAV4NrDI0hlPC264gMI9SltzN/9dAyTBPUf64hc3iCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uyXfH-00Aysu-LY;
	Tue, 16 Sep 2025 15:32:19 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/7] arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate usdhc1 props
Date: Tue, 16 Sep 2025 08:32:10 -0700
Message-Id: <20250916153216.1042625-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916153216.1042625-1-tharvey@gateworks.com>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the un-intended duplicate properties from usdhc1.

Fixes: 0d5b288c2110e ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index cbf0c9a740fa..303995a8adce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -423,9 +423,6 @@ &usdhc1 {
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
 };
 
 /* eMMC */
-- 
2.25.1


