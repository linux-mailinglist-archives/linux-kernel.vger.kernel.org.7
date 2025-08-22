Return-Path: <linux-kernel+bounces-781999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CDB319B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254D91D22650
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173BA307AF4;
	Fri, 22 Aug 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2nVsUzW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6794307AE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869501; cv=none; b=UIFmHLJYdEW28qJTXm1uGYNecOIKZilYNImTl3dMUOv3ONW6AoAexECTlUhlAL/w/3qewzByvTSevKQs89VFhU46CiHzYjAxDjYBAg8Bxkjfcj2++q5vm9IGFfPMR22dyVo9ZYdYYTTejPgsfcnGLVCzyfKD1Tj0FJkO6FY9Rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869501; c=relaxed/simple;
	bh=7H+O5W6Cx7TFYYHg0yIa4CMl+T5Jth/7El/WrcKoQQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObjgN6ffKrvASSs0BYNn3gJlQCPPuC7pZSovykbscer6cKQ+wu3MKLKpNz9lkCUv+4Dvtu/kgza2iz5E2IsFYbtUD007Hk/NxshJW9G306dKT+hyvuE40/0/7MbQ0mZcxVs4BnxT9CISVyHoY7sc64Ar0gtEEL9KdDQQD4EU0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2nVsUzW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7aecf92so33700766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869496; x=1756474296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1oPHSZs3u7U8KvICqkGflwd8yraABLSs55oPMk26ew=;
        b=G2nVsUzW7NyhO7XoHtSdgrOR8Rx5QO1cEU6qLPEJKqe5vFBk0DhgPuoA28ZYgzThB3
         Kn5SyBPRo5o+g5OqqvMH6UXRq2jt8Zg1cYJi/0+Z+oe4yBBoPyGxYp9oXbLvhlKiO7Vh
         NlMhsvXPP0jV76Y/tpFJFvIDrEDFbFEZjXv97//S0f2WuoRKbUHf3Zk2pEWvt+jRiZtZ
         oXNzJZRajiJ+9/WKbDUDR8cBHBQlrAD+0o1MmbdQsotXn/UtxQw5tPg2m0nOcvOIgH8g
         wtkQ+w1/XkvIx5BzVJPGPUICG2efei7Pfdk4/GP98flxXRULMMjWOUF8yIf6rLOHv51Z
         3KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869496; x=1756474296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1oPHSZs3u7U8KvICqkGflwd8yraABLSs55oPMk26ew=;
        b=PjTYYRKmLiHN6SLhtPFo0guqJExraBxkg4ZCfVYcd3X308FGe7TGfuymCXpfY4P/w6
         O+caSFrXkHG7En5AvOWvYYc/UjKlcyqTncJVGpIpNLufacKmLdo28xFqfP6QVZT8+adj
         pTHb/nZnXK7NdoAZMF1PLH+CKHecSew/y+VsAI+pRFfR8q6eb+P42JTtI6M84ElS+PgT
         /5EG0q7ZPzapuXTFnc5ZJs5SHCQdDICRnm9eyX6l4QgLoCjA0ovIyQaF13iHxnnahM/S
         X9w3APGzNnEy6A1DKzi+xdWFr+nMVzeh6iG+kzLYqRtXun2/K3/WuRa5Fn+G9FEHulVt
         d3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAu6mOaiddQUwZ54lBYvfo9XIw/GPwW+R1fmN3DMLHb/ktyQzM52/f6fV4rMuFWlnvQToLqsfUPjnFHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPGbGrhjt/42K8oJ2gj2jAYbHdthmtVp0dTh7W/sUyFpJI8+C
	fg6I44np15TTJ9NyR+Ou9wpTW9N0n0Je5CXyCdj/3je12KCZ+8NoHGsgs62hWJ8PMU4=
