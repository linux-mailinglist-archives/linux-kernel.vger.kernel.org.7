Return-Path: <linux-kernel+bounces-784116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA55B336E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B41317882A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D928D8D1;
	Mon, 25 Aug 2025 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMA87ZVz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C442877F7;
	Mon, 25 Aug 2025 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104831; cv=none; b=sST7c5KLR7dzzG5tVC5LGPY+y1pt3OaF7ezwi+T5TtC2hcZEsSNSsFeV5VCq6O9CucmWLRsoUG/v8XztWRDaBD2U7p5N5L2LRPRc6Zf/uwOzcCTfyGHYfz1xmujruqJ+1WytzFpOujJ+2bgjhPnWzq4CKy1hEXSkgFq/EExUnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104831; c=relaxed/simple;
	bh=770tep37AQxRO9n89AddBYNABLkbpAlEQjPRoe69z0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOG0DYd+Qu+uOsbd3pCQ8qs2zZRSJt11g+9iy+gFg/i71Liqbx5K4N6UJR/pFvT2mogTilrjgGXWujaZuCodqpWzAvgSDcZQNNQxVcEg2b762EDn6K6rUj5VjPNLs4xZhiERCaJxMnJhPwxiLV27/Kd374K3xz+hxk8G22FsCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMA87ZVz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso5302161b3a.1;
        Sun, 24 Aug 2025 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104829; x=1756709629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDff7kxeWQf5w68Sqw0Af5Suelz9hF3DYdfqd/EVhpY=;
        b=NMA87ZVzHQ/K6kIIeJk7DAtN3OMmBxPrKhlIy6z2yvEfph7xqzPSg/VwwzXKqG3kGu
         jGt+4jXUxBgixhQF+3sYJ03aiIhsrox463vT1AzX2LLVCldX87+npRnRAFURHfBrzokI
         sfwOO/Tjk6p/Q3ybv9er1x5OUNbnWLuvre31+ztdw3fy0f7QIPj3U1M/XkPpqC2xTx3/
         3jUwejxAmLrcAPb4Nr/ME/GdmLaB1sNzLuyIg/iJMeGL+zLG0a9GuVquERM3UBsI8EWQ
         4DwshMwaNWR5+VcAhuL+Dmv2S2kgZh1qVwTRgn0rGbQZ8X5Aqk5UToIl2vS78Cj9gUDv
         Z2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104829; x=1756709629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDff7kxeWQf5w68Sqw0Af5Suelz9hF3DYdfqd/EVhpY=;
        b=iMeM0kd/kwjexMAxPMMUNE9Cnu6qrk7ekyZEFoWgNjJrM4hlb+Bb/R2Ex7+4c9EK6n
         TP2h2YY2ldsrZ/otrJ8qlW06cg5mnSqxL4+KHFib87NGw8ARl/wn7D4tB7yfSu5yIL1q
         A/aaMUCzOKOwNjHxyakboQyEexBirJ8HN6FJAPZ2RHu1TPoLmrIGL7G74ipAjK3JhSRg
         Sd3ezEP47cQHEVrpXYe82DnJmojxRZM1b8Yzt1Lr/3Bwlp+Qtrs2/AU0GYonZkcZjwee
         ww6/SvjSFhT7qTrSz9VjbazGQUaV2S263IjXM+H24LExnecBSSwDrk7OOTKzZJ2n/g+7
         6pbA==
X-Forwarded-Encrypted: i=1; AJvYcCWmdocp2CzUip8+KjFyTrcn903xfxJURDKGShLe/tb3PWxnp/PMKn4aAa4y7rkHqQR7qxZcXpgOPx6n@vger.kernel.org, AJvYcCX0E9ladHLOKZSgVjbhMCT6XdRkJ3jNOVlWqDkL4WSRp2OFyIo36CCL1SNt5ek34u8NYAaQnOUlR4lrfRoN@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe532oD3GLNTaDZMJTsT7N3Mf0fAP+2k7AyRCRDPPutu1GIMA
	hsMnR6EXqpLAM70eVO9Dh0RmH78aTnjIDS3eewgL0UkoO31S1GQOJ9/JqBqK/g==
X-Gm-Gg: ASbGncsCkqTZBDP1xaU57etLVvxvuFUGlEjvfqsPZ/FEntijgqUwLCUWXN/U+5gVyuw
	YwO9Bop2mDstJVV76qIpHWEoMD7pvcWCKh+Scki48eohrKLdhnh+XPI+Qj3h0FulSbHFD0RXgbm
	P+97X6wcKjC7NRAAXeruSPwSIuRDdDz4AYi+6WyluqEfL5KS7q5b7BwL/oClGFJSBRCHjJLtDX7
	mjlFPMQynrIOb4uAXgWOnP4TpJoJamYrjUQUwTW89KWgzjlE2ycTfWpD2JTyCPrxwCLWkWBFrqn
	CAgdZPdRKx5n/0A2Yyytc/xNSq7WdvdvniywjyI8wRdkalbs3zOTvUuakhZZk0KQZXD04Uc+pH9
	G+9pmwMCNcSIpNztICN8r
X-Google-Smtp-Source: AGHT+IGuuscwtZ4k2V3iWkVLW0lCKtraVC8ZN8KLi/LF46f4gd15DaExFKpQGwweAHUC3u4yjRYb9A==
X-Received: by 2002:a05:6a00:4c81:b0:770:57c0:1fd5 with SMTP id d2e1a72fcca58-77057c02170mr3851638b3a.11.1756104829057;
        Sun, 24 Aug 2025 23:53:49 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:48 -0700 (PDT)
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
Subject: [PATCH v2 08/11] arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
Date: Mon, 25 Aug 2025 12:21:48 +0530
Message-ID: <20250825065240.22577-9-linux.amoon@gmail.com>
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

As per C3 datasheet add missing cache information to the Amlogic C3 SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index cb9ea3ca6ee0..ee0b1ffa947e 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -23,6 +23,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu1: cpu@1 {
@@ -30,6 +37,22 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x7d000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


