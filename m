Return-Path: <linux-kernel+bounces-844157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA5BC12AF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ED019A064C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD52DCBEE;
	Tue,  7 Oct 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw1ycah2"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94D2DC790
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835925; cv=none; b=jT9rxlReW9lbgkAbzYHl0C4PxKM4RzGnZf8cn8ZvoCWaGwAb/CH1aiLxRZlvGfaHPjbqlf+/XJIi6SV1FYrJKX428/ZMG7rl9wNxhF1K9fI7poJo8O1jNUotxJWePuf0OwuO/P+LwMx4SSDO1ISDT0waxH4F/irPFl3Df38x3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835925; c=relaxed/simple;
	bh=l1N1qUSs7aNQur915ZEPIIc8ybGkzYfyM4nn88B18eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAoBP+IHWEovnE9kgFq/x8447g/79mHbuVbDG0uil4a1cf9NK/bs6scjmKdDbc3qSWcb/r7MXBYn1/uTgJ338ppN8sD+sOR/iePzk/kmg9U9+K3HS5MewEA6jWvLSHwv+K6UCsFNhHu4LZFK9Rm8N2lTcoPDNo/IdDXMUaZF8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw1ycah2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5506b28c98so4313290a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835922; x=1760440722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xSjj3Iwg14xHIfiMziIXjcapcCofRPyKMdiFHmwd9k=;
        b=Pw1ycah20Hc6dyibu10Bo6Df40KVcFkHwtBDcZkDyV7NB3mKcBt5WgEpPfn6BP1u8I
         Ae1O7D1Bpo2el/z4y4rOygtWBu3E5NJFohoYOJjdLUlGK1mUOHz25AIJk3zIVWBxydLA
         1xJB/Dw2j0iRIvWrGGMAwJ2thTJP8/N2MF5J/G2KV30eQXcDqRXUXLntZ4wsTK7g2nzw
         t9VrElW8Ie9HfHNYsJE8kmI+b3sLSdIDXgE8k0tTKM0L7J/l8SKwJr/IzmyqqSDv85ss
         lC4IDoIxMm1PRy9sd+JrOtNLsttEbe2ze7kJyL9e71z2AjvA/23TncWIbTrWLOTKOj/Y
         WRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835922; x=1760440722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xSjj3Iwg14xHIfiMziIXjcapcCofRPyKMdiFHmwd9k=;
        b=F/LBWCPpsBa/Ovm7mXDYXRS8xcFT2qRQu740RO67AKef8pV08/nYyX2JJrqlk9Cd/0
         V3Amt8XGQNZtrzfiQVenWMOtOQG4yzAEAdVRHvY1QPKI4Cp1Y8CuKgMT1alLtyx4RmDN
         NhmrPgu0RWYSjV82AaS8VChjRWc18/YVPgbKT4/C9SjGXsafUpxmYFJpVFGdDDij01WB
         YoAkgp5+IHfcTXm/27tSXCK433RIAYCQ0kFP5FuzmAX1fgCGiO/IjSdIk3k2yl+/nT/+
         qlriQClz+FcVZrSkAzcuRS7lE+Sgppvzshy6nLj/JJ9OtryF8dL43u2ZMxnh572ksb4o
         XcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsj5+OuC9gQfkSAUZXAGfzoLZHAIUCr2qdUeswYtpzIRSWb+4wa2UUGDLFNcMA9vFqLHRajltBcN4CLzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUH2oY++czdzg+x51lIUe/kz1QRu8Sk/+ilQxj60hi+jXxXas
	UhDU9QyG9fZWsMS/raXjM86aV9hDkF/5Dk0DdmyG4ktzAEQ2BJyskN74
X-Gm-Gg: ASbGncsviJkFOokAT8IlfpQt7xWLgXEJmsGH7vh97Sxk3+d9v86/zAyMig6YnagLtME
	v3QO6ffRFwgoKVucW58BfuZbyysMXYyrE3YdXyRApvoo334MUyeAwiijk5y6m9meB1G2xuvWCgk
	3pA/x2dmNft9DjT9CbYzxY+8v2rTyw9NWCOazdpXBKCSpGqiFZruK6HPkfvTbvQ/a/b4PGWSNaL
	gV6oIMcmAsf4rxFhZRihfTRZLx54aBjseomkBoZJrCat0bsxcpoIa9ktWWoc9sLnLgbXc+HfDeF
	YR3415ggFglM7PqC7Px5lbQD5WIfQBk2Qd7gup1q9JEpNCwOxlAU9vGJASWV5qgJwsTljdmvfrq
	gethHMf1sQKIrI9g61zwCY9Rg6FLIax7QnieRxeTNpLY1qxRzdpSCQBKVI9VQlHwJ4qziaAWP+v
	LvdKK0tS0YBaMIp3dKi0bWGBRlNVWNNY2PMngafGeUqA==
