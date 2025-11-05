Return-Path: <linux-kernel+bounces-886188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF268C34EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6403BC903
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F830BBB3;
	Wed,  5 Nov 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgdP4Hxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F03090E6;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336006; cv=none; b=K/mUqY6zQrB3R81JY8jVnvwXXqy6ZL+8usO6zjoGyfcFiI/Qo+YNhKGPhRBgyorVF4Doa5272y3Bgy/CH9B4iXYk9bAHy7WCtQra/i1m3ebvaT4TtKo2EsYrUhaolTnNPO2Un8SUgdqA+sB1YbuVd89sfh0cYDZHxkhvrpfEw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336006; c=relaxed/simple;
	bh=bR/dJ1W1oedY8nMUkn3wXTEnnnKlSOlK+osXYyo7NIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ns2ZVtg5l22t3haLFewhbYkhQdCPDPcg4cTv91C8JpxJga+z/9hnr7rB4mMsx09TsPn9FhD+gaY9/lnEUCud/Sbf4E0l+QerNsJlGEuwzYzYC0BywnSvF5uU1K98HYXbIyZERZJ/abZlrgfYk4vgmHsbmODRzoUl5b7czDj5xIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgdP4Hxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B21D4C19421;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336005;
	bh=bR/dJ1W1oedY8nMUkn3wXTEnnnKlSOlK+osXYyo7NIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bgdP4HxlQLYR+a3xo+pzZqlMPDrJ+pYv5l6JkDj2A1Lw6FeXRZqCkVZfPhs5Jg8mi
	 eky7l0xuEO6NtcYMt9/gHxfJF/gu0zpX0PbfBFnDP3qDpUy/qyPpGxY7Tz1KA9KRGN
	 IGW7epwrujMitPTDdr9lbH1PYt1+U99p/WtH4DhPWggQi7CV1L49ZqktrdGECgid81
	 iRp7nitBovz/pJNQfIdVdjroSHHhXRuhVtK+kqhH9Neg7pfei9F8AbWTceZoQKIZxV
	 VmETRvgUucvYlbOCaGa1gis6voqFLGn6Phlq4FOAz20ziWR+rqHiJqmEFQp0MMG0bd
	 kxqPRHuyqJZqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9778CCF9F8;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Nov 2025 17:45:34 +0800
Subject: [PATCH 3/5] arm64: dts: Add gpio_intc node for Amlogic S6 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe4781c1@amlogic.com>
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
 bh=oWh7wvbC9VgUKpiFroFm8xAgEe2wFf5o1v5W8FxUUPA=;
 b=QBpdhMRZhusJtyBrfbf8YB99VZxECB/uM95mLRKI2xqDeHFlAVga5ul9RMsQNWaQN9xRopQK4
 PLK1yDsXhqkCyoU1yG7yrpBQ3QLQy0Y4hEr/LyOYRdztI3X6WY49f44
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
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
index 0dca64a2ef9e..3ee1b563a34a 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
@@ -199,6 +199,16 @@ gpiocc: gpio@300 {
 					gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			gpio_intc: interrupt-controller@4080 {
+				compatible = "amlogic,s6-gpio-intc",
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



