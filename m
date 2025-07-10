Return-Path: <linux-kernel+bounces-726474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F84B00D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F264A7A80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61D2FCFD6;
	Thu, 10 Jul 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2ZBT9MbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84605194124
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181034; cv=none; b=pJZ2QcHncrSCW2nnlv9TuH5gxjNwXu40hb9m/JIMfJiREej4w6KuGgAwmd9Lva1iB+Fz8c/Pcc6PfrYFIaHRq2rj+23V3s3qsZHp/QB2rPlYBJBs81V/leZA+m+Syb/ORhaCxGGR5dY/CG87tb1LVvWez8Z/ivIdebBYQkKaHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181034; c=relaxed/simple;
	bh=PgvdOHSZ/NTpEg8ByNQ7lOO3bzSndi9o3WTFutS94oc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WSBkU/mJ7GSAnt3c48xzsdzny+ZyqXOQfP4jtFF9FoLIxZ8MJMTYWKODbbF+cjSTkARd9KCxJ5e3v0Q5T9tm8KPmFM0kXy/AOye5qGUDQtP0tenKW6HJuDgZqRh5W9dEX/6F5dT99/vXYeUDdXskmdW0f2nJ+wsVFe35FIvLKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2ZBT9MbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A1EC4CEE3;
	Thu, 10 Jul 2025 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752181034;
	bh=PgvdOHSZ/NTpEg8ByNQ7lOO3bzSndi9o3WTFutS94oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2ZBT9MbZuwZu2B2D/nPBpGQgH+Ia64+2HJtj3QLESe4/1O3kvnr3ehU+A5m5OGgsR
	 u09e2kwEGx3O/J1YdlyNGasfdgov/nRTuSa0i6ilsLb4AADwHPbs2c9EV03gULA/zF
	 CScW+C1BStm9M+maVUaLqQI3dGqKOuW4AuBgiM94=
Date: Thu, 10 Jul 2025 13:57:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Liu Shixin
 <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
Message-Id: <20250710135713.916a4898fb02f595206ac861@linux-foundation.org>
In-Reply-To: <20250710195232.124790-1-roman.gushchin@linux.dev>
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 12:52:32 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> We've noticed in production that under a very heavy memory pressure
> the readahead behavior becomes unstable causing spikes in memory
> pressure and CPU contention on zone locks.
> 
> The current mmap_miss heuristics considers minor pagefaults as a
> good reason to decrease mmap_miss and conditionally start async
> readahead. This creates a vicious cycle: asynchronous readahead
> loads more pages, which in turn causes more minor pagefaults.
> This problem is especially pronounced when multiple threads of
> an application fault on consecutive pages of an evicted executable,
> aggressively lowering the mmap_miss counter and preventing readahead
> from being disabled.
> 
> To improve the logic let's check for !uptodate and workingset
> folios in do_async_mmap_readahead(). The presence of such pages
> is a strong indicator of thrashing, which is also used by the
> delay accounting code, e.g. in folio_wait_bit_common(). So instead
> of decreasing mmap_miss and lower chances to disable readahead,
> let's do the opposite and bump it by MMAP_LOTSAMISS / 2.

Are there any testing results to share?

What sort of workloads might be harmed by this change?

We do seem to be thrashing around (heh) with these readahead
heuristics.  Lots of potential for playing whack-a-mole.  

Should we make the readahead code more observable?  We don't seem to
have much in the way of statistics, counters, etc.  And no tracepoints,
which is surprising.


