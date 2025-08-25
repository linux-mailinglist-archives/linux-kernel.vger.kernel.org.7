Return-Path: <linux-kernel+bounces-784111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1528B336DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82848179D47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B0287260;
	Mon, 25 Aug 2025 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLPxC4Fk"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F841286436;
	Mon, 25 Aug 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104801; cv=none; b=NxaGC3yc13nLxMzf1+NrBLFYCCrH0Z601Viz65pMP7k8c70hfR0y08uQq7SYcUEFIalkWG/Ids41BplUVe0KE3F9/md17tBplNXkAXyik+RKhvhuzVqujY2d3PB5a299nPfBT8F43SxU0LHKb5rCtC1WHQIJLGhMlxkG8RtZzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104801; c=relaxed/simple;
	bh=Bp+33WwHMYhpfftkdn36iFE6BhgJ6GvkTH8MmQMHgQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tie0R8lMRjOZb0SU5TDKAuIKPEWlVuVxlsvMWeEW9LThaUH1kE78CMV3t7d3UYbhP2JdbxWWEYT5d2VzM2K8xCL7blExNNkSMoLbTx6QIMeFvcvlzXQ6ypkqugfvGFQxOujGWYSPFRb62Gs5yknvo9tlwbqodxzTR0km5ZFsi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLPxC4Fk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7702fc617e9so1966588b3a.1;
        Sun, 24 Aug 2025 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104800; x=1756709600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ2N7k0QaRKvwdt8Row2Gwf5GI5DjGkFkVkpFIACCKQ=;
        b=kLPxC4FkLrA2p0aUBbl23GbJ8UzAVqt5LBBYtx0cHcTeNUlua+GLER8jNNbKfL6Arg
         xXKEhzf7CTI0O8HDA6gjyognxH+xNT1WEAnlYuxXbRnybJVE1qeS4JndctKMH1m6v/lO
         7aFF1B5hmF1dkl48P7RnSbd4Zg0H9MyfVoq3BfHvz4WnYY+6E9w9RMV9yM3cbEpAfsh+
         0UkIsJDZx+GyaYMeqohC5Z2y2feheR1its2DvAQ22VVeit6kBg3sh0eVWjoQDLxt/ohh
         jBlD1gH7UWgStGCheaDBI435iup2LyhmbEBwUfPT/XO6iSF2V+plwzVREdNtjmOEzezO
         UJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104800; x=1756709600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ2N7k0QaRKvwdt8Row2Gwf5GI5DjGkFkVkpFIACCKQ=;
        b=j7HFvoWsbjoxOdc4jZjDo9kza7vpOkmjjyx58IWkltaLxLXQguiJVDWlh57P6QevLN
         UCYgPCplT+c2fOjGcI6fUMKTuR60/3hXTGBWVLds5VipEkElRt0Am/UH/3G9X5F60tPx
         6PKA1MBqfpCWoFtXOF/zfYRjreUakD5UL50OHQibazwFmsrHb92O6VI5woNd89H2zzSb
         HhdYfcy7VY8n8jEhj74McYt8OGBhPWj24nDRstqPVfYm+7muvomnrD9bkuY/aiiIB5qd
         ie/ozK5EqNCSaOsGxx7UJzPVU3t8IO7R8FCocaG3ttf4fRgg+JD0WLGjUI7xdDJiUuIu
         dZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVRn5QQQZtQ8FvWbI4cAcUP/2x+RnZMMFQtrU5uSFXALwUlu44Amg6dB1NWhXCkWQeBKSLCjn8qtM0uQ+H6@vger.kernel.org, AJvYcCVxTpOEjeCmFoXjAl+zZuU05fjvkFHtaVcQPqdHMe1slWDY5Rh0GaJzwHUicm5yx030MQvGdl+8n8Rl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u1LxLyc4d4jSyPHdGZrFzMoT1Uep5IeEuhWHRE8QS2DgCDIJ
	in47aTxtT9dGEcMCCUyiTGpwpQARm4I88P97rUA4OSUkGUFRwG6ZGmUB
X-Gm-Gg: ASbGnctOA1rIumAu8qUuYsdCbjBz3VZNuPpa4T0Udw8mXJj8dYzdsxmdgDtU59fIR/U
	bEWndcz6DgnsQORLlJ2yJIhoSwXBZbhcGtyLqRdZnYiySlT3Az0+wf4YyWRtC+4nbBJ0TPcwS4i
	HYXLfFYUiT2yIhQy7ckoJPBKXZLBay5rjicR404Lt43XVzEwq43xfJxHhSMntN0POSe2KKhUial
	F2/k++HmZPpSu1kj3fhKSu1ezXDr2BzM7i3qymoU69ZKFH0Bfv+0q3iEPvwnWXPdBBT/9dDe0eV
	88q42V0y2eKe3Aiw2TqCNthickzz44wULkmWHZ2Mf6OiBw2DKXeKkq3TSUbwyyJd9macfWuZ2kM
	3KLvsEiCM0oBThWNsgAKn
X-Google-Smtp-Source: AGHT+IF6BCINg9H6AheHy21bKoLfAApE4pOB1Dn/YBMZfa2bQAaftLXgoyLvL/npG8pEcRdiLKMN3g==
X-Received: by 2002:a05:6a20:6a26:b0:233:b51a:8597 with SMTP id adf61e73a8af0-24340d027b3mr15304899637.35.1756104799667;
        Sun, 24 Aug 2025 23:53:19 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:18 -0700 (PDT)
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
Subject: [PATCH v2 04/11] arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
Date: Mon, 25 Aug 2025 12:21:44 +0530
Message-ID: <20250825065240.22577-5-linux.amoon@gmail.com>
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

As per the AXG datasheet add missing cache information to the Amlogic AXG
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 2df143aa77ce..04fb130ac7c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -83,6 +83,12 @@ cpu1: cpu@1 {
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
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -94,6 +100,12 @@ cpu2: cpu@2 {
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
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -105,6 +117,12 @@ cpu3: cpu@3 {
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
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -115,6 +133,9 @@ l2: l2-cache0 {
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


