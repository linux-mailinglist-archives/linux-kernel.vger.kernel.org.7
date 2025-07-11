Return-Path: <linux-kernel+bounces-728300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7DB02648
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D4BA45D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12761C3C11;
	Fri, 11 Jul 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaG9O/0x"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DB1DE3CB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268701; cv=none; b=p3vHKA95ORMKc6321J6uhRJegqlHK8z/elVKTXV6uW3oAI7jFEjQEqieNqQf5qEOzF3i9xAEq3ojnMOyFSqOtrZoFp58QwIEP2I2QXcxKoacrhm1ZiYGRkf0Vs1ZEQQkK7MEoaqthBnKL7egsXbu/yf+h8wsXqbL0DnpbeHnPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268701; c=relaxed/simple;
	bh=SGhjK1vwowy94cSr7JLE0YT85C7WHx55zR/YCHpLgNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMgwh6lTuVIn+jc/zd1DmXPkkcoOFC59ychU18GrsYh5LRyQ8NmMS/URICCXwNXoqfL3PPns+lqCfjazHCuFSP2QoQIuMVNYxLZaUJ/ViEW3FlrwCabqQgWt/deakzN6WYTm8RGLKRUnfDsDz1syNMeaNBy5bh6dZmksTXKBvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaG9O/0x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dd9ae5aacso49175ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752268698; x=1752873498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srgjlONkaPIBXRcKZsQrDQafSdxOtuoef7L+z35YDgg=;
        b=qaG9O/0x1hG6hdLbIQL3uG3IXDlpRhaXiP42rnhlgLeBDmQ8NtvAK+8gS/YaDBtwH3
         5jiRNgu8MqPebSMO08rjxDY0K/uqs9xUJAfo6Y2ciIuh13xMVmHSQw9dHuzflrDVf/ws
         A7ZKf7muMp29zWKX/dLUQW4dj2nzutNA7wS3Jv+EVb5926ylRthK7szYRCyATVQRLk1m
         45sSSgMF69/zhm9VSkfb5Kb/8SmaL51+nSlhVHD5BSWQjQATONbK5ccD+chUMSKLIyvk
         yNeKvdjyQ42Hs1AOdfh0G1UeK/QMwT6w2K3kE2PRe29JJPsxRHB3meQjGTIaOTCKzwSd
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752268698; x=1752873498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srgjlONkaPIBXRcKZsQrDQafSdxOtuoef7L+z35YDgg=;
        b=wKNe4pEegoGxj40X1EahxWxzFniMnSwtvghyPvDPPTL+Hndnoz1MaMI+DP0/qhU3zc
         56qKZiNVFVfWJHIjXQeHRQiycCqzWYsdKqhIAIqCsdcJvy5O+HBsOZkwEczFv4LdfDXt
         djdvvzSLTRF18WgbwSmH0zCsNNvqOsTdBzFIR2lIX9yVG/2OB2/X9oJpPU2gGo9HV9/t
         mrb7jr9aGGD5RswckJc/kcdAbSWnPuTEq8kIbfiluUoq5jeiF88GELhU4rIVLC95bhjN
         WMjszLsEXFZo6wkST2T9sj/Vn6QicJji1gSLQdjj5X0iDyWmcqXdbS8M+BPCE9gcpTfb
         2c7A==
X-Forwarded-Encrypted: i=1; AJvYcCWB48a57apvP9+e6S0SCNaras5G/P6epipJN4VCJdMbtYMaTs11idxQRf6TrkBvGw2Fx1teCmV3ncskFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZAxxqfykGnOIRJ5fXsCO6ypwqs8rEsSe2kulib8uDHJi75Zc
	CRJUl/ivV1oXEQl34OhSJxfJdDP86sQaBnErss4KmX+Z5XMg/h8s9yfugUkIEAraFUMrkbuqhDA
	tdm/NRLZYyUYTy4XyLHOwY8EYLsTr63D4gNhLSwOU
X-Gm-Gg: ASbGncvgT1S8ijc1SKr99ZUvvclIgRc0A3QuaDz+7HfCbeRDwEnvXjqR6vVI75i4Mxp
	Mw9eABwyGBlKmuMD2BEWpibkR4jD91C8pB6na+vskpsKHfLYkBxh+asVZTHHdMWvztuTD7fmekt
	YQukeUR2hYMps8W7QRYfduEtb9WbEc+v4vyC2zHIdbducbwRidqSKS1fKmB/wKCWlhM/URJSkUT
	sRvqmlzu/iKQcB5A8Mxz3Y1HCFJ9Wr7UAUVDQ==
