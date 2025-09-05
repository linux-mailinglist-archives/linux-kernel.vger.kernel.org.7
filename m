Return-Path: <linux-kernel+bounces-803209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83676B45C26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C7AA1DF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFD331B813;
	Fri,  5 Sep 2025 15:12:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B131B80B;
	Fri,  5 Sep 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085163; cv=none; b=MGisWiVKOI03Wl841t/uRCT7Hyc03gKsGbGBhrKgKvnzYZ9TRc7AuI8CRxC08Aox6HN7ej9hD8v+pI+mLIr83YjwnX2Obja69kbNseiL9psvLKjJY3a5CuKnBAO//R0E7I+za+z1g7SPi+RpQ9eWcy2RWEs+7ZQaITpVaj61xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085163; c=relaxed/simple;
	bh=/KX5luXYZW6HClpST7249EccgXx88bUyswNisMK+RJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRyaI04ACeCUDe796StuHqcK+IS4LXSmYcjk1t6a14CKubjCfEQwsPZKc8SqILBGY/pnhU01d0HFae3q1X+BXgTFF3iSWAida4DKM79MS32xUH5jrJ82H3pnJSv4p3zrom8iWh/5uiz/W9OT1siYBsKf4ioUyuP00tMF4O8RJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F49C152B;
	Fri,  5 Sep 2025 08:12:33 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7F93F6A8;
	Fri,  5 Sep 2025 08:12:39 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:12:36 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] clk: sunxi-ng: mp: Fix dual-divider clock rate
 readback
Message-ID: <20250905161236.51b6ecee@donnerap>
In-Reply-To: <20250830170901.1996227-4-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
	<20250830170901.1996227-4-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 01:08:56 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> When dual-divider clock support was introduced, the P divider offset was
> left out of the .recalc_rate readback function. This causes the clock
> rate to become bogus or even zero (possibly due to the P divider being
> 1, leading to a divide-by-zero).

Ah, a nice catch, thanks for that! Just curious, how did you find this?
The MMC clocks use the dual divider type as well, but I didn't observe
them being wrong?

Regardless:

> Fix this by incorporating the P divider offset into the calculation.
> 
> Fixes: 45717804b75e ("clk: sunxi-ng: mp: introduce dual-divider clock")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  drivers/clk/sunxi-ng/ccu_mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> index 354c981943b6..4221b1888b38 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.c
> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> @@ -185,7 +185,7 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
>  	p &= (1 << cmp->p.width) - 1;
>  
>  	if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
> -		rate = (parent_rate / p) / m;
> +		rate = (parent_rate / (p + cmp->p.offset)) / m;
>  	else
>  		rate = (parent_rate >> p) / m;
>  


