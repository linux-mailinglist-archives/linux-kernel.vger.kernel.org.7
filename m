Return-Path: <linux-kernel+bounces-747852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843AB13921
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D93A3ADFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA692472B0;
	Mon, 28 Jul 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htMwnKWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB83596E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699212; cv=none; b=A0nVi0CUs2RRUOjx5maVQ7NichFnCNpkb7ashJtUAJxzv6bUZxsQEndBHOK0cdYG40O+q84Q8GMnMpIZUtEqw+8lK22NdEKw0CW4OycZTytsBBbb+YDPg1GKvP2nlgNwGtVI83B1JSO2KQq962zXyJWHi/dcffpYDTvCNjXPIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699212; c=relaxed/simple;
	bh=OmxutnyifGdMHXbLwlAlxjzG3ii/2q2pMTyzvPiwQbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmL852NrOi4cXRcBqFTkYVpVpQKAEgPxecfksSBfij/qWNu6gubYaWlNko8EFExJdHX89hZcsAoLzZJ12v2oULktwurJyffwTjr5Jbd74RYeJnYPHLp5EFB2aSXz49pT+fvLyYOWMl/kqbw5Fr/Njr+KbiAbp1tjRbPcYY4YwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=htMwnKWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96430C4CEF6;
	Mon, 28 Jul 2025 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753699212;
	bh=OmxutnyifGdMHXbLwlAlxjzG3ii/2q2pMTyzvPiwQbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htMwnKWes6ArQq+pBUlyRZnfw6mlewaLbRpu1gakrVMYM63flsZrE+RM9O7KiF5rl
	 /R+pYaeZdyAjRHYitwnxeieWfQGnsCV9n4x/7r7X0iGcp+D22+F0HZquN+5ORQucgY
	 UU2O3ExcWnf1xyc/UD5qcVoqfCKYpehoIOzTen7k=
Date: Mon, 28 Jul 2025 12:40:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: layouts: fix automatic module loading
Message-ID: <2025072801-kudos-dodge-5b3d@gregkh>
References: <20250728070726.292579-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728070726.292579-1-mwalle@kernel.org>

On Mon, Jul 28, 2025 at 09:07:26AM +0200, Michael Walle wrote:
> To support loading of a layout module automatically the MODALIAS
> variable in the uevent is needed. Add it.
> 
> Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I'm still not sure if the sysfs modalias file is required or not. It
> seems to work without it. I could't find any documentation about it.
> ---
>  drivers/nvmem/layouts.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index 65d39e19f6ec..f381ce1e84bd 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -45,11 +45,24 @@ static void nvmem_layout_bus_remove(struct device *dev)
>  	return drv->remove(layout);
>  }
>  
> +static int nvmem_layout_bus_uevent(const struct device *dev,
> +				   struct kobj_uevent_env *env)
> +{
> +	int ret;
> +
> +	ret = of_device_uevent_modalias(dev, env);
> +	if (ret != ENODEV)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct bus_type nvmem_layout_bus_type = {
>  	.name		= "nvmem-layout",
>  	.match		= nvmem_layout_bus_match,
>  	.probe		= nvmem_layout_bus_probe,
>  	.remove		= nvmem_layout_bus_remove,
> +	.uevent		= nvmem_layout_bus_uevent,
>  };
>  
>  int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
> -- 
> 2.39.5
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