X-Google-Smtp-Source: AGHT+IFn4YhrR2NMOpP0RcMBzjdz+i5J7fxD5D9l1We/eALKlDGnl4JwHOuZ1oclx2rFjnO5xzhl7yjgLb4uY8La0W4=
X-Received: by 2002:a17:902:da90:b0:234:9fd6:9796 with SMTP id
 d9443c01a7336-23df7b4371amr129275ad.19.1752268697429; Fri, 11 Jul 2025
 14:18:17 -0700 (PDT)
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
 <aG6D9NqG0r6iKPL0@google.com> <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
In-Reply-To: <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 11 Jul 2025 14:18:03 -0700
X-Gm-Features: Ac12FXxF9xOtwyt8UF9zfQ7KKAvsu6qF_2ngIDNtG1Fq0HXYA7tXCjkLx87XlaM
Message-ID: <CAGtprH9NbCPSwZrQAUzFw=4rZPA60QBM2G8opYo9CZxRiYihzg@mail.gmail.com>
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

On Wed, Jul 9, 2025 at 6:30=E2=80=AFPM Vishal Annapurve <vannapurve@google.=
com> wrote:
> > > 3) KVM should ideally associate the lifetime of backing
> > > pagetables/protection tables/RMP tables with the lifetime of the
> > > binding of memslots with guest_memfd.
> >
> > Again, please align your indentation.
> >
> > >          - Today KVM SNP logic ties RMP table entry lifetimes with ho=
w
> > >            long the folios are mapped in guest_memfd, which I think s=
hould be
> > >            revisited.
> >
> > Why?  Memslots are ephemeral per-"struct kvm" mappings.  RMP entries an=
d guest_memfd
> > inodes are tied to the Virtual Machine, not to the "struct kvm" instanc=
e.
>
> IIUC guest_memfd can only be accessed through the window of memslots
> and if there are no memslots I don't see the reason for memory still
> being associated with "virtual machine". Likely because I am yet to
> completely wrap my head around 'guest_memfd inodes are tied to the
> Virtual Machine, not to the "struct kvm" instance', I need to spend
> more time on this one.
>

I see the benefits of tying inodes to the virtual machine and
different guest_memfd files to different KVM instances. This allows us
to exercise intra-host migration usecases for TDX/SNP. But I think
this model doesn't allow us to reuse guest_memfd files for SNP VMs
during reboot.

Reboot scenario assuming reuse of existing guest_memfd inode for the
next instance:
1) Create a VM
2) Create guest_memfd files that pin KVM instance
3) Create memslots
4) Start the VM
5) For reboot/shutdown, Execute VM specific Termination (e.g.
KVM_TDX_TERMINATE_VM)
6) if allowed, delete the memslots
7) Create a new VM instance
8) Link the existing guest_memfd files to the new VM -> which creates
new files for the same inode.
9) Close the existing guest_memfd files and the existing VM
10) Jump to step 3

The difference between SNP and TDX is that TDX memory ownership is
limited to the duration the pages are mapped in the second stage
secure EPT tables, whereas SNP/RMP memory ownership lasts beyond
memslots and effectively remains till folios are punched out from
guest_memfd filemap. IIUC CCA might follow the suite of SNP in this
regard with the pfns populated in GPT entries.

I don't have a sense of how critical this problem could be, but this
would mean for every reboot all large memory allocations will have to
let go and need to be reallocated. For 1G support, we will be freeing
guest_memfd pages using a background thread which may add some delays
in being able to free up the memory in time.

Instead if we did this:
1) Support creating guest_memfd files for a certain VM type that
allows KVM to dictate the behavior of the guest_memfd.
2) Tie lifetime of KVM SNP/TDX memory ownership with guest_memfd and
memslot bindings
    - Each binding will increase a refcount on both guest_memfd file
and KVM, so both can't go away while the binding exists.
3) For SNP/CCA, pfns are invalidated from RMP/GPT tables during unbind
operations while for TDX, KVM will invalidate secure EPT entries.

This can allow us to decouple memory lifecycle from VM lifecycle and
match the behavior with non-confidential VMs where memory can outlast
VMs. Though this approach will mean change in intrahost migration
implementation as we don't need to differentiate guest_memfd files and
inodes.

That being said, I might be missing something here and I don't have
any data to back the criticality of this usecase for SNP and possibly
CCA VMs.