X-Gm-Gg: ASbGncuRTtfmSgxGYNJDLVlS5L3iAQEAuh7yk6IILlWtE2o2uZs9RJGzSIGZ+H2G9nI
	2iJBeLgdVjEMNYQBNMmpOonJepZAcmS/c3vZhCgRCqdkqDSqDvTCaUXHE5y8TqHLpfe1eU8hldl
	jlAS7qp6kESh1l26EyNxnxyEkf0wBnWxlkcHZdAzCZxi/EfHRyNGF0R8jhZnHFnC84cXVGiv+gj
	Va3rb2iKZAUvByj8OT4K6F04TdCMdJTv6H62tA4NlCK4LKiNjGfdCQ8ro2xev/iIkW65Bo6fReJ
	eA+ErzM3RDXdhEBMmL/myh36tFoCAk4i6P3C59ezT4L4PTOv4Z6iXngOrgHeNDtY5LfxNAG2AQX
	Bp/ry5p6lHJgo66gcDPSihjHhWrvlAI34Dl293zwQaaHnxnJPuA==
X-Google-Smtp-Source: AGHT+IHGf4gD2l54dPuZnRQTNE5elyH8zGFJB2EjqQyxv9TE0M0n+7dSm4Zf9PSmnmp/pw/J1tGJgw==
X-Received: by 2002:a17:907:728c:b0:ae3:63fd:c3b4 with SMTP id a640c23a62f3a-afe2904d606mr159430166b.5.1755869496058;
        Fri, 22 Aug 2025 06:31:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:18 +0200
Subject: [PATCH 09/10] arm64: dts: imx8qxp: Add default GIC address cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-9-f1b479da9340@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7H+O5W6Cx7TFYYHg0yIa4CMl+T5Jth/7El/WrcKoQQs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEneKEpVbA628wFgsw9V2z3aggP1pLeaWTvt
 DKf8bFCN6CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxJwAKCRDBN2bmhouD
 12XrD/91UKSwZcFLucZM7856sWnxIKl00ZUOGNPinv9qCyfjYCiszDUpqIuPvf636lvjnr6iTLD
 swRjLqBQvVrHKb9eZNHvNuvojmT/yHRRkUUe2o0kvr6dEJ6Z7ytdDpUFtvka5zIqi8kMk5Qq6Xg
 sz2uyWs71KBSPGwNGy6umMAMuIm3HzHRifN6mClsn0V0F8mVsfDyiSy8UejVpYvcw7i+fpRoX3f
 +MeM8Zv/QUoOnWGJXssrjOAPyN9l43eEvBXv1JaChihfwuao3gwjyMxuc2+KbtgBHEGDH9iLwLX
 sqq+cKMcqXWIDkMM5g+UW5TiYrV4KYhjWsw4GsX/ptj7fXwpkxdQNbzxbf7KaBaUmknrJcvvOlz
 jDAHL58ZqIebI0iTcO+wqMG9WFl/lNtFTALjDqSh5HhjrYqmy2RdRoy/X4xE4aAQwJYPB09Pzsp
 DiYd1b6O27dht2Z5CFA87Wanr/crWfUlAYKueeYQOc9cP+hSZJis8nS4EZzGf1t5qM7XfVBZHRj
 6ipvyaq/k8qC1SpD2AcDZdsc/86cgIcDno2ylCkHxr3pfUj2vuTz/qv+jBWHSW1RBXy2ttilZOc
 9R862LdCsnKXsa11wUa1rs5qgiOEot++kWuFs2iIrk80gMk1GeAHv6yL4ERreH4cmAMbMdBoyS7
 jrSf2RWVT3tJsPA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  imx8-ss-hsio.dtsi:71.3-74.28: Warning (interrupt_map): /bus@5f000000/pcie@5f010000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@51a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 9e46e16a8dc06448c6eb1796a3ffe70acb09374a..95edab058276bcfc87b9bd85426b999d1ab32360 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -159,6 +159,7 @@ gic: interrupt-controller@51a00000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
 		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.48.1


