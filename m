Return-Path: <linux-kernel+bounces-801076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9DB43F87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8633B7B09BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796327A124;
	Thu,  4 Sep 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IC+UnnTX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22671FBEBE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997300; cv=none; b=JeX70a6SpzfsXypx5OFILYsHfcKs61ZVMgxoYFkoRglqTV9NmeCRZ2vWhuQBfuN6J070lXZxV9rmgGYKj0VkNld1G9mIsA67NQ7+9ps8bkHavrX6DJt01FyACHOz1df0tvRQXEos050q3oW9qjRp9J8gMVdnRtePfbnX+R/eJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997300; c=relaxed/simple;
	bh=xHYUfZdrqWczqWo3UI45mBHt+VFA2+VFCBIllbJitmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzaff/N5bJb8oUJD2UYrZx48tjWcdoOIQvw01hUOntyUSdvIemxqjSsgJ5NsV1SbYu5RZsC3O2WS0ZT6Z0au1IBugJU8KupIty8fqTcOzYcOIkseiLn6KIZrCXrIMvVegWtVy8YLWxUrB6m7+cUrg0pBcOihJ9vgFLui0N6Txv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IC+UnnTX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso10892885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756997296; x=1757602096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Sf9UE3EF5HYpffcmBwy4ps10mS4KNLSqgfI9CuUyY=;
        b=IC+UnnTXcLun1B4Zid0IoBFZHjPML652UdqSWVu1Qm/gz9dvN3Rt3iXFJvyjSzMb29
         lmBwJ78YO+qBP1fWBip8s8y6936hNIGbGjn1hS40cgIbaplvIfK9hfk4i8+QT83NhpD8
         ZyTwWCWryGhc5PxtLLXwMpHxOpXzzLxCj6mf8bgitZVuXsIakwq56XbB/nKIbkeXy+H+
         aYeO08V+FKZr9tGdTkdk2Y3yriUaesJfuJ8b3e0SHXVz6UWgViCpPZOJK55BGq8LEv9j
         EVpD9WKgT8HQUPNNqBMX9BoB/iGccwEyrzmFIKU4Zs6nPa0at+0dkSWjGBVPy/PgMO3b
         4cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756997296; x=1757602096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6Sf9UE3EF5HYpffcmBwy4ps10mS4KNLSqgfI9CuUyY=;
        b=im18E8gVgN+LvWyo3+6j38CtfvMLT7rq8cXJeqyRQrWCh5pQW4Y2/Bnco3igus0LPR
         IFKlkqjlj0TkDekN2w44Q5PYoeLm9QY0vncYL95a3tGvmrs9ds7DrzAAezN24J/4Ah6z
         +acGEQ0Z03Czikk4cxiCVSDaKT/AbfYtvLD1B8xs0uo5APFLqxq87f3Ae5PcuPL6bBys
         6GAz5Bc/2RGQHmhm62kxOLA+wqWOueDi4V9ZrETtfrM6ZZK3q+g3VBZ64yqx50VmrZsC
         7Orq7Z8BSMmCXlIIBjuUPnNUrAMRN4nLIGSAWornKx0thVk4bxJHy2QSU/tQUKOGPki/
         Hunw==
X-Forwarded-Encrypted: i=1; AJvYcCWwubwYb30xRwQdoNNAvQcc+ADY29XdffjmDLxbD/es5W5qR584S5Mpuxx7pxNOPcLYjp+cch2bqQSOkaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUtrf9MGssAVkar+F6fZst6lPGEhSjkarL78hCFAQWXkwxHvW
	3PArqJOXcFXZy7obdCD6QBwX/XXiN5LMIY2Hphbn9eGkXxN4qB6D6xfZ5sB3/jpq5zk=
X-Gm-Gg: ASbGnctQzvlkhHfYfjrVYuesTBg08fblCBnkDHngJpaGgaWB0ouyJb4jdTpSKo+4Oe9
	7UMVLPIySIwUExRt4t5Zf2yrIhXiquTr2uvj8VhJ75LIKDM6ncg0LS2OxwXJJ3uLuesjqTYnV3w
	o+4cw3UFD3Qp3eaZes5WmynRGgOvcZ8nfwDrdLiu3z73+LjWmaPXUQgX+TMkSjzVh6mOUTmiErI
	1hOpo5Y/5wHFPcIjz+DrlvaBj57vm92ZLjZNT9D2JH9PWHt9TmGTo/1T8cvbGp8jajy1clX44LY
	NbR0akurZTPoOwnv1Zkx1UGmG/GiPYIEac8nXdZqTrpCT3T5CKhTA+Pb1ME1363O3f7LmZVQPcv
	2vT9a9/v4nrIII2zVg0eZ+gBsLwcQQFapUkZUW1JjyLlFkpQMwBmR9g==
X-Google-Smtp-Source: AGHT+IFmEWOaYXgd2qYtZqy5eD425678QUgMGGgTXiY3gZfol0LS2F7CgHBQrjxKscsjVJaOReKoiw==
X-Received: by 2002:a05:600c:1f0e:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b855335a8mr170497585e9.11.1756997296078;
        Thu, 04 Sep 2025 07:48:16 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dcfcb1497sm21106915e9.1.2025.09.04.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:48:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:48:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	liulu.liu@honor.com, lorenzo.stoakes@oracle.com,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aLmmrvPb6mFHzqCc@tiehlicka>
References: <aLg7ajpko2j1qV4h@tiehlicka>
 <20250904122438.22957-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904122438.22957-1-zhongjinji@honor.com>

