Return-Path: <linux-kernel+bounces-782214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC7B31CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E2B1C84796
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C923126C1;
	Fri, 22 Aug 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4YRcrn7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D43126AB;
	Fri, 22 Aug 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874123; cv=none; b=RRFYjCG0QtUsMR2fjVxvSbnIWHmkz0v2LwKS5u734f2Y8eMrsXF/jBLpybMTeiMBQQi3YLalNGtk4cmzPTkcozfq5aq8W1VzowdkNY20aPdDGw/qkTByuLtl209rfN2t0V6xvfDE+gQyXBvQz0MGWfr9OkFhz2OG6Zmut3YUUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874123; c=relaxed/simple;
	bh=ooHxYeuqSlm0Lf7mTP8oPP3GNMH5wQGxRznp5cQihXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cyn/bXFkBQAt/OHYW3CVahFTsh5nezkooJgfYEZyrgJEpWXU5w8CHJJ5H7Q+2jd1WQicXDxmobPqsK1pfmODPhaMZC6yIPr5hX3kTC1PHxn6fe/O7VW5PgV6/7AR/M+7USyQKhtHziKyTeaX2q95iHRPJlssZfBOKNnxthwrR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4YRcrn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C6FC4CEED;
	Fri, 22 Aug 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874122;
	bh=ooHxYeuqSlm0Lf7mTP8oPP3GNMH5wQGxRznp5cQihXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4YRcrn7MAkBEsW92XCJqFP0QJf2758UgsZPB/3N2tnPDuIJ02iRgH0kP6qkiN6X7
	 vzPknftZUjtwtZURBWtOkdnvupxFjYIgPcFz1ZTmxdPwhHGHB3uKU0ijlG19Y4X1Io
	 lBhQZhI6440fN316kLn06tsLLkSksK+bSP5AjzlLnU6A/ZM1S7yGPhN9Pe/zoegCfK
	 t1r+OF5KZWh37SexS82xmytQxZZ0cwnNuBGc+n7ZsxoU7MF53+4XUVqiY+KgkthLQ/
	 SVvkhzz2StS7ISJqLqRXQgvIFLJcUIUr69TNMlEZYRFDmj9asKpIreCP20oU4ncsHO
	 pTeNBPGHQg7Fw==
Date: Fri, 22 Aug 2025 09:48:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-kernel@vger.kernel.org, Arnaud Vrac <avrac@freebox.fr>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Jonas Karlman <jonas@kwiboo.se>, Sandy Huang <hjc@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	linux-rockchip@lists.infradead.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: display: rockchip,dw-mipi-dsi:
 Narrow clocks for rockchip,rk3288-mipi-dsi
Message-ID: <175587411947.3790873.4860739653450800146.robh@kernel.org>
References: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
 <20250820-dt-bindings-display-v2-3-91e2ccba3d4e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-dt-bindings-display-v2-3-91e2ccba3d4e@linaro.org>


On Wed, 20 Aug 2025 16:17:38 +0200, Krzysztof Kozlowski wrote:
> The binding allows in top-level from one to four clocks and each variant
> narrows the choice, but rockchip,rk3288-mipi-dsi missed the minItems.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Fix subject typo
> 2. Rb tag
> ---
>  .../devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


