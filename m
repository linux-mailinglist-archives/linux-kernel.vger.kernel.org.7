Return-Path: <linux-kernel+bounces-814632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE883B556AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5297B5902
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F593375B3;
	Fri, 12 Sep 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOqhcZpD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFE3375B4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703406; cv=none; b=JoYuzSZl7HqoOgNVWN+5ln4tcP+wUK39nxrvFZweJ/tPchsdcI6GBtklcyaFvQxQ1izeuh0J1Lz9GZijq3oGdS7XpcpDHx1zLimmtBlLu3DXqmx7hSWB1eFHUQj/TtH86mlUfngIniJ7dYSZpdTljL1Q0UuwWcCCE9nKkbMTAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703406; c=relaxed/simple;
	bh=NuhdEUhqxZA+bUb3jcXwQjwqzeFpVk/pkWfNTnUfb0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCpjhuIzf6JxE9KXjfu8ZSwqVLOzVkw4Zsa0sQ05Kf1l6AhFHkwpIp1QERt/x4x6aGeJNtPRNMh6HjB1iebx9T8zBW4sEaQUH7KYAtdFVANvuyIGagC8mS09Q8yuFqsTe3bY6GYROky3TNLdoniOrAOCueZBlI4cHi+WahPGUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOqhcZpD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04271cfc3eso282926966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703402; x=1758308202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMFuMNHgQtIODbObQedXrsxWoqDPf7/6pdH5IDOcwpI=;
        b=VOqhcZpDGQghuNsJheC76zS4Wkg0Zq7Sm4A4SnmD2pVFCUH3HKZdnjBdI0hAXS7I57
         sXoa2Km4zVfQJvOD4yW6i2/ESksF22sXKstqktx33/ZgK8ESmUbbDb8OpHPpVSZkcDpj
         NQXB8GGys2/Wq6iHzGaN/9RcfXqoK2Sn0cBJgBECm+noViColeGSdgQzQDmKnsvS9lVE
         l71AxwQGP2F0mG3vX+s6Qji6id53C9CupaS6Opi/MK8u9G+9Rkw309cwYoLcTfKBeb6A
         w/5qtBynMI+TwmmxXiyJx2tF+cTgaQSvdIaYfjlpr2vl/XbNkjX3/lke5boJOH4e/RAu
         YU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703402; x=1758308202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMFuMNHgQtIODbObQedXrsxWoqDPf7/6pdH5IDOcwpI=;
        b=PHlttUMsE0keafCOmrvfBh/6ZpTXbsGw0Eb4H/JqOdzamITQZwENbBImaedG2GNMVI
         WzvB4YKbysX7Dc7I3TdhSZ/Rb24OQG6TMUDSzZkmf5U/Rkjae/UyiTpyjoiiyNCDLSyq
         Oj16AOf/Acu7T9nfeG+28897IFx6hB4KBr7SpIJE4lZ1lBATBRtVnKIezJrpLUDx9eEf
         GIpB8tIwejc7fkbcApODuF7vKtTIDXF1XpvMdF0ebRo9fG8X3EsbiduWP2zJ5F8ITWmk
         vNEp/Z8BYEAq31GJSL+kFXNWl26CWAw9SrlBefAYHTTlfjFlW1nCtOLmyEoKitpymcSj
         ll/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwbe65thxaMz1iKo9pEY019oRMpoP1jD+kStR96gTJwQHOO8vlDVfvOYiNAclKFXmny27d3Ch3+0QA69U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15hgu5Io207mHGJjQecI09UIFTRslPjR7mloXL5YUy9zN07mU
	XK9gmLXiXacwHw+V/H9c3GTUI5uIsg74cYDOCYyYsDTMwN+sC5odQm/W
X-Gm-Gg: ASbGnctUYHC0S/X9YaH/0AsYaB7yF5tODNb+EjcBocl2eGU4hCfLDgSdRwCMzotoysy
	NCDdJZpUI8U6DxTmDAv4dDfNxZYTHChRHZYg8X3S5ufS3IvAntlpAbKerZn3ofKh2ay12t9+H1d
	FvuaueebK+PIBof0G1qYU3ANg28AfcQlTpsWxvJO8eiSF6cUlFmKIh8DH/p8Zvl5IqfYCAsjpiA
	xQUhhJVFHFtqY4J9lYNrW701w6TsgOvwM684ocq+2kw4AmDN96E+vzqfHeXvUQTu/VxrwmASDeN
	+MWufHGFsDcKlJ0ruAsm3Bdx7gT/OVzBugmIw47KYChBCy7CrcqmjL7A71dudKL7UChjcTPN4Dg
	w3Iz0f2B0O3Ii8KHNlXDZaf9zyBouqtNz+uWwuOsLAg==
X-Google-Smtp-Source: AGHT+IGTL4pEw44esZuXiYOpXJ8UaMoJp/w5uz6YI+s5Fhx4tBOD/bNzTMRTfy/5dx0N6xED2ZIftQ==
X-Received: by 2002:a17:907:d19:b0:afe:ef48:ee41 with SMTP id a640c23a62f3a-b07c3a783ddmr386299966b.58.1757703402115;
        Fri, 12 Sep 2025 11:56:42 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b30da310sm418184566b.20.2025.09.12.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:56:41 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 12 Sep 2025 21:56:36 +0300
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845-starqltechn: add slpi
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-starqltechn_slpi-v2-2-5ca5ddbbe7b4@gmail.com>
References: <20250912-starqltechn_slpi-v2-0-5ca5ddbbe7b4@gmail.com>
In-Reply-To: <20250912-starqltechn_slpi-v2-0-5ca5ddbbe7b4@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757703398; l=1717;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=NuhdEUhqxZA+bUb3jcXwQjwqzeFpVk/pkWfNTnUfb0c=;
 b=bFrvnGE8VIM/ELvl0Z0h8PH1FWAGmZKloaOgGml5/7biOlmyMwusnSEYVqdWF1LOlxpDpiSiP
 kyb1B+zHMPSAyk9z6z6oJbOP3DXaGwaCejyAmSA+H76KZgj1crtcR4K
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for Qualcomm sensor low power island.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v2:
- pinctrl replaced with fixed regulator
- add space before 'status' node
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 32ce666fc57e..75a53f0bbebd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -56,6 +56,21 @@ framebuffer: framebuffer@9d400000 {
 		};
 	};
 
+	slpi_regulator: slpi-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&slpi_ldo_active_state>;
+		pinctrl-names = "default";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "slpi";
+
+		enable-active-high;
+		gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
+	};
+
 	vib_regulator: gpio-regulator {
 		compatible = "regulator-fixed";
 
@@ -902,6 +917,13 @@ &ipa {
 	status = "okay";
 };
 
+&slpi_pas {
+	firmware-name = "qcom/sdm845/starqltechn/slpi.mbn";
+	cx-supply = <&slpi_regulator>;
+
+	status = "okay";
+};
+
 &usb_1 {
 	status = "okay";
 };
@@ -1028,6 +1050,13 @@ sd_card_det_n_state: sd-card-det-n-state {
 		bias-pull-up;
 	};
 
+	slpi_ldo_active_state: slpi-ldo-active-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	touch_irq_state: touch-irq-state {
 		pins = "gpio120";
 		function = "gpio";

-- 
2.39.5


