Return-Path: <linux-kernel+bounces-825442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA0B8BCF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7645A477D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487914A60C;
	Sat, 20 Sep 2025 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhMm8xki"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0127735
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332828; cv=none; b=keEXJE0SQciLaD9/ojHYfSYJWO1+1nIqpfeEI1NsH9+W+TZVCqr0hqNlAfvOrDuUWEl7Vw5WOLssz4WiFYfQoW2rSMaHKGbP+99HUjX6VUiGdEB/huWZVhcyGJOpPFP/6hYYQOqrlNfZJvcFWtEtkINKajYPl5B24VRb3a2qczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332828; c=relaxed/simple;
	bh=wttyNu3FB0JHzpeprhteba5sV89v7tUiRECg5BE75Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3noiKGoXuTZJ9pId+LadMDZ7PUDZ+SvESZhQ6+Jf3Cmgz8H9CBeqMd3tuHfytxSQ1/QG+HudYt4nl+9uMS+6+VA5SpOhM1HljqEOrLMpqIo5ZaJFPMDbY8iuoztAIZlLrM3w8XhPguJf/ZS5WGGEkxCRVfo9bAbj0x8hFaE3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhMm8xki; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445806e03cso33079945ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332827; x=1758937627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcxgtjVmCUZxaigJVlvyZe7TDMmHkjmyWKCsB43+itQ=;
        b=JhMm8xkiucygClKtWcJDQyATzF+yhqdWj//AfVdMkCqpkbgpI0eH7GMyae9ib4PCh1
         daHwE9qtgdQSETWBHsouSU2qrU9qlaAKINjy/j9LUcUG7/xderIWV6y4kuNzYNiKL+jn
         GJv9Srs4QMdzfK2rv+bR0p8MKS1umbyPMk8umk1dkR4XBeUrjpURtMyJ13Sv/I2w7I/2
         /6RsoTLbVUZfvQdMJUlLbojytZVf/Kyh1jEVxL139ZKs8Gea2bBCAN8/RkjuJosOn1v+
         gkiWSUoUmL3Mi7/Wf6TJ9k2y7zQmtG5vE7gHpA1MTELa+w+lvJs/hjA2AmHcwmDpZWxR
         b9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332827; x=1758937627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcxgtjVmCUZxaigJVlvyZe7TDMmHkjmyWKCsB43+itQ=;
        b=IgITumQgybzPOrVn7XJU6VJkyvIOOZPi2oNV/Vgyer9gAQr2TcVoUPNp1XJaZAAA7S
         BoPVuQOaB5O52OQcH+D7lwdLuEXXdviT2eOzZ9dS3jLUG1tjeln8b8weoupi5DSt2y/c
         /dtFXoKQD3kZ83l9apX7/HDH1EcGM1cNjkxExVXR8MqvYyS43flq9L7UIoLWFTkiSVSl
         FT56txNt/cb8BQ7hQANlekDT8v4MnJrhf0KjwWB3pUaBletxgyJdq8DyQG003Q6Y1jvD
         xofliFbLRkaEtHyz6Zwp5EE2PyfdFCxvfD/J6Ek1/yiTDKms6q8DNeqrNxegqSgVrJFE
         hpZg==
X-Forwarded-Encrypted: i=1; AJvYcCVonSnjNpyN63pPQp/KX3O6I3oPMsTXKNxQogHuNG/dJmaZhWRjLAl6p39MVwj7UpmlrminGAgR2ur/tAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySC03J2BETQ64rUiDbkeWTZBFQ2/wgsBZYCQXReXSk/RH+PCtl
	ojvyc75ATCi8YnyUDYUe55kCb0RP+is80aWsBBF1nrnYZQxgOIh7fwf/
X-Gm-Gg: ASbGncvEsK4fRsLzG0PkgzlulFa+LU48aIRhxXCg08NEkPv13/BFlyIfT+a5CzAv7Cx
	W5+SLqL6HnstGbPs+7q3jnfA2WdQGSltI/cB/vE/laPKBHgu+SHlH9FMnqcQyEjaIp5NLRvH22V
	aqViOP4B2NP+1vg9AZxHI2SfWh9lGXw9cpQtPruPHFRDvDLShmkhi+O5EZ0sJVUEnj8VsIwUpFN
	djap1LX/gMHqiieZZGWJTDeE4+bfb4+Rf4mkSJNAcUaJmlhO/nbLFuf7SvcHLS7ZBsAfXEyEXDA
	/xlxZFUSYJRgAEEbcVjgIARou98bCA5FJXobVyYNAYRXu8Cav3eDDqAyGzdWGyEOa5OA5LvAxP6
	e7/fL4FZCvNnWlYBFPsoU
X-Google-Smtp-Source: AGHT+IHu1VNSw+3ZcwebyxobluQNwXjhZ7r3UWUU730aQvye7TB/kSMESaaIT14huvuykOXkg+coQw==
X-Received: by 2002:a17:903:90b:b0:263:b8f:77dd with SMTP id d9443c01a7336-269ba568cd3mr78159545ad.57.1758332826778;
        Fri, 19 Sep 2025 18:47:06 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm65709455ad.131.2025.09.19.18.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:47:06 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: qcom: r0q: add gpio keys
Date: Sat, 20 Sep 2025 01:46:33 +0000
Message-ID: <20250920014637.38175-2-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014637.38175-1-ghatto404@gmail.com>
References: <20250920014637.38175-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add GPIO keys support to Samsung Galaxy S22 (r0q).

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 53 +++++++++++++++----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index 880d74ae6032..70e953824996 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -2,11 +2,12 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
 
 / {
 	model = "Samsung Galaxy S22 5G";
@@ -28,13 +29,19 @@ framebuffer: framebuffer@b8000000 {
 		};
 	};
 
-	vph_pwr: regulator-vph-pwr {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-		regulator-always-on;
-		regulator-boot-on;
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-0 = <&vol_up_n>;
+		pinctrl-names = "default";
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+		};
 	};
 
 	reserved-memory {
@@ -47,6 +54,15 @@ splash-region@b8000000 {
 			no-map;
 		};
 	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -119,8 +135,27 @@ vreg_l1c_1p8: ldo1 {
 	};
 };
 
+&pm8350_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
 &tlmm {
-	gpio-reserved-ranges = <36 4>; /* SPI (not linked to anything) */
+	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
 };
 
 &usb_1 {
-- 
2.51.0


