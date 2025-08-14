Return-Path: <linux-kernel+bounces-769605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D4B270E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31D25E5A11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37048279DC8;
	Thu, 14 Aug 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpf2Hsoy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BB25B1FF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207309; cv=none; b=WR8yaZRty4J8tsQPcJRJ/a7nkzoUNtNsS5aURYIdrxhR9/FTdpTP2L7cWKHnFuH6eyEar+r9zTbJLwF02GDo8jbILBHbTq8Os01htqBCHzve1cAOoXX4psy2Ko4F3asDBnb9f+bLbdtWgfogAvvPJHphqVu8qCfjVCGiiyV4ZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207309; c=relaxed/simple;
	bh=2fuIMuEZcev0RDxuwZSy+EEzjg7NkM4Px2bVsPrQqQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wddqs8X8irRtoMCL8k/N2wtlT6YCbrgrfmfA/ApX/EyKTSZNPR/SPkQ2bUSlNLjeoWGPgFov4vV6vrJf+vLjyXqQBQ0kG5XGcM+tMMoqmwnbn+ThCR9IZzdy8ekSqXJhXZXqrIO/RmdxrkIM6TCaoLtdCd6vliV+14WyD5FPcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpf2Hsoy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f42254so29257015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755207307; x=1755812107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oajUHZurgaJBmxaEUN9ClPIgMpw3KkdomNP4S2lFK5E=;
        b=bpf2HsoydWKUiUdDeyV8xbTh2VAbTcJP2Z1FVet5rHKOHyATbYgOVwJHuzW1aEYQ2P
         KvLNxGAVkdfggH5N+tg6AeqJf4vw/C3Oa69/Le10EnyCatYdwJRsgbPwVH0zikfOCMTd
         VA685XDAszjLHrjKpjvjbmt5OOX4sesNCGiFE7pINUpXIvLDGtmFZK2KK2CdQdgTub5Y
         8DLMoMuZ4fEv8jNZB2HzZI0RPBWt2gkmdpIK5veSX7alhArra+NJcKQNJZKK6uH1WC7H
         5JlMmJqf3pkqYRgkXUscBIU1/pWPQzhx3GrRF4keyKbPiHBw0ogd4+AuP9bmw5Xtm8uu
         ywKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755207307; x=1755812107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oajUHZurgaJBmxaEUN9ClPIgMpw3KkdomNP4S2lFK5E=;
        b=wLo+dArQq/LzRFeWxkvuVK37kiG4fqEN9248Go/Vw/rGB/Aqx6H2GN8x07vDybdnFE
         eZaPKZJNBjSebUkzCGW0THzDD+URizFZbBSgKG8C7gf+WGr28UGXeCbLjF5AhdWRiEd2
         wo2yOssNkgLNRfRoopj5RtcZbLaZZ90nS/xReCZe/5iZGFX8iBA0NoL0AlRIhk+acVDc
         YO1iPoAPefuwJBZ565wDa5kK89IRBjZQAnD5UWLodJBLZDUCGihBr+JXg1ootU8VdgGx
         VnglN/5t+nmkxzTYqJ7TAZK3nr7flxc15JI7TUR/3dx3mBKayX8EDT2coByV/eakrJX8
         VXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6d0yymit41taV5Ai3paCelNWtOEDfD5dZnG8lNDq04RTxrGpQ+KYIgrrUaLLx3ndWfAHxpFcZmFKCJS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcf38fVo3gE/DXlsNr2OlcyPH4jl6fJkdPP+RB7xOHW2vpLShM
	BNKVApTF5NMZ2qXI08l+q/P4i8+U5mZTJIwFV/wdgmuOVzI47/nWIDmzcXIOtuyZfUtA6kmfm3m
	pHBLnh+WWPjdT//Uh3ZTsh2cMPg==
X-Google-Smtp-Source: AGHT+IHSCWEZ4WzQFvfM7gmfwowerM9ooYJUxTCTTxPR6qD/XE6Y7uX4MPuDDOyY1Umu3SEnPhVG+BTFarjXCQhhaQ==
X-Received: from pjboi8.prod.google.com ([2002:a17:90b:3a08:b0:321:90c5:fc2b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef0f:b0:240:b075:577f with SMTP id d9443c01a7336-244586c4da1mr76912365ad.37.1755207307282;
 Thu, 14 Aug 2025 14:35:07 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:35:05 -0700
In-Reply-To: <aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com>
Message-ID: <diqz349ta8om.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
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
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
>> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
>> +						 pgoff_t index)
>> +{
>> +	struct maple_tree *mt;
>> +	void *entry;
>> +
>> +	mt = &kvm_gmem_private(inode)->shareability;
>> +	entry = mtree_load(mt, index);
>> +	WARN(!entry,
>> +	     "Shareability should always be defined for all indices in inode.");
>> +
>> +	return xa_to_value(entry);
>> +}
>> +
> Hi Ackerley,
>
> Not sure if it's a known issue. Just want to let you know in case you're unaware.
>

Thanks for informing me, and thanks for the analysis :)

> During a test to repeatedly launching/destroying TDs, I encountered a warning
> from kvm_gmem_shareability_get() (see the attached log at the bottom).
> The reproducing rate is 1 in every 20-100 times of launching TD.
>
> After some analysis, I found that the warning was produced by
> kvm_gmem_shareability_get() when it's called from kvm_gmem_is_private(), which
> is not protected by any locks.
>
> I can get rid of the warning by either fix 1 or fix 2 below.
> (I prefer fix 1 though :))
>
> fix 1:
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e78fbebf4f53..136d46c5b2ab 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -2024,7 +2024,7 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>
>  #ifdef CONFIG_KVM_GMEM_SHARED_MEM
>         if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
> -               mt_init(&private->shareability);
> +               mt_init_flags(&private->shareability, MT_FLAGS_USE_RCU);
>
>                 err = kvm_gmem_shareability_setup(private, size, flags);
>                 if (err)
>

Not sure about the version of the conversion patch series that you're
using, in the version I'm preparing, I'm using
filemap_invalidate_lock_shared() to guard shareability
reads. filemap_invalidate_lock() is held during shareability updates, so
I think this issue should be fixed.

Please let me know if you're still seeing this issue in the next series
(coming soon). Thank you!

>
> fix 2:
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e78fbebf4f53..9a4518104d56 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -171,7 +171,9 @@ static enum shareability kvm_gmem_shareability_get(struct inode *inode,
>         void *entry;
>
>         mt = &kvm_gmem_private(inode)->shareability;
> +       mtree_lock(mt);
>         entry = mtree_load(mt, index);
> +       mtree_unlock(mt);
>         WARN(!entry,
>              "Shareability should always be defined for all indices in inode.");
>
>
> Thanks
> Yan
>
> 
> [...snip...]
> 

