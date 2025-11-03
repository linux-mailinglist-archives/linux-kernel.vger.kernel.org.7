Return-Path: <linux-kernel+bounces-882535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56CC2AAED
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE218903E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003342E62A6;
	Mon,  3 Nov 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CNA9PnZ+"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0C2DCC03
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160852; cv=none; b=jctLq8LuKOOaXQuLZMTDJDQgT2l5Duj3WWm21e712DvcbRGt0sVKDrVpFJgZB7dsGgdzXHgTKMyR9ViN3lw6wviYAioxaES7Psag/xU06D1zv4tz27dsdPtr3/0LoZM1NQvY41hZGx0io9y7taPlI+coUMtg2Br0LFrNqax5yVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160852; c=relaxed/simple;
	bh=NgMq2hjt9shZh+YMVMRQPCILMDoUyo/xGvIdjAyHOL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HH11VLz9U4+J5MqQTZFkSKB7uodLgK92sGm49CWu4q8CkKHxYsuXnWWyYOHUo+CgqZtvsyfmX5Nb38HTowtPrUc/fu6fevAoumz2h9WLjD0RprXizyXsJVYUspwaQHjhYcvUoNhzaQaI5TnDtndcqxGQnPHYxJ0VTrWqhwKpkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CNA9PnZ+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b994baabfcfso364646a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762160850; x=1762765650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IXR4W/3bU885mnocYWtgD1fWaKiafANwqtbBTb2/Bg=;
        b=CNA9PnZ+Ur6y+7FdfPnkhc/Vzlk11XbexSFE6qhqsJ7oVP2xLTJvzhvrcGbHnxDQA2
         jGS27YcG/KNIVtiaYY25D6Jr2BmS189n8hzWUkoN/URk/CL47eVewHaMVXs3zNOrHQr0
         552+Vi1YynFUVlwfs2//MGkqcZed7jlzrQcnhSBoPIMeGaEmmCosu3av1h6h0sJwJKRG
         RFKUsZ1R6CQZ6k/oGUOvfcxNqbxRf0+4HQFzysxC8Jqn21Ya3wLcc3IwzkMKKkdeOMPQ
         ygp+zXqcyhVxIq9KBVGnaNF2O821YbL++3Le+2sxAFvo0KRBq41unq7edzU/VXfMwvBi
         jFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160850; x=1762765650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IXR4W/3bU885mnocYWtgD1fWaKiafANwqtbBTb2/Bg=;
        b=hrfbgRYfAD2Bd77DbcUaN+WM3trWj1OKlorP40yQWguzK0TAgVpB9Rj4Fy/wclsree
         4E8c+u4Fg6AYawO0vGrNLnlEZTBOohuJriv/nR0MSmcuVP7tMPyljzEaJtV5HpH+BJFs
         TGiXex9JJ40amreHELoISFlV/qAouScVMPdRY8dpK2ftg1AlqT6GUvKTXCHEh3fZBlYE
         yl4d4k+H2wYr6wA9KO1F8BcOTU0/vX5nRdJpSqaY8ext54pNJxfnp5lg35jn+wqMSgop
         SkUE47CBFF/zv7jYwRKzpI3XBGgkZW14Ptea18pyNh/syXVUcOjnB5XwpEm4ko7JFMUQ
         jVBw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/sAilL9fATs5pqh7LEDJwU5ygiJYXwEOX+slJoZsOQ7hxjFVZWc4EKY0FYfpMSjYGxQqhfYE6ewsUaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjCvQI5JOWpkgpRmUprfSYPqjjIeNrFbOaKX8gCWU4whz+OVd
	pD5/ncYLxI75XOfTwOWfxTGolUUATS35HyEju7ygSr4HbuYqd5y3h3I4EwP5F/son5U=
X-Gm-Gg: ASbGnct3zwOSZTjPdH/2JHaqT2yMsvLnH7P5+JpcJWNbGMaHMqCQFYHdIXtY0POB/0f
	Z6GVsgSC245q67V2vGKz1Jt9/QIHQHFMZ3jwUA0zI2Lv4+5p0wir4vKnxzIKx+iRMhjJtTIlRjd
	ClPfe4GlhIqTXEKGxmb111O4enAdtpOPzxnvXl5HLtjPli6Q7uk/3rDA92jWEs8XK2Ge/KBobUX
	XRIFK6vROyW6LO74DfLcYdSwkMHaJHWYrkcJqH+fsYpU3F9fAU71FALFKG7VIy3gvjeNioUT68P
	AIbFmqJacc4/Ym0UvVoTiISkfEd4756LOTNfObLPt5jgR2kUTeDxCmk7G51wxb6ZJ2aWWTO0OXn
	t18ozcoooNFbCFIRlB5i43jlEvwfdlrtsZ1QF99Jf1bY76O3MLdiR5caatVNpWX/ZvtClXEwr5t
	NrulLFV61GcG3BAzZA9ziDRJ7Amw4=
