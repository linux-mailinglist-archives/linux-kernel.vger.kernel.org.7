Return-Path: <linux-kernel+bounces-729922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1224B03DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D913B7D00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5C246774;
	Mon, 14 Jul 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iw9K/rvI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE021E47A8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493718; cv=none; b=Ti+g2+kJR+Idaf6IpUHuVUmlcZ1JgRuNAjKu9DzcQY2KsbJ5aXRF6PJWjKdi5IkLvb88ChjyjsvqFyD4g2HGmevw2LdjWyUFx+z6qbWVSK5fwUYxsutxlN0Orh/KjKXaizOgbstjrOUbncTVWNGFVddS1LgckGjsbDsJI3b3J20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493718; c=relaxed/simple;
	bh=tna5dLV3FkoihwjhvnZRfnme1kg+1D1J5pP0OU+C7tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZS24on0XMwexdbAd6J3QHJzqhq4SojQk5YrjobEYHj4LAicTs2MgTJtwQbBTqgda7rQwuPZ/iVD2Mvjc5e/BZxvBDGAKuE/ww6sev8udaRSOxGcrgDD+edye5wEyt6D2zRAs3fcrAmXGPXEKlkfy3PVr5bAagZQKG2RvuvFtFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iw9K/rvI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45611a517a4so3929435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752493715; x=1753098515; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrXb2WAM/2BOo1nQIRcq6S4LqmZekvDumGZAiTpraHg=;
        b=iw9K/rvIhiwy8ON8i6+U5d6xEHXmRqsU/0mgJIyMT2BMrwQLFmthJHTtP3G4+8kMiQ
         fGHU6BoiiJ3CG9Zh8xjML7sunkjBuOrW8oSRfJwVJ+poWQc0hIuMhHQOhKOg0lCph4Sx
         kFbwyC3BZUN6w4qOwUYfLqxntmu34jdFlI7R3UWfb7Q1oiouubXNv+mTSw79ikz0wB5Z
         lbRvZ52/sesDidcDafrw+ZaykAbBAASvpb+7TkBJVFGJrxVnHCgRz7iITP5H6/G+reBv
         g1FfUY8mawixHrsJe/sFnfwDx2EoJgCsmbkw5r+WkdqJkVP6SGn74UG/2BFoRJLlxQ4z
         vjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493715; x=1753098515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrXb2WAM/2BOo1nQIRcq6S4LqmZekvDumGZAiTpraHg=;
        b=s3fOXncn1eQlQUpG9eEGStYYXZiRxYiI9JE452a4OjqzyLaIgp2pvvlRvqCj1qD2oF
         xZodawBWxfRY57LijxVut5XUsgKuSNWL+mpNbEpzIwyfyo2+omRjPn1OgBbHIz9lHTxX
         M44JilcsrsWCAQeviqMD87+h3RF7UoPPkGADFUzIBQROaIj/fpvUctYmKQXOn/ytHsEj
         MDQmWMx0szl2wQqyY72KaaFcJlHK/SlynhSk0P/K2m/hS9fS+rl1DBHIsM05r4S30D6+
         ngVwPH9Z8lFU0SnoOjF1HGQTxKKJAEL0wsLUPR9ChHZSDjqN4PXV4YgHgzIQGE6H3jRQ
         hBCA==
X-Forwarded-Encrypted: i=1; AJvYcCXAjvyU3UnF9SWwjaRUrbNyCWZupNW0CGXJo9XkTOpa3lUf7VR/J+WC65TA953/baRm/BGoSlrTPdj3GWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzLojRDMtcX8TzXcwFvqfDyRjS57/GX5LqBpqRGUW9c5XLKsP
	Wnxr352MiN235304JfXLR1dSrNZG6vNiHaEtlQNNb/7t0WZDQTaYcQGhNDXQrSujm71aW2y+zA3
	Ig2bZ
