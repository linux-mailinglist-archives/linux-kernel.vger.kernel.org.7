Return-Path: <linux-kernel+bounces-639700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F24AAFAF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C711C059F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8E22D792;
	Thu,  8 May 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="CoY9UkqE"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40922A4F1;
	Thu,  8 May 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709821; cv=none; b=hxTP9AjfvjVjoG++uSmQFChAUrtVBpcP/WNcoImFwGVWhbU1mkmAHysMuthO4NE9bEiyqygtb4sAg8K2vQGjdtI90vyOZS1fLYrGNKqAi5l7l55zL0MF5JM5iPqTHpd7mrE54diQ3IBpCTZDdsixmN1fnv8x3edp3XCIQ7dGfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709821; c=relaxed/simple;
	bh=pte1bCB2uCCVS7NjT5+1rghzcm7FMy84JWgVmHzg0K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIFmmXSvWuLzDIsVqE0pwlfpFeu/qDyYtg8z+XWXTKjegFOMZi+eAsCbGJ1BVodXiUfkZ+jozPMv/hpUOpGleydDiXi4Dl1SJqRV7N3ThzTt9P4ItL6jabv7EHcxWNgeUIo8cSLm7gPmhej2IamHM7U8MgGT6nQA7xNXgIXMcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=CoY9UkqE; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ppq7AHmk7VzTx8O0SoLweDhwIEA4fRyR9YaSrcEMytw=; b=CoY9UkqEO2eLQ09+3CpHiRxAKh
	U2NIJOcRVEgzbYDlmEqhHYC1SwiE9DYoT87iEK5o+xK7X0grtEmEnijB929GVhFT8nF4be1wbIyVt
	Mfc65cEW2T599xYxAB0hbm5wv+gQRJUmhJvz/1YrPBqkBYjjcmfA4cyAt/FXBlslidsHjKgecgbon
	Q6OYO6mgQieLCmK5XCwl86oOJq64PnczyP+j3Nk1ND65A9Au/hTj/7fgTYy/jPKt38xSsGiR2Zuvp
	4VPR/yjSAENEJTvGn20xmEqUvY1TFhO6i/v4BhAFfLJ7JXwolSN3CyB7FkvFuBo5Mv15Sem+5rJC1
	Waoso+bQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uD10v-004aos-2w;
	Thu, 08 May 2025 21:10:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 May 2025 21:10:13 +0800
Date: Thu, 8 May 2025 21:10:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	EBALARD Arnaud <Arnaud.Ebalard@ssi.gouv.fr>,
	Romain Perier <romain.perier@gmail.com>
Subject: Re: [v3 PATCH] crypto: marvell/cesa - Do not chain submitted requests
Message-ID: <aBytNdRyd5Ywh1Pq@gondor.apana.org.au>
References: <15fadc356b73a1e8e24183f284b5c0a44a53e679.camel@gmail.com>
 <Zw31JIEyh28vK9q7@gondor.apana.org.au>
 <5db212655dc98945fa3f529925821879a03ff554.camel@gmail.com>
 <Zw9AsgqKHJfySScx@gondor.apana.org.au>
 <aBoMSHEMYj6FbH8o@gondor.apana.org.au>
 <aBsdTJUAcQgW4ink@gondor.apana.org.au>
 <aBt5Mxq1MeefwXGJ@Red>
 <aBw-C_krkNsIoPlT@gondor.apana.org.au>
 <aBw_iC_4okpiKglQ@gondor.apana.org.au>
 <aBypVwhHHzmqqN5K@Red>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBypVwhHHzmqqN5K@Red>

On Thu, May 08, 2025 at 02:53:43PM +0200, Corentin Labbe wrote:
>
> The board do not panic anymore, but have still selftest errors:
> See the full boot log at kernel.montjoie.ovh/477935.log

Do you have a boot log without this patch to compare? You seem
to be getting skcipher failures as well as hash failures while
the original report only had hash failures.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

