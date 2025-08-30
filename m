Return-Path: <linux-kernel+bounces-793067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA1B3CDA9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154E71B28317
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CD92D3724;
	Sat, 30 Aug 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUzq/5X9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC02765E8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573282; cv=none; b=GBF+kmJRztfeyJ2harbPycCZmxWpNmM/4Bj3c/88f5qok6pzD4zx9zgMCgAnNHt3mLSPJTUmHn8ATbukQ476lG4IDKTUcywIU8eKyouqjfa8o9lVvWBTYqr0bjZjmI5NkVeWPMi1sK6aU5mBEo+gKKWBuCBJKSW9ND3FZL0Kkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573282; c=relaxed/simple;
	bh=QqWeYHPVLq//RwXvGMYa4TqqaGs9IG7D/NPVlveQnRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUB0PazQTiav8eYU4+10XBrM/1tdtkKCHqEqCK36EkD73xxryD+xM+rurbElu6hNCaz8C1vnBZBlHA+8g9NaY/yPlhCTZj8DgF5kQ2pKTNZgNbn6BluPHck6d2lbpxnL/AVdfzCbIyxRbYa4Ge0XTN75Iw81btKHMq4sRCyxeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUzq/5X9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cd63fa0c5so470376a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756573279; x=1757178079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=us4cNYtwID9TjD04hpr8jvahpWc5vnsHqsFH+7B5S9o=;
        b=iUzq/5X9hNih7iqFPuvguQ7PFD4kSeI5uFGlsl2iNAQIUJodJfZI4N2cHpQi6VG9Jb
         XR7LqETcJxY9wAQJXh7tYEkTSbqjaDutnMiIkv7obGlcDX2/8xb85TiI114ogCm6UiCp
         JIQO9XbW5BLXHiMFlGY/vsBWhL14Iow2IR3NO54JB8wrLMVYSRfSGicS+cqv3fv27g5J
         xte+yj64uz30XRpvXE9G0oe9bYyfNNYxBKeZPk82YlMasBIeoQjfgT++xVdSGFjfM8po
         lQb0TXG1jlPt076XP2kaX/kHB8vba5HZ/LuaGdyYXLSGx0u7/1o5otvTIYm0iByWYTtG
         k+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756573279; x=1757178079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=us4cNYtwID9TjD04hpr8jvahpWc5vnsHqsFH+7B5S9o=;
        b=aJzHsEwWyughHOZ5JqeXJ10rARJV1mAYnwGSNcbulYC8FVGsQycnfbBM3afwbGvXXy
         FamFjA9nuq+4Oc9DvKN9r7GaldcW21wh+zg7ex/ib3i7ER0TaK0G4oZUihA5vhq3j5wd
         A6gf9nNKn9tNurSrcLp0cJYBr5gzf0QdkGUT+FI8fJ9tqsddaqWogGIdVLmgB2F/s3DB
         waU/ktUVjMMwywvSFmBWwGQMzmcVHDgqopjvopJO61B8TEyafkaItmqXMm00ZnVbVKio
         39ljSDZ4dFDytbuYwnw5gufNMDtBGZ8/ApAHQHbkflGes1tn5Gw3kd7Nb4eqvLsvSVgO
         Udhg==
X-Forwarded-Encrypted: i=1; AJvYcCWZVbJZMVlD1YOmHdnspQoIMRHC7AdE2AvreiMS6d/p1WS5TlKlsc1sdhZtz4+QNKLSNW74uaTr0BBnDQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUaaP66jgXj5Jgr32I/9S/w8objnVTMhCp/TWPsdTVitq6Swl
	uxLVTb170MSFxioD45sY7yKk4qhtYuhkJosry/naIvZi941hBrV19K4EmH6kiOnMxAvqKm0Lh9I
	XvefR
X-Gm-Gg: ASbGncsN+DeBzAsIg3b+lctVBF5+th04MpDjpWtGqDVM2oh5n17Aj0UauixPXZM7nWR
	eXVMu4CYTviPHQwZVAFGXAmwaTEXNzgsEnrogikZO7JPoRJHjYUUz+KKYqkCiHO1tX4S29cYTX/
	j5YR30Xp/eEQVZmWRHLT1/gqjg5oDt+GcDpIw9iPuXpXy5G1NzNBpXcIBE/uRs8i1K25SG02No6
	JRYrIFzn043RSQBZrwlNvhTy3lVCRTAk3Q3nk6We0RHMKmo6xt0PI2JJuTB1FNuQ6hRoypa8hby
	dPPj2icA8tu1D5zqYPPvDhcpzk15ql8HzOPY96Eomg8H9M9oH1RoIde8fqjxMV6H6UJGq0Xi1bM
	7klm9rS/BIM8PGe0p0Fwd6oyYkN/k0cq5jT0CN0SGlxUJ0w17VA==
