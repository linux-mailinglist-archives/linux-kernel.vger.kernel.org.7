Return-Path: <linux-kernel+bounces-623398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD96A9F52F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D6A1898A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147327A130;
	Mon, 28 Apr 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyNvYQQe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21C27A10D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856514; cv=none; b=AVZoxXLtw15GSKIhyVwrL8NG6Y6/gtvNqyb8/luPd2bO2n5KW1ouLP5t4P6M+8JxkIVN9iGG8rMecBjAb1YBBzcm2/sQBOmhWB6VucwjJB7Zis0V2Y5Hm8I6w5I20kSmc8MhHX+thUBQZzTiFQs/z2KGu5lwOlB6oQfPGtei3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856514; c=relaxed/simple;
	bh=AX32dtOJ31HAfikwICNlEs+befnC1r7W0gI0ec/LHO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/RWKKOW6NHt0Bp3kfJ/4/8qUBLX/s/CYOx/GgaNVAWYLcoC87Jx8Q1J9HMom7HdIc3qxjYpjNUUWQR7VdceNsYjLvXVZWPR9mPp5pKBCXOM91+0au9M526Y0uv7ZR9WdJVZwWUqT3owINLNWh2kwSJ1jIuaUH68WbJNMsq9f64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyNvYQQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745856510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjlHZlqdBLidaHviO2ndJKZu4KjLnMsljSpmBM9kRPM=;
	b=UyNvYQQeYRoijryXqswUbs92HIwLvDg79JzsNRRZJjzU3iUsR8kVlaCvujbCEUlY29q2Hp
	7COa+v7q2snPB2lof6PNMGbVhO7fA1KCKjaMvSoy0ykoNP4/Uo2JANVtGmxxpLJOseOj8R
	mg+HvgkFVSQmvG3EUzo2vCaXtpfBPBI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-kCuK58goPp6065GQsAFOXA-1; Mon, 28 Apr 2025 12:08:28 -0400
X-MC-Unique: kCuK58goPp6065GQsAFOXA-1
X-Mimecast-MFC-AGG-ID: kCuK58goPp6065GQsAFOXA_1745856508
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c09f73873fso722791985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 09:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856508; x=1746461308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjlHZlqdBLidaHviO2ndJKZu4KjLnMsljSpmBM9kRPM=;
        b=EVrmTTWLvJpgD7NZeSxz6vBD7/WOH884+ejI2CjO6B3tx/VXR1AbdbQShuwCeaDIBc
         tF2quKHzwBNdwUpVnF/kTMTMHVYQjCmzB9j8DSVTj8044mg8SVMBpu7NR4RnRwGT5Ea+
         na68ysxoQxK5uSjmIpUyzChe9B8bnQ8cgpKNX+xZfW7UxbK+tzxlFVgzg7gIyJGmuJ3k
         0Jp988oQ9Mvpo6Q4fulpGJcveQqFEz0yzNQep3NriFmgiNcQ4g8q68bIIb8+tOcL3L20
         IWqiqW5514S9n06N+cg7bmNwRdI4v9N4sKMAowAQmjZVcVPYk40xLq6v0B46rANw6M4B
         BejA==
X-Gm-Message-State: AOJu0YyDV21UiDGaV10jeFNRNO8DOwEYsAH7UePFCtdi0OUS0JDMAhAg
	1fzoNDlJaTVWVMrryERTIoh4m4btY9RIEXt6qUgx/5BwWoiiYzNHJzqw45QLOHBJH4Hv41H1eC6
	5Ynd+qD2It2OjGr1uLFrxr5AzDBjLYzMVZmqN9z5i+wTMFHzujKanTlNK/l1TnQ==
X-Gm-Gg: ASbGncum5JeiY9KGbgm+tZ2UuHojiF9ng4oxVQsGv2pEtfi1iMWhjWOvtr9MTzH+XiS
	OODDZnkOaSzwEYeyGxpT3tgqJJF65iBTGg+xYQMr5U3h7qdYdpV8y5rw3wusZKfO63ju0K7l0tY
	tMLB+qHv5Rxpso2O1C1rmRMaEDcCUbG2y+cexZIliFOZ45RiHi3SwV1HA7rmFB9watPNmE8lH1e
	JW2RqKUNW73Xavk30vx8jf1AWiQG/a4aQBbPTMYrN8piM3paj0mV+7meXS2o2tY4IvHpygAalNR
	Qs8=
