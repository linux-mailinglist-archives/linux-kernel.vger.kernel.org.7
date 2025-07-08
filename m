Return-Path: <linux-kernel+bounces-721884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98824AFCF26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE8A3AA631
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691A2E427D;
	Tue,  8 Jul 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wt7LFU1V"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8702E2647
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988179; cv=none; b=q6kpVh0ndzCfkgbvdyo09biYrgcm6hCUUTvEGwKd/WV2ZwGkv2KHz7jCtAzxN2l6y8SuT0PaXkBeOOvga+Am+dQS2FXHKZFzToLAW/4CEyoCx+aR+AaRy5147rHvBq6buLbSt3pr5XjGyShwMESe+Zos9UA78W3gQMtIkq3knOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988179; c=relaxed/simple;
	bh=T4yTkeA5wBWeoNDU5UhGBbPqChxZBpZdVhOEcjLVFnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF14XG6+g74SQSNZ9cHlUWaitwwJKn6K5uL7yHH3uiSpEnLu+ac31+F/p0/79RR6BjFHFt02HS954Bo+W4AnrmcNRF6WYE7Hpc61NMOu2SL4PpEUHZd3Cd44b24qNF8V2CpMgIgPKHHw6cvEMmG/lkro6NvWjjwDXbz/bXorXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wt7LFU1V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d7b50815so37625635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751988175; x=1752592975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDbUdQbHcS+u2uA1nZKwuAGbng6kfr+9iRKL/0FgyEw=;
        b=Wt7LFU1VGKIL6rZQ6IjVesSMCVbdPRAa/HrG4fvPdh8lHl9SF2k+YOu8Ex68KVh/AP
         A8BnZS1E3yStiL3Bd+mdaZ5IOJhWlHbl+nrZbcEvLUVmi2jp7/D2T4pVNSckEdS4PPm2
         8sxSBTNT6ArV+aHdB7jG2wUA2GtgzZVpFZ3AsLvJXtAewaVBz9m95z9HOaa67qmSi5su
         J+b5SRftvC/Ec+9XYw8etF3oo5uzIpdEr7A3rNqcKhgGNuHFUNTmtjjzTB2NLp0iS4wp
         tQp9jpqmzYxliv+NOmaw6Gxp2XOyLKgMTRDKIEyuKltVc0XDq3OMgeyXfskt81MnbG8l
         xRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988175; x=1752592975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDbUdQbHcS+u2uA1nZKwuAGbng6kfr+9iRKL/0FgyEw=;
        b=mtKLWyJ8LEskoKwjYNVlYEz/Cxm8zyZMwVjk8brI4uQembYvbmL71FEpiBSlRJZGTs
         e0t8y2QAAzspKOAUZ8N/BoCE84TndXJNVyyJro2uxlduVDjmGSzN9ldOcVxwDS8shAiG
         dnUFK3iwdsMG9NUVc1IQtR/KUBxuxCHizG1Mobv74hyA9QR7tDdcbKrShR1jYUWWHVSm
         N9zG+hjKdIwkSchwcnP4eoMSYn7RSECtM4JxoEBG/PNCp2vxGDMGtixMSYX1auB2qITg
         DsReCM+YB/DeedVEai6jLhkwW5peG1KZxBZJXm0tarUryPHcuFWAzsjIK1DESgdhfIcz
         Kg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1hIurd0e/p5RE/FcnzxZF9rKZMSTVfkcqaEMoOvBBZ/mhXba2DV3Sy6199q9KXTr2IsG0NuzZ0mSqWEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZ3JCNL6jvh9qWnHSTyuvLIiFHR6yhB4d0VhqpB4RicxmDGMx
	oLR2FnEYUdHrBhQGVjnlnbTYubW6oQ7v4UHJz9zISKWEBtysGFZCJkkXWvmamhhTvMA+YqWMPBn
	W1FEzGGc=
