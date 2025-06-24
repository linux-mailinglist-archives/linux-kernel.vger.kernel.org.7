Return-Path: <linux-kernel+bounces-700398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E043BAE67F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C409C4E20DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459E2D5C60;
	Tue, 24 Jun 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUrPa04b"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66652D29D1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774254; cv=none; b=l/ExLL4peGoTYtlnvwZhIlysGDcktT4oOHlee0iRvDWU5khkHvyjqaYEGECcxTE2Be5xKS7123pbAZuCIYvfEY1u7zD7No05s2q04a5n9pOLLNakufM9BgP7N594jMS1DpFBroYhZlY8cRMrC+dXSoMKnS824K+dDWDXpjYWzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774254; c=relaxed/simple;
	bh=R6OWWnQ7Ism47qN12eO+TDSgprr7hgpEagXqOhThZVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4qjBxuxGUxlI9IaNMZ+XJZGqoQT4tixtYTpVUAcLHW7eJN6fyhAIdeC7JljCll4AUcI/MBhxjk9Bmcfpx95UkIt6YNFkFaHMjNqVrTu7Xq47ac4y+TL6rdBpC/bWtBP3ULGqbdxCH0pKcBXVdYlEKLwjiIygC50YxAJLEKRttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUrPa04b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso227295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750774252; x=1751379052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPXG9NMXD6nYMUFeG+o56gXIEmWIJJ0n8imu3rUl/a8=;
        b=NUrPa04bJW5wf6OUbZGfVQNZAcNA6z0HsETw61Vv1IyqPlcqpmFJkSFrGR8pLQuN3M
         VnSp5BhE8+ZHHzS4+YPdJLgO9FL4tzrmu6bIHdI3yvzU5VHQmp5y31NOLu/ipzqPAIbk
         tCNyc2ctYL/5a+9fv+eykaUYqV8BCH5yGe3NF8K2iNY5RpBTIWD+p8ZWD4YJCefJyFyB
         Ujd5F4hyUpoi1is+YykEP6tpSsEuSTOyai5PDVMgsf2vFwpStoFbSg8r8+KcryJNY76n
         8h6pRz9vVg4+NDMGpIXqzPDj7iH7dXBQVKHQ2b5lNhHjawaijksvAHUd+1YcoI2hToXh
         E1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774252; x=1751379052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPXG9NMXD6nYMUFeG+o56gXIEmWIJJ0n8imu3rUl/a8=;
        b=urB1k8V+QWozDooE484rciDAI8zuP7GMclMMPfYVqO15YIiFU+/FZgooSz/6CBE/OW
         GtdG95NvEOk1oj63zaAhOVaI3vnQkI1eVS0QUX/QEgzq2R0MqKmsWkEl9zNVpz8E3Cho
         GVIcWLnm91QVT5yIACEVouIUaR038vHu55IZKlrlOvp/aL7flTEdDjvt7lzwufrC8bgG
         TqdzPhwpy66h9Ib6m18uxZz16k35k2x7riT442xfekMa/p/CDuGajl2lICtQHYhfPAEy
         uSzwDUGk13qWLVZb1jqPxT60PZUnrNr8kfxGT5ZiUiQmusTfkz+EdCDlvdYy2KLdbCkY
         KzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjYX7YRg85R9ksv5Pv6EkInO1tfopZzXJx6LVmXlJmbOxDtkplbdusijSLhvHO/lGpel+tD23xqRTD+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiD8bVfKcvlWT4FwqDOk9laoJPStRKqy5V6lGZwz05UASq1qT
	S2EnDVwr7sjsDSIh9Wg2Uj+ij7rk1qBERD2bYuCbtuatRhTcd6WvZFE5msEIz0V3Zw538aki2JT
	qpKwQml+3bJiS21xa2VMcs9ScolKHbcvPUmgLUQGu
X-Gm-Gg: ASbGncvkq+yKZoI/TxgEAQWqNmFGBXRX0/1FvmNMx77Rd3CQByRT5QmadT2BhmZHfqq
	+LUfiUjA6qUudseJOx4q7zv9QeNCxS0VNGGb12m/Bf3TX3KPEPbawGzLbs019kt+/o3qckGNgP8
	kogXeh6R/vhKlY0t8UyYgF5bnlzSrjgx2ZwGRUlaMgt4Vw5iHRHfjTX3LPnAXjcR+L+bu/IEiYW
	PM+