X-Google-Smtp-Source: AGHT+IHQhWG4at6c4CSv92k3Kc2ZO7qLCe+WK+3iGElAPZoi7Z/HUsioUEndvALrS7T+2HHEi3fTMQ==
X-Received: by 2002:a17:903:2409:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-28e9a54423bmr206134295ad.14.1759835921894;
        Tue, 07 Oct 2025 04:18:41 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm162509045ad.94.2025.10.07.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:18:41 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 07 Oct 2025 21:16:52 +1000
Subject: [PATCH v3 11/13] arm64: dts: apple: t8103, t8112, t60xx: add hwmon
 SMC subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-macsmc-subdevs-v3-11-d7d3bfd7ae02@gmail.com>
References: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
In-Reply-To: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=l1N1qUSs7aNQur915ZEPIIc8ybGkzYfyM4nn88B18eA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBlPvm1b4qq69Uht7n7+Jkm98m/LRPVem4gxb5O6ar954
 s7df7ZydpSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCRqZ8Y/mmfN0l8cGTT+/aj
 HGrv5p1WYI5+xXPz5b3Eb+qv5wRNCpvLyNB8WqqikeUrk3D9m6SOk5mMvzVf6f3cW964bnHO3/P
 2XiwA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Apple's System Management Controller integrates numerous sensors
that can be exposed via hwmon. Add the subdevice and compatible
in preparation for the sensors that need to be described
for each device.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../arm64/boot/dts/apple/t600x-die0.dtsi | 4 ++++
 .../arm64/boot/dts/apple/t602x-die0.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t8103.dtsi     | 4 ++++
 arch/arm64/boot/dts/apple/t8112.dtsi     | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index f715b19efd16..e6647c1a9173 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -37,6 +37,10 @@ smc_gpio: gpio {
 			#gpio-cells = <2>;
 		};
 
+		smc_hwmon: hwmon {
+			compatible = "apple,smc-hwmon";
+		};
+
 		smc_reboot: reboot {
 			compatible = "apple,smc-reboot";
 			nvmem-cells = <&shutdown_flag>, <&boot_stage>,
diff --git a/arch/arm64/boot/dts/apple/t602x-die0.dtsi b/arch/arm64/boot/dts/apple/t602x-die0.dtsi
index 8622ddea7b44..680c103c1c0f 100644
--- a/arch/arm64/boot/dts/apple/t602x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t602x-die0.dtsi
@@ -114,6 +114,10 @@ smc_gpio: gpio {
 			#gpio-cells = <2>;
 		};
 
+		smc_hwmon: hwmon {
+			compatible = "apple,smc-hwmon";
+		};
+
 		smc_reboot: reboot {
 			compatible = "apple,smc-reboot";
 			nvmem-cells = <&shutdown_flag>, <&boot_stage>,
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 59f2678639cf..78eb931d6fb7 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -909,6 +909,10 @@ smc_gpio: gpio {
 				#gpio-cells = <2>;
 			};
 
+			smc_hwmon: hwmon {
+				compatible = "apple,smc-hwmon";
+			};
+
 			smc_reboot: reboot {
 				compatible = "apple,smc-reboot";
 				nvmem-cells = <&shutdown_flag>, <&boot_stage>,
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 6bc3f58b06f7..5a8fa6daa00a 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -912,6 +912,10 @@ smc_gpio: gpio {
 				#gpio-cells = <2>;
 			};
 
+			smc_hwmon: hwmon {
+				compatible = "apple,smc-hwmon";
+			};
+
 			smc_reboot: reboot {
 				compatible = "apple,smc-reboot";
 				nvmem-cells = <&shutdown_flag>, <&boot_stage>,

-- 
2.51.0


