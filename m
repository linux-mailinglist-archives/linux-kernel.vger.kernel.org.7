Return-Path: <linux-kernel+bounces-781990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5EB3199E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D441D21EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF5302CCC;
	Fri, 22 Aug 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POcg3Hlj"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96B30149D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869487; cv=none; b=sH346XclxiJkfZ2tkX2Jsecsjq0wGLxIdS3zYPTmzS6atZ8iaDv8GiJgaZSP9iqdqKsLdXRKA9DP5g5IiQ/4FnX9jboHRRTTDbNkeTWhAs+oQHg7wAY+g5ToTTDmXyK3oiYp9Gfjd8x3zXLFyl7R81yF/y4nVCFzlwkTh1SBpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869487; c=relaxed/simple;
	bh=3SVpgon+i1YQeIuy3oRoxPKfUy9lcns76Zkt/Y4NV+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjWmHPM3QcJ2TZ4Lc/0gXHh8WzgANL4D6py0A060gRrl87fBfArK9aQ4hv5dhfzVEL7tLXwRskEh2Rv8RkkpBD07wBxKO6V44HbzMjpcZqYU0B6A627sB9HQegSJOM7kUPkaP0kWgYvxrfcBwaIDhWJ7+p52sPCkc0+Ye4fq5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POcg3Hlj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78d1695so27829866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869484; x=1756474284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLPWBbvJzifuSCPGTnAy7x/NBrhVR2Sch+UbydDDTnc=;
        b=POcg3HljMchyMYWqKeiN+PKBIzw47eumyQGP7YS/y4yNMHd42vAVduGfWx/nGvsXLB
         18PPX/VovJJQ+HoNRapoO5xEM4H4kGEsNyEXxR36sw6uIZ1ppcDrV2Ne8c99HCsS3ywV
         mPk/0ZA9Hojbgvtd/fWSMGz50k3M64PAFPh34ZmYw9FLJPyKQQWH/8tXcBYj0dyq1/I7
         Plj2vo23qD0qlSxFsTqzs1DIW4XIlrUrvK7b7cfzuxksZn29kmsVf4Hc7DBLGr5M89fA
         3oULO2Gvl/WdWEV2dYrvhe4F9wJTnJAy4gHUrDSm45MASrO/6eVtmC4xIUclWEE6KYt8
         izEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869484; x=1756474284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLPWBbvJzifuSCPGTnAy7x/NBrhVR2Sch+UbydDDTnc=;
        b=O8I3vXoFRjYXTL0pt+8AGIZahkKsJY3qZlxW2vkEM6+EeqzwoDYY8SfC+UGCW6A37t
         iT3oYY60ib9BwKAj7XA0Mu0ycF3WzOysJ3RaZr6owromTVQ4e3viAgV2u8/KXjmQycXl
         +aywb2GGK7Rny3nXg6ElXvm6jcYFj5DVXjhGr7JP2IrAjNfjnIwAWyaQOmrFnRrTBO4P
         1NaHEiKkVS5MOF53GNNvPaZIR0bWful7LQVmqswrc2pUNuukFxI6U6w6In5ijc/Nass/
         Aozn54qZcf+ulfJt4aGy9NxqmuR00v/bKAf//1kqLxRkE+Ge8xN22GCrLIsRez4Igqkl
         Z07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1dQkxJUWSlN95wd2y321cm4lY3j6jSCmuq6LT+QcFaVZMm5SCd9qX2QbeeeAI9Ln9d6XILADets/+Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zG1V12XI+mpyJ8CsFZki6bdT15UBM2ecw1dy4x00NCKOrr0o
	+c8fV2E4wLHgojth9kO8bo8a5gm9YHzM4f85eofCLtEansJk69rkW+YNZ4BnTMH+ej/HpbxQsGF
	bJXnT
