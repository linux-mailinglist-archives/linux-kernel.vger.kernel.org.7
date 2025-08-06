Return-Path: <linux-kernel+bounces-757808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90436B1C6EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C748A562A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3A28C2BD;
	Wed,  6 Aug 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyk3owjr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC928C2B1;
	Wed,  6 Aug 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487520; cv=none; b=EbnTBE33JE4AjapkUTOwzTR9Jw1gk406a6n6ky0JAfxOUf1S12BeBItqYvGOyCNijHWNZeq1beLkyk66gja+CUERC6/VznPZPdmMeQXsHHtwUKpnqGxKlf5s2+xvutJAtq6fNfic79MZ63zNZtrPcKpFoTWYQUptvSNe9dWdFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487520; c=relaxed/simple;
	bh=b0pX+22t8v2eycKE11swxKQtETKO+aLg0fgXwGjUuso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZKxXqPcalnTf15u0+YGa+D/HpxN6frCPn1OoNVfaDoGy24E90sf1mJMIB3OwWKcLTd4DbDxCaGlcTSh5VU78p2JNrN8xXXeFS9JAxZ70Whcwi0khDEfnfJ+NJb8KJcLNK8yF3nQ0HxP4X+rechKtzsTdParXvXq8s9v3CJI+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyk3owjr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af9180a11bcso216878066b.0;
        Wed, 06 Aug 2025 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487515; x=1755092315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c50RyBPgQdPr/4DUil1KpdDvS+9hJu/6Tk48lrLYEFk=;
        b=Lyk3owjrpSfnvaeU+PDqPZK+41+ecuQJLxVbyrM4Asu+GZaZ+eEeHQJNM9ruvzcaTr
         t6jgKq9zNZgQz7lwG56C/HmUec+BJxibzEJHxtSkGwGLa7N94dO301H3S4zsjYgK6tPe
         iwsXtwh19qHs47reknRzcjer3ACd8PY1OZZfeDE8dB28QPU783vlqI+0embY4Dtx/90J
         28E6pQI8ubAXvlbjMRxRjBdVluK4TJgB2nZWeU/IIRvxtir6Xug/juvj0as8YF1j2i7g
         FTKHpooKIBbk2AdzvbfDtxnI6PSiPNR0d7a4R/i9vwoRu9rgEG3z/z13evi4pxsdY3dV
         +vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487515; x=1755092315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c50RyBPgQdPr/4DUil1KpdDvS+9hJu/6Tk48lrLYEFk=;
        b=B4bh/jjDtnC0xT6t2pm+I9uGUsU6RUfZ6W/LpZI2CnE4XH8AIWn0/gtZWTOdac/3Is
         JFjYcbA3XF+oTk2dUVxZBxqe8l3vQDHrjz37c9AoTi1kNMBVy/4d7YxOtvjJLu/XrvOp
         i2Y0+TiB6GF9uI8Ml9Vbb9Bpo7nO/Bc+7yS/nP+bMhg62gq60RsnQIWFDP6REfpi8ujW
         oNMfoaUCdvZ0Mixtk/rHhVoAPb50m/8FBYNqZHs5q6TjKlbxDWH+83IS9Cq46tyLu3YH
         AtmQW0nYPQawT0ruWPh9uOgcmsX8RDNr1fEAcz7uVRY3rb+meVRiGBCdkStJ+bR27Fw8
         3vAA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcSZsp67X5P4LGh8dBEiWLRHteB++tSHcQtYCSIldhnYZrUiRbU0nMS9p3Ux4jWnJhrZscRTw/Nmo@vger.kernel.org, AJvYcCXGL+Dx5ItpIwskFFMQVQaapvnxzh0PgA33neXvYXL+agLxSXCmyNWUdJU/0NouH+ZtqgW2xnlqUo81D/q8@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVBzZE8YLMRD2YFRe+c3ZOZe+xMHwIiSvxiYGYj/i4vYbSTJj
	AXXFIo56SghPIi2VlCIexiUsGD+caNVQy08fogSgUtW9ZNImdyHXoHae
