Return-Path: <linux-kernel+bounces-757636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FFB1C48F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325A118A82FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F71F874C;
	Wed,  6 Aug 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKGApy0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A325F78F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477660; cv=none; b=ZhBDwxjyT4zENRVLpPpilQ0zsOqsFGrC9W884cfS5vJCfoHhZooYgGzLN6c8RzyBJRa4bm7BOdaYMMoBfUGDBfLKgMuaRk1XrE71/v2BpRHU6knmM2uH+J/5ao8mmjoAvidSY9D8oJgppWli9iHiwRdBBEWbgNTk/xUeNQM6GHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477660; c=relaxed/simple;
	bh=i2uI+lUBfjiSG+v9KMFT8zJfDvUFVH+PsQfODjy3ias=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjg2Jf0+lPn6w8p9JvdrnFlVt5wO1LEpboxPa02olhz37r+atqWFizw6NV0Yskh/l4vpdhWpuy3UP5PChrYrvqZ2J8CwtVEuPqxdtp8LLOdqGk2Mjjky/GUG0bp76a/pckyNFjyLU3jCIwAHvI6bFvrkxjk/26VojqnF0+287XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKGApy0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0120C4CEE7;
	Wed,  6 Aug 2025 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754477660;
	bh=i2uI+lUBfjiSG+v9KMFT8zJfDvUFVH+PsQfODjy3ias=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKGApy0lewt7v918KB25guqvipI+Nz5f2IgnqBt6dnZVP1TaS7PhzA98LjNkDbC0X
	 gO1+GGthaP/bwlVW48oUqO7M71/s8nUQ82LzuVXYf+kjvjwNfFWOtmPKzm8kV3ZFuv
	 GEUoBoenKV/oTkp4DrH0kM5BXx/E1rpMS4iRpwTO05iV+lBwfGv/D+hvAOAo/n/XhX
	 9Gf2rp22cND8P9EZ+DF1zGo4ZjssN6zXYaPbaKjeYvFEYl3hdakuVY4Ba+FNa011Iz
	 zNZRFGeZQo/MRktAZxlcLfCxZxDEG7jTURd1aCfP/pGvwTIM38BZlE4FIsNy1+A7Bp
	 q3O2y8WeHhpaw==
Date: Wed, 6 Aug 2025 16:24:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH 0/2] phy: cdns-dphy: hs-clk improvement and a cleanup
Message-ID: <aJM0WPVDUkte9E_D@vaman>
References: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
 <cc0e4cf5-1bd9-4ae3-a130-0483dbfc6335@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc0e4cf5-1bd9-4ae3-a130-0483dbfc6335@ideasonboard.com>

On 05-08-25, 15:03, Tomi Valkeinen wrote:
> Hi Vinod, Kishon,
> 
> On 23/07/2025 13:01, Tomi Valkeinen wrote:
> > A cdns-dphy improvement to return the actual hs clock rate, and a
> > cleanup to remove leftover code.
> > 
> > These were part of a Cadence DSI series:
> > 
> > https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02%40ideasonboard.com/
> > 
> > but are now separately here for easier merging.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
> > Tomi Valkeinen (2):
> >       phy: cdns-dphy: Store hs_clk_rate and return it
> >       phy: cdns-dphy: Remove leftover code
> > 
> >  drivers/phy/cadence/cdns-dphy.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> > ---
> > base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> > change-id: 20250723-cdns-dphy-hs-clk-rate-fix-a8857a5789dd
> 
> Is this good to merge, and if so, do you have any estimate when? While
> this is independent from the DSI series, I'd rather push the DSI series
> into drm-misc about the same time, so both would appear in linux-next
> relatively together.

I will start taking patches after merge window closes next monday, so
next week should be a good estimate

-- 
~Vinod

