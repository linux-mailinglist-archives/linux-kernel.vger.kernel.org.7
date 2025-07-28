Return-Path: <linux-kernel+bounces-747478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD8B13448
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059DC1711A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E621FF50;
	Mon, 28 Jul 2025 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxIuSDfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5F4C6C;
	Mon, 28 Jul 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681725; cv=none; b=ZTfqirRn+hN31nIH86EaTU802pxbu1SizVBj0/eCq3De6my6JFd715wlvT3RgRXOT0QPl0KjhR78MR66jK5m8P8tWEHVRkQIuDfLtAcdXeDTmjKyXeVSCbZnYBoHWcCqOgVlgTlwS6j51jTt+doA4gkSFwn02u5JfPv7ql4WfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681725; c=relaxed/simple;
	bh=pJXDyB+Im5tDUOmGE13Hrm0vZMGJ6T+h3gdz1qXk3ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAyAdyRg75tWcQGvWSb9VdTKL9hKRT3ke/tVEivD6hD6q8AKaqN+f0nFxR0g20aGTpEaWRkYVhZP4BEzaxmMMxz9I6Qk27YangCrEzJqQuvetuxM1UhHvshznOXApOPectMwug7VUKoJwTPeOdkc2RzM2+lbBeoeOiIMtzProSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxIuSDfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACF0C4CEE7;
	Mon, 28 Jul 2025 05:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681724;
	bh=pJXDyB+Im5tDUOmGE13Hrm0vZMGJ6T+h3gdz1qXk3ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxIuSDfPefwEX6gSwgSkfqbxNxRh59urZX8oQ3mUy26C49vhACphjDc2fTuk+4nln
	 6RwdbMtyeDmR6VFPr/vXOFJcw3T4xf06hJhKgc7WYMjbjZkaVyOf6QVP3r7JHS8UIw
	 WTvIrLxwrl9eQvm6Iume2TMFAt0Lg5rx3dqr2Di7RzkptPnmMP+acKVgPpFfHHkcvb
	 KkjZIT2YsRNXaqyL7bjBWKMjiNPGR3w0ynC8GyOWnq1WaZdkV0ryck7+EDgBXTg/tc
	 iYcNCpclpFgVkkKWpQbBi7FX9dklB/4YcYupsWxSQ7XEtiDG82ywUW1Q9DNTNvbXsu
	 8yZgUHFPQzJrw==
Date: Mon, 28 Jul 2025 07:48:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: rockchip: Add Radxa E24C
Message-ID: <20250728-splendid-oyster-of-nirvana-756cea@kuoka>
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250727144409.327740-3-jonas@kwiboo.se>

On Sun, Jul 27, 2025 at 02:44:02PM +0000, Jonas Karlman wrote:
> The Radxa E24C is a compact, high-performance network computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add devicetree binding documentation for the Radxa E24C.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


