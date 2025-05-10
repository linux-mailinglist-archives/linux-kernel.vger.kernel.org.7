Return-Path: <linux-kernel+bounces-642601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19ACAB20DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 03:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8545B3AE5B0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA7266B41;
	Sat, 10 May 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="n8vm+53d"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2D7FBA2;
	Sat, 10 May 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841471; cv=none; b=eGOry2SSoNZXClNXChkxDEWAk8NrYLCcEYmc1YZTGLgepv23hSwc0jHy1HWPGYa7usC3cZyMAzHBLYzKB1HeyJ5WrbxMKI5PwcwpeHW8BdDZFI0o/1Zlh5d5AMvJCBFE1jwm8oW0kuAky23PXzsmMmG2hbayMGdeQy2KeAJY16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841471; c=relaxed/simple;
	bh=M5tx+r1QbIUCT1y1uSrH7KPbcnmkzXkMSj/LeL8Zzv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzwgGYipEOLvwVUkaZH66HsailnvC+cqM9HIWVSWikQ+Fgh/hwSqfia9FdWMAU5SXSD4P57bssFqoU071EgqaOvJ9s2UpSCn/d7Qe3e+5hoM3GBivLf23htdMhGp5YDAzVybLUvGTOf9mGTKt+qukxxxEymztlbuQjHMybWio24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=n8vm+53d; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VL+chSAODTarjeBDTkcr1EDJvwQEwFverB/SmL/keUM=; b=n8vm+53d2GgZ1XjCJLUyDsVI7p
	dUIsGDXnPKNmve+HPc3E8gWFv88Vk05qPGXsFx/uk27TMLOPoNiLW4fCz9QTSgjts1RQMB5YWl4ir
	LQCVsvURz3hcTvALV/txB5dsALOc37RyunEm+01U8MBuXs/tS6rouVHuq1tXymc94+tn9Lpw302Es
	hkmDhL5VMz+9Y2WgrhzZtf1ZnuiTKCK3huZtY3VBYfQqM7UqCYdABXICTdKAhrZ/NAR4OYj93DYP7
	LgOilsu95cnuSS8CYT+1pzCOCyfYKDdo5jhjTsoS9oLCWdlfnTeNXZ9vYkZdohboMG7GGcmFvhgtZ
	yjVk+5xQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uDZGK-004zr6-2J;
	Sat, 10 May 2025 09:44:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 10 May 2025 09:44:24 +0800
Date: Sat, 10 May 2025 09:44:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	EBALARD Arnaud <Arnaud.Ebalard@ssi.gouv.fr>,
	Romain Perier <romain.perier@gmail.com>
Subject: Re: [v3 PATCH] crypto: marvell/cesa - Do not chain submitted requests
Message-ID: <aB6veEHqgrxBJs01@gondor.apana.org.au>
References: <aBw-C_krkNsIoPlT@gondor.apana.org.au>
 <aBw_iC_4okpiKglQ@gondor.apana.org.au>
 <aBypVwhHHzmqqN5K@Red>
 <aBytNdRyd5Ywh1Pq@gondor.apana.org.au>
 <aBy06xyzh5kKC48a@Red>
 <aB10PqZNk0L-ly70@gondor.apana.org.au>
 <aB24nSeEJKtP1bO_@gondor.apana.org.au>
 <aB3ggeQDdaPblUxi@Red>
 <aB6oxlR6DINIvdLM@gondor.apana.org.au>
 <aB6t9lfMCSuYVxwv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB6t9lfMCSuYVxwv@gondor.apana.org.au>

On Sat, May 10, 2025 at 09:37:58AM +0800, Herbert Xu wrote:
>
> In particular, when testmgr does an update+final, it will give a
> non-NULL SG list to the final call.

This ties in with all the test results so far because it appears
that all the failed test vectors involve a final call.

> The buggy code in marvell/cesa will then read that non-NULL SG list
> during the final call and overwrite the cached bytes with it.
> However, I still can't see why that would make a difference because
> it should contain the same data.

I think I can see where it does make a difference.  The SG list
is never mapped during the final call.  So the DMA address is going
to be either crap or more likely the address from the previous
update call where it was mapped.

Now depending on how DMA mapping works on your platform, that may
indeed be buggy during concurrent calls only.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

