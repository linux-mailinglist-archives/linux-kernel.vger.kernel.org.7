Return-Path: <linux-kernel+bounces-770885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03298B27FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F507A711E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F3286400;
	Fri, 15 Aug 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBvgaCMd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFD2FF673
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260658; cv=none; b=pwQ9h14+vN4tLXNruNE0DMAOStIEEn9Z5018jWvD7iS9uc8jHDnaNpOyDEgtMyyV6WxchHZfDSJQjn43x2O2tnChDnfD01uAxU6bLdJCN3sW85f2p2EXkjM0TcDg0IewH1MQzuSR/aOsmjF/9botQOhjMNG90xcmW1Kf5nBlAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260658; c=relaxed/simple;
	bh=exc7HTHCDUgoW3S5Kwx8tQNumPy7B4v5EZFghSKwdvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGVl83HIncIuZYbFfrU5eIliqvKfv3/DHa8BjMdVcfqSfMRpFAEwJUY37iEIZ8dIIUIcnlHSxhHsq0MxkrmAPNX7oANyXXs3KJVbTgEqWL+juOuUmiAVgkfzz9bKmPakf+qNmJ0mv3cl1jWcm8/kHbqMKERuzJGFQ1gj4JoS8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBvgaCMd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jgPEkDv+7jph4GklLNs9K3EdOtaugPbD7LdlNYsxyPE=; b=FBvgaCMdtC/ao9r/NkTtaTi/Hv
	HTjyLJiXrA8cTXYfnZgj+WAZoUYd5gpntXRRXKfJA3uPUnKK4boTcQ3X4DiPGQg632ym1FLFpkCL4
	wSZxR+P+tRTzyVSvVQWAJf+3oR5b9636ujdKdR1y4hPDPaKL/BnEEb8r7ko8OGZFEhkjGRToo1GXS
	VDmrhqCeMKTbKpEkJ5X8CuZ+jZ+oCF2Ebu6ShuTbUR0VvNXWszN6hBVoWLwN1cd0RLkU9r1iS5UxB
	/qk7MuptTOUzDItruvSVp6X2i9Ex/GXIoy7gf0qGD156tjY4B94p6v1jevkEqQJz8KlFu21mjvUIN
	1FJ5oM5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umtTY-0000000CYl1-0asH;
	Fri, 15 Aug 2025 12:24:04 +0000
Date: Fri, 15 Aug 2025 13:24:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: drop usage of folio_index
Message-ID: <aJ8m42sM1NX_wEE9@casper.infradead.org>
References: <20250815121252.41315-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815121252.41315-1-ryncsn@gmail.com>

On Fri, Aug 15, 2025 at 08:12:52PM +0800, Kairui Song wrote:
> +++ b/mm/page-writeback.c
> @@ -2739,8 +2739,8 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
>  	if (folio->mapping) {	/* Race with truncate? */
>  		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
>  		folio_account_dirtied(folio, mapping);
> -		__xa_set_mark(&mapping->i_pages, folio_index(folio),
> -				PAGECACHE_TAG_DIRTY);
> +		__xa_set_mark(&mapping->i_pages, folio->index,
> +			      PAGECACHE_TAG_DIRTY);
>  	}
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);
>  }

What about a shmem folio that's been moved to the swap cache?  I used
folio_index() here because I couldn't prove to my satisfaction that this
couldn't happen.


