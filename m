Return-Path: <linux-kernel+bounces-884800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01EC312E9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D07F429D88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79452F3C01;
	Tue,  4 Nov 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMZpGFSg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF902F6191
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262042; cv=none; b=hcIm1Bpz0+Rscq8jabI+Q+xQSgWYdyR9LZgv+sa/4lk6ngHw6lXlzSA/xQGmfICweKEX57tFLJYydt6ZnQqhBBnXQyFJGhrxKmK5MYsWI36D2uytd6hZdldqfbTXytLbcj2zL5Ol2ildRjG4LI3wfwHQawOfhC/6Xv3mLpkaeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262042; c=relaxed/simple;
	bh=4MPgfytn22O76WkDtUM857WsGsfoygug18mvRJwrySU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7IvCl4ZvF+dPpMjftogtL1S3/vVjCevvjIk/pMjcnq0iPgqEM9f5+9nwyC5vPaSWGaCYsjJoWNAa+c/r2P6csywetrpRnf+6OEYun17nmZYsdKopi+qaVtxnp8+/bFwwUnAs/MsZO4vwXtd4CPjqWh+QKfKZTsOAHE5P2QyT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMZpGFSg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so2844758a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762262039; x=1762866839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htheXeHYFH0rHBiPohNUpeYbuuhI1fDU6CfL2d8wKps=;
        b=XMZpGFSgjE6rMMZUCbwU9miNpD7Kir1MHds0znbsJQRcVAZ6Ap2p6DXiO98L+obE/U
         TVyLJbJMHNf505RrxFqpRoDsFH4t4kQojnTJMCzhID+RYLauv8lwRtoyOjxwUbk56vAN
         FzL+eDxu0vD1fJjeGaDn0Z0sgI2gxLm4wcAxqpipUKzaCWxT3W6to67USyaBeKPYB5Ri
         t/s59h7AaHoc89q5Nubrww4FrsJNhof1qOi93+zoFGAtq4sK0H9tgWxoGY5GzBgnaqHS
         KBlAGlEXeY1AZp78PFIXOl8vzeFomGMnFNWleptmcfbJjB8JhDvBo0+8FDtrbooh+7xz
         NsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262039; x=1762866839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htheXeHYFH0rHBiPohNUpeYbuuhI1fDU6CfL2d8wKps=;
        b=pr+vSz7bQd1wutPji1v6vIRorl5X+yoAlnv0zo94WQC/c5Y+b4ofnpyrEEJ+aJMi9N
         QRFDLVl27GZz7nDeY/6clYtftkdSi6t7xCErnxbVLmYyV47TVepRagiMyiAmQ8K4NF2q
         TInXcbAEqC+tI92EJ4Cu2Ye/TmyX45pz6F+ndZ7n2+lleyaebEB3u1Vu8Y7wkjyebEUV
         lQ7GabqC7Y5TqjWyd89X64pY0qKGc3QKob1klGoWQmT4KV5NkQ5wXN2hSLnS33p4pxWP
         4CKHnzJYHrRHUys6BlVX35APHYHJ+oAPgQI+waOAVF+Zaf0843bLf3U1SochM/ZNmb3t
         OWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwANrRMX5PvZlZiPeCQlILys+mzHf9vS9e3ePQJhjwMI4FTf1cCxASFeYFQGEA88eT+I3zZ0iB6D237RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Fq+f4pdBTiFS2ZMUeLgS4oHi5f32MU7NHoWJqqmhAL0cH22q
	ncLGU6Wc/fPuHCKbilUWfpV9SvVp+gH1r7rYxz1/SD2evThID/rLAj7R
X-Gm-Gg: ASbGncuQ93ze3dHAK9BV54sH52yvVSyphldSnV/h6b0RZmuNk3iC2SyGu1A5yfJA4qq
	fhzCrk5ZEmt/a/arY5DYPk3G/XOnIFZLgP97ZmKJcaPViFMUMNtXypUWIVcqrBxM/RoSA0ZgxQZ
	qhR+PPReQu8tfFbCBWKwIA0XsoZmL+w02B60XBZFgWXQVRxEOwEw1Jait9atx4n3rVvxE3V6zdX
	TNBhpN0FPa6poJYsigqKv4XMwDaU2/lfBkgcNu9Ii7tqeewb2epyGSLZC5k5jBxG7FLE6bXwmvZ
	7J8lKgsgOLwk8Rv83PHhBJbGWIaTiN05fGNBh5MO8wujf/zaV3XnfZ4LtD5s2whTLpk5pntOR1e
	L8D8G/qqptdns67AnJS4kiKm8K+XZCRpFcu6YfgwZRZUJCHEMPeUNkIS3TNsidO1Im6/ehVCtl+
	ySzMagNIlPEsHNYctSbw==
X-Google-Smtp-Source: AGHT+IHUCOHDOpY+jomk9+xhanjpsBEdHr6SPe8Xr4SpqUQogzIVi9n8mhwvDLW5yvR6G0BAdhVDBQ==
X-Received: by 2002:a17:90b:3c50:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-3408308ab16mr21572001a91.26.1762262038771;
        Tue, 04 Nov 2025 05:13:58 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415991d381sm4616141a91.2.2025.11.04.05.13.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Nov 2025 05:13:58 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: zhengqi.arch@bytedance.com,
	dev.jain@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	hannes@cmpxchg.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mingo@redhat.com,
	ppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	surenb@google.com,
	tglx@linutronix.de,
	vbabka@suse.cz,
	will@kernel.org,
	x86@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
