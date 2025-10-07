Return-Path: <linux-kernel+bounces-844532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370FBC2255
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1946619A4EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC022E7186;
	Tue,  7 Oct 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG9q3xUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1138F6F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855642; cv=none; b=TokuKLJN8J6RzZWul/ZDH9c+Vg7eF2myLrmxQkkd7bZuxbiatDCe1kvi2nJXLw/fWKBK2HcWQ6oiKpHVp2DIluLAY+OuGFGF7NdoT7xo5qpoGYFZjYDWVxX2ljsRX6lW9QhooT/4mJfaoljeMGB1CZ0cADFQE2L40feUC2fba/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855642; c=relaxed/simple;
	bh=U4Cqlhfbpv/uCqPeNFXCL04OqHPbhrmByPIWnA8v0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdMW7pfQmxUsM2e07c0MOTGf68QS3s8CWT/olWOlfEqnvw/LiOaOWqBKtcgSnIS3M7xEcvYn/l9zvSgvHOfQWmzYFWj3EIOw+Hpj34txeY+KBHdoGOMGsHFgF8qoB1ulHBXS1ioTCJtfwvuNLrGMjqfO7H/CTTgyN/cwiCAGzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VG9q3xUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759855639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTOFzWIRXXry9icZqnPg5XCEpLea61ztG7L2WQgFEsA=;
	b=VG9q3xUk7Z3NH9EBOG4n3Qdnbiz98LKMTqnotA9e7fQyPKD4ThCfQarNzYmQqfISMF7D7k
	TJBRQjLJ0es8Y4dhlGxKSeOIe4OI1zNzzRISfxGzoPsTkyZzUC13Hx5kVwWrQQ+APZT2WU
	6bIEojxSc/ASfBhKLrycEc67hUsRvdQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-BALS8lHtNqewDTmHX5myYQ-1; Tue, 07 Oct 2025 12:47:16 -0400
X-MC-Unique: BALS8lHtNqewDTmHX5myYQ-1
X-Mimecast-MFC-AGG-ID: BALS8lHtNqewDTmHX5myYQ_1759855635
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de801c1446so141219771cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855635; x=1760460435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTOFzWIRXXry9icZqnPg5XCEpLea61ztG7L2WQgFEsA=;
        b=ocr60iJXY3Ig6FI6HWqA92YufOMrn89rHc9pwrXDSBCSYVyhOnd2yRcvrR4RQiKbWP
         XCgFJWXw3089ljcome6LHuOQdksqaGbTjlO9Rme6FkNtKTCookqsLNj7SeQS2wfgvypI
         RSTRFRXnQSHzQd8TagKyjb6y03ijn/o7i7UaEEE0GLfyTrpeI3pgr8a6+Oyfyl1PQmqW
         SQOKDRkvgRRvxrwKG73AlNLOxdYEpt3SWGZ5T+gRWxN8d2hUC2rNpRTGVtETIVhCOTTz
         i/nLT825D7etnAnMx1jfpepsFWamKU9hCGdnOjjX91Pm4C0yV9QMPjiRz6nMs5SHVskL
         LkRA==
X-Forwarded-Encrypted: i=1; AJvYcCXXMDFgOgDWVrQLkdCWJCq4Yfw7dttXfTZoZL4O/H7orz/trYrJu8YMtZDH7fmBzUpniqXjavTw9D5ccIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXu3Ifd8JinWkzRx9mU9yTUqIk3KvoaXnBehU30wHvwur2F0A5
	q0gWFcYpslvSWKHyuvVCQ61lnHaaACZqUi5S3/G3pCLVzDgqBNvxl0y6Nzf4Ddw3n0XWEbLjONJ
	Vb1apt1VcejieIM57z3XaiMniDH5JQijQ6srwpcET8SokB9DQrepXxYGkPKHyzOFol8N9h3VKHQ
	==
X-Gm-Gg: ASbGncscq6BYqJLCGbKjIBG1I89MT6tuRHTyJuygK47c1Cx8rMRVTc76aH4KEj7rr/E
	oZPMurffKZihOsY7cP6+h00XXerK1FvXGZUP0qa53Ry99UZdSsA0oTol/Ha3E/2IUK8DccB711Y
	WQG9UvTwW1raaAo/NudQYIimkipFQxyUPBO9Gertciy52seXkX+XID3LUkWzG9ydB++IclNtTBM
	rSb/8+0ltXgq53UP3IYh9ZHXFBpO26iXOWMxzSoSTKFHw3s4n29mC9NhFOlnVRNqq42gMzDAZg9
	BU/pl/ppX4FD8w1rvU0fbTx3K6NRIRGilGDa9g==
