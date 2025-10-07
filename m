Return-Path: <linux-kernel+bounces-844327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C90BC1926
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759D43A5C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CBD2E0926;
	Tue,  7 Oct 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQlKl8d9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF32D5A0C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845113; cv=none; b=XQEyJZffHMg6Pc0zKRK7l0ETdZfoSO6Lq2kqaLf3lD1sPE9upzYrAggu+0wzAeNKp4GHX8isEZOfO0/H9R5o+Urp7WBkBJJl9MN7tJpz8LME5VlzTueuIf/zFDSYJJl0c2udcogR7A0rREgm+XM4M+LJtqPL7/JFS/s5bAvRbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845113; c=relaxed/simple;
	bh=rbiqUhe+ruiA/MkSga2ynDZeTCKW5iAN+8x4s8hC+GY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgqQC+20TlvCM7q3/2CcnXBACoY4QdnJ/C/vg4Pyc10NcbUQYfKczUbGcXah1NbngB6wVbvdbg+AsFegvjr05/Itscwk4BzeUsO/SEQEBYBA7mu5xiwj7cxX5U2C3XaEoQiVYvwPU9BF+uxJLDsAkCniQDW8SUCMtggRSydBHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQlKl8d9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759845110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrQVt4Oy0c+QhuB8BTSmtP+2slJhAn2k60X6LTe3UUI=;
	b=gQlKl8d9xiLna6pb7xwitIzj6Og3QPP3RiovPBnhzwEHS3izJlNYb8xU0J0gbuHVUfhgLA
	oQEfRMTphK0kHJ7NU4FZdxBL1GEs7zTTsQdLfB5YgZpq+GVum6eanCTjxSNxQ+o99fqML7
	RwKwuz1vixHiQnSP8HXuB141zdVdmbM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-7Br7KeiXN5K_wNRCf6rl4Q-1; Tue, 07 Oct 2025 09:51:49 -0400
X-MC-Unique: 7Br7KeiXN5K_wNRCf6rl4Q-1
X-Mimecast-MFC-AGG-ID: 7Br7KeiXN5K_wNRCf6rl4Q_1759845109
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-79390b83c48so124627946d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845109; x=1760449909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrQVt4Oy0c+QhuB8BTSmtP+2slJhAn2k60X6LTe3UUI=;
        b=lHK6uGbVUoBQSCFEG+BHXY6Zv2FbQExRReIv5WUtbxoJpAwOmgrH/efP/XHS6tikLG
         RPgUFuddcOjCKK6fzuHGgIFKKwrkTEN3hipO7LRJ5q72r8PrZ3wByGlo5SSmtiMokWjJ
         MCvFKEre/tzO0hGVbus7hrGVOsHD6qF2o9wpquHbs+wfsoj3ay/ZKuYp/l/6YEkd+Drc
         BIu2jtRB/PZZuCpVDn64YzKL2ST28CaLIXSN9wOrKv/j6bwX6hZUYOWYTkkAt7A2DumT
         GiBTNxzWs3HVzzjwpVIE2kft4/wlqiMvMkRDJwDLpEo0fPGYEqMW0X8ROb1pn5FsfBLT
         zJVw==
X-Forwarded-Encrypted: i=1; AJvYcCU9WJrBHxwr1rwWXUwRKMekrLtowBFh8ffM+FI9JYYtK7AmS3+aH3UpoIqjK7v+WpuU42uiS3a4RndikVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUKHTsOsdPLEexZxgwQBddIYQA0trZzV3mNKbLEQ1koYOA7Po
	nONlSa/jvDMqE4KtjzmQjueWLO6ilFH2zL/HG8ugGhijW6CrySNeBQzO8uapybwgH9jojO80gIb
	fKq6tOuNEgcysbBXPqz4fIo9REcAPZ8nFxnaErtbfkwCZ3Oj2+xvwPSLjqGLR9b1fJw==
X-Gm-Gg: ASbGncte/HF09toN07q+gwNvGwURxOreX8TJ19HbuFXmhWxUrWjJlV0j5lUHcuUYxtp
	25HS6Cf0H7W1c8hn8P8Z0p/MXFnMDpqrhcs18yMrDXV7sjTvEoMsjy7neWHJBpzt9p6HFqS4TI/
	fC+CoLRtDOrd2UsJcdpMmOAlBm6nmuq2cDuP9XyGJSMOglrUHGnwqSBxsuZT4ZkII4CaTCWiPJi
	LjwhtP95TFizsaBN9gxalkkEo5dbsakpbSzOfjwBvQq6zG8WdZc+2e6k2o3i6s0G4tRBbAgNlIA
	8oQzxTpqzpLSXumkINkx17lGm2eBMC+anSZFAg==
X-Received: by 2002:a05:620a:290d:b0:864:e52f:311f with SMTP id af79cd13be357-87a346cc53dmr2292106385a.6.1759845108511;
        Tue, 07 Oct 2025 06:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyTN7ORuYSWPTrnejt1+QGmPLwI0L8U3s7S0+xuWtUbchmNvNTcasASdPK+56R/Qk+2jQJow==
X-Received: by 2002:a05:620a:290d:b0:864:e52f:311f with SMTP id af79cd13be357-87a346cc53dmr2292098985a.6.1759845107717;
        Tue, 07 Oct 2025 06:51:47 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a4448desm143437771cf.9.2025.10.07.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:51:47 -0700 (PDT)
