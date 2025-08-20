Return-Path: <linux-kernel+bounces-777544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508AB2DAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EC91C40253
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C02E427A;
	Wed, 20 Aug 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8K2+GYe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CC283FD6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688531; cv=none; b=tGdVKIO6cFtdP6ADKq93XpZucOBsY6zHRGP0mIfS0fQ0e80uaOFOmiHKQ+mvxODOt6Erd9/zZ4Pm4GOe7ePEC68mbB2d8ZO/DPcAq30qzbt5yb4lmSOOE05yeqTm7clC62yfJnxIl05NaJ+WKMzOSQRb+LhsoY47PSCEXsYJfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688531; c=relaxed/simple;
	bh=sIzdoOowe+HlGvxm+Jg3JfRGL1LFP9lqNqwaEjkbLbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTUsC2xKT+L/POysrmrePkVXkwIIEFp1ShsEgjsFg506vBBcfVYkM7VRQbDDY9nkjhLebPvJXoP6COp1YYCYgj2iS4ukVVDJZwALXSwwj4MEZTQ16rqSDjgeUOOoh32ZeQ57Vaa7a5wHKaJTcIzU8KDYgTUoXTcyClLssnkXuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x8K2+GYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74955C4CEEB;
	Wed, 20 Aug 2025 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755688530;
	bh=sIzdoOowe+HlGvxm+Jg3JfRGL1LFP9lqNqwaEjkbLbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x8K2+GYeJmqXFruD2Xd8y4xwh7RuSQIJiZW7lPua2WjOKVZQPEB6HM3RNL7/ktvlO
	 aJFVecE/K1WQSyDeEBnwExyS+aZ/RRCd0Xk7EAwztQWByxgksJAc40tsQmRx8PSZzr
	 BksIJjmbtYIXpEkFuGjSRD22Ab0aQ6c5/l0bE9z4=
Date: Wed, 20 Aug 2025 13:15:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: ad525x_dpot: Use str_enabled_disabled() in
 sysfs_show_reg()
Message-ID: <2025082052-crawfish-revisable-7965@gregkh>
References: <20250820102734.760844-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820102734.760844-2-thorsten.blum@linux.dev>

On Wed, Aug 20, 2025 at 12:27:34PM +0200, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function and silence the following Coccinelle/coccicheck warning
> reported by string_choices.cocci:
> 
>   opportunity for str_enabled_disabled(..)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/misc/ad525x_dpot.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
> index 756ef6912b5a..04683b981e54 100644
> --- a/drivers/misc/ad525x_dpot.c
> +++ b/drivers/misc/ad525x_dpot.c
> @@ -73,6 +73,7 @@
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  
>  #include "ad525x_dpot.h"
>  
> @@ -418,10 +419,8 @@ static ssize_t sysfs_show_reg(struct device *dev,
>  	s32 value;
>  
>  	if (reg & DPOT_ADDR_OTP_EN)
> -		return sprintf(buf, "%s\n",
> -			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask) ?
> -			"enabled" : "disabled");
> -
> +		return sprintf(buf, "%s\n", str_enabled_disabled(
> +			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask)));

If you are going to change this, might as well call sysfs_emit() as
well, right?

that way you get two coccicheck warnings at once :)

thanks,

greg k-h

