Return-Path: <linux-kernel+bounces-784118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E0B336F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051FA189AEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32531288522;
	Mon, 25 Aug 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak1CxU7f"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4528850C;
	Mon, 25 Aug 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104846; cv=none; b=PaUEonTJZxb60gqTjkHzLuMcpKkKP2lVDQqOShewy/rnIaEpuTuz85M+AT9JM2TdRvEDbm071wyCFid/7IoxPT+qclPLt4z04WnEn5G2RY3CMzzKu08p8/P5dVC5/PdilbuVWElzPwAuy/fIHfMO7Gw6lBy1/WSmeI5urBrNAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104846; c=relaxed/simple;
	bh=P9yxc2FIjcEen9vfwcffcFphbuyv4RU988g5mXWGPR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTGXrOlefHJg7cUAKC1OSuz/w6ygpRU+O1m4xucEF+edKed4koXIFzbyYOZ2zueyf5vUFZpWIXzppfi0QaqEUP4k3Dihm5bJnGiHXuC7uV/nrbmeWDoh6C1F52Qb2/xDH/n+O/xQZS5MAqbeUEqJdgeiwg4i8inJC/DB2rS/hTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak1CxU7f; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so3794607b3a.2;
        Sun, 24 Aug 2025 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104844; x=1756709644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTZ6ReWDh63SW2snxudICAvhkxK62zXI722Y94yJGWI=;
        b=Ak1CxU7fB+4VqiHm4vfHfZ8t+1nXn07PBqP7ytxcDBqfKRKfjfeR08Mc5uVqae7TbN
         Ww0cUT0O6MG2CYIWr7agVVJz2O0Zjtxi6enaDR0WcT0LctRulSsDX/gt1MM+1ZeeEoFc
         9LyMDPKxkbE36Cbq0UdSbphiCBrLJIsowSDQsD/T+7rKOsT+dKdHdLlgeEWeED/h07pm
         UPNGGP8UHynuN3by8HRR5PQRd10ccikeWf3afgfokpauR6aPxxtBsRocq/3CXZf+KiPT
         JTkLPfkRCkpxzbtEKHyDGDF+7T1P6JZgk5Fv8wdMFjuv2C75ZXJEYx/TnSJGfPwrF0cB
         s3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104844; x=1756709644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTZ6ReWDh63SW2snxudICAvhkxK62zXI722Y94yJGWI=;
        b=LyvD3IN5rUIJdD+AnYmDoWUNg94HwI2cQqI/PQPlwGM0+Qh+1cev8s8cQOVh/961pK
         e2lffa2wQqk61DYORHjbIYehmWuEJNxqxbbRmOB6c6EqQPFhxOgmm2t57fTtgctqpGhe
         YDWoRoaIuPTSMeO6QwGcdpfkLxiVkw9wvMfEcUvA61dmKIFAx0+bfH/znjFhj5mbeTlB
         D1QWnMRWry/fUMhtjtgKFyhvsW/yV0fwkJg1vvpWEM6EP7gc8qHTNySzaoLIowD4URZt
         hBU44Y4CUtXsrJfUShYnyKUwqAj4QDTQWH+GcymTR5saOJmKGW+GTg/Z85jYWAFKdqMx
         cqvA==
X-Forwarded-Encrypted: i=1; AJvYcCUHEgfWJLSX2VE/zXy8jN92Q+J7rhBHqCv5/OIy0iXgnJH6EtYgA6Z3fXIjEaQR60I5SG6nxn9hpDaj@vger.kernel.org, AJvYcCXuBrnnhXriDeouqbh6UNLQEnkiy/ZW1yIZMF9XhnhkVitAeVF2CmqvLW075B/IEF1YpSYfxeIvyB8EcH3T@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoR7lkyXseOMGxJmysIpwNn+f8XNRv4N9XBxqBVWZW/Q2/p2H
	tIOhPOJkbPb9N5Aw+PtGo2qygbRuCIzY+0qOUHsx3UYhEQoihuY6rXUf
X-Gm-Gg: ASbGncshfZXIgVix3KQtfsq2FWwElmNVqgN76EsqWEzyMjsn9LZGZj/a5++Kbht22az
	XBQskH1eBOjs7bNBl8Iz4XAbTcoTGgjBqbWzyDb4br/IiDnpHzyiswIHos+SiQ/3YCrUQdLJ1O0
	w21vuJyYhLO3e5PGfz7aOuJzb3rI+LyI5HwYNBz5b7xPzqjc4hpTSRRg3Re0WaqW0sIgi+mkeF/
	cjFBWCIArnNdk0K5lq5pvmrcAp+MLjKwXsezPvoV5yrlYciXe2RRpTE6re/z808eWkXQWuuGz5p
	NNWOLR+D0oYL9AqLtfZl9YKQYcdu/cWdMgvzN7tSbanigQ8y3UgA2rJPl58UgjMQcxCuwAHI9KA
	HcM7AUya1naBPdJILXkRoSmbLksQC/dY=
X-Google-Smtp-Source: AGHT+IExiDKidasdirJUMxHM8Ko8guGC+ynt8/s2M0w0Ora+UP9rYkO4PHXhidtDZ1EPCbRI+HH6qQ==
X-Received: by 2002:a05:6a00:98c:b0:76e:99fd:e8 with SMTP id d2e1a72fcca58-7702fbfaf3emr13327206b3a.27.1756104844339;
        Sun, 24 Aug 2025 23:54:04 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:54:03 -0700 (PDT)
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
Subject: [PATCH v2 10/11] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
Date: Mon, 25 Aug 2025 12:21:50 +0530
Message-ID: <20250825065240.22577-11-linux.amoon@gmail.com>
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

As per S922X datasheet add missing cache information to the Amlogic
S922X SoC.

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
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 62 ++++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 86e6ceb31d5e..f04efa828256 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -49,7 +49,13 @@ cpu0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <592>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -59,7 +65,13 @@ cpu1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <592>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -69,7 +81,13 @@ cpu100: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -79,7 +97,13 @@ cpu101: cpu@101 {
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -89,7 +113,13 @@ cpu102: cpu@102 {
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
@@ -99,14 +129,32 @@ cpu103: cpu@103 {
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
-		l2: l2-cache0 {
+		l2_cache_l: l2-cache-cluster0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x40000>;  /* L2. 256 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
+
+		l2_cache_b: l2-cache-cluster1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>; /* L2. 1MB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 };
-- 
2.50.1


