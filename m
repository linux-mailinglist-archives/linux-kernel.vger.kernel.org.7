Return-Path: <linux-kernel+bounces-886210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 804BBC34FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F14E24A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8730BB8E;
	Wed,  5 Nov 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJf9Lc1U"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8F309F0C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336716; cv=none; b=AMVleQwgk5Uj/CSAZY01FYkBTr9GEEmRmmj7AqF4WZ0Kx5JVNZlS/rr0FL5HM9tR2Vffr9KKkXFSeg/Q83UwQq9k7E4tp2tg4vT3okONuH3L6lfrGR6IfNNCIZnkxy0FidCq4fhzSHH6cYaVtpFMuYzq0iIPC5nE4MLr1HGFMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336716; c=relaxed/simple;
	bh=M825Gm7Yt/bZv6Pny9WU7xR62SQa5Q5WFd49TRZUv3A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FDYlSkbLVUCcXdOv4bSrs54FgbBwffTqC8kXx4C8SzGZJU9A4I/PG2PXbNT+hFlADbbl9Q48qwibwfSYrd7t1NWZH7PnzA+Jb9o98fK5T6VotsF7kxyNF2nlwY4eahd3hPYk3vhYMKCmESMLrKRIqNTVN+WvbitcI/jvgo5Fwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJf9Lc1U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-294fe7c2e69so61862485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336714; x=1762941514; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PiM5gwx7v9fuKjSNGU0XIbMsJHzNcD3t6sxDOvTigVo=;
        b=EJf9Lc1UaqFsoib2IiIrj+l7qufExGMrDWq10HeBl7ztsMNPTkueHB2aqUAqUjiB0I
         ZjCdr444JaW+GTBpkxy4p5ODtAdRC9vR6wkohMX4DPS3oskjf7kCOAfL4rvZOVE62Jg/
         MO+FuPxdLnrmot3GNQdosYJUlgnIw71LIZyXQk2+4BCmzXZLUu6s+kBmW+lfmYm/tsF+
         0ifnSICAtlBOBeBWueMrUyWY9Xk6QLR4hdPKoPEcXmBLrxcsb4/Ub1bQTljB0gOKp3s+
         R+HolmfLWnXLAIv+Eb7IGJpRGqmJW71pApfvIGBocrmnoqw/WXS1mUk7jqS7vjTMvubU
         oyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336714; x=1762941514;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiM5gwx7v9fuKjSNGU0XIbMsJHzNcD3t6sxDOvTigVo=;
        b=N4xLw5qjG/C6v5A9K4BepuW7S3lZU0iB557Ewa2QBeMR8S5apebujZjpZ3DFBQB9Lq
         k9VEq35m66h6aoo4RvEHeleplNosmB+PW7RWuOCf+zvC6CeltyKyB4mnVsF6GjwI9RB2
         aUsJc5UnwJh0lRPuFiycg4eFEReY5SHKKPyLTI8ku1xripNPPEpKFgO9NOO6bevr8CQc
         qUhF/hEy1wcldUrPHlmcavr6GkUJcHcPE7uOI01+2ggggK6c64y+EmeZ1y0lLAXvY6qa
         1x83NqIUe71o1lRzSdziBCbvttTXBUxyftNu6cbikSu5TMVXdqueHwoC5RGPyyimU9pR
         Yl0w==
X-Gm-Message-State: AOJu0YyZDMwTtq+tFXRZeHaqllTpZhCGaChp8d01a74TxotdXEmIW0Dh
	a2rUdcqdZDQJA708K49liutbwgszjTPlfdLBP8m7F4WkJnK2Nlgbh0sm
