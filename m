Return-Path: <linux-kernel+bounces-744196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C4B10955
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE54169A45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940692741CF;
	Thu, 24 Jul 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ut3285aw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119023D291
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357075; cv=none; b=VLqa375Ob3b+8fsr5OtKiAM+PxVZaIs7aPQ1m2yeTj4NyC/9w3TaDd8EJv1Zpdv5RlHyxEEgPwShfgUN1Uqu5JkzLuQXflfTkLX741+6/7KqtIOw4eFanwb0n74Z8tjoCf/XkBIp41S8k9XYXYCX2IGF8JkyKV4HIgJuafLiYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357075; c=relaxed/simple;
	bh=vmAGaIruxx22XZqjTQi9lTZxbVP16Mvm0h4/t3XvvYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6405orlB0enU9IanJbkXTQStxxGNL28YHSbWs2928J/fVILtdXETdDA7onxitte75L2zPAGFsCPngxfmmghfhzm6a1W5bIDKXUbX82HX2mA7s5gr9OqYwJlyymY6XBvjicQwcu4a5JAedl4SyZrpQVN3NtDxIl7V26Y0vjr03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ut3285aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C97C4CEED;
	Thu, 24 Jul 2025 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753357074;
	bh=vmAGaIruxx22XZqjTQi9lTZxbVP16Mvm0h4/t3XvvYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ut3285awzMJr4FCibZdgC1n/qg+kQFcdnPIQgVWBi87OOUqAtdCjC0Fr25oes35t5
	 0yV7sYu3YBvpp5WAYtSeqtN3m+0XXAuI62zBEY0dppj6f0r7iVGo9Mb8xwA/gm2WxP
	 USyc2UQo1+21R9y7SukX3Qm7Yp0hlMzlXqebG6Mo=
Date: Thu, 24 Jul 2025 13:37:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Liya Huang <1425075683@qq.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/faux: Remove unnecessary match callback
Message-ID: <2025072430-spoilage-willing-6d5c@gregkh>
References: <tencent_5782606120514CBCC9339FD79EBC411FB607@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5782606120514CBCC9339FD79EBC411FB607@qq.com>

On Thu, Jul 24, 2025 at 06:37:23PM +0800, Liya Huang wrote:
> The faux_match() function always returns 1, indicating a successful match.
> The driver core function driver_match_device() already handles this case
> by defaulting to 1 if the bus->match callback is NULL.
> 
> The implementation in driver_match_device() is:
>   return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> 
> Therefore, the faux_match() callback is redundant and can be removed to
> simplify the code, with no change in functionality.
> 
> ---
> drivers/base/faux: Remove unnecessary match callback
> 
> The faux_match() function always returns 1, indicating a successful match.
> The driver core function driver_match_device() already handles this case
> by defaulting to 1 if the bus->match callback is NULL.
> 
> The implementation in driver_match_device() is:
>   return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> 
> Therefore, the faux_match() callback is redundant and can be removed to
> simplify the code, with no change in functionality.
> 
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
>  drivers/base/faux.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index f5fbda0a9a44bd8e4831ee0ef9fc87841146d2da..005e4ecac05aebccb6fcf770f7e62848d9963c88 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -33,12 +33,6 @@ static struct device faux_bus_root = {
>  	.init_name	= "faux",
>  };
>  
> -static int faux_match(struct device *dev, const struct device_driver *drv)
> -{
> -	/* Match always succeeds, we only have one driver */
> -	return 1;
> -}
> -
>  static int faux_probe(struct device *dev)
>  {
>  	struct faux_object *faux_obj = to_faux_object(dev);
> @@ -77,7 +71,6 @@ static void faux_remove(struct device *dev)
>  
>  static const struct bus_type faux_bus_type = {
>  	.name		= "faux",
> -	.match		= faux_match,

Let's leave this please, it makes things more "obvious" as to what is
going on and isn't hurting anything.

thanks,

greg k-h

