Return-Path: <linux-kernel+bounces-781996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C67B319D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80EAB05786
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBA30748A;
	Fri, 22 Aug 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcqbNw24"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF32FFDEB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869496; cv=none; b=J+4R9vgK4vW0s3pcywoaf9QjWdwj/qHpaB1Bwnle0x165SDe6GmSCvucxcLSrqvK8xEREIFs17B6d8SQ38AXtuafJ3cGh5mCRlHH0W/HBVKKnNBisjOlJc5baWZv/s5Av0anYVj7wqLxJ9UlIY3elWML4aqJci7YEE9guYiYO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869496; c=relaxed/simple;
	bh=9aGPRqF3hU3LhHMJ5AKmjiN2YyxcsRNqdApXK8jOBCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRthYVhZZKfWEP52e8ca7piTgVtBRgrKOeW7y8/exTzxpTsellw8HU3EBQIfWMA4tTAfbR9ihJ4EE48Q62mAfXX6WU9CjizPmb1UEm72dIy5gbCfkmUPZqVwyzFV95fm7tGwXQVtjJhX6wt9wi6CWyM0C7RwUiO2NXvUWqFPe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZcqbNw24; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so34375166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869493; x=1756474293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+/3XqC9O5lqfeiA7jEpapMypPzqJuRm5i4h79cnVCQ=;
        b=ZcqbNw246ZoKNh4WzDBV+omkeJ+hId0d901CaX27XLOUxc2faDt4IBBlILP4eu9BAT
         SK8NqeWUR7zd7MD3ZtR004OJ1+B+5MFOhbaTDYG5rsSpBxSZHSXD2ejpuI9lUw2nFy8B
         q0tNbaPbJuRUZYOkOdoQmx/vo2UJd4LWUoeXvnx/zQYK+x4EuxOFbOUIP+xBoeIbH6v/
         kUI02DvYN+6TrnL1kF1GeIK3CLIYIiX6NP6xb3V+PtfkI/qP3uLu7CfwcXn/BcMIN9zb
         +d5VlD6chr8stXu+dNCiEraXiBUH84RHKs2wPndX31hQWmzXGZ1N97ToY+9mEQIx5Pjv
         Z/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869493; x=1756474293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+/3XqC9O5lqfeiA7jEpapMypPzqJuRm5i4h79cnVCQ=;
        b=K1qYTGtoZWuITddlwi4ypZMYP+E1oU39BecKJUmVZoHU9L9juDBSAuQVCQ4j4O+Zwt
         VaDLDvTTB0+lpanEk46G4AEPyDvPLu2KWK7mn3ADenSli8EwWJEAqRD85mPpY5bUVb+Y
         Qdgo+QxO0yIEmFsf9iWtYeKT0aJ07mvLrZ/xaaCeoLgBc7MIhOTrwyIASRNW1h/vNQ6d
         LJZ/OWjzGmjdnwE5YwlGvAm2fw8xbZ5B+k0vIWpuhNUNImS+L0SAca2AOPZ0mbzgzjpi
         f5ESizNXTc1WUgxLryrKCdHg2yJqZv097wTe83oWPM60Z4Niu+8a7UhE4cbCXA2sjkPU
         sfKg==
X-Forwarded-Encrypted: i=1; AJvYcCWYgHlXempi6xcm8fAkIKtgGpnMlC3SPM3XaAusiZf12syJ29YmaLJPk6A+zEn46L4rbqVzcD8H5jDwBCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOkxHTVSKn3fZFl9FsZ/28aUUAu2SOni+72rbIYofNmHyIm+Y
	bSBrnK98WQJl7bMQ+aJ3i1F4NCE0xusV4FrEqhjf66jpYvgENwy7EsY1/fV0m7G9vB4=
