Return-Path: <linux-kernel+bounces-720064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCAAFB68E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5113420F71
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBA2E172F;
	Mon,  7 Jul 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vykBEbzG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECF2D97A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900117; cv=none; b=ilNG0wjZ0ikZe34qIpgjALPiItdSY3xp7vomTujuCbo9f5inZfge6KJjOIiYZLv4PZroVyg5Yy2p6rOb0BNXi+hREv3oqHKvKZEB/eNScfUGnSFmNwBWKt3Sv9ERFKSyyCuqJO3+tevA4YCL4nV1IW/eWIoO+MAcjiTtAwnB0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900117; c=relaxed/simple;
	bh=B7JxrGmXJuGH2czgl8Oj0PyXhtTmI8a8+b/ZFGmsa4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff8O/h0NVNiWeXnld4MwtJmoP9Tupj/QAaRmht5mRhn+AxP6CsOt1q2YLIH5I5HBoz6HO2VmoHZSmOOsalNZLw50QYIM7oVgNNcfP4vRdGL65JAOUGV6ZSOoKJcz/D2F8bPxD9syb1eVhQWwP1DNkQUA79hushiTZWB3IAVIMhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vykBEbzG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f270513bso653365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751900115; x=1752504915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRktVXf5mIe78Av0JuWhtfTpF59d0PhecR0EGwcUxk0=;
        b=vykBEbzG3aqu3jv+dtxchb5PNU8deluNdq7ncJuZYXEh8UgvlnXjOgApOm3tUUIv1G
         1LyGn1tRgFQMCECQnGMF1mWm/t7rYDUIRmhGCRIiOuaHCOfnW328wJeJPoy8xACTnFCx
         0qT3os0m6Ok7uA/MN3Z3DArosVEkoAt59uVvLO2+BFwDSjvn7d+eCHv96cEf4ZZr8pEu
         kH2h3bFPQ2zQZLja79EoWV85vfajI+ka5hc5Bx1DC4PxAP/nYBWfJ3N9GFbGESU3R/vl
         bjmplIoih9ouWaT9H/dHzaxXY39ZrasBsrHWlIQEPg4n/9pbByDXcxYx42ou/BiQ2JZW
         Iauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900115; x=1752504915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRktVXf5mIe78Av0JuWhtfTpF59d0PhecR0EGwcUxk0=;
        b=pTVIdFWTepULyu0up/vcAHfJm81FH6ga+L7lJ6S7xFNYdW4EU1ySqO7znSlf6UCZ8L
         tlJuxpyXeLvwnuuK2bTqNFOzkmrSNJz2krz94qzJXdU/xJsGp0AL/bjtiez/wuFLcZ6Q
         /BkJV3TLBY7N+qRbrCBzTM/4ZgQodmeWIdKru+3Hnws4vw28w2QSzBhpCCTj0eYBaw8h
         j1h4HFHdRzzXj4hRzB2s72EhvpG5zEHZaHLEtLgQdvH8XlqFoFii89hf+9bt84U+Y8rJ
         RZmC+BZzw+Mp1D/yd9gxPVdUmY1gwu2E9RlS02Fl5Z0XNr/pWctq+a8Y5ITaAxgnVrrP
         WFeg==
X-Forwarded-Encrypted: i=1; AJvYcCWxOSVfO78s02yEztfix53Q/6iD2d7+ptrZpyyE9th0+HUEQY1hnNrbSDNfqSBTZE2tvRlcNGWcJWEjVUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws851sdz9mTvgzC07QCR9hX0TM2+rug9A0cAMYWEmqgkJHb7Kn
	XYmtf8umqHPnFZxW0R7x6GgaUl3DiAHjApHMj0lTjeIEmM6ElbGnjCiiM5dq58pjI9Po7nEt6gr
	9mAXKAlnfEueXKZxBW7OLgZmkIc4b3VOidl18Y4PLjRRXiRoreA7uLbYItWFQPQ==
X-Gm-Gg: ASbGncv7RWzrJibDKtywh61hgtVWh+nB1E82Cv7dVBguPGmgl3Z6nhtVUqowFGP1e/W
	0sRtDceiVWRNPQgNdLXsaWFjIPS3qmxBGUHmaWJHXwUxQ/f2eyH3a2ocMA6MWnwgVIUQv9mzB51
	Rr8d+rd8ZS85iZk9HFqpw6zK7KqDmdcW32IHJn/YkbmJ0MKrElypNC3JwqGkiAAfWYMqUq8eO5a
	iGG
X-Google-Smtp-Source: AGHT+IEJT+lPpiVSgfMXZ2IKzRwmdKmEWyobwf3mOCnOwgAU724C9llo2Jg9w2I/TgbZ9BGhgSoxJ70KADaog3FlAY8=
X-Received: by 2002:a17:902:d492:b0:234:8eeb:d81a with SMTP id
 d9443c01a7336-23c79c421fdmr9042025ad.16.1751900113952; Mon, 07 Jul 2025
 07:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com> <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com> <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com> <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
 <20250703203944.lhpyzu7elgqmplkl@amd.com>