On Thu 04-09-25 20:24:38, zhongjinji wrote:
> > On Wed 03-09-25 17:27:29, zhongjinji wrote:
> > > Although the oom_reaper is delayed and it gives the oom victim chance to
> > > clean up its address space this might take a while especially for
> > > processes with a large address space footprint. In those cases
> > > oom_reaper might start racing with the dying task and compete for shared
> > > resources - e.g. page table lock contention has been observed.
> > > 
> > > Reduce those races by reaping the oom victim from the other end of the
> > > address space.
> > > 
> > > It is also a significant improvement for process_mrelease(). When a process
> > > is killed, process_mrelease is used to reap the killed process and often
> > > runs concurrently with the dying task. The test data shows that after
> > > applying the patch, lock contention is greatly reduced during the procedure
> > > of reaping the killed process.
> > 
> > Thank you this is much better!
> > 
> > > Without the patch:
> > > |--99.74%-- oom_reaper
> > > |  |--76.67%-- unmap_page_range
> > > |  |  |--33.70%-- __pte_offset_map_lock
> > > |  |  |  |--98.46%-- _raw_spin_lock
> > > |  |  |--27.61%-- free_swap_and_cache_nr
> > > |  |  |--16.40%-- folio_remove_rmap_ptes
> > > |  |  |--12.25%-- tlb_flush_mmu
> > > |  |--12.61%-- tlb_finish_mmu
> > > 
> > > With the patch:
> > > |--98.84%-- oom_reaper
> > > |  |--53.45%-- unmap_page_range
> > > |  |  |--24.29%-- [hit in function]
> > > |  |  |--48.06%-- folio_remove_rmap_ptes
> > > |  |  |--17.99%-- tlb_flush_mmu
> > > |  |  |--1.72%-- __pte_offset_map_lock
> > > |  |--30.43%-- tlb_finish_mmu
> > 
> > Just curious. Do I read this correctly that the overall speedup is
> > mostly eaten by contention over tlb_finish_mmu?
> 
> Here is a more detailed perf report, which includes the execution times
> of some important functions. I believe it will address your concerns.
> 
> tlb_flush_mmu and tlb_finish_mmu perform similar tasks; they both mainly
> call free_pages_and_swap_cache, and its execution time is related to the
> number of anonymous pages being reclaimed.
> 
> In previous tests, the pte spinlock contention was so obvious that I
> overlooked other issues.
> 
> Without the patch
> |--99.50%-- oom_reaper
> |    |--0.50%-- [hit in function]
> |    |--71.06%-- unmap_page_range
> |    |    |--41.75%-- __pte_offset_map_lock
> |    |    |--23.23%-- folio_remove_rmap_ptes
> |    |    |--20.34%-- tlb_flush_mmu
> |    |    |           free_pages_and_swap_cache
> |    |    |--2.23%-- folio_mark_accessed
> |    |    |--1.19%-- free_swap_and_cache_nr
> |    |    |--1.13%-- __tlb_remove_folio_pages
> |    |    |--0.76%-- _raw_spin_lock
> |    |--16.02%-- tlb_finish_mmu
> |    |    |--26.08%-- [hit in function]
> |    |    |--72.97%-- free_pages_and_swap_cache
> |    |    |--0.67%-- free_pages
> |    |--2.27%-- folio_remove_rmap_ptes
> |    |--1.54%-- __tlb_remove_folio_pages
> |    |    |--83.47%-- [hit in function]
> |    |--0.51%-- __pte_offset_map_lock
> 
> Period (ms)           Symbol
> 79.180156             oom_reaper
> 56.321241             unmap_page_range
> 23.891714             __pte_offset_map_lock
> 20.711614             free_pages_and_swap_cache
> 12.831778             tlb_finish_mmu
> 11.443282             tlb_flush_mmu
> 
> With the patch
> |--99.54%-- oom_reaper
> |    |--0.29%-- [hit in function]
> |    |--57.91%-- unmap_page_range
> |    |    |--20.42%-- [hit in function]
> |    |    |--53.35%-- folio_remove_rmap_ptes
> |    |    |    |--5.85%-- [hit in function]
> |    |    |--10.49%-- __pte_offset_map_lock
> |    |    |    |--5.17%-- [hit in function]
> |    |    |--8.40%-- tlb_flush_mmu
> |    |    |--2.35%-- _raw_spin_lock
> |    |    |--1.89%-- folio_mark_accessed
> |    |    |--1.64%-- __tlb_remove_folio_pages
> |    |    |    |--57.95%-- [hit in function]
> |    |--36.34%-- tlb_finish_mmu
> |    |    |--14.70%-- [hit in function]
> |    |    |--84.85%-- free_pages_and_swap_cache
> |    |    |    |--2.32%-- [hit in function]
> |    |    |--0.37%-- free_pages
> |    |     --0.08%-- free_unref_page
> |    |--1.94%-- folio_remove_rmap_ptes
> |    |--1.68%-- __tlb_remove_folio_pages
> |    |--0.93%-- __pte_offset_map_lock
> |    |--0.43%-- folio_mark_accessed
> 
> Period (ms)           Symbol
> 49.580521             oom_reaper
> 28.781660             unmap_page_range
> 18.105898             tlb_finish_mmu
> 17.688397             free_pages_and_swap_cache
>  3.471721             __pte_offset_map_lock
>  2.412970             tlb_flush_mmu

yes, this break down gives much more insight. Percentage is quite
misleading as the base is different. Could you also provide cumulative
oom_reaper + exit_mmap(victim) time in both cases?


-- 
Michal Hocko
SUSE Labs

