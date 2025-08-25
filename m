Return-Path: <linux-kernel+bounces-784666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39885B33F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4AB1A824EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7425334B;
	Mon, 25 Aug 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of7GO0su"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A14393DCA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124891; cv=none; b=PDMn6duwSHJIOqLjq/JZ+W48eWxhnk7gvZR1plpkUytsDC5I8TZQn9iWmNwlEYkV/zgNZVLflwhjvHMr/1vLEgCy2gRpa6D8NACTxF25Se9E5/0G/YMP0q7Dp/gv8TjLFNVpf7v9AR7iIgnt6gxG49SNqaKgyDXEZi1abArqYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124891; c=relaxed/simple;
	bh=s1PgCLxziYv3zEZVYuVsMh01+gdUdF0MsmjAHhr7TLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo9kzq0axWQCrmvRZVadgznNvxK1ZqYBJHokxA9G1nWKi67wzUW8m2j8Y8iC28idgwJabqwJ5g4vvYlR1dqnMZBi0q5DsJ6v11dTVuF+4c1/MwY6/XwJcC9WNDV142qq7VJ4PqP/doS2bsLtxhg09rAj5Yb5DANyLE9BL/SR9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of7GO0su; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so12806945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756124888; x=1756729688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPfDBfbpwUW+KOvZVoZK+orl1I1HkIgHCfW1U8nixbM=;
        b=Of7GO0su89bjnLiEObgnysXo8dyWKJ5vkAj4KHa1hCF3aUyzCUBScY99XxM8O80GGm
         2JiinDCRMxj/wymAZXHdvbbHnipIQrqY/5GCPL41iL7uJ4Wx8OOev6ANzl718HpTt/4N
         VMQdKJ2gE98vIQpayAjRlcUyBu5HUBtdemIBw2ExEfaPXZypx0fSrlbhdayRnO/6yer+
         26tvyeSH/xy9CCGrrEWZNTs8XzfuGMDcJ6KG4qY9/ETqs7CBLS+SHGHkv+l2kObLZXs4
         K4zr6scRbHza8x55qp3zd838nutekHvRKYQ//WP0M9nO8kGQh5NFTLszuoqJ9Y2ZVbbO
         BDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756124888; x=1756729688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPfDBfbpwUW+KOvZVoZK+orl1I1HkIgHCfW1U8nixbM=;
        b=XjEJFMwwXazl+eJQ9chKs2mVuofiVIZroF6vB/p//91c+fjsWL2HRWjwfyI4hS6XBl
         5kwCVf/LrNVxg839BZiwaq6ew9Y4muO3ntHtN9TI59R563S6/Bd66it29WLdJzTNuGRn
         Xv11VTvYPJNcrR0J0Pdg6b5iCgkqOZpT3uFoMxG7nXLdUW5BSdLPSsnarSomxT214v4D
         gzbIVQDMPlGLtz0bC18W5tToWu0DtqU4DduiEj6OFeNUm/jA8y93gtoeYd5FG5b4bZ6B
         8tew1adxAx0b5468kjWJz4jjkn3DON9WD7YCO6gD2UggIITN+RZ/eyTCFq7TIxcT7F6F
         yL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqDFXygrPuwoFOFp3pdN2KXhqZ671Mr7zp7kz0Au1D7YvWNFcTwK+vxlXyR3cjOPOLUBcFwS1ZIsis2RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewA7WeJBgJFvGKmA4R5OBD+p2dblqH51uZqaSorN2eXaXNpRb
	NacXrU/LVIYaPc8nEOmL+JIJgBNfkwXQu645yikFDYUSotSemCNTOIj6sz5zNg==
X-Gm-Gg: ASbGncvAtmW3yhomos1vPBOSndmaQxuQffQ75B2NVzswS6Edc9yl+FGavGSfd/N1J6v
	28Z4R90BiI2LlULxQMIx9MG881mYiXZcGPO776h/P47H14IYsC+TWQF7gpuSv5Px6x4yKcds1ni
	Wh31S5TsrofyoOLYvLDjkT9spBrMRrcV9z3XNRpyzCRRoDnpW7pqsU/tj3gackiReqIhWseCwW3
	uq0XSk/zlFpc9aKKDo5RH6o53ds4zI+Imj8l58Tsl2DyQJzDsrQYM7vCZljxURt1Yz1qrl3O2lS
	H3GCZzscgbYdTWFu50XX6xAQvvZ1VgTBMue9iFYLrX4KvD87oWM5rU28nJ3aLc6HP0UlyWdfNyk
	uwxYrp5SkIoK7CT/d9Y9mrNLuWdjH5HwJZYU=
X-Google-Smtp-Source: AGHT+IESgx9HYKPain/SQOUHC5A3qxDYmJ3/amsQb6PIdB8JBVmGFTgZXWbCC7qK1K4LPP+7blyqdQ==
X-Received: by 2002:a05:6000:2585:b0:3b9:16a3:cf9b with SMTP id ffacd0b85a97d-3c5da64a8fbmr10103861f8f.5.1756124888325;
        Mon, 25 Aug 2025 05:28:08 -0700 (PDT)
Received: from f (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753adf7sm107780735e9.7.2025.08.25.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:28:07 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:27:58 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: readahead: improve mmap_miss heuristic for
 concurrent faults
Message-ID: <ynl23xmeglxarrkrmh4r3sj3idvqbofwatrnhgx6tsl4zfrsxp@juc5kmjelwjn>
References: <20250815183224.62007-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815183224.62007-1-roman.gushchin@linux.dev>

On Fri, Aug 15, 2025 at 11:32:24AM -0700, Roman Gushchin wrote:
> If two or more threads of an application faulting on the same folio,
> the mmap_miss counter can be decreased multiple times. It breaks the
> mmap_miss heuristic and keeps the readahead enabled even under extreme
> levels of memory pressure.
> 
> It happens often if file folios backing a multi-threaded application
> are getting evicted and re-faulted.
> 
> Fix it by skipping decreasing mmap_miss if the folio is locked.
> 
> This change was evaluated on several hundred thousands hosts in Google's
> production over a couple of weeks. The number of containers being
> stuck in a vicious reclaim cycle for a long time was reduced several
> fold (~10-20x), as well as the overall fleet-wide cpu time spent in
> direct memory reclaim was meaningfully reduced. No regressions were
> observed.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> ---
>  mm/filemap.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c21e98657e0b..983ba1019674 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3324,9 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>  		return fpin;
>  
> -	mmap_miss = READ_ONCE(ra->mmap_miss);
> -	if (mmap_miss)
> -		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	/*
> +	 * If the folio is locked, we're likely racing against another fault.
> +	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
> +	 * times for a single folio and break the balance with mmap_miss
> +	 * increase in do_sync_mmap_readahead().
> +	 */
> +	if (likely(!folio_test_locked(folio))) {
> +		mmap_miss = READ_ONCE(ra->mmap_miss);
> +		if (mmap_miss)
> +			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	}

I'm not an mm person.

The comment implies the change fixes the race, but it is not at all
clear to me how.

Does it merely make it significantly less likely?

