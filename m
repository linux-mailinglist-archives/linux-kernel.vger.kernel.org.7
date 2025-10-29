Return-Path: <linux-kernel+bounces-876963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953AC1CE01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A5AF4E32DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641722F12CC;
	Wed, 29 Oct 2025 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hQOdvw+f"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267D32D440
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764553; cv=none; b=Iik0/jzfHYXmqXP7T2VNE9bbbN2lZdoqEbBBDJOGaeoqB0fseooiFR1dDYj1CPRa76BAh/qwUF3tnbzCJCUghwVCWvhDk3N7adWFZHIf2Vu+78CHWjsVc7JI59AmvqVyV7DjXTiIOw/+uUI8fI/9j9sK7jn9qv/VVNzFeaIylfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764553; c=relaxed/simple;
	bh=yO1Opye+qc3JYrzAXa0i9zBPEzqerL6uatQVYdTfnV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3gpJza5k4MTtlWQ0cLmRZzn8olcSAQoUfYJnDxp0eZwSl/95wOCsShFQP3yjxaArSiZ4JYCIHBJu3XlWLj1uQB2K2NUMmBIA10mKMsj5g4J8JILyuQQALn69pdKct1YF3FQElKbrAEQTeZm3gnHhtQzOyi4lcY+0hMY0v/myCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hQOdvw+f; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-89e8a3fa70fso14758285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761764550; x=1762369350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sw72SXv9wDgu6p9YjUITDDH7nA95nOzLTT0dvLDWRw=;
        b=hQOdvw+fj+jtW3r9+9NQ13s4GPkZMNozPxyPEu1z69B9zHbOzVBVBC/HmpoVTc6TFm
         XvluiZHSkJGugnIq3ge2wwgua5RECtQs4Dn7/foiznF5m7TzSO2E3ubURTfduC5u3Bt/
         OXckmY5CXqsXNnsustPUZjAjWCX8BW7g05MwaObJbOr99OPm3uy4hUo7QIRVjgiiBKVt
         P00ybNGq2huXk6cI8WLt3aRtjmyiR79fsLO17PrT3TLOms7vmHG2Ihkr6QMsUjE7aaUQ
         vfqvSn55K+ikFm9NVJhqDZai3a9ifjYRKURJQ4vWLurIFAb7Yi7023pPF6tUWScBt5fj
         2BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764550; x=1762369350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sw72SXv9wDgu6p9YjUITDDH7nA95nOzLTT0dvLDWRw=;
        b=XXlMSl/ECU3Mrjx+VGWB1Vx9nj9/9Fodh174CqWdP3U2HxtxmAvxQJx3H8ugELA6lP
         nwFCzLCatMxs5e9vFJGsUmrmosXADFJk3Zv/vZg99q8BhFWo7F15dSjy6HWMcsS3UT81
         lyqiPEDLdDdHjZFlR9Rq9XtWLmB3TyzV1HI5xLMQMEmWRn4SeiEuiqZvUfhK8WJVbg93
         Aew6MVBjufbqclJaXPjFUCUcKJbTgYXhw5IDw3hS/TKWLueiR9OIbwONReChlVxMJ7m2
         QzjbzRHPRFi79cJyA7xQgl2OKM3ZFMXUZINdbSJBEh0/8QAoUGV6M40LhvgWlN7dIeGm
         HdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFcNofMVmZ2FHG9poHstUMSudDEsI6lcvrlvV1tJEMqgBdyyWgbAGBJlX6tE4dkqNItZagyIZ3P3IJJ9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUywucJ5oAbHQ++5t3O0dY6jfeB5JmEXkXzCXw8u/7pXbpEbND
	h85eWYb3ky4ur1lLUtsuJmE8+x+CexdCLeGS5+loA2u/RCFut36ABUi7WXJPwyN701s=
X-Gm-Gg: ASbGncs9QYadVEPKwDzZUBychWZwYoV1IPnuzQ25VePhMNg9umo0UDQZ9fAog7vjr6B
	m9JGonqWvWhq4hM3O3ssXd+B58zZKi2brCnuGrlqMudI5rU+Q+82XdEuBP5s1imfe74YfZhoK8f
	zKP5/ovsB64+yIWuYMWvSIGWZv+7kFJ9MThWEBQ15KAq20IGyOVi9cI6rLvpNRXuikL2G1DpAHl
	0n7slHe/oXVfwwR5rtZUA/h/wi4x2tGNya/trs/mPsNxZgnuVy8e8agZWut7gwzn957PJXNdROD
	Uz5u0+h/e6A/+p/t4hWUFh3YU3uENWEq3m0LfGtsuB/m+k+6XqtnamL/uJe8718gaKSMDjdU1uQ
	2RCMoBpuLBeliK7iODB8ZQf+9zqxHPl2j+5z7nIrCWPWQi8cowdVkL4gMa7k59oEn3aPdtlxkjW
	tEIfyYjXJ8lh2+1M+aD6r2ZdmXWxm/LCe5N7gz4oxxORuJSg==
