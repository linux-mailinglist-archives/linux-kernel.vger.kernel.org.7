Return-Path: <linux-kernel+bounces-761669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AEB1FD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15001896F41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050C2C86D;
	Mon, 11 Aug 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+ge23i9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6E13AC1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871340; cv=none; b=CpaloWzRAmHSsjBTuqjQJMwrLPMoYcJHM8P89jI+KpwQlXqjKybMSdL1CkF6dkYmZI+xGqfJomRXhHglVa0UNf2V40S0UqO8HvA2B/9Md9AW1rONqMkAFF6P59DiTeN5a4N0ja5MbZzBhP0nFtoLtQgXGUxRX1lZw2/Oj995an0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871340; c=relaxed/simple;
	bh=1bMxe8/8gv461TF/a2mhN7PaTFK6dAK9xLa4CajO5Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv1WF/2L9MM2gQ+nR+6sS07xdDXH6ptT4XJZAq2N1B0VwgfgY2EM04T5FlLQ/fJ9qxQ65Ds+eiTGHzkRMwIoouxyeTHSdCpUxEaAk74ROBAyloOlxJWDbswI11+6zIBScL/53Kjd6vC8PKGmENfPFGnoKk5BBJRsvb20YA/ksvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j+ge23i9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y+8mZzSO0k2kTLnKNSayaQjHBFlZoHnAiE4F0939UhM=; b=j+ge23i9X82gAdxkZ/G800m3II
	xuxx59avI6IJ2yg8YXqnwhb0wMw4WpfyaehDuhG7Jx3/KRZB65L3TytuPRGG0W8fCzpRgYWRcCFZB
	omRYt7YMBtE4bC2uUuz72J2p0lBOhAgynX+cwbuIvplMpKsDxXvVmRUno7UO/zRABle7r3DmSSUMY
	uJ3U1lCj2YHzsW7KB2F3SQhuusxvAa1zqLXJxFi8i5XPQg0bLB5KBxClcFjKM4C8Bx6ka7hCYhJCc
	MdYs0XVYmG6UcJEKf8jUyKwtprrBdUg+Gn9e2HdcpbLAjt/RAXU7ks1wY7zdH5if2CcE3mQFVJVR2
	ehX8IErg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulGCK-0000000GBdP-0gwH;
	Mon, 11 Aug 2025 00:15:33 +0000
Date: Mon, 11 Aug 2025 01:15:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Use max() to simplify
 hugetlb_vmemmap_optimizable_size()
Message-ID: <aJk2IygsxWKYf17u@casper.infradead.org>
References: <20250810214745.2368-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810214745.2368-2-thorsten.blum@linux.dev>

On Sun, Aug 10, 2025 at 11:47:45PM +0200, Thorsten Blum wrote:
> Use max() to simplify hugetlb_vmemmap_optimizable_size() and improve its
> readability.

That ... isn't clearer.

>  {
> -	int size = hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE;
> -
>  	if (!is_power_of_2(sizeof(struct page)))
>  		return 0;
> -	return size > 0 ? size : 0;
> +
> +	return max(0, hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE);
>  }

