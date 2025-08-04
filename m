Return-Path: <linux-kernel+bounces-755545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6DB1A836
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8818A4671
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256528A707;
	Mon,  4 Aug 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CpdMgMYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9728E3F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326452; cv=none; b=FU/jCRIoIyipqMVzm/3sqptJ7YMQ7wJ9lIyvuwSsY2fRwf99cYpGa3KwOEm43ue+8OefLWP/yF5VEqYqXQI5ZIVzFtB5c2YeKz20mYqTDcpJLPpKz1X852oDPSB5d8HC95w2Sy4CV4IOugsou31j8PI+9g8gzfrrZ5n6gizj8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326452; c=relaxed/simple;
	bh=CudL45l0Pse44c1AWtPvzMCBT3mMU7C0Tba4q5ADjkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgMrmnUQ84bxunmy4B1K1TlFptHSVx2c/MnRjh14lQOl0kQJAHGCEqHcGHOYCzfa0koT4959du2/oI/ml5PW405aVnDEh3mvZ+0x14HkrR770jGOobroZOGKHUUyy2cXN7Vrla4lkm5rAzD1YtPd5cML1s+Qa7GCXTU+LUH7mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CpdMgMYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA20DC4CEE7;
	Mon,  4 Aug 2025 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754326452;
	bh=CudL45l0Pse44c1AWtPvzMCBT3mMU7C0Tba4q5ADjkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpdMgMYXLj5HKIK027TIEuQRRcrTkzLEzzhyHpiOH1CsAsb9ELp6kh9dRxh3euqrN
	 8KhUBImlL/kz2rF0IaJ1OY8kQMW9L1aypci8vMmwCtm4G9vjPVyyf92M6ziXJmZ1s3
	 rTm6kKzBupzQPXNB+jVCCmHr5yckgvTg8tHCuKGk=
Date: Mon, 4 Aug 2025 17:54:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: core: Drop device reference after usage in
 get_channel()
Message-ID: <2025080442-devotedly-bubbly-cdb6@gregkh>
References: <20250804082955.3621026-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804082955.3621026-1-linmq006@gmail.com>

On Mon, Aug 04, 2025 at 12:29:55PM +0400, Miaoqian Lin wrote:
> In get_channel(), the reference obtained by bus_find_device_by_name()
> was dropped via put_device() before accessing the device's driver data
> Move put_device() after usage to avoid potential issues.
> 
> Fixes: 2485055394be ("staging: most: core: drop device reference")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/most/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/most/core.c b/drivers/most/core.c
> index a635d5082ebb..da319d108ea1 100644
> --- a/drivers/most/core.c
> +++ b/drivers/most/core.c
> @@ -538,8 +538,8 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
>  	dev = bus_find_device_by_name(&mostbus, NULL, mdev);
>  	if (!dev)
>  		return NULL;
> -	put_device(dev);
>  	iface = dev_get_drvdata(dev);
> +	put_device(dev);
>  	list_for_each_entry_safe(c, tmp, &iface->p->channel_list, list) {
>  		if (!strcmp(dev_name(&c->dev), mdev_ch))
>  			return c;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

