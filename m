Return-Path: <linux-kernel+bounces-851360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E31BD644B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE8A3E848B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0F2FE59F;
	Mon, 13 Oct 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpdoigWP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB432EE5FD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388714; cv=none; b=qVAr5MnVdua9a75Cj+GymhbXDHpkTuQETIodhnRk0wUqnqBnzsyHno/d+BRR41/2PKPkzDP2+DXdPd4tQ2/a9uZ/O/q7pO3VprsnzhxcfkVdRw7Rg/4vedMid3LPznpNYh3dJbLwwCUSzEmns4S82QhHUNZVd4J8A25dd8Sh4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388714; c=relaxed/simple;
	bh=HcBB/oM5Ltz/b5+IlSDZKmKzoXnPjplO+rzlk0nxCpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moomgAzKPTLK1A1PFSkBVw6MA/W/4SRV6tCzgPWwjP4JzVHUlUWeBt0YxeLqdsnKzHanmOO2N3lXe4JeI2OK3SgP5vgPHlJuxVO9xFAfPdq/usAIjMghKdZa+AgOWRv2AD2tsTeJiRL45LZUs8Ctm/kNN6ZAW9WYEzRwSHGhwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpdoigWP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2715492f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760388711; x=1760993511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcidvqHM0DTpowb0GHOMB/24jrUCyn/KdoJtskIHTFY=;
        b=fpdoigWPKSXX3iCTQeO6SotdgCqAR4V9OdJ2DQaI/y5sKQvwM5cnWSVWj6Mt6Mh3GK
         2UA1s7FoRfFsthfphrj1+TvQxfJt3+C4LCWltQBsm704FY0761qp28jW4rrDWqTPOiVE
         9ZxKhhCGqOSSOQNsuZ8hS94Z9gx5gURaFGf++Tcy3uR54uJaxJ2uPrU6dxooXGg6pGwB
         tG2jwOEtlHxWLcTbsiCPH6d9B2mW6JB0v+Q/JvySEFwGAqSrGtRbv4kuTw+aesrVciAl
         agc8gDKE/eo7a7g5dMo2XpDv6I0BPkvfLo1Qf/bannJukVqFSXCBzqYHE1ouNAlxqF1U
         4F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388711; x=1760993511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcidvqHM0DTpowb0GHOMB/24jrUCyn/KdoJtskIHTFY=;
        b=V2XKxtiXz6vs0KSNqCqZmqhVbC8BG1ZVRrpHsHfPVlMUdRMdw4shFQ0oRmFzymTofh
         jWIEfatsn/MBWb335uBeys/7nli3WTM5FN7LPsj+zwNi2eu//T4sOUjLISx+o0btRE/+
         4ucCHjo7wRP9SFDyw7xYD+biiBF3yhcB5OHVk53NMmPjOw3XtXoioGaAm33J8Vy1VkBa
         dVYj9kaH6x/NyO9ubLA2QOiuf7x8eIOBy1nCz8oYyQMQWzo+0yYPLlT3CckvbI/fEap2
         jWEpG61l0hURYRNztGeJysN4+xZAKOUTVY6yOWVCu0NjbqwO/rFMw8u3PoDUY1YPCrib
         +EDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfEv0XaEa5SncT3m6P1o28hVpiQ+zC1dTaPj1SmBy6OjXH3N0TmW8VSNcd9oXPx+9ioGJWBbKEk4If1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQTGt9oxKY3auWlwE2WIqAlU53GpZIefyVQ7igQ87MBv3NUpWJ
	X2HHvXaabdP8KVrXBrPyUVQiUUyHEjucI7u+R1omUYUc2iyEQq/ljPtTYHGfQO3RpxU=
X-Gm-Gg: ASbGncvdvT7LdH2gvqIglc4t1S7nb9faMbcYNXL9Ql8FwcvQ1cXLFw8MS9WsivtbU5r
	CQ0A6BYKRAPevXmX3RyYDnlyBhEHp/04aEiw7/drJNfQK++ijM5eBa4BM6nsJbH4nsdBea0c4s6
	x/562giN2ift0r5Ba8iYI9IY6VyPxBQPLh7P+uj/0v9QoefrzuExR6Pl2pqPvWFZFKRMupQRiPM
	af8RCBDEzkleqDadXaVrDZNUv479qO0/fzSRzflie9r4CJoOaMswmlGbVmIL/7iMHJHegzm2S3o
	SsQckKkE1IcOHOUB5RCwPx2pfM5en2/PIjF/upW5tDPiEHlbPjnrYsdbh6Zr9BFYi8RdaB1yFyL
	aoS4cMPTVbVYoFTk4i+S0iH46apqeGivbiq6NXyIZJ2KeFeVr2cJYZigNc7YlEdV2o9e7xOtC4f
	YD0KcYzN7K7g==
X-Google-Smtp-Source: AGHT+IGR7na4kqfqbnnRja9gaL+GPCruM+aq2vYMgg3ZztoY/GsoH+Vl1WubHAu4JJbPtq9P4Dwh1g==
X-Received: by 2002:a05:6000:2010:b0:3e8:ee5d:f31e with SMTP id ffacd0b85a97d-42667177f63mr13981151f8f.25.1760388711219;
        Mon, 13 Oct 2025 13:51:51 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.67.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm133512615e9.4.2025.10.13.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:51:49 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 13 Oct 2025 21:51:33 +0100
