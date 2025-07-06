Return-Path: <linux-kernel+bounces-713471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F664AF5A42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3488445140
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A4E27F16C;
	Wed,  2 Jul 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW5p+89B"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FE27A10A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464465; cv=none; b=t1eeW1Nd/c2DhuxtcfpX7X7FXzWf0tdy4j0j64/uxiFf6FFkU/LopFVEQYPfThZDprmkqL5OU9xB2HsL15gjS9N/F6SJz9EjdCkRBBWUGGx58WA7K0JPoLKcJ3RehXkPS0aUSt9L7gH7ZhJzDMkzCHVGR3a1xj3Ysj72J8e4G2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464465; c=relaxed/simple;
	bh=JYcMfo/FRV0MXHDD6f3JXpyZw1uOm6GKaDPQ9wemazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptC3QwdRcerysrOBIqyyC0sF06wBEt3oK43zlVb7AB0sPT9ompXiSllXx88fb7JIR5qrz1H0YSa8j385KGMwt7nxiaNRCgL+wL2LlXiS6enHQTGngVgDrd0nL3MF8h8vzEtiz1mWercpzoEatS+Ez51E15J0b8vmBoB5IicGHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vW5p+89B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237f18108d2so416355ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751464463; x=1752069263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJKh0bhmf7f4ICuPLjZddH/eg+QtQRmvEhkym3b4VZM=;
        b=vW5p+89BxMEqixi/n3Unclc2DoAPPx7T0yzcZIbQMWq+fgM9MupOABCb3C63QIPNy8
         3NNXf/r5Tzk/fHKVTrklfRXjMsbk9p88aLChECA4u5JmSau48iJk6aaEPTC/XVl/x2V/
         iA4/Ucl3LS95JVVzIjPU1hYBTosJp2D5afZVk0zxsp5+a5VJS51pnL/fo0NqUnvzzrcs
         PCRYewa2ENjR+WvisU6K/OwebjDX8uiv8GeNNmyrmra69KgHM4IAeGMBy6p5/mBZt+qO
         Qy0alvNaZUOIFx9GX2+jcttyIG+aYFKn6XgYJG3ccEreFo7qbr+xbzOcwHcVF01MXiP6
         D+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464463; x=1752069263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJKh0bhmf7f4ICuPLjZddH/eg+QtQRmvEhkym3b4VZM=;
        b=Iwgof32BLteL5e2SmeJEb6aZmXs8QtaABqeqiONK3I9pTj04toNJeXmhH2xDkcJmYM
         Do/fLfugQhnB70hIFLgzIML/Nv9Nyi3D1oWriZDJk0wT/qUrrtBl6UTYrOpgMYuFLSJO
         vayGPvsVFumyg1RGRpWEGQUWFyPpsMNRhlnOQeD3UyQi741MfyvxVyHBfqEvHZdcqN+3
         LEkTzIbCvvF1bRDF1QUHce1lbVktyUdZKVFLOAPKzfr+GeJJd85pxomcJJpHO4Ys0s0Y
         1DykVpy+uMmqTZnhQqDVZFKpdMNcgRqYw86ln+QaE/Yvc2oKJLnV20q3nw1aqBudLxkS
         nxIA==
X-Forwarded-Encrypted: i=1; AJvYcCVCbXZWfuR7CW3Zvuwae9AA8v4Kj1pf83Mwlry5PvzMHSM0mXqgmhdKXqQ5muqAlQRlOYQmnlD2WxUo+LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxbhIGFaHf5bp6tHIuFA+7lujg9lydeOscg5lceaAVMNDHU32
	Ic+X0w+/QGg+csWGyPveod+CsEmPjjTM4HtG322aJBKCJ4UNCU3ESaMshoTM3lrALN9dplai/ln
	JDKNt4l15xSA2gWjotQsLlDtekwOxqe9SbUQkxD1Z
X-Gm-Gg: ASbGncuHJkXTLG7310CyKxoNl/o0wT8XX/701KJvAeJ1pqi+vcbZ3V5xN4Er8Qygcy3
	XJhFED8TbokQXCOvZ2sR8nLFyXuUAdrUl6j0ZfDYT3IxcoyKso/NzrW/B6WfrtDpGCiFnqlMxSD
	GSobJb86otG+NGTlYyMtt4JaKwC2LJl9kcoiybzoWNoMiHI8gJZ5LF+rp/tGv3zBT8O7+YzoDwH
	fIT
X-Google-Smtp-Source: AGHT+IHkpkBgJvS1R3RkrtvsvOEZZf/jKPLYOGmrsQsZdhoqLh6xPOUqe8mNaDmp8JgFozGwZ+2Sa6aXZMCU210+49A=
X-Received: by 2002:a17:903:1ac5:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-23c5ffc0004mr6060785ad.18.1751464462881; Wed, 02 Jul 2025
 06:54:22 -0700 (PDT)
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
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com> <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
In-Reply-To: <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 2 Jul 2025 06:54:10 -0700
X-Gm-Features: Ac12FXydqjoi-wuuZAMsDh9iHHkaJIooZH0B4_yVoZTkA8pqs4QeyD27Ae8Anyg
Message-ID: <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:38=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > On Tue, Jun 24, 2025 at 6:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > >
> > > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > > folios in my RFC.
> > > >
> > > > So what is the expected sequence here? The userspace unmaps a DMA
> > > > page and maps it back right away, all from the userspace? The end
> > > > result will be the exactly same which seems useless. And IOMMU TLB
> >
> >  As Jason described, ideally IOMMU just like KVM, should just:
> > 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > by IOMMU stack
> In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to =
inform
> TDX module about which pages are used by it for DMAs purposes.
> So, if a page is regarded as pinned by TDs for DMA, the TDX module will f=
ail the
> unmap of the pages from S-EPT.
>
> If IOMMU side does not increase refcount, IMHO, some way to indicate that
> certain PFNs are used by TDs for DMA is still required, so guest_memfd ca=
n
> reject the request before attempting the actual unmap.

So it looks like guest_memfd will need an interface with KVM/IOMMU
backends to check if unmapping can succeed. And if unmapping still
fails, there should be a way for KVM/IOMMU backends to kill the TD and
any TDIs bound to that TD.

> Otherwise, the unmap of TD-DMA-pinned pages will fail.
>
> Upon this kind of unmapping failure, it also doesn't help for host to ret=
ry
> unmapping without unpinning from TD.
>

