Return-Path: <linux-kernel+bounces-781993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39777B319B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C22556582B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB96305044;
	Fri, 22 Aug 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltPzdWoF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54701303CB0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869492; cv=none; b=b2GWmjsOF+AIqpfzMB3OFX7SsqlMaynmCSHzuk/VcX9qPMQLmgZIzMYhGxP0XCxGoB15PN+GkjBqVDC6pqXgScOZovg2gGLAUf+fhz8NjWQHMIufTKeAKaudHiWDrLhIGjpBCi6a+/6bATZ/ls8BLpV1TEuBJsGvtRQTNYPSC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869492; c=relaxed/simple;
	bh=aXy08N5ASlJt1VGT53iFuQkAElMeDXbRExFiLdVB5y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I00kLicZ0e1nrBSSZxiV24buOlXcQVvPtwCYcOAwD+3lSRNOy/xXUICbKNoQJmdJwNuvtCSpWOyjJjr1bAwNBxwepm99pVDH1WsvlqsCTjEiQ/vM99jYlk/dsvbsObKyDhIQrQxy/SJvuwICLYjfPqlvvSIye2oEK4xw5054Qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltPzdWoF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7aecf92so33699166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869489; x=1756474289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2Ul2W0BQETQWNbcAlwTY9yoNAx48v1oZv5jnDd27cw=;
        b=ltPzdWoFmbr9T93sPZkgMmGt6PYfBvRhpSWlG3PXtsPeYGVWTwR6vdyRfi27r2NGf5
         BzQ7pPm4TD9jVEqKL8Gwyxd623d2zdx8LLeUnwFIA5Vdk2CjOwY3v+NfJDFErFghwT5F
         W83nwbhkRRCGJ9ZJgl1aNeIgQNa7/Eku+J4bFMsZ/YEHVoXcFlBD6AIbUUBnYRKXehQQ
         yvrhqVoEylpkHnIPhXVBV0UEAR/5FpOjjWCHBf11/l7kOxVV9MMFfmfE0vCV+1wpUEdx
         +cmDqEmtmFSweD6OCkdVul+1OhEcOyZmaCka7FdUU6DA1P5u3LBl5wfPFGN1AFChpClK
         akyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869489; x=1756474289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2Ul2W0BQETQWNbcAlwTY9yoNAx48v1oZv5jnDd27cw=;
        b=hQqfFgjqnEm6R9b0cZiDTBp/zDfR5Mo1Ui0AkHl1CYqk7rxjRQRSphzqRLxgs3G0wd
         k8YnQ2BZ8F0lKEUYBd8TBGtuWB1XxzjnITjFENH3/RQsMOoIURRH9RlypZ6Oo5l1F4Fg
         Tv7hHHWPYn8my9c3ZTqlWja8UGvJo1ywpvmz4Gfk8DTH9ybYZRVJ5kq8wxrMoD7T1sAe
         OflRKIZOB70pVv7xiVlyg5czJAef/duE+a0g0eMHftRBOvG08NlZCHcKKgsX0Tledzcj
         /pzre6CLLOnXOmaMfKUrQkcVwjYtwPvZfPbTWAufdkXX3BFGXSrNYLQ0Z/QETrA54hBX
         aakw==
X-Forwarded-Encrypted: i=1; AJvYcCUHx5Y2VXNVnht8reRPq6T93dLUmYSghybpkYjH0tp940FgoGDS2WQKiinWZXdcH7CHT3+5yy5o8VxY/Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uZiCOpoJsDPATyu+xqbndiAfu2FjTIsI3x/QA7tyZNYM8dVT
	RAatZxAdg7ubmInr74Ewi/Ud5PZQnxWY2h9gZ433UOlDcGK+hWAdbe9O8zZxrXV+FUg=
