Return-Path: <linux-kernel+bounces-872447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C8C1141A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 498C55634E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F232549E;
	Mon, 27 Oct 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB2wAqAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC628682;
	Mon, 27 Oct 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593634; cv=none; b=sH1vwxycCjLulcW09sWnFkP7T8jOe2kAxPb6hVgfPsxfZnu6RtDbh77vTH2l2278H85o9Sog0mxtgY3ZGyBIk/LXncVQCfIL1IYcV+bzhOzprGNShfxmJscsZEEaKqZeQHVUNO7+MhTyRf+tm1p2oPoxsFWKlrEtqxub8tkfd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593634; c=relaxed/simple;
	bh=GBuTHku0HZy+N4bLq8h+zIHugchhObZYaWI/ZaqLViI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQH54mI6ab5oJT8DWDlkrF5cCziKSfxzZKvU3Q54zoxFqj2H0/ALk6Mei8y0VhVjmxtCAn+xkbKaLMhbi0ZygkqTRpdbqnGBOfJNDIjwpeuWeKLrToxIm/hVQVlr9/hdShkQFCMxbcXREYi3+F3WXr1yACh+pRCWxeb45Jy0ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB2wAqAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A5C4CEFD;
	Mon, 27 Oct 2025 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593634;
	bh=GBuTHku0HZy+N4bLq8h+zIHugchhObZYaWI/ZaqLViI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2wAqAXCd/BB8/BunSqi7t8cuGIdnwMtSgaxpuj9p59XOiO31MeOL5zM6ifVnaV4
	 iuefubtyNvSxYAwTvkUqis4tKHehdEQQrq+lrA9ebAKQdR35IBWt8ReFf2UUAiJQGj
	 ykqic2i6CR6itbn9zTBbYqjLO4YJAQkAxTVw8ao39GzzAJXGIh/WajnI7x7A9REZNd
	 tXcFYm6NoY7SrLpu6wXXdPoUle/k9xXO+mnqaHpYAgHVsKzApXvfeGA59TAaKiGiAw
	 fIOLe7G557DyFoPl/tLx/MjdFdN0SF6i+nu8D9igcCv4lxbqmyyYLlAAJMQQlG9QEc
	 xxXSDeMBK008A==
Date: Mon, 27 Oct 2025 14:33:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add NineTripod X3568
 series
Message-ID: <176159363059.1460567.9335053361524523986.robh@kernel.org>
References: <20251026150358.1078453-1-coiaprant@gmail.com>
 <20251026150358.1078453-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026150358.1078453-2-coiaprant@gmail.com>


On Sun, 26 Oct 2025 23:03:57 +0800, Coia Prant wrote:
> This documents NineTripod X3568 v4 which is a SBC based on RK3568 SoC.
> 
> Link: http://www.9tripod.com/showpro.php?id=117
> Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


