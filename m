Return-Path: <linux-kernel+bounces-741469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F44B0E480
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CFCAA7E44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F5227FD5B;
	Tue, 22 Jul 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTe/uMKk"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5717C224
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214482; cv=none; b=SNGdlDBD6+/SU2l4HsqUI5r2yyOT6oQp+JS7rHi1BqWoo7sYrXcKcoeDhbMYNjck1mee20/wlnwOTWRI836fw/R9Er6ae3X1Zp/VerDaovrXpMR5a+o+lkEezUaSKVUEJ4uqcjwvrIlbnoqq6rt20xCO9+CHSGjDfvZjUWJi7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214482; c=relaxed/simple;
	bh=KysHRX8+uQek7GjdzItO4xc14Xpx8ps1VTWaKVVFgWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tER40RS7CReFOTc1R7tPcHfaeIxi/aWQ4PtGP2fg6agVlYcG3Hs8LnZeWSa1lOd7btJAoy2EIzEkCnFDsA5O8NMI2pft6PvpLGyJGHVplNGkMR1k8ZoaaoJPHSD441aNXDKI8z3LYkqK7AjtcS7QdHUMfZuj31c0Dwggy0G1YHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTe/uMKk; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:01:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753214477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgd2rD9RabSwUS4iapZN19usxQFXsWZrQ2L3/K0TL5w=;
	b=jTe/uMKkOBVTHV1tnwHtGBUlgzNehHh+YAelWWXxmQh4DOnowCwSlolBltLwqsnvFwNrLp
	eyKBHdSB0CmhyPNsb4IizZ7gPi2gwSUt8N4e6aGLYTKxrjIcsDjZe5252m9lnBx2eOy+0q
	1R98FKxpUFnUIsizj1L74FGBKILFW2M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] MAINTAINERS: add missing file to cgroup section
Message-ID: <bdetq74tgtlekfzxjzfpv2cu6kgwarzez6tfzui7fopznzpn53@x3kjfgkggjua>
References: <20250722181409.154444-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722181409.154444-1-lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 07:14:09PM +0100, Lorenzo Stoakes wrote:
> The page_counter.c file seems most appropriately placed here.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Let's add include/linux/page_counter.h as well.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..d062318b6d09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6166,6 +6166,7 @@ F:	include/linux/memcontrol.h
>  F:	mm/memcontrol.c
>  F:	mm/memcontrol-v1.c
>  F:	mm/memcontrol-v1.h
> +F:	mm/page_counter.c
>  F:	mm/swap_cgroup.c
>  F:	samples/cgroup/*
>  F:	tools/testing/selftests/cgroup/memcg_protection.m
> -- 
> 2.50.1
> 

