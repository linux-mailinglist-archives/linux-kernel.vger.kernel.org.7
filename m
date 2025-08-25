Return-Path: <linux-kernel+bounces-784114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A14B336E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485A717A320
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045728C871;
	Mon, 25 Aug 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwGsQTfL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF7287502;
	Mon, 25 Aug 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104816; cv=none; b=KPG13VTlJ73yMtFTiOgR2GtqcIerxfdnoyyH4TtiTierCyQpUTKchaWASdy2egmr/bZ6gkPjr6llVWxOR0qLKD/Rsdyctn87H1EvvVD2Fj6qa8PdNZQ6R/dSTPrH4ojhNtGwptDkFfPOTYrvqnjlljXOcdxiRfw6TPkH+fkCBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104816; c=relaxed/simple;
	bh=wzgmvVBlzIP3pCsnC8o4m05MAwVkK5hcDmKWzx022ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFIf5p60KNHcZrVA40eNT0KXl4u9Z1I8oADl++sYdeQjljdAW7V2E5bVfimA5f1vOBUiu1w2r5JnWaG39NPJGKtaCcVE/zXaiKLRV6oPvF+7i0wGIP5DNKTBUNJUgf44JP3ROqoz63/OhLiW3MTEtbLHcHye8GYkiRIj7IzXSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwGsQTfL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so3794170b3a.2;
        Sun, 24 Aug 2025 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104814; x=1756709614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpWYLZ3/Cil789iwatZdhzUNJcQxhQ2Jy0GGTG4rorg=;
        b=QwGsQTfL62aElZdeyLBOMUyQZoiaFf5jJOdRHQSCdDTdrA3JuOLNYS/2JXBv6LIOab
         EtS8V57nrNEn8GmsmATXX0jc+RHGTf5KB6huMkP+ltT6LLToxM/wtOL/Tl7N5dT3vWke
         xZelFretr9DsxZIVtECzHCSC85rTItXaAenKux6NeC7VH5XkHvRAtf4fQXu523QSQ63L
         uB0HMB5E5G5jguyyJluuqJunI+upYEsn9w8kQo1KOVm5DVD717DcOQziOEOv6SQPAqh5
         Y1t/NPFtqOA35fFYJ8hApjsZ23JyN7NIFTkMOWevNLeRRpA1tj0xCT8jCAEt4zK9bBj4
         qpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104814; x=1756709614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpWYLZ3/Cil789iwatZdhzUNJcQxhQ2Jy0GGTG4rorg=;
        b=jmtf2c9xqRSvCx+zsfQMjoa7Avb0K0wZbKeBxEvazQyn97klMVuWO3ZnSOmACltiOn
         mjNu6tpYpTgNVLX4BfzDy9l5gB26LnwJ+OXy+GT0U8RjRSS5SeLB/sKaiEzOZxSzpH0e
         C1pIY9X0jjwbQ+Unz7/d0hhr5q7xk9EtMXl3H/s8Tdk1EWoNABC0LIDt+l3Pc/nd3tkI
         JpznptSZX3TWUo0v7a2EK26ePmbYRWWy8nqdpBLet0llSnxqeYL0fDHnVlTHTzs0jy6k
         CBCJYTDIy8W8iSo48bwdhkqwt0WBHhPCnAOr5MOLY7aibVlHj8Y78W5yXQwYtvPqCvgM
         T9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaJ4vdmERlUDhc4+J8TGhFn3J2hm8Xmha4QM5moKCrJ3Id4Meik7CCiIlQ5UlyIAPuzM01p6QtV97d@vger.kernel.org, AJvYcCXy/WNl9ZuaC3IrSTwzGv/Fiwnl8czLwLpmk+fgxmH68WYBIqdXpEtk9vK+jPZIHs1XGxJZEoK9N+9kkNxK@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYkq3FMiRzl5tAm84uP3cCKJgSqIVFuk08ATyz5pUEt4TtBa1
	o8HDmvAnxlZdQLPW4rxwwJwrH20NBb6+d+wefVzgG8shR18cfHq9J8Go
X-Gm-Gg: ASbGncuI7hPxV4AjRnORJBh/KOsal9gjPPwjRTt4oGpsAqp6coy2hqEu4xuH8L17sNq
	ugalTKr7fSYEfvcKj8j7mLuLgV71Wc1d2Xf/J86UVXF1mdHH6Y/lizBjMASlq7kb4oxv2tYi/W2
	yJtmb0ONQlJr00lVprKamnQfeW1lRHzu1l3B1avj+pqLvy2gsiOOaaxIcvCho9nSWv0wVPPDyl0
	SHM/7byRUR8RYFpmdy6wXnlSK+PPVQ24cfzpI0xBmHnK4nBWtNo6aIEWc6RU6nm4NPrDCwnl+69
	qSqEk+LDkrXZDN5NzqGcRxlf9SASXYVSSwy09J4Ial0gnZGp/Og+2w2RGhZfFUyBmb7g02sx9qJ
	VXaXEgWKYcs1pj3xI5Wzq
X-Google-Smtp-Source: AGHT+IEJ9v2YuGTPj6e3CqpkOu27JKZc8ygwmzFRvwV2rJG4r8c49aZnSJ4hrvoX/pEwKqx+A2Koxg==
X-Received: by 2002:a05:6a20:394b:b0:23d:dad9:50d1 with SMTP id adf61e73a8af0-24340bd0f16mr15536129637.7.1756104814484;
        Sun, 24 Aug 2025 23:53:34 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:33 -0700 (PDT)
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
Subject: [PATCH v2 06/11] arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
Date: Mon, 25 Aug 2025 12:21:46 +0530
Message-ID: <20250825065240.22577-7-linux.amoon@gmail.com>
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

As per the A1 datasheet add missing cache information to the Amlogic A1
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index f7f25a10f409..27b68ed85c4c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -27,6 +27,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -36,6 +42,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -44,6 +56,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


