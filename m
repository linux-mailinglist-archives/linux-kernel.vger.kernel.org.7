Return-Path: <linux-kernel+bounces-664310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3DAC5A02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346033AAFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24728002F;
	Tue, 27 May 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TmluuGYR"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825E27C854
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748370011; cv=none; b=c+TPNzBuxNNa4hf+RMl2VUh7l4iFimNsNZeG2z0x1TxOwW/DfmOv58gfpuK27gd6ZgDeluSRYXuBaurbjkcoVF5lCel0/cKnePrLSDdIzh2qm4h+6ZfSc0fA9sXrb+OUZfWEyYsfqGTSxblbh/w6WQHHz3mTkSCOsXNKnz7oltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748370011; c=relaxed/simple;
	bh=sEVi5xn73Yeh8Ap0foTsEMNSOsy1XzgbIiNqMSAIwJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqALyC5YHasBCtPKP6xDBoVEF1Xnl+rLjVTdXEfjhLzrC9FUw3SUUwHbjihl2l9VHh4KQfmpruzLo5pKw8w4sD30ZYkafRfX/KhAQg2Q4GbPqCN84rAjl6AeSu7Hf8WXYSfBNro/goLOxip6fFOgVqHTGel8i3rv4wFBFhOFLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TmluuGYR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 14:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748370007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sEVi5xn73Yeh8Ap0foTsEMNSOsy1XzgbIiNqMSAIwJs=;
	b=TmluuGYR+8ufeptzGamzCM6BbJrYwElWoCgkbSVRJ2on/KIiqARqnAGc2G1361RJbWJt4i
	980JOAAEuLjQQfoK9+/jiee7IAfBmpFbuyK9nI82ie00emWY9rGJZT50UppCLNaI6yiZqc
	ddV9CDv05P2Nh7u1B5yIu9UMpvHxbvc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH bcachefs-testing] bcachefs: fix goto jumping over guard
 initializers
Message-ID: <62qt435bsvvhstxhn2utpio7owmk6ddjuyzkjv3tvbnh2f5xoz@56kd22dgyjqg>
References: <20250527173116.368912-2-bharadwaj.raju777@gmail.com>
 <CAPZ5DTE1z=PPm+v718ZfgYg0oJkEKHJ-pxrSjSGTmxQVqzaP7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPZ5DTE1z=PPm+v718ZfgYg0oJkEKHJ-pxrSjSGTmxQVqzaP7A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 27, 2025 at 11:09:00PM +0530, Bharadwaj Raju wrote:
> Now I'm actually not sure this is the best solution -- the comments in
> include/linux/cleanup.h say that gotos and cleanup helpers should never be
> mixed in the same function in the first place. So ideally we should not use
> these guard helpers until we develop helpers for everything that
> we want to clean up using gotos, like printbuf_exit, bch2_trans_put,
> and so on, and then switch over everything at once.

I believe that's too strict; a goto that jumps after a CLASS()
initialized object in the same scope clearly doesn't work, and probably
the same is true for a goto that jumps backwards over a CLASS()
initialization in the same scope (doesn't come up as much, haven't
checked).

But a goto that works like a break statement - jumping forwards out of a
scope with a CLASS() object should be fine, and likewise for gotos that
stay in the same scope and don't jump over CLASS() object initializers.

(gotos that jump backwards out of scopes, or forwards into scopes, are
really problematic for compilers to model; 'break' style gotos are much
easier for them).

So we should be ok with those rare cases fixed, and I'm running the full
test suite on this series with lockdep/kasan/leak checking enabled.

Agreed that it would be good to get everything converted. I've already
done printbufs and btree_trans objects, but we still need darrays,
wrappers for various device/filesystem refcounts (and the
for_aach_device() macros might be tricky to convert, but worthwhile),
and btree iterators.

Btree iterators have an exit function that takes a pointer to
btree_trans as well, and it didn't look like DEFINE_CLASS() could handle
that directly - will have to look at how the lock/unlock guards work.

