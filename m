Return-Path: <linux-kernel+bounces-839063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA6BB0BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B08E4C34F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40D25A2AE;
	Wed,  1 Oct 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf8KahY/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE31B21BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329343; cv=none; b=nRwbYwD0CC+VEz2Ex4F1ae3t5dS1uvMvcTj48Nx69ISd5ryi4K/q1STJfHvdcz6FqZ58i554Cg4iuK3UvXmC0K4+ZsBdLe/7S8S1XGQi2jeP+vYjLf6RNURv94yMyGYtcPCyQ0LQg0W1KniTFd91qfQ3YAajtVkcsfI4m4QiBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329343; c=relaxed/simple;
	bh=8Xy4sMtogkr0cSJciI4vHvitmU2HOnL+Yn4jgG0c7Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEriyTztn9I3z4PyoGybnOsUN5Hx/Fa0i9xaiCQdfcfxGVQVmdaDaamsWVpvQrsqieNLuosaWctwObFfUIu4GC5aOPqoKBOziBeIR9IRYUr5OSbFHjgkU2qz8CcXOVakI7fXmNXplFtlPgvAGxY41qjoP9Bte8rglf3PB3bsMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cf8KahY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759329339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoSJ/UNITIMkV6E4NWf6uVIJcLK8gRuM5n7XzbDfFos=;
	b=cf8KahY/d1DLAO1HBtAzoJO3Z74pnqGVaM6wXT+hNE7hkXWUElpasCu2kT7fMTcCYED3ys
	9zzkgDvV2VMtEa1DNQeUbjH+bBblu7iX8rkzxcWYo2CLEaP/TOOKJ1cCxNGiaHQUx9m4Mc
	yKPntJsQourmQZA5ikZSj0EEcEFLPfs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-fdiY0uWINESwWB9xSRlohA-1; Wed, 01 Oct 2025 10:35:38 -0400
X-MC-Unique: fdiY0uWINESwWB9xSRlohA-1
X-Mimecast-MFC-AGG-ID: fdiY0uWINESwWB9xSRlohA_1759329338
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de35879e7dso122262411cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329338; x=1759934138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoSJ/UNITIMkV6E4NWf6uVIJcLK8gRuM5n7XzbDfFos=;
        b=Oc81f9MLbFaP6lYswZIsEh9qFg8P66pkcmTyzLCpw4m2pCptmTR7OAzG7x1quvQuQ1
         wARiiPfiEq/pYDzaA2P1V4ugOKCF5e6PoVQtSRtNRMWFwW0CmxJsfsla/EMt/WstwPZ6
         6i5tw3KYXuxz1DGgXurEtmXWj3E/SrSBuuoBIzGCaYIVbZTPt9AHk9cfBdcFSdE8mZAk
         vKVVAiuippgM+eZhekUKt1P1FHLBzb4MVvWzN9LA/wW8v7yKfwMC9cvRbrZTG89aSE4J
         fXYcoLYAQlc+HGJk5MPkrNpy1k4f1e/JO68xH2QThthgTVIPRCHtfs96QgDfAhORBlXk
         liDw==
X-Forwarded-Encrypted: i=1; AJvYcCUzLRbfwUKsajakE0okf6ecJuD8oLZ/3yQ2TOksqSMl0sQHg9Es8pFkzSTCpALJS68+/Xv2ch08GvHFaas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyakOSQAwT1/74lSiMr6KDp+JhSneilEESmHb0mMhNThZ5rv1lW
	5o7/fAoAHmQl+DU6AFYyhmbBX308LzGIYj3ppqxSLAT7NN6nSVh9CQAl1VFcB3652D3v7iocDRU
	Vh0VF4W/htyHCIZQ+wmno/vF7uyBQR9VHEvZpyt2u0/hnCPqlkdB8SRFb3e1BTdzYXg==
X-Gm-Gg: ASbGnctKG69FtZLVaFwy1kA/0RMqgb0q4dHUJpJAcV3R3H2Y3nNnHzrWrF/RWitFphn
	c/5hP4qSypK272Sefg2zsWeLmEUUrns7g9O5Q6kBrXXwwzJ9sZec1xAuMP3b1nuEzj5BLZoHLaJ
	gbLcQT8JBD0kc94bFKAmimMFGPHMP9Bp+Th/G94fzZaIj14LWqa2NUNRAZeVWQdNEJ0NSGMyWc5
	MCqH/5xmVQWh+jj8S8ZxG4+8mpTJ/dq0uoznw6L30swBQuUkvnOIC1zN0eMorEqc+oBXvB9n8a8
	cKwHmmIzdMnEZKX+qhxZ33kwlVlJb7NKlaNjqw==
X-Received: by 2002:a05:622a:488a:b0:4dd:e207:fe4 with SMTP id d75a77b69052e-4e41eb17812mr47774431cf.59.1759329337748;
        Wed, 01 Oct 2025 07:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhLIp5lzdVDeFvG81gfpmp2z3qIn9O0rp5mce0smNOD1AJWGIvivjhG4Il9kTcoZYm63Jv2w==
X-Received: by 2002:a05:622a:488a:b0:4dd:e207:fe4 with SMTP id d75a77b69052e-4e41eb17812mr47773831cf.59.1759329337136;
        Wed, 01 Oct 2025 07:35:37 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db09f19dbesm121035751cf.4.2025.10.01.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:35:36 -0700 (PDT)
Date: Wed, 1 Oct 2025 10:35:35 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aN08NxRLz7Wx0Qh4@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
 <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>

On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> > > > > I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> > > > > are rather unsuited for this case here (e.g., different feature flags for
> > > > > hugetlb support/shmem support etc).
> > > > > 
> > > > > But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> > > > > the supported ioctls?
> > > > > 
> > > > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > > > 
> > > > Yes we can deduce that, but it'll be unclear then when one stares at a
> > > > bunch of ioctls and cannot easily digest the modes the memory type
> > > > supports.  Here, the modes should be the most straightforward way to
> > > > describe the capability of a memory type.
> > > 
> > > I rather dislike the current split approach between vm-flags and ioctls.
> > > 
> > > I briefly thought about abstracting it for internal purposes further and
> > > just have some internal backend ("memory type") flags.
> > > 
> > > UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> > > UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> > > UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> > > UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> > > UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> > 
> > This layer of mapping can be helpful to some, but maybe confusing to
> > others.. who is familiar with existing userfaultfd definitions.
> > 
> 
> Just wondering, is this confusing to you, and if so, which part?
> 
> To me it makes perfect sense and cleans up this API and not have to sets of
> flags that are somehow interlinked.

It adds the extra layer of mapping that will only be used in vm_uffd_ops
and the helper that will consume it.

But I confess this might be subjective.

> 
> > > > 
> > > > If hugetlbfs supported ZEROPAGE, then we can deduce the ioctls the other
> > > > way round, and we can drop the uffd_ioctls.  However we need the ioctls now
> > > > for hugetlbfs to make everything generic.
> > > 
> > > POISON is not a VM_ flag, so that wouldn't work completely, right?
> > 
> > Logically speaking, POISON should be meaningful if MISSING|MINOR is
> > supported.  However, in reality, POISON should always be supported across
> > all types..
> 
> Do you know what the plans are with guest_memfd?

I am not aware of anyone discussing this yet, but IMHO we need to support
it at least for the !CoCo use cases.

I do not know how CoCo manages poisoned pages, e.g. if they are kept being
encrypted or not even if corrupted.

Thanks,

-- 
Peter Xu


