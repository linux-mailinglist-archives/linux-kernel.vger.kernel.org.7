Return-Path: <linux-kernel+bounces-800147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7CB433FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E10F3A2043
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED029BDAD;
	Thu,  4 Sep 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBzro54a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BC29BD92;
	Thu,  4 Sep 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970994; cv=none; b=RmcQK2qWzC5mCsHhitcRdEIZrd2Sqr/fz8JlzkX3YoKKlDndz7rdpmh2tzlX+ahH+ZE/nAbiA59Pm+8L/mQPMZB9SCH2/mhKgV7NMAvYd9z1safB73UkiKDsV5LUCt5x5H9OvpF+1q+IiWs719ah3sa81ogJg9e3LGi0qJ3f59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970994; c=relaxed/simple;
	bh=eH8cDvd3H9MNJ1WHvOF2gG+uBWrtr7bwcPe6463npC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crAJ+EPhEvBEwJqGmIuXKpNA3Imr08sRkVCSyk07e45jJtPuN6GzLux7mA8O20S/OFTg9ls2mnlzg/lClVyLvMd/pktTG8cQIOFnTRfaMyh7D2Y58c93GXjL704HM8LCZfNaGjIk1NOi6BK2DRs/ECXb7k2S3obYxYMb22JgPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBzro54a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5A1C4CEF0;
	Thu,  4 Sep 2025 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970993;
	bh=eH8cDvd3H9MNJ1WHvOF2gG+uBWrtr7bwcPe6463npC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBzro54aaf5Bkj6Fbxh6cMvQqaTCuRaTOGYkgsZjs88yn5wB0CP/pUhDUewAQquvd
	 uvzDDDTu5+jqiPTGMR/wCNUPGiE6s6Ej6SLK7DHuh1JRphufwJde9wvPtscdqRlesz
	 XmwfWzkokpHts8S1ILk/97skW1ut5htRsl5FfL1O30ArsSzKgRsfS5HZjGkUfCDPy+
	 XelhXSCb6vQXwcyLZR0PuscvNABDMUOJ5hyQDZXh50KU0vku4FSiOQo3FfBgjVNhoi
	 TBtjXLVuN+ZZ4YUO/eW4DNYygkHgBlh2zwb+FwVnNgMRL5LGmdCG0SAycA8Dqldc8a
	 ouwRBhY9WmHOg==
Date: Thu, 4 Sep 2025 09:29:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Collabora Kernel Team <kernel@collabora.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
Message-ID: <20250904-space-swift-of-acumen-2fa4dc@kuoka>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
 <20250616-rk3588-csi-dphy-v4-3-a4f340a7f0cf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616-rk3588-csi-dphy-v4-3-a4f340a7f0cf@collabora.com>

On Wed, Sep 03, 2025 at 07:04:51PM +0200, Michael Riesch wrote:
> The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
> Add the variant and allow for the additional reset.
> 
> While at it, fix the description of the first reset in order to avoid
> confusion.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 50 +++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


