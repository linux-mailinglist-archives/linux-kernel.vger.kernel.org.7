Return-Path: <linux-kernel+bounces-735421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F3B08F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BB25A0209
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DF12F85F0;
	Thu, 17 Jul 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNfZz1le"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AA2F85DC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762173; cv=none; b=dbILBiHhbRaDN2fDSCJo7y2Sct1gpTcEsPT2+z3pA8esnrPUccEtT5OBQ+ZHd/rfW3Wi4JC6p3PD1pZiaLPOHNMlm9Dje+kuqWZ9eQHzMhHCkXVZICT9afMl9nbyqIZdnuPMZB09ux6CTPgIGAPQk/gNkToFiunn63eKXhSsSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762173; c=relaxed/simple;
	bh=uujvZIEacMR4RmI0viShcrE6nyskrRbnFlw1trpWzkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcsdCYXanPUMtmqAMUA2U1dxYB2OqGSRMf8lMHBormEMyua5TJsZLHP6LwA1vRokckpdUB/57HPe+MXkxcanGNkoYdz1QXv6oCD28rR8Kd2SgvCr6yKal/rggEy++hPjJ+8R9pCReqC4K/zyneActuyNtJNX5fDSxSjf3Xv1EOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNfZz1le; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3521a124cso19478666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752762170; x=1753366970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUMs6u1zn9GnSxixdQQj+KqICw4gE2MY7effcI0/DiY=;
        b=yNfZz1leGosM3s5QDbUVwNjNGpXhQQTgKLzvKcGTsPP8ABHw6BYqCeHmMVVGRK3QYQ
         yhzkaWFWXGB2bF32KqJZITkwyt0adyJ+Iod4545kdQIClmH0IcLxb7BLdcdxzzQrEEF1
         Lsrgu6csuHKk69LsXVdrnbFLALbgx+kHku/p/aIOS4B8WuO4xUJESubqehrj8IiB864X
         dLex2N9hr+3fyFEEkv9zt2DRRNBg9hjK3GcVd1pGuzuBuSbMUoEbIYOhDp6PfCbY/Eil
         i4gT9KQTQp9HBAMqDUUQKQs1+5w00nxrNcc+ayuV91NHCXnJfr++hfTrAp4CKuE9Y71D
         GuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762170; x=1753366970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUMs6u1zn9GnSxixdQQj+KqICw4gE2MY7effcI0/DiY=;
        b=BWsFptx5LfKjB/v6Bl0x5lZ7WS2iJIgtQVVbuwvvmROIpqSamngXiaP1nWYszl1qwJ
         2TIzxqHCNNTCSfx4aH+ffaaajOSoao7RUt2Vdc9K4zvwBzPcl1EGE3yDEf+0lYcCGPjH
         d195R5rzocF9RPpWYm8nxbSYDJCLg0pTE438SzJ078RTIzx52wneoCjSJlMPqB3JhND6
         F8Qno+ibAABe0116lwG9Jn8ko0BvdTidDoGBGiIT8xFSHx6rCHt54n7akEmCZQffBwav
         AI2oy3y6aoSXYVYpDb7ymhf6GF4KIc0pFtLV92lagBWIM6ebWcb1kGTHe8RYbyQUC5z5
         mrow==
X-Forwarded-Encrypted: i=1; AJvYcCVLR8J61uUTsIv8RKinnMmV05T8deyVMIcDiWsNH2rM7wAJRxaDT7EIqEQl69usE5L765Fd2wURsIMWClw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNN4AuSDDQt1LrkwYm/PH4NxUqXVoXto5JmscupkAqvkB/3k0Z
	MlhvMZ/ghoScapoGY7ITMj3zOnNO/Yiu1GrG+mUheF4AyoLUIwepKgzTzfUeFQnRpYw=
X-Gm-Gg: ASbGncsHbV2jyujkhK79G89Zm0qIe0Xw1SljypZg5KE1MzJHO3qyTgk5g2TNm1D2KqG
	1INr5IIqod7u9AlyquGlCMPgqLvArwqL1JOgqQqRinQA+EgigWdRaoPlW0Yw9zAdJ9FfehZEgsS
	kU2gL/vSbQO0GxGp0RxgKSGeMlO6vZSyJcF0U/fq3kYVF/NgBbjPVwi1N0wAfLwyPl4e2t3UOUv
	d41NlwZjDAB4aZfQh3A/zqyGKPNjtpSrykBTSmJrnns/+GymFMb+jAw2hQIqjP9gkGAf3xhYVFC
	YrWzgqVHc4CvFD6llfmZjnntowiWrz+ga7ehMl8Cz8D5dZnQBULI6GI1SaFcKTvQdOwpHs9KkH6
	+Qz+VhCE+r44zsCiQsXonIIRmO8tjQaQImZSh7I6QmDc=
