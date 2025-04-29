Return-Path: <linux-kernel+bounces-625170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69123AA0DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 15:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757921A87F54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7112D1901;
	Tue, 29 Apr 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg+pwG4C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E02C376A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934297; cv=none; b=kZ02viaC7gMSICblbcEeSOSInr5dbYdFewNWnMz6Z1lRYrlFKfXpiCdtfm8Z5lSjJJULKHJ/jcQYiAOFxCYiklUEOXuNNvqR7ddxqkVziYN5vA19rgxEkMJI8KszPW2LD6cBH9GqbgbkDZ6gr4UH618U2gGEHwTz2V3O8b9dAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934297; c=relaxed/simple;
	bh=46uaeAz2RDa279T5DnrMmKZNr1ILVIKnwTZlR8xZFcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etAnHQeQBvpdNzPW6U3svNLACytshPtdwYvsXvGCQpc2RWIlI9z7aENxhhjzIm/fovvPgdANASWOGUxhXPrhE8M8qc6mWDC5NiQaRJPc0lCEFahTeKoqSdwT2uTJ3koTylrJt0aTR/DCEOjyAUrDmc4+q1Q3LIlhFoOxqpep5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg+pwG4C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745934294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8El/MNSWeMGWGhHkl6gHFO/ffF6zovBaM0ZG9eZHFK4=;
	b=Sg+pwG4CY2nNNTcw4XZx/u7JkhBegX57jbCghtOOrYheZxcvlnUf9TaLtBlkwCDNi6Q0Gh
	r7l0gJFaYXDCscTXYPy25qMZ9mMiL3RNkG5GizbW7Xna8JZRTxJwVM8s/9d52z1Lpum/Vr
	Tn4BtXf5heVJVcl7N1fchzt1r3OnZLM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-763j0OXgP6icILX_IR0I-g-1; Tue, 29 Apr 2025 09:44:19 -0400
X-MC-Unique: 763j0OXgP6icILX_IR0I-g-1
X-Mimecast-MFC-AGG-ID: 763j0OXgP6icILX_IR0I-g_1745934259
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c9abdbd3so559489285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 06:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934259; x=1746539059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8El/MNSWeMGWGhHkl6gHFO/ffF6zovBaM0ZG9eZHFK4=;
        b=SwopUrBWiWIuHs20b/c6fdcrj85g0prIR1my/vwJQ5tbAABlM77QFp0sp0yM+sfDXr
         aM81/WB3kOvuEO5xGKqclM0r7Dz31xz16wrwVv5n72L3ewMmdCqBf1Nvh04tGkvJMgik
         jprbC0F5VZgoNE4Atu4kNitvRv4+E9biLdTZSkLg5SHQ7EPXGgQUY/zKQe9HFip1jSc+
         FEfPcYy7G2U+YjmPCsVhO7Bp8lxUvCrdiUaCsGC95RstJSFLwvy7tzO+FDNmssRThh22
         h42VfiLHdh2ofKAZWiqpA7/x8eXIGflAjH2GgOZ1voff8XLEI8o7YHJYRLn8+lSwolzH
         ShLA==
X-Gm-Message-State: AOJu0YwcVvB5XjtCFp4+Y9B+ovrvW0Fo/Vi9ua7JQKYqCj5PmH5t4YFZ
	1lDUZB2HcwfvapcHZzU2czeh2hdn/iJ3J43qFPppXrD/838UT6mCpZhoJkQ+LYZs6YuVZEAw7ZP
	Ja8CmoSfzUueFPPwwiiXBTA/DO/rgX/wKUocs9S7PwlUSsgtlFTVR8LRvZxLi6Q==
X-Gm-Gg: ASbGncuhputVxwyfYKQm+ZGTiEAsCUM5ez3B8tq889sTnbmIlMZirfALvL8d7Rjprel
	apyoFzjUzqgxANiLeMCG+tmqN8fmjB6iM3QKQYR5XAjliRtWlueqsJ91ahjN7uBraVU2cYJ85fg
	O+xV1ufhGJeybpbY/f1WGv60bbGGn2IzswM4FPwQzzKe0H3COPRwY22nHsOWKThmuawljjT/l5G
	eQKbxD7sl4JQainlhwMAkD/G9PpCc0hZ8p0ST9mGZxF0T81cBf8VJe1bl+lF3CAWupi4OBiByNz
	Ftk=
