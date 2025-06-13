Return-Path: <linux-kernel+bounces-685322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842FAD8808
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DC73B7098
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2785291C33;
	Fri, 13 Jun 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="HB6cxMbu"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6040279DDE;
	Fri, 13 Jun 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807233; cv=none; b=oKAIArbZ5X7RtLKBPByahkcNRdStaDegx026+x49YDbLiesDpNptUd/h3ip4hTLL9deHZhLn/zUEiyL9xLzkAJ4Nrh2NVDS6+T3jdZlQmV1ugA8lGApGEJsTEKaYK6a/SfFU7Tzu40HcHN91yWpHLs7TyBrROT/7Jns0i1PaLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807233; c=relaxed/simple;
	bh=Eqp+V72EaWNPkZw4qjCDr556H/HNa3qOlLz/oQ2LYwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttWRooqZ+Fhsagnzz1yQS2qZ20V/7qz9vYNooPC3XB8PaH0ZI34hPF4fV102BEM11XZsuMDNFGBqqQ0RsoQ97geaN6ix4K15E4Gua2KCTw0sSRumSXeII/qURuy+42xWBF2cLacNcE/NnpDKcbNxLGnAi/rWvpcpOTh7GiW58qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=HB6cxMbu; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RJ9X0kaBblbNG+aXoLy8U3PCQzc+sowmQF/zXxcEjiA=; b=HB6cxMbu2/d1Vxe9k+FnVdQXFj
	aTJD7F26yZ5qI/urpQYXZV9CWqeiRKaAk7geieB9vEvYglwJ9Zpk/I4Hf4jjWdEUk1uhn5Om3kHS7
	f111l4Wq7E8Ql2//cf2dpBhpPvP+7AWuE7esZNVXL80czXFgPDGOOsc9+Vf6ciA9ChdGkNAejUYl5
	mE4G+domQ3LuBvF+mQZdGKGo9k7bdmek0PzVsgmp0oqJnqDIOfQkVMZzZok3e654sv2gd0ki9+WOj
	b8hNSoaYGjl121BDcBWvhdfzh3FDhlUfOoaioR64+7VLSrko/zIhjESkNM3qDvWgudUEotTaYSPSo
	YcizbaGg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uQ0n2-00Csua-0T;
	Fri, 13 Jun 2025 17:33:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jun 2025 17:33:36 +0800
Date: Fri, 13 Jun 2025 17:33:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: clabbe.montjoie@gmail.com, davem@davemloft.net,
	linux-crypto@vger.kernel.org, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: sun8i-ce - fix nents passed to dma_unmap_sg()
Message-ID: <aEvwcABHs8tV9SHN@gondor.apana.org.au>
References: <20250519151350.3442981-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519151350.3442981-1-ovidiu.panait.oss@gmail.com>

On Mon, May 19, 2025 at 06:13:48PM +0300, Ovidiu Panait wrote:
> In sun8i_ce_cipher_unprepare(), dma_unmap_sg() is incorrectly called with
> the number of entries returned by dma_map_sg(), rather than using the
> original number of entries passed when mapping the scatterlist.
> 
> To fix this, stash the original number of entries passed to dma_map_sg()
> in the request context.
> 
> Fixes: 0605fa0f7826 ("crypto: sun8i-ce - split into prepare/run/unprepare")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

