Return-Path: <linux-kernel+bounces-725142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D856BAFFB40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6113A8782
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DC28B4E2;
	Thu, 10 Jul 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBHM3Wxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AF4A23;
	Thu, 10 Jul 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133555; cv=none; b=UNUahmZeNtAX6FGxAyCOReXJIb/yTdKkqMD9PtA9u19wWSYMTg+HX9y0lisCCNOezLiM0U8mtugjEqXP1uYeoapEW2wVPm+bil3JnfpcHvGKjgihFJ6HcnuD1A+U4aqUmseveYrJ5v2diU3Cc0ovYOAw7saa+coWYL9/1O0F8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133555; c=relaxed/simple;
	bh=YByCcDpGBTUYHamBUKc3M6t0s4XO0wxpUY0SsNzyjMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6nOnda482mRhKYrFAy6qv3PuuUH0tWvXnaZLVNlusYjYJzJzo88hLvnpsqeBalbSJXivmiLJDeqP0etb7sv6BmBkb+TYqyt/0bh9XnFv8bkUEA+WIV9ZSrdMq20d9CisBGvoQY4KNXcWvsiaAtVKHsW7mjoC5bNADBEp4jJOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBHM3Wxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE81C4CEE3;
	Thu, 10 Jul 2025 07:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133555;
	bh=YByCcDpGBTUYHamBUKc3M6t0s4XO0wxpUY0SsNzyjMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBHM3WxyGhIzbjSE1mVJBP0gy2s+B2OjBP/C8qXPff7gpG69oSJ+J6X6zPFOX1Xbx
	 4f6kjZu78sxO7Smh/TZxp6HX0+kGo6xMXQdnxLRvy2efDQzSlmHXgEqXI4xk0gYFar
	 O482hQdu1CsJc8y+nhxlHmfqdrpOdehNumAg9o3qnmmTtKb0I5CbhG2R9ArQ4lkgk0
	 8IinYrhbpgO2X9QmxRIXbeHYkRAKAhm+T7XVHVCPtN6fxiGERuPT56Ek6E2s+Ar5UJ
	 bs7NWK2TfEKI8BuQUSXUx7EjvzGlZjcgqh9CQqNwqqrJXLa/cXFHuTofNBh7dmv91N
	 TRMXs2BTpcW4A==
Date: Thu, 10 Jul 2025 13:15:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: compress_offload: tighten ioctl command number
 checks
Message-ID: <aG9vrq8kRqfigzgm@vaman>
References: <20250710063059.2683476-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710063059.2683476-1-arnd@kernel.org>

On 10-07-25, 08:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The snd_compr_ioctl() ignores the upper 24 bits of the ioctl command
> number and only compares the number of the ioctl command, which can
> cause unintended behavior if an application tries to use an unsupprted
> command that happens to have the same _IOC_NR() value.
> 
> Remove the truncation to the low bits and compare the entire ioctl
> command code like every other driver does.
> 
> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I could not find any indication on why this driver did this in
> the first place, it already was this way in the original commit
> back in 2011.

I guess I would have started from a bad template back then!
Thanks for fixing this

Acked-by: Vinod Koul <vkoul@kernel.org>
-- 
~Vinod

