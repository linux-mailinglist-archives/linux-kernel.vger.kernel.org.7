Return-Path: <linux-kernel+bounces-760203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B673B1E7C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B308587A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9126275872;
	Fri,  8 Aug 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev2wvQoc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACBC275869
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654054; cv=none; b=Mzc/Nx+a08ss3W5rXCYq+071a2QA6ExJ/J/IVGdZ5RWntpJRfC3wOX0jaxWTjZwsCKQ7Joc9wwsHWwnCyX0NDNy5+VPI635rXMbgAefKL19Wbc7siMJ9TdGi6JhpMb+tJnidIb6PUWmDL4lq+ejcl5qu0m4V/btCc18Fs8FuNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654054; c=relaxed/simple;
	bh=1W+LExxHwvk82uogQT6+0btj3TE86+Sr01FmFYrF+4w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoexEw9a+n22ktQbmT17XwFJn2VR5vhcV8mHA+B0lNndB/zfLvdEXeB1WysmHL/Hee2Kvf8xFVKqOrTUoNHrXnMRsBCqtlCrDQg9jNl5ENtxl+DgwmqugKbqFUpDpITkZq1GD/W+DXXScHSx4YGOXQ3U9RFqZg+SUAu61b53hIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev2wvQoc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b82db8fd4so2322476e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754654050; x=1755258850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z87KtuYTYFFBg3Z4T1TS83oRHuynTc7l5TeBpmr4G0=;
        b=ev2wvQocvqL8hAPlvNdMdc432Bl27G1e6eJtMtOI3VvlHyHOHFwdzcK1WMsLVcdnGR
         LbEhzqqW31xPUBHMwwufhf0gzswF0XGUeYwT0gegqXvQkD4pzBEShm14UC3bl+SpRk8/
         O7HZHTPYBfzkOebUS3FWTOrKXJ9ZYObp0lNv/9Im24a4YvUCxpSA2mhjR1aJOU+lCe5g
         ijMpenIvUDZpvBV1ofAtFME2a4b5dh+vBcECEuqsOeevqlJR9WPzQBI6l1u0IN7GWcy0
         hcsow7h/kmjHdxLDAeaiggXHr1+weW11r/XdWXi0PtROd+jDJelXHyDLi30ZO33EqCfs
         O3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654050; x=1755258850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z87KtuYTYFFBg3Z4T1TS83oRHuynTc7l5TeBpmr4G0=;
        b=IvbKFZVvr+c1oZv1LB7iVlfRIEjlnxHsKDt+xwMkLpTIQXoicRgwxg5V3q7CYg/PB4
         mAt39h7fXxDWRbHXYHH/qo7jaGkNu0qyvylADjP/kUjPVW9my+U8IwFQJZwUnol4w6FE
         35h0hF9KJ5vyyrK4W14v9Hk2B1zVxkx0E/LPgjxwmdybJqPkytZxfEwXsSszJELekDxo
         THjOLF/D0556qoTkjaFKjNe9ZQhev7MdapguwvLeyFunqEk7LgtXKRETuUbeePcuLyU7
         eAfmOGPVBnzeJXFf/To0bhT+P1fufI1j+qv6wDkxn68oOtN1tPFUO6ILoFAtO585rCy8
         cEVw==
X-Forwarded-Encrypted: i=1; AJvYcCXd/AuDtwrgOzUs/1y7u+p70TSdnKjV7LJLYbVGM0+iiahmBAAsituHb0T7qkcMM1P6mwYBnU5lfNFh0Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgxndVrCI54bLVeQneOM3uU+/H6DFCRpwy6AS33uJ/WN9mJ8V
	mTeaIm2fFODSTv5NNVhGXEnPoPOuKMMuVGpT7M5VVO+AOVwrf9Ifpk4abU3rmQ==
