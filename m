Return-Path: <linux-kernel+bounces-879033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9BC22176
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FC794EA1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AFA3126C5;
	Thu, 30 Oct 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlZIPUNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7551313297
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854152; cv=none; b=cr6ZU5M+++gj6UaNTpZPSuKf0f6ymgpPBMA0DaYGABQnf/yk+NMc+7UxE2IObCtQR99UmUZEicqaN/gxFaZUT07Rb9vqzTK+ISd7XEnRdHxzjKrsKgLGzCKVQ8S44T0RUstJHiVyK8Ac81iZlk1+E8d4V6+RpJpwx+4DdinrtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854152; c=relaxed/simple;
	bh=koY6lh5e8iod0cwGNGY4VXb+dxYu5tjh1wtKUy2n2YM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljF/8CVsra/zaqWv6RLikZGYNXIcfZBUKoBoVNb/Ewx8JkAnPTZd3Ec5pAQMEmP3hM4jdhIttvNiMHUdEdQyzDrITByIu8Ht8hqneUGwU9Uh/89a06Ze4y8/pc+uozvz7CSIUfY/4Z4VTB+kt47YMsqle8ueeoWdmur16ZZHRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlZIPUNx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761854149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOfjpjtn1M8qsaqsd1nqTT6We9OytpooWr9SyKG7CNE=;
	b=YlZIPUNxq2ayoGwKZw3ZvDLJuFFUKgFImxcQHdeTDl81q07pZizHR2n9ID9fKUpBUy8tCD
	xDLXfipxytFGx/+S1jLVb7qIZk7qh7zewfbUx6zIVTMhFOO7CvnxQF71/aNyWo2Fj7ceJ6
	Rwyrw32utRFS56LPHrrF0I1k9ukjwR4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-o5P6s7aXMQ2XBDHsufexSQ-1; Thu, 30 Oct 2025 15:55:48 -0400
X-MC-Unique: o5P6s7aXMQ2XBDHsufexSQ-1
X-Mimecast-MFC-AGG-ID: o5P6s7aXMQ2XBDHsufexSQ_1761854148
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf4540bb6so37650661cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761854148; x=1762458948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOfjpjtn1M8qsaqsd1nqTT6We9OytpooWr9SyKG7CNE=;
        b=MkYIgtIV1T/ixaqBu6skDP4qsKvJ7rFEdmzWeUNgPma6XtgXnKlQLmQOH1bYAk9wUs
         Tx6rjI12ST3boD+LFUSoxaJCB0FQmlgXxk6t8S0AWP4oU3EIVnlkeLcpxlEUfMDfDXLI
         KJidd/UABydD8f9QnaDZpCjU1ckzekFeeR9hCgd9W3QyODdlwfNs6t/5SgZPcQzzLm9z
         LkqUU/tQYcQa/uTpFOLvzgbSHJQVv4w0mmopAFbqaX0qTq4aP79P7xXM+HuoizrZejFB
         xEVbUDp9qaoYqDBxOHoTjgQweoNSc/TRVPN+/bZD8IqdVjQWqjCg5BzxCluU62l5bEP9
         W/kg==
X-Forwarded-Encrypted: i=1; AJvYcCW79b6sxxhBBC86p2yuAmCwfykKSPiMF/V7J2721KBzfJRFYBScP18m80y3FC2Qr6JZZFULC2b8QooZDw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzQI2vdormp5Gl0NgW7fROpQzNg6Mi7feXPCVxYBR6qrvtqXC
	OdJ8FoYE/tiTwMsxbpRnEdUNxdOe+0vnPyqRk+SblflgzBQ0wEJCnFJ2I/der+bRVSw81egkjnN
	hTWNcqqTvwXYMaLFp+ipjtjnjIs+q7og3RyqWynWMoXaXVGq8a2p5DOuhYToCzjNLsg==
X-Gm-Gg: ASbGncvg8yYMb6RbzlyQSXC3BQEghM2LLJsb7EUmC5Msk1Ch5lkaf6Uhl3cVmGgokAy
	3mTx4WLarE0S5nfEBtAgnCXTQY5TYgHcZwZsEFwrwFHG+VEKx5IkPwjrFvNjRKHABZM6vwvwFQO
	AMzAAa3HKt8XxuW1znnxnJu9ZTOlVUg57xj3SlpFgwyYJtXIS5k1kIsfLSc4DJntWUsEiZcY0wM
	pqq0rgi/WaH08UKvgcdUKFBngNv8Xrc9+kGOySkTpr5qT8wevluqVpQWUoFrFfHIidpGntE1OvR
	XwWAmwOnKPbazc2VqosGGlOlkpF5gEOqXuROq9Xk8K8cUQLKPyAJtuKqP0/L8YAuPIg=
