Return-Path: <linux-kernel+bounces-723487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C20AFE781
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EBA1C47ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F217293B69;
	Wed,  9 Jul 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8YoKb/G"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC728F93E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060026; cv=none; b=l5eie2aRdvaQoTExF3fELqlK2XKxLZV350UESK4aLI1rN3lzPXmGnE7CI9grgw/QiTjHXRiBr0dEFD0lRWfNwxsAR5gh0qzRiyzQxMto/mu54tUyhHtyQKBFaB0xxTpQGnLvd2rVdkbfFDncevvSNjjlSv8SpAiN7rUWUSWkJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060026; c=relaxed/simple;
	bh=Vg50uWQ3dAcOxwrrRmtisHZtbTXidg5T9pIJLrEBByw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB+wdePLJO9W54+iKzR7zrGcWGswLfusUu2WB8c+xQbBaLuKpRoeklzqaNu8Pi2jVVaOSLDVw9Va9n7nSIm4LFlJB3hxMxsi8ilwyVUQYBbPdLU9mExxhoWnGaGutF+SA7njCdNmmrIZHYF8/7A6sBeSiaPNUCUkZB4CaRfBlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8YoKb/G; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-558facbc19cso441298e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752060023; x=1752664823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txd42CVnl5W2pOlG8rm4KcHzy5Vi4ZE+YD5Q4QXw2ko=;
        b=Z8YoKb/G4old42RlM7/CCFIZJSzrjgRS2qHhSWcp7FY5VbDAGLcJvpoOzN8/1cH2qJ
         HL+u4GKRqWhcsBX4viJcqPMJGfY9aB/aDeTTUIroO0DgvHhkWz7GvSfZwyOEOxBCfopw
         +/ou7B5g4CkypVNNRTVqQjuo/MCBCIhrK3+lScqRKQI8lyrTNLtEk+FvM01wkEuWecRb
         LGbFgKcvI0C4u/tRrsrOnvJyPJ/cXIpCd1jJ6rSK8L8IX8WMX/7+tmu+H1zenugpfNpA
         wSBLGivozD2YswhbKMYTuoahPuSuzcmyH5N7/1ZY5H6Zas8rR5MC0KBZNy9fvfoQtNnz
         3b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060023; x=1752664823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txd42CVnl5W2pOlG8rm4KcHzy5Vi4ZE+YD5Q4QXw2ko=;
        b=gzfKwbTsaqLzD3Ug1iMTZUiLO+GBW8jXL+cB/U6U9WMmV3nGApNoCKla1Xo0NNvsJ/
         U37CCp4C0+VXTEZxkFp9PpCHJhaZLiHZHklXkzBOGpygthCQ5vqhWVuOCa6GvIpXsHHK
         L5aAlRHz+3crFedy8xIZHOnxMp/me2T6UeksFLwZDPlkB+t8ANugtCH1PYf1GTzF6ovc
         u5rS5I83bPKQFz0fs+O0V8An4ZrHquIWo+gyx+BZPCPd1k/FAS/kgFHI5UP7vcNKn+uT
         /z+iHAPufG4wZ9M/pyFmT3mp4OLjdVNgqe/N0kedT2UcGtQ7P/iPZeVNPPWJjQ7Uhoo8
         ZgWw==
X-Forwarded-Encrypted: i=1; AJvYcCWpfP1Mdr9Yiyk7V30Qv3hZVrvmj9mXTlAeDyIjvAyKPsJDvFNMwbSqRX0CDf/6pKpW+sHMmvZHM2sZv7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2A4F2QzT+4OX8y7eWZsYqlYmzpTkvUeU2/KpfAeNpcno9jNU
	ksLtGqm/iMx9+1s8TuA4syzlqiv6otQUyZ67gMjAyWhJRi0JpdbPDpPu
X-Gm-Gg: ASbGncuu56nrvnJ2/No4URODXyG8WjEZab3r/W1Bpp2e+ZzBunOktl4A+sTILIW7Uah
	J0RyTFV0MCpUVNtwwjO84TXj9rzvgqbLEUlhecReXPhYNWx4HEmQA5d9a+htUm+IZoBZ9MZKhDz
	oEus2N/ePpjdfS41R+6gtu4RvoAyvPV++2mqYs6b+kSiqL9aNDRVfOojra2r6Ldne0s5Y6aQ+eU
	QSgPplsuclPpk0UlMIAJ4mgYhcxNR/rdwAL6jHW96poVbFAl9dkuTpcEtX8kXi5yXc7FlGQIyH8
	27Hh7YuZSKU0XjECDHFIZ++NcdBgsq8YyN/ub+nOD8LH+nKSflm4M62Ath355+TGlFslfiTxvLP
	JItJCaSHXEjzlxqWq
