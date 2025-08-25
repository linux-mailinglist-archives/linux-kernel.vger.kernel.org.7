Return-Path: <linux-kernel+bounces-784110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D92B336D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A06D7A5D77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E8286D76;
	Mon, 25 Aug 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE5MZeCj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AC2882DE;
	Mon, 25 Aug 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104794; cv=none; b=uxYiquPXfypyf6DdUJh181mRbmE7EsjUuKKiSHbee0je3GC1+4C5yn+HeywBvdyoCJA603nNgme4Dvpf5MBZAjcBo6A4fuFkXL3iCarA/2vL/6AH3kZuyd0Rhnzmw7F2WwvRSJKvvOriiujZCkjJw1C/TyXHWFXHzJFvZkHoO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104794; c=relaxed/simple;
	bh=I/YCYz9qGbKDUOanC8PPEizW5oFk/MjKf0W87AHsC5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H93KX1RKkQzuJnMSUeHrisPrgLoVBet5yUr2OmM4elw+876F/+ritmoWl8GhccnVr/xindiRcWQaD8XdSIl+N3O0DRT74FFRgGox7+YxNyrP7sNJ4HxdaKdYnPNA6ykhrNE7GNiS3WSYFnwGBGCVQqF3mGzk3kLX21X9Iv1CC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE5MZeCj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77057c4d88bso585336b3a.2;
        Sun, 24 Aug 2025 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104792; x=1756709592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sJCLAs9Ub2fhHSbUKPpxZHLwG3foItGZ6AhSJ9AW5Q=;
        b=bE5MZeCjVoqpNjgasfzQck+inmkIxQffGywUctoJyVz54EfAWiu8meKjHLAPYBQfgB
         Uq4R5pTrTtIy3E0R9/ol7Hm5ga8mH2euSMCxHSKtlq+5aCdtmByI+gNoy7NLM8rL2dtL
         c93f1OrAkQm12lU9iFsv2sGvXRpS/5H+T9vN6Ck3u64pLQE3wM11cvyfZZlqzYb1GMsH
         Wndp3/yL+7crLyAdQMK9pJok30mHVqeHIBJQDa2/wjL51xtHmw3YYeOflHZmF7FGmOLh
         IHHcluoDKSUvjItd0QPXKXsD1Apaq3+KAcuowvmLZdBcitZivNTsuM9/G0lexyE8p1zO
         Sbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104792; x=1756709592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sJCLAs9Ub2fhHSbUKPpxZHLwG3foItGZ6AhSJ9AW5Q=;
        b=nWE4gUXe43Rt8n166QAdXDG7DiD9dYv1uCJ1TaoZM0bR1JpW0Zr6BZGxQQDK/3vR7o
         Sj9NpzUaDgLxDOHgxBhr9XVpmnOTTJagf8td4YhOXMOuQTEc09D8WuAIQ6s0j3WwUN3m
         Bqtn7+703PMQQdoeh4JCLS6cZ8QvqPUgmUaqBoCW2s7dhtsHF3d5mH/FzeRfd1slsHnS
         sd9MaAVmfjwUr1FJzg/k0s5hLvR2Rh4FVMdD61pqBX+zu6rR7CD9+0xVdDx203TO1Luw
         c2chkanJle5O05HV4k9VoTw1ov77HdnDO7eozRWd8almHBKHBzGMplpTI3tzU7IBuZt/
         dqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUqdJ08nqM0KdSzK9yaBhBGI/NGYTDTBNAuG8bWdhGXXs6mJZrcSSWjN6+Hvh6fUnXpLvvv+7zKSxYnUpCv@vger.kernel.org, AJvYcCVodEsczlTbBwUPfm2EevtVXNAHN1/lbQmElN7k4c5h1K8Uk8T/QA3a+hbP3ERDwlHYK5pGU2B9WMOC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wGoWHDGcvok7fIiDppmRxdFTs0moDIknWnmdQ2SEW/AQZ18b
	DHIdU2xPSud19Q41u4iA3ADGcMHDuNwTuAYGpP1ym9ds4CvoLECjVnOt
X-Gm-Gg: ASbGncswkuE9VRvTmYb/iihKYdjtFu2gjNaWAhn0JF0ybZAR5odyp7rOXHxbth8M68Z
	iJ8gI1/90JOSzgpLFomCgjZiIzruTpjOP3p1+g4nkb9gmbCZ6cN7L2KZMnL6PO39N6Cfg8tC1FR
	m6RiuJYRYP+a68lsTBsDcNox8oOshyk+vDuPQClJ3BOoTwbG6l7a/yeoGUDyeSz2CngQ7PqV5pl
	65V0pk7ciZRM1HAtcTPeFcJdOWtE3yFjSRvkrzcUiamHBW85bxVeiA3ZBSdhXbDpUaum65TghX7
	BFyrriqEzsv4FDU2XOORSuKdMFuUrnfVmius+cOpM9bsjKPFBSJ4S2jGSFj6yge8kluohdqb9nw
	1L6uUpIV/vbFlnc8M7t/R
X-Google-Smtp-Source: AGHT+IEuXAC6GTvXdh+FQR2MmdSDTq0jrcSEN6KLs/qvLz3Mrs1wH+kkzuUrxAawY/6c/RpxtZoJxQ==
X-Received: by 2002:a05:6a00:3927:b0:76e:885a:c330 with SMTP id d2e1a72fcca58-7702fc75bf8mr11181399b3a.30.1756104791843;
        Sun, 24 Aug 2025 23:53:11 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:10 -0700 (PDT)
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
Subject: [PATCH v2 03/11] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
Date: Mon, 25 Aug 2025 12:21:43 +0530
Message-ID: <20250825065240.22577-4-linux.amoon@gmail.com>
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

As per the S905X2 datasheet add missing cache information to the Amlogic
G12A SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index deee61dbe074..1321ad95923d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -17,6 +17,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
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
@@ -26,6 +32,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
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
@@ -35,6 +47,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
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
@@ -44,6 +62,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
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
@@ -52,6 +76,9 @@ l2: l2-cache0 {
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


