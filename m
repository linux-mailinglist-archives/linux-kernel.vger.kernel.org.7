Return-Path: <linux-kernel+bounces-755484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D3B1A6D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0C182711
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF585275852;
	Mon,  4 Aug 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFgxI2PE"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0C2750E3;
	Mon,  4 Aug 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322931; cv=none; b=bzrXqc4AcNjPyGi+DYWyL1rQcIt8rWWkbTnfrix4RNN/UBLQSFPL5fxxRGUxVEjTEWoG9yFKb9ZoFoqE2vgjrE5XItGyb9QsIENdMC9l62qLmB9Iispl2vmKRy7aNXIBFZnpJSGQkUXpDLo8QzxEaQCFpqVemyxOPlFK33e5lqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322931; c=relaxed/simple;
	bh=G3AOG/bEGmhO/+ziIgJS1IJ9V+kVnQuf2DhW0m1MM1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSP+Ot/N/Dv5bfkj7Q4p7NAT1EMFjjPmRZT8zJtEtxBXKppF4Hsk6QIJaNu36Y0jeIlXb900cTksPmCj4TxIcBo5C8xsRUHwH7kHObAfNhd5/rIToB7aZZo4AvWTlITdaSp0LAQQDdeyDVj6uxbZd0z4DtW1lYcUwLoNnd1PEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFgxI2PE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615756b1e99so5177097a12.0;
        Mon, 04 Aug 2025 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322928; x=1754927728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLlT+oF+y8eGG+KGSJRAGU5NF1zSKfS78wOa934bYI4=;
        b=FFgxI2PE+QAgssf+gCxi5dBnBqCsAfZmwZlUN2vMPkV13XY8mkV7591VCEXQH6ZQvc
         fDAhwaGDCxkTbDrAmRJRIOZSxP0IDmWzatdbgojkb1vYW3yvaH11PmfzZ+QTnuBsClb3
         yxd2oVCdk53aaqslODQI/05XA6SeLpbL/HinQrbjFTKxzVcl2eGpVRHyWdo5BVLKd4uH
         FeR5MvW8mufaQQ4Yze3f8gibTpUOvjnf0oNwOC7rkmxFYR/IFHFHBuYPOqgosU8CYXD6
         GT7uxGfSKDQjn11nmIo5RHSbUIw0NqagJ8V+SkhZFy78hzX4TajJbtXJCC8yr1HMUlXR
         CT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322928; x=1754927728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLlT+oF+y8eGG+KGSJRAGU5NF1zSKfS78wOa934bYI4=;
        b=rSCw/44c6b7k1THkX4xMg5ctIyw5yu37A06HEbmZli38rssxtUe2k26ipJLypCMRgF
         kvZXkvE7GRDid1KCz90AFRkxDTA48l1ZHcr24vbcCL7hGqJjAVulCRzI7ZJ4HnnyHRjG
         bIxqfyPrdPPlXZct/dkcXPcXAmPM7t+YyCJRzvhIsgSyOAkrZ0kPKggyFkFJBBrggxe2
         a69HDj5ChDe7i4fcZyVDkgjXDjIPzpYRKyPd2OWQTfd31vkvvTid+u2RVPXaLs+FliH8
         yP+WZ/k2yiITG0JTWRWv59p1UVn1QTsFjxYK2XxdzGa1IlmH0/aosnKQrq5R6fw5N2RX
         kleg==
X-Forwarded-Encrypted: i=1; AJvYcCV2JL8Ox7NcnJc9f4+dqbhfXEqT4n+QgfMI1k+S8MGF+Yk1nn37UGpLfHaO35Uw01cy4L613uTeEqGW47LE@vger.kernel.org, AJvYcCWDwLj3Ez3Tyf18+LrvDvSHjSzm2LOVNKi44RbYOUfMezengvjK4LQC5kS+ySaEZtOk1QkMHk+L8tTp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjb88axVm9mEGGkSE4a3UBdFwmNM3Sidtk7apEaSyeZwAPZDaj
	njZh3I7BV/ejDfqkzgdxFOypWYvGO7m8OGjSfxCfhWUslLhkou2y+glS
X-Gm-Gg: ASbGnct37a7GLas2AXc/0/3DHjpGeTIrgR4R+UUZC3hJjCk8029bebHO8yf4ewVpmZ0
	oUvNn67JGLCOGNoNecFlkxqHvLKN+QZKnV/Fx096REsSQU4f0UwkM+rJJtvoT4P6uCLW+4NtqSw
	3tePUV5C3HzxtDBpLt2PnE83C0O5udsE6YGeFEs9g9W5xmXCPF/cfE4KGOAMoxDNk8b35bDyZcU
	gS6qie/jhUKKF0Zv4mrU5Au3l3likIhQBQoWhVzImBdLnjcgl/p2l30IQI6R3uzdCgRECi42H3b
	EcQwLX+/hYnejf34bNOOvKU0quepSKp4ZScIY40q95JToDZoBfDgSKAVHfbEofQT6GufAccHGhw
	r8V25mHdfeAipumgI2J02WjN9e6zcRE5PdvQ4Rk2S6uwuidinHVAOR3Emw4c=
X-Google-Smtp-Source: AGHT+IFkQCoHBvtFXtmc6tn7x2i+nDP+sB5y4q5vfMQOe0tSDU1cK5lDy/Byu6GA2X7xwsf3VhALxw==
X-Received: by 2002:a17:907:97c5:b0:af9:3773:8232 with SMTP id a640c23a62f3a-af94001e6eamr1176790666b.18.1754322927566;
        Mon, 04 Aug 2025 08:55:27 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:27 -0700 (PDT)
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
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 7/7] arm64: dts: imx8ulp: add sim lpav node
Date: Mon,  4 Aug 2025 11:54:07 -0400
Message-Id: <20250804155407.285353-8-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4..d84f50d8ecc0 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -776,6 +776,17 @@ edma2: dma-controller@2d800000 {
 						"ch28", "ch29", "ch30", "ch31";
 			};
 
+			sim_lpav: clock-controller@2da50000 {
+				compatible = "fsl,imx8ulp-sim-lpav", "syscon";
+				reg = <0x2da50000 0x10000>;
+				clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+				clock-names = "lpav_bus", "hifi_core", "hifi_plat";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.34.1


