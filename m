Return-Path: <linux-kernel+bounces-895175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874BC4D2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746A04F82C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58176350293;
	Tue, 11 Nov 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC45D6IN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBB34F265
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857779; cv=none; b=kiZ7fjF7ECz9qIYbv7PiyblceHNVw+j5Ppo8MTuT1BkjJBEIvkzOsPc1wYGvIvf5VzgNV0SinC2zuxu0ViPhbfRPAlC+scA9wzlt7sq6Blt9t2VS/O+2Xzy/Oqr36No9+dHSchhtLqLR5CSnrJ3KaotC/6qRCeAibEactQHuox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857779; c=relaxed/simple;
	bh=MPJETMYI7dWOLt6/n9IzJSMzQlKG2FVGqAgOqOZYvV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skpmboY5uhdhSoJHtp5i9t6JWSnpqmoutW7w2pawCrXiz5ZLz7WG8QEsc38c4ZwzIn62OWPP7L28VGd6SXznC/N4w9n7zz6U0C3h3OGKGyOZqvYvRSLgw+qkcaFVpKmgXMVmNb/BkJJnZg+LpebdyXGOiyvm6zC8E7i7tNkL2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC45D6IN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295548467c7so44206345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762857777; x=1763462577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGRhGlZHAoccrsdkNElXy8I6EJeUpk9FFBinfWP92lw=;
        b=CC45D6IN4UzfG/BSstS2NCVKzWLqwNYvZ9QLgE6duLU9zSMx1DcJIrCgIJzMM9IZwh
         R8x6rU0ifQ7f4ssAs0AzqAutqzllL2xvi2cBaP1cikO++v01iOQfyp0Ra7PR+9cQ5vkB
         v8ysMbSsOgkQsAw4axslm/JJOrPH5jLcoxD9U8SnjJq6V5hwbHEmHXTeozQaO9hrOu7x
         ByEZileKrGyR1+QmRXJJ1mDu0DYYxU1R0FqfSUF6k12J4miMQGHQHcvILfnS4oh/qfUS
         fFmV7XEIp71bowxqr92VtiM5G4eofUTgo8sz6hGYuOrNw4FqknT1ECbVtlsApSI00U3/
         +YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857777; x=1763462577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGRhGlZHAoccrsdkNElXy8I6EJeUpk9FFBinfWP92lw=;
        b=b4W7bFuKRHUq4D7G8sGwV0E8aF0rRhw2bsaxuhkxU/U6DKQliVTWHHbAd8XV6GFn4b
         J6/vNxvuWfS9l50/VZeVQH9yBNcFfXh4+Cav0QaPQh6CZWhaY8tUfC4B97a0EX0cf3cz
         +CxgjY/J/AXli1xwJVr0TigEiDE/+6KS8MuDGkAfTBGpOpmVIr7Cd6dp7t2MLSXxxwqt
         lhVpnvjNAg8GeNdMzRLS6glRHxCM5nwwZ12UMVLgqkmwB9AvCY+mDyE4Nwf3cMnRiBrg
         WK4LzQmC5EQDdWoNV7+fgF/n62DNWA7YgC57UXuicqZ9/y02fxTBvSBnGEqfpTjczh5K
         JVmg==
X-Forwarded-Encrypted: i=1; AJvYcCVDLkNsBd9QHcAQXpHAGmoON+W4+iPLeCtx4H1+5GERtpPcOHgsBB8VJLE61iGya372vfHeBtT7ukiBcRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWBxDqH1cixWPTRC28Lviw79+MjyqjXrbWtwJCGFSEYuvf2kA
	EUMTlL5A24kItmm1sW7y6LmfQo62nRuNd4Y/8bEoum1TFoQw/cNv/L0h
X-Gm-Gg: ASbGncsdBtMhdT1HU57kGPZvpFFE3SfHgN/vYswxFfVq0Ve3mh6zcf2qg0NABrqpzq6
	i36aGU329VAhCjmsuN4fTZVTy2AucNBcgiF0n6Alhjg0RIViAi3PIvEBZ2RnJnUljdKUeNXRd6i
	CHnTS0eZp/imPLwmzon6EZ7TNLjrnv5+YHKLZYSqCuV5CgD8fL/kW0AlZba9oADRyo/zKf7aQyQ
	6notlXXjLMFYbVyh3MCNH28+yIR8dsqLz3WK3Zey9zKGvw3+jJ5YNWHBquVXjkCriIslKubZ20q
	2tdOsHGG4ihaRL5sZKqwiAzx9JZfe4QBi/ofxlV8MI+megZ2j8nf5xhtd2KkKBrBzBqd8aCghmR
	DQFka9TnhTu43KBbvQ6dLXygKN6jMRss3W410uVJRbdAx2aVf21PcqNJI6vwb6Ea8bjWrxfF2wA
	aAHQ4qe1nGSg4Kp85aQWIwcRfVNxO0x4KJqiBJ
X-Google-Smtp-Source: AGHT+IHJsqK3225QNg/lHSnOP7SQXHe14YnI4hlpXDxBwQPf4by5o2ZcPMaK6uU7gFSHpt1eiaYvcQ==
X-Received: by 2002:a17:902:ce83:b0:298:ea9:5732 with SMTP id d9443c01a7336-2980ea95b02mr105165995ad.41.1762857777500;
        Tue, 11 Nov 2025 02:42:57 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29846334db5sm9875235ad.32.2025.11.11.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:42:57 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: qcom: Add support to validate direct DSI
Date: Tue, 11 Nov 2025 16:12:45 +0530
Message-Id: <20251111104245.3420041-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111104245.3420041-1-tessolveupstream@gmail.com>
References: <20251111104245.3420041-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds device tree support for the Waveshare 10.1-inch
MIPI-DSI panel on the QCS615 talos evk platform.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile          |  1 +
 arch/arm64/boot/dts/qcom/talos-evk-dsi.dts | 43 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-dsi.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 282d744acd73..d5a3dd98137d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -306,6 +306,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-dsi.dtb
 x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
 x1e78100-lenovo-thinkpad-t14s-el2-dtbs	:= x1e78100-lenovo-thinkpad-t14s.dtb x1-el2.dtbo
diff --git a/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts b/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts
new file mode 100644
index 000000000000..8a6dc8b6bf8f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+/dts-v1/;
+
+#include "talos-evk-cb.dtsi"
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	display_mcu: display-mcu@45 {
+		compatible = "waveshare,touchscreen-panel-regulator";
+		reg = <0x45>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		enable-gpio = <&display_mcu 2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l11a>;
+	status = "okay";
+
+	dsi_panel: dsi-panel@1 {
+		reg = <1>;
+		compatible = "waveshare,10.1-dsi-touch-a";
+		reset-gpio = <&display_mcu 1 GPIO_ACTIVE_HIGH>;
+		backlight = <&display_mcu>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+};
-- 
2.34.1


