Return-Path: <linux-kernel+bounces-802795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDBB45712
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D09C4E5277
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4C34AAFF;
	Fri,  5 Sep 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXo4Ds0A"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B834AB0A;
	Fri,  5 Sep 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073567; cv=none; b=d/BlGpcFqaTxEVuyWGElmYrCvEUFgc+ejuRqWog4tytFiUx1B1INr3LhyTg58T8ld+BWxBIkHW3Ns+xwIp9/h36nKB/hs/JKfnoCdvgOt+2fgOkRFOdAgAYSfMhs/AzAtacnN853OQ3ZZwhVmUoJDNRMrOU7VHSRkIqLvwFcpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073567; c=relaxed/simple;
	bh=i79txWModNDW/xWv8m0QOZJFIoxMFqOWCap+2pvU//M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8cUhff1IXiobelnDp6MfV6hK7cucMie2g6Wc/jzZUNuq0p/HeUcBoPBILkm0pL8pZXaWtKF/fMd+F4AKkuSkQMPjxno//XUeh7az1YZzNbYTHamvMPeIXnUSNFMyi92NoHQvh/WQILlv69058Bp3eEN9KUUErTcn01/dMb7uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXo4Ds0A; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso1895011b3a.2;
        Fri, 05 Sep 2025 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073566; x=1757678366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flm6222xa/92k8Sq5cNvWvnFsG2Um41uLYPha1Yvsys=;
        b=aXo4Ds0AJRXXqJvPem+9p/1Epa2esqpPcLfI5aW0iWIDf46PIZHSUwHCCoNsYBEf2w
         otSp42cNI+8hEgfyi9yNHvgI1l+9wRUhwp+sQ2ejkEbu+JTYwFCnN075uUfNYHmu3twD
         TvcQOr9EM929v2DEWFwm0e7VEFiQ/wl8zEpZJKkXN+lAliiQn7aBQcT0/wWPS417qTwT
         75rIOle9KXqlv6LzWYMRBolRe+IqYE2GrAMas7rz8nmsd3RbsvamQx922Vxb2M47zefM
         lgp6pRiavZbN4KQ6f0Gvh8ybk/ssDb5WA1DPe/Q6Q7FEyVXn40CwVQ60ZmMMc2wkHV63
         BW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073566; x=1757678366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flm6222xa/92k8Sq5cNvWvnFsG2Um41uLYPha1Yvsys=;
        b=d2cogRpq4yjZOedd8a1Dp5fIt1TSi4h2nh39AiLVuqGgzYeU1+64Ct7y1AvIHepwNn
         aUWFA1skKz2H7mdEIRWBuhyCkKYslWp/SH2vMEEdX3bi0GC7WhnF4k+1sIj14726paSP
         1cr4IZEqu8FZ5TiHmJtveB+GecUrVZIbF11PPBGLe1+VbcIFPh++B555dzeLbXOKKO7+
         hIfeHGik3QkSK/npNpsGXRoH361QcoqymA/LCtEfw1v90OEWd45r9Jhvx/BA6+n0BTwv
         YTWoQYBwRzGONP9N4B987zQZTVM31c6hiJVSzEqEs5ZhIj4jRbKNsXOZTK5wIM4VVFbe
         wgWw==
X-Forwarded-Encrypted: i=1; AJvYcCUHqgRWxkjHZpF9OepmNjcY7T/H+BCmbia5pMzt4/DRaSmacsy8N3n5KAVgoAx/z65SR0CKQDx7ag9P@vger.kernel.org, AJvYcCWVTKIp8rmLvHSdMy/dkkXcDeMiTXIImrXh6hveTr2mHBrZ6H2ldcVrn5uMezlDEjp9gcG9SfhcIyBOhp0u@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvCsqYOcvXVn6GbZJjZScag2F63Dwa+l4xFyeeWteXaaD5da7
	Fn9qwLnsD5TwuOuTyeb4wOF9b7sm9YPdUi6moYjLnKt7XilSty9UwP1S
X-Gm-Gg: ASbGnct6Y0VVUpu2IHCRdALkJC9fzxdRh/TH7Ofr8GQ5oqKCG34Ed4MQ8yWGg8aM6Bm
	BVIcAbR1uqvqmWgWtabxfKbuhl58l2pZAxYxZEd4V7ujNcORmaG6J7tbqCyxcH/5Y+V38LKd24s
	Ibg5z70YT4ELLStnz5nfvmvo1HTPZgfH3fzaEWkRKNM5fcz1GuGxbdDZ7mfhiw6iFbvdjm+HLqk
	c15dnqIVkwHUViJe/Vu1EyjTi/8RDvsxQnummWyJJnfFIusHXvR4vp5sIlrxnT960d5/vtaJVE2
	9G8G0WYT40k4FQMIPgDjc3Uo9NV66DtbQ2qq9SkLL3yStueLhyGO3/ipQeI1K5SD/yzOuTQ6COF
	qurkKyKVrjz28c02YiPHQbGbHL/hMvnA2kfQhFtRbBA==
X-Google-Smtp-Source: AGHT+IG2Pnmes/eTL7tY/s5et8H9DzEQu33HG6W0BhNZAdeaRHrB5x2FRDCOngLSFjV0GySVEkb77w==
X-Received: by 2002:a05:6a00:896:b0:772:2bc2:b2c1 with SMTP id d2e1a72fcca58-7723e309cc5mr26299134b3a.20.1757073565699;
        Fri, 05 Sep 2025 04:59:25 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:25 -0700 (PDT)
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
Subject: [PATCH v3 05/11] arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
Date: Fri,  5 Sep 2025 17:27:36 +0530
Message-ID: <20250905115836.7549-6-linux.amoon@gmail.com>
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

As per the GXM datasheet add missing cache information to the Amlogic GXM
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 411cc312fc62b..514c9bea64230 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -64,6 +64,12 @@ cpu4: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -75,6 +81,12 @@ cpu5: cpu@101 {
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -86,6 +98,12 @@ cpu6: cpu@102 {
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -97,6 +115,12 @@ cpu7: cpu@103 {
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
-- 
2.50.1


