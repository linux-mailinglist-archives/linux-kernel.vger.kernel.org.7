Return-Path: <linux-kernel+bounces-806019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21ECB490CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BFA7A1E92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0D30BF59;
	Mon,  8 Sep 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUSLOFHz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0E2FFDDB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340648; cv=none; b=tcRgiC5bn6L6q3aOfV26ZcIP3dDKzT44mbENb15qwVp1M9Tb1wBaBwnJtA0+raoglx5OFudMqromFWr4oWzaFx1LCf3/XaJ5U6iXwt5tB0a1NP3Ry3Gad9tQJBPv/4vHl5BR0FZwRq5+Esx+3xeihkqGlL6PECkm1XR7dbuuPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340648; c=relaxed/simple;
	bh=jyjPNmTxSiVU8a0GdACvmlL4fqoWXiCgbHzxMxjmA7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utpU8mnAtylfEdsbj5BOLMtQLDIL8MmueLjXD51rV0y0iNYVGdS382GgJSXcKGAj/0P/E3ha7gwBYUwu/+67IHh2uG8oQ/aiKKyXZoyfaMyQ83hMDEJCQq5MBlpOYVYBu5wZ6wsmg+kzUMSH+FybjpipkwRjSvkJ/eyG0hN1D0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mUSLOFHz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jNRqPB7KdfOgvFdRA5vcOdjcm25++aV3+/H1vQCBoRc=; b=mUSLOFHzjw2tflmcF/aj9xbc+6
	fxGUHe7DTTiHp3DptSeNuOgyq279YLs5LPMCHwJSRipuducFDZ7hwSDtBu8/vcoeNv+JBVQnOhbOh
	dM6tOzWLMLTnxBFItNs1maFSZL8OSwUrPnAb7WK8RNfeebN9zbTlvyXGjPGQ/QxZX0VReZ8iBWBbc
	0glvwg2EmCu4zS1M1fyo/yYcJVfM5NsBSSs4KQTvQF1Vo3k9BRYkbPhlJLYOjxJrkwc1Rf656b60p
	SzyFgue2NZtyEUh8F2wyN/T2c7O6AIJD+H4l981jOz+dqFZbv6T6e1mTKrHHJn9whHKRPORQBVwMx
	6KtIwxQA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvcZW-0000000853C-1KUZ;
	Mon, 08 Sep 2025 14:10:18 +0000
Date: Mon, 8 Sep 2025 15:10:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, riel@surriel.com,
	harry.yoo@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm/rmap: make num_children and num_active_vmas
 update in internally
Message-ID: <aL7jyhlTjBrdbPBV@casper.infradead.org>
References: <20250908140505.26237-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908140505.26237-1-yajun.deng@linux.dev>

On Mon, Sep 08, 2025 at 02:05:04PM +0000, Yajun Deng wrote:
> If the anon_vma_alloc() is called, the num_children of the parent of
> the anon_vma will be updated. But this operation occurs outside of
> anon_vma_alloc(). There are two callers, one has itself as its parent,
> while another has a real parent. That means they have the same logic.

No, they don't.  This is terrible.  Please stop.