X-Gm-Gg: ASbGncuwmM7DTmkwSUPDNpk8mOvaV5ebLmRL3ST1PYuHoBKhWqeb8clCMnvhdzk+4tS
	5v3mx27DmrMDmNIF13yNHQpJT12IsVbCYRen644+7DSgqhm7eK+Y5KQe8uSIs8M5Jo9/G7rjZek
	o/77U9QHuYkqID94k31Hj4rQmicpPvORjSwwPE7bU6XGs0uAsu1hRQ4coTj8X8ib35FrWJUKhLd
	ECCKWrBd2rMQVSH4hUFLB06kZhH1ONf7rygVv9mJdOKVzhtawc6klpso6uQPMz3q4+x1rOvz6nZ
	Gj6VRkBqAzqN1nbfBbHdkWy0BVt/tgMFxe9pWt9E8V2bC+eDysUCPrVMZzJKkA3nFhwARmZGnI3
	o4gIf3NMw9ECKVw7XnchYIwIWxD0lzHYrQ+YLS/4=
X-Google-Smtp-Source: AGHT+IGv7fFkgXyf3+soUZrw4vUGsNAYnhF5jPzx8yt72j1BLMthgE61ET3nwo62H4P4NqEQzXSWRw==
X-Received: by 2002:a17:907:2686:b0:af9:3397:ee9d with SMTP id a640c23a62f3a-afe28f60bfamr149944766b.3.1755869493213;
        Fri, 22 Aug 2025 06:31:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:16 +0200
Subject: [PATCH 07/10] arm64: dts: imx8mq: Add default GIC address cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-7-f1b479da9340@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9aGPRqF3hU3LhHMJ5AKmjiN2YyxcsRNqdApXK8jOBCE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHElcNZBJwVVoVferD3+Ha+vRMM/Yxaj3iOuX
 ndH63U9FAaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxJQAKCRDBN2bmhouD
 10X/D/48aejT48pDsDMcPM2RnZNjcDN50dVq1bQ31lwG1aErEMVxN7xy/aIU54uRE8a1JAdMWL4
 pVQKTkVJzM9DlzkY83kNNUh5agl27PtDyQ+pM27g3ZNU3uQQIGF7EDt1Nzlc9MGKtJN0DQ63qcC
 Qmyj0yLBCpSuyD5wh/CUh8Re08HOJvxdWKghvffYt1NNHnm3K1kP1fyR1PfHNhImMcmhpNc85zR
 Kp5gLcNSxsWFa9VEYXHhZuFNUi2+UPoFdrsTgbJAzSfapIxW3g8BbQ4CzZGkTrI3KtQ29kPyM+D
 bP0DC0vMAiOmkG9CLT+AujHSVUi364vqMFOOZ2GOSpvLNOTXHLipnwdHJkBDMjYEo5UJmq+xhLt
 fGblRgCLiQm7Weav9a9TR7xdjXB7aLrnSAKB0j3eeqblgZEE2iYG9KnIVyfEpnDPeV8D050knca
 xyJN4Cx6rB61FPv9KxFVCLL7IvDPwk0PRrQHaTjgfNw8WHWmssVH5yQjPQK5CJH2NVwRNWBqnxa
 QF7Jrs2hGiGAFvnmdYFgp7AbjOzbfnGe/Ya0HSzbRq4ANwnmGT9KAUN5YrtLyq6iBQK0/8JZCvT
 JyaPu35vcRb8esRoFPgb6m5Ev4KQHv+qDKFQiDJa9SJ9i/N09E6EG4XPGAkaXXKYATRRP69svZG
 +h0aCa505lvd3jQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  imx8mq.dtsi:1746.4-1749.43: Warning (interrupt_map): /soc@0/pcie@33800000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@38800000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c9040d1131a80941474806da0741df18bd36b2c8..607962f807bebe52d55976019a210738fa6bb339 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1890,6 +1890,7 @@ gic: interrupt-controller@38800000 {
 			      <0x31000000 0x2000>,	/* GICC */
 			      <0x31010000 0x2000>,	/* GICV */
 			      <0x31020000 0x2000>;	/* GICH */
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.48.1


