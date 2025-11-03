Return-Path: <linux-kernel+bounces-882312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE3C2A28C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75073AB537
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888028EA56;
	Mon,  3 Nov 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bt5enmgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4534D3A5;
	Mon,  3 Nov 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150861; cv=none; b=Bxux966oxN0/su1kni3VUzm1gmC6BXFSPPIXODaVMhaDH2k3xldwh+1bwE4Kgi1kkppWn8LCwGA1/pwm0LCoK0m4nU6kmRUPQvMblzajOGRe4rI/Bim/Ni1XgT8ZncveXTrDIYBh/DSGrtzPJp12Z/Pu6u7if9UPcD5WQyKG7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150861; c=relaxed/simple;
	bh=3oluBvHH0h8kKPf4YzZkXH4AKBNMaJ+LHhxbNQE8Fr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBPq7sR11JmpjuM2xYdv7pXqAe1RKDZ3TFXw+aJqeesuOCTwwDj1CblmTNlNw65+6FhogCMgN9Vi3/+8GuJ7XdAyHkbCGE4IIYz57ADBwmIsausDeUp/Vvm2P2lhOlsqe2suDdgYaraUsvHtp6Vc+ONxHYcSqovXfOWsJrU4Ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bt5enmgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D41FC4CEE7;
	Mon,  3 Nov 2025 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762150859;
	bh=3oluBvHH0h8kKPf4YzZkXH4AKBNMaJ+LHhxbNQE8Fr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bt5enmgYXPe/vFyIfEVvdj4yvMjyHwxBuPKg9JJtb986W55o/A9C28nt2bkG/OpBm
	 oCUTcXPz2bsRC7+FO5SQgrTfTJe+rO5V6UwovtD6+f4JWA9uWe/SnFPMi6Tkw9xuI/
	 ZmskcrfiVz+qlH9MJpkGauYF36KyH6oOS16knaVM=
Date: Mon, 3 Nov 2025 11:07:43 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: ux500: Fix PHY resource leak in error path
Message-ID: <2025110336-barrack-agent-b418@gregkh>
References: <20251103020204.796-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103020204.796-1-vulab@iscas.ac.cn>

On Mon, Nov 03, 2025 at 10:02:04AM +0800, Haotian Zhang wrote:
> The ux500_musb_init() function calls usb_get_phy() to obtain a PHY
> resource, but fails to release it with usb_put_phy() when
> usb_register_notifier() fails. This leads to a resource leak as the
> PHY reference count is not properly decremented.
> 
> Add usb_put_phy() call in the error path before returning to ensure
> the PHY resource is properly released when notifier registration fails.
> 
> Fixes: 0135522c4898 ("usb: musb: ux500: add otg notifier support")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/musb/ux500.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
> index 8c2a43d992f5..14c5e986937e 100644
> --- a/drivers/usb/musb/ux500.c
> +++ b/drivers/usb/musb/ux500.c
> @@ -155,6 +155,7 @@ static int ux500_musb_init(struct musb *musb)
>  	status = usb_register_notifier(musb->xceiv, &musb->nb);
>  	if (status < 0) {
>  		dev_dbg(musb->controller, "notification register failed\n");
> +		usb_put_phy(musb->xceiv);
>  		return status;
>  	}
>  
> -- 
> 2.50.1.windows.1
> 
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

