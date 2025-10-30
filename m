Return-Path: <linux-kernel+bounces-878250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22873C201A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD0A1A250E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCF354AC6;
	Thu, 30 Oct 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ctg4oghw"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479734D924
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828760; cv=none; b=YI4+NNkImiiwdCv06/0kpXtkM9joJbkb5gD2kySa+hXKQUgTpHHA+t6ZGxEil7OTxACaaLkcuGCvAT4WBcNfA/vgsmIZOeljKw+iwKF/E+78RfTyow3c62oNHthwVqLHd5/BclxQi1v22D9smv5aOf/a3V6O0WK8fPXx0XGCz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828760; c=relaxed/simple;
	bh=ueVmkCcZ6Fn8px+zLdb8kTT+GDQqAsSoqXj2QT6A7IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMY9H4mJV2iuAFPdSUiyAuYxSfkn00qWIacUTK4vC4NjyiNookIzFQjHUn2V1/RhHiLnkwlaulGiLEZKwWoh8Kl4H3qvahcdGKCnQ8B7H2zCDb5jdWgq/FyNQPXZdfvmy7vHSQ5n/NosMCkc/fHyXhAAIJIv+QSN64gaJMJQGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ctg4oghw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-795be3a3644so6590906d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761828758; x=1762433558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhWJzGzGzYtcQeOF2Zd9nQeXdar54wkYdmN+7gtiSCA=;
        b=ctg4oghwmGsO8lan6lbDuCBstoSbfveEO3Xc7ptzGIUf7Bf0jjJrADE5dYPu9cyMZN
         7WY5rnS4KnUQf9W5wpfrsAbJjdsCgovUL8ufEKsiYIPf40frltth6VEDTxtVUA8CXApx
         3+n0RQNxAabApXj7GRVo5MhZ/+Qg6XikHiLtvKeCD7eJ9uwO7Inkn3oS3uB/LVI1yQkt
         0y16M47qeo8HMLdzFsJCCjwRduFfJK0yeWDapv2qKFY1rcFMYrNTyK8dJ1jIMfwk4fGC
         K3tpU8txpZz1uAY+dXc+4UDkhlzkph2VGxkgjKka2EDDidY7BVPgM3Rcx28xIkSsUsNP
         H5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828758; x=1762433558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhWJzGzGzYtcQeOF2Zd9nQeXdar54wkYdmN+7gtiSCA=;
        b=RBsvC/LyXkbPQ3V6RPWFkcqK65ttyRhEfVE3p/rAW9DMM09X8gZTaLQBa8a+gPtM/c
         N8mRQA/eQL0a2oNdMsnul/os3tTlEi5QT4Owl/1GuFI7mQptoAPU1nifCFaUoyl6ZkHJ
         AYtBsN288J4HjU2sDH+U4R8bPmEJZKq4CHrFNWPUzeePClNHmosi/Z3cjlZ0o3PEW6Kj
         dByZGO2X6c5xraTyGmVmrABhoRVgw1ns1gQhBw1JonFtYBH93ibcXrBOMzW2OqXwa6p7
         CWvEMC94t3EqkUatFoDptrB/BtiguZ0y4cI4bTqAitWMhqn0kbRcoQy1B1THreD1Wb28
         QRUA==
X-Forwarded-Encrypted: i=1; AJvYcCV4TxIQJSTlhj7HKA6IgAkg5ix1a1oU0FfwS+GVIkdpi4ORyDkUEUIeL/HGS44yZ9y8xEyRUGkmc6OMHcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrz8Q1nBpt+Hfr/f7b0YWvV2jufM6WVR+YfP37qAAkXVzCrwXH
	0gM6OgMXvAsIAM6MNf98HyzekhsRcBUGl6j2I+1Zj9DelGMtZrXXJCQvzTqWlSAcv4Q=
