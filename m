Return-Path: <linux-kernel+bounces-733647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64CB07754
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC35E7B186E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9131E572F;
	Wed, 16 Jul 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/hiXrDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF51E503D;
	Wed, 16 Jul 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673663; cv=none; b=MVeWTlRMaIslpro7DkbWdiJjFmM+864SKAI6c7OQwvfmI3nwpY5HlfeuUishVdUCpaiSMln4BhXw+t+abiCUzBlZtS5NByqoAl1/6gO8HwnxXty0JSHg4NgtF7Scn1cgn4LJj2VQ9lKiLIdLZnRpL+lLeOFtbZNCNiEwfrWC9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673663; c=relaxed/simple;
	bh=rdQDdI9JouSQXlopIgj0zTq8D4QW2KHFO3f9GHrlvrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+eOzQGoOPOFqihfWqY0mPZha75oHXdndflDzgVWUlGfaqzxAARGy3shISID2XGx82Xgmb4AZZh1+v8Ot2Kkyw5QOusVZR7S+ryOZcSUZP6bZmAYDOGn3BWcv6MDwKys/9dQPZGbyR/ncTHakQa1uM9Yo0yaYMAN27slsyEvDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/hiXrDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C0EC4CEF6;
	Wed, 16 Jul 2025 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673663;
	bh=rdQDdI9JouSQXlopIgj0zTq8D4QW2KHFO3f9GHrlvrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/hiXrDMKTQO05nvgVSvUQAgzWP8ULEvvHhKJo+3ZDWK0YCUhDi/uoyNF+ngznSZ/
	 DcSEndLqgj70AVgNsiThGVM7FCWx8X4Eyay593WZUaf2YwXapEOr3p9acKsE+yWyVs
	 uX7ItNEO35RyrxwTE5tKmEo5gLqLQSr+ErY4FQIl+iGrfsOnG/acyciI2AP297H3Uy
	 xv0o1luCOglbDmxs5OBcpTQN5o9FEH+s01kTHYjYjV827XkWBvc+AMiqXVZDix8lAp
	 FgpDyfB85TffhRocGdU1pS3T4+GPacOwLmAWspoJZT9cP/9NPGO3o0fhI94mmTj/Bu
	 IbyM+UqBVYxwQ==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH 3/3] arm64: dts: ti: add GPU node
Date: Wed, 16 Jul 2025 15:47:17 +0200
Message-Id: <20250716134717.4085567-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716134717.4085567-1-mwalle@kernel.org>
References: <20250716134717.4085567-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J722S features a BXS-4 GPU. Add the node for it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 17c0949ac1d7..8f3d39d8004b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -1229,6 +1229,19 @@ dsi0: dsi@30500000 {
 		status = "disabled";
 	};
 
+	gpu: gpu@fd80000 {
+		compatible = "ti,am62p-gpu", "img,img-bxs-4-64", "img,img-rogue";
+		reg = <0x00 0x0fd80000 0x00 0x80000>;
+		clocks = <&k3_clks 237 3>;
+		clock-names = "core";
+		assigned-clocks = <&k3_clks 237 3>;
+		assigned-clock-rates = <800000000>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a", "b";
+	};
+
 	vpu: video-codec@30210000 {
 		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
 		reg = <0x00 0x30210000 0x00 0x10000>;
-- 
2.39.5


