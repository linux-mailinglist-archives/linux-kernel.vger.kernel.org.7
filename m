Return-Path: <linux-kernel+bounces-722261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F7AFD719
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1155C188ED8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59A2E6D0D;
	Tue,  8 Jul 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXTYoaHE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F5220F3E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002943; cv=none; b=u++kgpJvk7QcAgbgGJ4MfsPMFOQa6yD2Shk8kryadPSilR/bjcSVW5wcp3cv7KBelmkzzBRzb3m7aMmNzVtMVNKdWexljS5TqmYR8Pp//z95H6OHZmYcEUosDRWeLljs/ugDeO+PJ7IyStUoE/lNFAgD7q9dYxr+xXBVUpKlASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002943; c=relaxed/simple;
	bh=/iJoCZWBT+k8ZJ6PfVSPFNHJUwaMG+UGQ97S5m2HT6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/hAksPVuvc6hrZAJ/rHk8Tp/7wpluYe9zTJ/fI9QcKujyxhXxTHUF2NbAeVGEN+ybqrU3xmSUSN5fxL3cgCbwP+H9YZvYtQCGdEoxsktUeRQ1zRZo4OrMMP1zRonelDFcROPsrpTJgzh8gLPS7sfvKPWtc7uOkJ08sV2IR85NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXTYoaHE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dd9ae5aacso2815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752002941; x=1752607741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTYdn6rBYcWLJ4T1Xl4c7iktQHkSqqtyT5L40Z5QBgA=;
        b=hXTYoaHEHy16NlWEZlwcr7yQErw5dEochhAgeK/6WqGK+PhASpiQs/p3j7608/FoL9
         kslXhRb80AbUieUt0CY1czkkWXMx/+7ez5C4dkbTP3ufcwlbalu5g1o96jfz2cjakekj
         aDb+XaoaKL+PRF5q7eWuGbKXzYidtS5yV4KHJE91pDcB/nK1cMNqpbChJbp0QEwep4fu
         HNE4kyuDv/uCXq+28aGnsSHYeBXTjFToZDOe+SMAbtvm0BevfWC9/PgNlgeW7IuyMA0g
         9YUA2qgbc05ey81JdMJTQTHhNQvajLo62PBJ/k6eiPWPlzXFO5HRYm27m7UCHB+tHjWd
         dNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752002941; x=1752607741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTYdn6rBYcWLJ4T1Xl4c7iktQHkSqqtyT5L40Z5QBgA=;
        b=ecqtBOaN0HLeJgEOYSRUT3e40nWt5ZcazbyABem2zb9OkI2mVZ8AG/MghIgXnjjL0k
         RYsRov7AeCqvhXBWLTf4cDbbKYOBhEOwntrZE/8/tzfTk+TfrrXBLK+lRlVj6EnVCy8+
         uCuZj99A8RaaGYZs95x2sgbQymHRaydKllEWcgoGYogI611bYXW+qXKvouzCxhKUrrCZ
         tLHWR9CR1mzm2vf4o5fTy3VrCTh8q22eUMiH1HgtuISThYdG3idJ9Fb7ju0XNl5jAEVg
         5M6Y2xXHm8H2RLEAKIHkScJCZG/aaw6CdMcIhaXJLKyRKtgOxSjoLN6oESTs9mTkmFY7
         mC7g==
X-Forwarded-Encrypted: i=1; AJvYcCU6sIsEDhtIzOiIyr2v8VQL2GdUSS0REkbKRT2U7RD1XNbIFsz8p4i1VTuk4IFMqVfqyi2MYgvr39Hn480=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2jr0WJQMD18JXRgh5og0B5s+07r2Fy2Zlw348r/NKNJ/mWDk
	Q07mQVm48cmgjVv4E7BDrYhDjE+mNu4/I428d50ElNIqVO70YqSWd3A90kuL8nfKn7CKvkMIBTv
	e3x0swuifMVHOMsac7ST+awRMda36PitdiBC5fR0Z
X-Gm-Gg: ASbGnctnsWdhdq4qajRp0718Tji5Kh74U3Huwn2lqDvicpJjnA8BQA1/mBLrw89fOLg
	KNK3BngvBEiDi8l0c6SKP1dy3cLcJ1t0Ygm9CX5rlj1MQmFC7MLaYB30jB6kEbPoj0RxCLsD+eI
	RlVrZC/40PTkkYYTkzQ1rELTnu3OI3AipQ+Ph1I0RwTiasC3mlZTSHBgjkiSbLDDGXu//ezSGHG
	zgV9C98aL6Z
X-Google-Smtp-Source: AGHT+IF+e0b/viSVE3deh/eLOleNwJVHNQOYU2XyylIkxIAW3YRR/V3A96+f2y39KaRwcjn13Ytsxc06jpGoXpOjB3o=
X-Received: by 2002:a17:903:2f47:b0:236:9402:a610 with SMTP id
 d9443c01a7336-23dda44c1fbmr452675ad.22.1752002940898; Tue, 08 Jul 2025
 12:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com> <aG1dbD2Xnpi_Cqf_@google.com>
