Return-Path: <linux-kernel+bounces-871226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7BC0CAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB18C4E8B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266A2F39BF;
	Mon, 27 Oct 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEfWoQFg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715A2EFD90
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557549; cv=none; b=IX+FwLQDzTdw10HOasor0slSIbFDsIY9KkPEbvnmQ6pAcFv0ps8JT73U/MWrDU8jtH9RlNFzpabG6vy8I3fvY7FUl8jU8vBiScV2QiRsyxIaoAz+ANS4ws5gbNyCiuwCH9QqRuTNFKHujGuGKvMtCFrbWs6ov0e+LPVWwA7WCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557549; c=relaxed/simple;
	bh=72/KDI0ED0WOuGQa9wsAl7If0x4o4qq3O0o6SEkbMDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUFVWaoVNaOXX6gS7yAHg1xR/13iXvjtHtHfGz/R2C3SaswOLr0TXCXZJrZiKB12UawipwXHajXDU8DwI+mnSLzGMvq+hgDUIMkOHKMwqItkqbCbPspZ4i3M4xMcCbmSx64+ztH1UFsyMTsJyv1uK/Xu5HiCi7dI2nfn8g7goWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEfWoQFg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4736e043f9so814558566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557546; x=1762162346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCQDnPWqowHG59QXmb0jLVkKI2rjRu35406X3JQiDVY=;
        b=MEfWoQFgX4dqQWoaBIY3Ty8zpZMxOTF2QyNzGnBERQV+ZbMRA83qL/ACG8TRMCBwKH
         k/N/O4LHT51b/b0sGOi6e4eSRGx26+haznX0h64EPArqRdfl/34gKoJthfn1hOUDJ9z7
         L2jOWw2SkJHDZBvmFIXZBv7L7C/bPHsb7QhNZ+t8w0kziYxqFuWEc8ujrrC+oGyOOdGv
         RMzq3nXuCy851TPe9mxZQlm2BDkccj1go05B4aoiahzrCE3Hqg5my0DsRMwAWZTgXW7R
         7fIVEYY/HPkAMxEPK+kzZO7koItgo3hj9//P/tgD9dPFVr7PMhmuJS1ZUFMvuhxkzxcD
         wr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557546; x=1762162346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCQDnPWqowHG59QXmb0jLVkKI2rjRu35406X3JQiDVY=;
        b=e4x7GXn/EihINNxx5vtZxXEX3yWS+Jzw5DxF9TibVMsOf7skhheyw9PZWvqjA76uHh
         u482/TG03gLhVBYBCAYGKADeeY52FKbVGVQICASyXu5NKGiiFhwdwtfFKf/Hq6fo4YZc
         K2A9/CKR98+zhDkCnA9w8fET5IjHI5tAgi+9z6f0jBQDf+oo8RQibgNuyfz/hpCJxxpS
         7jEMeMghhhwAeAdd4wMXHS8h4V8OuLAtL5663ylLDl93JIzQkwXZ3yOXzmoyIkxslcsj
         E91lThH1AnaAQerga4CjKaZ5ZdizuoZjbgGvDYjmxpj+NdENQ8YrKL40aQVZS/mvMaeo
         MsYg==
X-Forwarded-Encrypted: i=1; AJvYcCXAOUwG21M2g09QF18W+96QJjszo48UX2diE/o7YCoyESbMaEbyCFj4r3XiogLKSlY0VNEl6Lf73EKua0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwvDrxsRhFGylYZ0WBopgITVOsbW8U+MXzVH6zyLaRBLD9A6b
	QjtjS/YjzM6cp3WQ3kP2V8mvX9del9eMRk4ZGq3D04CK+XG046UuptFJ
X-Gm-Gg: ASbGncu39vtss+HcNeAMQby0aFWyqvUW/lPLUh9ltT9AKwPdy0s1XL1IEDA1rP37mDH
	TGOnNz3y5Y84OMzFIPVHPaGdRVjx3niMPFVazLj/+bL8G7ESBMvsNCKazq5yfjHLVwjn0sKpyiJ
	ozROTuW+omFn71ffQF2m7ahDShBFIUAjKrZKTUNDw9QaMJRtBEpV/nPwPYkhOqzZ66Jw10U43sx
	E3Ia6NZIh/3LHeWSfb9VfisUZ9grx+MLpZfiQbc0k6KbmwJELzoXDGXVdbmfOfEUW1yUQ6UDfn7
	Z8uF5TBVJPm2f1ZO1j4m5gFr3gSeWdtXcG1okL1IguqY6i3kkNRBL/cvpEEpXzk7k6Lq5NaixxL
	X9s01PGYHCNEaNY6n/jiGioDrcKy24um48dqH8oJAhQRZ9loQmqVe0D/9eNum7bKsMOrvaTQjsP
	SELXigZMRKzThyn4UDvjrjOcrfvy9LWhSvdkeSEtnwHCt3aMuauqEd3AIaJRf4+1BnUf6oVU0AN
	oLzOg==
X-Google-Smtp-Source: AGHT+IGjcZLCWHusJQ+RRTOnS62EVI4AzVgjShANu+qiEsSh8iA493hRxBFjM7nRHQfw9gIc6kKZYg==
X-Received: by 2002:a17:906:4fc4:b0:b3a:b22e:dd35 with SMTP id a640c23a62f3a-b6471d45a69mr4222583766b.2.1761557545758;
        Mon, 27 Oct 2025 02:32:25 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:25 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] arm64: dts: imx8-apalis: add thermal nodes
Date: Mon, 27 Oct 2025 10:30:08 +0100
Message-ID: <20251027093133.2344267-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251027093133.2344267-1-max.oss.09@gmail.com>
References: <20251027093133.2344267-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Add the thermal-zones and cooling-maps nodes for the PMIC device.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 30 +++++++++++++++++--
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     | 10 ++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 6ebeade2ce72..686fce7443bb 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -226,6 +226,34 @@ sound-spdif {
 		spdif-out;
 	};
 
+	thermal-zones {
+		pmic-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+			cooling-maps {
+				cooling_maps_map0: map0 {
+					trip = <&pmic_alert0>;
+				};
+			};
+
+			trips {
+				pmic_alert0: trip0 {
+					hysteresis = <2000>;
+					temperature = <110000>;
+					type = "passive";
+				};
+
+				pmic_crit0: trip1 {
+					hysteresis = <2000>;
+					temperature = <125000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	touchscreen: touchscreen {
 		compatible = "toradex,vf50-touchscreen";
 		interrupt-parent = <&lsio_gpio3>;
@@ -833,8 +861,6 @@ &spdif0 {
 	status = "okay";
 };
 
-/* TODO: Thermal Zones */
-
 /* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
 
 /* Apalis USBH4 */
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
index b1c3f331c4ed..8a37cbe922ac 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
@@ -11,4 +11,12 @@ / {
 	model = "Toradex Apalis iMX8QM V1.1";
 };
 
-/* TODO: Cooling Maps */
+&cooling_maps_map0 {
+	cooling-device =
+		<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+		<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+		<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+		<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+		<&A72_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+		<&A72_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+};
-- 
2.42.0