X-Google-Smtp-Source: AGHT+IFZX9BGgT9x3QocepLQl5WhOnUhBgwxIkPHZcxu8L9iFIb0/kRnbcbOnsyPXf7VCVGi0goryg==
X-Received: by 2002:a17:907:1b03:b0:ae3:5d47:634 with SMTP id a640c23a62f3a-ae9c9ae83fdmr247023766b.9.1752762169843;
        Thu, 17 Jul 2025 07:22:49 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910fesm1371235366b.1.2025.07.17.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:22:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: st: spear: Use generic "ethernet" as node name
Date: Thu, 17 Jul 2025 16:22:46 +0200
Message-ID: <20250717142245.92492-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4702; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=uujvZIEacMR4RmI0viShcrE6nyskrRbnFlw1trpWzkg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoeQc1nazIsXmyvnrckGiynmTvQnQDrqclaTwNs
 09NE3Zpv6uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHkHNQAKCRDBN2bmhouD
 1ziUD/4xRIoA9qa8jB6p8q9H6du3tZw9quXQJhekhD31jMX4VcsCOcjBIiktkHqvRK+VHXCx8SF
 IlsxNiot9I64M/+CVxK9HOBiD5w2C3MflRYkbeAH3BfbfTvafMU+fo9JgTFr3aOT+vDTGtEfkm9
 RAeLbqDe6beDNFeG71n25GvTULT8ECpzou92GkVNv2CNf5vG6NmxjOz2/CLn0XlhgWToS8S+tig
 P8A62nu8Mqmr2sUJ2354HQ4MPB0+yR/iuBfoDU2SuYyUZkf5XvaSligGVsDh0jk+3fjUglX1ne7
 m4RxY5rg28N6bvXVJpHVW7tcmg89/xdKzOIk0BHk/tlDPjs3XN4BiZu6cW1GC0RSz243zjIJkwY
 rSE37Vk/lUFbOkuUgXnY9KdkjkywXFBgl2VlQDIyaUZRhV8BBQaIZT0gjFgixzL+Uf3e4LkmQBg
 FCeEhBHKB9FfYoPgP680CVLj1MUSewy9Z6U3gyXMAr6wq17itAUNRXZbfy90ayzO4NRo7R41Fxk
 EYVPf23yT0fiaONZv4S3yx8fnt5j25SRnIy+6cM6cMBpKOpWGVKb0dypLdJNxnfRfifT9c0nrcz
 ZONV3p1k3TigfZKPhQCvzuCkk6L6+/FgYFSAm26bWvXbBPMSzN2GYMii/2DLqSc8Rbze0lZbFAX IzY3tofXGHWcLiQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Common name for Ethernet controllers is "ethernet", not "eth", also
recommended by Devicetree specification in "Generic Names
Recommendation".  Verified lack of impact using dtx_diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/spear1310-evb.dts | 2 +-
 arch/arm/boot/dts/st/spear1310.dtsi    | 8 ++++----
 arch/arm/boot/dts/st/spear1340-evb.dts | 2 +-
 arch/arm/boot/dts/st/spear13xx.dtsi    | 2 +-
 arch/arm/boot/dts/st/spear300-evb.dts  | 2 +-
 arch/arm/boot/dts/st/spear310-evb.dts  | 2 +-
 arch/arm/boot/dts/st/spear320-evb.dts  | 2 +-
 arch/arm/boot/dts/st/spear3xx.dtsi     | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/st/spear1310-evb.dts b/arch/arm/boot/dts/st/spear1310-evb.dts
index 089bd7db55c7..417a064db11e 100644
--- a/arch/arm/boot/dts/st/spear1310-evb.dts
+++ b/arch/arm/boot/dts/st/spear1310-evb.dts
@@ -159,7 +159,7 @@ button@1 {
 			};
 		};
 
