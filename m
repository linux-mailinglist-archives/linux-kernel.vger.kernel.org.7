Return-Path: <linux-kernel+bounces-809389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A84B50D11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2047B34FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA774260578;
	Wed, 10 Sep 2025 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ADSDnES+"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12631D39F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481499; cv=none; b=O1+hozo9PxGuhRyD/973VPmHWSCKPTlm3UbK+G2huZIM2zFHgD7lDKehGSb6yn3wPOw5wvPwFF1n+GuNcIHMAjrX0FRPntud/Gm5GB7ClVVNpi36C2bJDkwMXUtNjyGwQ6Ttap5VDOSNguCOEdSGJIrnASJA8VH3AesX/7sDU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481499; c=relaxed/simple;
	bh=REH7eUKP+Nr8xbBHvhgwlBaD4/1/YC39m0GjHndY1CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgJuhBzgKqvCge474R7GGN0dTRwWvFDWIOjTJTDILBGiirUOS2aR1i4eWw646KKacEIBiyfReNmgVG8M+/zYByp/8tHCTTeIo3RzPXNFOiagnnFEFV8k44G0+gHfxHhZ5lU1vs3RoUobON5qLyWF9CQY0agdEyRfTvzRJ4fzm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ADSDnES+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 22:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757481495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVZb3Wv5DjHV/fPWzvQeRpiAZuaKt+I3hkiJK9us3y4=;
	b=ADSDnES+dA9YiAsLR1cETJqGS3IXOSFpFZeD+BtrcZyZnqzeTZdv6YG3+hIiUmB2GEOZts
	9XAfth4nQDb468IXHg64fzok3xtKvEINhKb8+PypbZBLxAKH2AzYWDt5E36un+tU1uDHKR
	71IfSwkaYr/DAutTh7Nm5nRUBRfQg9Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <hp7kdpo4wqlyge2mjivfieibcfxu2jxestrqfwll27v4gsoqja@stvbcth6zc5v>
References: <20250909234942.1104356-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909234942.1104356-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:49:42PM -0700, Suren Baghdasaryan wrote:
> While rare, memory allocation profiling can contain inaccurate counters
> if slab object extension vector allocation fails. That allocation might
> succeed later but prior to that, slab allocations that would have used
> that object extension vector will not be accounted for. To indicate
> incorrect counters, mark them with an asterisk in the /proc/allocinfo
> output.
> Bump up /proc/allocinfo version to reflect change in the file format.
> 
> Example output with invalid counters:
> allocinfo - version: 2.0
>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>           0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

