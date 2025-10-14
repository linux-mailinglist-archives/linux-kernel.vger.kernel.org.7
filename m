Return-Path: <linux-kernel+bounces-852604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7573BD96F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4873F19A0042
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31730F94E;
	Tue, 14 Oct 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QZWOd6Av"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78934BA46
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445926; cv=none; b=ML9spwEFgpo4JOrnWZew4Htu1g+9qc6vxmRgki+TiVvllZT0uhZOzUrFYN9hw5qMk0diIAkD3RqxixwoAl/+BsfJjbisY7GrN2VpMDvxQwq/YW/WolFxgOWltm7i647w5ViCesedDQP9HUfbyUTSH5aAxIY+ArEFLlJFd75tuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445926; c=relaxed/simple;
	bh=2HloXGZvRD+88/eG4ZgEhcmqaAV/Ri/MXMiO2AoLeJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLOkR0hEpzzUE3QsKRLp3FpZUFsdAhCprmZR+5Zn0X7Pa1iXSAkQFK5cTtIGTshEBb5c7/poTJQc3I1zuM0UqtdgtRQQtGimk6D/pEb22sFSdNDuQ+24ZuA9OprRz1EDxIKz0KT40jUGeHEVHC7q5eUd8HoauUI0lHQUwHYREC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QZWOd6Av; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b404a8be3f1so123245066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760445922; x=1761050722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEOQpQJo98QyfYnBlnV0kP+HUCRx4XT+4+xOb+xrqYg=;
        b=QZWOd6AvX4xSk0ozoQ8EOxK8HGRVtr3tBQLZS8CD8z31RdQDUk7swwzco5uHtneiSV
         uAb8th1Q8utKWpeyaoLB6e2i0J3zjcrFUJyKF+Agy+LvwgmBsE9fJKKgqW9JHEKTfLNO
         yVrA75gr3tTs5Xqioj2lfxfmQE0kPxn411XNLq10cfT/C+CbkuW2e3pdyW2L7whXLW5K
         2jcXGlOZ4UV4sSy1nFZ6K8F9TTDyPZvg1vZ5gr2it2dee/2KrzbVnG1ZSTq5pJtLGC5F
         NCc/iLm/3fWM0KLMR/h6OwQu5wN8eusTXWrWcHRmmUI7F+RnaqaJi7tdb0tu4pgRnSGP
         YGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445922; x=1761050722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEOQpQJo98QyfYnBlnV0kP+HUCRx4XT+4+xOb+xrqYg=;
        b=VB6m3oiv13o4wAm3/Wc4rh6N4cAF4Dc9AsVPnigerWMebRycRWoHauYs3qEbQ/mHXW
         0xsXaGSaPMOUI3Bbq82XpgeMdCPtdiPhVo847yEpD8VW/wqwZmU33fSoItkmFNlw+aJO
         3dwbAzTdOyPf2PfyWYlQs3xBlaSCPZ9DpGvYgnHL6cQnbh2PCXsMMP8hvcNQ1GjeQGuo
         DUe31mbZrD8ZMy2ndBtUHtAZA+o7gme1iKz+0TwKOnt5bnuPW6FIgVWvTW1BN8miwlQI
         uVEsIR8TpykT0jMNaN6tk+3/Vq5bWbCB+3mRJ2q1B/wEA++kFJsLErKeUAegMsRFwhF+
         BNfw==
X-Forwarded-Encrypted: i=1; AJvYcCW/E17fvqCS6vrUQZfqhwgXEITmgHIbHN+S20pBjfzNW5WKTk8EzOOlxBvcdMB9qqnlB1qRAnm5RSFfzP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSg7o+j/THx+udT3+jd0KBNAFi6P2+5rbzdRvhY9PO31wc/Jbj
	gTMRq29EaYgVTi+auqFLUQxihMH4czimD7a9d+9mVTaSJT7WHtqxjCQrG9WR9p15r9s=
X-Gm-Gg: ASbGnctqwcOnfeYhu++e8HJBY8h2/u1IEuxUxOMZb+Y36kl+v/K4oM6OxxMWKEMOfL2
	QUWF6hnabDqvl45h6K375t6DqH2ZA4s2Lbw5AUCo/kyUNOpYdxmiGizPy7sTflMTzVNBPe3dldC
	CUWM+SCfJvbgbCac5fIfGGjmUeVBEYiyCIXc7rrOFkzN3vRzYBcGXypzf8bGyIP+S1lKlPkxXw/
	5KpoYzETZnW4vTDFX5ruz84ObL/yVcC47wItzfjWEnGRPPmF8sJ7xGfTNd61ATDFbkABf5gyed8
	xtK8vVUL+dty8WQr0hM3PCFM80Ev6Auh7WfKJqIWXAACmsJPOQmd0bo/fxdiPcqEgL7MrH0aU5a
	9Ixb3Zw5WbnF/o/6xwxHeYvosothvjzePnwWdGWzTL60pJnIKJFYC8oeoUnc/uTxJWMHNmZ0C8J
	nCHg==
