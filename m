Return-Path: <linux-kernel+bounces-785513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539BB34BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55AB481F64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52502882DE;
	Mon, 25 Aug 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mK8TnozM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1F8635C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153738; cv=none; b=g3b92NAFlh6P85bQ02mmfvEghwdrGHW26y8aBkl/K3bN8qtnfp5PDkEQOiLdfBkBtHxb0b6sqgXpH3zZJV0gfzbFcpJ4NBrm3GAPGPpRbxnGMVDBlw5b4mgD9NeIZTeloJTFGGrjC0wrQlwg/3Ng/yti9QzTuv7FoNvkwArSRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153738; c=relaxed/simple;
	bh=ComM35XaOofwnrs4E6SooCBJVLjt4r+F5uISZovHRbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=immi5tjHWA6cRm/kjl3m9ngmKqnLKxF3cy5mDYyKT0k+9oUuWsrQ137IHUQXpPCZbckgW79jKM4VxYX+R0XBgB6Ne1b5/6GL1eJkE1tSEjIbdU9mV6WnjR98lB8zMC03N7chkf0q+bWdC0vViuhhZN8tK+JGO/cpTmvUkLyB8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mK8TnozM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF3C4CEED;
	Mon, 25 Aug 2025 20:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756153737;
	bh=ComM35XaOofwnrs4E6SooCBJVLjt4r+F5uISZovHRbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mK8TnozMk+hiGthqg6YeyX5K9pIAYMFPVR75G238AJAo/HCD9a0QSWhpYZF+II6/+
	 GYnnrODQVztWLZDy50ntAhUkMwszDSRpzIeUdpj0fvCTUad/qcaM32Hh7FD8r22o/N
	 5t8SohtCCDesXq7etFZD551C6gCqYtprq5G6EeeE=
Date: Mon, 25 Aug 2025 22:28:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: xion.wang@mediatek.com
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, huadian.liu@mediatek.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Message-ID: <2025082533-ranked-simply-4b63@gregkh>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
 <20250825084556.10358-2-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825084556.10358-2-xion.wang@mediatek.com>

On Mon, Aug 25, 2025 at 04:45:47PM +0800, xion.wang@mediatek.com wrote:
> From: Xion Wang <xion.wang@mediatek.com>
> 
> When repeated calls to misc_register() or misc_deregister() on the
> same miscdevice could lead to kernel crashes or misc_list corruption due to
> multiple INIT_LIST_HEAD or list_del operations on the same list node.
> 
> This patch improves the robustness of the misc device driver by preventing
> both double registration and double deregistration of miscdevice instances.
> 
> Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> ---
>  drivers/char/misc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 558302a64dd9..2f8666312966 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -210,6 +210,9 @@ int misc_register(struct miscdevice *misc)
>  	int err = 0;
>  	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
>  
> +	if (WARN_ON(misc->this_device))
> +		return -EEXIST;

You just crashed the kernel if this ever triggers (remember when
panic-on-warn is set)

So please, if this can happen, properly handle it.

> +
>  	INIT_LIST_HEAD(&misc->list);
>  
>  	mutex_lock(&misc_mtx);
> @@ -251,6 +254,7 @@ int misc_register(struct miscdevice *misc)
>  			misc->minor = MISC_DYNAMIC_MINOR;
>  		}
>  		err = PTR_ERR(misc->this_device);
> +		misc->this_device = NULL;
>  		goto out;
>  	}
>  
> @@ -275,12 +279,13 @@ EXPORT_SYMBOL(misc_register);
>  
>  void misc_deregister(struct miscdevice *misc)
>  {
> -	if (WARN_ON(list_empty(&misc->list)))
> +	if (WARN_ON(!misc->this_device))
>  		return;
>  
>  	mutex_lock(&misc_mtx);
>  	list_del(&misc->list);
>  	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
> +	misc->this_device = NULL;

You are overloading the pointer here to mean something, please don't.

Again, why would this ever happen?  What in-tree driver does this?

thanks,

greg k-h

