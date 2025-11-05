Return-Path: <linux-kernel+bounces-886187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66FC34F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 360834F9EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EF30BBA4;
	Wed,  5 Nov 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn7Z0iyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E667308F0F;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336006; cv=none; b=AXIS4Rk5cdMmWUUHPNLxsWmemdCkPCjbZ0ooJRisQ2fKD2STzQwDsGcDaG4cl15nybmnA3yDo3X1FE1cnUGibd9XtcuPqgzwThK8iUwntteqcoZJ+lQmGbMlSElTnud8ncy1YOKjZqzCNYpxaSX+vJ6QBty9SVo4yd9rOOSEW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336006; c=relaxed/simple;
	bh=D+g92RPPyToKxZV9E5r3aNx2xs44Ra8kbrfRIOZI8og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUmrRIPS5QPBI33vI87OpD82ox6Bbfbf1XrNfUdBZ+CLK6rvx1P874X2tLp4/m+yrT+7cOoUzNj7Vy3XY2jB+/rfCEydh2zC+mK82acTVP1e5Y5EaXw8EbLiak+vo8bDOT4ekbyt9MZKAtFbDWZxBRtu4qZzh0McA64X2KGqwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn7Z0iyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C118C16AAE;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336005;
	bh=D+g92RPPyToKxZV9E5r3aNx2xs44Ra8kbrfRIOZI8og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qn7Z0iyyau3yR17BhkZ8u2RDOPdxGweXPQXK8VGc0Zd+u5nfbza0EEYFQnHimc0vw
	 fI6bwEPk57nHwlBEYk77/39cQM8GFwbYmQxehWwiP6bFNiv5VvkbWCKCXKLRjDPs8l
	 mZcfTWtHOAKHL6MtzAL9MIwOZ/FPS2H4YbkhHBOQ87cl7u88Jh4jgyCOXxjGSvQi36
	 x5B/Ea2WDWRCRu1xKH+ggREzw4xoRhwfaEOcybqjFU26fdwzGy3rsbZKJD3uLQB+6O
	 ZltfUoMB8Y5ZbYy/V0UhkkiAMD3UvyUZtwxzBm9s2xp9y0a87GmBDIlC9XJOmS4grp
	 TW2sX7SoiyJ3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F46CCFA07;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Nov 2025 17:45:33 +0800
Subject: [PATCH 2/5] irqchip: Add support for Amlogic S6 S7 and S7D SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe4781c1@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762336003; l=2575;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=8Qj9MLaQxbWjp8ZestvxizI5mF05EIMU/HlW0eH6014=;
 b=4RZQDlQ+vZEZoK73tT8R8TxrKC/7YG83xJ+YyAtAFiEh5hkkvEU9clUHwiGPkK2/C66L38kaK
 xnfyJ0ve5FvDLpxf4C/YxVsQsmL16A3U86H5gjXNt2wy3J/9/IGtum/
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The Amlogic S6/S7/S7D SoCs support 12 GPIO IRQ lines,
details are as below.

    S6 IRQ Number:
    - 99:98    2 pins on bank CC
    - 97       1 pin  on bank TESTN
    - 96:81   16 pins on bank A
    - 80:65   16 pins on bank Z
    - 64:45   20 pins on bank X
    - 44:37    8 pins on bank H offs H1
    - 36:32    5 pins on bank F
    - 31:25    7 pins on bank D
    - 24:22    3 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

    S7 IRQ Number:
    - 83:82    2 pins on bank CC
    - 81       1 pin  on bank TESTN
    - 80:68   13 pins on bank Z
    - 67:48   20 pins on bank X
    - 47:36   12 pins on bank H
    - 35:24   12 pins on bank D
    - 23:22    2 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

    S7D IRQ Number:
    - 83:82    2 pins on bank CC
    - 81:75    7 pins on bank DV
    - 74       1 pin  on bank TESTN
    - 73:61   13 pins on bank Z
    - 60:41   20 pins on bank X
    - 40:29   12 pins on bank H
    - 28:24    5 pins on bank D
    - 23:22    2 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7d177626d64b..7e718b07e960 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -174,6 +174,14 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
+static const struct meson_gpio_irq_params s6_params = {
+	INIT_MESON_S4_COMMON_DATA(100)
+};
+
+static const struct meson_gpio_irq_params s7_params = {
+	INIT_MESON_S4_COMMON_DATA(84)
+};
+
 static const struct meson_gpio_irq_params c3_params = {
 	INIT_MESON_S4_COMMON_DATA(55)
 };
@@ -195,6 +203,9 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,a4-gpio-ao-intc", .data = &a4_ao_params },
 	{ .compatible = "amlogic,a4-gpio-intc", .data = &a4_params },
 	{ .compatible = "amlogic,a5-gpio-intc", .data = &a5_params },
+	{ .compatible = "amlogic,s6-gpio-intc", .data = &s6_params },
+	{ .compatible = "amlogic,s7-gpio-intc", .data = &s7_params },
+	{ .compatible = "amlogic,s7d-gpio-intc", .data = &s7_params },
 	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
 	{ .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
 	{ }

-- 
2.37.1



