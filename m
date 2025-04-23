Return-Path: <linux-kernel+bounces-615362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E132DA97C15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 03:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C1A1B61563
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088325D54A;
	Wed, 23 Apr 2025 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="jydTR+Nw"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA61EA7FD;
	Wed, 23 Apr 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371369; cv=none; b=TkEiwUIJkEanXpaLZ3H4mA875/NlLNOH38sjoxy36sTx0NrVorb2Xv5kQSMv2mW8j4Xq9ljGfc7q6eBdUIMPfIZPq91JzophPEocABRN+nbEWYMDBpvrPB+Ja7sK+QPo92+CbteQNE0sGLSaETsND/BZwqdF+FD6ztvNMojcI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371369; c=relaxed/simple;
	bh=3IU9xggvxaGyK7C8FsIJX/MreMYfHLvHVx3mahRv7VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GELEn8mSzQcvyo1DXRsEwLkDAE7y/EAV33BJN8GFdU7ujthiMicbYNBxd32AHiUgOgbS1jx+VmRfYZID//OZ0jhre0zHR3rd7fKSr882EqhmEIQ9Y19LEF0q4C0nKtkGnjGR3UcktUR8YKyGgp0h7Z3NXBRZTqgNrA2ciAWPvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=jydTR+Nw; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Bm5aY/6VVF0bgAOLgzDfud9C1Mj1JgBZ+ZlOE5CW70w=; b=jydTR+NwHdzKIURBEiuMVZboYi
	DCzwWQLhKnGgUo5HZYkqzhQ0Qz4mqZljqyNFR4KZ748gcounLL9OJfWLO9LCXsHD72iXYufOYaV1P
	sboHKZo/GUYfcCaZlUJxUiAOdrFgPiUh1R1kKLJmYiCA+eLkrq3n3sYoOrjjZ7el4b9E7204of4jf
	8aNRskw8RyHMGk/okwwPl2V0fiSxWpTuNAZluzf5ubyATJh3JG0vjWfh9hGc/TaKN2/mMovlLb4Ij
	NE6K3gIk1LKIRV7jAZ5frHwcgR6VaRMJuSYa4yTALGKsKpB352lgMQg24ePUV/T5rpGh+OJPfVWCO
	7yVn584g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u7Ooc-000FHI-0h;
	Wed, 23 Apr 2025 09:22:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Apr 2025 09:22:18 +0800
Date: Wed, 23 Apr 2025 09:22:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: Linux 6.15-rc1 regression, folio/ubifs Oops
Message-ID: <aAhAylotNK_zHl0C@gondor.apana.org.au>
References: <20250408082018.GA23886@francesco-nb>
 <20250422175409.GA877874@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422175409.GA877874@francesco-nb>

On Tue, Apr 22, 2025 at 07:54:09PM +0200, Francesco Dolcini wrote:
> 
> On Tue, Apr 08, 2025 at 10:20:18AM +0200, Francesco Dolcini wrote:
> > I do have the following regression on single core system using UBIFS,
> > dual core seems not affected, any idea?

Please try this patch which will go in today:

https://patchwork.kernel.org/project/linux-crypto/patch/aAW8E9NrKWq1Xk2w@gondor.apana.org.au/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

