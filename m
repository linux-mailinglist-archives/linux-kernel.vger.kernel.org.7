Return-Path: <linux-kernel+bounces-766542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E67B247EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C705A4D57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614E2FE58A;
	Wed, 13 Aug 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCVjqD3U"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAD2FDC32;
	Wed, 13 Aug 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082841; cv=none; b=A3v1RStHxo8AXvKypdpPHbGL4bKmn5LzPMk38XgA4broO8i8/tjZt18DIzvQGJskUanyKGiYZzQbz8UFPHJ84kewDV9G40w89jpIr2Cpl3EKmKji/31HZrI6dAQ4C2vJSHzInnh3tC47cM/9SYCzNcO6eGsjzX2/91jN/QUwl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082841; c=relaxed/simple;
	bh=zuGgg+KtKbX59cmwAVv8C3u2io11Muh9kIrEOlRf3fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O18seW334jmrRvFLWdKN0U7gU/S5JFK6ol1DpRQf1w8Tb2rYLkbNe6G5AuZjCa8isI/sAe5GcoOwIuP2qtYIvm2dxMi+taEKfisatOdZ+5FbDgCE5yKEq11uOaZLVTe8J8hoWomxrDQ7A0rtJrXK5Y0a3lQJKNAJpQgl7Tz3jmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCVjqD3U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af93381a1d2so1016601866b.3;
        Wed, 13 Aug 2025 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082838; x=1755687638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz6W98GzI/frUrKHDzE5ELN6joCDuBvAObhPSXpDpZc=;
        b=RCVjqD3UZ1fj2Tql/PNrJyeTlRyl0P9C6RF589Cm6F6DGytRnFa3oXBZ3i+YGyFnHA
         stOwy5ARubQL+BgX1uJNbxYLxstvgGZbwvcfQOEiQ3l9MLailslgOoUJeW8n5hN7kd8n
         kMeZOJ5cMoFomIZx7xV/3sUuABnTw+lIgC3vGv68cieKe9WVAbHiKRTwGYZvjzaou8dY
         rv0uQxTZERCPSOp0gDDRQrd/+RVzit3Qw68OXW1qdJRVDnApi04p8Uj4XGBlVrAVDLpw
         pH12EYHXK3aL1pR1dKWwzq0PKWXKJ3EhyHRO+eCkE2Kq82FtBXQFA0tCZ3Z8en0Z3xPX
         xh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082838; x=1755687638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz6W98GzI/frUrKHDzE5ELN6joCDuBvAObhPSXpDpZc=;
        b=vP5+2BiqS3QFe3Fi3nf0JCslKKg2mS8JWlTa4q6Qv5veb1YOTogOlE9709h/8ZU/nX
         AZZlJfhOmaWl+OoOVXiTE49m3Kv2Bi6jdzjMYDkPn73c1NpUBkQP9GRUbOtJ4PUv2M7t
         ADwswVcuYjSbPcre86gMi6wnOPGkzkwfko8NHdUzqfNB6lVcuj1nzS0ipymhdgxjpDsc
         L2ktJD3KnEed7JPQ0SuNz5fukGh1ItbmrezhnIUOaML1IyCG/cT4I9b+s90hyU8icLWs
         dK1g47GEIJVkalXe14KURdToLDNogTTDUqEYo3tgThgSt/oEjXnmma6XNxvAPzqcdsBq
         /FCA==
X-Forwarded-Encrypted: i=1; AJvYcCU3lqcJ+QkTw8RppAzBItCRMHC96LNvUIFb6kCr+NXvDHb8Mz1+l1QIEGYUIsI/5j0uRqjOdZkume6a@vger.kernel.org, AJvYcCUGOrAp7fPfxKqv6PYzz6u0Y96lvIUdfZ85APtJ33Ja5V5mBXZ5qDuKDcS8UHmmxvWDzI25mJKWuEsfu0GG@vger.kernel.org, AJvYcCW/vocFCN5a3PJz69HUVbAOxAaFIZQlGDNyoZWW41WnPPreixbS6fvyoGylb23dLYUmN785aogMPcWB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5TYxhAHPhmDmZZRyINnkYn1fclzwVZmnronIkCA+zI1C9ZBGd
	763r2ElltSf4z3GcZTp1w8FWcCPQ8zpvvj1iuiaQzHIqcGXGOp9Zfm8o