X-Google-Smtp-Source: AGHT+IEa1VI1o8sCudVEZfhZ3gaC0zyMofPPT2ZBfSOCrdhwJHioZOMNxGzq3r24F58nX/VQxYQy5w==
X-Received: by 2002:a17:907:7e99:b0:afe:af91:2e54 with SMTP id a640c23a62f3a-aff0f15c2c2mr290241666b.9.1756573279207;
        Sat, 30 Aug 2025 10:01:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm309038766b.88.2025.08.30.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:01:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 19:01:10 +0200
Subject: [PATCH 2/4] dt-bindings: mtd samsung-s3c2410: Drop S3C2410 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-nand-v1-2-05b99ef990fe@linaro.org>
References: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QqWeYHPVLq//RwXvGMYa4TqqaGs9IG7D/NPVlveQnRw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosy5Yy3SpNOt0HGF2AczXJ3AfabDf8t8/xXbJl
 wARVHKMzUqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMuWAAKCRDBN2bmhouD
 179DD/9+2t3OdNYd4i3brhoOrz4Kyz/N483Dm/aOqEzp3IwdOT6Jo+xN65Iw6AYjfqprAWKoy8Q
 4Wb0iynxRE7k+s0vA4+B+Oz7PB88lqEIrVPQyv8qRuRrUXV2tMUMB3Lyl93ky8xPOVoI36Dg8W8
 ATsAenaLvUrsH6Dt6xn1Ivx0Au5J3cnA420wk5GAK/Wtapt1rj+o0WjKL/15V9nIehpsY9qO5Hr
 ZG9w8rv/vZuNdlqrvv9JKvpqWniEcdj88JcjyzuxFkKSlTPrSUU/M4lLJpc0BY2nTJWpaXHh1XI
 GVxWW12/Mqeru3op0jgKXZW1ffB/36DS5koHwuQOkIx8vQ8FA7jc5e76pL8R7vFU2f29iqtyDsc
 2BmKuq/m391sk3V/C6GCUeP1LaFgiaFLsi5hJZ3ml49u4lnyXcBH5c+ZhjjlTJ6KNiD1XBStNcI
 exXQrh9LaigQgHWkI6kFbAwoU8tuDjcUzZAWrlSbV3JP/wGvDk5O4n4pTTNmrQxrQv3/hauBQ13
 PLdI7t355zMZna0djeTokra2SWNBuqEMRAx4fO8vYHNEogO9yyXMQ43u/Ax1nwFOqFPEnydUV8Z
 RDhoecH3Oc+LKFPgdCbAJZV8a3O7P1lFx8hFBUdvgwKAzhoyzdFv0SU4VdhyConflzyjHdFozOy
 hSPZD7UNMnmIdPw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C24xx family of SoCs was removed from the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of its compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mtd/samsung-s3c2410.txt    | 56 ----------------------
 1 file changed, 56 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
deleted file mode 100644
index 6354553506602d452acd02dbac48c854b8b59cbe..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Samsung S3C2410 and compatible NAND flash controller
-
-Required properties:
-- compatible : The possible values are:
-	"samsung,s3c2410-nand"
-	"samsung,s3c2412-nand"
-	"samsung,s3c2440-nand"
-- reg : register's location and length.
-- #address-cells, #size-cells : see nand-controller.yaml
-- clocks : phandle to the nand controller clock
-- clock-names : must contain "nand"
-
-Optional child nodes:
-Child nodes representing the available nand chips.
-
-Optional child properties:
-- nand-ecc-mode : see nand-controller.yaml
-- nand-on-flash-bbt : see nand-controller.yaml
-
-Each child device node may optionally contain a 'partitions' sub-node,
-which further contains sub-nodes describing the flash partition mapping.
-See mtd.yaml for more detail.
-
-Example:
-
-nand-controller@4e000000 {
-	compatible = "samsung,s3c2440-nand";
-	reg = <0x4e000000 0x40>;
-
-	#address-cells = <1>;
-        #size-cells = <0>;
-
-	clocks = <&clocks HCLK_NAND>;
-	clock-names = "nand";
-
-	nand {
-		nand-ecc-mode = "soft";
-		nand-on-flash-bbt;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "u-boot";
-				reg = <0 0x040000>;
-			};
-
-			partition@40000 {
-				label = "kernel";
-				reg = <0x040000 0x500000>;
-			};
-		};
-	};
-};

-- 
2.48.1


