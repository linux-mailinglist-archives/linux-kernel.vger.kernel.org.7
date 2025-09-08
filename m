Return-Path: <linux-kernel+bounces-805346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D3B48761
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BB91887E06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9727AC5C;
	Mon,  8 Sep 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7o0TxS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4991531C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320792; cv=none; b=eB1BCghMMNYgBFB7P0hnBeUd3H0P9ABP1zYMPHZfRF+oRWOvJXDy90qUiJUi0bb0LS+8vroV6FGvqAESwGlihUn2LDK2/TN+fBXkeRCacn9nH3oVnXjqlQhLZcVxQPGwaxR3+4vFcK/DsNgwAYTT3ch2wM2X0mFwBHmxOnlARTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320792; c=relaxed/simple;
	bh=KkCnrtHF6ChEI9N/28CbZ7v5UfJS88AZj6T3uigboOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO3kExdE+3SDqmdQb1qvDztAkoFjor+4idwFrFdtZu31SH7me0fffM5QoVW46OY6VPZmeur+q683l+5ZbVlmhN+/9Ev0DsYjZd5P8AD8gS7QOKz6/FttXeYFfl6u8VTyEYxNysiUqCqCV5Rrx5f7JvDfm6eWWkovXepbguS0Apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7o0TxS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78167C4CEF1;
	Mon,  8 Sep 2025 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320791;
	bh=KkCnrtHF6ChEI9N/28CbZ7v5UfJS88AZj6T3uigboOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7o0TxS5I0zZKoyfYdSdbEOiyt0P3N6e2YHCS/I7704BatJyVLRMLePl2ulakGvE4
	 SIDijrqrveHMSETYWINN7rcCxOiKNlyWnZnBNFHX8BCYjWx42vM+GUbQfTehVU0XaF
	 2a4vsKWlQpK1iwG1rQ4ZyzxdvxhlgtBk5U4B0wlD9dTy67UuqL8PlGG1ymOWdckjzH
	 oWDK6yryqdgyz28ZvNDOam9dJNgyhdATsywj5XMLlIGiD0Ova59W5wWM/71F5xGon2
	 FJkWNtxaCmbAYyZ18vqi8Pq3KwQhKpQXSXioL23OS+ZCG+pM4ZXbfahSG0aU7j6ppK
	 YsnmkcB/nA8UA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvXPi-000000008N4-2AIF;
	Mon, 08 Sep 2025 10:39:51 +0200
Date: Mon, 8 Sep 2025 10:39:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Carlo Caione <ccaione@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: firmware: meson-sm: fix compile-test default
Message-ID: <aL6WVp10hET2-fql@hovoldconsulting.com>
References: <20250725075429.10056-1-johan@kernel.org>
 <4eacd669-9967-4ad7-a3a6-d124477100fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eacd669-9967-4ad7-a3a6-d124477100fe@linaro.org>

Hi Neil,

On Mon, Jul 28, 2025 at 05:42:00PM +0200, Neil Armstrong wrote:
> On 25/07/2025 09:54, Johan Hovold wrote:
> > Enabling compile testing should not enable every individual driver (we
> > have "allyesconfig" for that).
> > 
> > Fixes: 4a434abc40d2 ("firmware: meson-sm: enable build as module")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >   drivers/firmware/meson/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
> > index f2fdd3756648..179f5d46d8dd 100644
> > --- a/drivers/firmware/meson/Kconfig
> > +++ b/drivers/firmware/meson/Kconfig
> > @@ -5,7 +5,7 @@
> >   config MESON_SM
> >   	tristate "Amlogic Secure Monitor driver"
> >   	depends on ARCH_MESON || COMPILE_TEST
> > -	default y
> > +	default ARCH_MESON
> >   	depends on ARM64_4K_PAGES
> >   	help
> >   	  Say y here to enable the Amlogic secure monitor driver
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Could you pick this one up for 6.18 as well?

I noticed that there's a duplicate "firmware: " in Subject, perhaps you
can fix that up when applying?

Johan

