Return-Path: <linux-kernel+bounces-814381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A1B55334
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307F1AE0350
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765721CFF6;
	Fri, 12 Sep 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTauwZnj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD731F8724
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690495; cv=none; b=M5AW3/Mfzqw6y7fx4WI9CPjKBtfN0G0AedWee2lfGaGBTMI1q0Ri/HFJEnVgHUQX8IUEAQ2WKVVSEfWWBErmS3hg1KaihR+iV6CnibAl+CbfKsKYrMgAjjp622jQrH+s3kNrEjALfWu0O4KFQgtTBwGuX6wy2C1Yu8KlEQWX/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690495; c=relaxed/simple;
	bh=7+UJYWpjI3cKaQ0DZucwvz4JPczikI95eUptzLzg6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhC1rdNUkFA5q8zlDKbvWr3i0EYxlKi54TWmxAl6VVvEmD4BkK7iz6uDeJVilZE3jTQ9EQLnY3noSAnUZaExTDqpMbf581it2dtPYddt1YW8oVOam2uqVC4i8dSW+631cAWvzbWEPwa1uGes79BUcK2r4Wyz6zohdQwgUdha57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTauwZnj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d4L6UERSUOracgIwE3XhKEBtUrUmqFBKh6Ibcm8VYUM=; b=nTauwZnjXYiFWYrr31vLVhi97Q
	DBH7B71TT7gySBI68eEf/NWSX4SMiDjI5BveiyHNlHwXWKWNtliCE6fSkcJjh094ugEjD9RU7fls/
	NEs8xvD3Ix1B+JTG5+qZfQOODH9QxhJ+AIC27ot1slnF/qgxoO3+hEGljf1gN45mt0hchWCD67QAv
	pkf/gvQ1QwAhBqWTYLlJ5/9ceVxjO3uMwSGKXVoi8CtNmldKnP2b7UMVvtoa36fGc2R3mDeoqfJMN
	RUZWme9gU4OCncQ5XsWfkbGMNY6NP5EQTsvjGiKCXN1UYjLOlSBdaDbPQVWteL8AUBRW52og+99z1
	4ClHuZqw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux5aQ-00000000rLL-0XaV;
	Fri, 12 Sep 2025 15:21:18 +0000
Date: Fri, 12 Sep 2025 16:21:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
Message-ID: <aMQ6bW-OoMWMVEFF@casper.infradead.org>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>

On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>  	 * swap_backing_dev_info is bust: it doesn't reflect the
>  	 * congestion state of the swapdevs.  Easy to fix, if needed.
>  	 */
> -	if (!is_page_cache_freeable(folio))
> +	if (!is_page_cache_freeable(folio) || !mapping)
>  		return PAGE_KEEP;

I feel like we need to keep the comment (assuming it's still true ...
which it probably is, although there's nobody who would think to update
this comment if it became no longer true).  I would certainly wonder why
we can have this !mapping test.

> -		/*
> -		 * Some data journaling orphaned folios can have
> -		 * folio->mapping == NULL while being dirty with clean buffers.
> -		 */

I approve of this simplification, and I think there's more work to be
done in this area.  Thanks for doing it.