X-Gm-Gg: ASbGncvSv4p0vpCF/7yCBhV7EOxHg/+1PXD3EzF1ct8a+KCruxHKvDtd6KtLArYvlAA
	pbmBwW+UelGkWUjNl7J8psJHN1NzWCiCt9nNnH2Xn42sRm866Bt8PCBQi2boictliIH1RhaTfo7
	8IQ5hwo0QgMgfQ99sEgeIQ2rBo1ga6vjuHwm+o4Q/hptqhCwvk/9qBQc4r/X1jKzdrY4M/t1d1b
	syVbSd6M+dNdoE61G9p0EM43zyLKLTIZDZhRsViSIrviLpNFZw2L9ApPm1AlV/nQa2GbhJchmjV
	4a7bb7eSK4SilmuHlM+LTiY7dOtT13Ss02UaCg9fX4bLWoUD2Sp8K9IsY0tx0gG2nL7YtmX0qT8
	=
X-Google-Smtp-Source: AGHT+IEgN2ptsswvGbcqQV5HZKzy/tIMBN87UV1FLzjZJTzsOrsTBqZu7eb19DKwYvD06MzflwcQEA==
X-Received: by 2002:a05:600c:458f:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-454c6db327bmr70525085e9.11.1751988175023;
        Tue, 08 Jul 2025 08:22:55 -0700 (PDT)
Received: from localhost (109-81-17-167.rct.o2.cz. [109.81.17.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd3d25e4sm25058845e9.26.2025.07.08.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:22:54 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:22:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 6/7] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aG03zMoVJSVJz5KK@tiehlicka>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-7-urezki@gmail.com>
 <aGtzgOXdhAAOTBhs@tiehlicka>
 <aG0Ozc3Mro95djxn@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0Ozc3Mro95djxn@pc636>

On Tue 08-07-25 14:27:57, Uladzislau Rezki wrote:
> On Mon, Jul 07, 2025 at 09:13:04AM +0200, Michal Hocko wrote:
> > On Fri 04-07-25 17:25:36, Uladzislau Rezki wrote:
> > > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > > 
> > > - nested_gfp flag follows the same non-blocking constraints
> > >   as the primary gfp_mask, ensuring consistency and avoiding
> > >   sleeping allocations in atomic contexts.
> > > 
> > > - if blocking is not allowed, __GFP_NOFAIL is forcibly cleared
> > >   and warning is issued if it was set, since __GFP_NOFAIL is
> > >   incompatible with non-blocking contexts;
> > > 
> > > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> > >   if there are no DMA constraints.
> > > 
> > > - in non-blocking mode we use memalloc_noreclaim_save/restore()
> > >   to prevent reclaim related operations that may sleep while
> > >   setting up page tables or mapping pages.
> > > 
> > > This is particularly important for page table allocations that
> > > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > > scope restrictions are applied. For example:
> > > 
> > > <snip>
> > >     #define GFP_PGTABLE_KERNEL (GFP_KERNEL | __GFP_ZERO)
> > > 
> > >     __pte_alloc_kernel()
> > >         pte_alloc_one_kernel(&init_mm);
> > >             pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > > <snip>
> > 
> > The changelog doesn't explain the actual implementation and that is
> > really crucial here. You rely on memalloc_noreclaim_save (i.e.
> > PF_MEMALLOC) to never trigger memory reclaim but you are not explaining
> > how do you prevent from the biggest caveat of this interface. Let me
> > quote the documentation
> >  * Users of this scope have to be extremely careful to not deplete the reserves
> >  * completely and implement a throttling mechanism which controls the
> >  * consumption of the reserve based on the amount of freed memory. Usage of a
> >  * pre-allocated pool (e.g. mempool) should be always considered before using
> >  * this scope.
> > 
> I am aware about that comment. I had same concern about this, but it
> looks like i/you may overshot here. Yes, we have access to memory
> resrves but this only for page-table manipulations, i.e. to allocate
> a page for 5-level page table structure. We have PGD, P4D, PUD, PMD
> and PTE which is the lowest level and which needs pages the most.
> 
> As i see we do not free pages at least on PTE level, it means that
> an address space is populated forward only and never shrink back.
> Most of the time you do not need to allocate, this mostly occurs
> initially after the boot.

You are right, I have misread the patch. I thought this includes
vm_area_alloc_pages as well but you are right this is only for page
tables and that seems much more reasonable. Having that outlined in the
changelog would have helped ;)
-- 
Michal Hocko
SUSE Labs

