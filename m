Return-Path: <linux-kernel+bounces-813827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C484B54B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9341189E240
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D878301011;
	Fri, 12 Sep 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUKpR1tU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD83009D5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677119; cv=none; b=n4gvQA2WMMtDDqcEC5nEGMeRaU2ECcwUBSrZFueaJ54bIhwYqcp6FW0btn6lafcJII5IyQr8uq2ffvZ74YIC4ZXtSnrgZMUBmaxyDt1LkNYwdlg3CEMQStOy9Hmv1rzutwrGtOXC7CUjwtQ+p8KOPQrBxgYs1/ZGEOk/dFOAplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677119; c=relaxed/simple;
	bh=8PyfkQTDVSsnzHJWTxQrHFvYpwiIn3uDM+R1DlmCSUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvUs4Gn1P6FzlEoqZAfXBGAPvthn8RYNqwXbT1cTmZ8GfL1ONC7UoIKFHbbWwK8j3A6IFjRIN9lUf8vB0KkTfkWpWHfoclGjTq+R+N2KNCmOfWVZjEy0iergKjrKW3XGyxJu6vaW+Wxez+rR2fHEAKSGrlDdbA/dVjwsmS/nUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUKpR1tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC895C4CEF4;
	Fri, 12 Sep 2025 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757677119;
	bh=8PyfkQTDVSsnzHJWTxQrHFvYpwiIn3uDM+R1DlmCSUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUKpR1tUzMiKd7ImmOi1jFbTnKmyFtmJOOGJUwzcUoaNvyj5+zNYYi/OzwcE1JIP+
	 DbMNyQzkVLlB+ONI6jowETpptdOcisfIScB1VZZzlo9qUvFbMZuMq6xrPowYPk2yhg
	 GbOzF2aWgLuSaCNxJin8p4KK8DZrTgXBmJ4K/b7I=
Date: Fri, 12 Sep 2025 13:38:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: arnd@arndb.de, naveenkrishna.chatradhi@amd.com, akshay.gupta@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: amd-sbi: Add NULL check in create_misc_rmi_device
Message-ID: <2025091212-dole-multitask-ee06@gregkh>
References: <20250912101451.1928-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912101451.1928-1-hanchunchao@inspur.com>

On Fri, Sep 12, 2025 at 06:14:51PM +0800, Charles Han wrote:
> Add check for the return value of devm_kmemdup() to prevent
> potential null pointer dereference.
> 
> Fixes: 35ac2034db72 ("misc: amd-sbi: Add support for AMD_SBI IOCTL")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/misc/amd-sbi/rmi-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
> index 3dec2fc00124..50b8e9e02833 100644
> --- a/drivers/misc/amd-sbi/rmi-core.c
> +++ b/drivers/misc/amd-sbi/rmi-core.c
> @@ -471,6 +471,9 @@ int create_misc_rmi_device(struct sbrmi_data *data,
>  							 GFP_KERNEL,
>  							 "sbrmi-%x",
>  							 data->dev_static_addr);
> +	if (!data->sbrmi_misc_dev.name)
> +		return -ENOMEM;
> +
>  	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
>  	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
>  	data->sbrmi_misc_dev.parent	= dev;
> @@ -478,6 +481,9 @@ int create_misc_rmi_device(struct sbrmi_data *data,
>  							 GFP_KERNEL,
>  							 "sbrmi-%x",
>  							 data->dev_static_addr);
> +	if (!data->sbrmi_misc_dev.nodename)
> +		return -ENOMEM;
> +

Why not just make this a single if statement?  And this really can't
ever fail in real life :)

thanks,

greg k-h