X-Gm-Gg: ASbGncsTW8YPFK0ydwcWzTl4M3GFvNw1Uz8qDxs4+oIlGmC+KWGXc/NnOjR2WVRPpDl
	pLFIYlGJMeBJ8ek54r4yJ6/QpFHCwumkFCsgd5jGML9BWapIdakeeSNJAud3SW3lDnTcJe2hYpe
	ABKZPt11jZh82R/rs4b97VBtwSAaURl3cDtGzTKxOL3hPan3PokMFPzquEyIvyziQEgJhe2Br92
	+Sr3XZBjrRzfHkwACBhzIjj24MWJ5ZdA9cmomtdzXDdffWPVlpjL/rMTm/FNH9Q9IwtNaogFOPf
	XFraR7d5+KCqlrSC5QaAkzPpiDSxUATt3pnmowtSdVC2oUj0REezhRSS/jgE4bLkPo6PhlX9+d+
	vU3I658X+OlidcPqdSoYrLfusjnaQpLhPdbrksWfc5HidzG3S
X-Google-Smtp-Source: AGHT+IECRHTOqH1pMckrQTVJ2vn4wcB0MM2YxMCUNqlzmwxmnXRr2ua/O3tsfNjUQBkMU3gTEe+wCw==
X-Received: by 2002:a17:907:9687:b0:af9:41a4:25b3 with SMTP id a640c23a62f3a-af9909a55efmr267368466b.29.1754487515061;
        Wed, 06 Aug 2025 06:38:35 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm1113170666b.116.2025.08.06.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:38:34 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: phy: rockchip,pcie3-phy: add rockchip,phy-ref-use-pad
Date: Wed,  6 Aug 2025 15:38:23 +0200
Message-Id: <20250806133824.525871-4-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>From the RK3588 Technical Reference Manual, Part1,
section 6.19 PCIe3PHY_GRF Register Description: "ref_use_pad"

"Select reference clock connected to ref_pad_clk_p/ref_pad_clk_m.
Selects the external ref_pad_clk_p and ref_pad_clk_m inputs as the
reference clock source when asserted. When de-asserted, ref_alt_clk_p
and ref_alt_clk_m are the sources of the reference clock."

The hardware reset value for this field is 0x1 (enabled).
Note that this register field is only available on RK3588, not on RK3568.

Add support for the device tree property rockchip,phy-ref-use-pad,
such that the PCIe PHY can be used on boards where there is no PCIe
reference clock generated or connected to the external pad, by setting
this property to 0 so that the internal clock is used.

DT bindings for internal clocks are CLK_PHY0_REF_ALT_P/M and
CLK_PHY1_REF_ALT_P/M and clock rate should be set to 100MHz in
the RK3588 cru clock controller (PLL_PPLL).

Example DT overlay where PHY0 uses internal clock (the first clock of
the cru (PLL_PPLL) must be set to 100MHz, other values are copied from
rk3588-base.dtsi) and PHY1 uses the external pad (the default):

---
&cru {
        assigned-clock-rates =
                <100000000>, <786432000>,
                <850000000>, <1188000000>,
                <702000000>,
                <400000000>, <500000000>,
                <800000000>, <100000000>,
                <400000000>, <100000000>,
                <200000000>, <500000000>,
                <375000000>, <150000000>,
                <200000000>;
};

&pcie30phy {
        rockchip,rx-common-refclk-mode = <0 0 1 1>;
        rockchip,phy-ref-use-pad = <0 1>;
        clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>, <&cru CLK_PHY0_REF_ALT_P>,
                         <&cru CLK_PHY0_REF_ALT_M>, <&cru CLK_PHY1_REF_ALT_P>,
                         <&cru CLK_PHY1_REF_ALT_M>;
        clock-names = "pclk", "phy0_ref_alt_p",
                              "phy0_ref_alt_m", "phy1_ref_alt_p",
                              "phy1_ref_alt_m";
};
---

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../devicetree/bindings/phy/rockchip,pcie3-phy.yaml    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
index b747930b18f1..d9b9d7eabb81 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
@@ -67,6 +67,16 @@ properties:
       minimum: 0
       maximum: 1
 
+  rockchip,phy-ref-use-pad:
+    description: which PHY should use the external pad as PCIe reference clock.
+      1 means use pad (default), 0 means use internal clock (PLL_PPLL).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 1
+
 required:
   - compatible
   - reg
-- 
2.25.1


