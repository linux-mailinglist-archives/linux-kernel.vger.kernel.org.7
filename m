Return-Path: <linux-kernel+bounces-807228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B6B4A1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305E71BC35FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B582FF17D;
	Tue,  9 Sep 2025 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFXo8FaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB702D8791;
	Tue,  9 Sep 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398348; cv=none; b=qyLLxTXvAEG1PGyHNMtyAmjOigRK1eliXbyPis2dN8ebwrr8G3Sn/OB0XYjq61JCysBJnuAY84dD1J2s93Z3Ywiq4aUOrhPych5Ne9oK5Tgzg/D9/R8lRkRAEwq1MT1tlhF1h8gLposivIrB3XcT8y0du5uZDtyslvjlFWSWl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398348; c=relaxed/simple;
	bh=wXX1uIyZrCALOC7SlUARzzhblZFLb5TZfha2G6VA1QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty4apI6rTa67Vf0lLDXAyGqutql+j87fu3bNK7qzbuxcXRHM5CX4b2r0OyPvrOmQwZA9cf9u9p/KHPaOHSw3n4Eva3HSQ8BvMbypg1v7+9392nOUzk0Bj4fCquCMxpqbi6tcLXwUzDSYhj2M9hi2ElRD9tY59yVYJ/Hpl2OMJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFXo8FaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A924CC4CEF4;
	Tue,  9 Sep 2025 06:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757398348;
	bh=wXX1uIyZrCALOC7SlUARzzhblZFLb5TZfha2G6VA1QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFXo8FaBFLE8dCdbkWHJB+nmZUd8Bf87a/pHXePtkQmBucLvkaeXfqr7CDpHG0PMD
	 efJmAEwylLAyI8VJV47CdhAfDuIOib+mZrYN8I1y4VqGQWkLg4XtdNFQSJOVSSbqi1
	 INPV1kggDdclHAHpYl6+8dmpscVLyWajRedMYrFI=
Date: Tue, 9 Sep 2025 08:12:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gopi <ggopijeganathan@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Declare processor directive as
 CONFIG_TNT4882
Message-ID: <2025090940-backyard-mud-253a@gregkh>
References: <20250909041707.3001-1-ggopijeganathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909041707.3001-1-ggopijeganathan@gmail.com>

On Tue, Sep 09, 2025 at 09:46:54AM +0530, Gopi wrote:
> Warning massage found by checkpatch.pl script.
> 
> Signed-off-by: Gopi <ggopijeganathan@gmail.com>
> ---
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
> index a17b69e34986..918a4cebbc6c 100644
> --- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
> +++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
> @@ -1369,7 +1369,7 @@ static struct pci_driver tnt4882_pci_driver = {
>  	.probe = &tnt4882_pci_probe
>  };
>  
> -#if 0
> +#ifdef CONFIG_TNT4882

I do not understand, sorry, why is this the correct value to put here?

>  /* unused, will be needed when the driver is turned into a pnp_driver */
>  static const struct pnp_device_id tnt4882_pnp_table[] = {
>  	{.id = "NICC601"},

Now the code will not be unused, as you just enabled it?  Are you sure
the checkpatch warning was correct?

thanks,

greg k-h

