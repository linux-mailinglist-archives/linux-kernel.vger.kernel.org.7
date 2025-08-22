Return-Path: <linux-kernel+bounces-781992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3EB319CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58C3B00410
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB063043D3;
	Fri, 22 Aug 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax6ZTcCH"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB03009C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869490; cv=none; b=ntB8L8uJIKM0LZXp6diiiNNz4+Mt6YM50VcSxvEa2LAszCt8UConOdcpNzohh2uB8m/14qbrD595uVJexzn5vRsez9Q1+eVS9HUvlER6hVfx26XEWF5zOlruZf+bL3S/z0XEr5cXSgltSuere9db8BCJAikIdjKh+vM4dAIdYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869490; c=relaxed/simple;
	bh=qJdqhbannqpcNe/ZF5YUjLIXi50NcD/YKBgc5cMgrCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZD8RWgNPmDSuTOYT4l6c2Dcw4QCaDJzYL55wKnE49/wFaVxGh2tBQcFjt+kgY/Ct3k3QDEQ0XXLVdTB4YAxHwQlHlokdSz6nZq5CehwzC4t0eEUMYBUaMMA7MHR9vsNZpEcLwxC1hlU4U2IInEHf5pgQM0whibzAJVrKvvOuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ax6ZTcCH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afdefc9b005so33613666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869485; x=1756474285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPjWI7EHXybjCjXrMdkmBIb5D7sVI/NhlSvf78izrHE=;
        b=Ax6ZTcCHd/qfaxu2shmb2cTCT2mTLGeDAhle3chklKFHi2LbVRGRSruKswI7tNoYQD
         zugLtyDW5x+IUuI7eRZ7Y8HYbK6invisV07wYeNZ1I4Q1gbFjhNrNthJlnLfJEDhGBSO
         +ntad3KMOVvYu7pmfy/ko62jMFuQdybI4w/PIGMCGNd7IE0UOXioarHkmaDqY2kWYMyu
         2C3ZdX6MuHteQiVb80S4ZVwUgEYMLTR9Km/HERobPz0iqnu4+En8yUv0VctNqIqbugSb
         oh6v3J9hRVPmyVyH5Q3c3mLxfkZjtez5lg6P1tNgVYTB+UMl50WoNgHiBnG2zfBRYpYe
         JZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869485; x=1756474285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPjWI7EHXybjCjXrMdkmBIb5D7sVI/NhlSvf78izrHE=;
        b=GaLW6jZXGHgjqnhcTq63g1/fCjxPKcYHuQhncimRzx5CduspreiIQ1V0bPCAMlCSAL
         i3yN4bxtnHSjAkj56X70jiL8m1cPChurwUDxwK0yqDerluRlb93Zx4kMi9zVco3RZuwp
         +w0C2BJ+j9ouxHj2SuyDL+YrAb2yDrFCq9K1luGoZu9PXB/8Ia1/saLzmLyNU+DxQMem
         +lEnvsBtKfYgyHbnivzT2OrvhGH4CPKlTbV7N0kpxF9AKM4BvMJ7YE59g4rWPeIAwtxp
         JU5UibId00DEA6+qOAhTmaSQ8nrS9cuBIjClcn0q0RKW+Tq8IQWjL/MJqmr7gwcDD4O3
         l8gA==
X-Forwarded-Encrypted: i=1; AJvYcCUHovLGWSlpzKi7xp7TIbw5Q9jNX4BDoy4vZ+0MUEtk7dbcu+jjckDBK8IrwjyWLGNVnx32tQduu3XEEY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Zvy7HDfY2u480v0XqKoSbWU3fSV9gRo6xcVSSVSL0DA8D7rM
	Yaig5XtzNpX6SCYSd3W0wDFiuzVp9WiVWI+Sspg2p48vxkkv3Mgw1lxsW2FvzWO5bBgz2+mcyr2
	JoBR3