X-Received: by 2002:a05:622a:192a:b0:476:7d74:dd10 with SMTP id d75a77b69052e-488131609e1mr63611011cf.19.1745934259243;
        Tue, 29 Apr 2025 06:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnvb9YE4nJ15XVZdziBUCLpPu73z51k76ZUd4aW/VF9ZsxE0SxmntEXtj/bIpgYaiPj9O/Pg==
X-Received: by 2002:a05:622a:192a:b0:476:7d74:dd10 with SMTP id d75a77b69052e-488131609e1mr63610481cf.19.1745934258824;
        Tue, 29 Apr 2025 06:44:18 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1693378sm80410351cf.64.2025.04.29.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:44:18 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:44:15 -0400
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
Subject: Re: [PATCH v1 02/11] mm: convert track_pfn_insert() to
 pfnmap_sanitize_pgprot()
Message-ID: <aBDXr-Qp4z0tS50P@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-3-david@redhat.com>
 <aAvjJOmvm5GsZ-JN@x1.local>
 <78f88303-6b00-42cf-8977-bf7541fa45a9@redhat.com>
 <aAwh6n058Hh490io@x1.local>
 <75998f7c-93d2-4b98-bb53-8d858b2c108e@redhat.com>
 <aA-q_PrThAw5v1PF@x1.local>
 <57f9480c-2f8c-4be8-864c-406fec917eb1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57f9480c-2f8c-4be8-864c-406fec917eb1@redhat.com>

