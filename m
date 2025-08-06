Return-Path: <linux-kernel+bounces-757807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8BB1C6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E306171456
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499128C03F;
	Wed,  6 Aug 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTDb0gg+"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713428C2B6;
	Wed,  6 Aug 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487516; cv=none; b=WULwV9L/D5BybUBgurC7418fnz7AkJQFqRR51PUuZN/Ii0VcbncwR8mGaJJjUL22RBH4eRRJsWvW9Db9h7bgOn8mqUWOT4sbMPfvXqRBALO72GUDrPvC6ZbswHwCNcZkcPCzs/UdaHtC71Q4t4B321cpJdMRmRqMcEPCR4KiHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487516; c=relaxed/simple;
	bh=ceWuJVPs5vLoTA0fUJyqzQPFIdH617Drv2JS+1b4QM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnpKZwOVbpegt1H0Xp47h7HFnbrLkudHl2s3BQZ1PVS71qoGAQxi8Ur2Iyew2TO8oTpoJvf9yJHkIgxmQlqscWz01S7usHRpDeGsbkzVhsXzeiSGlSdncHIbPM/nDUEXkOC1cIpnbPV+Ff554zioW+Knm3E2Z8GVDucsBg+M1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTDb0gg+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so1586194a12.1;
        Wed, 06 Aug 2025 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487513; x=1755092313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/mHAbC8hGHbBSwhAq1pRep/z7r7zHvPcOOX2+I5dO8=;
        b=VTDb0gg+6vLbqyBHjMGPvPMGhJEzeWANWr9nCh2wRHJTU6WWyAxnYhvdQISLf1sZYR
         sQDjKZG+rHP/mF6PkCwCk5xuLKLTihgw95CnXYShNWbtnDfAnWyCKMTyYLZ3e4qxkdZW
         DgHXuq+1E29pRazlaRDmb05miFSW0w1o2Kh9OPnTvXeE86gNku9dwoeYvK04wC8SrEDZ
         HY8v0Hj/woIqzZ9GIYMYq4upEuhEPnM+Ii/Yy7S94JZD3fJY3B1wAszF0TsdBqzYDQK1
         p7QcV/imQxj+av1oBUAl4av3B2TT8mfVTomlTM+Hq+RO7z2DHbfYkFvPmtPpH8Zy1h16
         4fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487513; x=1755092313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/mHAbC8hGHbBSwhAq1pRep/z7r7zHvPcOOX2+I5dO8=;
        b=hLr+a8X2/vYj8GNZRfujQXanmhpHHeaMUEitBzBp4HCp1jMy+ea0+uEs6Spn3lh29o
         e9wjTd/TF4U4XE9I6euZuReayUNlaWowc7eZ2V38X3xlb79p7fBGS2Tq6uGwvxk8s8Ma
         JUPIqWpFcOK4poytoX7czOJeSnM6bQjQTEnNvrJTTwUXx3KQMZCM+H8/Sifvdws9TGyT
         fikgOZsA6nJAW88S+ccY0x5u9NZeUGQ7on1KiJ75wG4pjpwzz8ZmIMoIOL6wMF86YZTf
         MNmD1PYZFxzpYJqWysAOHzEDDvcCgIGQGO4lcunX0yfqEq6ivA98PpSYABWh5xE+6BMT
         MX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwPXmSmp8/ff6+erW8FfJPu9qxEQKH9g1rUXCMMjmxyoS1vksBiLyrSBXBqlVUAr7vRx7uYY6h2KD/@vger.kernel.org, AJvYcCXbsaMyeFkNutt+uH/yzvIxjcANuj0QMfC8w/Of/02aKotsQrSmij8gJHg2bvkTX5tpOBPzF11JdgbX3vih@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQk6mM6Syih8DZx3Bv/C7CowTP4ymqQXl8c6DToM4nbdFR3rc
	ISlDzVawNqBhQFZT3hG5CUFItvxdypkGlXFlXRdyHQaxw6pkD6tw3sI5
X-Gm-Gg: ASbGncul5Hpitf7LI4EcB+IenSbeOC7rW1mY6vjnvKKkIcCdeEtuR/Zf3aIJKcehLAI
	iAN7NUnLmMjRePZichjDFO/h6ifcw6WBZjXySo7l8KFlSb8Rw/WLyXgPj+Hczm5lcLkdtKWNNNZ
	Pc60vd0Piqpqrza7LQwLbG05yWxf77IEv3Kq5wn9etjVHKPCH7n2q/ZM0bfj+9495Y6W9ldEv1J
	Dx++5D2u+o06M+sT0AjN4NkZ5FYUvRo4+wleBs3dfGahmvAL89XXFYGoibwyxEU/ph2fbnauux8
	kVz3xhvZQy5P1U2nclvc6pomGvzKPHG94i2WHMjeUvTKyHAfH9yP3q8yxzC9be5IdBIY6AnYnhr
	rXEsp5FDWzEAMnTuWpqna+HElA2YIQfSKr9zK+6Rl5Kei6UFU
