Return-Path: <linux-kernel+bounces-739446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA14B0C663
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B552163B19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC982D3742;
	Mon, 21 Jul 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKTBF8YR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B680B67A;
	Mon, 21 Jul 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108290; cv=none; b=OZIpbOPpgMOc8KFHxg1x5leZcolrPRlPa6IT7sLq0EDD7/m1Ei8rcgou9xNmwQhnhwT+O9M/MX8ZuAg2X55MvxmhkVlPQkoX95mRW59tQ5LkJMAsEBIOkY+7I43EBvmFbAyytK55CjFdjNgeRhhS+4N2PFJ38OEUxP/hYMJBOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108290; c=relaxed/simple;
	bh=nv7c53HMZGXsVbbUK5FVFqqjDWQv5W/iS1kBfcHp3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw9d8McNskYmcRvSGV45XOeVQ/1S7N4hCmv9369bFeXGrRaD4qJLGGA2i+MtWZbDII5QoFRbAymC0J/dQ0OOgAQuUrgqj6mzfG97NTIvsQeaiykLOVO5rIcszxrHOc036TYJOBp5MfSW1W3DTFgXbWmVnpVfIEAqZDomwACMRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKTBF8YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ED2C4CEED;
	Mon, 21 Jul 2025 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753108289;
	bh=nv7c53HMZGXsVbbUK5FVFqqjDWQv5W/iS1kBfcHp3Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKTBF8YRSvOamteKSfMoHMjH+UrZbESC11rUMJiPVFRF5WLxZyHWsibX5h4w9eet+
	 WUGIzOQhyLTeJnB7D7+OFVzAK2Lp2HYbTnzIAhfOdv7j+mQ/oYNDqA+frt2BBgTEus
	 qKxM2m3/joJsStldLw84P1fp21XTyGBwn5N/CAXc=
Date: Mon, 21 Jul 2025 16:31:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: crwulff@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] usb: gadget: f_uac1: replace scnprintf() with
 sysfs_emit()
Message-ID: <2025072103-pointing-ravioli-493b@gregkh>
References: <20250718175037.299710-1-sumanth.gavini.ref@yahoo.com>
 <20250718175037.299710-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718175037.299710-1-sumanth.gavini@yahoo.com>

On Fri, Jul 18, 2025 at 12:50:35PM -0500, Sumanth Gavini wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
>  drivers/usb/gadget/function/f_uac1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
> index c87e74afc881..9da9fb4e1239 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -1634,7 +1634,7 @@ static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
>  	int result;							\
>  									\
>  	mutex_lock(&opts->lock);					\
> -	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
> +	result = sysfs_emit(page, "%s", opts->name);        	        \
>  	mutex_unlock(&opts->lock);					\
>  									\
>  	return result;							\
> -- 
> 2.43.0
> 
> 

Note, this really isn't needed at all, you should only use sysfs_emit()
for new code, but this "cleanup" is simple enough...

