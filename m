Return-Path: <linux-kernel+bounces-722339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B420AFD856
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3F188A887
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2323E334;
	Tue,  8 Jul 2025 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phQhR2+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D31D54E2;
	Tue,  8 Jul 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006182; cv=none; b=unLIfgjd1bjuHGofMGK7tSuCwk3K1bFCui9IaCmNQn6OXb9ABaBWapyDYZPSsLPW0FTRZT8FB+ktQVZ8gU3gcPK7Td4i+jE87otN9tFHAdpwLDeDrABbhcM1yKh6XEaFJZPKcuEQBbpfSKlRqyGCpqWquPcAn8vj7Zz+W/9aKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006182; c=relaxed/simple;
	bh=I2VRzsXmZPYGTLrr+78RCRNRi3ChbnEGC8YNwbiCV1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je/jMoAm1dLegdvb3qSdyVeBMaVgtVC9OgucIQD5VwxeCcwdnmf+1kt3m7kIpa5OaXqMWOgeg0DNWnTUSdTWg9HBhfx3u9yDnDZ/Fq/6PrkeUVcRx8ti1BtWvFHBIpPjKmZ6M4b2pbMO5xWTdoQUaYAuFSR08b482rczQWVISpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phQhR2+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A828CC4CEED;
	Tue,  8 Jul 2025 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752006182;
	bh=I2VRzsXmZPYGTLrr+78RCRNRi3ChbnEGC8YNwbiCV1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phQhR2+rN3jJSw6/t3qvVnB+m8wEVCacr/x7z9MWz0eialAWhnwTTJRifg3FZTmg4
	 s1EtyUdNX+IpxNr5AURU50vYdLsd3LOQDU8J0+FV1F+YHzsRFG2wP1mjvtP2p8IFYy
	 JzusohcspLPahKDUSDkl8Y4vm/dpIjcvbPkpyaijgculqpKppRdcs8LJxRG9qNIj4z
	 Kzgy8i5icVz3Wu7YhGmzZARtj002HNqiJ7A9qv/RsonbCjOzHnY4q5WpslnsHfQbSE
	 FJCjklhwuqxOBO/KyhfsyAjuelxSUO5oZ4b3EgmiY3dQIPftyEPlP1d8Ss+TB9o6Wt
	 rvJSl9qx/uYTA==
Date: Tue, 8 Jul 2025 15:22:59 -0500
From: Rob Herring <robh@kernel.org>
To: Paresh Bhagat <p-bhagat@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, praneeth@ti.com, kristo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, khasim@ti.com, v-singh1@ti.com,
	afd@ti.com, bb@ti.com, devarsht@ti.com, s-vadapalli@ti.com,
	andrew@lunn.ch
Subject: Re: [PATCH v7 3/4] arm64: dts: ti: Add pinctrl entries for AM62D2
 family of SoCs
Message-ID: <20250708202259.GA904737-robh@kernel.org>
References: <20250708085839.1498505-1-p-bhagat@ti.com>
 <20250708085839.1498505-4-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708085839.1498505-4-p-bhagat@ti.com>

On Tue, Jul 08, 2025 at 02:28:38PM +0530, Paresh Bhagat wrote:
> Update k3-pinctrl file to include pin definitions for AM62D2 family of
> SoCs.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index cac7cccc1112..0cf57179c974 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -63,6 +63,9 @@
>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> +#define AM62DX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define AM62DX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>  #define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))

Why is the same expression just repeated over and over? Looks like this 
needs some refactoring.


