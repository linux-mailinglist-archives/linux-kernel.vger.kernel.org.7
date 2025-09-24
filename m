Return-Path: <linux-kernel+bounces-831236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CEB9C29E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A537188533F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE257329F2A;
	Wed, 24 Sep 2025 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7hBuaEr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B8322DCA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746312; cv=none; b=JZRj29Ztd72zuruYxXx2vzUQbYjdnoN9BN6KBB06BeM+B2J//rjegUGPVjrHnzTqu4ah4M/vGdAwnlPlX3vif0QqoP/gC7r+QCnAhhsfdRSlSxcJrH7eNFvc6ngPHoG8zhqAdxPisGu/l1nvhHuZc56wi2TDZMoP6JVOM4ntMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746312; c=relaxed/simple;
	bh=/7E6ceDbDhZ4pxug1DrrfRHk0oYerFsLd6y+cKd/Fmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KOM8ASX4NIWWq7s2GdGrgRaEZ34njU+ZnZW+QAM/s1QMlKOExfq71PfaR4hc4U5DojbZHpy2kv7KxFtxvoOqBGh2IWlBReJ2dp3ogCvrr5FscAH+6EuhtWyZh/FT/GUs7fPL9NE7kdLGjBZiB7w8KWU8IZe+I8iF1jb28Q6g0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7hBuaEr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso1117005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746308; x=1759351108; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgAWQCFoo98/Z9ljCaTiQGL2NXe+X8U3ZUEI4e+iLi4=;
        b=N7hBuaEr8t+6xC4rLoQ+rFnTMSFIHuA7TOrBqdAbbuOHt9EuqGWjL8mUxPcLj2gk9v
         z0mLvsP6MF6t8Hazcu9f4t0en5PSjTHxFWfNM59TEBU7K18lku72AOGaV3+XblMzmEBH
         iI9VJAz/KLS5QhY7Y/FYcj+OT+AlXDH3xVF4BmFcdOwZby2GF+npYG8mADRbdWSI8STK
         UqZwqmnY2iOME3tHpAdO2hFUbxj/ltMXU4mLCXJIt0c/NW3JXiBPC4wtP819cYP9UwZd
         HPcQglKNfGGbH989waIkH2Iaj5w3t+F/E1u4DBL3O0zhjYH0CMRv9JFosCQcsryA66sz
         qtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746308; x=1759351108;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgAWQCFoo98/Z9ljCaTiQGL2NXe+X8U3ZUEI4e+iLi4=;
        b=EBYte4kZJS+0EBLO1jdmJFsKZYYzSb+N2uTIg70Y8nvfeRO17FqTtImotW+8xkD9Ln
         MNUDbKmD0Sbm84E5Hkje+nzfDWgFoI53ybzWILF60EGNk0B57wnmy9kTnGMlE8tLl55T
         7C9R5j8ZuUwlZHIELgNG2dgI2EnC0EtbPrp+tUSIWv7CdgoHBqxQFlwgZKWgHpTewN0v
         RqQlY+BenBx78W+af/vhVi8C+phr8u0subIwMQeciqZ7AqGIWnEBKLvsMDZpCxg5QKP+
         R3fTT0gaOUTuCy3RsbgO3KbqJATf2pi/2OeMfjVzWXH+WIIinigPWSxVplY7Ww9EsF8N
         y4nA==
X-Forwarded-Encrypted: i=1; AJvYcCUOzGt/MMpricFgIDzpE0ykJsxp038uCtndSo5W/flu/P95Ah8h/EXLWNxuICB8tC/sUJ9YiqEJZtPiNqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMYggRHF8JdroQL3B7zJG1TXh+ig/t2zoDrTFh8CwFmfJCtNs
	BOXpKOdKpvz+BAsPD1K6SCmwkRm/IUL3IujZo43TxY3DvGIrfn6aJPOr
X-Gm-Gg: ASbGncu8HdjTtWz2M5AalKPXy6MiSNn6RwEYah8TR+CITC44E1+lH4Ywc9heEMYhHga
	fypo1FOlmKpNAmnfdxSLIlJGjxN/rvlV/ue9gGeJaakkYwz6+G8fcmL1tYCSHIOp2ez02ogUoa4
	WOJf25Sfdg5Ze9Fr8mxGgPFgPKR4TUcgkYV+QLw3GSBzg8t54mBMCo+jlJlXqrBgiCXuxhgX3CZ
	UR8VBHjTw/dXNnXtq2JXcxMlsdxo6vwWK8ChrUkHaRbbjllJDoATwB68XSjMeQOPwgyBgCg5Kej
	OWoRGrRi3gWBXIhQSbXXSgS3AuptTedtggVbNUbnnQ0HfgLaumrnqgsnsx9hjiUNoY8ABPaIJy3
	DxLgaqGO24NLEiAn2sfJgvXSeAwdIlA39Q/HIH9kuK1937AqF