X-Received: by 2002:a05:622a:107:b0:4b7:95da:b3c7 with SMTP id d75a77b69052e-4e6ead4b0eemr3307381cf.48.1759855634995;
        Tue, 07 Oct 2025 09:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8RX884Zg/mlMH86KuApH2VeuJdNzehLkNSygcZJ0HaGfZTFTmEttK1Cc2JLQhTCyVQ+bWvw==
X-Received: by 2002:a05:622a:107:b0:4b7:95da:b3c7 with SMTP id d75a77b69052e-4e6ead4b0eemr3306771cf.48.1759855634461;
        Tue, 07 Oct 2025 09:47:14 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e78cfsm160745871cf.27.2025.10.07.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:47:13 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:47:10 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
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
Message-ID: <aOVEDii4HPB6outm@x1.local>
References: <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
 <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
 <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
 <aOQuZy_Hpu1yyu29@x1.local>
 <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>
 <aOUa8C8bhWvo5TbV@x1.local>
 <frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy>
 <9089d994-262f-4941-8bed-f3c6ee05a769@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9089d994-262f-4941-8bed-f3c6ee05a769@redhat.com>

On Tue, Oct 07, 2025 at 06:14:01PM +0200, David Hildenbrand wrote:
> > > If so, I'd prefer that rather than introducing feature-backend flags,
> > > because I want to avoid introducing another different feature set to uffd.
> > > 
> > 
> > I was talking about uffd_features.  I thought it was being renamed to
> > flags, not modes_supported.  It was pretty late when I responded.
> > 
> > FWIU, David was saying we don't need both of modes and ioctl listed in
> > the uffd_ops?
> 
> Right, I would have abstracted the features to clean it up and avoid using
> VM_ flags in this interface.
> 
> > 
> > I was thinking that we could just put the features directly as function
> > pointers in the uffd_ops and check if they are NULL or not for
> > 'support'.
> > 
> > ie:
> > 
> > struct vm_uffd_ops hugetlb_uffd_ops = {
> >          .missing = hugetlb_handle_userfault,

This is not needed because the logic to handle userfault isn't very type
sensitive. Hugetlb is the only one that differs very lightly, but again I
think we should better take hugetlbfs as special always as of now, per all
the previous discussions on hugetlb unifications.

> >          .write_protect = mwriteprotect_range,

This is not needed.  WP processing is the same.

> >          .minor = hugetlb_handle_userfault_minor,

We can do that, but ultimately we do almost exactly the same for all memory
types except a fetch on the page cache.  IMHO this will make it awkward..
because 99% of the minor hooks will do the same thing..  OTOH, it makes
more sense to me that the hook is defined to cover what is different on the
memory type.

I'll stop commenting on the rest.

> > 
> >          .mfill_atomic = hugetlb_mfill_atomic_pte,
> >          .mfill_atomic_continue = ...
> >          .mfill_zeropage = ...
> >          .mfill_poison = ...
> >          .mfill_copy = NULL, /* For example */
> > };
> > 
> > Then mfill_atomic_copy() becomes:
> > {
> >          /*
> >           * Maybe some setup, used for all mfill operations from
> >           * mfill_atomic()
> >           */
> > 
> >           ...
> > 
> >          dst_vma = uffd_mfill_lock()
> >          uffd_ops = vma_get_uffd_ops(vma);
> >          if (!uffd_ops)
> >                  return false;
> > 
> >          if (!uffd_ops->mfill_copy) /* unlikely? */
> >                  return false;
> > 
> >          return uffd_ops->mfill_copy(dst_vma,..);
> > }
> > 
> > This way is_vm_hugetlb_page() never really needs to be used because the
> > function pointer already makes that distinction.
> > 
> > Right now, we have checks for hugetlb through other functions that "pass
> > off to appropriate routine", and we end up translating the
> > ioctl_supports into the function call eventually, anyways.
> 
> Right, it would be great to get rid of that. I recall I asked for such a
> cleanup in RFC (or was it v1).

I didn't send RFC, likely you meant this reply in v1?

https://lore.kernel.org/all/0126fa5f-b5aa-4a17-80d6-d428105e45c7@redhat.com/

        I agree that another special-purpose file (like implemented by
        guest_memfd) would need that. But if we could get rid of
        "hugetlb"/"shmem" special-casing in userfaultfd, it would be a
        rasonable independent cleanup.

Get rid of hugetlbfs is still not my goal as of in this series.

OTOH, I generalized shmem and removed shmem.h header from userfaultfd, but
that was prior versions when with uffd_copy() and it was rejected.

What should I do now to move this series forward?  Could anyone provide a
solid answer?

Thanks,

-- 
Peter Xu


