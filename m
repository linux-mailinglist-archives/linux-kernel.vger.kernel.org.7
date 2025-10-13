Return-Path: <linux-kernel+bounces-850041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C09BD1B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E623AF597
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3152E092B;
	Mon, 13 Oct 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kvt6/JQa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C92DEA7B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337525; cv=none; b=A8fjX0dAu7XVUu29+uXhO7XL4rOqAFr/7PCj8+Ed8HjnjrH9k9CsN9k2cw+JqkJHJ/q+3WC1ceLyw2JyDETFkoAf2ULwTUR6SnLgvNepny/usepHcR0rbZg1JV590UhDPgCVy4EWiad5PrzOJ9UAlvnP2UhK8ZdFRXCLoJ+ICxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337525; c=relaxed/simple;
	bh=Bh8CKCGXjzqwDZ3l2stIyHWUkGP2QjQn2OcKwt3qMY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGgyDKy/fIOum4xD0+ZttE0itvSk0xSSivdfJvwHCTdoQsisMqF1fdS2mx1TPP1PvcwMvVymGtX+KSVe/dimeWooK/VJDts+79VhMQq5/uwvstWSbgUPxV4NkqqL0T6OGdKHy18E96x7DImdHgAAEFmnhjpavYcSj2+G13m/juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kvt6/JQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=isaSbpMShywvvXlcplns85wwaESRqvKoGMPLZhtqLec=; b=Kvt6/JQa6dxbC5a9qOSJ0smXL2
	ZwRh/KQ3+vEBo01TrJ7MYocNFn5ub3NKabzEcrGm10nZSQbTWG7Eq93eakUWKLWWDzYZXAIupj+hd
	MGbpC0giag7Nj3J7U7/CTDJvTaX978tQdzYLimMPW7YHoxL/P69eUnw9ApTlI2wDvWKD5Lqh0e0df
	qtYeFWVMtOu1HE8raGIxTEPfqnV5ERJe+BUT4LS3jR1kIYhmV2EomwPM70irEDYmP4RHiitzXZr/h
	pqTPcZRzT4IChFiY0zfYZSJM8IkO3zx2t6vcvdRwJF4EupXf6OB2BBKQUc5IS5jyWaHwoW5jrr9Hf
	t8S9K38g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8CCh-0000000CPry-2YmL;
	Mon, 13 Oct 2025 06:38:43 +0000
Date: Sun, 12 Oct 2025 23:38:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/8] bcachefs out-of-tree series
Message-ID: <aOyecxJIzgxBSnly@infradead.org>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Kent,

just as explained last time Kconfig adjustments are a no-go.  If you
want to submit fixes to other code do that, but don't mix these already
NAKed bits in.

On Sun, Oct 12, 2025 at 05:24:03PM -0400, Kent Overstreet wrote:
> Now includes a genradix patch adding overflow checks that ought to make
> Kees happy, if he sees it. Otherwise - just commit message fixups.
> 
> (I'm the author and listed maintainer of that code).
> 
> Kent Overstreet (8):
>   closures: Improve closure_put_after_sub_checks
>   closures: closure_sub() uses cmpxchg
>   closures: CLOSURE_SLEEPING
>   closures: kill closure.closure_get_happened
>   lib: Give closures, min_heap config opts names
>   lib: Give XOR_BLOCKS, RAID6_PQ config opts names
>   lib: Give compression, checksum, crypto config opts names
>   generix-radix-tree: Overflow checking
> 
>  crypto/Kconfig                     |   2 +-
>  fs/bcachefs/alloc_foreground.h     |   2 +-
>  fs/bcachefs/fs-io-direct.c         |   1 -
>  include/linux/closure.h            |  33 +++--
>  include/linux/generic-radix-tree.h | 110 +++++++++-------
>  lib/Kconfig                        |  24 ++--
>  lib/closure.c                      | 203 +++++++++++++++--------------
>  lib/crc/Kconfig                    |   4 +-
>  lib/crypto/Kconfig                 |   4 +-
>  9 files changed, 201 insertions(+), 182 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
---end quoted text---

