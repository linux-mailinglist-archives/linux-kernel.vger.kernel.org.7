Return-Path: <linux-kernel+bounces-781532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD6B313C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD145C2965
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E92EE297;
	Fri, 22 Aug 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="rCCZMPzl"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D132EC561;
	Fri, 22 Aug 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855110; cv=none; b=qM0P33WZHFU9wT+R1CAsk3bIpDxsCPyjh8J2KxSQL0+op5Fe82VQWEfuGKTBOP0BXPnt7ag5Jep1L4ah+03LgLvUZjSxBEEttQR/0vGrGobfYaI86GEmBAAp9sRZHcGC9SC21P9ZrTAhRUfpuIz/KK1DyrWEIqnp4Eg43ALnfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855110; c=relaxed/simple;
	bh=1PEEABKN8YjTbQMOp+G0dFxUsh71zWoKwMGK+sJ2AII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMYPfi3G7n4Er6lHgTQOQFFmMCzB5WmGj8ByX9vEJoP23QXznPsmturLLwYscae8MFPki7opS3m60fnkDQINaTJa/4clr3WL6PtxVpLbE4csSaBfVD19Icdriyh2XfuEUCIJIC963miw8cjXKccJx+1qMuVm0GUEOcJLc0tkkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=rCCZMPzl; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4bRU6A31QXbo43eK3PDvdi3lSPXbr2xWSGINg2EoI5A=; b=rCCZMPzl1Gnsu17PG0H5+loTjO
	p5T+28bwCbFmX7X2iQBlcU1rQQQDqEvbailqnYPKTxV0FjABxePNbHx82CtWVDMpCePXaIbTLZayH
	KL7oHLUfgdRMwb8QDX4O7bPwZvNAyaO2+OTen4yjSwlGzkLbzuCdzwjz0adhd2S30p32/jSgWvNj7
	5TXkRjmiF6s3aq2D23DnsJqNqZvwl2ef0JkUg9Zlo1b8SAJuEfvPbYs8SrR6QHyJ9N+ZpLCaTZotj
	KzJsgtZHL4n+ZbaJmX4RmzY46MnFrYObiZ2xWV0kIVPBPuwG3jfXuUFykIldD9jzQiwp5oFoyCTHp
	qsCF+8iw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1upNrv-00GN2g-1Z;
	Fri, 22 Aug 2025 17:31:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Aug 2025 17:31:27 +0800
Date: Fri, 22 Aug 2025 17:31:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx2 - Call strscpy() with correct size
 argument
Message-ID: <aKg471oRs3QB3xOm@gondor.apana.org.au>
References: <20250811092459.4833-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092459.4833-2-thorsten.blum@linux.dev>

On Mon, Aug 11, 2025 at 11:24:57AM +0200, Thorsten Blum wrote:
> In otx2_cpt_dl_custom_egrp_create(), strscpy() is called with the length
> of the source string rather than the size of the destination buffer.
> 
> This is fine as long as the destination buffer is larger than the source
> string, but we should still use the destination buffer size instead to
> call strscpy() as intended. And since 'tmp_buf' is a fixed-size buffer,
> we can safely omit the size argument and let strscpy() infer it using
> sizeof().
> 
> Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