Date: Tue, 7 Oct 2025 09:51:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aOUa8C8bhWvo5TbV@x1.local>
References: <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
 <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
 <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
 <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
 <aOQuZy_Hpu1yyu29@x1.local>
 <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>

On Mon, Oct 06, 2025 at 11:31:19PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251006 17:02]:
> > On Mon, Oct 06, 2025 at 03:06:39PM -0400, Liam R. Howlett wrote:
> > > * Peter Xu <peterx@redhat.com> [251003 10:02]:
> > > > On Wed, Oct 01, 2025 at 04:39:50PM +0200, David Hildenbrand wrote:
> > > > > On 01.10.25 16:35, Peter Xu wrote:
> > > > > > On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> > > > > > > > > > > I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> > > > > > > > > > > are rather unsuited for this case here (e.g., different feature flags for
> > > > > > > > > > > hugetlb support/shmem support etc).
> > > 
> > > I think this supports the need for a code clean up before applying an
> > > API that generalizes it?
> > > 
> > > I would expect the uffd code that needs the same uffd_feature would
> > > logically have the same uffd flags for the uffd_ops, but that's not the
> > > case here?
> > > 
> > > Is this because uffd_feature != UFFD_FEATURE_* ... or are the internal
> > > UFFD_FEATURE_* not the same thing?
> > > 
> > > > > > > > > > > 
> > > > > > > > > > > But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> > > > > > > > > > > the supported ioctls?
> > > > > > > > > > > 
> > > > > > > > > > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > > > > > > > > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > > > > > > > > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > > > > > > > > > 
> > > > > > > > > > Yes we can deduce that, but it'll be unclear then when one stares at a
> > > > > > > > > > bunch of ioctls and cannot easily digest the modes the memory type
> > > > > > > > > > supports.  Here, the modes should be the most straightforward way to
> > > > > > > > > > describe the capability of a memory type.
> > > > > > > > > 
> > > > > > > > > I rather dislike the current split approach between vm-flags and ioctls.
> > > > > > > > > 
> > > > > > > > > I briefly thought about abstracting it for internal purposes further and
> > > > > > > > > just have some internal backend ("memory type") flags.
> > > > > > > > > 
> > > > > > > > > UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> > > > > > > > > UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> > > > > > > > > UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> > > > > > > > > UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> > > > > > > > > UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> > > > > > > > 
> > > > > > > > This layer of mapping can be helpful to some, but maybe confusing to
> > > > > > > > others.. who is familiar with existing userfaultfd definitions.
> > > > > > > > 
> > > > > > > 
> > > > > > > Just wondering, is this confusing to you, and if so, which part?
> > > > > > > 
> > > > > > > To me it makes perfect sense and cleans up this API and not have to sets of
> > > > > > > flags that are somehow interlinked.
> > > > > > 
> > > > > > It adds the extra layer of mapping that will only be used in vm_uffd_ops
> > > > > > and the helper that will consume it.
> > > > > 
> > > > > Agreed, while making the API cleaner. I don't easily see what's confusing
> > > > > about that, though.
> > > > 
> > > > It will introduce another set of userfaultfd features, making it hard to
> > > > say what is the difference between the new set and UFFD_FEATURE_*.
> > > 
> > > If it's not using UFFD_FEATURE_ defines, then please don't use
> > > uffd_feature for it in the uffd_ops.  That seems like a recipe for
> > > confusion.
> > > 
> > > > 
> > > > > 
> > > > > I think it can be done with a handful of LOC and avoid having to use VM_
> > > > > flags in this API.
> > > > 
> > > > I waited for a few days, unfortunately we didn't get a second opinion.
> > > 
> > > Sorry, been pretty busy here.
> > > 
> > > If we can avoid the flags/features, then I'd rather that (the derived
> > > from uffd_ops == NULL for support).  We can always add something else
> > > later.
> > > 
> > > If we have to have a feature/flag setting, then please avoid using
> > > uffd_feature unless we use it with UFFD_FEATURE_ - which I think, we've
> > > ruled out?
> > 
> > Yes, there was no plan to use UFFD_FEATURE_* in vm_uffd_ops.  It's because
> > UFFD_FEATURE_* was introduced to almost let userapp have a way to probe the
> > capability of the kernel, rather than the layer to describe what features
> > userfaultfd has.
> > 
> > For example, we have UFFD_FEATURE_MISSING_SHMEM declaring that "the current
> > kernel supports MISSING mode userfaultfd on shmem".  This feature flag is
> > essentially of no use for any other memory types, hence not applicable to
> > vm_uffd_ops.  OTOH, we don't have a feature flag to represent "userfaultfd
> > MISSING mode".
> > 
> 
> hehe, the overloaded terms here are numerous, but I think I get what you
> are saying.  It's funny that FEATURE_MISSING isn't a check for a missing
> feature, but really to check if the register mode missing is available.
> 
> I'd also rather not have ioctls and features/flags.  It seems reasonable
> to drop the ioctl, like David said.
> 
> I assume there is some future plan for flags, or is this for versioning?
> 
> I'd like to one day even remove the suggested backend types and instead
> use handlers in the uffd_ops directly, although it is difficult to know
> if this is reasonable today.

The current proposal will be two fields (modes_supported,
ioctls_supported).  If we add yet another feature-backend flags, that will
only be used to map to the two fields but using one flag.

Could you elaborate what's the handler you described?  Is that one handler
returning both of the fields?

If so, I'd prefer that rather than introducing feature-backend flags,
because I want to avoid introducing another different feature set to uffd.

Thanks,

-- 
Peter Xu


