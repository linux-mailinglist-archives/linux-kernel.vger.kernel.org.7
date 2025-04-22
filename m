Return-Path: <linux-kernel+bounces-613847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B1A962DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C84E3A9F08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218225743F;
	Tue, 22 Apr 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MbUQVUCH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4225A642
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311316; cv=none; b=C57DJL1ao/A5T1N8RjfFF+6S7rHa/fQ+6fkzIFnak3B4i+AfupzFNYL1cFx+6lZML/OVRbj8zGYHWUMixb6/fzHAdLrpGM1lqx8rwxV3X/9/kS+HrUiWAmteEBM6Nz3sMLoE+RzgA2ExvR9Hxzmf2audzP3dETD5tIjzdbJfN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311316; c=relaxed/simple;
	bh=plbpc31rVrOD0KMkWiMy9DSCysG2bPp4EWpOgbNVk+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFLVT22L61S8v3tu6P5b6wM2InbsVLFw0yv7vnyrpS4WWFRSSqE+C6nArWJ8mpsBTE4mq3CWQv/+a8dbANluw1fBG/t6DUcDs+PkKXhhrJs+X5g3uuq/FLmLoy6I3Thh0wFeUsCbNkPGtVSQ3U3wR2Bd00gBj7Q9jP2b4t/BpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MbUQVUCH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso68712185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311314; x=1745916114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=MbUQVUCHSysY+BlA82S9jWphlH5MgsbojF32v7wnCW9Gd9MJJDvr2pxkynY+uCRbjf
         ABIpiOJdFBZ4VUfe7mEGPEhn92yltZlFH9BRZgDrqugOyJF+uYJ2NuyFc/iWXCvxYaVQ
         HS+uGwkV12LLgV5jeBP/xYYJ1XSyvoikz9enmCaobSCryPTetMTvy8h52PmdrDGOzb1X
         vBMX4xw67rl8PfRZ7/F52V5DQNT0z9owDs1fAF0IKeuBeiX8D4i1HOziVsyQC2AiXCKg
         k9PDBnFRFuTir1wEahHE2rRvydWCAZpZavCmGOTRVCdi6Sy8AB6Ti8xiETmXIhA9u7ZN
         i7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311314; x=1745916114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=GnNMcDM1UNUvI4z5go+RAxirjnH8NJXMnRhzq0nZPRhBfNcqWQQ91A4dG31naK2Lup
         V7DafjcsN8P+MZeudASjF/8P6OHXW6x+S2bjkK7yCbxWUNertDZk2oZY0VvvEld+iG6X
         ZJkYL7Ba/fv55mtU9u7dWFRGkoUxdfAdVGwArav3q3iikzhnsGmu4aCCGM+8BvsHD9Rf
         X1zeZH1WQqrwmAUVVrbIFxL2pEsR5MdUHV1RoO8NdAY7AIQX0APaU44Hjr9lCyZpZ4Hn
         0oBuCMgy7OnmOT0SAF23W+unjPOJC4nYLcQ45842IdYh74QYu48K8wsw1akr/WPQlCGC
         XgYw==
X-Forwarded-Encrypted: i=1; AJvYcCXaAwzKx5TqOh9KM9uhvIqIL+ubtIFaO3KY6ri1KVyXEQSx3bJ4ljMAg6KBp257hT+cBfBJy3Ug4tT8yOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylvbBcaV7TR8qBG5JGspZ+6TgY519/n2rM0xejU8rNde0qmsAG
	XkPOKtOxP85V/VbuhTi3UY5rl3ZIakACisKCWIq7ZFq8/HOAcDEQyy9b/f3z11g=
X-Gm-Gg: ASbGnctfS+E9E6IiANaYecpeBrLOsN13SUd3OsTtMhH8ID829rrQXcThTPahAMRm0ch
	nfcKV4fTYBZjxdP/sP+lOnJAedhNgcluXH/GG2QNuj9qNxZDsIEnIcwkzIkFdcaOVZS6VRxvsEU
	kbhBWf4zwoIjIwjRoQch2Q1NnfskHh4/VsV25mE4mCvIgMye/kePw36CCeEEXRNbn3rQ8QR6dzy
	7uQQh13D09dKkbXgd4XdlNktAWNptmjQ9em8szxWgogwVkLAsSTERA6V2LP6PCicIr/Xvs3HUdY
	uhxfWEYHT2HWhzPLfv7Bs4jnPf7X/sBOVvQhx2VwGH7T5sLD3KTBRSp/FlPwCVSI0csSuebPsRa
	v+u4kWIqUa4wD
X-Google-Smtp-Source: AGHT+IFp00dnBQ86k04fdmbX8xvzwFEmfdHBx64nvu1PEvdvO50/UHtsOOWSOHg/3EGakH1tIpZc6g==
X-Received: by 2002:a17:903:1249:b0:22c:336f:cb54 with SMTP id d9443c01a7336-22c535c9c28mr225400805ad.29.1745311313749;
        Tue, 22 Apr 2025 01:41:53 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:41:53 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v12 1/5] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Tue, 22 Apr 2025 16:53:08 +0800
Message-Id: <20250422085312.812877-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422085312.812877-1-nylon.chen@sifive.com>
References: <20250422085312.812877-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 12 ++++--------
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..06731b8c7bc3 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -49,32 +49,28 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-d1 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d1";
 		};
 
 		led-d2 {
-			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 1 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d2";
 		};
 
 		led-d3 {
-			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 2 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d3";
 		};
 
 		led-d4 {
-			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 3 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d4";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 72b87b08ab44..03ce2cee4e97 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,8 +51,7 @@ led-controller-1 {
 		compatible = "pwm-leds";
 
 		led-d12 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -68,20 +67,17 @@ multi-led {
 			label = "d2";
 
 			led-red {
-				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 2 7812500 0>;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
-				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 1 7812500 0>;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
-				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 3 7812500 0>;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.34.1