X-Gm-Gg: ASbGncs9YTjLpo469LhIUyLZOY/IZPppfr1zGn6BlrYLT5GYY5PyaX3Ru0l3v+DPowL
	wAD1STWf464EyV/0S/fauPwWOx9Cl53vYIL5rH0QHtp+dZM1GsW91y4hg9NKQZh2Pgvv9xOg4JI
	uS5nYWM13AjboyPJgByX9mbvSS9YEJY18uoUjQBYz9UFNIleeDuWBQ2zYXMBj2IqiHDKt1B16aq
	S6N1nWTWsyn+Gg9hxdjxOEeN0N2cIG3bdrho6WmSiLfJqpP2AA/km56ZS7f67KPHmCiGiiF9Vxt
	SsMKJfjDD6HI5wOAchBP5UiuIUWm7MHAGBN64IiTugBY/GOELjlDoi6l6WFIaMYuYHvjOwjnFyC
	fqhTNSERHnkABX/FlmPkoeJUUSYOe9KIUZeTx7Xs=
X-Google-Smtp-Source: AGHT+IFNlJzZkDjLydkUzPUYLlA2c9JWh9TESZKV4zpfAYn8jjKMtO3j/MHwJN4CO/OBrA5y4xzAzQ==
X-Received: by 2002:a17:907:2da9:b0:af9:649c:d0ae with SMTP id a640c23a62f3a-afe294b454fmr144101566b.8.1755869485266;
        Fri, 22 Aug 2025 06:31:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:11 +0200
Subject: [PATCH 02/10] arm64: dts: fsl-ls1043a: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-2-f1b479da9340@linaro.org>
References: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
In-Reply-To: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qJdqhbannqpcNe/ZF5YUjLIXi50NcD/YKBgc5cMgrCM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEgGG8Ahoy4wxm6xwMlRb9HztC+05u5oiGkT
 kxjGtiUVeSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxIAAKCRDBN2bmhouD
 18B8D/9OaqPF1Mfs2Ufem0YAlsIQ5SlbHEwLAzxREncxYfZL8LpWvL5GA2B3aULGUmLI4k3HVBU
 XYr16qUJN2hSlRM5e07nlfHYNM/IsvAgif+INe8YNODi+pBIOvo5FpsWFR6nCSGEMPyqHDA5732
 bY+iUCrPIadFPGVQxHCuRvsovQFP2oDHuB5rzAPO6vlYABNqA9l+UC4n+MqEEa3S/sQCAhwO1dX
 D/QSwxXAKw6xOzZkp8gwxvxuuxeQwnbGD87eUuMNW/JLQg549HY4jQlWaNKvix4UJgnhqfIK+p/
 E02HY+5e/wOS4958yv2SFIjXt14YHFcCRlgvRWeeCQcy3Q9BSSIIP6NBa2GYeuYElQmnpgP6Ei0
 WltvDg3oBZIkReUE1fZNCQsITc7R8vZw+i1+tX/Yk1IGzQgYAFvB4xMzPrBJK0WZcoTB4nH/GT1
 +a0pidmbdqbT/MVM3PYYk+n+JmvvrpabaTXa72ubWo4vK0wicl1Gmx9Zukc7eXfrrNKGOC8OrmA
 zWBNin+TdD9T8yH5rrVGH2A7HuJj47d7aPoGJD4EVNgfGex/Xi7nQuf2YCZbFchzQVsVFDTjpaQ
 JOlfvddfcs2Pek3McvvhumLNXxH0VGtEQqOH1aO0QIsM8qkFThGIK80ReiXtGWPzLsX+zoRXG/r
 d4IQ0px1to6syqw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  fsl-ls1043a.dtsi:330.5-342.26: Warning (interrupt_map): /soc/scfg@1570000/interrupt-controller@1ac:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@1400000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 26bea88cb967ccdb7b3cbae3191476f486c86288..73315c51703943d9ee5e1aa300c388ff6482423f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -289,6 +289,7 @@ pmu {
 
 	gic: interrupt-controller@1400000 {
 		compatible = "arm,gic-400";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x1401000 0 0x1000>, /* GICD */

-- 
2.48.1