X-Google-Smtp-Source: AGHT+IFEZVVWBSeU6miQg9ukzVA2Omdwgy9xE3uJN2mdElXkmiiS2fX8FwhQFoumPSYknIKRu1v6vg==
X-Received: by 2002:a05:620a:2915:b0:8a2:234a:17be with SMTP id af79cd13be357-8aa2c08ed8emr119910685a.7.1761764549800;
        Wed, 29 Oct 2025 12:02:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a6461sm1145536585a.30.2025.10.29.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:02:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEBRE-000000051Qy-2L0s;
	Wed, 29 Oct 2025 16:02:28 -0300
Date: Wed, 29 Oct 2025 16:02:28 -0300
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
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <20251029190228.GS760669@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>

On Wed, Oct 29, 2025 at 05:49:35PM +0000, Lorenzo Stoakes wrote:
> We declare a sparse-bitwise type vma_flag_t which ensures that users can't
> pass around invalid VMA flags by accident and prepares for future work
> towards VMA flags being a bitmap where we want to ensure bit values are
> type safe.

Does sparse attach the type to the enum item? Normal C says the enum
item's type is always 'int' if the value fits in int..

And I'm not sure bitwise rules work quite the way you'd like for this
enum, it was ment for things that are |'d..

I have seen an agressively abuse-resistent technique before, I don't
really recommend it, but FYI:

struct vma_bits {
  u8 VMA_READ_BIT;
  u8 VMA_WRITE_BIT;
  ..
};
#define VMA_BIT(bit_name) BIT(offsetof(struct vma_bits, bit_name))

> Finally, we have to update some rather silly if-deffery found in
> mm/task_mmu.c which would otherwise break.
> 
> Additionally, update the VMA userland testing vma_internal.h header to
> include these changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/proc/task_mmu.c               |   4 +-
>  include/linux/mm.h               | 286 +++++++++++++++++---------
>  tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----

Maybe take the moment to put them in some vma_flags.h and then can
that be included from tools/testing to avoid this copying??