Subject: [PATCH 4/9] arm64: dts: exynos: gs101: fix clock module unit reg
 sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-automatic-clocks-v1-4-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
In-Reply-To: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=HcBB/oM5Ltz/b5+IlSDZKmKzoXnPjplO+rzlk0nxCpU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBo7WZYfzLRdL8VJOj7ItKK0VzjwnPjmQkF16AAH
 EN/3nR0woKJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaO1mWAAKCRDO6LjWAjRy
 uoxdD/44noFGVAg6H/7t8IFFPSjfN+O063aUxB39GsQU6dPSmhatkdJzGV8lDDFiiYjGFaqPh0I
 IuZJX11glmxeVQx9aDqlgiBbHSsm+Xy91xkNhkB/KiTxCywWz4m+NBcY/x3/2bF4UkKSC/1Xwgm
 XPLBWejL5wGuXpcWfTIcouVM/rn6wV1alCTTovdVfDaNNv8p+FL0lNAp++yZ0ds1cZsy5pM+yTi
 yMDQvEaI2SxuM7+zrrg1424YtvrWlGQQDUpRV1YoR+Z+v6mVvZ9/WLUJDasiTD23mKjXAyRyHgE
 AngzcWNnqWf0/Rdn95v4cnEfG62y5MHNIJSyNSGAURkAWT1PAg1/KbaoGBYcxTVG7cy3vY65cBN
 5azh4Egd/9JJBmiz3Uu9zu1TQ7El2hXtUEDYS1/l8cO+uh4PbZ3M1nuJRnjEtISs7RVA2d4a770
 gVeeMgK03WU2FjN1oxD3D5V0ImspjGS5GbqMnc5qsGJ2ke4oqyq0E70BjhTCuT/lWjq1YIKF5fc
 xHH4r2EGa1yJBXGwFqu4Exsahn+QcKRg6qsAcOVsRm5XWqK0ChbTG2FRiPAhDHkhIvQq7RsdDxj
 Vt4MF09WvjQje8CY/aUrzvj4EdLctignBH+l9lz8ZZhJJ+Ftv91R9PTobZp5MRV4ehYmvC0Q/Li
 ViqnyfmXgo8kBQw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

The memory map lists each clock module unit as having a size of
0x10000. Additionally there are some undocumented registers in this region
that need to be used for automatic clock gating mode. Some of those
registers also need to be saved/restored on suspend & resume.

Fixes: 86124c76683e ("arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller")
Fixes: 4982a4a2092e ("arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller")
Fixes: 7d66d98b5bf3 ("arm64: dts: exynos: gs101: enable cmu-peric1 clock controller")
Fixes: e62c706f3aa0 ("arm64: dts: exynos: gs101: enable cmu-peric0 clock controller")
Fixes: ea89fdf24fd9 ("arm64: dts: exynos: google: Add initial Google gs101 SoC support")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d1e3226da6472bb9db766926100a6b9855d7a30c..1ae965e456665bf05aa1b08269b5dd66b46d200b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -288,7 +288,7 @@ soc: soc@0 {
 
 		cmu_misc: clock-controller@10010000 {
 			compatible = "google,gs101-cmu-misc";
-			reg = <0x10010000 0x8000>;
+			reg = <0x10010000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
@@ -371,7 +371,7 @@ ppi_cluster2: interrupt-partition-2 {
 
 		cmu_peric0: clock-controller@10800000 {
 			compatible = "google,gs101-cmu-peric0";
-			reg = <0x10800000 0x4000>;
+			reg = <0x10800000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&ext_24_5m>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
@@ -917,7 +917,7 @@ spi_14: spi@10a20000 {
 
 		cmu_peric1: clock-controller@10c00000 {
 			compatible = "google,gs101-cmu-peric1";
-			reg = <0x10c00000 0x4000>;
+			reg = <0x10c00000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&ext_24_5m>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
@@ -1271,7 +1271,7 @@ spi_13: spi@10d60000 {
 
 		cmu_hsi0: clock-controller@11000000 {
 			compatible = "google,gs101-cmu-hsi0";
-			reg = <0x11000000 0x4000>;
+			reg = <0x11000000 0x10000>;
 			#clock-cells = <1>;
 
 			clocks = <&ext_24_5m>,
@@ -1344,7 +1344,7 @@ pinctrl_hsi1: pinctrl@11840000 {
 
 		cmu_hsi2: clock-controller@14400000 {
 			compatible = "google,gs101-cmu-hsi2";
-			reg = <0x14400000 0x4000>;
+			reg = <0x14400000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&ext_24_5m>,
 				 <&cmu_top CLK_DOUT_CMU_HSI2_BUS>,
@@ -1407,7 +1407,7 @@ ufs_0_phy: phy@14704000 {
 
 		cmu_apm: clock-controller@17400000 {
 			compatible = "google,gs101-cmu-apm";
-			reg = <0x17400000 0x8000>;
+			reg = <0x17400000 0x10000>;
 			#clock-cells = <1>;
 
 			clocks = <&ext_24_5m>;
@@ -1509,7 +1509,7 @@ pinctrl_gsacore: pinctrl@17a80000 {
 
 		cmu_top: clock-controller@1e080000 {
 			compatible = "google,gs101-cmu-top";
-			reg = <0x1e080000 0x8000>;
+			reg = <0x1e080000 0x10000>;
 			#clock-cells = <1>;
 
 			clocks = <&ext_24_5m>;

-- 
2.51.0.760.g7b8bcc2412-goog


