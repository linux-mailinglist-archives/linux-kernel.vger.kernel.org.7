Return-Path: <linux-kernel+bounces-857943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE3BE84D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D95C35C906
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ADC3570B9;
	Fri, 17 Oct 2025 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niyy5DtK"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DE34F48E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700124; cv=none; b=Inc7PBQV/N6OMkztGi71oKjU+k2nQpyDrCbZaVAMSYnClBcm04OyNKvksB+mzQxmWn4bfoiamHaVJRqdqUw1duHxbpiqIs2tKyojSbWaJKBwHPwDyOsb3YDdj79lSLRDETdfApue8bCyrBQoEDc1DgDt/q9oaECvmnYiilNLq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700124; c=relaxed/simple;
	bh=y613Fibuye7rvTibD+68qb4oNwl+ydXU9k6h+6Dna6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz3DAS+fd3ER5yOohTE8wRb9u2YM906iXh0CPjsY5ziWAOePTUkxusP4xVGpJusZz4KP+3OJ4EYgs7QmlxTEzBMKjyMMqJF84qW8L4MaWQ3FHDT5IExqvKaXnu8PICPRmS3ZXckqTPZAzaZ+MMs4enjQPFlXTbC/5j2e50Z4wyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niyy5DtK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b463f986f80so371573766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700121; x=1761304921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07Toi2vUIU+MWGlot8kMIQ1ee07JBmL9YfZNkL4sfI0=;
        b=niyy5DtK/jIqiA/dpFcGD8XGY2TG1/EBgwRWvMgT44+eZ5c40GsYOxjZWgK9xMx3oJ
         Ub8ppWIKnhpL6mFxaHI7eVX8M+d7R9ThA3MaeUDMqPecxRXxCYqLewPINElPIZgufd4J
         CxgiDjEBtHdlyczcz2/x+y10CmJmL+jiQFjudfTN64G1bJvHofnY5h4eZEPzRJhHQEPs
         qwy4GzPp+9srKAdaOVD9o9ZAREt/yd7xn7kkDN5vjWKYb+yl8olWCqsDQRShre42SEEo
         T+Pr/HabeP5C3YDNcyXxK8O8zBm8NGZNRB6EIJpdgDmERmtVOJ36eQCIFUSB1cBdtTOM
         1umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700121; x=1761304921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07Toi2vUIU+MWGlot8kMIQ1ee07JBmL9YfZNkL4sfI0=;
        b=DxAt1NhyvPyJWDLQhbBV0rYVK+4OgH8S3ku8ze95ETZWvbEHjVFN4rE92ZKNZjY2X+
         C0QCPYy6D3UMT9u8mVY85Y5J/PgMjGYbEqWOk0wlFuhD3y93Ul9roIvSC34rqz4tuXL8
         LEbcu0JGqPZJRzdTQF+1XJoIGl9cJW8q+EMZa6FLu8xy5QDV4qBkbQhvluSWLXcEPYLG
         AHknZrki2ctkeKZRmFuTAGq4GI+XOaSOeTLi6QjweCyLvScv5BmdUYj5LOiIDHhGNdOG
         Q3TeXMHWyRqDeKppCbYa9/Sp1NF983WeJlPP+dFFJT5PqAoLOcXi0Mg9V9H3nTkO72NP
         BkzA==
X-Forwarded-Encrypted: i=1; AJvYcCW1DOahp7PwXkQKVvkvIdVDaN+1RrBu/Puk0R3HV7YOLMy7RI2cuiMI+I1dwGgIDQuq5kiOlrSZIYZ4Y1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoDY+gJ+rJeyRX/Jy2nnYh3ifn0+Z4wLmnk1Xh8c4z3pXGQUw
	6/JhPBdPBGkaiGMhCHoV/C9dRFTnU1tGeJe8UtKgtq45ExD5/5tWcStO
X-Gm-Gg: ASbGnculWNiXAjoO2WfPFDFwSic7sr9phNrUw3fkAf+yquNUHCnFaMLGScmWxIRQBhZ
	lzu342fAnIBzty6IK95a2HWS8+wb8D324SfPToOQ0R1sHx6g1+6V17HTasGkJGYVLw/D4j9nCl/
	Al+uNtvLCOv/S1Dn+PmxSapPHjQIgmfYu8CBIzAvY6vLEUIgzbW+8Q/fueuqQUnpua2/TqUAZOz
	mXid0rbbnqQQiqDJf2q360k+03/oet70kouFZE73h43mxFiLuye+J/KzKny4JzbVuLg5qgxVVco
	YbEjEXmwDsKHScmIC5oM0TTFD1IWi66/g6dOcn141QTYU36x9ZDy/fkJzgPZRfZ5ZGHhVMIDJdO
	Ce+JxOkxW3I86KiQj6vIbHkKOIk9XPSj8bS8RmGY0/o0tCswhuUsIVsEQvY9Ahygmw8c32lSl/D
	6C4GwdYuaD8Ufw3u91jpHNGHjDFQkcvBXNnIAd5g==
X-Google-Smtp-Source: AGHT+IFm4WIQFISVomrAFV51FZBLIpyrii3K7EFFJhRI3QtwYUrQCPmRYno3c3emRFDyrsQdPdKFXw==
X-Received: by 2002:a17:907:7ea3:b0:b41:873d:e220 with SMTP id a640c23a62f3a-b6474f18597mr313933066b.50.1760700121004;
        Fri, 17 Oct 2025 04:22:01 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm788256166b.60.2025.10.17.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:22:00 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 8/8] arm64: dts: imx8ulp: add sim lpav node
Date: Fri, 17 Oct 2025 04:20:25 -0700
Message-ID: <20251017112025.11997-9-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DT node for the SIM LPAV module.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4..676535c3fc84 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -776,6 +776,23 @@ edma2: dma-controller@2d800000 {
 						"ch28", "ch29", "ch30", "ch31";
 			};
 
+			sim_lpav: clock-controller@2da50000 {
+				compatible = "fsl,imx8ulp-sim-lpav";
+				reg = <0x2da50000 0x10000>;
+				clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+				clock-names = "lpav_bus", "hifi_core", "hifi_plat";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+
+				sim_lpav_mux: mux-controller {
+					compatible = "reg-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.43.0