X-Google-Smtp-Source: AGHT+IGEIzwVD1kQWngECBW/TE86WqdjSZGBNfA0QX7gMqVVKSneWxDBN1wo61EMHfeOMI2G9SeP6A==
X-Received: by 2002:a17:906:7316:b0:af9:8739:10ca with SMTP id a640c23a62f3a-af99099f240mr290124866b.28.1754487512787;
        Wed, 06 Aug 2025 06:38:32 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm1113170666b.116.2025.08.06.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:38:32 -0700 (PDT)
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
Subject: [PATCH v2 2/3] phy: rockchip-snps-pcie3: add support for rockchip,phy-ref-use-pad
Date: Wed,  6 Aug 2025 15:38:22 +0200
Message-Id: <20250806133824.525871-3-rick.wertenbroek@gmail.com>
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
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 4e8ffd173096..0859c7960167 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -33,6 +33,8 @@
 /* Register for RK3588 */
 #define PHP_GRF_PCIESEL_CON			0x100
 #define RK3588_PCIE3PHY_GRF_CMN_CON0		0x0
+#define RK3588_PCIE3PHY_GRF_PHY0_CONTROL6	0x118
+#define RK3588_PCIE3PHY_GRF_PHY1_CONTROL6	0x218
 #define RK3588_PCIE3PHY_GRF_PHY0_STATUS1	0x904
 #define RK3588_PCIE3PHY_GRF_PHY1_STATUS1	0xa04
 #define RK3588_PCIE3PHY_GRF_PHY0_LN0_CON1	0x1004
@@ -44,6 +46,8 @@
 #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
 #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
 #define RK3588_LANE_AGGREGATION		BIT(2)
+#define RK3588_PHY_REF_USE_PAD_EN		((BIT(2) << 16 | BIT(2)))
+#define RK3588_PHY_REF_USE_PAD_DIS		((BIT(2) << 16))
 #define RK3588_RX_CMN_REFCLK_MODE_EN		((BIT(7) << 16) |  BIT(7))
 #define RK3588_RX_CMN_REFCLK_MODE_DIS		(BIT(7) << 16)
 #define RK3588_PCIE1LN_SEL_EN			(GENMASK(1, 0) << 16)
@@ -67,6 +71,7 @@ struct rockchip_p3phy_priv {
 	int num_lanes;
 	u32 lanes[4];
 	u32 rx_cmn_refclk_mode[4];
+	u32 phy_ref_use_pad[2];
 };
 
 struct rockchip_p3phy_ops {
@@ -157,6 +162,14 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 		     priv->rx_cmn_refclk_mode[3] ? RK3588_RX_CMN_REFCLK_MODE_EN :
 		     RK3588_RX_CMN_REFCLK_MODE_DIS);
 
+	/* Select PHY reference clock, external pad or internal clock */
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_PHY0_CONTROL6,
+		     priv->phy_ref_use_pad[0] ? RK3588_PHY_REF_USE_PAD_EN :
+		     RK3588_PHY_REF_USE_PAD_DIS);
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_PHY1_CONTROL6,
+		     priv->phy_ref_use_pad[1] ? RK3588_PHY_REF_USE_PAD_EN :
+		     RK3588_PHY_REF_USE_PAD_DIS);
+
 	/* Deassert PCIe PMA output clamp mode */
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, BIT(8) | BIT(24));
 
@@ -312,6 +325,25 @@ static int rockchip_p3phy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_read_variable_u32_array(dev->of_node,
+						  "rockchip,phy-ref-use-pad",
+						  priv->phy_ref_use_pad, 1,
+						  ARRAY_SIZE(priv->phy_ref_use_pad));
+
+	/*
+	 * if no rockhip,phy-use-internal-clk, assume PHY uses pad for the
+	 * reference clock in order to be DT backwards compatible. (Since HW
+	 * reset val is enabled.)
+	 */
+	if (ret == -EINVAL) {
+		for (int i = 0; i < ARRAY_SIZE(priv->phy_ref_use_pad); i++)
+			priv->phy_ref_use_pad[i] = 1;
+	} else if (ret < 0) {
+		dev_err(dev, "failed to read rockchip,phy-ref-use-pad property %d\n",
+			ret);
+		return ret;
+	}
+
 	priv->phy = devm_phy_create(dev, NULL, &rockchip_p3phy_ops);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create combphy\n");
-- 
2.25.1


