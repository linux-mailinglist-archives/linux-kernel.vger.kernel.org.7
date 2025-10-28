Return-Path: <linux-kernel+bounces-873786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D338C14B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8BEA4FF19D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6B32F778;
	Tue, 28 Oct 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o7QR7l/R"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B02EA72A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655982; cv=none; b=ix0R8eZRrwmv5kP1RUZZL4EuwEBr3Ja5vphuNhPQFOVLrj+Wh97f/fVzZHjCs1aqYV8xJEo9sCML6p92twqzKr9Wu5PKoF2DLWhVY9bROfhHy0C9zhKQTdt4/agmVDChDTZX/AUlUJqlzLsPh3c0wzDzuGFT4yDtQJfLIm1FjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655982; c=relaxed/simple;
	bh=+3vPaDsnNL8heSTGQITQySDS23M0o5dLkagTN8ShR9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhLGVS14eksUKCF9PXiPvU9uadrJk3zwBroCGwtr7AqnYqRta6LTSh17A71h/xBhRetO4y2TxDOA9WXF5htgd4NEQpf7B13Zr8zYFx4icEd7+8AAKTDB9sRShklRaIndpWa6g/pgx9oTKgpQzN5Rh9XNRJ/5mhN5nYXInqAPFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o7QR7l/R; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7f7835f4478so42165066d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761655980; x=1762260780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CqgmoumiIO/LqZvmbvABjwYG8sY5r9jILlhcKrm4Ms=;
        b=o7QR7l/RcnzhMMWrC+iO7b3J3CZ0SUbCMtZvxpEAUu6jsnUYavb8PWPeBXQ2nlFd7U
         SnCwfRbZCGNOydBsVkw6/Q4FSnrzT8PHcUsrF4rXGf/1Ntsji7jr2ylHEvqqx+3FH/Fn
         /dV2NQ0FyiEvm4RS6HpIAp6LiC62QKSUNtXs3+pdsHtJEaK4RUB3f1ktieiUYW9/Son8
         03FPqQkIHNHsmlqdkKRLpwV+E0GAVAgg9sdpykFEAyCFZGVdNEZZMeirWPeo+sYb4D8H
         UgZQ9fq0DDO00uVOp2p0iEd91CdZU/Q/MoIl4Z/4y7n2zrnGEt5EZcyWLZ2cUE5uMhQk
         tk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655980; x=1762260780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CqgmoumiIO/LqZvmbvABjwYG8sY5r9jILlhcKrm4Ms=;
        b=VXbokl/qcoBEx7G+65/ur8aSXuUaF38C+UIxd995WPDi6rFDz1aOhoc8tUqemFrbCE
         NOg0Dgzz34ETtQsMn1kj3XdZ4LLXofe10CrDVHUSUmfKdvAZ8Y7j8n5JumR7sYwvx5zF
         tbS7bEisLeugbV5/+osmr2wi8u9OQlf3tvAZVjmpB/L+EhltZa8XYVcWcd9m7Qeslj81
         7vnhF41DafMWplrOrl6XT/rDyaz1Sjs4XgREjv8nmM75JaKzs4dMLpRRv2R9csxki+f2
         4pka2oH7T4kDdoz4VaKj7f0yc34z0L5yvQkFMSXbbxAUcIRgQ/jlnadCkc/g2UsuS1nS
         n2zA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZjTgfz8Lie6DnoLDL1AbkOhEUiYX63WR57nfS4cwgBp+V+O6cSERdFfOSQEW6IxHRUSLYW22Q0H0q2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCw13tyaBjqsDGVCtlzCnjwXQt9rtCOwQD3P69VqNDdCQ/9ROa
	TkRFNWDpZH4BdlkwsK7rzxBAQEVmQSdy1V3zP7iOTp0hNtUXExtrYEnD7sb6/lgHeUM=
X-Gm-Gg: ASbGnctgF3u5i67KprkdDvCpjEuLNpTSxyIs6CoM1SWmxjkcGVqbYhFQHD7z/J3BNW7
	JsTY++5SumHEwYXQv4UofAPetX9UuDK5B9BM5O05JVqOCZ8zxOm3dmyrdSEQxl+D1TEaUmFSZ4g
	wGURmBQY9go+TXVSch7aHrNj/8rlRLM+/Drjha4C0br5YWPFDNoPiDuxkWyS7ISqPJS98/0OWjc
	/OzLf7q2IWpzvcAIyTsmD0idXp/kOhBmzNJOJXyKztAt0DDDUcN46efM4UAPI9f5UJ20nuTyxHn
	XuEtyg5Fen53D0wQsEaWuDHcL/gMqR7qNoDL4yxdCvHb70jciQaomJdcw7n+8OwiQqfLvYjzHjL
	Zt4W5PSrn7HfLydMz6s88GDr3YcyA2ewGNwmmlvBvwJRZdnq3Rt/uH9BjTaCrHk1PQTAOZ/Ydw9
	IEJnQV8euVuck3nNbdc/aMXeJ6KwNmB0oqHRlXlRo7spCK0Q==
X-Google-Smtp-Source: AGHT+IH+xZpvPIbhKx7mJgf5LQY0C/zJpDpvmdyPQ1VJnfhZtNoMsQ1XOGKSORZ38fLIo5wpD093Tw==
X-Received: by 2002:a05:6214:262d:b0:809:5095:4153 with SMTP id 6a1803df08f44-87ffb10cd22mr39426046d6.31.1761655979645;
        Tue, 28 Oct 2025 05:52:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48abea7sm79249956d6.0.2025.10.28.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:52:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDjBs-00000004Orq-30qI;
	Tue, 28 Oct 2025 09:52:44 -0300
Date: Tue, 28 Oct 2025 09:52:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <20251028125244.GI760669@ziepe.ca>
References: <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
 <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
 <a813aa51-cc5c-4375-9146-31699b4be4ca@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a813aa51-cc5c-4375-9146-31699b4be4ca@lucifer.local>

On Mon, Oct 27, 2025 at 04:38:05PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 27, 2025 at 05:31:54PM +0100, David Hildenbrand wrote:
> > >
> > > I don't love the union.
> > >
> > > How would we determine what type it is, we'd have to have some
> > > generic_leaf_entry_t type or something to contain the swap type field and then
> > > cast and... is it worth it?
> > >
> > > Intent of non-present was to refer to not-swap swapentry. It's already a
> > > convention that exists, e.g. is_pmd_non_present_folio_entry().
> >
> > Just noting that this was a recent addition (still not upstream) that
> > essentially says "there is a folio here, but it's not in an ordinary present
> > page table entry.
> >
> > So we could change that to something better.
> 
> Yeah but leaf_entry_t encapsulates BOTH swap and non-swap entries.
> 
> So that's nice.
> 
> What do you propose calling non-swap leaf entries? It starts spiralling down a
> bit there.

You don't even ask that question.

You have a leaf entry. It has a type.

What you are calling a "swap entry" is a "leaf entry of swap type".

The union helps encode in the type system what code is operating on
what type of the leaf entry.

It seems pretty simple.
 
> And it's really common to have logic asserting it's actually a swap entry
> vs. not etc.

leafent_is_swap(ent) - meaning is a "leaf entry of swap type".

> 1. we keep the non-present terminology as a better way of referring
>    to non-swap entries.

I vastly prefer you leap ahead and start using leaf_entry
terminology. We don't need a temporary name we are going to throw
away.

Jason

