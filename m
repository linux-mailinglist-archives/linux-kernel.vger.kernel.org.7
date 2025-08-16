Return-Path: <linux-kernel+bounces-772090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E972B28EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D41C2181C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3772F1FD5;
	Sat, 16 Aug 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="p7kMNMrI"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F711E8332
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355949; cv=none; b=a95ptl/WB+XRL64MevGJgzpGeGBSaoHdt4tb3kfxFph6utpLYfqysQWHa57iGeAuK2Ur1/3gWBJWNDkRl4jRzBYtQXpqrGG1wRzCtggRrPkMSRB9TWpDpAUxQKvp+lrOqn7Db3L8KL1K8iilq9uBxrAXQe5NUYRbAePZQB36s1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355949; c=relaxed/simple;
	bh=1trCEvk8sxlX7UElZbGiNbijyY1MrtGGb2e+artoGZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWiMScWgleeRZDnWbmTrABLp49CeHktcga2bWRz0Gy3hN1hgOsMtqnWSfFW7XV0i+mW5B4gJLdW+st2Iu4PjUnJFC0OKGpS+CiwsmhOz9qnvnfaPE03mqeVDTJoqYISKtQ2g4Fb16D6IF6q/PfspMRNlR/n+Dl/DwLsJjM0pmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=p7kMNMrI; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355415;
	bh=1trCEvk8sxlX7UElZbGiNbijyY1MrtGGb2e+artoGZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7kMNMrIVxY4QW/ufkVnLl8nOvxCxHBXIIGl2kAFF59Lr9p8n4s/es1q9lMYovZ/t
	 bN2aCfYoVd0wlChrIvMOLgS0rrsBUaCWBeKTOnFgvI4ri8tuB0JdEyP8hlEJRl7WY/
	 ep385I+1toRPQhNu4CpL9Ft75hPOErkOwLz/7IGElOAKIylCPGDEAjm/1O5uEU4UrS
	 P4UyHsKS3zn0f2WYJdU7CuR2fPlrWc+x7c063TgAaJnqOOfmW6qbvJKBhNcfEpwNGu
	 BAlehWKXmH12qOfGFNqRAdmWi7epdUqjKnqh/MsHCzd4PZeYHCfQJTrU74VQp1IGl2
	 QNso7xXOZs+2Q==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 0AC9020071F;
	Sat, 16 Aug 2025 14:43:34 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id BD174A00A9; Sat, 16 Aug 2025 16:43:06 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:43:06 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: tony@atomide.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: omap: Add missing check for platform_get_resource
Message-ID: <aKCY-rmXymcSNrhr@shine.dominikbrodowski.net>
References: <20250320063956.211577-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063956.211577-1-nichen@iscas.ac.cn>

Am Thu, Mar 20, 2025 at 02:39:56PM +0800 schrieb Chen Ni:
> Add missing check for platform_get_resource() and return error if it fails
> to catch the error.
> 
> Fixes: d87d44f7ab35 ("ARM: omap1: move CF chipselect setup to board file")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Applied to pcmcia-next, thanks.

Best,
	Dominik

> ---
>  drivers/pcmcia/omap_cf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
> index f0ccf479f36e..e0a3820acaef 100644
> --- a/drivers/pcmcia/omap_cf.c
> +++ b/drivers/pcmcia/omap_cf.c
> @@ -215,6 +215,8 @@ static int __init omap_cf_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
>  
>  	cf = kzalloc(sizeof *cf, GFP_KERNEL);
>  	if (!cf)
> -- 
> 2.25.1
> 
> 

