Return-Path: <linux-kernel+bounces-724741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39131AFF668
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB001C2461E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1727E1C5;
	Thu, 10 Jul 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt7vjTZB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E53B280
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752111039; cv=none; b=rVMazhdW/24v0MojNSeDeKhEkIfjHDupjgEJoEYd8PHJBqzf5Vct891HcGND9LQV2E4NWGulj1p9PCwjboFtgINioBJzCNO0Bu9sLmlROEQiJo+TCXQa5dm1pNmkkyoDEZP4pSmnICx0Sl9hbcbGoAMF3JuYNp+YEI8UZPXHK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752111039; c=relaxed/simple;
	bh=cwlgChzOqSfKCiRvjUu84m9aH/2achBZS5mS3a+AbGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuhkrWxTagLGnlyZe77Rn/SujxjrTWAILqbPh+4CE6/M/BKvfvSX12lD9psDJ5k83BmwbAsF05Gy7XKJESdf7Lv6TzKzP+/cF62cimYBfpCURAFM0Vk18SJNQmFnenyxy2ae8Nnp1/FgS2dfD+nMRt3IAErB7XhdSenruk2N9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qt7vjTZB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dd9ae5aacso56875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752111037; x=1752715837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is04f/Bkm7gJJ/jV1LRjXX51WkiBnOdhDaBr6UaJT6Q=;
        b=qt7vjTZBOSl2e4TphPTy2W3hTeBjLXqu4dyqx5skISoVZdsGx5rcvZWEfc/9ROOEak
         249pd604w+dTfp4d06nv7e6Wwe0wfNPxdL4bAB8lMd3f6jqOiAP/IEUkFffrEQ5FO+RW
         e15/GHTSb64wK+HW9PHg7ntVM9Jc0eGBaaz1MsBdABW28+TQymyG9g++XDifdXgovA4A
         Ln24pXXh2uOutLtrbTsq+g81rT0Ltz5E+owZBpIeWVID+3HXQbiOklu8abQA3It2y0Uf
         6M0N4yap6vqyV9JCnJhkFTPh2fxitg+su+qlqkKKAKjpSCbjtRTMLZ5UEvy74emZ+fFW
         8J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752111037; x=1752715837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is04f/Bkm7gJJ/jV1LRjXX51WkiBnOdhDaBr6UaJT6Q=;
        b=huyYisv8FCD/1P7zfw7anjClLGCs9QyvYdJCxgvYFFoIZMUrg1SFLlOaky39ZzR0uL
         jmZl8cgDX7iVe+hb8CKTEhDnwxA6RJGjXr3eWaAlBT767FzSsVUB1J62jeRtyt/OETmn
         BNqFc0zKmPP5zzzrjIVfsLiFNLhtsNvZxCTD/C/KcHuIMiPPDaPy/Ly29JFw9JIOVHio
         SbhUSKy1FtBU3uV0H6hGi0l0ZDh9uNtdXAkQ+ro8Fo6fjyqfpygTao0GcS+z02IVYqdH
         WcCInT8d8gO7nL1TC5VWKdS4wriK/0FHXLlJW6hIBVTmZpzhUkpmUeEijfBoAgoZLVMN
         WsiA==
X-Forwarded-Encrypted: i=1; AJvYcCXKBAA9z65PudGJHFiHJ143nNA1FZId5atuE1K/DA8kca0Xmsh2RfICiYIrPn0kJ2yx5Q+gdmzRH17l0OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREx91ciCZAJifGkTl3Uj7Y7vBJLB+gq9371C2PYPlPPleeI97
	unV68TkXWyAsOM/3T86z62dbHpPCw7igU/6Z7lHEDYFei73KApqetDhDHe/BYcMlk+6fc2Zj5jz
	VRQ2XaRvfHgn3Zyn4HTxFKtVw1D8wMuSZZ2/+rvKt
X-Gm-Gg: ASbGnct7vfNFFusk66+4E1jTugSJLWfjRTLPMKbcjviccTm0S1MQfWQxDYE8j6JPgcL
	1/hnOrrUa6x1vBTD8mXiogEkTmwWmV/F3KCkrlDsw7JKDGS60x714rslBkUGdGnWwR86RM77FTB
	rCeBTWrk4qVAEnlAWwcHGp7g4uGmO0fUU/ydMNbdMBIOUlqA/ug0P49dm95NRLcB8qyIfJSmngt
	g==
