Return-Path: <linux-kernel+bounces-674828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4CACF536
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C90170911
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0827E1AC;
	Thu,  5 Jun 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17vFeL+L"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509527D77A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143773; cv=none; b=DuEnoavXsFi9yLZQaBWnkVkIHcIHf2GgwmgNwcN9eDw0yqHi/uOChEc+XoZvvHrMtfekwxBVn8etPz0QsEUeT11XhR2CLlAtXg7sbnP93oelsbZ4cJQFmVvzIs4E/HLRHlwN/FBjwhd+R93aD1gGGBVOrRAryKtdjv1NSmJycSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143773; c=relaxed/simple;
	bh=owWI8WAYAlFsjJvXIyvYSUNXCshP/5FGhM730a1ama8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USl3OY/OxbEaLRwCsjU+Ewmheyyl4ZuDrCntWNA4dM+fg7Rh6DvhuJdXq8oEXObQloF3uwxreLTe5U5pXZu3QyGp8FyPJR+z2FwflOVh8fNPjVysPOB6ZZwf7Dd/HYZWaN5BIJxPp/N7ZE3jCZtdV5/XtWHITitrTE1Iz35xOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17vFeL+L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73e0094706bso1682440b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143771; x=1749748571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=17vFeL+L95dEKx4ll2OCcOVAeOGUSKOFCg+8/AhbXLVH4hueGU05UabngmFYP29zIW
         N3A972Mcic4E80ldCvw+MF1su+fg1yRQSbt9kuz1sqvtqqcRtQ0wm3RN4lGlFc5wr5Do
         pE5IvlDSXJ4bnbQkBuIkXD67zq1DeEz6MithtBhwFvxEXNebh1Ch+HLgnJZ6e4TsCp/c
         gPwpe1ibZsafIKo9DmbuX7hqgPLYOrZ5crRjtFqFnJZjSzVXXLiQN4TYXyESUqDl1R0X
         iRuma978nAFPlw2QgNmW/nYRjyEgzn8PhxcadHEFYMKOUe86HXdciztPiIyAksgdciHH
         Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143771; x=1749748571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=TcfdZGbrAm76FDFsCkey/nSkHNMF5eX3dXiE2Ccj1toW6V2dQlKzWp0c78MGIdIwks
         tSVLUITYBodBoh370vP897jQ0k7HlqVSrqlgkMv83YbPjICGo49dPtLgZgduStb0wwiQ
         6xzB/qANyiHKoRfdFO0HZqEYYdA71wM3Q2rGSY46RiSC0MxCe2cREUZzF6948iC3tQXx
         0AWifz4hiePsJA/+CmNvRKW2Ug1i2s0MgJik6OztBobZ7yLgfDVNUGmc/zctbtbgs9tv
         fPqMLfG9xLIUmau8C6ssmh65IUl33IThbPmxeWGSWtGk1oWTR+augQihQMTCARQL1Kfy
         4arQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfcSHw1YxixvotV9V/J685Ut14wzOe5/nBgM5Ktnsg2mixU1FAavoltnYySk2DAViQSYOJbo42h5pc9wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+69EcwJivHQU0CllJtbpU+dEWPCkQNhRMUMeoKcRGQj9vRA1
	GVQ84WSAsYuIEbw+u3Igamjcp9zJOIwwQRTIz3zR673MV6MviDWjNJEqTPOgwvkhEXtSu/ZqNaz
	hKIQsY5wPAG02BM6NnqQLQZMp6g==
X-Google-Smtp-Source: AGHT+IHsVYh0GgG5BEiO5ED3ww8e04bKedQW6s8IFetr0LVufC4TvNmMIrwHvA/YCfrSoO0Jh0Izl6xHqaQ0nKL6UA==
X-Received: from pfef13.prod.google.com ([2002:a05:6a00:228d:b0:746:301b:10ca])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:21d3:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-74827f304f8mr618930b3a.22.1749143771256;
 Thu, 05 Jun 2025 10:16:11 -0700 (PDT)
Date: Thu, 05 Jun 2025 10:16:09 -0700
In-Reply-To: <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Message-ID: <diqz34cejehy.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
From: Ackerley Tng <ackerleytng@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Miao, Jun" <jun.miao@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "jack@suse.cz" <jack@suse.cz>, 
	"amoorthy@google.com" <amoorthy@google.com>, "maz@kernel.org" <maz@kernel.org>, 
	"keirf@google.com" <keirf@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>, 
	"Du, Fan" <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>, 
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "will@kernel.org" <will@kernel.org>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"Graf, Alexander" <graf@amazon.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, "Xu, Yilun" <yilun.xu@intel.com>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"qperret@google.com" <qperret@google.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "dmatlack@google.com" <dmatlack@google.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, 
	"hch@infradead.org" <hch@infradead.org>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Wed, 2025-05-14 at 16:42 -0700, Ackerley Tng wrote:
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_bound(struct inode *inode,
>> +						 pgoff_t bound, bool start)
>> +{
>> +	size_t nr_pages;
>> +	void *priv;
>> +
>> +	if (!kvm_gmem_has_custom_allocator(inode))
>
> General comment - It's a bit unfortunate how kvm_gmem_has_custom_allocator() is
> checked all over the place across this series. There are only two allocators
> after this, right? So one is implemented with callbacks presumably designed to
> fit other allocators, and one has special case logic in guest_memfd.c.
>
> Did you consider designing struct guestmem_allocator_operations so that it could
> encapsulate the special logic for both the existing and new
> allocators?

I did, yes. I believe it is definitely possible to make standard 4K
pages become another allocator too.

I would love to clean this up. Not sure if that will be a new series
after this one, or part of this one though.

> If it
> didn't work well, could we expect that a next allocator would actually fit
> struct guestmem_allocator_operations?
>

This was definitely designed to support allocators beyond
guestmem_hugetlb, though I won't promise that it will be a perfect fit
for future allocators. This is internal to the kernel and this interface
can be updated for future allocators though.

>> +		return bound;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +
>> +	if (start)
>> +		return round_down(bound, nr_pages);
>> +	else
>> +		return round_up(bound, nr_pages);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_start(struct inode *inode,
>> +						 pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, true);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_end(struct inode *inode,
>> +					       pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, false);
>> +}
>> +