X-Google-Smtp-Source: AGHT+IGDxHR9zD3T2Jojj5V63amKQHEZ4Y5ouX0SIG7pqFz8i6fnWZlg4urHE+jXQ/8JQVeDmH/9Kg==
X-Received: by 2002:a05:600c:1695:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-46e32a1987cmr6748555e9.34.1758746308296;
        Wed, 24 Sep 2025 13:38:28 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.95.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e8aesm2663465e9.4.2025.09.24.13.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:38:27 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Sep 2025 00:38:13 +0400
Subject: [PATCH] arm64: dts: rockchip: Add DSI LCD display on rk3576-evb1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
X-B4-Tracking: v=1; b=H4sIALRW1GgC/x3MSQqAMAxA0atI1gZsU8eriAuHVIOg0kIRSu9uc
 fkW/0fw7IQ9DEUEx0G83FeGKgtYj/naGWXLBl3puuq1QXdS3TbIYVG4eUGm3pLpiBbbQK4ex1b
 e/zhOKX3yEkZhYQAAAA==
X-Change-ID: 20250924-rk3576-evb1-dsi-e39f34833bf6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3993; i=alchark@gmail.com;
 h=from:subject:message-id; bh=/7E6ceDbDhZ4pxug1DrrfRHk0oYerFsLd6y+cKd/Fmc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRcCTss8+Uow9wVd7om3ggIPPxuqbaVReHufeeOKO8ui
 DqxLvCgXUcpC4MYF4OsmCLL3G9LbKca8c3a5eHxFWYOKxPIEAYuTgGYiNxbRoafxwXXszilzNvD
 v3ou95Mb/R6Ju83fpOisd/+6dteaZbd2MPwPfxPzSlRMSOXbG8XWJufMCcLu6zfOeeo/SUhQjlt
 YYSsDAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for the Rockchip W552793DBA-V10 LCD+touchscreen assembly which
comes physically attached to Rockchip RK3576 EVB1 boards.

The display part is driven by the on-chip MIPI DSI controller, and the
touchscreen is connected over I2C.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Note that backlight support is left out for now, as it depends on PWM
support [0] which has not yet been merged.

A workaround is simply `gpioset -c 0 13=1` to set the respective GPIO
pin high and thus to light up the display unconditionally.

[0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com/
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index db8fef7a4f1b9570cb517ccc9a857d1c93c9d2db..f20cd6f2c079e0a5bd79acc9ebcd56b499e0f72f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -125,6 +125,8 @@ vcc3v3_lcd_n: regulator-vcc3v3-lcd0-n {
 		regulator-boot-on;
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_lcd_s0_en>;
 		vin-supply = <&vcc_3v3_s0>;
 	};
 
@@ -264,6 +266,43 @@ &combphy1_psu {
 	status = "okay";
 };
 
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&mipim1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	panel@0 {
+		compatible = "wanchanglong,w552793baa", "raydium,rm67200";
+		reg = <0>;
+
+		iovcc-supply = <&vcc3v3_lcd_n>;
+		reset-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc3v3_lcd_n>;
+		vsn-supply = <&vcc5v0_device>;
+		vsp-supply = <&vcc5v0_device>;
+
+		port {
+			mipi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_in {
+	dsi_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_dsi>;
+	};
+};
+
+&dsi_out {
+	dsi_out_panel: endpoint {
+		remote-endpoint = <&mipi_panel_in>;
+	};
+};
+
 &gmac0 {
 	clock_in_out = "output";
 	phy-mode = "rgmii-rxid";
@@ -319,6 +358,28 @@ &hdptxphy {
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m1_xfer>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	touchscreen@14 {
+		compatible = "goodix,gt1158";
+		reg = <0x14>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int>, <&tp_rst>;
+		reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
+		VDDIO-supply = <&vcc3v3_lcd_n>;
+	};
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -738,6 +799,10 @@ rgmii_phy1: ethernet-phy@1 {
 	};
 };
 
+&mipidcphy {
+	status = "okay";
+};
+
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_rst>;
@@ -788,6 +853,20 @@ host_wake_bt: host-wake-bt {
 		};
 	};
 
+	display {
+		vcc3v3_lcd_s0_en: vcc3v3-lcd-s0-en {
+			rockchip,pins = <0 RK_PC6 0 &pcfg_pull_none>;
+		};
+
+		tp_int: tp-int {
+			rockchip,pins = <0 RK_PC5 0 &pcfg_pull_none>;
+		};
+
+		tp_rst: tp-rst {
+			rockchip,pins = <0 RK_PD0 0 &pcfg_pull_none>;
+		};
+	};
+
 	hym8563 {
 		rtc_int: rtc-int {
 			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -941,3 +1020,13 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&vp1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vp1_out_dsi: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
+		reg = <ROCKCHIP_VOP2_EP_MIPI0>;
+		remote-endpoint = <&dsi_in_vp1>;
+	};
+};

---
base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
change-id: 20250924-rk3576-evb1-dsi-e39f34833bf6

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


