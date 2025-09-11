Return-Path: <linux-kernel+bounces-811342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3302B527C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DB71629FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD62367DA;
	Thu, 11 Sep 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRkcekVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C5329F3C;
	Thu, 11 Sep 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565381; cv=none; b=m54IuPdOzfqIRImgzoUyqwm9mVTBtlnbM/Fq3E5Skc1C1uBKsPWvCh9vMk9Tge8jjf38vMHqiwbM732Wagui2/3MORjHWGyBIjqmMtxUlIvJf4KI3mw7REG6ZOIrviu8OdUOsPB8Z9hXcG6hbChCTl6yRO5z43Fs0ujfnwbZJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565381; c=relaxed/simple;
	bh=ZgftlexC7m0f7G9tB59+CtBtIlpZM1B//E5L2IXaVTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFsvIlHZ3hqX17skTXH7kcqTD2PBKG2e3UG+nqQfVOcN7w36vYF0OD8mk+Hoa9t+KOVULTgEhkgTeUuOAsTUwvY6m2nYREgi9bj4f5FSM3eN5qRDNyzskLfGwUGdN7L83pT86mMl/doJiKSCa+Zbg5odPIbqV2z9oRlDHqO2zDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRkcekVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAB8C4CEF1;
	Thu, 11 Sep 2025 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757565380;
	bh=ZgftlexC7m0f7G9tB59+CtBtIlpZM1B//E5L2IXaVTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRkcekVRHWqQcu29cLjnza7mjmFYeioVBFoZ4C2HaBoRqNuyBVZbDyqt4Mtp98RIi
	 yg5PkRkr3lcW9/XzDtiK4FKRSu6RzVuD7U5bu6XXZ72WbqkejhRlEiJKcts1oHeGjn
	 PO0zVs+Kn7Q2MGgubGvhhlaQDoLNrsHGaM/WGjooetq54WOyoY01TXI2daU4dPDCfx
	 +7ps5yf4qQncVWIrZ8cwSFiI0xwtm+LKFU1h7XiW9QeBQeCD+n77uzahLq8zk1pgi+
	 +5V1fJ3tA6NUaU9HLKMyeVGYPvPXRdg31VxdpMhkD9GmrTSGa7Lt2AREADvZZHKvY5
	 AUSqnBPIrc+AA==
Date: Thu, 11 Sep 2025 10:06:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Collabora Kernel Team <kernel@collabora.com>,
	Michael Riesch <michael.riesch@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, stable@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 0/7] phy: rockchip:
 phy-rockchip-inno-csidphy: add support for rk3588 variant
Message-ID: <aMJRwENKCuNQKbYC@vaman>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
 <175752285211.484319.18097786132863236205.b4-ty@kernel.org>
 <2070639.PIDvDuAF1L@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2070639.PIDvDuAF1L@diego>


Hi Heiko,

On 10-09-25, 21:21, Heiko Stübner wrote:
> Hi Vinod,
> 
> Am Mittwoch, 10. September 2025, 18:47:32 Mitteleuropäische Sommerzeit schrieb Vinod Koul:
> > 
> > On Wed, 03 Sep 2025 19:04:48 +0200, Michael Riesch wrote:
> > > Habidere,
> > > 
> > > The Rockchip RK3588 features two MIPI CSI-2 DPHYs (not to be confused with
> > > the two combo MIPI DSI/CSI CPHY/DPHY blocks). The CSI-2 DPHYs can be
> > > supported using the existing phy-rockchip-inno-csidphy driver, the notable
> > > differences being
> > >  - the control bits in the GRF
> > >  - the additional reset line
> > > This patch series adds support for this variant.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-required
> >       commit: c254815b02673cc77a84103c4c0d6197bd90c0ef
> > [3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add rk3588 variant
> >       commit: 5072b8e98eef4685a5a9a8bae56072cb65a2ef69
> > [4/7] phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0
> >       commit: 8c7c19466c854fa86b82d2148eaa9bf0e6531423
> > [5/7] phy: rockchip: phy-rockchip-inno-csidphy: allow for different reset lines
> >       commit: 260435153c90c8e90553e456ec43578834a14a71
> 
> question, what happened to patch 6?
>   [PATCH v4 6/7] phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 variant
> 
> or is it just missing from this mail?

Looks like I missed, picked now

-- 
~Vinod