In-Reply-To: <aG1dbD2Xnpi_Cqf_@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Jul 2025 12:28:48 -0700
X-Gm-Features: Ac12FXypoF-PMAkZ7mwB0oOR5Y1QBTCoc64ZMQzShq2qX-6W01tjlHIokvek2B8
Message-ID: <CAGtprH-ESrdhCeHkuRtiDoaqxCS9JVKu_CC9fbDRo+k+3jKCcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"tabba@google.com" <tabba@google.com>, "amoorthy@google.com" <amoorthy@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "jack@suse.cz" <jack@suse.cz>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"keirf@google.com" <keirf@google.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, Dave Hansen <dave.hansen@intel.com>, 
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"maz@kernel.org" <maz@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, Fan Du <fan.du@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Zhiquan1 Li <zhiquan1.li@intel.com>, 
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	Erdem Aktas <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hughd@google.com" <hughd@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
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
	"brauner@kernel.org" <brauner@kernel.org>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>, 
	"will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 08, 2025, Rick P Edgecombe wrote:
> > On Tue, 2025-07-08 at 10:16 -0700, Vishal Annapurve wrote:
> > > > Right, I read that. I still don't see why pKVM needs to do normal
> > > > private/shared
> > > > conversion for data provisioning. Vs a dedicated operation/flag to =
make it a
> > > > special case.
> > >
> > > It's dictated by pKVM usecases, memory contents need to be preserved
> > > for every conversion not just for initial payload population.
> >
> > We are weighing pros/cons between:
> >  - Unifying this uABI across all gmemfd VM types
> >  - Userspace for one VM type passing a flag for it's special non-shared=
 use case
> >
> > I don't see how passing a flag or not is dictated by pKVM use case.
>
> Yep.  Baking the behavior of a single usecase into the kernel's ABI is ra=
rely a
> good idea.  Just because pKVM's current usecases always wants contents to=
 be
> preserved doesn't mean that pKVM will never change.
>
> As a general rule, KVM should push policy to userspace whenever possible.
>
> > P.S. This doesn't really impact TDX I think. Except that TDX developmen=
t needs
> > to work in the code without bumping anything. So just wishing to work i=
n code
> > with less conditionals.
> >
> > >
> > > >
> > > > I'm trying to suggest there could be a benefit to making all gmem V=
M types
> > > > behave the same. If conversions are always content preserving for p=
KVM, why
> > > > can't userspace  always use the operation that says preserve conten=
t? Vs
> > > > changing the behavior of the common operations?
> > >
> > > I don't see a benefit of userspace passing a flag that's kind of
> > > default for the VM type (assuming pKVM will use a special VM type).
> >
> > The benefit is that we don't need to have special VM default behavior f=
or
> > gmemfd. Think about if some day (very hypothetical and made up) we want=
 to add a
> > mode for TDX that adds new private data to a running guest (with specia=
l accept
> > on the guest side or something). Then we might want to add a flag to ov=
erride
> > the default destructive behavior. Then maybe pKVM wants to add a "don't
> > preserve" operation and it adds a second flag to not destroy. Now gmemf=
d has
> > lots of VM specific flags. The point of this example is to show how uni=
fied uABI
> > can he helpful.
>
> Yep again. Pivoting on the VM type would be completely inflexible.  If pK=
VM gains
> a usecase that wants to zero memory on conversions, we're hosed.  If SNP =
or TDX
> gains the ability to preserve data on conversions, we're hosed.
>
> The VM type may restrict what is possible, but (a) that should be abstrac=
ted,
> e.g. by defining the allowed flags during guest_memfd creation, and (b) t=
he
> capabilities of the guest_memfd instance need to be communicated to users=
pace.

Ok, I concur with this: It's beneficial to keep a unified ABI that
allows guest_memfd to make runtime decisions without relying on VM
type as far as possible.

Few points that seem important here:
1) Userspace can and should be able to only dictate if memory contents
need to be preserved on shared to private conversion.
   -> For SNP/TDX VMs:
        * Only usecase for preserving contents is initial memory
population, which can be achieved by:
               -  Userspace converting the ranges to shared,
populating the contents, converting them back to private and then
calling SNP/TDX specific existing ABI functions.
        * For runtime conversions, guest_memfd can't ensure memory
contents are preserved during shared to private conversions as the
architectures don't support that behavior.
        * So IMO, this "preserve" flag doesn't make sense for SNP/TDX
VMs, even if we add this flag, today guest_memfd should effectively
mark this unsupported based on the backing architecture support.
2) For pKVM, if userspace wants to specify a "preserve" flag then this
flag can be allowed based on the known capabilities of the backing
architecture.

So this topic is still orthogonal to "zeroing on private to shared conversi=
on".





>
> > > Common operations in guest_memfd will need to either check for the
> > > userspace passed flag or the VM type, so no major change in
> > > guest_memfd implementation for either mechanism.
> >
> > While we discuss ABI, we should allow ourselves to think ahead. So, is =
a gmemfd
> > fd tied to a VM?
>
> Yes.
>
> > I think there is interest in de-coupling it?
>
> No?  Even if we get to a point where multiple distinct VMs can bind to a =
single
> guest_memfd, e.g. for inter-VM shared memory, there will still need to be=
 a sole
> owner of the memory.  AFAICT, fully decoupling guest_memfd from a VM woul=
d add
> non-trivial complexity for zero practical benefit.
>
> > Is the VM type sticky?
> >
> > It seems the more they are separate, the better it will be to not have =
VM-aware
> > behavior living in gmem.
>
> Ya.  A guest_memfd instance may have capabilities/features that are restr=
icted
> and/or defined based on the properties of the owning VM, but we should do=
 our
> best to make guest_memfd itself blissly unaware of the VM type.

