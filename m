Return-Path: <linux-kernel+bounces-845194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC69BC3D64
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4478352B93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999F2F1FCD;
	Wed,  8 Oct 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAbTbYXx"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA872F49FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912125; cv=none; b=SiTQ8QRVlew5wiARN6kxX3b3ZsY6F1MitGiowatQMnN01jad3OnIsp+Q3+kdRA4t6X78JorYl10ej7zuUzGuWFRjlPBTtQSJhuWJfU340t6XSzfPw0TauPiLdvwtVOLq5yY+sWbq2zOADpTsJ/wrdpqgw55tKQEacPw30opXyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912125; c=relaxed/simple;
	bh=o0ADLZP20Gf+RaCUCo73PsEebUZu5lyI6twUNiTxrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV8+9U21lJUCrf29x66ew6oyhewnqXDRrHwdF3OkKH832yZo8lo5flACnZTG8/284JmuqmbCTc3xB74XbNV2aCEVqP01kd4rLSVAOGeiQnWr5YSaxcsIujZ5aILrSX3WT4Go5LY/xTR6K0KDgxxK+zXXWCbsBC1MUFO0nvIyoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAbTbYXx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-58d29830058so7224511e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912121; x=1760516921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=QAbTbYXx+KiIYB/ZvMixKYuuPKCqRdXmyyxStMPglMMLGcAkd0bZH7y+9Yr4XLlQFU
         WD0B44OiADsmxjVX+W+2mDSqe162BmEJNDC6bMUXPuqhlKVaWLEfVQ2eM2o/LA8OexMS
         j5VtyYdoevLrXfDq+HMH2jEfOSKOosgo7+Xlqhc2+XHOLRDyq5etoPASKFEuiNYyudnN
         pXkSZUxXFVVP35PT6aePS7JkZW+g4+1+OkTJ6Q6Jr64NmqJ/WyE0qR8H4SebCdZdpkvi
         cFaMS/uc253ayCxN/gSfqkvXMEoInv3LFIGbg0m7jlyGOutbDdmcIaYcd3VbmyT0LpZG
         w2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912121; x=1760516921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=Y6tp3yFdxkpAs/HrrTvCpQzLnRbsSxAU0Q07FzgVbPDxSeBno/jHdy2+uSwPsIR40R
         NPMh90rBrF5ODexTYgDDYf3emBLgx8l1VKgf04z+nhxKXAlu504PeUQch/gwrPRV9QPM
         XobcHOkuCm8Tx8OjDBIyRgE9V0Kmr6vcDw+cTsZTEeOX/x5kdKcWw53SWwz27/c/Oe0q
         TDbAHft14niCL9KGcHtINqJXcN+4kbY8A9u6v4m2sAygt5ls3TKXktSUBbAAxothgCfk
         o1FaFwlN7OAfaBZFs/muzoVQX/zADgNY9Qa15rlIv0CbXJOITyJZeq4u4edPXVdoQf52
         nruw==
X-Forwarded-Encrypted: i=1; AJvYcCUh+DQDn6k0hytYvit1dHg4gOj6DOykj2dQkukcnBcFVVEJwRVJAl3F3NfBNOEP+CUMluYQBXW042uKgd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBFqNyEpV+PRFLG7Svy/eC3gCFcblyYm8P8saYIS7GZh7qvrY
	Urcg7m6vLXjqW+XvH7sQTKx/DZkb6lAX5r/dVD5AvKAYYrJdKnEX09M9
X-Gm-Gg: ASbGncu+JjlxRGEMIG7oVpPv+ap3ljapi5J7zxry9mCGQ34Q5Z8yf2YP2cWZLVqGaOk
	dvvPaueN7AYgcF8jJQRD1dMmq/KSX/qXTRywFBZivZju0akGV49GisQjEgljFeI/SpZtu+C8Jht
	P5Ff2Gp+VWMIiHSMM8K48+qjp5OOW1SgY+dA4d2JsEFT6jFseSQhjv3f7wfaXZz1Wz2QgkC5RHo
	+VGPcj9YJPoHGSJka7u6jJbQjkLkdk1A64x+dehQRWtX0910gEN4fCEwYvcdJPl21EThxeCN6QN
	54KUkbJBz3jqvRyy7gejQYRy//1ohRlMA/x88MLxcifxqINtVB7xV4v6+d4nnJBnql84MQkkZ46
	JkmE2tMEvGH7fzpr5sDBLwE0zr8xbEpve1asDHA==
X-Google-Smtp-Source: AGHT+IFV9hCDPQx6NSx5ECD7DNlbhKuCcj5wIMJQj0wyuQZ2L9bgoGkjVG4izGN54TiKv8m27OKE3A==
X-Received: by 2002:a05:6512:3b26:b0:58b:a:d043 with SMTP id 2adb3069b0e04-5906d88b312mr813137e87.17.1759912120855;
        Wed, 08 Oct 2025 01:28:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124649sm6968733e87.15.2025.10.08.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:28:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/7] ARM: tn7: adjust panel node
Date: Wed,  8 Oct 2025 11:27:55 +0300
Message-ID: <20251008082800.67718-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008082800.67718-1-clamor95@gmail.com>
References: <20251008082800.67718-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust panel node in Tegra Note 7 according to the updated schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts b/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
index bfbdb345575a..75fbafb4a872 100644
--- a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
@@ -43,7 +43,9 @@ panel@0 {
 				compatible = "lg,ld070wx3-sl01";
 				reg = <0>;
 
-				power-supply = <&vdd_lcd>;
+				vdd-supply = <&avdd_lcd>;
+				vcc-supply = <&dvdd_lcd>;
+
 				backlight = <&backlight>;
 			};
 		};
@@ -101,11 +103,10 @@ smps45 {
 						regulator-boot-on;
 					};
 
-					smps6 {
+					avdd_lcd: smps6 {
 						regulator-name = "va-lcd-hv";
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-						regulator-always-on;
+						regulator-min-microvolt = <3160000>;
+						regulator-max-microvolt = <3160000>;
 						regulator-boot-on;
 					};
 
@@ -325,7 +326,7 @@ lcd_bl_en: regulator-lcden {
 		regulator-boot-on;
 	};
 
-	vdd_lcd: regulator-lcd {
+	dvdd_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "VD_LCD_1V8";
 		regulator-min-microvolt = <1800000>;
-- 
2.48.1


