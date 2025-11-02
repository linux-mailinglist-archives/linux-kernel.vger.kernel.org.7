Return-Path: <linux-kernel+bounces-881994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C7C29659
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18032346CA3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE8241664;
	Sun,  2 Nov 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlEo1vyG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86186348
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115254; cv=none; b=Xcmla4UtCCktOYlA+NXhO+2yIfkmmwMB/0fUHkixqS/okDHawKt+AiL75h0V12QH1O4HVGrOzf05VZx9tUzlTO4Z0ehyyTqO4FzI8MmUSKyTfrXxdNdE8tSeIn2dlP96LZjjpPz3lmnResS8QUnKiMedPY/gwLRFtt6qv1LAWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115254; c=relaxed/simple;
	bh=nN8tTkTawLljwHrR/jD0xbk9vXmrtVCl9Rq1rJpMFpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQU9pi+8udtDuiyrNoiBooiaXqr1f7OrxUYOn0uYnwgt85vnALs1Bg4sZV8V+s0PuMOL52ucL3MSZRrK/rKUEZT75Fgr8Q7Qb5mW5kYlxcRNeKkJqEDLa0H7mrXweq9jkxMFGdkYcLnpmmtpLZpA9Epj6g4+yOk56MgBOd9xhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nlEo1vyG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso22054755e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762115251; x=1762720051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTngrYfAUFTcMg616558EOBLpim7WtyStRU50Tfvew8=;
        b=nlEo1vyG+hXK5BUqeN8CPsDAW3Hsl8GOMs403oONgLuiCY55xPx9JsAl5OOtEa0wob
         +1RUAp9qQ85jEbGFaAFzBzayhAXFg+RJdGiIfHyYJeQYRi02/d64MJgtOvGqdPH7dE6u
         RCK3x4flZnTCRM3sbehQpYSqaIu7shhmktrAz6XuVxlr4K4WR/ioqC69jJ3PGear4CpF
         iPxANshGKVOBprTEWTVdnj6vr2Lmm4Dr7L5YRM2BBzBNWRoRsT75GqTB+zrvjCSiegdi
         mALcAP4oEOwKDW6+VFMHOtVyJAmFcCSk7+82zW23KQroDQu8R2FsTXlaa6t/WiSFQINO
         X/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762115251; x=1762720051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTngrYfAUFTcMg616558EOBLpim7WtyStRU50Tfvew8=;
        b=RbWMDXAW5gWfZ1U66MB9V1OIY+0iyl9DP70ksQYxE1X23qM9HnpWYWKjTErQlN2ufG
         CTjgQqHBBSSgAp14XsF9lO0VPmbgUQKV24UFAOexO++M2tLQ4VqWyU/GvSkktDUnlT5d
         hzxGiKWO0Fn4y+Ax2f2p2ZY1H8GLfaVXvBgCq8B8DOE1pfLAXSC/EeTitvlQoIN1HziE
         EYTiAKcxYleu39VsdtLYOSV10CrzjtniKBp9zZEgtWGowKod/em9653pMjv1cUK0p3MY
         rP6AL29m0AIj4BPGDfE/uCVuWwKMbI6U5CHk4OcKR4jSNFs+aWo3h5rsD7HbMdl1YEUx
         Th/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7Z33WAWaLOJksGJ8Gd1TlZhDn3fmZ9+eq6d0V1qjQV/pNFSm7ZpfZ/rl3RtuQtkhlYdypAlIsjl6QRSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmaoCnu4SfWdA/6+q+Euv6LDa+0gRnm1EdA88H7zfouotD9z5
	+W7hsDD+ZfsaKJx5CAXzpqk1efFopv47LuBqyNgPMnQ1F0/DXeB5gvGLfG0qKjCZKRI=
X-Gm-Gg: ASbGnctzEK993sdnZHBSyIYnGofAL5bT2jscCz7O4t6tyu7SgGhQbjO+70qEN/JEBgH
	LlUjAe2GRRbOI+DVRKqiluEGU/7uAcJsJcyjOeIvYetiddQPXge83HkOzJgKkOrm5NpDZrNjhvm
	PT7sbhw8fupC4WFyewDl4TOLRvZHEzZzhA2Kbbj68tG1oyC9CqCMneHO9sh5qcPNUrRP8A+++bG
	qqcb8psY2TXBP00G1XoVVMDnCxPoCTH94+HEX2igvRJ5lLe+1zjek8uaOw1/ms4B4sVjXQR8nhn
	uHIg8FT2Jri0G3/AZKXWMr/nAspG1dqqbrgsLgmhZyR5f1hdw3Nsb8D/cOlv+6n7F68MdsBbXll
	IOYq9hUxtJ8xeVLK9gPNL4eGDfnEjYuUlcijsek0+buUHD6woFukaRgCqKA42BYYDeXgaiWiisg
	/RceROkIEpJATtkzXUAFhSSGQ6Daasmzg=
