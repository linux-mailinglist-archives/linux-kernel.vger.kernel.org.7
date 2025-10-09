Return-Path: <linux-kernel+bounces-846909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD9BC966A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E73A30D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C23C17;
	Thu,  9 Oct 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qXzi3/7E"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16499D271;
	Thu,  9 Oct 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018420; cv=none; b=UqqEAK34g6XI1G+LYe1feYoSMIBLtsAHNDci1tAfFQA8mC/d/rNqUteGjuFtT7MEnGVHF8wWS8uWVFdLpHCxuHAxeAjBH/kBE/g0fMgfGVne2g+TKUTeaG/jgroIy27nwGX2/qdCcnXq0eNjg0+dQhbmf2+7jjB3j82Iikxlfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018420; c=relaxed/simple;
	bh=3KG+ISZgXFbxkfQir+K96CSYwnwWZenDYR60OPfcQIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIQ9B2WGIwwNtIQh0gvtg57f/kO9WG6pxtcXa4UWlN9Nw/loNtspsgKtY2iKr8sRArZtT3stjUh5dZPttkgjSeeJ8vv8jbtj8oelzJYRE+dbWg6XIVXS0sZyrxZaPqKfE0uqNTGXFZVKRWFxCcbbq7/8ASDramHk6gT4X5dmlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qXzi3/7E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1y5MNw5pAX4zEDE7oHbM3Qb22NF+hb8K41cpqkfKay0=; b=qXzi3/7EvQikSz7+v6VhkyeIyY
	mrruz6GjdBUnEFBc00hilEBAoR7HPxjlOK7SkMaB5y/w+OB2W4DfoQ2gvvduFK7Jn5R9ZaSFLaBQi
	5MC5Ap9quFLTVLl4/3RteQ9wz/zoRyfugx9Jc5NDnvkO2RLGWvAD9tidUw90QwmaT54OAm5ESY7yR
	7xXE2wDGLl5PAEipZAnTw/3lYKU+VwN6cQHE6l7VmrjKPKz8KIm8b6UKwpiOGTgEZbRXoiw5wuD9H
	SMsImcO4DcLek2T69/tnTNWnlNPZroH/GNk19tXuib12c0RyofsGVl0Sc/lskeR3ZkNEQEXRYm0wA
	26Z98Mew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44504)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v6rBP-0000000074K-2fB0;
	Thu, 09 Oct 2025 14:59:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v6rBI-000000004rQ-3dqH;
	Thu, 09 Oct 2025 14:59:44 +0100
Date: Thu, 9 Oct 2025 14:59:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, andrew@lunn.ch, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <aOe_0EufouURu7R2@shell.armlinux.org.uk>
References: <20251009084416.45542-1-jjm2473@gmail.com>
 <20251009084416.45542-4-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009084416.45542-4-jjm2473@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 09, 2025 at 04:44:16PM +0800, Liangbin Lian wrote:
> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "input";
...
> +&gmac1 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "input";

I am fine with what is being proposed here, but I think this
clock_in_out property needs fixing. The description for it is thus:

  clock_in_out:
    description:
      For RGMII, it must be "input", means main clock(125MHz)
      is not sourced from SoC's PLL, but input from PHY.
      For RMII, "input" means PHY provides the reference clock(50MHz),
      "output" means GMAC provides the reference clock.
    $ref: /schemas/types.yaml#/definitions/string
    enum: [input, output]
    default: input

The problems that I have here are:

1) the description states that the only possible value for this when in
   RGMII mode is "input" which is reasonable, because it's due to the
   RGMII specification. The driver code is perfectly able to determine
   whether RGMII has been specified, and set bsp_priv->clock_input
   itself, relieving DT of this need.

2) bsp_priv->clock_input is only used in gmac_clk_enable() when calling
   the SoC specific set_clock_selection() method. Only RK3528, RK3576,
   and RK3588 populate this method. Every other SoC supported by this
   driver still requires the property:

        ret = of_property_read_string(dev->of_node, "clock_in_out", &strings);
        if (ret) {
                dev_err(dev, "Can not read property: clock_in_out.\n");
                bsp_priv->clock_input = true;
        } ...

  If one doesn't provide it, one gets an error print, which is not nice
  I note that the DT binding doesn't list this property as required, so
  the code is at odds with the binding.

  (I note that your Rockchip SoC is RK3568, which doesn't implement this
  method.)

So, taking both these points together, the code should not be printing
an error if "clock_in_out" is missing when either:

a) RGMII is being used (or maybe only when RMII is being used?)
b) the set_clock_selection() method is not present for the SoC variant.

With the driver fixed as indicated above, I then think clock_in_out in
your descriptions becomes unnecessary, and should be removed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

