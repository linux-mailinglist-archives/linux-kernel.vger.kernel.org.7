Return-Path: <linux-kernel+bounces-878165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E64C1FEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D17B4EBFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F110337BAE;
	Thu, 30 Oct 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2UkVujz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CC34D92B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825773; cv=none; b=kjyH77570bdzlpwAQRdvlAzLD80cxpZ+Il6OLK8+AhV74Tq2oslKOCmCwfu8eYmSFsauL8SWA1pJUvMB4hp1rAk4dnoAsIoqCubFSQW0npraWUWyx4hn3qPs349WboASnbUmdjLVf7ae0AqKVJtSX28qKPhYxKfs/OT7heNcsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825773; c=relaxed/simple;
	bh=e8pxQEqLtW1Slow0rZY/48Rg7tSYJ1oUbuHVlI3G87Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGgj+r2JXK36om5de3VDrdCm7CPEYhYcXn67ffCRlBw14jAGSFlnUnTjp75RcIONbhl20FkhWXtrQLy086YzaFgbwezrU82w/To9mUIm3fmqIAvJw7FonniUjebLJ9+SgkEvtgF77ObQ7BOqVIpW+n5z6LDtccZZIVkYnTrNV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2UkVujz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so634093f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825770; x=1762430570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu8nOseerJIwiaKexI9V+78CH5dDbgipqtlgAiyDwbk=;
        b=S2UkVujzedid05Hj5qKYXwrjUdQ7uAW/1SASx3DekKx8tMNZDGcjCe2EanAd1TswdL
         dS2cf7/AkThWBjOPuJM64qCy9I96umdA8E4iGq3Bw3KPCJ2h7QzzSA6t/mcec9aNMKIn
         yPxxqy1hB2MrEVQ7AYgLb9+NBYyH3TsCE5SlwBdLaBmNELiwuwt/4XjoxG22tNcZo6T5
         R8fpqInZ4Dfb6Uy6NuTwharSK7vFQOKJs6isLGADio2bj1H/wrfydwtb613L0uWlWkNT
         1YlW+h1J+NqcACUgPCN+zi9m26Q1uIaFDeMvjxjxYzAtlcRZm6LwHXeaMNo7yg/FE7X3
         YvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825770; x=1762430570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu8nOseerJIwiaKexI9V+78CH5dDbgipqtlgAiyDwbk=;
        b=XbBqwLJZoj9AkufHnfhBzos7BGEM3Fi/u6zSFPQmuszeNN3CWOlD4Le71AS9niKmVV
         VRTyrenZXEvkS1FfDNl76YJmZumFtwJtH9ao0Nb9qoEaE4VDdFyIFbUCnP7xWuvNIOqi
         NZVW/YYcbMtlLyrMZfgj39pD3Y4gQ6TJsnYeWjez9BvAItZsLMkaCKupywDcOzIA0mV7
         /vEuSEdCcpkpT4bX7siN6Mdgnz8AdzfyzoAlFoLW+kPDAcdkN4jobNkgwy+ApERKr4jY
         M+vNmYjlRksutuRf+zBx6+27VEr4iwIx4QuCqTE8/jqGyk5BJ1M/RkaiKZ0/J1KyYT1R
         Nm8A==
X-Forwarded-Encrypted: i=1; AJvYcCUFO5LqNW6RjVN04rFIiEMMHd4NQef7qnteE9YcnlqCoGDKijGjhEd7EtSacHP7vsH/C/y8qDM2qebHU9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6KtBeosy9YTIV4rWxlW9mV2dlBT4NZ7ilqmQzS2BigSqulYu
	vPULOdi1yW5Knsz98J34/4MaG7Pc60lztPXrXW0GP5OvAtF+Aphvr+Ht
