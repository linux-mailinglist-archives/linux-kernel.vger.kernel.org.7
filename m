Return-Path: <linux-kernel+bounces-666274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0EFAC7482
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 01:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDD1BA656F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD1230D0E;
	Wed, 28 May 2025 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Iev9w8RI"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D5193402;
	Wed, 28 May 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474839; cv=none; b=EOJYxDKswSiRCDITrdCoBFyf+rA0D/tTW+P+SSwA2P5+qHLvB6lMyvwsv9Q217/1GmH2uS3wYUn5dgjzqCQiFJ+o6O8O0ABhW6MLQMg2wXQ6v0yFkBGJasIv4p9bKUQUGxpiIxs1CuT3zLuLW0UCt427X+PgYknL+6x21/A2mqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474839; c=relaxed/simple;
	bh=tfuPIniloIoCg5CtduqvdZauSWu/5XK/q+LfFj+p9S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9klSITScZMScQUGrq7RRI11d9QtmbR0QPXJ8fAnYhvfHZyQx6qCp5BjETtgpQ1t5KzDZXT1jTtYsie7y2sICnwB95rf5l1n/vIcwMVFlwagAvKPZbuo9N3cOmdEyg6+cymIyfeqj1u5caXhPnmXj1O2kRQ0itVJWxyMXPebjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Iev9w8RI; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8hgOmhsyIzO6J7ZrHtl5mjYhfxIXZtj5NQ8SyZqSLdY=; b=Iev9w8RIUiIB5asop4Vt597lJi
	wHXtpEdzzsP7zt4jJbrRJdSu/R2BAAVaBQInTgFQnee9P43+YEyCHGDgb7LvH4Z11SQnncPZouR7g
	uM6q1qS+NU+arGQ8WoHUZswEaUIz25qNTTGMK+bmDduqiXLtyGegYSmCV2vGCrIcY+go6CSEsU24S
	pL+n+l0M5raC6Jhx2wWaquxanK+ckkReKXxfeF98AGuOSr7q3B8jMClXTi5ZPq+YMLpS6/y6AX/A/
	8LPRoksUCGamsw/AzzqkSguSieeqsINGJ9kKvYJcxE46/zm1wCbJMAsV0hMY/qeJP59IdjqXpGBCU
	kHrpj5eQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uKQAk-009T0j-0j;
	Thu, 29 May 2025 07:26:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 May 2025 07:26:58 +0800
Date: Thu, 29 May 2025 07:26:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: thomas.lendacky@amd.com, john.allen@amd.com, davem@davemloft.net,
	dan.carpenter@linaro.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp: Fix dereferencing uninitialized error
 pointer
Message-ID: <aDebwj8rcuWPIKOa@gondor.apana.org.au>
References: <20250528202018.78192-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528202018.78192-1-Ashish.Kalra@amd.com>

On Wed, May 28, 2025 at 08:20:18PM +0000, Ashish Kalra wrote:
>
> @@ -1320,10 +1322,10 @@ static int __sev_platform_init_locked(int *error)
>  
>  	/* Prepare for first SEV guest launch after INIT */
>  	wbinvd_on_all_cpus();
> -	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
> +	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &dfflush_error);
>  	if (rc) {
>  		dev_err(sev->dev, "SEV: DF_FLUSH failed %#x, rc %d\n",
> -			*error, rc);
> +			dfflush_error, rc);

dfflush_error is never returned to the caller unlike psp_ret, is
this intentional?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

