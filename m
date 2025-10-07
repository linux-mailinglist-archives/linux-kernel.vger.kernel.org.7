Return-Path: <linux-kernel+bounces-844751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4DBC2AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865B619A20BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767622A7F2;
	Tue,  7 Oct 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBIgjBME"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166F22A7E0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869631; cv=none; b=hcyGSJayewd8qpZPf4WQ/+0qqxCsj3f/iHcpxbW3p6kiGGec1zFAwUdIUDkgTY+JeYNsGHNDQ5H+Se8qyiUHQrKyjDu9GgN9LP8L4SovT0u3M63w7a6zD61lzDtJ8BvurnuSlHVDtjT9W862CQ3c6dAWicCASzZqcwi40RU/Vm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869631; c=relaxed/simple;
	bh=Oz/tB0CYkwMQs15Ivu5Ase3b0Uh2M70X3h8ZnOVJBr4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX3LXPBqNzsLI+rlAGM7STJzCYCp9Gpwasxy1mc+/1pLlBIHiqtD/ulAupCmzR+E8Gm6kyj4jjOP03Kar/sE9jsuSye1TSnL9qUlP5Dm7nYGtflNq6JegLPEyy57X51MLsl7dT8dc//UlMsCI3/l+LhvN4aUAdbZExfGt/WRTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBIgjBME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759869628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/WZ6z3oBQe+qrHik3HZBUI/wg3QioRoFpqi0YyJXTI=;
	b=MBIgjBMErPVoeU1w+2voGILFNkojc8xHGMnpxcPfVOFWOzmqInK1k2IFghO69vk+vTM2yN
	VFj7XRXNdf405HD3p2MTmjEFhJzQvGkSAPVSo3nCNYVrVrPJYE/XS0M3cZ5xLMRa4uynJv
	FUg9M/c8F+Ve0s9vrcTsl5w7oE9RF3Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-FiBM8yyqPSegqPm11ZsD9g-1; Tue, 07 Oct 2025 16:40:27 -0400
X-MC-Unique: FiBM8yyqPSegqPm11ZsD9g-1
X-Mimecast-MFC-AGG-ID: FiBM8yyqPSegqPm11ZsD9g_1759869626
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df80d0d4aaso124560661cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869626; x=1760474426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/WZ6z3oBQe+qrHik3HZBUI/wg3QioRoFpqi0YyJXTI=;
        b=B+0SUTpjfgjMjcPDE/SWQ0sm9DrjRiIbY5ZjHB9XBaSpQffl2IkVS8fXBYzyzU0rKZ
         +83tAwn+tx3DqC9oMY6XK9kbZIRXryAXJUuJn+EB1/jor7TMvP0y5Z64I8RdMWRD/6Q6
         FmC2SH/D9BQ4Li0ECDeJIQT0VdA4nw8V9mSghxvubhOcFdX0Rhnuj6tqopcjSGSWWuMx
         o1AFof5p9sYnqHdLH2cCT72CoOKNIg1RzdeXxUA210ceP0hYGMlmvFz8pCmr8zuHSBwJ
         j7NtzubxV/AxU/X8onjPtjzFJeqp0sp9aaity4P9ZylSotZvIvVrhQ3KiJzaOr4b/l5K
         JDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQOK0b6b7yRiVqPEXgVy1Mwc1qq9cLUJ/IQW8lmsIJ51vJv+RYYnw3CO81Pukm7eL/plN70OFsmrbtk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLskLoMGHlzw+PTgVI02dClxaNFaH0SKZSAjW6wIcIfaxNGQ9B
	Qzw3vynub1AXyNJfixu0q9TjqvnW/P1a1n4Ti8IvgSNyJdQbpOtXczmq2uS87cmAAWT6cXPI2cl
	NlnB6iizREc0caS2Cv2XvJaBy4bVkolxB1qEKdcuCIuoOttZaE3Lc+0FgPevGZNzmeg==
