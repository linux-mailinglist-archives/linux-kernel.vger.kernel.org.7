Return-Path: <linux-kernel+bounces-869531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BDC0813A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F71A67637
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036D2F6176;
	Fri, 24 Oct 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qgjWqiQg"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DA2C031B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338244; cv=none; b=AMdACZ1zUTPo5nicSZqXPRiwig68zWr5UbhABOcaxZkiTKltl70qdNtTTagm5yzuUQm9wR4KMUOlFU+2wpRkTn3nweU9mBAe/gQxh0hfxQKYTvAA7esB9Wl0wuERjJquzFIoLzYJIK0tM4Jfu0i87z9pbpxbDyc1OYd4qPGYOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338244; c=relaxed/simple;
	bh=brPT+lM2XPdvJ0J0zQqzP3FRuejOJIrYJjvdheDJC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huh+jRXCUOfU2J25+uuAaxhNg1qaTPwVG0gglPW/4zQ5472EWkM1rLVZ3e4Tn8BIwIvhxAh+YDcM8ykaHAX95734WdglaWH+yf+j6k2pRV7IOYOwKvZLKCKOE3vbfNMmD0QJA0dQVykZJDIJ2rGukrvZ1EB+egdCK+AU36VsKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qgjWqiQg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eb7f0b9041so18568221cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761338241; x=1761943041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=qgjWqiQg7Mw0bd6Y7P3gb+spLRaKxWc55mXCg5lTEioPzr2WALPNAO9coZW5YwSU/Q
         CutOTbPQFirUB6W23YGRV/4n3KJAwDc2HuZ1vmW9vsHfhTQE1lFOzrT1zKthKJ1vN7w8
         J99nIJOu6f1vbKH/VbY6iGK7SaV9bmoiquLKjhFMYlujpJGyyVA8Y6ikqLPzjJZE3K4u
         OZgIq3WLWE0V48aNTFEFsT8fugi2BJ4QfjAxzSnSHsv/2yqeA/JFfFAvF5Jn45VPjnM2
         VbQo5z+uEOp/ZfIDudxeAtIZujmHqqIYhpz5spR8VsG3LNndPL57lSFQQ4mQS3eRwY0J
         boJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338241; x=1761943041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=tJnZCvdanRokzOK0w3jChVyqCws43WU43zCpRJAhFpCaCGQtLrVgp22q38qtj2kSEa
         Lejwt7y50Sg9U12FbDv0ApKJF7Q9I4//a2iK1eE25Y1i3Q3vh67trqrYQLeUII3ScAe7
         xysIceg5ur68zpXP32IaqI+E20B+Ug/8cJ8F4gAb2XSY3vxs2U2b+2KBLlbORkrQoXyh
         uCaNVZBAWlO0368yQuUM5IC9e2uZWnD3auX/dm/70oClBuv3FlNldHM0iBms1OWgOBWT
         dG+2zBd2ZRIDSTuI51mqIUHjyW5wOFukyd7I5egXgye0cqmkfqkuIuwSag6gwO7sIW3f
         tbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4fSH8orqKItnK7od3Tc5UTkW1yxEHFx5thEtUFKRB5TS3bMBhSMr5kM2MIzX649HIkfuxDToUuZbHQdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEVdxbqIYY8lY6d+37/sFjZheyHE7D8gNEa6b6XWduWMrk2k4
	eGHEuqIGOiw02Fg+4eaxZbEKAh+Q+cEDTT1/tkBPqA3LmkiCb6u9WwIzw9GF+3m+WWs=
X-Gm-Gg: ASbGncuO3Ubbepd5MqCnPj00ffUGZ32vO1Q8N2kPMp2UMIFkxMxQ/Sewp2xUtwTxdvr
	g4GKmhnSBm5hi3SaUGecPk0KD9Ax+BqMw6GiQWChXGOrmibphF1scMhkHQGi50m+1vNi7mDDYB2
	HaQY/di/h+LbFVtNCxOsgtNZotg/Oj2OhAae/LhtwUyzjsPvQ9+z3KGKKMokEcxZHb3pN8EABwx
	fvKmfvIvtHtdLcF7WpdQnrx4Tq7Id6IZtUmVd7+eK9CVbumsqMOSF34Kqd1uS+OIS4rdIcuzAcG
	+u4UfU/kaxzciQgncgdUB/92iB7wmIBa9GR2xfE7KrvtaypHCmmS+LVIADTIgXla1VizfLIJK/k
	a5aT44N4VwVWCMpyW1fPdAOWx2M/oKRYmxS+E/H9rUoweTIs0zPZDgBPMcajm0Viwp/B62bNTUg
	hSozHMewIVJqzD2UGnfCmPEFa5baKbBJukEss8IVWVndDur7853KJL/NIBPBaOtuM26JUQLw==
X-Google-Smtp-Source: AGHT+IEizsVD5MWKlpznZSR+oUAoDamQsr5IFux8tgX6jFrLAoh3hAikSuRK1/9hfCiWycXsqW7SdA==
X-Received: by 2002:ac8:58d6:0:b0:4e8:8ed7:da6a with SMTP id d75a77b69052e-4e89d20680bmr359946041cf.8.1761338241380;
        Fri, 24 Oct 2025 13:37:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b96d0sm861481cf.6.2025.10.24.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:37:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:37:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>

On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> 
> So maybe actually that isn't too bad of an idea...
> 
> Could also be
> 
> nonpresent_or_swap_t but that's kinda icky...

clearly we need:

union {
	swp_entry_t swap;
	nonpresent_entry_t np;
	pony_entry_t pony;
	plum_emtry_t beer;
} leaf_entry_t;

with

leaf_type whats_that_pte(leaf_entry_t);

with 20 more new functions about how to manage leaf_entries ;]

no not seriously, please have a good weekend!

and thanks again for doing this!
~Gregory