X-Gm-Gg: ASbGncuyPpbGPFeGKi/D2qc6atpBYIrrWpCQ/p153Vr5YhzHK7hbJ5rlxK+ZE7XFhTF
	IV2W9c4u7reOPqXb0jLfR/RFZfZIoukZSszv/kxnnBa5/+AGG9mQ2o/UJkbPVlKyY49ASlHBIOL
	PBhwt7yEX6ixazQXbPe5UNHhOEWKhB8XgCi2Q1VjBAJzMjcwPkx3vZj9wg5AXhEolW+pyxnTBRN
	hiPLdSWY/UTrIHlsO7CIkorSQ41QnNE3mt7tzWdkX8lmgJu2Df25Xy1ba6Xcibd18JBEVu081WR
	XO4FOGESIIkhNcI+ChQzX/+UTNkazb590ZiCvaou0sPsUuXTzDobpKd2A/bKHMItzHb8hxCp2eY
	AG7GWEnWkjy0/4mc3P5qnsfTNmHUft2WoPnTDAKSw/Nd3Qn9+/QLRro3qbHUS4jDL1x4DIm9fFa
	vCfqMf
X-Google-Smtp-Source: AGHT+IH0aqDtVR0VevZ8f2uJ+2//Q9uHHryebJnEAf3vQOeF9yW2TPtt5LjJNUehypu46peYZ5JGzw==
X-Received: by 2002:a17:907:968a:b0:afc:a330:e423 with SMTP id a640c23a62f3a-afca4e434e2mr261368366b.42.1755082837769;
        Wed, 13 Aug 2025 04:00:37 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:37 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:15 +0200
Subject: [PATCH v6 9/9] ARM: dts: bcm11351: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-9-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=zuGgg+KtKbX59cmwAVv8C3u2io11Muh9kIrEOlRf3fc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA+zA3eXsWGpqI/E+S4hxfwR/JJD0yngPm32
 mRlhtef826JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPgAKCRCzu/ihE6BR
 aIj5D/0cV/FmJu4x3Wi5+fJqoEK/plwBYfi2jRNtUW6oUV6vvYcUkIpOt7FqTvUfOoDEmADjsJo
 hrjjaKSa8GpqgtabK6sVleXRHbOUuiO/k3j0cZH8qO4HL6sH5f2OgisGwzDT5oO+SAhL2UqVhen
 j1z9bwwBgN7y5/xDRmC6ktPuQQX3YBeQ3ipbGhpvCdyc2XCVXKohiIYZKiy7CtKy5wlykh1nmLF
 2w11m7ZbM8HhYXpWTHsBjBKtbfOcRJsroyB4gjhSz4UNBpP7fitkAkwZgVQ5qDjlClhpO9hIXdb
 d2jlGTo2AaJm9Q0DzboPvxpYMsD84YkjaT/zs3cRsXLAilYRE7Z4NxRUylxjNMdLWzx90Bfba10
 hN/BGCuNLwv4l7/AY8FQYuf/1pUbbpuoTQfCI13qr7aLRsA341nMl9iAlaf5c4kfhzKUbJBMZwi
 SUoLZ82ZkN3ggO1qNjVgHuvKnNbTE+4/YNvbOOjMjrXjdBykAb2CR/Jwt+me4kPjVEZTu8+Tljp
 4HgtcmXqjJK9dTx4+7ai5UTs67adDZxeV8CwgOvVAIEnYyclGXWdGhI9P9jnmesLUPidEDwOkMu
 ELA8OZcbKhGtFS7+v9eBL0qrs3h7Wz7b9TfudcNMR1TiBEtnfKwfHzHvQheMGWEgeaSx+XUzbpQ
 pfitsuvC2sGhu9w==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Following changes in the clock driver, add matching bus clocks for
existing peripheral clocks. Replace the usb_otg_ahb fixed clock with
the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 arch/arm/boot/dts/broadcom/bcm11351.dtsi | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
index 53857e572080d752732c512ed27f942756d59c46..fac5cf5a46bd9a4b7e09a2e65c3e807d1b4ef960 100644
--- a/arch/arm/boot/dts/broadcom/bcm11351.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
@@ -233,7 +233,9 @@ aon_ccu: aon_ccu@35002000 {
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer",
 					     "pmu_bsc",
-					     "pmu_bsc_var";
+					     "pmu_bsc_var",
+					     "hub_timer_apb",
+					     "pmu_bsc_apb";
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -246,7 +248,14 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio4",
 					     "usb_ic",
 					     "hsic2_48m",
-					     "hsic2_12m";
+					     "hsic2_12m",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_ic_ahb",
+					     "hsic2_ahb",
+					     "usb_otg_ahb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -262,7 +271,17 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "pwm";
+					     "pwm",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "uartb4_apb",
+					     "ssp0_apb",
+					     "ssp2_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "pwm_apb";
 		};
 
 		ref_1m_clk: ref_1m {
@@ -325,12 +344,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-			#clock-cells = <0>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -396,7 +409,7 @@ usbotg: usb@3f120000 {
 		compatible = "snps,dwc2";
 		reg = <0x3f120000 0x10000>;
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&usb_otg_ahb_clk>;
+		clocks = <&master_ccu BCM281XX_MASTER_CCU_USB_OTG_AHB>;
 		clock-names = "otg";
 		phys = <&usbphy>;
 		phy-names = "usb2-phy";

-- 
2.50.1


