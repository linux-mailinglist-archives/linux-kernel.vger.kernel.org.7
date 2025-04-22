Return-Path: <linux-kernel+bounces-614618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46CEA96F21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B31A17C4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9028C5C5;
	Tue, 22 Apr 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KkmYdZRA"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60438284B5C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332911; cv=none; b=nkEeCruTZiupXPgCOtBZ64YAgNWJvFvjd5plWu32/wEaFTKI3XeJ119tfmzVovbhlNOpAbHkZo19bFIg1PtQKc5sf8Sc9Z4LCoMZy7RFuj7JUguyfsyfRQlSJQWYXmfj8QkDssjhgc2wgR/5G95npyqas9YTCyuoPLBkaHRzT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332911; c=relaxed/simple;
	bh=zHWh4uSIApkmGP5MhyX7KcUm0obTMv71a5TDLmbBQ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpQ+/gkUDpyU3vvEXMvL6IRnPo5gUxW3ZtSgrFq0Y77PuVNpWS5MljtGvYrJOH4oVl22Xhy2Cdh5KPUgvReGgSVK0NOJ8HaGeBvYe++gJp2So2I/l4M3FDVgRgnIMNUp2vK/T7huqWPuoysjV38H3bhKa67Y+1TPlp3UaE96Ys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkmYdZRA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 07:41:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745332896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vyd+N7ix2s2qiHf7u+8PYPa1V/Nz2f9Sgk8z0rzIogw=;
	b=KkmYdZRAY57gqhIHaTcv3T4asZSyWxp+41awkJRHBMwHupZ+Ny0P8O25Uj98mqp2/XNb5v
	zgkEyJxfgTh7/dSUqRKZapHjKrUx8FURAEQcPkl1WQ4KndYhUNMmqHi1i1JsRoKRF6YSs7
	hQ6pA4setMf7aM/il45tyGApQfXsNCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hughd@google.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] mm: swap: add a separate type for physical
 swap slots
Message-ID: <aAeqlE95yQA16HT3@Asmaa.>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <20250407234223.1059191-4-nphamcs@gmail.com>
 <20250408141555.GA816@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408141555.GA816@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 08, 2025 at 10:15:55AM -0400, Johannes Weiner wrote:
> On Mon, Apr 07, 2025 at 04:42:04PM -0700, Nhat Pham wrote:
> > In preparation for swap virtualization, add a new type to represent the
> > physical swap slots of swapfile. This allows us to separates:
> > 
> > 1. The logical view of the swap entry (i.e what is stored in page table
> >    entries and used to index into the swap cache), represented by the
> >    old swp_entry_t type.
> > 
> > from:
> > 
> > 2. Its physical backing state (i.e the actual backing slot on the swap
> >    device), represented by the new swp_slot_t type.
> > 
> > The functions that operate at the physical level (i.e on the swp_slot_t
> > types) are also renamed where appropriate (prefixed with swp_slot_* for
> > e.g). We also take this opportunity to re-arrange the header files
> > (include/linux/swap.h and swapops.h), grouping the swap API into the
> > following categories:
> > 
> > 1. Virtual swap API (i.e functions on swp_entry_t type).
> > 
> > 2. Swap cache API (mm/swap_state.c)
> > 
> > 3. Swap slot cache API (mm/swap_slots.c)
> > 
> > 4. Physical swap slots and device API (mm/swapfile.c).
> 
> This all makes sense.
> 
> However,
> 
> > @@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
> >  	return atomic_long_read(&nr_swap_pages);
> >  }
> >  
> > -extern void si_swapinfo(struct sysinfo *);
> > -swp_entry_t folio_alloc_swap(struct folio *folio);
> > -bool folio_free_swap(struct folio *folio);
> > -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> > -extern swp_entry_t get_swap_page_of_type(int);
> > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
> > -extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > -extern void swap_shmem_alloc(swp_entry_t, int);
> > -extern int swap_duplicate(swp_entry_t);
> > -extern int swapcache_prepare(swp_entry_t entry, int nr);
> > -extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> > -extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > -extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> > +void si_swapinfo(struct sysinfo *);
> > +swp_slot_t swap_slot_alloc_of_type(int);
> > +int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
> > +void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
> > +void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
> >  int swap_type_of(dev_t device, sector_t offset);
> > +sector_t swapdev_block(int, pgoff_t);
> >  int find_first_swap(dev_t *device);
> > -extern unsigned int count_swap_pages(int, int);
> > -extern sector_t swapdev_block(int, pgoff_t);
> > -extern int __swap_count(swp_entry_t entry);
> > -extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
> > -extern int swp_swapcount(swp_entry_t entry);
> > -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> > +unsigned int count_swap_pages(int, int);
> > +struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
> >  struct backing_dev_info;
> > -extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
> > -extern void exit_swap_address_space(unsigned int type);
> > -extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> > +struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
> >  sector_t swap_folio_sector(struct folio *folio);
> 
> this is difficult to review.
> 
> Can you please split out:
> 
> 1. Code moves / cut-and-paste
> 
> 2. Renames
> 
> 3. New code
> 
> into three separate steps

+1, I agree with the fundamental change (and is something that I
attempted before), but it's really difficult to parse :)

Also, weren't the swap slots scheduled for removal or is my brain making
stuff up again?

