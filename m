Return-Path: <linux-kernel+bounces-803700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562EB463DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10C75C379E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D5275B0F;
	Fri,  5 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KCj+cC0s"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA341096F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101528; cv=none; b=rPy1cCIjB7kMHreDJRyRHqSAzesg0+QWkinnX1oogTD31VYGrBd4wd94tQyYasc5+zp/XhKXncU6RLSwytBnDCGke1vS6Wuxf/JgZCoh/8EUDXmRulvzlUvfh+1yyTRNSlJugBvBYcXj9y6ejr9qlp3Erd99+cq79ovL6fSeOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101528; c=relaxed/simple;
	bh=Mp7cPbd1ldUQ/LPkcr0bS/WmEXRs1oY+5Rs2q0Zqdl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0LYoT4btp5jzyi3wOLXC+3QoDrZHL2rDzvVdf1KErGsCWwFxNTBsBG1C69mrrOErQOEHcibdOhF/e5l4ow/flObMAQsnYx8l5h864IdtUytEK0YIM/d9w9cRpmvNmzThEXlcq30Z2IZTOqd84hlP0Y05UkGqFWqpax9w32ndxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KCj+cC0s; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 19:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757101522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zThdamV/JarxGl4cUxG9WAPKrvszQh4PaJJmLAyEpBA=;
	b=KCj+cC0slLrUOaDbX8hyEpTfYNkUVkKGyyiVnykcTf0+8NoHtIqCnpp6frMPwhlYNBgaOg
	ogPI8nnitcTX749CWfm12X/PzGopqbDRJgjo6hOqRpBfSIVluMJIeJhdNw8TzxIqMtuQyE
	YMNJ+mNs5YVlXcD+FaspF0MxDF8Z8ew=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <4vpqew3bfs74kesmgd6kaafgm6nr6zbtt2t3hl2khkc6ds4zep@hllgy77hdumf>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 10:52:18AM -0700, Nhat Pham wrote:
> On Fri, Aug 29, 2025 at 9:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > zpool is an indirection layer for zswap to switch between multiple
> > allocator backends at runtime. Since 6.15, zsmalloc is the only
> > allocator left in-tree, so there is no point in keeping zpool around.
> >
> 
> Taking a step back, even if we do have needs for multiple allocators
> for different setups, having it runtime-selectable makes no sense.

Honestly I think we should take it a step further and make the
compressor selection only at build/boot time and completely get rid of
supporting having multiple pools. We'd create one pool at initilization
and that would be it.

I believe this will simplify things considerably, and I doubt changing
the compressor at runtime has a valid use case beyond experimentation.

WDYT?

