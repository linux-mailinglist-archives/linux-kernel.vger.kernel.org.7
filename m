Return-Path: <linux-kernel+bounces-844257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB8BC1644
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF1C3AC222
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566352DF3E7;
	Tue,  7 Oct 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qid8ZZgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D782DF3D9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841035; cv=none; b=A75TI/hUY0uJO3Hi6Cg1civaifzZuwXLvvL3VA4Y6Vf2UsszoxJdChL6dlnqyB+M74TD0Lp8eS2CkMUj2hoAcRAL4oMBz408UCEKPAMzJuVR0zQdGrP7Ta5F6NuPsid9bMDV6wZH/DYzLa1GV+Cy4SQ3zjKTAWlEFT+HholpTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841035; c=relaxed/simple;
	bh=z4Cu0d5JiZe/vB1tXUFzIvwURtvPRfjrpNifoq/30zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBEp4WTyyD4UqkJ6U+qo1867jw7YRdbctanNlNEMI1YsuXZ3rjh+XJt4SaHqExG+j8k3Re/PYePxEu80h4im6iL2SRGh6dK9f0G0UyZyC9M/mS5VW8SmwIghQjyMkj3K7zN9UVuFf0F8RthXT/l80YyUmYE1yH9uGIdLsFOkNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qid8ZZgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1830C4CEF1;
	Tue,  7 Oct 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759841035;
	bh=z4Cu0d5JiZe/vB1tXUFzIvwURtvPRfjrpNifoq/30zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qid8ZZgSIMUonyRE78vAxP4RhSDG0tPJj5ZpTNMlahGgXBvn82NXQnx1Ekt7uueQ2
	 7QnyRR+yyaOvFIMoq2F8dJOPR+yl2jg7ZVNaaMdoE1z5ixjXY+BVvtj40MEvBURqfH
	 +3OquocxDP1kFoAyHdWuSjNwHdnzCWC8Y4/bZ3+Y=
Date: Tue, 7 Oct 2025 14:43:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: mirq-linux@rere.qmqm.pl, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: cb710: Replace deprecated PCI functions
Message-ID: <2025100743-irk-democrat-2d4d@gregkh>
References: <20250919083214.1052842-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919083214.1052842-1-madhurkumar004@gmail.com>

On Fri, Sep 19, 2025 at 02:02:14PM +0530, Madhur Kumar wrote:
> pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
> Replace them with pcim_iomap_region().
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>  drivers/misc/cb710/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
> index 55b7ee0e8f93..033e9e6d37db 100644
> --- a/drivers/misc/cb710/core.c
> +++ b/drivers/misc/cb710/core.c
> @@ -223,13 +223,12 @@ static int cb710_probe(struct pci_dev *pdev,
>  	if (err)
>  		return err;
>  
> -	err = pcim_iomap_regions(pdev, 0x0001, KBUILD_MODNAME);
> -	if (err)
> -		return err;
>  
>  	spin_lock_init(&chip->irq_lock);
>  	chip->pdev = pdev;
> -	chip->iobase = pcim_iomap_table(pdev)[0];
> +	chip->iobase = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	if(!chip->iobase)
> +		return -ENOMEM;
>  
>  	pci_set_drvdata(pdev, chip);
>  
> -- 
> 2.51.0
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

