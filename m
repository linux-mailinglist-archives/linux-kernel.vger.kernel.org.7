Return-Path: <linux-kernel+bounces-838064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8BBAE58F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E64D1925F97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8A22126D;
	Tue, 30 Sep 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPDJeYY5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C12B9B9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258139; cv=none; b=rJ5ou6MEZLn0wcF8LTkk60h5jKR8gPqfWCA30+79iJcWvskOaxOs2/kxdpXb5lnUlgBau3iYQojRzg2jqDGWHktxzpvdLSXxC914zo6HbZKNqoOL+PqlST6mfhURwOZ4SAqdoEbQ2jyAv9kA32m7Z4I/OuhCQ/Eq3qpdoA2qEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258139; c=relaxed/simple;
	bh=EecMY+VkM0TbudNcpVA+uiLVhjbZensjFurwDNkAibg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keevpKZBYUZt5uj//vk3QRS/hJqZfUnxLHq5TDHuXQy4qkN4gaTjLg5arOLZ/Bq1lLUvbaZeFse8Yjq//B+lkvpfDXy/EtpILz/wTvuLX13YG0CqDH7uD23BqhXZbAKhLVRjfFhcCvHWz0jiSQUuvtfRmhsI9PbDnqV4sXbhyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPDJeYY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759258136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GsK2ZJQMv6HTGwzBtNFmgf1Bb8Mvb8sxIYfW5o9dQJg=;
	b=CPDJeYY53qk7dp0qBtRHsJUozPdb8IOBhEV4CsDOX+06Kdv1+1IQoQUK4pqJvdiiu13F6u
	yGS+67DfusdCIW2jYeVnHffxYabIVi870xgal1TC+pJonEy1AXs5agQHsTwtb5RWIM5FOk
	dJLNyeM/RNnV1cOPjYz76WbdTacv18g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-jAZtVJAYPPC8_NirFAnYiQ-1; Tue, 30 Sep 2025 14:48:54 -0400
X-MC-Unique: jAZtVJAYPPC8_NirFAnYiQ-1
X-Mimecast-MFC-AGG-ID: jAZtVJAYPPC8_NirFAnYiQ_1759258134
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-857003e911fso1409414785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258134; x=1759862934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsK2ZJQMv6HTGwzBtNFmgf1Bb8Mvb8sxIYfW5o9dQJg=;
        b=sd6zZ61dLHGc4b3cqMwHrgqZbxES/g98T3ypQvJ+cvd1vzfRaBG1yAln3dO3dfMejP
         xqN0osV1NT+5urBY9MjyJNyjwLVrE71QhrUpRay32t7O+tSq3O/zp4OmYEWMsDEek7wv
         sMlfcicFe8O2QZYuM7PpBqkgCNoYlaJB6+D6QRNmukx/vmnQ+leeF5Qi2fSTGWEnNL70
         +DvQlifmn33InixqcVy2JBe0U8gZvQtlsYMYy4ikb9mojIH1WYjSe6Y7El5O8NwJ+uOQ
         s0a7ySKpwYPWwJN/yQmhbis2hLLkRpHm0kDc+1LtWRZ1HeyxuNbDhCO8COLomvAgUK4Q
         1gEg==
X-Forwarded-Encrypted: i=1; AJvYcCUYz9tiDry3EmCNZHHkRcwnktPZXQZbkxkexU1uEVE0LPltVJxd2tyS0wv7Eb1g+R48mlEvIe8GqFIgH+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9/JNGlGsw/LWZwwzQw+ZowOD4dlKSYygPqYkVFusuwVMCkgZ
	aFp4GaqtoN1kvJBVJsVDSoLT8i5HKLAZRHgxhPwk7J7v1TPpiT3RIBoqRlL2KaaCyc7SAbevjAT
	VjsQ3Moog0jHNflU20t4z26xaSXjtp2Qu76uus4wGlTgbSSzTfAt6RZyLdy1MacO/UA==
X-Gm-Gg: ASbGnctO+Qj11RVzsHQU7yocfI8QFK1b3FrJpS0ag1YCIKIjakITZMBYcHfqgWwCm/g
	Tbt4ewxvqGxGD2ycP1sU9g5Ma7R8T5l9pUZNa4a7rmwElUsmi0c4edyedENE8Ahd6PGQmHO/OQY
	8cvGic52FzguI1iDS/2/sdfFuOqgLSF6i7uXSyQJmyXebbKzQzC1T2o/rBg+LboH6Y9vFiWv887
	yE9rDVkucEMZ3L+Qhwsw0QFFlt1bWUdl41/JXvUOMQm1SFn0ykjOrpYt9eAojLJdFWZ1vnr0oJz
	oOlCkk6sYHDKFhCccBRigcB2IHyRUO8lSMgAvQ==
X-Received: by 2002:a05:620a:d8e:b0:815:87ab:37e0 with SMTP id af79cd13be357-873758551c8mr121580085a.53.1759258133774;
        Tue, 30 Sep 2025 11:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR75yoXHKLyo204zRVz+mQdvcWMzFHs268w3lCm1SiwqLIybwfgDOJTTuWeF1rAdKiczAlOQ==
X-Received: by 2002:a05:620a:d8e:b0:815:87ab:37e0 with SMTP id af79cd13be357-873758551c8mr121575285a.53.1759258133235;
        Tue, 30 Sep 2025 11:48:53 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c337a1e1csm1083938985a.62.2025.09.30.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:48:52 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:48:51 -0400
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
Message-ID: <aNwmE11LirPtEuGW@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>

On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
> > +/* VMA userfaultfd operations */
> > +struct vm_uffd_ops {
> > +	/**
> > +	 * @uffd_features: features supported in bitmask.
> > +	 *
> > +	 * When the ops is defined, the driver must set non-zero features
> > +	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
> > +	 *
> > +	 * NOTE: VM_UFFD_MISSING is still only supported under mm/ so far.
> > +	 */
> > +	unsigned long uffd_features;
> 
> This variable name is a bit confusing , because it's all about vma flags,
> not uffd features. Just reading the variable, I would rather connect it to
> things like UFFD_FEATURE_WP_UNPOPULATED.
> 
> As currently used for VM flags, maybe you should call this
> 
> 	unsigned long uffd_vm_flags;
> 
> or sth like that.

Indeed it's slightly confusing.  However uffd_vm_flags is confusing in
another way, where it seems to imply some flags similar to vm_flags that is
prone to change.

How about uffd_vm_flags_supported / uffd_modes_supported?

> 
> I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> are rather unsuited for this case here (e.g., different feature flags for
> hugetlb support/shmem support etc).
> 
> But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> the supported ioctls?
> 
> _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> _UFFDIO_CONTINUE -> VM_UFFD_MINOR

Yes we can deduce that, but it'll be unclear then when one stares at a
bunch of ioctls and cannot easily digest the modes the memory type
supports.  Here, the modes should be the most straightforward way to
describe the capability of a memory type.

If hugetlbfs supported ZEROPAGE, then we can deduce the ioctls the other
way round, and we can drop the uffd_ioctls.  However we need the ioctls now
for hugetlbfs to make everything generic.

Do you mind I still keep it as-is?  So far that's still the clearest I can
think of.  It's only set when some support is added to a memory type, so
it's a one-time shot.

Thanks,

-- 
Peter Xu