X-Gm-Gg: ASbGncvPTtfrkT2DbYKE7Qq8w8JwKIQdDseksGoeGGLCM2ZGxPgSFBYiVcYmYLKSlSI
	M7GhKNF4GRTnmgydj3ulExHnDas3UcjJ0vgwhdT58rqOD2DamfyyJWzyP2Kh4/iZ3d+7ueA/FnK
	rc58SVkr+Qj4I/EVRWBPYkEUNcHywL466pFvINwmQLwrQTE4emu4IG4B8mGlmWB94SgoKsOCqd4
	u+02EVzRm3R1gSOydG88Hh/zjqhs1JvzjWVsffI8TW2ccET6k/MwzZS6meYhmky2wxJmwR8pueI
	jcrhy13JyjBVhObZY9+eOgvHgK9Z1QmhYYaTNB31IKz17vmkVWATyUM3osHc7ZqVCbDD2APBr5S
	IPuQHEACj5+IiCnG2+vszf5Pdthzb+r+Sw36ZpQeL1KQcBlbp9hguX6V2RNHSJ6jfaZe+4w==
X-Google-Smtp-Source: AGHT+IHbi+0zqKpbA9V2mHcqMUNAu2olVZcwJU6s62eDD+69tSv+JW/d6KHzoaPAbvo+C4JRz5nOFw==
X-Received: by 2002:a17:903:19ce:b0:246:7a43:3f66 with SMTP id d9443c01a7336-2962adb2b0fmr33595265ad.7.1762336714441;
        Wed, 05 Nov 2025 01:58:34 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972ad1sm55039695ad.19.2025.11.05.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:58:33 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 03/12] powerpc/mm: implement arch_flush_lazy_mmu_mode()
In-Reply-To: <87pl9x41c5.ritesh.list@gmail.com>
Date: Wed, 05 Nov 2025 15:19:35 +0530
Message-ID: <87jz044xn4.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-4-kevin.brodsky@arm.com> <87pl9x41c5.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>
>> Upcoming changes to the lazy_mmu API will cause
>> arch_flush_lazy_mmu_mode() to be called when leaving a nested
>> lazy_mmu section.
>>
>> Move the relevant logic from arch_leave_lazy_mmu_mode() to
>> arch_flush_lazy_mmu_mode() and have the former call the latter.
>>
>> Note: the additional this_cpu_ptr() on the
>> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
>> patch.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  .../powerpc/include/asm/book3s/64/tlbflush-hash.h | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> index 146287d9580f..7704dbe8e88d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>>  	batch->active = 1;
>>  }
>>  
>> +static inline void arch_flush_lazy_mmu_mode(void)
>> +{
>> +	struct ppc64_tlb_batch *batch;
>> +
>> +	batch = this_cpu_ptr(&ppc64_tlb_batch);
>> +
>> +	if (batch->index)
>> +		__flush_tlb_pending(batch);
>> +}
>> +
>
> This looks a bit scary since arch_flush_lazy_mmu_mode() is getting
> called from several of the places in later patches(). 
>
> Although I think arch_flush_lazy_mmu_mode() will only always be called
> in nested lazy mmu case right?
>
> Do you think we can add a VM_BUG_ON(radix_enabled()); in above to make
> sure the above never gets called in radix_enabled() case. 
>
> I am still going over the patch series, but while reviewing this I
> wanted to take your opinion.
>
> Ohh wait.. There is no way of knowing the return value from
> arch_enter_lazy_mmu_mode().. I think you might need a similar check to
> return from arch_flush_lazy_mmu_mode() too, if radix_enabled() is true.
>

Now that I have gone through this series, it seems plaussible that since
lazy mmu mode supports nesting, arch_flush_lazy_mmu_mode() can get
called while the lazy mmu is active due to nesting.. 

That means we should add the radix_enabled() check as I was talking in
above i.e. 

@@ -38,6 +38,9 @@ static inline void arch_flush_lazy_mmu_mode(void)
 {
        struct ppc64_tlb_batch *batch;

+       if (radix_enabled())
+               return;
+
        batch = this_cpu_ptr(&ppc64_tlb_batch);

        if (batch->index)

Correct? Although otherwise also I don't think it should be a problem
because batch->index is only valid during hash, but I still think we can
add above check so that we don't have to call this_cpu_ptr() to check
for batch->index whenever flush is being called.

-ritesh

