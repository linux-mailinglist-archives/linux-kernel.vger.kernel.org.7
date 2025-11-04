Return-Path: <linux-kernel+bounces-884256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E840C2FBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDA3D34D431
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311C2951A7;
	Tue,  4 Nov 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARho0ulf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8C1F5435;
	Tue,  4 Nov 2025 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243267; cv=none; b=FLIc2wHCsAFMb8fKYClg63Xl47aKHF2p8LEwpDEPZwvoDhRWqV6ciI76XHeBMKYTgVOZ/BSaDYiK+9vS1cLGp0ERhwvCwV1khX/l/UgHzZNLVIzwLa3Ta1rWkT8oEVJg5ltXBUn3au2tNE8ddDPE+1IU3sk0uoxjJHQFry2w/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243267; c=relaxed/simple;
	bh=vGoIbPpz5aXIFdt5t3D5TrfQi3IlTuwBW7gh5GXbdIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgWrAF1YAzJqOtOWbX/O6hz0WwS7OGKKDj1Hw+w3RtHUscFB9YnIghhsPF6MTRYxq4HvQWAMtb2XkTdq+YpzIzRqNb3ADAX/EP5ibswHuLG6ZZClB3n5tqeP30ZuaMiDKS+7X5keNcXDiOby6tAZ1vIGBsz5ECIE0LGqeNY/N+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARho0ulf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496D4C4CEF7;
	Tue,  4 Nov 2025 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762243263;
	bh=vGoIbPpz5aXIFdt5t3D5TrfQi3IlTuwBW7gh5GXbdIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARho0ulfHfD0LwtnCerN/OpEB3PVm1rYxkXWFTUkQhZWvhyVzYc3kP9WyP1ETPi0R
	 InOd6nMfWxQ7YXQvvh6El2e3L5teEdnsUNZ3HGdhGMiRnqarqCJwCNs7UM8E2afdie
	 btRAIVXD0WretN6HLWRNFYT/r44Z7jyrs72Uw7N5KDniTx4gnFijmV3XMdxfxsIsb/
	 aQckCgwcevwcT9lcNazWocGkaYVjr6QrEujGifhHK7Rhu0hQtbtXWSjCKk0nLBco8Q
	 FxEZfuViU6MD1p38Vg5dti86FWEhUcCLmXha46F3CCK3AQYVNmLpNxj3E8ISriqrQD
	 CYROX95lHCfdA==
Date: Tue, 4 Nov 2025 09:01:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: rockchip: Add 9Tripod X3568
 series
Message-ID: <20251104-puma-of-undeniable-conversion-de00fb@kuoka>
References: <20251103171702.1518730-1-coiaprant@gmail.com>
 <20251103171702.1518730-3-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103171702.1518730-3-coiaprant@gmail.com>

On Tue, Nov 04, 2025 at 01:17:01AM +0800, Coia Prant wrote:
> This documents 9Tripod X3568 v4 which is a SBC based on RK3568 SoC.
> 
> Link: http://www.9tripod.com/showpro.php?id=117
> Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