X-Received: by 2002:a05:622a:1b8d:b0:4ec:efdd:938e with SMTP id d75a77b69052e-4ed30e1602dmr11808871cf.11.1761854147745;
        Thu, 30 Oct 2025 12:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRKBZnDt6f3bb2SOJLIKbgdsaWvqS0L1Ou0EOOZO2HK+UfbyRXmOhLAztZKbpEZv2OLHJBzA==
X-Received: by 2002:a05:622a:1b8d:b0:4ec:efdd:938e with SMTP id d75a77b69052e-4ed30e1602dmr11808661cf.11.1761854147220;
        Thu, 30 Oct 2025 12:55:47 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24dd5ad9sm1324998285a.22.2025.10.30.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:55:46 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:55:44 -0400
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
Message-ID: <aQPCwFZqNd_ZlZ0S@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQO3Zko6Qrk7O96u@x1.local>

On Thu, Oct 30, 2025 at 03:07:18PM -0400, Peter Xu wrote:
> > Patches are here:
> > 
> > https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> 
> Great!  Finally we have something solid to discuss on top.
> 
> Yes, I'm extremely happy to see whatever code there is, I'm happy to review
> it.  I'm happy to see it rolling.  If it is better, we can adopt it.

So here is a summary of why I think my proposal is better:

- Much less code

  I think this is crystal clear..  I'm pasting once more in this summary
  email on what your proposal touches:

 fs/userfaultfd.c              |  14 +--
 include/linux/hugetlb.h       |  21 ----
 include/linux/mm.h            |  11 ++
 include/linux/shmem_fs.h      |  14 ---
 include/linux/userfaultfd_k.h | 108 ++++++++++------
 mm/hugetlb.c                  | 359 +++++++++++++++++++++++++++++++++++++++++++++--------
 mm/shmem.c                    | 245 ++++++++++++++++++++++++------------
 mm/userfaultfd.c              | 869 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------
 8 files changed, 962 insertions(+), 679 deletions(-)

- Much less future code

  The new proposal needs at least 6 APIs to implement even minor fault..
  One of the API needs to be implemented with uffd_info* which further
  includes 10+ fields to process.  It means we'll have a bunch of
  duplicated code in the future if new things pop up, so it's not only
  about what we merge.

- Much less exported functions to modules

  My solution, after exposing vm_uffd_ops, doesn't need to export any
  function.

  Your solution needs to export a lot of new functions to modules.  I
  didn't pay a lot of attention but the list should at least include these
  10 functions:
  
        void uffd_complete_register(struct vm_area_struct *vma);
        unsigned int uffd_page_shift(struct vm_area_struct *vma);
        int uffd_writeprotect(struct uffd_info *info);
        ssize_t uffd_failed_do_unlock(struct uffd_info *info);
        int uffd_atomic_pte_copy(struct folio *folio, unsigned long src_addr);
        unsigned long mfill_size(struct vm_area_struct *vma)
        int mfill_atomic_pte_poison(struct uffd_info *info);
        int mfill_atomic_pte_copy(struct uffd_info *info);
        int mfill_atomic_pte_zeropage(struct uffd_info *info);
        ssize_t uffd_get_dst_pmd(struct vm_area_struct *dst_vma, unsigned long dst_addr,pmd_t **dst_pmd);

  It's simply unnecessary.

- Less error prone

  At least to support minor fault, my solution only needs one hook fetching
  page cache, then set the CONTINUE ioctl in the supported_ioctls.

- Safer

  Your code allows to operate on pmd* in a module??? That's too risky and
  mm can explode!  Isn't it?

- Do not build new codes on top of hugetlbfs

  AFAICT, more than half of your solution's API is trying to service
  hugetlbfs.  IMHO that's the wrong way to go.  I explained to you multiple
  times.  We should either keep hugetlbfs alone, or having hugetlbfs adopt
  mm APIs instead.  We shouldn't build any new code only trying to service
  hugetlbfsv1 but nobody else.  We shouldn't introduce new mm API only to
  service hugetlbfs.

- Much less risk of breaking things

  I'm pretty sure my code introduce zero or very little bug, if there's
  one, I'll fix it, but really, likely not, because the changes are
  straightforward.

  Your changes are huge.  I would not be surprised you break things here
  and there.  I hope at least you will be around fixing them when it
  happens, even if we're not sure the benefits of most of the changes.

-- 
Peter Xu


