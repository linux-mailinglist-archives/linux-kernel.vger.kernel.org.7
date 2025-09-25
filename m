Return-Path: <linux-kernel+bounces-833061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16FBA11D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6381C259A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6915530C;
	Thu, 25 Sep 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Dxhe3E53"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FEC433AD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826942; cv=none; b=bNxxynTPbtTOZ0+GhEjXnyNGIex8ycJqNj/4qUACLDNxZbndNRZicCeyHV8Uu30nIKcQSWvMZ72sVEJAz06UvC/opauo79dvjNfglP6/PRhD2t6uZdYabwSV38CBGkp1OgC0rfBfrPpwu3q52q401Xoa88EbSjKugk4q8+l/ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826942; c=relaxed/simple;
	bh=xwYfPKdUspsq3I/KqnSzDvEAx7bXNcICtcEdarQFJ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+wzfWeAwmyjAKYHdsa44/snCaWt2yCIX0fbf1C67XBTCZeAhQAItmpkHY27X47l6drYsoW49NI1rE1c6yQ9Vu94Rel1gJyrAU0E+ABBfDvHoN742v+t5Kvr7uXSZXrByUt/kC9eSFE2DPFsQ+0LQ/dvYteq+xHscVWDdbBVr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Dxhe3E53; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9032edd72c1so106267639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758826939; x=1759431739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5BGgKN1hYVlPuGDz0FxzI5j2NNaYJevvvmLa3nnM5k=;
        b=Dxhe3E53HS0YXPj/zC7z0L2jrDBsRhV95sp6WM329H/RbgtyY75u1q0dC8HsWhFigc
         rzlE6dNm4Y97V/XTM8oqiF6kJBuaorqzdvzqovGj3hWwTZGKsJ0Lt2jZKBtYUJYulHdx
         Nwe5RB8U3M2rDGBETtYamIR4oel/y+gKN93eDekQCAMRUTseVEF/IG3oeYl8gMsXtRXX
         ONf7LuGWE9YUhyBkIPw+OxATknb+xeNoOgPRS5G1K6NTNrhus9rSJdp4ACF96czYLuaj
         DfECXHSsvpCrAhc6ZjSUoOkPE2r2kLMn4/O1aI9iTXAvfWEEbyW6PFKq1CL452oamMpI
         HjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826939; x=1759431739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5BGgKN1hYVlPuGDz0FxzI5j2NNaYJevvvmLa3nnM5k=;
        b=Gb/FGCBgLmbnA9TTZS5zB08yQdQfzzyzT+guxZyZwzjIF3PbpBAkU1A0l5KNF4UXud
         nf6ZZ9lXGai7LQdqlW8IsrRv3mHAT2ACAmAwly0qnRTNZNKFzMkbdKpWkbUAqSoRnC8e
         iYaegBoclKttHEuCNxnyVZ6EJ37Ass7K9slnIiJiTnXgs1k2hwkRdh1mMWRVwf5n7eWJ
         CtMnonu6YARMIw7nhKdDXLzg2KhRH8jEw9/JrGMyaFo6LYgDGWTM7x3c5WyfRodNGwGL
         Je13x2aZGduMQcv0ZfWN8SFPf3QsluSyr8n8I5Hh+Epx7NdQl3ewJhF2OCNY/jDeSfQc
         vKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzLPckDZfcZPISpWJXCUj+0p+IV+Fepsbx79hV8J0aRJAuLFTMMPymqgducc0vxX3bwFSb5XQ8DA39Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEecYlg8VXcYalBm5tJnvPHu/cR9P65Fe9el4VuGh+ax3d12Xi
	R+nQWTvZq6jkW/+R7bLEVUq4Ih76uCsyCiSwmORwbMFQ9600Qyz8sRADcd/9ngSzVUg=
X-Gm-Gg: ASbGncvAWKzA7xmvlEXKRY4mkAxnoJ70nn9gf1idaJhGxtORzkhyOGNCPfq34pEtqDx
	Dam8yltfSyzWAPHK9cehaL3IPC2kYugWNDfT1Ki56cgcsLLgvwC3lNBdvd9/5CBlj2bWiwRczSm
	r1UTVsjb2OiGZxksfjAPTgy7hDV79h4cj1xsitNml/UAEyFRT8H0fWymYVKujSCx4AcsHaSuQrN
	T+zmBmZe31LqadgLUF/JKZrnbzUhGH4bXxvZ2Zr08KqbdwpdFx3jCvk/nP/zg76OiqsV/CiSIUN
	BMmHIbwpQCi+LrFaR06wJqgF+uUGYtiAO1sDjFZ3FE5vT/tdxTBxkewkMMClj9XK1TTMRDwle6k
	Icvgl8OCv96tJ4bhs55Ab+IonjTKX/c7fLtD/gJjhs+nuSaozue/1JyfMt2uVD/NaJjFr3f86MW
	k=
X-Google-Smtp-Source: AGHT+IElHzEjP4n2pPcMoIuxsAK3EgVQOeQkGgr0O77OUi809sXnbgs87TM+n1OoXUW5tPgUfSZIuQ==
X-Received: by 2002:a05:6e02:482:b0:425:79b4:9ef6 with SMTP id e9e14a558f8ab-4259564482amr49397665ab.27.1758826939416;
        Thu, 25 Sep 2025 12:02:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6b152a0dsm1065149173.81.2025.09.25.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:02:18 -0700 (PDT)
Date: Thu, 25 Sep 2025 15:02:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
References: <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com>
 <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925182308.00001be4@huawei.com>

On Thu, Sep 25, 2025 at 06:23:08PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 12:06:28 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > It feels much more natural to put this as a zswap/zram backend.
> > 
> Agreed.  I currently see two paths that are generic (ish).
> 
> 1. zswap route - faulting as you describe on writes.

aaaaaaaaaaaaaaaaaaaaaaah but therein lies the rub

The interposition point for zswap/zram is the PTE present bit being 
hacked off to generate access faults.

If you want any random VMA to be eligible for demotion into the
tier, then you need to override that VMA's fault/protect hooks in its
vm_area_struct.  This is idea is a non-starter.

What you'd have to do is have those particular vm_area_struct's be
provided by some special allocator that says the memory is eligible for
demotion to compressed memory, and to route all faults through it.

That looks a lot like hacking up mm internals to support a single
hardware case.  Hard to justify.

This may quite literally only be possible to do for for unmapped pages,
which would limit the application to things like mm/filemap.c and making
IO (read/write) calls faster.

which - hey - maybe that's the best use-case anyway.  Have all the
read-only compressible filecache you want.  At least you avoid touching
disk.

~Gregory