X-Google-Smtp-Source: AGHT+IF7iJ+IgLBUP9LE7khd4BTeU79k3SW+Aq/qgYQ2ReUgs8miL0YqahEetcsdRE6/eSU7CMke4A==
X-Received: by 2002:a05:600c:3489:b0:477:58:7d04 with SMTP id 5b1f17b1804b1-477307e214dmr92032845e9.9.1762115250618;
        Sun, 02 Nov 2025 12:27:30 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.65.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c374f84sm114664165e9.0.2025.11.02.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:27:30 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 02 Nov 2025 20:27:15 +0000
Subject: [PATCH v3 2/4] arm64: dts: exynos: gs101: add samsung,sysreg
 property to CMU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-automatic-clocks-v3-2-ff10eafe61c8@linaro.org>
References: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
In-Reply-To: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=nN8tTkTawLljwHrR/jD0xbk9vXmrtVCl9Rq1rJpMFpY=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpB76tYpUV3fOT+rf32etuSr6akf6snwSSeY/JQ
 uXlfMOQIJGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaQe+rQAKCRDO6LjWAjRy
 usr2D/wID/WRNDiqnQlsa8OyzPlkf0/VUyOybWhKF0Kj5odKclbYF2mxiScH+cIq9O0KL65XXN9
 BeN/ur987Dump6bm/2RiO7OKViS6igi7fbZrb6xfY8yHXM97A3x8QM+s9y/K6HNTnW3ZfCbceeE
 qCWA7BQgey9BsTzvr9WBYq06XAVsqujR/vhd7U8xrO1ZWwYSR6os0mKeZ8iJIRmQv28Bbvk74I4
 RWP36iDmy46mIZCjcWQenVKLLB8wd//NzgF4+twS71jMrGyTCAyFtAkLYvjy4Hm/3QF3JD6IuDw
 SPM2IaGq2C2NRTE0P5HK97fsPI/2b6A/dYQpUcu8rjQdpBUr49RP89Azhn601bhgIKqydE0GZjI
 vQuban4CFg+pes9d3APbuvKQFVDDUpQWjTPLEpK70zw5sogUgzXlfXUA+zcpmzDeA2GpPo3YIPH
 p7z54RnNqv9HTnSCERNP5CqVdUIlYCVsVwk1E/v8ZLVy2T2yIiQXh/92tpgq+lKeZ7SIjBzHMBf
 78PLsvVuoaL4lDZQghUB8GBNXh6MAtg/eKTIpkgcTD53qPK3x68rMD0uImtxtqGynMEutGneU6k
 CrysUXcf6J4nvDbrssGgpWitEon14PdRMFpj1YwtRedtRksDMmmZZsJ54fgoYUb8MGwcQv8Jabl
 +Hfbv24jEDwvZGw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

sysreg bank contains BUSCOMPONENT_DRCG_EN and MEMCLK clock registers that
need to be initialized in the CMU clock driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..c39ca4c4508f046ca16ae86be42468c7245561b8 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -578,6 +578,7 @@ cmu_misc: clock-controller@10010000 {
 			clocks = <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
 			clock-names = "bus", "sss";
+			samsung,sysreg = <&sysreg_misc>;
 		};
 
 		sysreg_misc: syscon@10030000 {
@@ -662,6 +663,7 @@ cmu_peric0: clock-controller@10800000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric0>;
 		};
 
 		sysreg_peric0: syscon@10820000 {
@@ -1208,6 +1210,7 @@ cmu_peric1: clock-controller@10c00000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric1>;
 		};
 
 		sysreg_peric1: syscon@10c20000 {
@@ -1566,6 +1569,7 @@ cmu_hsi0: clock-controller@11000000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI0_USBDPDBG>;
 			clock-names = "oscclk", "bus", "dpgtc", "usb31drd",
 				      "usbdpdbg";
+			samsung,sysreg = <&sysreg_hsi0>;
 		};
 
 		sysreg_hsi0: syscon@11020000 {
@@ -1637,6 +1641,7 @@ cmu_hsi2: clock-controller@14400000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
 				 <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
+			samsung,sysreg = <&sysreg_hsi2>;
 		};
 
 		sysreg_hsi2: syscon@14420000 {
@@ -1697,6 +1702,7 @@ cmu_apm: clock-controller@17400000 {
 
 			clocks = <&ext_24_5m>;
 			clock-names = "oscclk";
+			samsung,sysreg = <&sysreg_apm>;
 		};
 
 		sysreg_apm: syscon@17420000 {

-- 
2.51.1.930.gacf6e81ea2-goog


