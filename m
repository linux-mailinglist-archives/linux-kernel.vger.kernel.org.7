Return-Path: <linux-kernel+bounces-771884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F00B28C84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B63B60BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BA241673;
	Sat, 16 Aug 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="hiaTQf7w"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584711E0DFE;
	Sat, 16 Aug 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336986; cv=none; b=OqE8kb5daTwp+FdWo8olqH+z1KBpR/JFmB8nG+8f87y/+u1yDtzpnEEbORRpitruRbaNfqG/0VxTAKBvda3TpCx2nwoQRoYJtX+8k5BLDXhEtj2oJxtJsSshLDq48UKqGUwsiorIxgh3E1JL8TgaWMusieLoL/ysrReFG9JsoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336986; c=relaxed/simple;
	bh=eqVQt0FlXIrAzeuBsUm9ZzI5xee2EQHthRxo+F7YpiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf3v2OqFx5SCvtfEFHoL/WdDRJRvujG+kMcEH0DNTG/rDPn9cIKtvL4wJuXhv35MB6uhmJ9reaYkiLy5tgo9m5Tgx9NUagxRgzvdi/WPqgcrYuhRG2VI0PgMl8rrkcd09SglKL0j8ooZQP+jPSf+pRV5sM2BeCj65dHdo+6kstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=hiaTQf7w; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FGXFx57aFNJ2akU08oGs02FPClCl/sUX6Q0CeRy7TME=; b=hiaTQf7wxqPCTq8VLM/U8JZ0J1
	iXQ6Bnd5TKNmgGXH5q8NsFo8HWRlANcYdNNuDvItSG3qkYx06BIPPkGPJKeT3NcJKxXd0qsNwGESS
	jsZR3tn+7M3QUbWvnL3/qSZu0d0NeApo4dStCPrV49m10Sr3g7Erkg4XCX3zKJqaGRdErDngK455a
	NeH/x/xDaNsATWv1YqeWfkhdTWpmr8brsRxop22wA0pEBC0rd18ziBhLe+iROZVOmX8bWOg3yFVFB
	uq7a7Iwrl4cK8pB/N9j5Uag2bDB3dr6LX5MxUW2Wlq0si4On/t9Hzd7jw3sNNvohv8VZwQM9D49oF
	vwryLxPQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1unD5H-00EmPd-25;
	Sat, 16 Aug 2025 17:36:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Aug 2025 17:36:16 +0800
Date: Sat, 16 Aug 2025 17:36:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Remove redundant __GFP_ZERO
Message-ID: <aKBREBquWJ1c3DDM@gondor.apana.org.au>
References: <20250808074426.214726-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808074426.214726-1-rongqianfeng@vivo.com>

On Fri, Aug 08, 2025 at 03:44:26PM +0800, Qianfeng Rong wrote:
> Remove the redundant __GFP_ZERO flag from kzalloc() since kzalloc()
> inherently zeroes memory.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/crypto/ccp/hsti.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

