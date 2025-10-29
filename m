Return-Path: <linux-kernel+bounces-877198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CBC1D6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8884407B46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDD31AF17;
	Wed, 29 Oct 2025 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="urLqhlLl"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57631A562
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773025; cv=none; b=IuzigrKG9UtBhHFIF/P6JPyYM/l5iGtQYg6+hq2bu8TXHvtkj9xzzpATKO4VQBBfdoWLCSD43g2gKvMg8r9H+GLuw2riZYTeLdZt1lAa75IZaxjWEvS0e2Lyb3otyg/1tg8W1kgr728A9GLwq/2zBcb90lLnA956jmHdG5V35H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773025; c=relaxed/simple;
	bh=ehgfTYPPDlsusZMBOPSQ1VgmMj1ez7+siAFBL0GrCb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfrk9mRwAz1SyHZ/82u4rALW7i58NQDuYytg2ho3JzVDdscF/gA5aqCW+DCiHtwy7rpS5afto6CkhRtWkspkH373JWVw2zMc+KKXPUxvmx3tli9nBpUnw3av0dMh/fVFauCQC9ayVyjbBXKC5cXWJag30ykHa0PH2sE7GmVqwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=urLqhlLl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-890521c116fso24838785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761773023; x=1762377823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRjtLU1r2HfZv4PRAYf6oYIopT/Rmxw6gRmhQBXOWjA=;
        b=urLqhlLlu9UJRrNAv8mxw8gJSp5bTU1q4MfB4xz/BNdfJojwPWc3ojV+Xqu7d88+Gi
         cx2KJuVyH2djo08+S0tPYNoHfLa5P1ipiuJCTfFnogktqc9DCKdKt8ZRfcGZX77HKkUv
         9bk2VsOtQpbQfvzRNkzRF4w3+4Fm+F3EBJVJAoElPSdBVO8MwUlvqk39+rrAz5ukULGw
         4Q+nxxdFSwsmvwnWS4fleRIK/xG1X/CQt/XhSd9YIg4BgQsxkbc0TIyrARhRlvSwdwU8
         fbhCTOvZm4jtYMSrfupKg+0YP3/iURXwZp5hF5pg8Jv73Hd2Xi9YOaS7C19p8tExVTjR
         rFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773023; x=1762377823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRjtLU1r2HfZv4PRAYf6oYIopT/Rmxw6gRmhQBXOWjA=;
        b=DjKEpeBdbNhZ6K2ADKO89FXfMpp+YYpZQn0YYsmmkjaeBGZ91r22Ca05w0Y+0eNqcv
         7fJCk1wh4TQnKZaEt9aF41smyLe1Y91yty2PwiW7a+Ve+DkWuOZgaZesIfU3PHKiwlWP
         /0GlRSJuqynuH/mkK5maokNKyMAVz4M1FZm/0iSMK4TwhE8tf/FCGWHtbxICC9AwOsz9
         BUAKFpTJN+yv3LtWJYaSAQaHwjhjeSd8o3ViglKPwnjIJRyi2EaR6U9pdoeNK+qv747C
         srdogvjoMMgpXRcKznqXiQ8B9G7EmczmWTVGNRoTveuMP+fee1MGyqSX9q30hA8XZd+x
         t7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUba3ICOTL8yteTFNJETXLl//h4Z9BZyoBU4htgGObpkk+VaTRGbVFji4wi0EY1TzZ6q+9AcB6WMKSQRQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0GUNal075kRMnyaovAC2Z7jbWdZJJl55MyowRdDyQBXKqWGt
	6Ub6Oh8y2Ppf634+Hzzm56aboBUQ/XtJKmvtbG5UNrfu7xy0wLxW95/Pg4Co2rYUWmM=
X-Gm-Gg: ASbGncu6HsnyhMhUWdzjFURig7bLw4LmfSpw/bdgbq+a85mGiEftFBOFZadTLLmU7Z0
	S6Gfqwy/+3asPwRw8QPKWKj/dlloX4Bn6p7TG5zG11O5NpOk3CuxwDWP545JT8mZbcQdovTs+JW
	QMZFB4wxDKs0du+gWsP6NZVdPW98PgW+EP/3fLNK4qVf8Y6Cn0tFuv/PLeHKKrJ0uaYG/Bq1zZ1
	pzCGwfCkFg2NWX4Mwvyf2nIj+PsjCNwf5ddMuxeT7W+CroqJRHo7yWUf/J6XxAngzpyKHVkupa3
	cRi2HG3dQWcZzRL88TsqssTweHHV321nFl568IxL3KoYTAk8+d2yKyZP6Win2fbUfF3aeXlcSbp
	+7WhZEiuPWuv94i/DiC0vxvyMC8H7/6/nHH1hXHIv7Ti6/OOcAXc3lzg87srP5qlbI02WoYrIUm
	xIa1txjci8SiZHuDKkZXZ4Lw/WCWG73c4E+94hxodAM8NsV3NDASwa4LXX6hY=
X-Google-Smtp-Source: AGHT+IHIvemppeW4VU2bcQtfcjjrB/a+ZhJ9fpfDcYpqh7YEbBY+IwMLRkdQTC8NbNXnWXScRwyJQw==
X-Received: by 2002:a05:620a:29c4:b0:82e:ce61:f840 with SMTP id af79cd13be357-8aa2ea07948mr164184685a.84.1761773022583;
        Wed, 29 Oct 2025 14:23:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc6fsm1114391785a.9.2025.10.29.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:23:42 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:23:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
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
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <aQKF2y7YI9SUBLKo@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
 <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
 <20251029141048.GN760669@ziepe.ca>
 <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>

On Wed, Oct 29, 2025 at 07:09:59PM +0000, Lorenzo Stoakes wrote:
> >
> > pmd_is_leaf_or_leafent()
> >
> > In the PTE API we are calling present entries that are address, not
> > tables, leafs.
> 
> Hmm I think pmd_is_present_or_leafent() is clearer actually on second
> thoughts :)
> 

apologies if misunderstanding, but I like short names :]

#define pmd_exists(entry) (pmd_is_present() || pmd_is_leafent())

If you care about what that entry is, you'll have to spell out these
checks in your code anyway, so no need to explode the naming to include
everything that might be there.

~Gregory