> +/**
> + * vma_flag_t - specifies an individual VMA flag by bit number.
> + *
> + * This value is made type safe by sparse to avoid passing invalid flag values
> + * around.
> + */
> +typedef int __bitwise vma_flag_t;
> +
> +enum {
> +	/* currently active flags */
> +	VMA_READ_BIT = (__force vma_flag_t)0,
> +	VMA_WRITE_BIT = (__force vma_flag_t)1,
> +	VMA_EXEC_BIT = (__force vma_flag_t)2,
> +	VMA_SHARED_BIT = (__force vma_flag_t)3,
> +
> +	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> +	VMA_MAYREAD_BIT = (__force vma_flag_t)4, /* limits for mprotect() etc */
> +	VMA_MAYWRITE_BIT = (__force vma_flag_t)5,
> +	VMA_MAYEXEC_BIT = (__force vma_flag_t)6,
> +	VMA_MAYSHARE_BIT = (__force vma_flag_t)7,
> +
> +	VMA_GROWSDOWN_BIT = (__force vma_flag_t)8, /* general info on the segment */
> +#ifdef CONFIG_MMU
> +	VMA_UFFD_MISSING_BIT = (__force vma_flag_t)9, /* missing pages tracking */
> +#else
> +	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> +	VMA_MAYOVERLAY_BIT = (__force vma_flag_t)9,
> +#endif
> +	/* Page-ranges managed without "struct page", just pure PFN */
> +	VMA_PFNMAP_BIT = (__force vma_flag_t)10,
> +
> +	VMA_MAYBE_GUARD_BIT = (__force vma_flag_t)11,
> +
> +	VMA_UFFD_WP_BIT = (__force vma_flag_t)12, /* wrprotect pages tracking */
> +
> +	VMA_LOCKED_BIT = (__force vma_flag_t)13,
> +	VMA_IO_BIT = (__force vma_flag_t)14, /* Memory mapped I/O or similar */
> +
> +	/* Used by madvise() */
> +	VMA_SEQ_READ_BIT = (__force vma_flag_t)15, /* App will access data sequentially */
> +	VMA_RAND_READ_BIT = (__force vma_flag_t)16, /* App will not benefit from clustered reads */
> +
> +	VMA_DONTCOPY_BIT = (__force vma_flag_t)17, /* Do not copy this vma on fork */
> +	VMA_DONTEXPAND_BIT = (__force vma_flag_t)18, /* Cannot expand with mremap() */
> +	VMA_LOCKONFAULT_BIT = (__force vma_flag_t)19, /* Lock pages covered when faulted in */
> +	VMA_ACCOUNT_BIT = (__force vma_flag_t)20, /* Is a VM accounted object */
> +	VMA_NORESERVE_BIT = (__force vma_flag_t)21, /* should the VM suppress accounting */
> +	VMA_HUGETLB_BIT = (__force vma_flag_t)22, /* Huge TLB Page VM */
> +	VMA_SYNC_BIT = (__force vma_flag_t)23, /* Synchronous page faults */
> +	VMA_ARCH_1_BIT = (__force vma_flag_t)24, /* Architecture-specific flag */
> +	VMA_WIPEONFORK_BIT = (__force vma_flag_t)25, /* Wipe VMA contents in child. */
> +	VMA_DONTDUMP_BIT = (__force vma_flag_t)26, /* Do not include in the core dump */
> +
> +#ifdef CONFIG_MEM_SOFT_DIRTY
> +	VMA_SOFTDIRTY_BIT = (__force vma_flag_t)27, /* Not soft dirty clean area */
> +#endif
> +
> +	VMA_MIXEDMAP_BIT = (__force vma_flag_t)28, /* Can contain struct page and pure PFN pages */
> +	VMA_HUGEPAGE_BIT = (__force vma_flag_t)29, /* MADV_HUGEPAGE marked this vma */
> +	VMA_NOHUGEPAGE_BIT = (__force vma_flag_t)30, /* MADV_NOHUGEPAGE marked this vma */
> +	VMA_MERGEABLE_BIT = (__force vma_flag_t)31, /* KSM may merge identical pages */
> +
> +#ifdef CONFIG_64BIT
> +	/* These bits are reused, we define specific uses below. */
> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> +	VMA_HIGH_ARCH_0_BIT = (__force vma_flag_t)32,
> +	VMA_HIGH_ARCH_1_BIT = (__force vma_flag_t)33,
> +	VMA_HIGH_ARCH_2_BIT = (__force vma_flag_t)34,
> +	VMA_HIGH_ARCH_3_BIT = (__force vma_flag_t)35,
> +	VMA_HIGH_ARCH_4_BIT = (__force vma_flag_t)36,
> +	VMA_HIGH_ARCH_5_BIT = (__force vma_flag_t)37,
> +	VMA_HIGH_ARCH_6_BIT = (__force vma_flag_t)38,
> +#endif
> +
> +	VMA_ALLOW_ANY_UNCACHED_BIT = (__force vma_flag_t)39,
> +	VMA_DROPPABLE_BIT = (__force vma_flag_t)40,
> +
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> +	VMA_UFFD_MINOR_BIT = (__force vma_flag_t)41,
> +#endif
> +
> +	VMA_SEALED_BIT = (__force vma_flag_t)42,
> +#endif /* CONFIG_64BIT */
> +};
> +
> +#define VMA_BIT(bit)	BIT((__force int)bit)

> -/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> -#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
> -#define VM_MAYWRITE	0x00000020
> -#define VM_MAYEXEC	0x00000040
> -#define VM_MAYSHARE	0x00000080
> +#define VM_MAYREAD	VMA_BIT(VMA_MAYREAD_BIT)
> +#define VM_MAYWRITE	VMA_BIT(VMA_MAYWRITE_BIT)
> +#define VM_MAYEXEC	VMA_BIT(VMA_MAYEXEC_BIT)
> +#define VM_MAYSHARE	VMA_BIT(VMA_MAYSHARE_BIT)

I suggest removing some of this duplication..

#define DECLARE_VMA_BIT(name, bitno) \
    NAME ## _BIT = (__force vma_flag_t)bitno,
    NAME = BIT(bitno),

enum {
   DECLARE_VMA_BIT(VMA_READ, 0),
}

Especially since the #defines and enum need to have matching #ifdefs.

It is OK to abuse the enum like the above, C won't get mad and works
better in gdb/clangd.

Later you can have a variation of the macro for your first sytem
word/second system word idea.

Otherwise I think this is a great thing to do, thanks!

Jason

