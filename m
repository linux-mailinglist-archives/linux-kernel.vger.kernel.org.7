Return-Path: <linux-kernel+bounces-771933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A9B28D01
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3401CC7F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E529AAFE;
	Sat, 16 Aug 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfgstkYi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE629AAF6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341239; cv=none; b=RDkU34ihZzVf+iwTS836NtaOnVir9U97oR0Rf5qHFAoZArs0odQ24Kk4YZnP+P4zTlNhYluOMtfp4bSXcvc8a7tJiW+a+hp/ykPTkrbIOj92aQqZZDbNwbvsxy/aLdzYVrItXFdsXewZPgyKjWscQDaG0T+5hHeAGcZfJHDBTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341239; c=relaxed/simple;
	bh=fyrnp2G3Ydck/VjXXAZySzmhvFr0osu+dU28HaR/Aig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZBISoGDBh3KDxlr8WZH+hqhxo3PsupG9GbSD6ooR4WM+Stsq5rYZJiBkg+IIU1DnzHP8gBYZcjVrLMdNrx+BKVyqIpX64kGF06HBu02BFwEedSuAhY3IVz7SUvqfpOMvwcFHvLnSjVEKs9eAVWhUbYXiAJeL/NFkap7pokIf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfgstkYi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so12473365e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755341236; x=1755946036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KLQMXDCWuJhcgQgQnyLb1KMnCRmFUpDqVZgzOKpGBQ=;
        b=kfgstkYiv66DuC8qirldPIiycCgf68F9ctuG03i14CB/hOq606L4/GHzBwEfRFI1RI
         hLNfHBRbQz3y9AJVRuiOzTH1Yr0M1WXwXOmGl3iAvsNkTEiFdYq3C+YOHYR77HDyhJAJ
         1WabpTKDWf5IQcLC/earoH4K/NLqFHAqvpW9sH13LvhppsZ+C9TPTmqL/BLpmDMMfO60
         nak/uEPFv3s+Xb+9cXm8428AWjGBUGcxQIPuwq9dB++BFG0GlXwfilmHX6nwB4pmL9hl
         HSMMU2qii7PXtqstBQEe1T4CQMfTU/Fa5so2rBP6m+V1PC6duGaF1YGpmSENoeYLvigU
         Z0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341236; x=1755946036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KLQMXDCWuJhcgQgQnyLb1KMnCRmFUpDqVZgzOKpGBQ=;
        b=VB5Pf23S6K0krvg/319UcTTfeJIJUChfi9GyDvTkOvYAhHA9j/1pSLVK7NDJr13Wpd
         R2f3AZMaLT2xw5warsRhF0q5eAxbNHjr/Cwcnwbu+DrioF5GKD8f21RLuEItgTmQ65wC
         UgQQ39lDkK/WwmLTfeyRTEkaqb0tDnKyj8hfL3c577cmaeUx4jiNy4v+CxeddlBZRJxN
         609nP3T3Pfs+GAYsBX5g7G9gHQpEPfGpMh3ECqQY/SAfqvkMAxf+d22M3DT9wMLM8RxU
         +A8z3avYFENi9KrjwQTAaLoWzXSoC9UCWHhL7a8cscMdvT29M8iocjfN7XTuC8oBnEIv
         UhYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+mQ+vxjaptcueNJqN9fk6JiowOcPBf/QafoQWh6pbagcebWiEXUasvnoY++UcESTRrGBPimPLO+I3pwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczxBtCFAgJZaGWRU6iJXgjKfCZUwmqLZt0X6dzNhOLIIxtsRy
	OXUWETUAxMM1w0R795jYL7uEpczaYw9cT/qIyN5aAKdzXJ6p6emIfMdKXPblS3seEDg=
X-Gm-Gg: ASbGnctADGdZch7TMfA44/y+zcwAYdzOUFlW9eSXj2mn81McLV/UpobLIbClCqWWb9z
	8s0y4cR0/IbZuemOWFUUBQaxGADsKHtA15R7zXPh9oBawCkGMByPHlnIHOm2UwyXZ0fDeUp6/w/
	w6jq2H8A/8kcQAW31EJtUwEVKA16W7oeSOsJ1tVz/mHmLMM9ypAXHZvOhzDsfPf/HAPln3zqC09
	qmfQMh+Jj+8aXt/HM1uU7LIP4FZASeKBiOJ3Ex/CMKe2F9ogDAg2tMikmlFr0AhmWoMDwudRsCb
	oZB21gEgw80Pm/n7pyD3KqCbnjkeJW0JWGK88Ak2bEIqLrVNiRj9yv8/HLh9jnfRNPgV64OqDb9
	dcDyheb72znR6HrluRurs3Xt2F4SMzt5VPOpXlW/Ugyg=
X-Google-Smtp-Source: AGHT+IGkyNX6lrch8bdW1/jFFLJz/On6HV5NRlOeDX6BHkVK6NSeDO7JwUZmN0V0NpAm5N6hxBYQhg==
X-Received: by 2002:a05:600c:4451:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45a21867837mr39821515e9.32.1755341236605;
        Sat, 16 Aug 2025 03:47:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6be10esm96169425e9.3.2025.08.16.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:47:16 -0700 (PDT)
Date: Sat, 16 Aug 2025 13:47:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/3] arm64: dts: s32g: Add device tree information for the
 OCOTP driver
Message-ID: <9b3874c6aedf87f78cc6438fe840433162b06445.1755341000.git.dan.carpenter@linaro.org>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755341000.git.dan.carpenter@linaro.org>

Add the device tree information for the S32G On Chip One-Time
Programmable Controller (OCOTP) chip.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 09d2fbbe1d8c..e58ea0d3b083 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -612,5 +612,12 @@ gic: interrupt-controller@50800000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 		};
+
+		ocotp: ocotp@400a4000 {
+			compatible = "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 39effbe8217c..184a29dea184 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -681,6 +681,13 @@ gic: interrupt-controller@50800000 {
 			      <0x50420000 0x2000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocotp: ocotp@400a4000 {
+			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.47.2


