Return-Path: <linux-kernel+bounces-863361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7DBF7A85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 486E9500B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4033491DF;
	Tue, 21 Oct 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/EDkNSz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52D3491F7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064107; cv=none; b=Hjmvltvw4J3PA2HD1eKw5usZV9EZtH3a+0WViDNOx0Iqnrg0NuHQNRj5S4mdoXUX8OKTjWS6XZ+Vkcht3qSR/o796DdnXFyest7QnZBxscvSIy3FB2g/BCBG3IQOiJkucptXOKhf5WQKhEdt85QIss/r8Agap1owlntUh/Cnjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064107; c=relaxed/simple;
	bh=61nUKwYrqdqA/8vnCgp6kS+XxQ/BLcqNLvhBvc7N5Lw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxtABqpCllfJE+3gIZz2OLsOWbvhbDRg89n9QUFFxYpVTQvPfJK6r+RXSEGb0CBtor254DQ5Ysc/iIpZPaY2C+5Dbo305PcBbqoG6nU8rruKBB7MtdHSJZciqvFgpcxK8sQFH3ZMp21GtNU1p4VurxYGNl/jEHljV8CbOjNpau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/EDkNSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761064104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sioSGv2R6nSPzmRxdpYSKuGX8pcqdwmqq+r8Ju50xks=;
	b=e/EDkNSzUp56YAtOdTzBEx05nvga2J12fvrCJ/USfGhGQWc2SoLzHxPrCf8+1EiMHm1HPv
	3l+BFB9XtEVd8mM9Fkb1gLSMpCS+gYkG1q/WN9PaP1pHPOYbaPRRwl/PcJ1mpzr1mIqqpl
	CCyNuG9gLAhC/+vOwJylZoa5F6MSiMk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-KiaAd5qQMX-w0i6WF2_Myg-1; Tue, 21 Oct 2025 12:28:23 -0400
X-MC-Unique: KiaAd5qQMX-w0i6WF2_Myg-1
X-Mimecast-MFC-AGG-ID: KiaAd5qQMX-w0i6WF2_Myg_1761064102
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8916e8d4aso4196671cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064102; x=1761668902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sioSGv2R6nSPzmRxdpYSKuGX8pcqdwmqq+r8Ju50xks=;
        b=XnBzxwWlQjGKMAOq63FrMBorvwUzHqLhh+4DaY5eoUxUS0sO2+kpQCLNridXxjQhi3
         YEWQIwfWj688yTz4phW92nR2cnyaC4V/wAnVhDZxUC4m9dSJHY/C3YVYGnc/RfbPbBcO
         tZLOGBgBRVfhtAhGGDc8EPSkhtzPJNnHT+uUjGy4C4rkNUyhbKAALXGQT6qT/adaURXL
         +SwIAq4cloc88T34r3+X8hXKW2na3L9vvKwcLRpg0p4O3mMCA5lEjqWYn/T09ci8g49L
         wU3fRvqr/pjZzurN2UMIp20R3XVcbo0MqRqjY5kEjGdvs2P032GhlgXMDfF8vzBvWBmR
         vnGw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCEn8LYHYcrUl7fryDSuHdivIIANc6qgVaMFvxSajfIwDSOTrbYY1OLF38kffZoeiE7E25mwN6dMYb/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNq4eCVi8t1aUQjePpPtZFkemLv3oLT7TLu7l906oy6vH2Ol/r
	AmjKu7SwbV2clbVVP7+8p2syOtxXGI+H/jxwVkB+5Jw13WZXdZfoxvGr7ciDIdHK0LQ7H/ZjNj4
	wN3L7FHHRgscbiMa2Nvgm21cz1823zP2DvD/mICkfVdYPohF8I9vbPbit/DhzdNYJ4A==
X-Gm-Gg: ASbGncslJx0yeHPTWhEBpCc9j5nL9AdEgX4zCgac8JaEtpLJLXTxh717dx/4QaD4r7H
	2xvZuBtjhcmBxWlMpADZhXSaxUIK+h5kjHTEgzJJoLF+3vB16z4tz1UZtOs/ASwrjam33ns57Kd
	XNcNVIsZdRiCl03vpv/Ba7tb73Pk+db/bqwMc7PnZpJJLoNilWYR4lbnRl9S7/oO7v830Qwpfi/
	AA8/UMEhfHu17wQ5Hs7cJh0fer5MfoOmvD/rlkjCGijNeky7aBxYAloCR9eiwJmeiCkAOacziW2
	EfmGc08osGtQb9Wl9wIqeb1BRHj0/B9cg3qD8hy6jzBOI7SKQGQWh4nTOmGZAYEuUBg=
X-Received: by 2002:ac8:4659:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4e8a0bff828mr159622481cf.73.1761064102267;
        Tue, 21 Oct 2025 09:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM1Uo1w8gouAcqG+65k+utF3myIC3KHqazzJjQ+llWJyhJmMQcXA/E0CIWf7wbTpckD7BgpA==
X-Received: by 2002:ac8:4659:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4e8a0bff828mr159622091cf.73.1761064101674;
        Tue, 21 Oct 2025 09:28:21 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf34386sm77137021cf.4.2025.10.21.09.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:28:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:28:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aPe0oWR9-Oj58Asz@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>