On Mon, Apr 28, 2025 at 10:37:49PM +0200, David Hildenbrand wrote:
> On 28.04.25 18:21, Peter Xu wrote:
> > On Mon, Apr 28, 2025 at 04:58:46PM +0200, David Hildenbrand wrote:
> > > 
> > > > > What it does on PAT (only implementation so far ...) is looking up the
> > > > > memory type to select the caching mode that can be use.
> > > > > 
> > > > > "sanitize" was IMHO a good fit, because we must make sure that we don't use
> > > > > the wrong caching mode.
> > > > > 
> > > > > update/setup/... don't make that quite clear. Any other suggestions?
> > > > 
> > > > I'm very poor on naming.. :( So far anything seems slightly better than
> > > > sanitize to me, as the word "sanitize" is actually also used in memtype.c
> > > > for other purpose.. see sanitize_phys().
> > > 
> > > Sure, one can sanitize a lot of things. Here it's the cachemode/pgrpot, in
> > > the other functions it's an address.
> > > 
> > > Likely we should just call it pfnmap_X_cachemode()/
> > > 
> > > Set/update don't really fit for X in case pfnmap_X_cachemode() is a NOP.
> > > 
> > > pfnmap_setup_cachemode() ? Hm.
> > 
> > Sounds good here.
> 
> Okay, I'll use that one. If ever something else besides PAT would require
> different semantics, they can bother with finding a better name :)
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > + * @pfn: the start of the pfn range
> > > > > > > + * @size: the size of the pfn range
> > > > > > > + * @prot: the pgprot to sanitize
> > > > > > > + *
> > > > > > > + * Sanitize the given pgprot for a pfn range, for example, adjusting the
> > > > > > > + * cachemode.
> > > > > > > + *
> > > > > > > + * This function cannot fail for a single page, but can fail for multiple
> > > > > > > + * pages.
> > > > > > > + *
> > > > > > > + * Returns 0 on success and -EINVAL on error.
> > > > > > > + */
> > > > > > > +int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
> > > > > > > +		pgprot_t *prot);
> > > > > > >     extern int track_pfn_copy(struct vm_area_struct *dst_vma,
> > > > > > >     		struct vm_area_struct *src_vma, unsigned long *pfn);
> > > > > > >     extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
> > > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > > index fdcf0a6049b9f..b8ae5e1493315 100644
> > > > > > > --- a/mm/huge_memory.c
> > > > > > > +++ b/mm/huge_memory.c
> > > > > > > @@ -1455,7 +1455,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
> > > > > > >     			return VM_FAULT_OOM;
> > > > > > >     	}
> > > > > > > -	track_pfn_insert(vma, &pgprot, pfn);
> > > > > > > +	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
> > > > > > > +		return VM_FAULT_FALLBACK;
> > > > > > 
> > > > > > Would "pgtable" leak if it fails?  If it's PAGE_SIZE, IIUC it won't ever
> > > > > > trigger, though.
> > > > > > 
> > > > > > Maybe we could have a "void pfnmap_sanitize_pgprot_pfn(&pgprot, pfn)" to
> > > > > > replace track_pfn_insert() and never fail?  Dropping vma ref is definitely
> > > > > > a win already in all cases.
> > > > > 
> > > > > It could be a simple wrapper around pfnmap_sanitize_pgprot(), yes. That's
> > > > > certainly helpful for the single-page case.
> > > > > 
> > > > > Regarding never failing here: we should check the whole range. We have to
> > > > > make sure that none of the pages has a memory type / caching mode that is
> > > > > incompatible with what we setup.
> > > > 
> > > > Would it happen in real world?
> > > > > IIUC per-vma registration needs to happen first, which checks for
> > > memtype
> > > > conflicts in the first place, or reserve_pfn_range() could already have
> > > > failed.
> > > > > Here it's the fault path looking up the memtype, so I would expect it is
> > > > guaranteed all pfns under the same vma is following the verified (and same)
> > > > memtype?
> > > 
> > > The whole point of track_pfn_insert() is that it is used when we *don't* use
> > > reserve_pfn_range()->track_pfn_remap(), no?
> > > 
> > > track_pfn_remap() would check the whole range that gets mapped, so
> > > track_pfn_insert() user must similarly check the whole range that gets
> > > mapped.
> > > 
> > > Note that even track_pfn_insert() is already pretty clear on the intended
> > > usage: "called when a _new_ single pfn is established"
> > 
> > We need to define "new" then..  But I agree it's not crystal clear at
> > least.  I think I just wasn't the first to assume it was reserved, see this
> > (especially, the "Expectation" part..):
> > 
> > commit 5180da410db6369d1f95c9014da1c9bc33fb043e
> > Author: Suresh Siddha <suresh.b.siddha@intel.com>
> > Date:   Mon Oct 8 16:28:29 2012 -0700
> > 
> >      x86, pat: separate the pfn attribute tracking for remap_pfn_range and vm_insert_pfn
> >      With PAT enabled, vm_insert_pfn() looks up the existing pfn memory
> >      attribute and uses it.  Expectation is that the driver reserves the
> >      memory attributes for the pfn before calling vm_insert_pfn().
> 
> It's all confusing.
> 
> We do have the following functions relevant in pat code:
> 
> (1) memtype_reserve(): used by ioremap and set_memory_XX
> 
> (2) memtype_reserve_io(): used by iomap
> 
> (3) reserve_pfn_range(): only remap_pfn_range() calls it
> 
> (4) arch_io_reserve_memtype_wc()
> 
> 
> Which one would perform the reservation for, say, vfio?

My understanding is it was done via barmap.  See this stack:

vfio_pci_core_mmap
  pci_iomap
    pci_iomap_range
      ... 
        __ioremap_caller
          memtype_reserve

> 
> 
> I agree that if there would be a guarantee/expectation that all PFNs have
> the same memtype (from previous reservation), it would be sufficient to
> check a single PFN, and we could document that. I just don't easily see
> where that reservation is happening.
> 
> So a pointer to that would be appreciated!

I am not aware of any pointer.. maybe others could chime in.

IMHO, if there's anything uncertain, for this one we could always decouple
this issue from the core issue you're working on, so at least it keeps the
old behavior (which is pure lookup on pfn injections) until a solid issue
occurs?  It avoids the case where we could introduce unnecessary code but
then it's much harder to justify a removal.  What do you think?

Thanks,

-- 
Peter Xu