In-Reply-To: <20250703203944.lhpyzu7elgqmplkl@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 7 Jul 2025 07:55:01 -0700
X-Gm-Features: Ac12FXz_kcb6k45NrqHWXfpE1zl6Ylgp3cPdDP8rbyvC0i3k7kTaxp08jYwop3A
Message-ID: <CAGtprH9_zS=QMW9y8krZ5Hq5jTL3Y9v0iVxxUY2+vSe9Mz83Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 1:41=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> > > > > >
> > > > > > Because shared pages are split once any memory is allocated, ha=
ving a
> > > > > > way to INIT_PRIVATE could avoid the split and then merge on
> > > > > > conversion. I feel that is enough value to have this config fla=
g, what
> > > > > > do you think?
> > > > > >
> > > > > > I guess we could also have userspace be careful not to do any a=
llocation
> > > > > > before converting.
> > >
> > > (Re-visiting this with the assumption that we *don't* intend to use m=
map() to
> > > populate memory (in which case you can pretty much ignore my previous
> > > response))
> >
> > I am assuming in-place conversion with huge page backing for the
> > discussion below.
> >
> > Looks like there are three scenarios/usecases we are discussing here:
> > 1) Pre-allocating guest_memfd file offsets
> >    - Userspace can use fallocate to do this for hugepages by keeping
> > the file ranges marked private.
> > 2) Prefaulting guest EPT/NPT entries
> > 3) Populating initial guest payload into guest_memfd memory
> >    - Userspace can mark certain ranges as shared, populate the
> > contents and convert the ranges back to private. So mmap will come in
> > handy here.
> >
> > >
> > > I'm still not sure where the INIT_PRIVATE flag comes into play. For S=
NP,
> > > userspace already defaults to marking everything private pretty close=
 to
> > > guest_memfd creation time, so the potential for allocations to occur
> > > in-between seems small, but worth confirming.
> >
> > Ok, I am not much worried about whether the INIT_PRIVATE flag gets
> > supported or not, but more about the default setting that different
> > CVMs start with. To me, it looks like all CVMs should start as
> > everything private by default and if there is a way to bake that
> > configuration during guest_memfd creation time that would be good to
> > have instead of doing "create and convert" operations and there is a
> > fairly low cost to support this flag.
> >
> > >
> > > But I know in the past there was a desire to ensure TDX/SNP could
> > > support pre-allocating guest_memfd memory (and even pre-faulting via
> > > KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> > > fallocate() handling could still avoid the split if the whole hugepag=
e
> > > is private, though there is a bit more potential for that fallocate()
> > > to happen before userspace does the "manually" shared->private
> > > conversion. I'll double-check on that aspect, but otherwise, is there
> > > still any other need for it?
> >
> > This usecase of being able to preallocate should still work with
> > in-place conversion assuming all ranges are private before
> > pre-population.
>
> Ok, I think I was missing that the merge logic here will then restore it
> to 1GB before the guest starts, so the folio isn't permanently split if
> we do the mmap() and that gives us more flexibility on how we can use
> it.
>
> I was thinking we needed to avoid the split from the start by avoiding
> paths like mmap() which might trigger the split. I was trying to avoid
> any merge->unsplit logic in the THP case (or unsplit in general), in
> which case we'd get permanent splits via the mmap() approach, but for
> 2MB that's probably not a big deal.

After initial payload population, during its runtime guest can cause
different hugepages to get split which can remain split even after
guest converts them back to private. For THP there may not be much
benefit of merging those pages together specially if NPT/EPT entries
can't be promoted back to hugepage mapping and there is no memory
penalty as THP doesn't use HVO.

Wishful thinking on my part: It would be great to figure out a way to
promote these pagetable entries without relying on the guest, if
possible with ABI updates, as I think the host should have some
control over EPT/NPT granularities even for Confidential VMs. Along
the similar lines, it would be great to have "page struct"-less memory
working for Confidential VMs, which should greatly reduce the toil
with merge/split operations and will render the conversions mostly to
be pagetable manipulations.

That being said, memory split and merge seem to be relatively
lightweight for THP (with no memory allocation/freeing) and reusing
the memory files after reboot of the guest VM will require pages to be
merged to start with a clean slate. One possible option is to always
merge as early as possible, second option is to invent a new UAPI to
do it on demand.

For 1G pages, even if we go with 1G -> 2M -> 4K split stages, page
splits result in higher memory usage with HVO around and it becomes
useful to merge them back as early as possible as guest proceeds to
convert subranges of different hugepages over its lifetime. Merging
pages as early as possible also allows reusing of memory files during
the next reboot without having to invent a new UAPI.

Caveats with "merge as early as possible":
- Shared to private conversions will be slower for hugetlb pages.
   * Counter argument: These conversions are already slow as we need
safe refcounts to reach on the ranges getting converted.
- If guests convert a particular range often then extra merge/split
operations will result in overhead.
   * Counter argument: Since conversions are anyways slow, it's
beneficial for guests to avoid such a scenario and keep back and forth
conversions as less frequent as possible.