X-Gm-Gg: ASbGncujU3CO2a3JhW0rZd10CZ3jeZ19vxMZg9OCV8O8vzKRgaEpq++IBpj3hyE/t34
	UvPsHmdItimPEW9D+fCYr4NeptyS/FoBoMTj9ZgNQcnWDWygKLZzqiwDP36hspfT6B8fUWdtgPO
	Lc7DZtN5RzW1A4eeIs96QcdoHMci6FvkXu457apLYhJ+ldFO2x9px92d7yqEQ0BZnxuzkdLB5cx
	qTHUYoZp5aBlkcq0y0hd2h4Ssd4f6l2wUBSMYsF7Hc5dXlBWHj1BQXgm7klw/kBwMRrjxw1W216
	bzUJwISpQa2tawPUFdteGNEza+gXcT05u+Rborw2SLakxVGaAWVk7lhfBYZRZ1BUECLPKKTLD7g
	hgXGEEF6jN+zj9wqoJuxIlL2S/ojbkeOAve6g7jn8m5PXxOWskyjhlnZyAiErUtlOswRVyG+N9G
	RWD2ltzfc0VYaFFWzjvCLoTmJBDp882qpXXYyIMpwgN4wnja+IvFe0VWl4
X-Google-Smtp-Source: AGHT+IGoESvGzpUDrJdPJLRLhPWYD3SbdQgNdCWAIIjRLmFYz/jY6rOutROAlH9tr+MSKSD3bFPOYQ==
X-Received: by 2002:a05:6214:2261:b0:87c:2d74:1fef with SMTP id 6a1803df08f44-8801b2227c1mr37575316d6.52.1761828757828;
        Thu, 30 Oct 2025 05:52:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a6befsm115003726d6.4.2025.10.30.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:52:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vES8o-000000058XD-1cvN;
	Thu, 30 Oct 2025 09:52:34 -0300
Date: Thu, 30 Oct 2025 09:52:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <20251030125234.GA1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>

On Thu, Oct 30, 2025 at 10:04:31AM +0000, Lorenzo Stoakes wrote:
> It may also just be sensible to drop the vma_test() since I've named VMA flags
> vma->flags which is kinda neat and not so painful to do:
> 
> 	if (vma_flags_test(&vma->flags, VMA_READ_BIT)) {
> 	}
> 
> Another note - I do hope to drop the _BIT at some point. But it felt egregious
> to do so _now_ since VM_READ, VMA_READ are so close it'd be _super_ easy to
> mistake the two.

Yes, you should have the bit until the non-bit versions are removed
entirely.

> Buuut I'm guessing actually you're thinking more of getting rid of
> vm_flags_word_[and, any, all]() all of which take VM_xxx parameters.

Yes
 
> > few instructions.
> >
> 
> Well I'm not sure, hopefully. Maybe I need to test this and see exactly what the
> it comes up with.
> 
> I mean you could in theory have:
> 
> vma_flags_any(&vma->flags, OR_VMA_FLAGS(VMA_PFNMAP_BIT, VMA_SEALED_BIT))

'any' here means any of the given bits set, yes? So the operation is

(flags & to_test) != 0

Which is bitmap_and, not or. In this case the compiler goes word by
word:

  flags[0] & to_test[0] != 0
  flags[1] & to_test[1] != 0
 
And constant propagation turns it into
  flags[1] & 0 != 0 ----> 0

So the extra word just disappears.

Similarly if you want to do a set bit using or

  flags[0] = flags[0] | to_set[0]
  flags[1] = flags[1] | to_set[1]

And again constant propagation
  flags[1] = flags[1] | 0 ------>  NOP

> I feel like we're going to need the 'special first word' stuff permanently for
> performance reasons.

I think not, look above..

> > Then everything only works with _BIT and we don't have the special
> > first word situation.
> 
> In any case we still need to maintain the word stuff for legacy purposes at
> least to handle the existing vm_flags_*() interfaces until the work is complete.

I think it will be hard to sustain this idea that some operations do
not work on the bits in the second word, it is just not very natural
going forward..

So I'd try to structure things to remove the non-BIT users before
adding multi-word..

Jason

