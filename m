Return-Path: <linux-kernel+bounces-825799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B0B8CD5F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396DC189756F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA852561A7;
	Sat, 20 Sep 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="mlncUhmX"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F818EFD1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758386122; cv=none; b=MZtmuPBRh0nyjRQlUMp4RjYaGj9YxYP8yh/UHAjRXZ4exr6NmWq1Aj8l6JUc1k580qQJaOG6AyuxdTO8npwFDca0e6BTwVpFqTVfeWdLyrG9fEDjVHgKIc1EIiLOEh4VuiDJmIewD7iQQNxI5dntKiDBB1yXcXICfaqlBitZ9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758386122; c=relaxed/simple;
	bh=y/h2lGlsDsISElvABB6a+BgNLxMKebhzWjiuoZl0im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHNtqFxTrYcQpJqaeZpNT7iZk6rUB05FhfnGTYd26K+k+5AERa6Gu+0VAoMspki7djYZhiIMBJ5U0ZX7fB7UfnYcNpLRHoD26sCU1askBYBVAweJRATuJA7pJO8jFscp9yfIQ9jVAGpxpylSy2eeBkRCEQb1OjUKxtgT9TKhTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=mlncUhmX; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1758385515; bh=y/h2lGlsDsISElvABB6a+BgNLxMKebhzWjiuoZl0im8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlncUhmXu1JVFekpYLbgjAQw6BS4oombB5BEYFqU5kijmpEz02pGWtVlEVyE5uYJF
	 OKjasooK8RAwbtULtc87BLgL1UTwz33i8YC2MD5SljFIQPDIDDhVYKjoTqHiWAGt3m
	 rTRS9fYdOxHGQSvI2eAzFdAtZYdw5g0tjpnwKIMdzWr9wqs98e7wAO1XO7BdLCsiNC
	 MEZCC8MmNRK1r2aHkm0+hkNXEtU4waZYgseyIoJdkfP887zx2Bq8p+Uc4blKwrfqmh
	 PUK+8TdoE3wrQ6zJYW2/ytNCm3hZ7aQzhUcyT74UTvInYVsydNRvG4+3Gvtw6A0L9T
	 VjPSConlbpCgA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4cTZV2615mz2n;
	Sat, 20 Sep 2025 18:25:14 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.9 at mail
Date: Sat, 20 Sep 2025 18:25:13 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: cb710: Replace deprecated PCI functions
Message-ID: <aM7Vab4TWill5vev@qmqm.qmqm.pl>
References: <20250919083214.1052842-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919083214.1052842-1-madhurkumar004@gmail.com>

On Fri, Sep 19, 2025 at 02:02:14PM +0530, Madhur Kumar wrote:
> pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
> Replace them with pcim_iomap_region().
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

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

-- 
Micha³ Miros³aw

