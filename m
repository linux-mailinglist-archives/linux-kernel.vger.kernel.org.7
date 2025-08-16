Return-Path: <linux-kernel+bounces-772091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57069B28EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346623BA0E3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362742F1FDE;
	Sat, 16 Aug 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="yo+wGyxZ"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20652ED179
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355949; cv=none; b=vBi61KmEfYwbFvduobjmRD7k0hK/BazVEttSPxa6WL9s4FPHHLPWdtKGHG+S9bdOTptBlq0UTf7WQGY6Nr84orIryixpRAA7UhxQKyp3S4IUSsYt9f6hpUSvPXnfU9zlcQKFkJQfZUpNfjJ4xuEpjSGJLDuLwbQ/lhJg9OZkW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355949; c=relaxed/simple;
	bh=QsrSgo1OINdU9FzZenuyNq1YjSn+2cYuPSyx31lP7TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxpCPCjNUUG4aVyWu8XUWwtEwTUPHfxayibAF0UBsLfLMMyCX0f3/AsbF1smmhJKSvrGRaRu7Vt8wgfoln9MPFqXwOdbpgIuEafb24nF5FWyyPJkM2xjnJ+jiTszoeq0llXoK/pR8yr7ncoYT04hK7bhk5aKHW+ylmKqW3DZjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=yo+wGyxZ; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355415;
	bh=QsrSgo1OINdU9FzZenuyNq1YjSn+2cYuPSyx31lP7TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yo+wGyxZ/FVQpr5ziDHvz27zeS2Wnj6mpEQL1qilghdvjooEnFAOhMT0f13Ze+Id+
	 r4XWRyAkFwI4EypoAzQwU4rn1quHzLAi8R22+4IjghVUywZIKiqe0V0OdXb/vwf7pr
	 oXvmRe1Jz4DbXF2mYk5Mzd+x1KAv06HTJHZufpVWeshiRt3AthRFjUHQkJ8L+e4qs1
	 2C6NM69jegIplMLYZaIaegrTCooJupZmKTh0oO4/hWfNNsUiJWAT5qWNemB2ZpAqDy
	 fpj3SzMay06feqE2r7MWxGB07iRI13bOaJS2K9i96iuDnxkJsnHPJ7OcULjrbTHenv
	 p7FdwY7bco+WQ==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 8796E200720;
	Sat, 16 Aug 2025 14:43:35 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 1B8CCA00AE; Sat, 16 Aug 2025 16:43:23 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:43:23 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: [PATCH] pcmcia: Add error handling for add_interval() in
 do_validate_mem()
Message-ID: <aKCZC6zaG3T8NVgT@shine.dominikbrodowski.net>
References: <20250120131006.1332-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120131006.1332-1-vulab@iscas.ac.cn>

Am Mon, Jan 20, 2025 at 09:10:06PM +0800 schrieb Wentao Liang:
> In the do_validate_mem(), the call to add_interval() does not
> handle errors. If kmalloc() fails in add_interval(), it could
> result in a null pointer being inserted into the linked list,
> leading to illegal memory access when sub_interval() is called
> next.
> 
> This patch adds an error handling for the add_interval(). If
> add_interval() returns an error, the function will return early
> with the error code.
> 
> Fixes: 7b4884ca8853 ("pcmcia: validate late-added resources")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pcmcia/rsrc_nonstatic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
> index bf9d070a4496..da494fe451ba 100644
> --- a/drivers/pcmcia/rsrc_nonstatic.c
> +++ b/drivers/pcmcia/rsrc_nonstatic.c
> @@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
>  
>  	if (validate && !s->fake_cis) {
>  		/* move it to the validated data set */
> -		add_interval(&s_data->mem_db_valid, base, size);
> +		ret = add_interval(&s_data->mem_db_valid, base, size);
> +		if (ret)
> +			return ret;
>  		sub_interval(&s_data->mem_db, base, size);
>  	}

Applied to pcmcia-next, thanks.

Best,
	Dominik