X-Gm-Gg: ASbGncvuwj5gE6NR98WxbrCr9W8HFdWpcl0eZo4r31+xNxU4qsDMOKsxibvFKdrt8Ng
	KygMrM9vP0eyhXHhvKK8G/tCkSd4HrEid7ElLU9XXHKZrGwhwweALvWHIl7aIe+SO6IcC1fRmjO
	W0B62pGO36LeJHAoWvedjYUWWtpVeVm44//BPix/ThjMkS2lRXGAYf3dj7FmTRG8MONN68YzX0r
	P4Dl79T9Mrq1grFmQsV526GHR6Y778CW++kVWqKy0qYue/jmrfRCGi0ei4LhFk5xPeNNgg7j8x0
	cuhoSXSkHQ/YIXkdEUP0JMhcAX2N9XtqOcOuq5/DEo259I3zNUYzGe3/OAfAetAgIVeV0Cz7e70
	TyXgVRrVf8g2jDYbYWNIHWFRLWvcaxhNnxyHu2SgHHvaP/upgiQ==
X-Google-Smtp-Source: AGHT+IGTlRX32W/66W5mgyretpQulwmybCU5oV0rZLF1gNKD0bCCz7gtRG+Cn9bV9vAJ/GiZCjPktQ==
X-Received: by 2002:a05:6512:3e1f:b0:553:3407:eee0 with SMTP id 2adb3069b0e04-55cc0078ba4mr760428e87.4.1754654050035;
        Fri, 08 Aug 2025 04:54:10 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca2d29sm3067058e87.124.2025.08.08.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:54:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 13:54:07 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aJXlXzxDUo_i3c8u@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-8-urezki@gmail.com>
 <aJST7TnermwROX41@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJST7TnermwROX41@tiehlicka>

On Thu, Aug 07, 2025 at 01:54:21PM +0200, Michal Hocko wrote:
> On Thu 07-08-25 09:58:09, Uladzislau Rezki wrote:
> > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > 
> > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> >   if there are no DMA constraints.
> 
> This begs for a more explanation. Why does __GFP_HIGHMEM matters? I
> suspect this is due to kmapping of those pages but that could be done in
> an atomic way. But in practice I do not think we really care about
> highmem all that much for vmalloc. The vmalloc space is really tiny for
> 32b systems where highmem matters and failing vmalloc allocations due to
> lack is of __GFP_HIGHMEM is hard to consider important if relevant at
> all.
> 
Thank you for this note. Yes, __GFP_HIGHMEM is about 32 bit systems.
Initially, in the RFC series, during testing i saw some incompatibility
kernel splats when use together with non-blocking flags.

Whereas i do not see it anymore and now. It looks like i messed up something
when testing pre-RFC series.

I will not touch it. I mean i will keep it as it used to be, i.e. apply
it if no (GFP_DMA | GFP_DMA32).

> > - vmap_page_range() is wrapped by memalloc_noreclaim_save/restore()
> >   to avoid memory reclaim related operations that could sleep during
> >   page table setup or mapping pages.
> > 
> > This is particularly important for page table allocations that
> > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > scope restrictions are applied. For example:
> > 
> > <snip>
> > __pte_alloc_kernel()
> >     pte_alloc_one_kernel(&init_mm);
> >         pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > <snip>
> 
> As I've said in several occations, I am not entirely happy about this
> approach because it doesn't really guarantee atomicty. If any
> architecture decides to use some sleeping locking down that path then
> the whole thing just blows up. On the other hand this is mostly a
> theoretical concern at this stage and this is a feature people have
> been asking for a long time (especially from kvmalloc side) so better
> good than perfect that his.
> 
I agree with it. Unfortunately i can not control the PTE kernel allocation
layer.

>
> That being said, you are missing __kvmalloc_node_noprof,
> __vmalloc_node_range_noprof (and maybe some more places) documentation
> update.
> 
I would like to fix documentation in separate patch. That was deliberately.

> > Note: in most cases, PTE entries are established only up to the level
> > required by current vmap space usage, meaning the page tables are typically
> > fully populated during the mapping process.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> With the doc part fixed
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
Thanks! Applied.

--
Uladzislau Rezki