X-Google-Smtp-Source: AGHT+IFkKP0/bxjxUSaylRZNBFb2jmXliX/Cc8L9pI2bxgyUjZXPUeSrW8ZKF4kKZJ2HOh4R2sl9mA==
X-Received: by 2002:a05:6512:686:b0:553:24b7:2f6f with SMTP id 2adb3069b0e04-558fa91d29fmr771112e87.51.1752060022689;
        Wed, 09 Jul 2025 04:20:22 -0700 (PDT)
Received: from pc636 (host-90-233-203-201.mobileonline.telia.com. [90.233.203.201])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-558fdb6a30esm67803e87.179.2025.07.09.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:20:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 9 Jul 2025 13:20:20 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 6/7] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aG5QdPWXuvcB4Z6k@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-7-urezki@gmail.com>
 <aGtzgOXdhAAOTBhs@tiehlicka>
 <aG0Ozc3Mro95djxn@pc636>
 <aG03zMoVJSVJz5KK@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG03zMoVJSVJz5KK@tiehlicka>

On Tue, Jul 08, 2025 at 05:22:52PM +0200, Michal Hocko wrote:
> On Tue 08-07-25 14:27:57, Uladzislau Rezki wrote:
> > On Mon, Jul 07, 2025 at 09:13:04AM +0200, Michal Hocko wrote:
> > > On Fri 04-07-25 17:25:36, Uladzislau Rezki wrote:
> > > > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > > > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > > > 
> > > > - nested_gfp flag follows the same non-blocking constraints
> > > >   as the primary gfp_mask, ensuring consistency and avoiding
> > > >   sleeping allocations in atomic contexts.
> > > > 
> > > > - if blocking is not allowed, __GFP_NOFAIL is forcibly cleared
> > > >   and warning is issued if it was set, since __GFP_NOFAIL is
> > > >   incompatible with non-blocking contexts;
> > > > 
> > > > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> > > >   if there are no DMA constraints.
> > > > 
> > > > - in non-blocking mode we use memalloc_noreclaim_save/restore()
> > > >   to prevent reclaim related operations that may sleep while
> > > >   setting up page tables or mapping pages.
> > > > 
> > > > This is particularly important for page table allocations that
> > > > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > > > scope restrictions are applied. For example:
> > > > 
> > > > <snip>
> > > >     #define GFP_PGTABLE_KERNEL (GFP_KERNEL | __GFP_ZERO)
> > > > 
> > > >     __pte_alloc_kernel()
> > > >         pte_alloc_one_kernel(&init_mm);
> > > >             pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > > > <snip>
> > > 
> > > The changelog doesn't explain the actual implementation and that is
> > > really crucial here. You rely on memalloc_noreclaim_save (i.e.
> > > PF_MEMALLOC) to never trigger memory reclaim but you are not explaining
> > > how do you prevent from the biggest caveat of this interface. Let me
> > > quote the documentation
> > >  * Users of this scope have to be extremely careful to not deplete the reserves
> > >  * completely and implement a throttling mechanism which controls the
> > >  * consumption of the reserve based on the amount of freed memory. Usage of a
> > >  * pre-allocated pool (e.g. mempool) should be always considered before using
> > >  * this scope.
> > > 
> > I am aware about that comment. I had same concern about this, but it
> > looks like i/you may overshot here. Yes, we have access to memory
> > resrves but this only for page-table manipulations, i.e. to allocate
> > a page for 5-level page table structure. We have PGD, P4D, PUD, PMD
> > and PTE which is the lowest level and which needs pages the most.
> > 
> > As i see we do not free pages at least on PTE level, it means that
> > an address space is populated forward only and never shrink back.
> > Most of the time you do not need to allocate, this mostly occurs
> > initially after the boot.
> 
> You are right, I have misread the patch. I thought this includes
> vm_area_alloc_pages as well but you are right this is only for page
> tables and that seems much more reasonable. Having that outlined in the
> changelog would have helped ;)
>
I will update the commit message in more detail in my next version.

Thank you for!

--
Uladzislau Rezki