X-Google-Smtp-Source: AGHT+IHQRxLhKTVLkbXOo+VEMkswy/Fljlw0yFW5tZ5FbAGr3AvPtN+zX/l8wR12tsrz7uBXDg3nz5YzYaXHlJhS9FA=
X-Received: by 2002:a17:903:2350:b0:23c:7be2:59d0 with SMTP id
 d9443c01a7336-23de43709f4mr1099425ad.23.1752111036578; Wed, 09 Jul 2025
 18:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
 <aG1ps4uC4jyr8ED1@google.com> <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
 <aG6D9NqG0r6iKPL0@google.com>
In-Reply-To: <aG6D9NqG0r6iKPL0@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 9 Jul 2025 18:30:23 -0700
X-Gm-Features: Ac12FXw12BTQ2UDgvxWfgcVv3vtRLhBXnJJTOmc7eonn3MPXMwv6b46DcRxjVuk
Message-ID: <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, Wei W Wang <wei.w.wang@intel.com>, 
	Fan Du <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Dave Hansen <dave.hansen@intel.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com" <fvdl@google.com>, 
	"jack@suse.cz" <jack@suse.cz>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "anup@brainfault.org" <anup@brainfault.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "keirf@google.com" <keirf@google.com>, 
	"mic@digikod.net" <mic@digikod.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com" <hughd@google.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, Chao P Peng <chao.p.peng@intel.com>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Alexander Graf <graf@amazon.com>, 
	"nikunj@amd.com" <nikunj@amd.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, Yilun Xu <yilun.xu@intel.com>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Ira Weiny <ira.weiny@intel.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"hch@infradead.org" <hch@infradead.org>, "will@kernel.org" <will@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:00=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Jul 09, 2025, Vishal Annapurve wrote:
> > I think we can simplify the role of guest_memfd in line with discussion=
 [1]:
>
> I genuinely don't understand what you're trying to "simplify".  We need t=
o define
> an ABI that is flexible and robust, but beyond that most of these guideli=
nes boil
> down to "don't write bad code".

My goal for bringing this discussion up is to see if we can better
define the role of guest_memfd and how it interacts with other layers,
as I see some scenarios that can be improved like kvm_gmem_populate[1]
where guest_memfd is trying to fault in pages on behalf of KVM.

[1] https://lore.kernel.org/lkml/20250703062641.3247-1-yan.y.zhao@intel.com=
/

>
> > 1) guest_memfd is a memory provider for userspace, KVM, IOMMU.
>
> No, guest_memfd is a memory provider for KVM guests.  That memory *might*=
 be
> mapped by userspace and/or into IOMMU page tables in order out of functio=
nal
> necessity, but guest_memfd exists solely to serve memory to KVM guests, f=
ull stop.

I look at this as guest_memfd should serve memory to KVM guests and to
other users by following some KVM/Arch related guidelines e.g. for CC
VMs, guest_memfd can handle certain behavior differently.

>
> > 3) KVM should ideally associate the lifetime of backing
> > pagetables/protection tables/RMP tables with the lifetime of the
> > binding of memslots with guest_memfd.
>
> Again, please align your indentation.
>
> >          - Today KVM SNP logic ties RMP table entry lifetimes with how
> >            long the folios are mapped in guest_memfd, which I think sho=
uld be
> >            revisited.
>
> Why?  Memslots are ephemeral per-"struct kvm" mappings.  RMP entries and =
guest_memfd
> inodes are tied to the Virtual Machine, not to the "struct kvm" instance.

IIUC guest_memfd can only be accessed through the window of memslots
and if there are no memslots I don't see the reason for memory still
being associated with "virtual machine". Likely because I am yet to
completely wrap my head around 'guest_memfd inodes are tied to the
Virtual Machine, not to the "struct kvm" instance', I need to spend
more time on this one.

>
> > Some very early thoughts on how guest_memfd could be laid out for the l=
ong term:
> > 1) guest_memfd code ideally should be built-in to the kernel.
>
> Why?  How is this at all relevant?  If we need to bake some parts of gues=
t_memfd
> into the kernel in order to avoid nasty exports and/or ordering dependenc=
ies, then
> we can do so.  But that is 100% an implementation detail and in no way a =
design
> goal.

I agree, this is implementation detail and we need real code to
discuss this better.

