Return-Path: <linux-kernel+bounces-794655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EECB3E4D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D62B3A4072
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488B326D63;
	Mon,  1 Sep 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajG0RMJp"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C2322A18;
	Mon,  1 Sep 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733078; cv=none; b=klISIuLgAp7AiK/Y9ORXzXGPDtQfn+RKckiFYkMDandDhWqQKcHeY4FHtlLdPloGJKGap15bSLAcGOqrCvkbSiuASrNQVvMreAUzfmc+ofxs34mqUNOLTjV0Kd33yM+qT0rqHlPnrSmKCAbxKMQ5lp0rgrbNeSMlgdUOnMBSo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733078; c=relaxed/simple;
	bh=sJWYGnT1WWEG+kqtUxqmZBzwgmvbVmwP8qD+SOYqeyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdIYUpgZ1tyrBN/fLL2MWGsEtGP6UqymcZwIVdPKUPgyq92HGQKF0Ubxr3R/21S7rq7etHqNUcNH1drtJIy7hCEIgJbMS8EMF9mpFTcGoT4KB2yedhf3qxsDAXx8xVm/kk1VwpBubHCYWGHHuudBavI7ofWhQiX4ileY6mHquhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajG0RMJp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3620675f8f.3;
        Mon, 01 Sep 2025 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733075; x=1757337875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWlw5Ms5yTVtOwXxGv7Ts8LYQp05G0qkRwNzIO4qfS4=;
        b=ajG0RMJpoLaWD0+pxxu1qCeXlQ4qcWk/e+NRA8a+LNDJtbJj9y8WmMonrcEv2S4gDv
         kxpAcMXwMk6QW2ewwXoX6cvMG04zkxTaAtRKhtDxgMJ2aCDzMhbhd9aRO8DPGgUDohoH
         2OHwetco51lIqQsz30fJ9jYMKHBnpGRMnniYngqzt5q5fkfKtHukYYnyR7oyqiPUjhlp
         FHKF2ZfyPLU7kQUjZP1Qg3JtPOSu0RPxz4WitpgZoxwmZjhTet3fJd5Uxt4LiH1JRzVv
         IGadJ5AAsVX/zlw6GMoIs6kJZu2vdO4ztSMUD+dFj3fwPYFjn+fsAYMWgVhxpqDE3Syi
         rxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733075; x=1757337875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWlw5Ms5yTVtOwXxGv7Ts8LYQp05G0qkRwNzIO4qfS4=;
        b=WsTbWnra7a9dJtU80ucnuNMXLk20aNtVbB64MK/TTXNr8/mkMvpHmErjGsM7iywu4Q
         6UfpvPpi1AujVv8jdhbIqc2+oxCkev+oBfkNMihkNpdsEZJOJXfwaoJP142mb7Q6dtv6
         kJq+tZdj2fe2OU4TJa7KTO6cGOcnGXCkLKkL0AqAelpFzAu/992+uNxZUj4HZn/JZaON
         gPS4PwSb0CFPeSL6ss9d5P92UrRAJ59B2KkuMhJCpbsSY2k5OxzJsSHGyFnY7yOPD6+z
         e577SweK5BlUkBS8daXv2HkuQFH+1nw+LZG7UgL4VaVrwW1FPscX0/WkHB4MrmgSbEuH
         cK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEhf8euSRb0xXygS6ggUHWYZ/KQAa5ynKBLV1Pre1nd5ewL55HG0xXxRzEB+2Nx05yMUzPOSgUyVlHfcFp@vger.kernel.org, AJvYcCWPuulY3B+GCIRzGyPySLoypsVPbPDJzLnhRhdcX6dBBm16dMUjA2N8chie225aIOaGGIyB0qLPfdXy@vger.kernel.org
X-Gm-Message-State: AOJu0YytRslsqLDd0jv8OzRvA/n2f1yvVmBh0NZWlQyLTIe5OCL8JEhl
	hChnLyLC/0aGt8fPIZWGQ1k1nF92sIepajSGoH0jjhYgFyfToN11JNhH
X-Gm-Gg: ASbGncvND60MBmgDMwqspWU4Ui69XXSnT+yKStytXU/J79YDDjAe9zIbJUj3VFsjLQn
	X612SbQlyzrLRbKSS2nVjVXaGr8BukHbWhAVojr4x8KYBYOnB6gwsl9ANwY/Fc6xHicFHeQnq+G
	7W+pW4vC+Es2U/EDxPPIgjA4ZnXTN/MHYC37y3VVIuYxqq1A0zAL0OAzCpd5lwkQwX8KqIq5J0Y
	0k3HodzjDa+I6X2/Syj03YBTYX+jugXHxnubGS1q9b5pEovgdsBGb3nh2frySc4wxKmu60tsVxj
	T3lLOhaEaGlNN16z+jS0IgveZFwK7UdrC31IviE2vCJrYkmKTQz3B9a2ktziYRWWFPb3m067wZ0
	SkmXoMmzDo3dfVzW7VjtOLFxXrh48lZJMVJPT5bHBAL49
X-Google-Smtp-Source: AGHT+IGFXZ6qbwJ3kEV+0fxALLiC8wRzseV8lfDHfGg7Uz+h42PgAbXCYv+xNFrUtwJWgrqbFGpWjg==
X-Received: by 2002:a05:6000:400d:b0:3d7:94bb:cb9d with SMTP id ffacd0b85a97d-3d794bbceb5mr1508219f8f.3.1756733074684;
        Mon, 01 Sep 2025 06:24:34 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm24359635e9.19.2025.09.01.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:24:34 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v2 2/2] arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM845
Date: Mon,  1 Sep 2025 16:24:26 +0300
Message-Id: <20250901132426.3081648-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132426.3081648-1-tmaimon77@gmail.com>
References: <20250901132426.3081648-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a 25 MHz fixed-clock node (refclk) in the NPCM845-EVB board device
tree to represent the external reference clock used by the NPCM845 reset
and clock controller.

Update peripherals (timer0, watchdog0-2) in the NPCM845 device tree to
reference this refclk directly instead of the previous clock controller
output (NPCM8XX_CLK_REFCLK).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 9 +++++----
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts     | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index e4053ffefe90..ee7da5e8f95b 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -47,6 +47,7 @@ clk: rstc: reset-controller@f0801000 {
 			reg = <0x0 0xf0801000 0x0 0xC4>;
 			nuvoton,sysgcr = <&gcr>;
 			#reset-cells = <2>;
+			clocks = <&refclk>;
 			#clock-cells = <1>;
 		};
 
@@ -71,7 +72,7 @@ timer0: timer@8000 {
 				compatible = "nuvoton,npcm845-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				clock-names = "refclk";
 			};
 
@@ -143,7 +144,7 @@ watchdog0: watchdog@801c {
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x801c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -152,7 +153,7 @@ watchdog1: watchdog@901c {
 				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x901c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -161,7 +162,7 @@ watchdog2: watchdog@a01c {
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xa01c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index eeceb5b292a8..2638ee1c3846 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -19,6 +19,12 @@ chosen {
 	memory@0 {
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	refclk: refclk-25mhz {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
 };
 
 &serial0 {
-- 
2.34.1