X-Gm-Gg: ASbGncsDw/HYo1cT97DA5auSXcsHgFwK4R1U2kNHPbtp1AV/RacHfZw4L2E1ZsfZRUZ
	Lhb8SonQj7usYo02beEVRVixohR0BYWEzd5qzdPR3KVgz9BS+EB6k5oDWOf2wXT0npWwJqSHB7q
	TWa1yg4sRTFHcyTvAp0HfMWm7LrWjb0XSV3SNzD/jyrqtZw7Z//bOUbLz/2k522d4brHv+i/+09
	loe6IvdVdUTHiA9wG6MPv78rieYG6zcLX5fWorTNDWwPLUqbRlb0gxXLTNHABFQPqcskN0efuej
	rGpXYLiUHrHyvgNwWJx8QD3b+j+XmHDfXDeXM7HJhhCdti4gqfj8A8E0Krp2HiBDeJI9ID7vuhw
	KsSEaf42yltE/9/gRL/RnhdsskRksI7BtMPmNc14=
X-Google-Smtp-Source: AGHT+IGye/ypxcYwHYTg5+3IuOjm1+gEOjzMVOKls45nzJUtB1Xa9O00N+ETVyA5ZLC+lUcykguCIw==
X-Received: by 2002:a17:907:7fa3:b0:ad8:9207:b436 with SMTP id a640c23a62f3a-afe29048212mr148055166b.5.1755869483728;
        Fri, 22 Aug 2025 06:31:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:10 +0200
Subject: [PATCH 01/10] arm64: dts: fsl-ls1012a: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-1-f1b479da9340@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3SVpgon+i1YQeIuy3oRoxPKfUy9lcns76Zkt/Y4NV+k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEgiIiD6BglCYSYhzqb8B01pZD6xzH72ddRt
 SeeZP/7jl6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxIAAKCRDBN2bmhouD
 16+GEACReaQu8HmfvIKNpHLlEbY6YYh0s0nof4k3fX9yB1JvLMmDUYQa2XucniT/Jjqxn/FpXnc
 1Oc9F8wHgQ7A9tfonoMlLWbMY+n2dy4ZPKsQ7127kXGUnPs40RoNloVb5C+YJprflb4cPT4kFY1
 hD1mLDtmN39cN26PQSkK1cOChLCJ9MkuQ8oig7UmltQO0YU6azgpYcgfrmivxdt/mVD7fWiCddc
 9b1/FkvhKrt0ftpy8WXriKE03cZMgKeFczZrMOB+Cn0NzzevCXi2c9AnTx+cfJsOF4QrGMAx/Kv
 7PmwHYJZ7FWwLo3rx87JZ+NxFVJAuN0GhZl/eoWfXQR3FbnrZRo/XI5b6M/PKMoLLwoa2PmWElA
 Ss1Me+3WYH1tQXKprVqtvkdzlBrhPsDUAivEDiNSJQVPeMdocN2eMwj+qyrr1p4NICMUx6rnHTH
 VJKUFko2xx2xtgkxiEieJ8qhfDOaJTC/MgBquy33kn5/t44wFV8rJj/oPfggEGGgF3TcGoEb5PJ
 BfY8Uq10AX3UWhY+O1/yDV+/xblulpI6ckf40CL2GGeCsxatWkvHaSc2WuHvjFrQcEvQLxS8kkX
 Z2ju3N74J7IDTL+m8izQAEQCxEHMNXg3NWV+YuO4atriqT+vRBz88c0WTTe6qJGJfEij014Q+ns
 i5V0vR3VPO+IctQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  fsl-ls1012a.dtsi:548.4-551.32: Warning (interrupt_map): /soc/pcie@3400000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@1400000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index dd479889658d452142e6d50b507147ba91c799af..fc3e138077b86cd5e3cf95c3d336cb3c6e1c45ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -87,6 +87,7 @@ pmu {
 
 	gic: interrupt-controller@1400000 {
 		compatible = "arm,gic-400";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x1401000 0 0x1000>, /* GICD */

-- 
2.48.1