X-Google-Smtp-Source: AGHT+IF98YZGXnc/a9+tF96u8G13aSwGmApwD+ogJyUi8W1JPjF4gTRZUKJnX0ICaKrlb9YoA4BxHw==
X-Received: by 2002:a17:907:7ea6:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b50ac6cd23fmr1429210866b.9.1760445921504;
        Tue, 14 Oct 2025 05:45:21 -0700 (PDT)
Received: from mordecai.tesarici.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d66cc4b8sm1150612066b.30.2025.10.14.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:45:21 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:45:13 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Mel Gorman
 <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Sumit
 Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 <steve.kang@unisoc.com>
Subject: Re: [PATCH 2/2] driver: dma-buf: use alloc_pages_bulk_list for
 order-0 allocation
Message-ID: <20251014144513.445a370d@mordecai.tesarici.cz>
In-Reply-To: <20251014083230.1181072-3-zhaoyang.huang@unisoc.com>
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
	<20251014083230.1181072-3-zhaoyang.huang@unisoc.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 16:32:30 +0800
"zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The size of once dma-buf allocation could be dozens MB or much more
> which introduce a loop of allocating several thousands of order-0 pages.
> Furthermore, the concurrent allocation could have dma-buf allocation enter
> direct-reclaim during the loop. This commit would like to eliminate the
> above two affections by introducing alloc_pages_bulk_list in dma-buf's
> order-0 allocation. This patch is proved to be conditionally helpful
> in 18MB allocation as decreasing the time from 24604us to 6555us and no
> harm when bulk allocation can't be done(fallback to single page
> allocation)
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 36 +++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index bbe7881f1360..71b028c63bd8 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -300,8 +300,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
>  	.release = system_heap_dma_buf_release,
>  };
>  
> -static struct page *alloc_largest_available(unsigned long size,
> -					    unsigned int max_order)
> +static void alloc_largest_available(unsigned long size,
> +		    unsigned int max_order, unsigned int *num_pages, struct list_head *list)

This interface feels weird. Maybe you could return the number of pages
instead of making this a void function and passing a pointer to get that
number?

>  {
>  	struct page *page;
>  	int i;
> @@ -312,12 +312,19 @@ static struct page *alloc_largest_available(unsigned long size,
>  		if (max_order < orders[i])
>  			continue;
>  
> -		page = alloc_pages(order_flags[i], orders[i]);
> -		if (!page)
> +		if (orders[i]) {
> +			page = alloc_pages(order_flags[i], orders[i]);

nitpick: Since the lowest order is special-cased now, you can simply
use HIGH_ORDER_GFP here and remove order_flags[] entirely.

> +			if (page) {
> +				list_add(&page->lru, list);
> +				*num_pages = 1;
> +			}
> +		} else
> +			*num_pages = alloc_pages_bulk_list(LOW_ORDER_GFP, size / PAGE_SIZE, list);
> +
> +		if (list_empty(list))
>  			continue;
> -		return page;
> +		return;
>  	}
> -	return NULL;
>  }
>  
>  static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> @@ -335,6 +342,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	struct list_head pages;
>  	struct page *page, *tmp_page;
>  	int i, ret = -ENOMEM;
> +	unsigned int num_pages;
> +	LIST_HEAD(head);
>  
>  	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>  	if (!buffer)
> @@ -348,6 +357,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	INIT_LIST_HEAD(&pages);
>  	i = 0;
>  	while (size_remaining > 0) {
> +		num_pages = 0;
> +		INIT_LIST_HEAD(&head);
>  		/*
>  		 * Avoid trying to allocate memory if the process
>  		 * has been killed by SIGKILL
> @@ -357,14 +368,15 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  			goto free_buffer;
>  		}
>  
> -		page = alloc_largest_available(size_remaining, max_order);
> -		if (!page)
> +		alloc_largest_available(size_remaining, max_order, &num_pages, &head);
> +		if (!num_pages)
>  			goto free_buffer;
>  
> -		list_add_tail(&page->lru, &pages);
> -		size_remaining -= page_size(page);
> -		max_order = compound_order(page);
> -		i++;
> +		list_splice_tail(&head, &pages);
> +		max_order = folio_order(lru_to_folio(&head));
> +		size_remaining -= PAGE_SIZE * (num_pages << max_order);

This looks complicated. What about changing alloc_largest_available()
to return the total number of pages and using PAGE_SIZE * num_page?

Ah, you still have to look at the folio order to determine the new
value of max_order, so no big win. Hm. You could pass a pointer to
max_order down to alloc_largest_available(), but at that point I think
it's a matter of taste (aka bikeshedding).

Petr T

> +		i += num_pages;
> +
>  	}
>  
>  	table = &buffer->sg_table;


