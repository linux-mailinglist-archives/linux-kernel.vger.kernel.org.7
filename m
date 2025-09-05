Return-Path: <linux-kernel+bounces-802792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D390EB4570C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963855C2EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763B34AB1F;
	Fri,  5 Sep 2025 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIcT/pQy"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3A34A32F;
	Fri,  5 Sep 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073552; cv=none; b=ghNPzelQXas1CgVSgC6bMD8Gear34TzUiv2u9b0d9Ygsx42qgmZwKYQu8n2ectgClulToOw7BQHPntkiWnGqq2CnmmSe2KgIeqyM38OE7rnhmuUysCHfyRT7Wr+y4x8dL0Ky6Vaq0sl6Wm85gk4thplJe14MsXoFxX6zJI+ll8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073552; c=relaxed/simple;
	bh=2l7q+i8LWKqzqaAoqMX56jT3MFmS7S2YhS34PWVXVhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+kOV8QP8keroESzSL27RoNItq0Xu9SjFBBl5cTs4LIP3zNWfOEPxNMyPVGNTJDTThLwlZuplC/Bp1a9NlHCyxlBKeZNzVcv3a4RKsBXm2BniXVIEdTX/teduGHQZzuxlQf23HFMkiQUhhPAS2enIzsuwDOExusyor6z68wTSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIcT/pQy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77256e75eacso1871131b3a.0;
        Fri, 05 Sep 2025 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073550; x=1757678350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYuNyG2GAqaie93/7NeU7tj1oNpzzcQbM9L/utkdmAE=;
        b=mIcT/pQyn7dHMsHyDiqCAYp+XDHk+KmA3eVCq6aUsMU9+ehMZXPKEVhl6vtln19Twv
         3RoI0QLuDoISOtKrSwkh1NE7/00LwfeMMElIjLfjutLCMkZGyIBn1CKX8m3CGc3kTJLY
         1MdqxC6+BvhuDXAd/wNC49ejsoImuriUtYT6OKdnyqoN3EqKmrIFbzKBan4SAu2RHQ/I
         D47ioT6qTVRlz7b8gc/YsAE5n2cyPuHhJwOpnLZVguFrghp6JCbupU32dRZ6JapYY8E9
         iXlCAuXMparC1/VJ1c5zepbQdztesUjjDWOKhyU4DMK6JUE5Z8PsXUODMo5wG7MfbfEw
         7TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073550; x=1757678350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYuNyG2GAqaie93/7NeU7tj1oNpzzcQbM9L/utkdmAE=;
        b=kd+GLXfyv9ayFbDr4i7W7HapOv+h2WHO4SN3j1nAceilF7BIkF1VeawJ9uXYcmbwPz
         /Z6AeKoThuVRnv0rNfXxFuyjWB70dn1ck7xvVl89U3RjORc3x3soxBK4I4ckQPZdIw2R
         T/Rubw180i9VOxxgnHmtzjE63S0tvZnnc3h0NYSQwSsuRWVTahyzFokSOHlFsm8kBusr
         QVqAshayaGLvz9eqLuVUI3M5n18swQzj3ThCjZwmeHFFU4TMFA1X7uQXTL7yF+c9C3Vb
         BNxS9fgo1eHalRYWUHwyUV2aVeUEwny0SORBqHKExZT6jDBsQF+nbt7WvTnXXNig0aGc
         6d1g==
X-Forwarded-Encrypted: i=1; AJvYcCU/BjylmQVnj8mi192xtSut6nHGBz+D4mMFxC3ET6qvlMZgKB1DYOB0Ul7m7TC6VKapp2D+umlU8+K59CTG@vger.kernel.org, AJvYcCVNXIbz1F6kR+VRrkJdiump02so0NT1/jC/k6fwvnm0tWiJgknu5ohAp8vYp4HbIYV+mqfY6n3wLzRc@vger.kernel.org
X-Gm-Message-State: AOJu0YxdL3Uh3Y2+2aSTMvGdu6JF2oIpa2haIW+HR5VRkQFImMk3Im20
	KezYgJUL4mmRLkP0yPRmAnKyzF7bWwb0jkrOTbLgSaKv+/E1Oczc0Fmg3AED5w==
X-Gm-Gg: ASbGncvfom+lZ+Dp4/3fkbufbSdzrG+CVyrUtFHIJ5Sm+4Dk/wPCwXKrOisMjH4dDdW
	opdkNOxfx5J+DgcO7Ml2MztQh0ZhpPcmJ7AvClZ0jXyhjUDThuAJ+J4CU/SW1KuSYX0YqUSdl9t
	PqPROuTQCmaqSAbptj+DKuggw/aOICDOa2VzpKJAtDr8FGk73i6gHZ2Jd++wHB9AsLNFdmjugCm
	sRgkn/525NHCPATFCjIfEYEovvsGU6Oyhe1Z4TyHlQhmFvZl0L/TPwteJFAMpZxGCaCRwCjrAbj
	ZqB489E6vkZuoMKt2tRkfazpjtFwofyI/MR7vdZrANILs30m1UCX8dvu0D4/MiLk73p2/4Aw0zd
	paw22PLWYkvvkxueE+Xsa
X-Google-Smtp-Source: AGHT+IHGB/yjSbbs04l00A0cSu2Dz7NKsJx4kcQ5AewH3kzpAjOf8+eC8mvbiziKgtWS8cvIJPgkzw==
X-Received: by 2002:a05:6a00:189e:b0:772:2a2d:5837 with SMTP id d2e1a72fcca58-7723e0d33a7mr24141035b3a.0.1757073550226;
        Fri, 05 Sep 2025 04:59:10 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:09 -0700 (PDT)
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
Subject: [PATCH v3 03/11] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
Date: Fri,  5 Sep 2025 17:27:34 +0530
Message-ID: <20250905115836.7549-4-linux.amoon@gmail.com>
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

As per the S905X2 datasheet add missing cache information to the Amlogic
G12A SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index deee61dbe0741..1321ad95923d2 100644
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


