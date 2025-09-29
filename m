Return-Path: <linux-kernel+bounces-836275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CABA92C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D355C189EAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222303054FE;
	Mon, 29 Sep 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IMTp+LqD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E1269D17;
	Mon, 29 Sep 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148052; cv=pass; b=YRftDJpdtDj3RQU4c8ZY+LCtaoyajlpJGOeh+PtiihFuFYqLS8w5x54xWama0bu64XuuK5lQYrCtQiJ+sP3/utyirselvB2Zp9b6cvKlojOqLY895o68FLvTYx5TNOi5A8V2/h9BXUt5d2fNKB/0Z9wCua1kuFj1lQPTMRW7JK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148052; c=relaxed/simple;
	bh=1xshg8Db+FHyhdQQB7hIBQxxqN58HazFbh//LmsFlvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0cAqL7+qZV+dlRJOBUIrZTW+GyXEwMIh6nJKwasj0KAPRwwXgI0y2DKOGgLL7SVxXEQR2pao2P8gpzulVShuGFi2YQ0Wtg8+C5zwOn1nzaWeSN1uVoyshO3fVp8anTlzaS6mFoSF6QYBG/auXMpM7/AJp6asVX68eecTekwb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IMTp+LqD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759148029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OvZXlL6457jQwi9TxNd45IkxRWD2OerRZgb3MCUSDRnMSfezAPvQErxldYHDckncC5kYhMr1xYsnvElxkMamr2SjL1dWnBo4LpVo84Yrci5cjyM5ru3kylhTg0/yjy/UhqiDS9+6laLwaFE/HvKX2UknjvNCyBr2i/Vv0rwoVWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759148029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Po+W4jLTNNRztJahEXbzKFJ1FSG77lyfODqSfi5rmPk=; 
	b=KBtolMeJM1giSs9rqZ6l1559ZViXOYEygMaNyACtn2BfWNfcdjeKXZalWiIlfM1yGn9EjdA7PTdA5R/S0Ui/T2/kMXFbUsuTDMluZjnw8E2QvsodRC+OaDDiDcNtA4KoSeBkiyqZ6HF/LjCmmjxzaRRke0qOF2bOKVxqTaNVCD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759148028;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Po+W4jLTNNRztJahEXbzKFJ1FSG77lyfODqSfi5rmPk=;
	b=IMTp+LqDmhl7qx7VaGEbd0T5h3HTBwBfZppj5Q4S532hGnSfMLJMQub1LZUfDVpS
	4Tl1LgiOexwsTJMoLgqiBUfBEo95oQGjLXbo91YeWI3gqthxN3pdjG4m1i//N9E5pp6
	FaBzpTBI5JCLGKDK3SKRK5HWhGfukTCgZ9phSWEM=
Received: by mx.zohomail.com with SMTPS id 1759148027547606.8319661506675;
	Mon, 29 Sep 2025 05:13:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 29 Sep 2025 14:13:20 +0200
Subject: [PATCH 1/4] dt-bindings: clock: mediatek: Add clocks for MT8196
 mfgpll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-mtk-pll-rpm-v1-1-49541777878d@collabora.com>
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
In-Reply-To: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Guangjie Song <guangjie.song@mediatek.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The clock controllers for mfgpll, mfgpll-sc0, and mfgpll-sc1 all need
CLK_TOP_MFG_EB to be on if their clock control registers are touched in
any way.

This was not known at the time this binding was written, as this
dependency only came to light when I started poking at the MFlexGraphics
hardware, where this undocumented peculiarity made itself known through
SErrors being thrown during register reads.

Add a clocks property to the binding to describe this relationship, and
mark it as required for the affected clocks.

Fixes: dd240e95f1be ("dt-bindings: clock: mediatek: Describe MT8196 clock controllers")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/clock/mediatek,mt8196-sys-clock.yaml  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
index 660ab64f390d2e722b7d3e25cf057926da318bc0..41aacd8d5f69050eebdf8392f7b652427632f491 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
@@ -45,6 +45,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   '#clock-cells':
     const: 1
 
@@ -90,6 +93,23 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8196-mfgpll-pll-ctrl
+              - mediatek,mt8196-mfgpll-sc0-pll-ctrl
+              - mediatek,mt8196-mfgpll-sc1-pll-ctrl
+    then:
+      properties:
+        clocks:
+          items:
+            - description: mfg_eb clock
+      required:
+        - clocks
+
 examples:
   - |
     apmixedsys_clk: syscon@10000800 {
@@ -104,4 +124,12 @@ examples:
         mediatek,hardware-voter = <&scp_hwv>;
         #clock-cells = <1>;
     };
+  - |
+    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
 
+    clock-controller@4b810000 {
+        compatible = "mediatek,mt8196-mfgpll-pll-ctrl", "syscon";
+        reg = <0x4b810000 0x400>;
+        clocks = <&topckgen CLK_TOP_MFG_EB>;
+        #clock-cells = <1>;
+    };

-- 
2.51.0


