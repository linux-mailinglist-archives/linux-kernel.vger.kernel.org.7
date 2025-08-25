Return-Path: <linux-kernel+bounces-784109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05883B336CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F533B024E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA175286D46;
	Mon, 25 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIpBFBo4"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511F2868B3;
	Mon, 25 Aug 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104786; cv=none; b=KZg2zwBHqBk+QvwfzCjgBdqFV8niam06rSCG6zdDltBZc7RO4tAvQCfka95lzsQaIV9VX6bR/t4lkFKRnCae7VBb/NI3gSAGfuBKtbIzJek+z0KCvrJ7M1RJQVn4fVcS+dregNjoYG/rsok7FHCgO1/SQXSotAWpk0hQwJ1coy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104786; c=relaxed/simple;
	bh=utfrP39YI/u2CCXxWMX4I9ei8/DTis2F2msoPJCvSPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekNCYJHzb2wxfdy/YUGWJ2nxc5hhvjEarMAaj0C2UP/mSfz/HfFsKdIy3UATzq5to9DeLZa46OH8QhigTrkw/aKs0zrmM5W5gq0rNEzRI8dG/B1disY/qbCJ5JNwWG8qKI5VhSb5GwBQBzPQNaab9mlKUHNppVtO27dvDG3Hdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIpBFBo4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3472521b3a.1;
        Sun, 24 Aug 2025 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104784; x=1756709584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIWXtqAycbzhe4Sr5Ts/vyd9th8G9u/Hp7QGpaPlOCY=;
        b=eIpBFBo4ttngTPtkRxBn4WA1smQFIH0ga3HEu/dLhm/+iiJu9ZvIMfp+y6oy1BcRG4
         s8kTZQOvSVQrHypaE0SJvYKBbI7L1TbUCh6j9FLz5m0TgjFngU5vWbxEWBHhtx3xXSUq
         crahgrgytux3cnrBjlzTLW6p7JxW9z5JlmKNXZ+Q6cjGDIZ81wbGKkE6JqODj44qDlHp
         Epi+SbJG2YpXca48t6uZcYAr65eFKR8ihImC4n+KiOTuIlJsFuO+FoFGxA+sMCttdw9g
         jl0o2CFto2kJDHkVEJExThXZtPOKwLJ9gpY5rfJFE5VaoHElBLyTkWDdSMDLJUTvSsHF
         hY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104784; x=1756709584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIWXtqAycbzhe4Sr5Ts/vyd9th8G9u/Hp7QGpaPlOCY=;
        b=s1x/QTpWdhUcX1EiGMq18kbY3ObNsrnr3J1s83Ke/LCkihG0NJeGWFMoVxT8BLrTWj
         bskJ3Ps4hn1QhqRIPzgSowyM/IOBI5KY18epdtrXdBcho7MSTbsQi2AhhxPL9TgIfRMH
         9NuFFXO9VNH7uBEaLw3yyjq8PaVN/MKfa0Lbnr/yzAmDf2p1AamVCqS0KXao0IWTXCj9
         9kvPzFa2zwKWawiC1rfVa3IQxBp2CaBZKx94FUrl+lmPmLFh9+LjXtA5oC2hZUF4A7AI
         Wl5PEyz/cU9PUzR6r9I6w+/m5OO+PY0MGxl59BSQjEjowigt8u9g619UEBurTM2gkALp
         mEYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZttCI+xIbv8GjD6LC7n3bHcLXTd9yQ+9/3DHHkcTAm9cRDdp9wrZp+hmmiD/FGonMhp7w7me8T9iZ@vger.kernel.org, AJvYcCW3oyLnIYTPuwx0ypVWi41kIT2kwfYWON8ZAn4NpJyGNpzewlvsUkhwUZLOgRct3fTuZhefu9LYeAz4fSK4@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqDRQIdNCMVFkzJZ1z1s66II21FZDA5jS9UfKRh3n2wmgT3En
	jsiWJJH4iHVpoaRlD8RuuLfizvLddNd+aJDl3m4yfceO8ngpvWLVsa7H
X-Gm-Gg: ASbGnctviVYhrn3viWKRe1bk3H9AZtYX5CtuwxwlPRIV27Ux2y0qYDRcgexEPNBuAeR
	P5QU3wJ0C5NcJQ6gT/0cjoTLnH8l4sW25VV4a2hb34p/b30Pix7tbKS74TthzmHcKuyi0zYVvaX
	N0GFbDuVRi1FTRocAnrq+pnd2puhK6w3M1pJUpbP7gpD/Gm24w3+V2vrjkXHiYLHMMyUa8LqQ54
	bsd6HZLc46YtqpZ8eg15ivCuxDixMJppCZwxpop7EBzOkTa/5MBiFUBGVYmR2F43N2TGG1SgCTO
	zFxHG35PRvYd/pi8Xlv1DoviixOgzkWOYpnAmmhDiTqfwJVN6CKgAU9BWyBynr4u55GXpfECMBo
	/a0G+ru9l3kVQSHsSE5DkFadNMa6xeA4=
X-Google-Smtp-Source: AGHT+IFajvwzq6Qo3npfwFwSekJ/XSu0iCw1ahqWn11zFaTmKTFkPXUZL0TSPeczoZ04P7j1uIIcFQ==
X-Received: by 2002:a05:6a00:3a0b:b0:76e:7ab9:a239 with SMTP id d2e1a72fcca58-76ea311ed45mr18401779b3a.16.1756104784032;
        Sun, 24 Aug 2025 23:53:04 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:03 -0700 (PDT)
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
Subject: [PATCH v2 02/11] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
Date: Mon, 25 Aug 2025 12:21:42 +0530
Message-ID: <20250825065240.22577-3-linux.amoon@gmail.com>
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

As per S905X3 datasheet add missing cache information to the Amlogic
SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.

- Each Cortex-A55 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 256KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 966ebb19cc55..e5db8ce94062 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -55,6 +55,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
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
@@ -64,6 +70,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a55";
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
@@ -73,6 +85,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a55";
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
@@ -82,6 +100,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a55";
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
@@ -90,6 +114,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x40000>; /* L2. 256 KB */
+			cache-line-size = <64>;
+			cache-sets = <256>;
 		};
 	};
 
-- 
2.50.1


