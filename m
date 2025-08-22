Return-Path: <linux-kernel+bounces-781991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797BB3199D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD82BBA1973
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCD3043BC;
	Fri, 22 Aug 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJAHAcfu"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1F302CD5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869490; cv=none; b=mdKhqoUfvj80oqyVEf43zN2kf3u3nWhGHbKAY/zXPQKYZufo0sBzK0v5QxkS4cpEsaIW5+RrPCSsvGw81GOlNRJpZPoY1R8hAVEYLshAAWmBCtxgD5hCfpWLunKcojK7H1tx8UeM1RAlocYR9AY0W3IwlnswclVN6vCnq9RhzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869490; c=relaxed/simple;
	bh=LwVTDYBupuAcHM+FBGEUCmwg7FAt9lhCXjGxqLhE3Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADnBRoo773+/vjhXcB2GiGEmDtxH0XsWs9OhCABVjJUGpunhYuCVHD0F1ZPtgnboe/hlXDGX77oJUTIpXGRZ+JUlCY+OfEdeXSnwDKuHYoTtgcjP6kjPIdBZtTV7UPOm5DdG8gosGqLaIS3H4PhansQFiVMb1DUYxtwv+rFNvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJAHAcfu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb74bef86so32689266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869487; x=1756474287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dmXcSmUeGXx3nL3phdW0mGHdFDemcCiAs4uvRov1PM=;
        b=GJAHAcfuQgQlNpgSvwEKvhmT4Sgnb04chuEYnBj9+6wNpsL6Nw9q+2GTFltYnqUnr8
         4ZlfDzzF4r+iff/5DFDUPhGFGcEBf1pOSpfRExlXM5Wo/3xeag8Oq9WNYrzBaAuymMfj
         Hhy4XgA4ev3uvDtFPxcLSlbgcNIyguaWDlMylyzmrMwH6TJ3SbybpuGvbmYwaNh9GvSA
         RZFn02NCKnzcOqEtN5BUhphnBquZ0s+81dJ3Wz6uyOvZJANCK3+VsJrXtJGRbCz6MG5U
         mAkTgymYp+tFzUFAePbTskUQXs4zkP+0aOcD7SCmVhOLKbEIAgcq/zh2Y9EHL8e2/WL7
         tfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869487; x=1756474287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dmXcSmUeGXx3nL3phdW0mGHdFDemcCiAs4uvRov1PM=;
        b=aVgAN4r0kJ7lql7atc0d5LzOq91ssJ+joBsb2TJIZsSXa9VcueGkqPivvSx81IF82T
         g45M+uTTPf3wyFBlkl5q6QDVYG7cGAcUDx4tfBiNRQgQRyMOZANWwre2fjEc06PPFKhR
         HBLeJsZudv4JX56AAPclTtVOP6bFb8Ez7OXCmWcmjuPQo1zg8xGH7VCOnmy+W6vEu/PY
         dThtpSagUMdTYdrwyh/7lzgvpsjCAKaQOrwuzPYccjGE61oo71cM1MOTQ0x+UQwy2Ny+
         arDQMKOzM1LeC6eo78WdodLNjiogWalf1wiFpu3gGtNTP5sOwZOgoF6HmCZHY3saTX6u
         F2eA==
X-Forwarded-Encrypted: i=1; AJvYcCVuqF+rIN/USqVeQEzE5SAxBcRGqVcYiKUOPG/5Mjklzp3yGWpD7DkHsjGuhx8eOgY6ws3v94rNOaOqZ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwcaYvbXQUnOzqgcQnXokTT/w3HaWctuinEodlmeTBRnoBwCA
	xlDcIDHWukXwFxOM1r27M+mXiqIDJke8Bi2pZqrRwz5NQ2NWsv0tE/yVpB3Tud7IkuI=