X-Gm-Gg: ASbGncsyTtaMiFvKqpaq2U1xne7eUGkhteSJC6EsLhvvxYswuUD2/smi4+Bacv1UU28
	UiuUZrOmaA4vQ+Z3a2k0+fbHvL7UDSlp2n24KMSmokoMPwjsuLbJX6jaL3jqKdzAG5bQtA0aU0J
	n5i4cw9pttYt6+gKl+4GwAuNhzfLxjM0utra3WwyLmCJ/BKtoHFgCkGrIXwoswBH03D5P2jlYUN
	O2bprAjRylvYL6GCBiauT+gUehFYQ5XCuwyaZn91s5xOor22e96WzjizDc/+mpRUvp59oGYfwPD
	421JU7fJ3hZCjTI0b4QdLj3vF0s6VCTDY1HP44I8huak7MBhqHr6GK4XAnqNR+2wAK+mQd+KrXB
	maVKrAuKHL9bSHCLnCNHpm3JpouM9fLjH+l1XpggJ/lvVd/oLtQ==
X-Google-Smtp-Source: AGHT+IHV78ZxU3iKNd6nP7fZUbBvl9S8fQrvWntZEx4dMBRpAUfAAE5JWDVypBBpJHo8PYXAQs5H5Q==
X-Received: by 2002:a17:907:728c:b0:ae3:63fd:c3b4 with SMTP id a640c23a62f3a-afe2904d606mr159402866b.5.1755869488604;
        Fri, 22 Aug 2025 06:31:28 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:13 +0200
Subject: [PATCH 04/10] arm64: dts: imx8dxl: Add default GIC address cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-4-f1b479da9340@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aXy08N5ASlJt1VGT53iFuQkAElMeDXbRExFiLdVB5y4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEibvRBDJw4yp+gxDajS6PLcrd0nA3hShUtl
 8Dm0nFuyeKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxIgAKCRDBN2bmhouD
 14DaD/9L8xMva9DaFBSQ4PC9biqUYgFlQGRgXmbDMV/uW9ip4ASvFGD8OCb/h2g5ADDSG6hW7gm
 OUeCOa3+yLMQP4eP0gJUSlyVLD+JFjk45RqiywwCDWa4fGnvmDAPMf2eavxTgGll3Kq9Lzlwf76
 UZgG28HmG1rMEz/KyPqBTx/LchefFJOnxbPKeU4iWmpYdNgPQ7ggQlPG1rSIc2teYq4wOTpV/Ov
 X5Cmi9pNXCeQxqgiUt9zZNIZOPodSZq+cPKqEhGeoVP7SLhDnsUHQK84BLFzXyfrQ1oQbobXMm9
 SRnkMRxE8Ilztcs9uhwiOs7wVyXWyprkWQgwdxUkGe2aAqC210k441aZsSVj26lOKVjnmmtx5bK
 02wtbUxMuxWwnsCxkMhUqV1jIhtuQ8oRA/ISwTqdcxGb9R1JgsW7e0DWXFVu7/mnWK8SwGWlfct
 XFshe7VwJA7v3K6mpa37v2JZjifiDk9Lyq7EYaCLDA9W2qn71OxdlhjRhzDN3bITix2YNrbXzET
 vkLRUdrtAnjv34SO3Fp1neixvBP9oDEI3KysCAPbtPk0pJTOMe8BNW6Q/7ReuJRxvmu9/C7k0d4
 P3rt6mILJ69BqKaD6hh4dvVwslFScCPb4evHRO/Ddp+DFdFZ4v7TIiVvyi87YS+qvSVg588Z+4a
 foDRYXgoncHtsdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  imx8dxl-ss-hsio.dtsi:45.3-48.27: Warning (interrupt_map): /bus@5f000000/pcie@5f010000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@51a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index a71d8b32c1920bf9d73020ef48eb98fdbe9adc6f..8d60827822ed1cc6cfb1a9369faaebfd711708d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -92,6 +92,7 @@ gic: interrupt-controller@51a00000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
 		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.48.1