X-Gm-Gg: ASbGncuiSNkH1kWCd1HNv1xy7BD+Yn0iFYZD4sOl3wHJTgQKEN2aaaSDSyfX2ZT2j4x
	nk2+XKj1R9BFuMCo1tavCFiY44MSjXqUjgUPFUcJBSl0266WA2iPe/6WRKpMbwOmoAR/LrY0FHT
	47Q5+gfs6ZwxBur4RU3GlCztyrcQJ1aJ/voaNXafCy0dmkBeIN1cAY1lfftRx4PJC6X2hbfUls4
	GjKpZxtCkc/hK9Ml79ETzMGaoyFBTscp6qXLDmXgj4shq4/4DdQjlOd5udK3Id8pv/hjua27jmg
	E92SixeXSgwJvSHbQyr6P46BvktIYjDBhjiAQnZxTUxT8fuY25hrbWpUrJdBJTR1DJNhveHnLF8
	pcHiQ35TVcGbcW3jSHSsGk6mQ+VDoFtM400N0bw==
X-Google-Smtp-Source: AGHT+IF6yDHqORZ0MamyNX03OxUZYY8wce9Taz/nJCLQrMm/ptKAPpdbWmWfdS3FD0biNI03MzGk2A==
X-Received: by 2002:a05:600d:7:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-454db8d8cd6mr133757405e9.15.1752493714879;
        Mon, 14 Jul 2025 04:48:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c96e:1862:d33d:f504])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm12426359f8f.14.2025.07.14.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:48:34 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 14 Jul 2025 13:48:15 +0200
Subject: [PATCH v2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint reader
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-x1e80100-crd-fp-v2-1-3246eb02b679@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH/udGgC/2WNQQrCMBBFr1Jm7UiSmhpdeQ/pIqbTdkCaMpFQK
 b27seDK5Xvw318hkTAluFYrCGVOHKcC5lBBGP00EHJXGIwyJ621xUWTU1opDNJhP6NzxoXgL+e
 uaaCsZqGel714bwuPnF5R3vtB1l/7a7m/VtaokELzsLb2hmx9e/LkJR6jDNBu2/YB7sgUfK8AA
 AA=
X-Change-ID: 20241115-x1e80100-crd-fp-8828cca97d66
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

The X1E80100 CRD has a Goodix fingerprint reader connected to the USB
multiport controller on eUSB6. All other ports (including USB super-speed
pins) are unused.

Set it up in the device tree together with the NXP PTN3222 repeater.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Describe all PHYs, also the unused ones (Johan)
- Put #phy-cells property last (Johan)
- Sort supplies alphabetically (Johan)
- Johan suggested dropping output-low, but together with bias-disable this
  would leave the line temporarily floating until the driver probes.
  Perhaps dropping bias-disable would be better since it shouldn't make a
  difference for output-only GPIOs(?), but for now keep it as-is to match
  all other X1E devices.
- Drop defconfig patch since Bjorn sent a different one that was applied
- Link to v1: https://lore.kernel.org/r/20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index c9f0d505267081af66b0973fe6c1e33832a2c86b..730b27c878fc7bebc9d8c0d055cbd7e635140d83 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -1016,6 +1016,27 @@ retimer_ss0_con_sbu_out: endpoint {
 	};
 };
 
+&i2c5 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	eusb6_repeater: redriver@4f {
+		compatible = "nxp,ptn3222";
+		reg = <0x4f>;
+
+		vdd1v8-supply = <&vreg_l4b_1p8>;
+		vdd3v3-supply = <&vreg_l13b_3p0>;
+
+		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&eusb6_reset_n>;
+		pinctrl-names = "default";
+
+		#phy-cells = <0>;
+	};
+};
+
 &i2c7 {
 	clock-frequency = <400000>;
 
@@ -1466,6 +1487,14 @@ edp_reg_en: edp-reg-en-state {
 		bias-disable;
 	};
 
+	eusb6_reset_n: eusb6-reset-n-state {
+		pins = "gpio184";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	hall_int_n_default: hall-int-n-state {
 		pins = "gpio92";
 		function = "gpio";
@@ -1747,3 +1776,38 @@ &usb_1_ss2_dwc3_hs {
 &usb_1_ss2_qmpphy_out {
 	remote-endpoint = <&retimer_ss2_ss_in>;
 };
+
+&usb_mp {
+	/* Only second port is used with USB 2.0 maximum speed */
+	status = "okay";
+};
+
+&usb_mp_hsphy0 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&eusb6_repeater>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3c_0p8>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3c_0p8>;
+
+	status = "okay";
+};

---
base-commit: 0672fe83ed07387afb88653ab3b5dae4c84cf3ce
change-id: 20241115-x1e80100-crd-fp-8828cca97d66

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


