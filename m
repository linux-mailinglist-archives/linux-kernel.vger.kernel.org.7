Return-Path: <linux-kernel+bounces-784115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF6B336E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B46017A35A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF528C87D;
	Mon, 25 Aug 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2JrXS26"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926752877CD;
	Mon, 25 Aug 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104824; cv=none; b=aXKf4Thj6QAra9oXIoQp6XW7ZPDQFFbuzwNDgIHGIIBp68N8MLof/rC7BQGlkVt7mBm21a32izjq8dJRrxSSOierlxR0IInhAYHPWUnyFRIkrf6Osnz+Xh+XeCiwv6iWJJOMgW/7iFBkWSOqD2VsBydj8TmaBjCo9dDhhUeTmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104824; c=relaxed/simple;
	bh=D98gxtllCg6LEuCfRlSPNw/2gJlYD2juIKQwyvdn248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG99KXfuuVUIAN8Rzn+8ABL3/Vxy8TYV0phwrUqA2DVHaL32txJUWA5BZ6vbpsEYC4N/FJuAGCUPs0+VrOXw2PprcYXUJyOuMRRH304fW8dKomhHLyXWc5aUFrWmpYaVDpcFtYr3lZgAKtiGj9KFmrczvWbzC6SxsDcH4pxHmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2JrXS26; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77057266dacso896952b3a.2;
        Sun, 24 Aug 2025 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104822; x=1756709622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE3Wekvqd21lu0tbx2agJJ6vLB1jjjHkZqTR9vvpgx8=;
        b=b2JrXS26DmBrXQ0R6g1AV8F4Ok4DjaCl43jGf8W8whkJ1A0sDXyAwey2pu3kxSatve
         i3cDHba1QTQm4CUHyjzr5WWKvFAooAL7wwga3oVHh0T/PP3CWf71paVxYi6waiGRxIj+
         m/bHCFHGEaU0J3y0mVsZxaUCD+wHeFrd60uPZxXO8YK3f5SqUKf5QhpGeSM1mOkm2gVK
         wi5pTtXtm6uVcVkHcN6nvw6qa5KgGpDpotxxZGzppGUdwi0zrILFkGeVeWTyftQwQ0AV
         Opprzk8qmd4vTvxQcVapu78QROf6Tj//VQ/LhHH2zp5FTD+DMQCK+MfoR5nu4eqiQJ7v
         6ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104822; x=1756709622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE3Wekvqd21lu0tbx2agJJ6vLB1jjjHkZqTR9vvpgx8=;
        b=R21p6Y83N9o4DfU2id3pAJKfFFIfsmp58AjqNBL41R9YBjT59uhK0Opq+fPEM/M9wD
         zAMr/xdKoeSc687ttU7ScBHNebv5AzHwLZYJixFGWiktj+PNqbB1kcM4pqPiUZovLoKm
         2dVw03lu4uFuIV7VBr8aqmO/XhdSL7a2U2xwfiBd/SwG9e1YisWotmusK+QleAzEtXes
         fHZpdS+CGNRQB5jjIs/O1EEFXT+aMgPyQ5YKWhVahkeKZy0dsnHCHt880/6+YXVDJ/mb
         2W8QDIffEZpNx9+u8S8kSO+1tm7NQy3kvxaMLMQh+WuN3w+/zrudDQ/iHSplMeAtMSm5
         THog==
X-Forwarded-Encrypted: i=1; AJvYcCXaZNiu8s26amxE7+0mqHUYMYF2pFojMW8hkUF9yrJ4O2d2peRdMSNLh7VLFGBMu+ApLfKvI6/qeWBt@vger.kernel.org, AJvYcCXtSMkZUYCgCLKlGWmg/1/0iHjGCrWMtRf2rKsvtKh7Hbp9XjQADHh1oUQb5nb/BIe/xg7TaVZ4bnCie4Ez@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAVN4RL7kwU3M4HYncmOfSc+/Qz8RpQ9Mj6lWNWZaND8Gy3Di
	wirgO9/juKsfFuo+slSNSktAOLjIfN5YJvQ89xrJxDv8cAtKHRS8FxDn
X-Gm-Gg: ASbGnctd78NTGz58SBg/erV/H2I87hS6TAlvokO5zAFqqfGI06pISCep7vL2t0Uwt1/
	bQZnzNMS5N5OAwrU+JvzBs0v8mJtDnneVd4muiKsFSzUjSCVD+3InPT81h9IWvIfMQg9XvaSfvt
	9MufQe5zg8X+U8A8/3UPD/n4z8BLUtDloQHbmdwdpM7YgAkrT8x7gvQuJhjghYvPb/KUr7P4WE2
	izoRxCzJTtMMMH3remZ7gV3OBGIXzFlKIzOPY1Ook1uXxadK235Zo2KFgns0/OdYnr6OkYQymx4
	gDfopJE6qMJbLz97uaNO8VW4aW2BLp08ggzSQvTkwS54zPIEY+qbQXckQCyfQmrghRiJguWaEkq
	mGKXMt5WgqJROKadP46U+
X-Google-Smtp-Source: AGHT+IFI4sVwOwHsrTnCMhJK89ZZD27xDF2iiY7KEmc5KezJ+HdRgm0rt3ypibL1UVs91B3yoI/ivw==
X-Received: by 2002:a05:6a00:3e14:b0:770:57c0:1fce with SMTP id d2e1a72fcca58-77057c02141mr4993573b3a.4.1756104821807;
        Sun, 24 Aug 2025 23:53:41 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:41 -0700 (PDT)
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
Subject: [PATCH v2 07/11] arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
Date: Mon, 25 Aug 2025 12:21:47 +0530
Message-ID: <20250825065240.22577-8-linux.amoon@gmail.com>
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

As per A4 datasheet add missing cache information to the Amlogic A4 SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 563bc2e662fa..fce45933fa28 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -17,6 +17,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
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
@@ -24,6 +31,13 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu@2 {
@@ -31,6 +45,13 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu@3 {
@@ -38,6 +59,22 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
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
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