X-Gm-Gg: ASbGnct7jJs+GFMxxgaRaQ0aH5e/be65seB33DewEYjSsecLNGLs9gp9s3He7J1d9sz
	Xj1eranG1lWToSLfVLwza5rMmslD50v//7uQxxsKWv6snc0obVa0wK6ySC2PliL6d17VctzK5Vl
	j36Pq5oR+JSmffVG71y8/XZ0I814XTcTnNzZXbaBhpWqDNngbpZJRtXyVt8AnLCX1e8zGUjnkK0
	xdf4v4rbQDug3OdoAWzTuIrCEPfooWkBrN8Ml5PHLjPPUH2dQQOcTdjVPNP0kmZUZOg2yWepFsv
	uMvqVAKv6h9/qNMhV/OGXBxFm960dsy4xWqYIQ==
X-Received: by 2002:a05:620a:28d1:b0:828:6f7e:879 with SMTP id af79cd13be357-883521db3b2mr192514985a.52.1759869626179;
        Tue, 07 Oct 2025 13:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9xBA940n6kRoyXPAy5XEeKHkXneQCWPoqjDHrtncfqMafSdhwjOsgyCfguuM3RUeHnC5t/A==
X-Received: by 2002:a05:620a:28d1:b0:828:6f7e:879 with SMTP id af79cd13be357-883521db3b2mr192507985a.52.1759869625472;
        Tue, 07 Oct 2025 13:40:25 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877711296b6sm1615975285a.14.2025.10.07.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:40:24 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:40:22 -0400
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
Message-ID: <aOV6ttA17Pt2S8xO@x1.local>
References: <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
 <aOQuZy_Hpu1yyu29@x1.local>
 <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>
 <aOUa8C8bhWvo5TbV@x1.local>
 <frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy>
 <9089d994-262f-4941-8bed-f3c6ee05a769@redhat.com>
 <aOVEDii4HPB6outm@x1.local>
 <6csw4pmymno4kdtlbzd74posr3dekamq4zkje2mfkmbg5q7xbx@y3o323tbm7h3>
 <aOVtAMm8PqEbGANh@x1.local>
 <33wnllmydtdlv4vf3rzz7ei3vg7t7x2gqqha27ib3i47lfd6mz@n3nyevb4yf26>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33wnllmydtdlv4vf3rzz7ei3vg7t7x2gqqha27ib3i47lfd6mz@n3nyevb4yf26>

On Tue, Oct 07, 2025 at 04:25:48PM -0400, Liam R. Howlett wrote:
> > Would it look better to you if I drop uffd_modes_supported, deducing it
> > from uffd_ioctls_supported?
> > 
> > I believe that's what David mentioned very initially here:
> > 
> > https://lore.kernel.org/r/f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com
> > 
> > I'd rather go with the two fields, but if we're trying to introduce another
> > feature sets almost only for vm_uffd_ops, I'd prefer keeping it simple, and
> > deduce the modes from ioctls.
> > 
> > Is that ok for you?  So it'll have (1) get_folio(), (2) supported_ioctls.
> > That's all.
> 
> This is still middleware - a translation of flags passed in to figure
> out what function to call.  I don't think this is the best path forward
> as it means we have to complicate the layer for every user we add while
> we are already providing the most flexible return of a folio.
> 
> This will end up making things worse, IMO.
> 
> Think, for example, we add hugetlbfs_v2 - every place we have
> "if (is_hugetlbfs())" will now need an "else if(is_hugetlbfsv2())" to
> accommodate something that probably has the same uffd_ops as hugetlbfs
> v1.
> 
> Why would we do this instead of actually making your uffd_ops a complete
> API, or at least a subset of the API that supports guest-memfd?

It will be the complete API with (1) and (2) on minor fault.

When one proposes hugetlbfsv2, it should make sure it will work with the
API that only has (1)+(2).  Some uffd paths may need touch up (e.g. on
detecting VMA sizes), but it'll never be "if (is_hugetlbfsv2())".

That's IMHO one of the major purposes of having hugetlbfsv2 after all,
which is to start using the common MM apis, including the one we're going
to introduce here.

Thanks,

-- 
Peter Xu