Date: Tue,  4 Nov 2025 21:13:45 +0800
Message-ID: <20251104131348.32332-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <827b647d-798f-4775-bb31-ef735485c6bb@bytedance.com>
References: <827b647d-798f-4775-bb31-ef735485c6bb@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Tue, 4 Nov 2025 14:33:00 +0800, Qi Zheng wrote:
> 
> 
> On 11/4/25 12:02 PM, Dev Jain wrote:
> > 
> > On 03/11/25 2:37 pm, Qi Zheng wrote:
> >> Hi Dev,
> >>
> >> On 11/3/25 4:43 PM, Dev Jain wrote:
> >>>
> >>> On 03/11/25 12:33 pm, Qi Zheng wrote:
> >>>> Hi Dev,
> >>>>
> >>>> On 11/3/25 2:37 PM, Dev Jain wrote:
> >>>>> The implementation of CONFIG_PT_RECLAIM is completely contained in 
> >>>>> generic
> >>>>> mm code. It depends on the RCU callback which will reclaim the 
> >>>>> pagetables -
> >>>>> there is nothing arch-specific about that. So, enable this config for
> >>>>> all architectures.
> >>>>
> >>>> Thanks for doing this!
> >>>>
> >>>> But unfortunately, not all architectures call tlb_remove_ptdesc() in
> >>>> __pte_free_tlb(). Some architectures directly call pte_free() to
> >>>> free PTE pages (without RCU).
> >>>
> >>> Thanks! This was not obvious to figure out.
> >>>
> >>> Is there an arch bottleneck because of which they do this? I mean to 
> >>> say,
> >>>
> >>> is something stopping us from simply redirecting __pte_free_tlb to 
> >>> tlb_remove_ptdesc
> >>
> >> Some architectures have special handling in __pte_free_tlb(), and cannot
> >> simple redirect __pte_free_tlb() to tlb_remove_ptdesc(), such as m68k,
> >> powerpc, etc.
> >>
> >> For those architectures that call pte_free() in __pte_free_tlb(), it
> >> should be easy to modify them.
> >>
> >> If you're not in a rush, I can take the time to finish the above tasks.
> > 
> > Right then, I'll leave that up to you!
> 
> OK, I will do it ASAP.

Cool! Looking forward to seeing that land ;p

Cheers,
Lance

> 
> > 
> > 
> >>
> >>>
> >>> or pte_free_defer?
> >>>
> >>>
> >>> I am looking to enable this config at least on arm64 by default, I 
> >>> believe it will be legal

Great proposal, Dev! That looks like a very useful feature. Let's make it
happen on arm64 ;)

> >>>
> >>> to do this at least here.
> >>
> >> IIRC, arm64 can directly enable CONFIG_PT_RECLAIM, as it is supported
> >> at the architecture level.
> >>
> >> Thanks,
> >> Qi
> >>
> >>>
> >>>
> >>>>
> >>>> We need to modify these architectures first, otherwise it will
> >>>> lead to UAF. This approach is feasible because Hugh provides similar
> >>>> support in pte_free_defer().
> >>>>
> >>>> Enabling PT_RECLAIM on all architecture has always been on my
> >>>> TODO list, but it's been blocked by other things. :(
> >>>>
> >>>> Thanks,
> >>>> Qi
> >>>>
> >>>>>
> >>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >>>>> ---
> >>>>>   arch/x86/Kconfig | 1 -
> >>>>>   mm/Kconfig       | 5 +----
> >>>>>   mm/pt_reclaim.c  | 2 +-
> >>>>>   3 files changed, 2 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>>>> index fa3b616af03a..5681308a5650 100644
> >>>>> --- a/arch/x86/Kconfig
> >>>>> +++ b/arch/x86/Kconfig
> >>>>> @@ -327,7 +327,6 @@ config X86
> >>>>>       select FUNCTION_ALIGNMENT_4B
> >>>>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> >>>>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> >>>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
> >>>>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
> >>>>>       select SCHED_SMT            if SMP
> >>>>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
> >>>>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>>>> index 0e26f4fc8717..903c37d02555 100644
> >>>>> --- a/mm/Kconfig
> >>>>> +++ b/mm/Kconfig
> >>>>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
> >>>>>         The architecture has hardware support for userspace shadow 
> >>>>> call
> >>>>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> >>>>>   -config ARCH_SUPPORTS_PT_RECLAIM
> >>>>> -    def_bool n
> >>>>> -
> >>>>>   config PT_RECLAIM
> >>>>>       bool "reclaim empty user page table pages"
> >>>>>       default y
> >>>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> >>>>> +    depends on MMU && SMP
> >>>>>       select MMU_GATHER_RCU_TABLE_FREE
> >>>>>       help
> >>>>>         Try to reclaim empty user page table pages in paths other 
> >>>>> than munmap
> >>>>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
> >>>>> index 7e9455a18aae..049e17f08c6a 100644
> >>>>> --- a/mm/pt_reclaim.c
> >>>>> +++ b/mm/pt_reclaim.c
> >>>>> @@ -1,6 +1,6 @@
> >>>>>   // SPDX-License-Identifier: GPL-2.0
> >>>>>   #include <linux/hugetlb.h>
> >>>>> -#include <asm-generic/tlb.h>
> >>>>> +#include <asm/tlb.h>
> >>>>>   #include <asm/pgalloc.h>
> >>>>>     #include "internal.h"
> >>>>
> >>
> 
> 

