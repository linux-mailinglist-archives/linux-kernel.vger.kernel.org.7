Return-Path: <linux-kernel+bounces-802797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1903B45716
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE152484ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D934AAE1;
	Fri,  5 Sep 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmU1hzLf"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227A34DCC1;
	Fri,  5 Sep 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073575; cv=none; b=h/DQWD+fP18vVn2R3WRQPuPwZg4T2kQqJJ/aaDYSpqOURtNoozqi1+2/9O5DY6/AIUp7LJmowcU9HfBdJQE9ELqjAbMcoJgeZ7khpcYrFDOQB1fxDJjq6Lb2YtFbS/dToJpPyrKL8e040MjK7lFh45RjHzcntU0fQSSJfTI1HMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073575; c=relaxed/simple;
	bh=I0/nty3Xn1/QR9Grwb9qQxmDoSq2TaJxxZcvqOsylL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk+wxavmfb8ekU7w6D/5/1rkrAISbu1mPG93n5yMMhOtHyl7apvW1s+6AFoOuMypMDeRWlfG+h74O3jR8InegWq11V5Npa187mdD1gzGLrHHstXL/Y7h9o5+tnkrKk/VSfoou4lTrAmhv8nrTvBx6cgrbMq/TjKeSzvgqHZkxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmU1hzLf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d5886f825so1657311a12.0;
        Fri, 05 Sep 2025 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073573; x=1757678373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe/85hlUcEsxOvUu4Y2TtydFL8DXWRl3gCCd21B9y2M=;
        b=MmU1hzLf5EEhurFQm5XaK6VmBotdI0s4YC+rdYu2lR8fqUGJ2Je9bSWN1j5RM5yBzC
         BADL5JXw35PxcNUhp4ZQ4RRFSJ3uKED7v+r3s3eQECFOfvl/KMVh3h0k4QgQez4I6TJI
         jCH+Jrs8FMCs3u8t49d2skgM3p3bxGGRE/G/fJnXp54amnDVXn9jWJDubsk0prw6RQIf
         c585N4r4vyQcWssGY25dwtuVU4adC3anpBGrKulysY8/l8xYyysY77a1prLz2m2H2NSE
         1IWRbORwzy5Bt6YIpKnUxH3MPSpnAmyMkZMwxwVZ6W3ecUjSsoEvNmTmHJPj4MUVgolL
         diEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073573; x=1757678373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe/85hlUcEsxOvUu4Y2TtydFL8DXWRl3gCCd21B9y2M=;
        b=Z1UKp3gvcWr5iX+T30OBgxUPe+Pvz8nuAXhbuCmJmi3nruoTVi3W4rrHM8s8WSb2GA
         uPvlvBYX4awcflavEEyk+AvTG4gr0f/iPrGmBLzD5kgXvWk2fC5ckw+Q1X1HtB607tdE
         T1G3mW0aFeQFtNSAmKFlIIx7OQRqsan+dDdy4FuXx4AjmyR4oKvGT9pBt9OHPWnmN5qR
         6cCVyqLL4qzJBJ6jKOD+6TOanqFdQ04AW7CO33tgRVug6OHefFTmk3sOw/Mo9MVHWwz3
         o4FiIDRW9hUAlGbHR8755eVstNH+HvdKMvDoAehLBw7aBbBrObd1yI2YWa692xYzIsBx
         LKyA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7gQMHsWKtkBIDIs38JMMgd6Ozfifei0zaz7JgzR/8HY1iVoV5sbG8xudCRWBvV3IuNUUdwAldC4X@vger.kernel.org, AJvYcCWfkyWOFfTnk3fBwVeB2BBfjYQUgHr9fVDP5+uKjo8TtqRYBMcC1fKDXctSEWvXCAskCIjHSDAVEvjUs5IN@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAch7tSGh6cU411J/SQM5hucn6bh9hlMLhMmEguzwfA//k0W6
	M+R18DHU2YDMDuGw3m29iSHCPnsgG2rEGblzZcIEg19G+/cBsQxIM86r
X-Gm-Gg: ASbGncsXtT1tZlgMOGDdRVaDNFY8nr5sEVeNIXG38otQWU7f69LfNwt7qdnAXPOfy3A
	g0fvy9xCXIUCwc1lLPp7UQ1j9Ua5JhMJDDhMofr8VldakUXPgcLZ/WyUf5XDr8RakPzGDvh6Bnh
	TynMI/b3jL88bBA6vKCriJE/qg7FRdlIZFE4bRkP+IsDog7mVV1eDCjI2C02rWeu/OILSELl4/l
	twvtGEcy+qr1p68ddNb/KK8dc4s9/B5fu/zSwdJYvCxkqIOU+NzFkDT8ChQ0tSXieyCQaC0CDDb
	RdI5Wpp1Q4/lb4e3c8avFnVEVUDCZeLckb9+1iTJ6gu37vIyc6MxUxLN08/cq/ZA1fbl/O3jfdn
	4f/0YNDosnNRRV5hSIj0/7LIXXiV+CfngUjZB34rT6g==
X-Google-Smtp-Source: AGHT+IEl+0xk7RVZLv7F4wywYH/rRyYrCOnztdqRPEMZQDUlqWWSAiXr6DyjaVRavuWX0eJOl5nnGA==
X-Received: by 2002:a05:6a20:a11c:b0:246:9192:2778 with SMTP id adf61e73a8af0-24691922d32mr15582255637.45.1757073573202;
        Fri, 05 Sep 2025 04:59:33 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:32 -0700 (PDT)
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
Subject: [PATCH v3 06/11] arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
Date: Fri,  5 Sep 2025 17:27:37 +0530
Message-ID: <20250905115836.7549-7-linux.amoon@gmail.com>
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

As per the A1 datasheet add missing cache information to the Amlogic A1
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index f7f25a10f409a..27b68ed85c4c2 100644
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


