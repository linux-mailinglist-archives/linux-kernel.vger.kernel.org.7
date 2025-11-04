Return-Path: <linux-kernel+bounces-884803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A3C31326
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F33B4F9404
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4D3164D9;
	Tue,  4 Nov 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2NkINY7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46716311979
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262135; cv=none; b=SdonEUW1Xhjb7K1xQ6O7Rw1YxChGRLfIDKiy+iYUe0aOPdmlACwXMXIl7yiaN5+d94o8D7oS4LSHK7QySnSW+PBbpfPlAcS3JEhs5dFv2c1ZFMP+PdAeWnIeLGKl8iuU1r1fehlBRnDPz4kwhgcreJfmeelwI6AiaOU/bPRwlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262135; c=relaxed/simple;
	bh=xP+UBwA0akWhb2m1gUTSCWu4gdeyEopc7/qO6glrb3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbCK0huTUsvzFXOX31/5nrpq7Jaa48i7REHAkWY+6MqRz/oQpO9EaDxpGFVcIh5+kWT7fHZe5VBC9K6jgfMAZxpN6zCS9GST7JPUguo8SKhGG1OBrFe1n9tCGKL+L0u18FEKHvc0WtNM02cN2PvZJeyb0S+gdi7c1PbpoCEGRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2NkINY7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294fc62d7f4so52174755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762262134; x=1762866934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaPdklETLQOqQGht0Ouglwao5ZyyFqDFyIPDptevZDI=;
        b=J2NkINY7Jnbj7bJrpAwfdEFAMMepAbxsJvYu31YqWEAlbN3lRa8RpiKuMxUmOeUXUT
         fmjD4wKJ/UEGImyDpiLJeriZV60J7hRa/xrhP1ip64tXOAlToHJLgzFvab5DFolTJhyx
         LoiXJJK1EZp7KU4SewoeVORNQGrbLiVAA/kwKYj0wBvOq5e07j/Hue2mDJMEGTbW7XdO
         4KHaMSIdfcgdwO4Qtyd/LoFStDKiliJ0mxsnP5LKkCpDNT1otxpl9J3T8Tna2dHdsSQZ
         9Q+DdNjNkjwgJ0kt+AvjeQ+ywwSlObHpouoGHdtrll6BH7DdlCkSt3N5uS0DnsZ3+6IJ
         XXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262134; x=1762866934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaPdklETLQOqQGht0Ouglwao5ZyyFqDFyIPDptevZDI=;
        b=tTKadOlZnSD8Ax2OPbt+NSpHVG7IrUmmB+soeESw2M5ABmqeJPE0LuAzY1iJxxpTfs
         aFGnvdS6HTu0pZSFZC/5/JxAExFzGvQ9dLs7DaknbfFokWyGkHfqYOX95Bk7NUOEhFG6
         GoAdcT7dK5pFL2VgCjT4lbDNGUPIknmImHBoPowLEFv+1/OyAc9RYYmrDjA4pBt8xtkN
         aWSyx5D6g+o0kVaO85nTg0pTvh3ANbOopPu8dIgEaARUD6LzpHcBXs/6W1fYx1E0wl3+
         OZ+0dJ9w+nYGQWJSslvHCRMNw6thf9EBONuj+dIC6sSws8c9D2tdsIkX3n1GIv/upZmt
         VkOg==
X-Forwarded-Encrypted: i=1; AJvYcCWznIQaPTSuuB+9A9M4zZw9tWEloiI70p4uxDpxn/IjY3tqzVcIhopAGoWEvmluFYpuKjSmuCjlek4tr8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiSINbWRP0icgW3yNG660ZSUg1jpi8+4RD0EaKnORhiHt2Sfx
	M6a1u4e5xiDOw3ryyd35/nwv/fZUeSgzfQDulEbIGVHwKWJv+BvkVA6c
X-Gm-Gg: ASbGncuKkrkN1dFMeF3IuNHDHIhWKfaZqs7w5Wj2cjy2PLzGAsmk25YtRwDhJ/1vK0w
	svllx2TzDnGRPq9h3Sm8mK4hAjXEGkNN6MlQJSnWt1k5yZnKSwe4VDDymA1B+zldegHTwrDSlhA
	1D3UxdRHcbb8MOM+mFWx9Zgnl1kX8URm2Bx7Xyrm3GBPXPc63Tw4t1Ka1DixLCiw+w/ekvHnI5a
	IU4kEAch6mVoSEz+kW34NKQlr8CjiM0HKcqbELrX0Z5J7Otxj+ixOTFU6ieX9rXht/32nw3OFN0
	8u7o5ZKmFf77M012ItclCFKqIXdEgU8n/qKM9ZoiPsT6WVcs3gsNU3uqw+ploSoJryRmNElJvTx
	UKu/ltClncyJ239MTYCmvroMjKupz4rx3TZJxf31rnK3vghHaWyBq8MPiecWovUq88PA0KLcInq
	1mVHbEPVI=
X-Google-Smtp-Source: AGHT+IFYJ+Ef86npfeYUTM5p40wZKPAA18fU6R4aES1geEESlAZFL0CbAepJgKE0wSrpDsdnIncgPw==
X-Received: by 2002:a17:902:f68b:b0:274:3db8:e755 with SMTP id d9443c01a7336-2951a4936a6mr213193865ad.30.1762262133305;
        Tue, 04 Nov 2025 05:15:33 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a87sm26839245ad.15.2025.11.04.05.15.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Nov 2025 05:15:32 -0800 (PST)
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
Date: Tue,  4 Nov 2025 21:15:21 +0800
Message-ID: <20251104131522.33079-1-ioworker0@gmail.com>
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

