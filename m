Return-Path: <linux-kernel+bounces-802802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38364B45721
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104674E551A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE534DCC8;
	Fri,  5 Sep 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak9de5Dx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9EC2343BE;
	Fri,  5 Sep 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073614; cv=none; b=Bcp+NbHV8BMohAhW5apJT9iwlWqRBb8FuyoeuUh8dOwYCg0SdZUQbdhsMf6Hw26kRTy02P5844TolgSGS6+TReM1LJko8rdJL8pIS3lKGFaRDZNHlKmCW3OYHT9WS447JoLoL/7P5jtLPMHlDyTBpGj9/API03AlHGND37l9Ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073614; c=relaxed/simple;
	bh=lXISe0xsz5jXAKAliGKbVi5V4LE36s1ZbY9PbPUaJH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ5GqmKOt1tjLQ2CjqwXs8+wtrPg7O3082m379w8A3Equ8J/zoLkvY6c9jvacL8Bxc1jnpdSXERb4Lry8KKTOptUVgNyBRqlPqU0wiFvt5pPOmXY/k1rvvrFqde6OEy5jfv8ZiFQ84FhG1cTPDuJ4RI7gmzqLaSFNXeEuaEPJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak9de5Dx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724df82cabso2440561b3a.2;
        Fri, 05 Sep 2025 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073611; x=1757678411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbHadlRPNZHf4QM7oZmMpzNXcctgtaP/Xq2UPJ6KP14=;
        b=Ak9de5DxKf8CT0W+3wDkQxWCbSWzsz+85n8o2YnLwmPefI0qK28wPJyGvVV2e3SiMF
         BhrK4Aok4WbfC08a2LwMvMLGLcueeo0rWIrGYG9ASnJVBWdi9XeWZMR02I9KENIVApGV
         jqqEZwuB3txpLNSzCe2gFJbqzwKArJOJixQt2Oxik3ssgWIC0PxtJUMW45UN2bWoPEtX
         OB2uuVbZwVtMO8cWHcK/f7VN1n/RGeIuNfkdFaMIrlTRa0ozPgnsiXwQztGkXm/u8YRw
         bVWnxxgJP149KUe/sAU+/XIBRGThJZATWIjQ66+v9JDcDsfGNGOJDi4m/3zna6oVZFBb
         HisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073611; x=1757678411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbHadlRPNZHf4QM7oZmMpzNXcctgtaP/Xq2UPJ6KP14=;
        b=xPOOeAdLuDdGypmdxO+LnkGlWJw3rVgolua35pQQy77cWPVA+rgmlDjeWaohVZdjlL
         WHLJLr+UnHL4HgkpyTjLWr0jnGXo6h0gAWATxPKXqTEmYKwioMYbK/rGU4aGb4nGOluc
         mVQinyuhdLRPdYqST35EBNopLBWSvO8Vun9GS6cbVp0Ep8IcpRpANHcdEXW8g3CBF6tt
         i7ec038eY8oeMDJBnUbhaPX1LLiZBmmhM9PPuylosxRQ0OHEU5Y9I+amaYMV8FcvtZTQ
         NM30e267S78YXXM18DjQyZlsYpsIyr5grjv8NR0YCSUAOcb+xWqYEVNna1vh2ll1FXii
         Jw5w==
X-Forwarded-Encrypted: i=1; AJvYcCUkEEVSUGyG6QEGfXUU4IfU/b8VLFIZ4vw0xCY1i6gsdWy8eiuInDW6SLcXKCZsOW1nrmSP8fE+ULJL@vger.kernel.org, AJvYcCXU2BjalgOVLa9KsF1e3NeCdeKMANNzrIY9owwiXxoy/RJwfD3dzCXEAgMEXBXczx7yBvJPB5QpkKBtjhWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XEG5QzxroGuEh79cLt1vMOxTgiR2wW3wwEeoYFs9y5h1xOnV
	fBcg7DKTzleKT2yJ5Bka1QxV3tLddWaI4JC3w9pgsH2DH+k9hiLJXKkc
X-Gm-Gg: ASbGnctbGLaxef01bEmN2kBaqNx8th9tmBY8UV/bK+Srm033XCC3k059IFVuamfhcyE
	SeWQ7qujGUMDZMvjjm6KBv0mrh/DTP/+YZWYCmmvNo7tnIYyVkHeG+g87fvWbXxBE0MdUtqqXA/
	SYQyaQ+PA8bIi8VVkU9EV9d1kzEbIv1ruaifUeSqmjDELTYMCNPQQDL4uN4LXrHyxcYJm8jZoxW
	AkaRt/db7jHciRLSYPqvE2DWAU7e/Yre+Hz7mmc1RFEBSvNiIMmUlNn2HfZpohT4RwEN2v13EBU
	WDhl4DjzEhGNkf69p4/b/zA0rl850FWFJrtBBN8K5Wai2kYvEQQAuJAvZqqnlJyaQKGnkMioZ/E
	TUZz28gFA36QjjD5QOJze8PtWhcZADZw=
X-Google-Smtp-Source: AGHT+IEHzTd/Vu5HIqp5Obu47X3pNPJVxl9wP0t91OrOXzNkFGFINMn4lFyMzbYJuqchoSIRXpB1mA==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id adf61e73a8af0-243d6f85b56mr31346449637.59.1757073611194;
        Fri, 05 Sep 2025 05:00:11 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:00:10 -0700 (PDT)
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
Subject: [PATCH v3 11/11] arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC
Date: Fri,  5 Sep 2025 17:27:42 +0530
Message-ID: <20250905115836.7549-12-linux.amoon@gmail.com>
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

As per T7 datasheet add missing cache information to the Amlogic T7 SoC.

- Each Cortex-A53 core has 32 KB of instruction cache and
	32 KB of L1 data cache available.
- Each Cortex-A73 core has 64 KB of L1 instruction cache and
	64 KB of L1 data cache available.
- The little (A53) cluster has 256 KB of unified L2 cache available.
- The big (A73) cluster has 1 MB of unified L2 cache available.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index ec743cad57dbf..6510068bcff92 100644
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