X-Gm-Gg: ASbGnctbajfmdo/WeyW24ISIa3VJUbS756Ox6/6KlxpmIK3mWTHc8/ajzBiLPYLMVYQ
	77dj47p7ehrVNVtU7XGvgPNIZ0JuobllYnEU7pO7xC0kpyLgL8kun11fRK/5h88acWmZdxmHYDN
	pzDAevaFz8+prH7eUucSKU4mquqbd5RPYtKeuXMi1QmmjsocK67p0g9KiSIclcnj18bcG1MOlow
	2tegIL8/qEHtSkDsWaQ2tkRzqf7Fr7AuEsTzAZLlvDxSVmG4nhZPmJL+tmQI9nyHsY/uX9FIz+e
	tMxwZQDW7PvFjcsuL+HDrTiwRxhGwpQiYjN3VFDZSfpoiVcHroquZXJCctllyaV5uYvU4Xq/8Tb
	1A0J/znrbiLJDVzha9RKUyVXcsoynQXKBPjw493Y=
X-Google-Smtp-Source: AGHT+IEuA5sRAstE8e/rjpyTg7g8U8xiEnXD0mREcr+QwaSaZg5p7OuKBV5B9Je9ZcQwkWGnedj8EQ==
X-Received: by 2002:a17:907:d88:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-afe2943e844mr157976766b.6.1755869486899;
        Fri, 22 Aug 2025 06:31:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:12 +0200
Subject: [PATCH 03/10] arm64: dts: fsl-ls1046a: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-3-f1b479da9340@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LwVTDYBupuAcHM+FBGEUCmwg7FAt9lhCXjGxqLhE3Ts=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEhPq/IurFRNWgjcOAKuyTeJQ536JU0iROCY
 4b40fpK7iqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxIQAKCRDBN2bmhouD
 1y1uD/4kk4nlwoMPLW0/2dm1wiY+/mE7GCwvrFBlIrva2XGyrDX6cbToe5FoLb25Bfy6A3Jys6U
 xRC1vMKVBeyCpy929fMlpYgZXUTOefH8YMKvZ6m36R9v2DgPl0zzGZ9FY/2Cmh9gOH6qaO6bHir
 z+0SjDDjVhC0kT558Me2i44GC7ROX/vAtwT2Y9dLCopgKRn/qYEC60sYKArtecoARZju8bU6eqo
 F8kymsHBhMGbrg8sU9VVX6AlO5wqZF+UxAt0lffpl+CO2HODEgo/gXAYibZ5Pjdil+NHjbiegNN
 fuNDaYRtAih560jnFASGDXG2dnsUxdsLr+lInNhZtKREG/8RxJTjeppOan/5qNy50oAuWgk9ebq
 P//iH01m/wlBcYzgshF4lS2CZP2LbVKIEgkW7oGaNna9gntA9e1Kin6nGq6VIbajcqmEzRcRqjA
 OINRGwnle1bYltacmy0KQRIkUeCTdwpDLKTaJIobeDlSmiCEEq9PKi8J2l3uyRO5i+v4mMdwY+D
 ApbcqZRbbOkzv+pmyFv6JGcYbxXJXFRxZmJ2CmvYERVWZCLWow9klpHVMeXvtJ0xsPeBju8Qhjp
 oZ8nOIZRJ7fc9Yskwrs1/Cq6bVSWSonHniPvV/4k/DG9m1uTQ5+c7sfrcfAMM5PUBJjOQ781FgU
 a2IfE9ZWXeTaKFQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  fsl-ls1046a.dtsi:334.5-346.26: Warning (interrupt_map): /soc/scfg@1570000/interrupt-controller@1ac:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@1400000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 4a22fde38bea678ffcaaf44e9984ded687cd2297..770d91ef0310d971d044a1f55cc5e2cb738acc47 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -260,6 +260,7 @@ pmu {
 
 	gic: interrupt-controller@1400000 {
 		compatible = "arm,gic-400";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x1410000 0 0x10000>, /* GICD */

-- 
2.48.1