-		gmac0: eth@e2000000 {
+		gmac0: ethernet@e2000000 {
 			phy-mode = "gmii";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/st/spear1310.dtsi b/arch/arm/boot/dts/st/spear1310.dtsi
index ba827d60bf07..1498996be14e 100644
--- a/arch/arm/boot/dts/st/spear1310.dtsi
+++ b/arch/arm/boot/dts/st/spear1310.dtsi
@@ -128,7 +128,7 @@ pcie2: pcie@b4000000 {
 			status = "disabled";
 		};
 
-		gmac1: eth@5c400000 {
+		gmac1: ethernet@5c400000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c400000 0x8000>;
 			interrupts = <0 95 0x4>;
@@ -137,7 +137,7 @@ gmac1: eth@5c400000 {
 			status = "disabled";
 		};
 
-		gmac2: eth@5c500000 {
+		gmac2: ethernet@5c500000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c500000 0x8000>;
 			interrupts = <0 96 0x4>;
@@ -146,7 +146,7 @@ gmac2: eth@5c500000 {
 			status = "disabled";
 		};
 
-		gmac3: eth@5c600000 {
+		gmac3: ethernet@5c600000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c600000 0x8000>;
 			interrupts = <0 97 0x4>;
@@ -155,7 +155,7 @@ gmac3: eth@5c600000 {
 			status = "disabled";
 		};
 
-		gmac4: eth@5c700000 {
+		gmac4: ethernet@5c700000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c700000 0x8000>;
 			interrupts = <0 98 0x4>;
diff --git a/arch/arm/boot/dts/st/spear1340-evb.dts b/arch/arm/boot/dts/st/spear1340-evb.dts
index d24146c3c9e8..9e7c356b1d9e 100644
--- a/arch/arm/boot/dts/st/spear1340-evb.dts
+++ b/arch/arm/boot/dts/st/spear1340-evb.dts
@@ -157,7 +157,7 @@ partition@1200000 {
 			};
 		};
 
-		gmac0: eth@e2000000 {
+		gmac0: ethernet@e2000000 {
 			phy-mode = "rgmii";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/st/spear13xx.dtsi b/arch/arm/boot/dts/st/spear13xx.dtsi
index 76749992394d..159e941708ca 100644
--- a/arch/arm/boot/dts/st/spear13xx.dtsi
+++ b/arch/arm/boot/dts/st/spear13xx.dtsi
@@ -149,7 +149,7 @@ fsmc: flash@b0000000 {
 			status = "disabled";
 		};
 
-		gmac0: eth@e2000000 {
+		gmac0: ethernet@e2000000 {
 			compatible = "st,spear600-gmac";
 			reg = <0xe2000000 0x8000>;
 			interrupts = <0 33 0x4>,
diff --git a/arch/arm/boot/dts/st/spear300-evb.dts b/arch/arm/boot/dts/st/spear300-evb.dts
index 7d4e6412d558..80fae76d4610 100644
--- a/arch/arm/boot/dts/st/spear300-evb.dts
+++ b/arch/arm/boot/dts/st/spear300-evb.dts
@@ -69,7 +69,7 @@ fsmc: flash@94000000 {
 			status = "okay";
 		};
 
-		gmac: eth@e0800000 {
+		gmac: ethernet@e0800000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/spear310-evb.dts b/arch/arm/boot/dts/st/spear310-evb.dts
index 459182210825..a3449eb7e59b 100644
--- a/arch/arm/boot/dts/st/spear310-evb.dts
+++ b/arch/arm/boot/dts/st/spear310-evb.dts
@@ -88,7 +88,7 @@ fsmc: flash@44000000 {
 			status = "okay";
 		};
 
-		gmac: eth@e0800000 {
+		gmac: ethernet@e0800000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/spear320-evb.dts b/arch/arm/boot/dts/st/spear320-evb.dts
index 6ac53d993cf3..984075e60634 100644
--- a/arch/arm/boot/dts/st/spear320-evb.dts
+++ b/arch/arm/boot/dts/st/spear320-evb.dts
@@ -84,7 +84,7 @@ fsmc: flash@4c000000 {
 			status = "okay";
 		};
 
-		gmac: eth@e0800000 {
+		gmac: ethernet@e0800000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/spear3xx.dtsi b/arch/arm/boot/dts/st/spear3xx.dtsi
index f54bb80ba28a..54e87ac98164 100644
--- a/arch/arm/boot/dts/st/spear3xx.dtsi
+++ b/arch/arm/boot/dts/st/spear3xx.dtsi
@@ -46,7 +46,7 @@ dma@fc400000 {
 			status = "disabled";
 		};
 
-		gmac: eth@e0800000 {
+		gmac: ethernet@e0800000 {
 			compatible = "snps,dwmac-3.40a";
 			reg = <0xe0800000 0x8000>;
 			interrupts = <23 22>;
-- 
2.48.1