X-Google-Smtp-Source: AGHT+IHh54ogHRgLZ5oCFCpwo7pndIkikgTzZE7KUbmx78mSc7CxlZ6V2BvH9MS0x7/fAgICWjZBSQ==
X-Received: by 2002:a17:902:da89:b0:295:5d0b:e119 with SMTP id d9443c01a7336-2955d0c24bbmr89339565ad.26.1762160849656;
        Mon, 03 Nov 2025 01:07:29 -0800 (PST)
Received: from [100.82.90.5] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f24ee93sm4810869a91.9.2025.11.03.01.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:07:29 -0800 (PST)
Message-ID: <9359ce51-5ac7-4312-8ef8-79fa51d014f5@bytedance.com>
Date: Mon, 3 Nov 2025 17:07:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
To: Dev Jain <dev.jain@arm.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, hannes@cmpxchg.org
Cc: ryan.roberts@arm.com, hpa@zytor.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shakeel.butt@linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251103063718.90743-1-dev.jain@arm.com>
 <044e3f9a-3de2-4939-afff-3bb527eb024b@bytedance.com>
 <666e012e-0b13-4def-82de-55ccd5868d36@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <666e012e-0b13-4def-82de-55ccd5868d36@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dev,

On 11/3/25 4:43 PM, Dev Jain wrote:
> 
> On 03/11/25 12:33 pm, Qi Zheng wrote:
>> Hi Dev,
>>
>> On 11/3/25 2:37 PM, Dev Jain wrote:
>>> The implementation of CONFIG_PT_RECLAIM is completely contained in 
>>> generic
>>> mm code. It depends on the RCU callback which will reclaim the 
>>> pagetables -
>>> there is nothing arch-specific about that. So, enable this config for
>>> all architectures.
>>
>> Thanks for doing this!
>>
>> But unfortunately, not all architectures call tlb_remove_ptdesc() in
>> __pte_free_tlb(). Some architectures directly call pte_free() to
>> free PTE pages (without RCU).
> 
> Thanks! This was not obvious to figure out.
> 
> Is there an arch bottleneck because of which they do this? I mean to say,
> 
> is something stopping us from simply redirecting __pte_free_tlb to 
> tlb_remove_ptdesc

Some architectures have special handling in __pte_free_tlb(), and cannot
simple redirect __pte_free_tlb() to tlb_remove_ptdesc(), such as m68k,
powerpc, etc.

For those architectures that call pte_free() in __pte_free_tlb(), it
should be easy to modify them.

If you're not in a rush, I can take the time to finish the above tasks.

> 
> or pte_free_defer?
> 
> 
> I am looking to enable this config at least on arm64 by default, I 
> believe it will be legal
> 
> to do this at least here.

IIRC, arm64 can directly enable CONFIG_PT_RECLAIM, as it is supported
at the architecture level.

Thanks,
Qi

> 
> 
>>
>> We need to modify these architectures first, otherwise it will
>> lead to UAF. This approach is feasible because Hugh provides similar
>> support in pte_free_defer().
>>
>> Enabling PT_RECLAIM on all architecture has always been on my
>> TODO list, but it's been blocked by other things. :(
>>
>> Thanks,
>> Qi
>>
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   arch/x86/Kconfig | 1 -
>>>   mm/Kconfig       | 5 +----
>>>   mm/pt_reclaim.c  | 2 +-
>>>   3 files changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index fa3b616af03a..5681308a5650 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -327,7 +327,6 @@ config X86
>>>       select FUNCTION_ALIGNMENT_4B
>>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>       select SCHED_SMT            if SMP
>>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 0e26f4fc8717..903c37d02555 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>         The architecture has hardware support for userspace shadow call
>>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>   -config ARCH_SUPPORTS_PT_RECLAIM
>>> -    def_bool n
>>> -
>>>   config PT_RECLAIM
>>>       bool "reclaim empty user page table pages"
>>>       default y
>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>> +    depends on MMU && SMP
>>>       select MMU_GATHER_RCU_TABLE_FREE
>>>       help
>>>         Try to reclaim empty user page table pages in paths other 
>>> than munmap
>>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>>> index 7e9455a18aae..049e17f08c6a 100644
>>> --- a/mm/pt_reclaim.c
>>> +++ b/mm/pt_reclaim.c
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0
>>>   #include <linux/hugetlb.h>
>>> -#include <asm-generic/tlb.h>
>>> +#include <asm/tlb.h>
>>>   #include <asm/pgalloc.h>
>>>     #include "internal.h"
>>


