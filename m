Return-Path: <linux-kernel+bounces-886934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77BC36B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37A7B34ED67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6DF32E722;
	Wed,  5 Nov 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ww/jUTnM"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100D2F363B;
	Wed,  5 Nov 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360541; cv=none; b=roYCz6teaiJxirx4/rXlTv+tzBVzRVHLQuIPnRpoJCxqplTM/A25ZkhbBtfZUHLE4HoCu3aOcvVZl6PTzkVhWGGRLKTHUcD7BsW3eEdYVOpPrC5o7j95dEFfBKR3rloZrxZJljX4HXsLcQrN5n5ORHsW9JzlE/6u9+2UYhBtMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360541; c=relaxed/simple;
	bh=cvkf4Z24dGLtOVRrUGkvl/a6n2HzBas3u1Y7OuVpAms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkZPpjaXarT4w43x0h5iugTJHDCYoyJSPNCp+uw7ANoFZh7o/rlS6E8HvZKSRG09CxR7wpYC7+eRqDfs0nZZbjIZzJuEqNyEf65GW/e+FyE+r0GBsURVI4nndQa59fDIy6H2LY8Shmfs2pDuVZKAE+h9NBLqoKw4TJ2cznvvNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ww/jUTnM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3F9801FA8E;
	Wed,  5 Nov 2025 17:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762360529;
	bh=LBtzWzncUCLW7jgIRibI+FmsMWik6VfyN9D1TSUtg8g=; h=From:To:Subject;
	b=ww/jUTnM93ycCzKIUYzW87oCShpcjIpKHFikyIeIZ+JW8Wwb/trOoD4msQns12CvY
	 lIU6OT6M1zRM8JFfOOj5LMHxTmdYi4XnuRnCFpFoeczX5rxdyUWrSx24GFILnXEI1I
	 4L3jRexsthSMuF7LhIESEAvItg5meLMNwJ10itkO2iL0OsjiRSoRjFzPW4y+jcMfli
	 npRvr1XCXp4Rhr81TDZ9Mm5iPQxjobmb2SdWzVdBq5MxXILpRufsdc66xF15YdXEro
	 kvRwbbEp8PShz/TgdwXozOO5iKzctm40Ina5/Hf3cRZL4o+RTz5/frJ2+98KSJovIG
	 K7qrsvT7GTpww==
Date: Wed, 5 Nov 2025 17:35:24 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
Message-ID: <20251105163524.GA18927@francesco-nb>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025073802.1790437-1-s-vadapalli@ti.com>

On Sat, Oct 25, 2025 at 01:07:59PM +0530, Siddharth Vadapalli wrote:
> The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G and
> CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. This
> correction has been implemented/enforced by the updates to:
> a) Device-Tree binding for CPSW [0]
> b) Driver for CPSW [1]
> c) Driver for CPSW MAC Port's GMII [2]
> 
> To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
> 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
> 'rgmii-id'.
> 
> [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example")
> [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
> [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII ID setting")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62P

Verdin AM62 is the same regarding ethernet, so I expect no issue also
there.

Francesco


