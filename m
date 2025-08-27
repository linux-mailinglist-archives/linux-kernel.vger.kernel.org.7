Return-Path: <linux-kernel+bounces-787750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655DCB37A96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3126916F20F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F8312829;
	Wed, 27 Aug 2025 06:40:31 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC71C84A6;
	Wed, 27 Aug 2025 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276830; cv=none; b=CcsZHh/WdgFanYrcWU2TMY4U1XYJk+wRj+3OtY0+X0QtuiVmcJjm64atzO2vUiSqMVXHfGJH7fwOdkEnn6iK2K4f0rVwA/OIZSiFEP2mpNJWbGTv2AAv7jS7P5RSxSlao+TeIgjf5Cw/KbXkDyatQBRQlCjuCIX/zH7ruBNOflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276830; c=relaxed/simple;
	bh=XZgrDnv9SWmzdVgGFNQhIVjV/gKYCMTTcBovuctsQOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQj3IUkf9VeFiu510Cn7zPpaqFkf0WccaFdn2S/Gi/4fMW9Dg+fzSwYYsZqL+N5XyqX6NPQnLLkn9zbk1mLsSIizv7+VC+MTfdWtg5UgCR+2Fzxgik3utgmSKdl4zpSnD+wKGlBO5i1DDgp15QHl8IC6FrP5TwqigvZ7IG9shKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20c18d712;
	Wed, 27 Aug 2025 14:40:16 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: iuncuim@gmail.com
Cc: andre.przywara@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jernej.skrabec@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	samuel@sholland.org,
	sboyd@kernel.org,
	vkoul@kernel.org,
	wens@csie.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 4/7] phy: allwinner: a523: add USB3/PCIe PHY driver
Date: Wed, 27 Aug 2025 14:40:10 +0800
Message-Id: <20250827064010.55675-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250816084700.569524-5-iuncuim@gmail.com>
References: <20250816084700.569524-5-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98ea417a0203a2kunmedb397446d055
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH09DVkNOHR5PThkYSh9KSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUpKVUpLS1VLWQ
	Y+

Hi,

> --- a/drivers/phy/allwinner/Makefile
> +++ b/drivers/phy/allwinner/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SUN6I_MIPI_DPHY)	+= phy-sun6i-mipi-dphy.o
>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
>  obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
> +obj-$(CONFIG_PHY_SUN55I_USB3_PCIE)		+= phy-sun55i-usb3-pcie.o

Would it be better to call it phy-sun55i-combophy ?

> --- /dev/null
> +++ b/drivers/phy/allwinner/phy-sun55i-usb3-pcie.c
> ...
> +static int sun55i_usb3_pcie_phy_init(struct phy *_phy)
> +{
> +	struct sun55i_usb3_pcie_phy *phy = phy_get_drvdata(_phy);
> +
> +	sun55i_usb3_phy_open(phy);

Maybe we need to add `case PHY_TYPE_USB3:`
And use <&combophy PHY_TYPE_USB3> in the DT

> +
> +	return 0;
> +}
> ...

> +static const struct of_device_id sun55i_usb3_pcie_phy_of_match[] = {
> +	{ .compatible = "allwinner,sun55i-a523-usb3-pcie-phy" },

Would it be better to use "allwinner,sun55i-a523-combophy" as
the compatible?

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sun55i_usb3_pcie_phy_of_match);

Thanks,
Chukun

