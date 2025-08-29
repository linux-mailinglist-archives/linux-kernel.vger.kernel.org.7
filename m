Return-Path: <linux-kernel+bounces-791576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA16B3B8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EB05E7CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26C30AD19;
	Fri, 29 Aug 2025 10:31:24 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05F3090C4;
	Fri, 29 Aug 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463484; cv=none; b=BgVYhBn7KFRwEoLX77aWpQgdircOQkLSWvYYLk/Ivoa+pQg6izdLoqcfXx+R4EbszBsqtBevEUF0uzejNgop4qXshgDoVjhFW6vQ7AnwU64LPefp9GJweKwB71ASJ4Ae9R16PnshX+qcOyegivocSyqxo6VQtFV4w3HxCYr4lnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463484; c=relaxed/simple;
	bh=rIVAe+5zOnI8iPSxCtn65W8wFSx36zlykAVqfz8ppfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwAkP8m/wEwevRUBKUGckQ/wL7A5+mn7FGL55DQSh1gwwdIOCcV7wV6XYjxhL7MB6xBwe28CeBBzUPyzb++ZPwH4k70tvS62SQimZfLf7VtuofkE23z43cmuJrgWX7dTWlurDED19TQ2BdGEwUd9yeXNN+0p3YjcbJqyq/9iHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1urwO1-0004FS-00; Fri, 29 Aug 2025 12:31:13 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6CEC5C0770; Fri, 29 Aug 2025 12:20:45 +0200 (CEST)
Date: Fri, 29 Aug 2025 12:20:45 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips/octeon/smp: Remove space before newline
Message-ID: <aLF-_UgIHaWW8n96@alpha.franken.de>
References: <20250729112141.1924206-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729112141.1924206-1-colin.i.king@gmail.com>

On Tue, Jul 29, 2025 at 12:21:41PM +0100, Colin Ian King wrote:
> There is an extraneous space before a newline in a pr_info message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/mips/cavium-octeon/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 08ea2cde1eb5..054e331b3202 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -334,7 +334,7 @@ static void octeon_cpu_die(unsigned int cpu)
>  		new_mask = *p;
>  	}
>  
> -	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
> +	pr_info("Reset core %d. Available Coremask = 0x%x\n", coreid, new_mask);
>  	mb();
>  	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
>  	cvmx_write_csr(CVMX_CIU_PP_RST, 0);

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