On Tue, Oct 21, 2025 at 11:51:33AM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251020 10:12]:
> > On Mon, Oct 20, 2025 at 03:34:47PM +0200, David Hildenbrand wrote:
> > > On 15.10.25 01:14, Peter Xu wrote:
> > > > [based on latest akpm/mm-new of Oct 14th, commit 36c6c5ce1b275]
> > > > 
> > > > v4:
> > > > - Some cleanups within vma_can_userfault() [David]
> > > > - Rename uffd_get_folio() to minor_get_folio() [David]
> > > > - Remove uffd_features in vm_uffd_ops, deduce it from supported ioctls [David]
> > > > 
> > > > v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
> > > > v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com
> > > > v3: https://lore.kernel.org/r/20250926211650.525109-1-peterx@redhat.com
> > > > 
> > > > This series is an alternative proposal of what Nikita proposed here on the
> > > > initial three patches:
> > > > 
> > > >    https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com
> > > > 
> > > > This is not yet relevant to any guest-memfd support, but paving way for it.
> > > > Here, the major goal is to make kernel modules be able to opt-in with any
> > > > form of userfaultfd supports, like guest-memfd.  This alternative option
> > > > should hopefully be cleaner, and avoid leaking userfault details into
> > > > vm_ops.fault().
> > > > 
> > > > It also means this series does not depend on anything.  It's a pure
> > > > refactoring of userfaultfd internals to provide a generic API, so that
> > > > other types of files, especially RAM based, can support userfaultfd without
> > > > touching mm/ at all.
> > > > 
> > > > To achieve it, this series introduced a file operation called vm_uffd_ops.
> > > > The ops needs to be provided when a file type supports any of userfaultfd.
> > > > 
> > > > With that, I moved both hugetlbfs and shmem over, whenever possible.  So
> > > > far due to concerns on exposing an uffd_copy() API, the MISSING faults are
> > > > still separately processed and can only be done within mm/.  Hugetlbfs kept
> > > > its special paths untouched.
> > > > 
> > > > An example of shmem uffd_ops:
> > > > 
> > > > static const struct vm_uffd_ops shmem_uffd_ops = {
> > > > 	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
> > > > 					BIT(_UFFDIO_ZEROPAGE) |
> > > > 					BIT(_UFFDIO_WRITEPROTECT) |
> > > > 					BIT(_UFFDIO_CONTINUE) |
> > > > 					BIT(_UFFDIO_POISON),
> > > > 	.minor_get_folio	=	shmem_uffd_get_folio,
> > > > };
> 
> I think you forgot to add the link to the guest_memfd implementation [1]
> to your cover letter.

I didn't.

https://lore.kernel.org/all/20251014231501.2301398-1-peterx@redhat.com/

    To show another sample, this is the patch that Nikita posted to implement
    minor fault for guest-memfd (on top of older versions of this series):

      https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/


> 
> > > 
> > > This looks better than the previous version to me.
> > > 
> > > Long term the goal should be to move all hugetlb/shmem specific stuff out of
> > > mm/hugetlb.c and of course, we won't be adding any new ones to
> > > mm/userfaultfd.c
> > > 
> > > I agree with Liam that a better interface could be providing default
> > > handlers for the separate ioctls [1], but there is always the option to
> > > evolve this interface into something like that later.
> > 
> > Thanks for accepting this current form.
> > 
> > > 
> > > 
> > > [1] https://lkml.kernel.org/r/frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy
> > 
> > I have replied to that, here:
> > 
> > https://lore.kernel.org/all/aOVEDii4HPB6outm@x1.local/
> > 
> > If we ignore hugetlbfs, most of the hooks may not be needed, as explained.
> 
> Those were examples.
> 
> Hooks allow for all the memory type checking to go away in the code,
> which allows for more readable code and less operations per call.
> 
> > 
> > If we introduce hooks only for hugetlbfs, IMHO it's going backwards.  When
> > we want to get rid of hugetlbfs paths, we will have something more to get
> > rid of..
> 
> This is just wrong.
> 
> It is far easier to remove one function pointer than go through all the
> code and remove the checks for hugetlbfs.
> 
> Are you thinking the hooks will just point to the generic function?
> This is the only way I can see your statement making sense.  That's not
> the idea I'm trying to communicate.
> 
> The idea is that you split the functions into parts that everyone does
> and special parts, then call them in the correct sequence for each type.
> New types need new special parts while using the generic code for the
> majority of the work.
> 
> In this way, the memory types are modularized into function pointers
> that all use common code without adding complexity.  In fact, knowing
> implicitly which context from call path means we don't need to check the
> types and should be able to reduce the complexity.
> 
> Then adding a new memory type will call almost all the same functions
> except for special areas.
> 
> Removing old memory types would me removing the special areas only - and
> maybe a function pointer if they are the only user.
> 
> The current patch set does not modularizing memory, it is creating a
> middleware level where we have to parse a value to figure out what to
> do.
> 
> These patches DO expose a method for memory types to be coded in a
> kernel module, which is fundamentally different than modularizing the
> memory types.  Different enough to be glossed over on a ML by looking at
> the subject alone.
> 
> Yes, one value is better than two values, but no magic values is ideal.
> 
> Is it a significant amount of work to remove the magic value by
> fragmenting the code into memory type specific function pointers?
> 
> IOW, instead of decoding the value to figure out where to route calls,
> just expose the calls directly in the function pointer layer that you
> are creating?  What is the minimum amount of function pointers to get
> the guest_memfd to work without this value being parsed?
> 
> [1].  https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/

I don't know what you're looking for.

I think I got most acks from userfaultfd developers whoever were active in
the past few years, ever since v1...

Then, we got some concern on uffd_copy() API being complicated, it's fine,
I dropped it.

We got some other concern on having a function returning folio pointer.  We
talked it all through, luckily, even if I do not know what really happened.

Now, I really don't know what you're suggesting here.

Can you send some patches and show us the code, help everyone to support
guest-memfd minor fault, please?

-- 
Peter Xu