X-Google-Smtp-Source: AGHT+IHm+0I51ZMCSpB9nsIXuoBv9SIjg9zSCmS8/Wkboc9UHu1UJHMZwYpWKTst/fkr9jbiULJlSRshQWeZUERJRQM=
X-Received: by 2002:a17:902:e80c:b0:234:afcf:d9e2 with SMTP id
 d9443c01a7336-23803f4d9a2mr2639155ad.17.1750774250932; Tue, 24 Jun 2025
 07:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com> <20250624130811.GB72557@ziepe.ca>
In-Reply-To: <20250624130811.GB72557@ziepe.ca>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 24 Jun 2025 07:10:38 -0700
X-Gm-Features: AX0GCFsRD1vv1pnJnJAHQ3_lVm2iqeW9vp-TueZFlNIyuARuSWfPMw0I71gJhzE
Message-ID: <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
>
> > Now, I am rebasing my RFC on top of this patchset and it fails in
> > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > folios in my RFC.
> >
> > So what is the expected sequence here? The userspace unmaps a DMA
> > page and maps it back right away, all from the userspace? The end
> > result will be the exactly same which seems useless. And IOMMU TLB

 As Jason described, ideally IOMMU just like KVM, should just:
1) Directly rely on guest_memfd for pinning -> no page refcounts taken
by IOMMU stack
2) Directly query pfns from guest_memfd for both shared/private ranges
3) Implement an invalidation callback that guest_memfd can invoke on
conversions.

Current flow:
Private to Shared conversion via kvm_gmem_convert_range() -
    1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
on each bound memslot overlapping with the range
         -> KVM has the concept of invalidation_begin() and end(),
which effectively ensures that between these function calls, no new
EPT/NPT entries can be added for the range.
     2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
actually unmaps the KVM SEPT/NPT entries.
     3) guest_memfd invokes kvm_gmem_execute_work() which updates the
shareability and then splits the folios if needed

Shared to private conversion via kvm_gmem_convert_range() -
    1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
on each bound memslot overlapping with the range
     2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
actually unmaps the host mappings which will unmap the KVM non-seucure
EPT/NPT entries.
     3) guest_memfd invokes kvm_gmem_execute_work() which updates the
shareability and then merges the folios if needed.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

For IOMMU, could something like below work?

* A new UAPI to bind IOMMU FDs with guest_memfd ranges
* VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
guest_memfd ranges using kvm_gmem_get_pfn()
    -> kvm invokes kvm_gmem_is_private() to check for the range
shareability, IOMMU could use the same or we could add an API in gmem
that takes in access type and checks the shareability before returning
the pfn.
* IOMMU stack exposes an invalidation callback that can be invoked by
guest_memfd.

Private to Shared conversion via kvm_gmem_convert_range() -
    1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
on each bound memslot overlapping with the range
     2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
actually unmaps the KVM SEPT/NPT entries.
           -> guest_memfd invokes IOMMU invalidation callback to zap
the secure IOMMU entries.
     3) guest_memfd invokes kvm_gmem_execute_work() which updates the
shareability and then splits the folios if needed
     4) Userspace invokes IOMMU map operation to map the ranges in
non-secure IOMMU.

Shared to private conversion via kvm_gmem_convert_range() -
    1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
on each bound memslot overlapping with the range
     2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
actually unmaps the host mappings which will unmap the KVM non-seucure
EPT/NPT entries.
         -> guest_memfd invokes IOMMU invalidation callback to zap the
non-secure IOMMU entries.
     3) guest_memfd invokes kvm_gmem_execute_work() which updates the
shareability and then merges the folios if needed.
     4) Userspace invokes IOMMU map operation to map the ranges in secure I=
OMMU.

There should be a way to block external IOMMU pagetable updates while
guest_memfd is performing conversion e.g. something like
kvm_invalidate_begin()/end().

> > is going to be flushed on a page conversion anyway (the RMPUPDATE
> > instruction does that). All this is about AMD's x86 though.
>
> The iommu should not be using the VMA to manage the mapping. It should

+1.

> be directly linked to the guestmemfd in some way that does not disturb
> its operations. I imagine there would be some kind of invalidation
> callback directly to the iommu.
>
> Presumably that invalidation call back can include a reason for the
> invalidation (addr change, shared/private conversion, etc)
>
> I'm not sure how we will figure out which case is which but guestmemfd
> should allow the iommu to plug in either invalidation scheme..
>
> Probably invalidation should be a global to the FD thing, I imagine
> that once invalidation is established the iommu will not be
> incrementing page refcounts.

+1.

>
> Jason

