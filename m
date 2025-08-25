Return-Path: <linux-kernel+bounces-784119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA676B336F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D541F161532
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DEA28D8DB;
	Mon, 25 Aug 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13//G3A"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B1287247;
	Mon, 25 Aug 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104854; cv=none; b=paStqr5Yw98FY4qmOf8tCqp4RE23h5bZQ+M94dHkwWzvxXruoPiokA0rEvCVaLExd1P3fEgyDB5X89Eigz5Jk/J3mwfPB4CZYkIYgYBXCbgIs4rlLjVE6vghi7dYV+nfOfOZXejcLdB9se3eNszv6YY6YHg68j5N0lXbCO2+DLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104854; c=relaxed/simple;
	bh=1xR1BrG/IQTEaj9CpRCQvh1HqBnG5wS7jvBzve6W3Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/kd45QLD9wIOSx1tQBQze0kC0KDIJp/p5w22E/Y65yE/JWRmkU8oSRHdwa8EOpisJL2k3ssQJyWr+CLUE2Kv4b5GWmiFMVN/lkv0uRPMbrG18WfRjufpZDOTAiuoVdWczxGFAlEkoKKB9B9PZZSTcrP2CSQLrP4wHDYmQUcxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y13//G3A; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-770530175a6so593356b3a.3;
        Sun, 24 Aug 2025 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104852; x=1756709652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYN7nhGItPuxuOx5ODUBHzob17LH5jYbMo8Fs5p8ph8=;
        b=Y13//G3AKGEavYnwK6t77r10C8Hh7BvBE6tazouXu8RhziQVtdZohcxw3vOsWieeXE
         6E+fGPTtCZSgxqhOdIM518BBqvuG7S32SqJiDdwyMyzBWWctdpcHGJir8/lxBcvN0gTW
         1lujTczKt6gTvdfXa67VKP6y/Ne47f+GlY97fAPNce5H+xD2WXu1ZKOtZAWZwkH+2d25
         Ip852ieo9r1uCjCMjKn/y/Wub+r3tbGnR7eeq0oC+we2WLe5NChbrPxv+cANLaJIzSeE
         AEcM6rNl/DLFFyYbYfmS1qxvqXL8QDvioj9Nq+WPulmYqrwZv/iQpm0yKpT/esm6chg7
         10Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104852; x=1756709652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYN7nhGItPuxuOx5ODUBHzob17LH5jYbMo8Fs5p8ph8=;
        b=C4uPMrGuKVAxo58dbImXdgfrgAhpJNvOYUGNWXUlf+P5E4ncMucPJsM+kwpeL8JrIL
         WXyk7Ed5saOyyipXsgqZS3sO4QSl2Dt6rzGGZrTRN/smcM/jXD33cAKiQBaQ5PSo/Uwh
         0e5q/F6pKSKagno4pywwqUFve+kEP2f6yNfvMxLUmT6OVE3ybbEUOncwnnfJSuwqOMKT
         WeGBGglO8uNFHUWrR+iil6+kTnqu3XssM3lJDJu/H3N2ytWQg9th81l8e1PS6JpUuqMk
         NZ1UMZ8Tx5KzFIvz+KlZr7/wGkav+hy0fflbHtHtRSb6ZwxzR+Z/h74om+DGpZ3NL6/C
         UkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTRktYcl1G2wvqFeLyqw0FGJgCiJVMLNQiPjn35Cz5p/Z/QOwgQoBGmYEgjrhHM+d25otRQQwF7O61@vger.kernel.org, AJvYcCXn/IztEATlFJLlEam6xY//OHYxrNbMqEc8DV6Sb3NgVu6kwPghR7maFdKsRGaDqmIjgP4PHEs4nvq3YMnZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yydpiv5+o8roF1Mcry079wCsOFQPDZYa/Ig639Ll7ynfwp3Nszx
	ra62i92OJgLrzvmmlmf+qslnPgf1DreN0EXS8TA4wlHO40BiLUWMFA5E
X-Gm-Gg: ASbGncs7FaU2sLv+rPOMplX5WLR6xv1tU0NTAkWmMFugPbdxVGwx9k0ewlqCMRwZ3BC
	2CGNC07s7ihAfxrJunqDQ8VflhAiJdeV/vnUFb56vXSRUWvdN6+66xR6z+6clmLvepTJ2GU+4dM
	rGTLcTC1qrJne5fqrdckTl99rXOHs2virwoOFmMT8jLOUNdSTGOBl3FBbAizEUIHRpptMV8euod
	QZnVRz/2I5/Xa+p+QlGgSXaacd8vov9uGNSuAZbZSRMkCYuqHlScrH7d78+aJ2RVYXloCTnUBJm
	pSrgp30OFUc+vkCu1f5uxMiB1g5jBBFMBUqpbkeyqPZtLyemzhPSiwzVdstfv0RjRCGfA+CQG/G
	GR0qiaFMt+cDlq8weZE4a
X-Google-Smtp-Source: AGHT+IHWUk4cAML93HyGiEFwezL8U62c5uaN829A7XblToHk00FYTc2hvy+Bm+6bwtMuYJzqSRZfFQ==
X-Received: by 2002:a05:6a00:398c:b0:76b:995c:4bb1 with SMTP id d2e1a72fcca58-7702fc1ca28mr13204386b3a.15.1756104851788;
        Sun, 24 Aug 2025 23:54:11 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:54:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 11/11] arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC
Date: Mon, 25 Aug 2025 12:21:51 +0530
Message-ID: <20250825065240.22577-12-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825065240.22577-1-linux.amoon@gmail.com>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per T7 datasheet add missing cache information to the Amlogic T7 SoC.

- Each Cortex-A53 core has 32 KB of instruction cache and
	32 KB of L1 data cache available.
- Each Cortex-A73 core has 64 KB of L1 instruction cache and
	64 KB of L1 data cache available.
- The little (A53) cluster has 256 KB of unified L2 cache available.
- The big (A73) cluster has 1 MB of unified L2 cache available.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index ec743cad57db..6510068bcff9 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -53,6 +53,13 @@ cpu100: cpu@100 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu101: cpu@101 {
@@ -60,6 +67,13 @@ cpu101: cpu@101 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu102: cpu@102 {
@@ -67,6 +81,13 @@ cpu102: cpu@102 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu103: cpu@103 {
@@ -74,6 +95,13 @@ cpu103: cpu@103 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu0: cpu@0 {
@@ -81,6 +109,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu1: cpu@1 {
@@ -88,6 +123,13 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu2: cpu@2 {
@@ -95,6 +137,13 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu3: cpu@3 {
@@ -102,6 +151,31 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
+		};
+
+		l2_cache_l: l2-cache-cluster0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x40000>;  /* L2. 256 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
+
+		l2_cache_b: l2-cache-cluster1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>; /* L2. 1 Mb */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


