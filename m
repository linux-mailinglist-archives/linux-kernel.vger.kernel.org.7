Return-Path: <linux-kernel+bounces-886186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB47C34EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E764F3BC66D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832E30BB8C;
	Wed,  5 Nov 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0cvidc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0998304BC2;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336006; cv=none; b=GS/bCU1dFoEu1rU9xwGtMwfNZt6782eUwpC/NsSWP7XCPr+T4dMTn0L+v4kQy6mwluN/d9A6iuTIY8zkbqbeg5x90G4M+pIkKwcRTZlDFR81nk/4UFXIqcKhC51T4Jg+RNxT8JTfE0jCZYE8g1LcMn6L8/dXysbLwjKC3It9ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336006; c=relaxed/simple;
	bh=99fVqQTCZBU9q5RiQ5PSykLF8wyOcIjkV7EDXi3gtDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOoAHM3RGbuCWcsR8M7Elhox0aKkIIauebDs9bFAfNBH1sG3RT2XSNVyPuaWnsj8XcIJ0YyieT9+/CoEWQMHSz8YHAC+ExOWLJTu9ppAe9btOhnUFMvIexXOccswTOKGpqDceDvrpETQ7cMPTzZUff5Td6iapBsSxSCSktZ6CrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0cvidc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEC1FC19424;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336005;
	bh=99fVqQTCZBU9q5RiQ5PSykLF8wyOcIjkV7EDXi3gtDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V0cvidc48untLCOIe0dsVO4llOu1xbYpPEp6xyO4M6Av56tPwhRTRCBd4k7uf9/t0
	 QCDTWiknhOlg+y9mVY4sdGNPBSLfV/ZpndL94mXBtRwX6Pi1ttx50f9re2wXVJ+7cm
	 /ho1sATEQOOJyKC0isDlXA2xMz6PIYfcuVYM3/oULigePrDA8edhWyqhNgU59TYvfj
	 zh0Nhkhi3xrdHbJw51hrf6AXMsuHCPEIX2W9MPvj2O401Bek6CTXgvPDX5YPFstKQT
	 AXvLnD1RRnGfoZoa4+RUhNy0LvecnOf0fk+CrXOtd4M22r79sCoVDLC8rpn5YZenJA
	 817jXuMX6NSsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B875CCCFA18;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Nov 2025 17:45:35 +0800
Subject: [PATCH 4/5] arm64: dts: Add gpio_intc node for Amlogic S7 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-irqchip-gpio-s6-s7-s7d-v1-4-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762336003; l=916;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=epwwC+3IrP75yFrjS6QYa+JuNwM3q8u7ctb1sF519+k=;
 b=9g12a7vCOUn6deBMg7xiDglM5u2DDjHNnX7gk6tSKw3Oz6vdJimIXuAuJ7zb4mu6Jgvs0PGe4
 DRwarPvJw0sCrFT3VpNbh5xHGHAVXNjVelV/aI6s1rM4aDdcNy2ansG
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
index d0b63d3fc953..aef7aad95667 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
@@ -221,6 +221,16 @@ gpiocc: gpio@300 {
 					gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			gpio_intc: interrupt-controller@4080 {
+				compatible = "amlogic,s7-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg = <0x0 0x4080 0x0 0x20>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts =
+					<10 11 12 13 14 15 16 17 18 19 20 21>;
+			};
 		};
 	};
 };

-- 
2.37.1



