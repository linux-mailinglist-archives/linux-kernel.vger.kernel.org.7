Return-Path: <linux-kernel+bounces-851362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AEBD6466
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D33C18A2252
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99F2F0C49;
	Mon, 13 Oct 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpMsvLPc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682C309F08
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388719; cv=none; b=Bem4cdPfKk2JeeF9kcgFGXG+EE/9/pR1KF3ZR1Hn59l8E5ovEzTF2HrpCIGjiH3yYeKyWpUuWOCc2/HH/UH9SSaLUKLMBaH0qs0oDtspKEiPfNRKRMlaZfy3qMfbMuFV3D5hFgz+2yXN1Rleh9vKI7Atm+aGcx+Qi/j41NYprIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388719; c=relaxed/simple;
	bh=O+8J39i2fHZkYMM2LMOQ9vzlXl+k0rDoBKMRFPbNLG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rf0EFzyGDGRVXnNdjvTWUT8nMmlKtj+U13UhviEvFrS/Q0X5mT7nHSsGDtt7SPRB1GibRGkdzDHM60WgGKER6nOqFpa3ng0ZpTeFFu3THqg28Ox/NhlH8U0qp25sSWZPu5RjLM8DLjgVTTpjiL0Bs99/AkO5bBm71BSNZ5chyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpMsvLPc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso34346055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760388716; x=1760993516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7w5z8KxrRxyU7p3Mrl1kYbxlm0NVCr4pzkwG2LaXuU=;
        b=tpMsvLPcy98zBoXx9uabxst7dYJeC3n4nsRtOzb+yXCkiCEzp/89qKA6aHXEXzrYdt
         yFswWS6H0G/EoDCsBv5p6iNg/QV3by9bAn+dz265T+rf2CN6F44AWaig2MhpHfkeUhMi
         7dP+qHv26tzRIziYEXziF9U+QroRPB4Ih079KRnkgKP21/w9Dy/mJjF9PhrbSXHjXeU5
         Gb5GdeWYjYIaO2qCuWezkkeFiBlYsimgFLqyXupc7tIHUurAN7qjlIe3oa0Q9qG5+w8q
         soY+6FzDrtW/rgukUrQqQku04kvPg4m+WmDazMzWzrZxnHS1l2uYNsOBEkxtrQPU1J+g
         rAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388716; x=1760993516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7w5z8KxrRxyU7p3Mrl1kYbxlm0NVCr4pzkwG2LaXuU=;
        b=dCbHjp1VTPR+8tNOPO8v885S51ebC78fGmqR+h20DqCU9UA3+H/65tRuCWsIZtjj5B
         EWn05CU2Mckq7jNe6gRaHEMu3oB6sInAJHpkUZtxH4TCi/1VSR4uCSa6isIw8QE/mC6k
         Emb1cEHYBGPoygLwLbjtmlsH9xMlSkwtn8CekMvs0WNqupPA2lgHDEuO5RpnpI9+cMMh
         EiuoGR2wX8DmElyXkRFMZ7/HkHfQ1jVLnxAgvwTX86hsQPemV9jkR+ADQqjJqBKVidOC
         y28MQM00K08BN+b9LfPeMGSpbgWBi9nR7USwgV+f8d525y2ye0/uvMGkszwI8qTc3IIH
         OO4g==
X-Forwarded-Encrypted: i=1; AJvYcCX/oTJaEFvL0sjWqbbspvVAIxU5+YlggBj8dd2GUOawQGMUdOeYm30bD4g3uj411PcdwNQoxmJIpzyCHXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCA5RAIpN4DZfzGy3bw0t062VGH8qiJHwrnwA/1bv3Gp5VaPr
	CiD7ja2HlhoTL7RC5ST6jlqMf1Q6Zwqtnsz0dPpGqM2CA7OGaoG4SSYMlawtMVcfjyI=
X-Gm-Gg: ASbGnctIuas8/d3mYJUANohvf+vI30Sxerz8wXIapF2rK0oZIo82Y33NkFGNguFakcc
	QQsRRX3S4UrWdzuIOgUtOHrDVDGgUMZj2/gqL3GPty5RklwUHaz5ouby1Hd3fkfAYY+cCLNkt8l
	WmnH4nlD/PvboRryz5el0CyScRFX6fjAaT2euP8L53MTC8dS0vpk/F9Tj3NvDNYUbVAfwfq8sqr
	7WjSnE1aHFHD2NViqjdwOeWXWFbcExdudwEsQhOeZzK2o0YXQ3RhGGICU0Zl6pTFZoEYTFSlslL
	ul+pbp7XJtOxrO/cxS4grsDpCOhDJRL2+8hEzEI4t0gEjv+q0N8ruRg93G2t5nN4TmsZEL0hdTF
	p4M4iyeTJBHnBtaoOl1WtvkEpNU0GlTDAxqA43PMVr+86ORrW1WtSgYS6ccYhurk1ZtvqcqI1xP
	blrTLa8JurdkQQhcqXqIlo
