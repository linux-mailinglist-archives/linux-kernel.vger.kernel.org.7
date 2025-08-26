Return-Path: <linux-kernel+bounces-787234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A3B3734D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB351BC096B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611930CD97;
	Tue, 26 Aug 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mmHOxM9s"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898730CD96
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237142; cv=none; b=JfVZg3b+9y52/HaYq9Gawioa4eE9jU3seey4WZIsm63wyxPna1trxNQrUBL+DFt5Yuc/Cgkb/Hhqau2WJaeUkRwHEcWepnRa09aXllBkRZtuTFwAg2z45ptibFis7B5gL6eG5wbkLw3nC1avY8Vwmh/An8sppP4RVK5DJCbQn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237142; c=relaxed/simple;
	bh=hbyyoAyHIcdN+BuJ9mHlZU/cFVmzvh6sgKPEsys+kr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKfoYaJrB9BNaE1a86dhZjrudw24mVPWWC9h9ThLY6kWA3tU3TQjeDyoK3XrdqobUQQPBGUwm9MkEXJoiQC4lMBcxOszFRu0IFL3kZLoaldw4sAuXJJZVvpmgBKlihAqKua5BcZf7vmvwK9p2iy8cNTxWjUUC9b/0zbmVhkx2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mmHOxM9s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n/kAsqmVBMedESn3J7MpJfJZf2HruICLXcPBtaj0vl4=; b=mmHOxM9sNOo2+Re3oykQKDtWdz
	rhODXDKvhq9IIubRcJJ6HjnjRESu+lBbbiXNc1hqKRiL9ZTTO3i5pbycRBIyTu6Ini0ItyzRHtdhW
	h9UIqwZ5TM5qtW6KBwGgCqeQdG+iruICoxDMdr4QK22jBABrtH8kv8wMlfC+RzNifIyZ+sfotOsSf
	Hka3lJ7MDatWwg0P79CMhyruu4iVZEUeWRixr24aUK99TvBAJeh7g6K0aHkEYy+JtcdZBSovAfMqB
	/2fb41aEV3rH2/F4+s1uZjv778mRsFGf7OyTZILlBDJJJ4fvzna1UpZclOt7cj7WBLdps5XrDS5tx
	3GVJQETA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqzVR-00000008dUK-1CXL;
	Tue, 26 Aug 2025 19:38:57 +0000
Date: Tue, 26 Aug 2025 20:38:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Message-ID: <aK4NUS5N9TiX5hk0@casper.infradead.org>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
 <20250826193258.902608-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826193258.902608-2-vishal.moola@gmail.com>

On Tue, Aug 26, 2025 at 12:32:52PM -0700, Vishal Moola (Oracle) wrote:
> +/**
> + * free_pages - Free pages allocated with alloc_pages().

I might reference get_free_pages() here instead of alloc_pages().
We used to have a wonderful document that explained that there was one
allocator with two namespaces to access it; alloc_pages()/__free_pages()
and get_free_pages()/free_pages().  I don't know what happened to it.

Other than that,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

