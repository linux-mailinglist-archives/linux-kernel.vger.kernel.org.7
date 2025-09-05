Return-Path: <linux-kernel+bounces-802801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EFB4571D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A683A8856
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104D2F83BA;
	Fri,  5 Sep 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZwix2JC"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64014341AD4;
	Fri,  5 Sep 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073605; cv=none; b=S3qDiwq0hXf/vT6lK9FbN8a2ARDH+9PvCT7r5vykievj3aaD8wq0l8pD+N3ZMP7nCdbCHZ9ZIpKimT6uB5r3HHeOVULdaPZ+zQEEBh9n76B2sLBcpqmQAuy7mSWQC+YAxvE2p640eZNhOXz8xYc11agBCd3ncEO/jNiu9jNY/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073605; c=relaxed/simple;
	bh=7ABTsmeScuin4GYhDUhvuRrG20wP60K0doEdcIzHAho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZE8M0jn5dN/WUbDYfqJurA3p5nLF/7w2geSO/4txsYhvRBOQMQ92lcKSc+ajsr/EJLaMc8VXpHlmnl0jptTRhkIfdd/vgmhO+UIYn7yQiF06gHjZhBt9huMCqZYtIcbSKaLcmV6TTrx+W4SxEqNcwwa1JMDsf/07QHvhpXFNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZwix2JC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b92d75eaeso1313680a91.0;
        Fri, 05 Sep 2025 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073604; x=1757678404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVxRCVFvOJzT3t1Nwg2lUVttPj3xxid9CGLZKoZfprg=;
        b=PZwix2JCP5hfVPGqCab+KEKEayNGGAqCYY+0PFXld7fWtofDMhoB+cQdFOZ0JlNwwJ
         xpD+72j6APBKL/ntm5/s+Upj6irLp/H7IWJTo0l0fpskU1r5p04VOuGreVhWPi4mI+qo
         M7IsKFxJL1wM0DK5sJYPYvSQwKagY/8TlNgz7TkW2lGbPSSnZBT/4Uaie0nX2awtQJIx
         svK3O2fbDAFV6EmeirsnmeZqEDdAEB7SQBAOuta3lkYhAd27MjdPKbQk9ocqToEoIATD
         ScTg6goMZibFMDu0AKO974UVupD0QUpj+f8FrIbOFL4LZB0MQ6Xkt/B7ZtBLd6MIXdkn
         Qvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073604; x=1757678404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVxRCVFvOJzT3t1Nwg2lUVttPj3xxid9CGLZKoZfprg=;
        b=nWuOhkq+PDXlFdMjMgrv2F+UFPLDSkm6GJvQz+mRlHS2Hw3VgTjn4GclZ3hPKHVGRY
         wREYn1l9l2LOC1y/vejqwc3t9go6qys32blCKUEPyX6WYRxHSVN264sMdx7rqWlZAW/e
         zydeF2g5vVXpHvi40VyvU2MDXZ7X9u79UgE77ngdbyvJic3BPgN8DIP3a7a8LhQggMor
         oArQmBAr/zJsT0EmXt/hLJcyEMCQKfQHoIkbKlIM5ULw78tou33+2fy0MoqwqqwSU6Mi
         SdRBfE0yQN8bxFHESX3HSZbalnbKzySqSHPF2FgkvVEKqBAwS+9YmpXUmCVDYrtyBMKZ
         EdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa2UG8Izqh6iekWwnyL2qdALsVV3swcnDq/D8or6TvvECFcPjfPtZpS4yE8a9Cq+uqWb86mmauzwP1@vger.kernel.org, AJvYcCXqrqDaRRnRS4cRK4luRDhsjh7QjceMbggjJv/JTSdH2yv5jc1c3kOJ8VAcrXQz4rvkyJUH0Ov/HMRwN+DU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1UuAAu3fev3JXBsbEaxWlYKNBshuHfWPQ5R20t/GvbkBtzhUN
	YVk6ILU7IXUuWaiuyIJhzC73IKWqxi4snwEu4J92pTPZeYCKNRwe6aE5
X-Gm-Gg: ASbGncu4us9RPR5jeW6OyvfNRMvJfiSFXNdW2oskTMl8c4gYwY+k8VH8g2IxLZVJLUM
	Jw/nkQRthDbzYmO8XAVE6bxdTzgSaemzKG/euAPuC6n60bqd0kTL7onUfkaJiK/+jYPMs8U2cSo
	DLVztcnyRTtGzX9i3OWd3VhBm59QbORTItk77uHjX9Q8Z12Ze3nkwS2MI63jOsFHQ8EL/9GE+wF
	6J4lSokl/mAtHEjNVfUd8SUKHpdz1ve3BTPPKsnWdDd/9vyzaf4TodS135uVn2aUb5U/4pSTs2L
	8710sQE0lyS34YtFmwIEQ3UEWj4jbykEmb+avH209Rb7WW8O9W5K5f3Y65hHc4hB2VW7fIhOyak
	VqBUhVz2SF9wyRuhYUVCSqXVorK+B1rA=
X-Google-Smtp-Source: AGHT+IGY5TeOBBLsD3Cq48stKZ7qkYVc+vwv84x6vovwpGRju1eJ3HiOc73XVMc6AcKN9NGG9nv4lA==
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr3464777a91.2.1757073603453;
        Fri, 05 Sep 2025 05:00:03 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:00:02 -0700 (PDT)
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
Subject: [PATCH v3 10/11] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
Date: Fri,  5 Sep 2025 17:27:41 +0530
Message-ID: <20250905115836.7549-11-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905115836.7549-1-linux.amoon@gmail.com>
References: <20250905115836.7549-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 62 ++++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 86e6ceb31d5e2..f04efa8282561 100644
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


