Return-Path: <linux-kernel+bounces-744777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDDB110B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137E97B9F50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443F2ECD1B;
	Thu, 24 Jul 2025 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="avBZvZL1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94F54723;
	Thu, 24 Jul 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381025; cv=none; b=flC64QoQRQM2HPYXWP6WEaZ4XZX51qjt4bj43JCTKp6ee2y38QhAt+sblE9Cc4sZBOXo8iP98SPhLx9PaR4SbueG2964lJJXWv88/jgpUVx45Efh2i8Uald/kM8llMN3Sj+Un2sKNcPZxGoRb2z9xk1ibk3TVqQ3mg7T+bfl8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381025; c=relaxed/simple;
	bh=kYMchTNuGPZOGekFX6yYx/jvmFhFEmukhYxUmiScl40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+r9LcXtVbD2sLeL+lX1+ZxYoYT5YmiE5TDL6RoL9ibFY5/hkLfXmmg7on/SQmDhGLaNluVP3RQ2pLtvxogE3O/SRTz414RkkADCvtD7mRa73b3MC2Ly7981DGpQ06+BfKmGsz+XHuU1u2TYeUZDhFv7AEPCUZwngl80ek/H9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=avBZvZL1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pEENey2w1cevs1tsnGhBook0OChKHoGcDIcOjH49bFg=; b=avBZvZL1MdJUmnRVPUQVLk5c1y
	WnCZeQ5XDg46LFMptIFRUSvqaHiOB7dg+AaSfB13F6iJUMFVLVFcsRvTnpXOk9+dOXeAMvMURNeKW
	rN0QXkDD7Smay2gdCecIvRSTA4a2fW+VCRcXjXZKF+fO4LA3Mc5BuQYDhfUesfazbL4FyD1feGoaZ
	GNUzgGtt6aa4+byLy9PEhgHifFi8lgmNg+OMyhzzSpzl8SAQcc4JI3YC8GPD+S3az5BWMAL/s9HIc
	C3wGAeGY80Aia4gni0S4mmJlxczAQHR3J+7V7jdCO0ZYYRJ3QTp+dGcQ7xor+o2vyuGeY54I6Y1lr
	p3k5STpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uf0Uy-0003f4-0Q;
	Thu, 24 Jul 2025 19:16:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uf0Uv-0000ww-2a;
	Thu, 24 Jul 2025 19:16:53 +0100
Date: Thu, 24 Jul 2025 19:16:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
Message-ID: <aIJ4lZgfTiNmHaXF@shell.armlinux.org.uk>
References: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 04:31:25PM +0200, Sebastian Reichel wrote:
> According to the Ethernet controller device tree binding "rgmii-id"
> means, that the PCB does not have extra long lines to add the required
> delays. This is indeed the case for the ROCK 4D.
> 
> The problem is, that the Rockchip MAC Linux driver interprets the
> interface type differently and abuses the information to configure
> RX and TX delays in the MAC using (vendor) properties 'rx_delay' and
> 'tx_delay'.
> 
> When Detlev Casanova upstreamed the ROCK 4D device tree, he used the
> correct description for the board ("rgmii-id"). This results in no delays
> being configured in the MAC. At the same time the PHY will provide
> some delays.

So why can't the MAC be fixed to conform to the requirements that are
well documented for RGMII?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