X-Received: by 2002:a05:620a:10a1:b0:7c5:5768:409f with SMTP id af79cd13be357-7c9619fa9a7mr1645600285a.57.1745856507669;
        Mon, 28 Apr 2025 09:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW5BlJDkcwxdtW1DAIlXgy/Si+TW6ulb7oYDt7LUfQf0Ngyzow9trm051yins+fPxPd9qHkw==
X-Received: by 2002:a05:620a:10a1:b0:7c5:5768:409f with SMTP id af79cd13be357-7c9619fa9a7mr1645595485a.57.1745856507123;
        Mon, 28 Apr 2025 09:08:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e9f111sm636846285a.93.2025.04.28.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:08:26 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:08:22 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v1 05/11] mm: convert VM_PFNMAP tracking to
 pfnmap_track() + pfnmap_untrack()
Message-ID: <aA-n9hvSX9JLsRM-@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-6-david@redhat.com>
 <aAvvQ1h9bg11hiqI@x1.local>
 <bbadf008-9ffc-4628-9809-2d8cf104a424@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbadf008-9ffc-4628-9809-2d8cf104a424@redhat.com>

On Fri, Apr 25, 2025 at 10:36:55PM +0200, David Hildenbrand wrote:
> On 25.04.25 22:23, Peter Xu wrote:
> > On Fri, Apr 25, 2025 at 10:17:09AM +0200, David Hildenbrand wrote:
> > > Let's use our new interface. In remap_pfn_range(), we'll now decide
> > > whether we have to track (full VMA covered) or only sanitize the pgprot
> > > (partial VMA covered).
> > > 
> > > Remember what we have to untrack by linking it from the VMA. When
> > > duplicating VMAs (e.g., splitting, mremap, fork), we'll handle it similar
> > > to anon VMA names, and use a kref to share the tracking.
> > > 
> > > Once the last VMA un-refs our tracking data, we'll do the untracking,
> > > which simplifies things a lot and should sort our various issues we saw
> > > recently, for example, when partially unmapping/zapping a tracked VMA.
> > > 
> > > This change implies that we'll keep tracking the original PFN range even
> > > after splitting + partially unmapping it: not too bad, because it was
> > > not working reliably before. The only thing that kind-of worked before
> > > was shrinking such a mapping using mremap(): we managed to adjust the
> > > reservation in a hacky way, now we won't adjust the reservation but
> > > leave it around until all involved VMAs are gone.
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   include/linux/mm_inline.h |  2 +
> > >   include/linux/mm_types.h  | 11 ++++++
> > >   kernel/fork.c             | 54 ++++++++++++++++++++++++--
> > >   mm/memory.c               | 81 +++++++++++++++++++++++++++++++--------
> > >   mm/mremap.c               |  4 --
> > >   5 files changed, 128 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index f9157a0c42a5c..89b518ff097e6 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -447,6 +447,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
> > >   #endif  /* CONFIG_ANON_VMA_NAME */
> > > +void pfnmap_track_ctx_release(struct kref *ref);
> > > +
> > >   static inline void init_tlb_flush_pending(struct mm_struct *mm)
> > >   {
> > >   	atomic_set(&mm->tlb_flush_pending, 0);
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 56d07edd01f91..91124761cfda8 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -764,6 +764,14 @@ struct vma_numab_state {
> > >   	int prev_scan_seq;
> > >   };
> > > +#ifdef __HAVE_PFNMAP_TRACKING
> > > +struct pfnmap_track_ctx {
> > > +	struct kref kref;
> > > +	unsigned long pfn;
> > > +	unsigned long size;
> > > +};
> > > +#endif
> > > +
> > >   /*
> > >    * This struct describes a virtual memory area. There is one of these
> > >    * per VM-area/task. A VM area is any part of the process virtual memory
> > > @@ -877,6 +885,9 @@ struct vm_area_struct {
> > >   	struct anon_vma_name *anon_name;
> > >   #endif
> > >   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > +#ifdef __HAVE_PFNMAP_TRACKING
> > > +	struct pfnmap_track_ctx *pfnmap_track_ctx;
> > > +#endif
> > 
> > So this was originally the small concern (or is it small?) that this will
> > grow every vma on x86, am I right?
> 
> Yeah, and last time I looked into this, it would have grown it such that it would
> require a bigger slab. Right now:

Probably due to what config you have.  E.g., when I'm looking mine it's
much bigger and already consuming 256B, but it's because I enabled more
things (userfaultfd, lockdep, etc.).

> 
> Before this change:
> 
> struct vm_area_struct {
> 	union {
> 		struct {
> 			long unsigned int vm_start;      /*     0     8 */
> 			long unsigned int vm_end;        /*     8     8 */
> 		};                                       /*     0    16 */
> 		freeptr_t          vm_freeptr;           /*     0     8 */
> 	};                                               /*     0    16 */
> 	struct mm_struct *         vm_mm;                /*    16     8 */
> 	pgprot_t                   vm_page_prot;         /*    24     8 */
> 	union {
> 		const vm_flags_t   vm_flags;             /*    32     8 */
> 		vm_flags_t         __vm_flags;           /*    32     8 */
> 	};                                               /*    32     8 */
> 	unsigned int               vm_lock_seq;          /*    40     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct list_head           anon_vma_chain;       /*    48    16 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct anon_vma *          anon_vma;             /*    64     8 */
> 	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
> 	long unsigned int          vm_pgoff;             /*    80     8 */
> 	struct file *              vm_file;              /*    88     8 */
> 	void *                     vm_private_data;      /*    96     8 */
> 	atomic_long_t              swap_readahead_info;  /*   104     8 */
> 	struct mempolicy *         vm_policy;            /*   112     8 */
> 	struct vma_numab_state *   numab_state;          /*   120     8 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	refcount_t                 vm_refcnt __attribute__((__aligned__(64))); /*   128     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct {
> 		struct rb_node     rb __attribute__((__aligned__(8))); /*   136    24 */
> 		long unsigned int  rb_subtree_last;      /*   160     8 */
> 	} __attribute__((__aligned__(8))) shared __attribute__((__aligned__(8)));        /*   136    32 */
> 	struct anon_vma_name *     anon_name;            /*   168     8 */
> 	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     0 */
> 
> 	/* size: 192, cachelines: 3, members: 18 */
> 	/* sum members: 168, holes: 2, sum holes: 8 */
> 	/* padding: 16 */
> 	/* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
> } __attribute__((__aligned__(64)));
> 
> After this change:
> 
> struct vm_area_struct {
> 	union {
> 		struct {
> 			long unsigned int vm_start;      /*     0     8 */
> 			long unsigned int vm_end;        /*     8     8 */
> 		};                                       /*     0    16 */
> 		freeptr_t          vm_freeptr;           /*     0     8 */
> 	};                                               /*     0    16 */
> 	struct mm_struct *         vm_mm;                /*    16     8 */
> 	pgprot_t                   vm_page_prot;         /*    24     8 */
> 	union {
> 		const vm_flags_t   vm_flags;             /*    32     8 */
> 		vm_flags_t         __vm_flags;           /*    32     8 */
> 	};                                               /*    32     8 */
> 	unsigned int               vm_lock_seq;          /*    40     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct list_head           anon_vma_chain;       /*    48    16 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct anon_vma *          anon_vma;             /*    64     8 */
> 	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
> 	long unsigned int          vm_pgoff;             /*    80     8 */
> 	struct file *              vm_file;              /*    88     8 */
> 	void *                     vm_private_data;      /*    96     8 */
> 	atomic_long_t              swap_readahead_info;  /*   104     8 */
> 	struct mempolicy *         vm_policy;            /*   112     8 */
> 	struct vma_numab_state *   numab_state;          /*   120     8 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	refcount_t                 vm_refcnt __attribute__((__aligned__(64))); /*   128     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct {
> 		struct rb_node     rb __attribute__((__aligned__(8))); /*   136    24 */
> 		long unsigned int  rb_subtree_last;      /*   160     8 */
> 	} __attribute__((__aligned__(8))) shared __attribute__((__aligned__(8)));        /*   136    32 */
> 	struct anon_vma_name *     anon_name;            /*   168     8 */
> 	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     0 */
> 	struct pfnmap_track_ctx *  pfnmap_track_ctx;     /*   176     8 */
> 
> 	/* size: 192, cachelines: 3, members: 19 */
> 	/* sum members: 176, holes: 2, sum holes: 8 */
> 	/* padding: 8 */
> 	/* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
> } __attribute__((__aligned__(64)));
> 
> Observe that we allocate 192 bytes with or without pfnmap_track_ctx. (IIRC,
> slab sizes are ... 128, 192, 256, 512, ...)

True. I just double checked, vm_area_cachep has SLAB_HWCACHE_ALIGN set, I
think it means it's working like that on x86_64 at least indeed.  So looks
like the new field at least isn't an immediate concern.

Thanks,

-- 
Peter Xu


