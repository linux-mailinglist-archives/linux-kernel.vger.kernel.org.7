Return-Path: <linux-kernel+bounces-803715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11EB46406
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504861C86325
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96349283FD8;
	Fri,  5 Sep 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k5QdP2dm"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C9248176
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102269; cv=none; b=Tj9L84ChRlSQvSZVbrKac+a0e6Fp+NccUBE9BHYti1xhjJeLJ6rwduPNnzXRtssDZ5TiQMyFyrl/QvxFunyNKc1Npl13WH4V4IZpOXNO6t5+6GVVo95qiwPb2hPu+BSyGOzmnbSFPKbRQDZyg9+m4YI6lZbLzcQZ8M5JgmF/254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102269; c=relaxed/simple;
	bh=UA13ufErpkBti0CSt0Y6CXeFDCG8q66BPU3KRp+4QLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF2a3gqsOnTSUKgGMZDH2LgC4uDNwDKC+gOWdldhimE4gOTct7OaM8+Ochq196M5zf4zIxwhlWfaJ9le+u/0MNXPD+smlw+hJC5zfv1eSudNJhp/1xILtE+fdVCR7LSQqR9dZsTEWqAs5w1ToTWzbIKZR+SMOMFf5Wvm0jb8MlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k5QdP2dm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 19:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757102261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C88HDehPWivD9EUSvKkxXMxjXSeia8HK43L6jBuUCCM=;
	b=k5QdP2dmq/1Ek9qMCh+byWehTbaBVFeSYl4SdH/jqY9gj46HWhi3IIEOEhOJyeA+k70JII
	1ExSzHoZnEmaDRNMgT0mcb1eD0KlvPvVIMKN8hYqiRT8ciWSv5fjiyMpzlWV5GKdrldXKV
	EIZ5cJon/uPV4AqhDtLsZr4PD+NgryQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 04, 2025 at 04:11:04PM +0200, Vitaly Wool wrote:
> 
> 
> On 9/4/25 12:13, Vlastimil Babka wrote:
> > On 9/4/25 11:33, Vitaly Wool wrote:
> > > > With zswap using zsmalloc directly, there are no more in-tree users of
> > > > this code. Remove it.
> > > > 
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > Per the previous discussions, this gets a *NACK* from my side. There is
> > > hardly anything _technical_ preventing new in-tree users of zpool API.
> > > zpool API is neutral and well-defined, I don’t see *any* good reason for
> > > it to be phased out.
> > 
> > AFAIK it's a policy that unused code should be removed ASAP. And that's the
> > case for zpool after Patch 1, no? It could be different if another user was
> > about to be merged (to avoid unnecessary churn), but that doesn't seem the
> > case for zblock?
> 
> For the C implementation of zblock, no. But there's another implementation
> which is in Rust and it's nearing the submission.
> 
> > My concern would be if the removal breaks any existing installations relying
> > on zswap. Presumably not as a make oldconfig will produce a config where
> > nothing important is missing, and existing boot options such as
> > "zswap.zpool=" or attempts to write to in the init scripts to
> > "/sys/module/zswap/parameters/zpool" will cause some errors/noise but not
> > prevent booting correctly?
> 
> I don't expect heavy breakage but misconfigurations will definitely occur.
> > I mean if we were paranoid and anticipated somebody would break their
> > booting if writing to /sys/module/zswap/parameters/zpool failed, we could
> > keep the file (for a while) and just produce a warning in dmesg that it's
> > deprecated and does nothing?
> > 
> >  From Patch 1:
> > 
> > > Note that this does not preclude future improvements and experiments
> > > with different allocation strategies. Should it become necessary, it's
> > > possible to provide an alternate implementation for the zsmalloc API,
> > > selectable at compile time. However, zsmalloc is also rather mature
> > > and feature rich, with years of widespread production exposure; it's
> > > encouraged to make incremental improvements rather than fork it.
> > 
> > With my history of maintaining the slab allocators I can only support this
> > approach.
> 
> There was the time when slab was the best option and it was more mature than
> slub, which is now the best and only option. Thus, the "maturity" point is
> indeed valid but not being backed by anything else it doesn't weigh too
> much. Besides, zsmalloc's production exposure from all I know is limited to
> the 4K page case, and zsmalloc is truly struggling when the system is
> configured for 16K pages.

I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
confirm.

