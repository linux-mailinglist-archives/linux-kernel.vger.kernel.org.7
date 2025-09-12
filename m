Return-Path: <linux-kernel+bounces-814479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E02B5548C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE23170947
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C230FC19;
	Fri, 12 Sep 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PszUAUam"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFE2550CA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693801; cv=none; b=hF5bY3R+3TT1m/KHGpMbqmmr3ehgHd5Z/nofjWxeLt1BRKZYbxZ4zqfYD9y/OtjdbkIWW6bbh1SKAS5fS4dOzLbMFLn/FTTWwV6hKLJKBnFfJJOeycUfkKkxjP30QbEIyuW8U/SyNs8HLH5c3+43Rr1eWmlxVNBlb6tckqxTQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693801; c=relaxed/simple;
	bh=Q7lznnAor/d21mYtI7sSfYDHKsgCHXwEJQogw9THP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgyh85Et884COjKIRfu3cnRhEeOUoJqaWxv2mgf2+lja+1aBPTiO2KlqS6t0V653whtLtseRHurbm/5JbbldU1EDcOuSZiwoQa2MRq68K6th+hTFmZhgGVi3n2zDBd92xHJ1tC8AFWgByiZutZDWuMbnComOgcCDkB2KjomvyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PszUAUam; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 09:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757693797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1s+nFYjm1BpxiJXuCQc5sgO3Fa1nM6X/7/UG+can/4=;
	b=PszUAUam6aowRxm6ZI/acl/mBwJKKxfq4NU97UBuocvbxpfWLDpBxO5mbaEm5kzmwhyHUR
	ngSILCiSozH7WWna3NVXykdXJDAyZvwgVAhv+pFVBh1bGBctE6H8K5nBj2ObrmK++2YurX
	8VZs49fCYqPVDzEcRqzTYm9R90lfeVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, willy@infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: vmscan: simplify the folio refcount check in
 pageout()
Message-ID: <g3seb57wsx2qn7tks33gudalcxfxk7ejq6cmkdbsfalb7sxoru@2esiwxtv7wia>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <e475c5ddbb94763b12d396122ade8ee3c711a967.1757648598.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e475c5ddbb94763b12d396122ade8ee3c711a967.1757648598.git.baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 11:45:08AM +0800, Baolin Wang wrote:
> Since we no longer attempt to write back filesystem folios in pageout(),
> and only tmpfs/shmem folios and anonymous swapcache folios can be written
> back, we can remove the redundant folio_test_private() when checking the
> folio's refcount, as tmpfs/shmem and swapcache folios do not use the
> PG_private flag.
> 
> While we're at it, we can open-code the folio refcount check instead of
> adding a simple helper that has only one user.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