X-Gm-Gg: ASbGncsx+LxunYLIzIDHiH1DkIVinkhL4xl5WsLnbzSaGwr+gwEXYl9k/cO6e2nl40q
	ODtCRrA5gdZ0w0mrB32wm+ehtKSpsF3LTvddoa10pfIvL+1j9n+VzZC0kgF/ppE8i4EKmxww6wA
	oCyCpyRSFM8YPXsww2BJFmJOaOurzVoViaYmCnX+M7YIN/qzJnKG8rAb00Fs9M4PD/sQCEGd0YS
	ZrZwVTTwdHyPhxYnWYdTiWSahN7cb//iqeKvzGPF9kWfiGC1ipVyevG9fa6lh0lLzEsHSKli5uD
	Kbf09UC0lsn02P+3OsScE+cEXNJ1uyLw/EmLA6UeSJ5+GsVzU4x8SlBF1g2WOw3pUxZgcDk6WdF
	IGGXgqvVgvIRhuTtS14eLxA8U/MwgDWsVs3chxVMtkZiR3SoYWIzQl2k5a8jJeNFCVk39WRGuQF
	mdqskaPsX8k6fiordjR8BK8C35cwvBz7zAM66cQnZTvITGgU/tYgvEXhauxg8zddN9IomZg5Jl
X-Google-Smtp-Source: AGHT+IHFni13l9ewEcMuX6++qZosCb8kSPle7LBBV+o9CF/LKnPDmcWv4Piuhrw/JZlMYaZ2eGkiDw==
X-Received: by 2002:a05:6000:1a87:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429b4c73527mr2728446f8f.10.1761825769830;
        Thu, 30 Oct 2025 05:02:49 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429b9b436efsm2399848f8f.23.2025.10.30.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:02:49 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] arm64: dts: freescale: imx93-var-som: Add support for ADS7846 touchscreen
Date: Thu, 30 Oct 2025 13:01:24 +0100
Message-ID: <20251030120127.509933-5-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030120127.509933-1-stefano.radaelli21@gmail.com>
References: <20251030120127.509933-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-MX93 integrates an ADS7846 resistive touchscreen controller.
The controller is physically located on the SOM, and its signals are
routed to the SOM pins, allowing carrier boards to make use of it.

This patch adds the ADS7846 node and the appropriate SPI controller.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v2:
 - Fix pinctrl alignment

 .../boot/dts/freescale/imx93-var-som.dtsi     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index 0b7f6740e5ad..2dc8b18ae91e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
@@ -212,6 +212,38 @@ wm8904: audio-codec@1a {
 	};
 };
 
+&lpspi8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi8>;
+	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	/* Resistive touch controller */
+	ads7846: touchscreen@0 {
+		compatible = "ti,ads7846";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_restouch>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <1000000>;
+		pendown-gpio = <&gpio4 29 0>;
+		vcc-supply = <&buck5>;
+		ti,x-min = /bits/ 16 <125>;
+		ti,x-max = /bits/ 16 <4008>;
+		ti,y-min = /bits/ 16 <282>;
+		ti,y-max = /bits/ 16 <3864>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,debounce-max = /bits/ 16 <10>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <1>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		ti,keep-vref-on;
+		wakeup-source;
+	};
+};
+
 /* BT module */
 &lpuart5 {
 	pinctrl-names = "default";
@@ -307,6 +339,15 @@ MX93_PAD_GPIO_IO29__GPIO2_IO29		0x40000b9e
 		>;
 	};
 
+	pinctrl_lpspi8: lpspi8grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO12__GPIO2_IO12		0x31e
+			MX93_PAD_GPIO_IO13__LPSPI8_SIN		0x31e
+			MX93_PAD_GPIO_IO14__LPSPI8_SOUT		0x31e
+			MX93_PAD_GPIO_IO15__LPSPI8_SCK		0x31e
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
@@ -316,6 +357,12 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e
 		>;
 	};
 
+	pinctrl_restouch: restouchgrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x31e
+		>;
+	};
+
 	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK		0x31e
-- 
2.43.0