X-Google-Smtp-Source: AGHT+IHcHlsKIP0Mk9NE5Y6ACBtaLFx5panG+gS1uzovpItpvweBLReojSWXTXiwTmSFJ7De3j4OaQ==
X-Received: by 2002:a05:600c:6818:b0:46e:477a:f3e3 with SMTP id 5b1f17b1804b1-46fa9ed23d5mr150899755e9.18.1760388715740;
        Mon, 13 Oct 2025 13:51:55 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.67.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm133512615e9.4.2025.10.13.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:51:54 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 13 Oct 2025 21:51:35 +0100
Subject: [PATCH 6/9] arm64: dts: exynos: gs101: add samsung,sysreg property
 to CMU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-automatic-clocks-v1-6-72851ee00300@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=O+8J39i2fHZkYMM2LMOQ9vzlXl+k0rDoBKMRFPbNLG8=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBo7WZZW/9QdYl4D6XrvzwE3Pa4aJol6NrersUlA
 HXzgH4jpB2JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaO1mWQAKCRDO6LjWAjRy
 ukgZD/9kwT19MKy+p7eaGNRAwMNSOiSh+XuiA8fQBjI0j0ckmMuJuBB3tL/5JpMUlKDR4dd2vNg
 SUYYa/N5NN7pWeV5koBdKdAjmIjfNytW6SSALKtKjeDuLxKjcr5NJN6XioAQ3pqcoRbRWTW++bF
 HSxN7TJWnCha6Njg/rvVBkfTFXPvL0dF3uWea2qi3A71tFm65b92N8BF1VvnRmq2stngDCd/hXw
 bdThIvIaaqRpNKCq9aeuo3+/cn1sRRPjeMEKPaWPbAkG1fMCIwGR6+1VTPTqYyD55iMZ+7ES8Vc
 mvXta9JBOMWZC3ydgN4sted76rj+AiL/3Kozxg+EdlpYjYkd4OQvwkvaobUJGJTvo8O9eRQnaOo
 iea/ItZBMzymDxnOPN+JcjdWLA3rpB3IvXThEusH7wAiBNxRO6OeRw2xQlnCSDBTF4lofT0BiE8
 Px5dl322X6DxFnwfTbueBc4LNmtS4bXFN3qhwGqvTfWqbpjxeja24RwVZPqhtRQpp4yi76/mTjz
 uKbc4XUOu+3FKxYs1hiTBrBx6fC74htKy/dKicPtZ0KMQNuygVOLDf5WnSMXGyfrQlCu9EOVDzf
 OBiu3vTIX/gBJyzBWYk1ChyGv6VRuMM6Pj35wR1mwNeE7AbB+aXbkjaQKnk3Wlw8oSGqwtBsVtu
 Mchat1WP8FScMxA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Each CMU (with the exception of cmu_top) should have a phandle to its
simarlarly named sysreg controller.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index ab66c055e0ac157f89a0e034f15bbe84e20a7e82..c54468ddbb02b170ec79d56ba2460f2ffb0dc40d 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -293,6 +293,7 @@ cmu_misc: clock-controller@10010000 {
 			clocks = <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
 			clock-names = "bus", "sss";
+			samsung,sysreg = <&sysreg_misc>;
 		};
 
 		sysreg_misc: syscon@10030000 {
@@ -377,6 +378,7 @@ cmu_peric0: clock-controller@10800000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric0>;
 		};
 
 		sysreg_peric0: syscon@10820000 {
@@ -923,6 +925,7 @@ cmu_peric1: clock-controller@10c00000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric1>;
 		};
 
 		sysreg_peric1: syscon@10c20000 {
@@ -1281,6 +1284,7 @@ cmu_hsi0: clock-controller@11000000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI0_USBDPDBG>;
 			clock-names = "oscclk", "bus", "dpgtc", "usb31drd",
 				      "usbdpdbg";
+			samsung,sysreg = <&sysreg_hsi0>;
 		};
 
 		sysreg_hsi0: syscon@11020000 {
@@ -1352,6 +1356,7 @@ cmu_hsi2: clock-controller@14400000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
 				 <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
+			samsung,sysreg = <&sysreg_hsi2>;
 		};
 
 		sysreg_hsi2: syscon@14420000 {
@@ -1412,6 +1417,7 @@ cmu_apm: clock-controller@17400000 {
 
 			clocks = <&ext_24_5m>;
 			clock-names = "oscclk";
+			samsung,sysreg = <&sysreg_apm>;
 		};
 
 		sysreg_apm: syscon@17420000 {

-- 
2.51.0.760.g7b8bcc2412-goog


