Return-Path: <linux-kernel+bounces-891274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3547C424E5
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B6D3AF94B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1B26CE2D;
	Sat,  8 Nov 2025 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLxYjy29"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC010957
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569220; cv=none; b=p9OPgY5xfCT9Mg/n0KpylrTlTGSDpJRS0yNYF/l9jUinbXEqTHCq5aaK7zIHdbRqeei+2rBL18ehyRnlgo4g2UfE1b4PWhoW6SHyHe83XRj57t3iGFvvJtrxjR5L+FCXFH0ghrkkZIRc6HIsuYL09AkQvJS8ryHd2pilZwtD9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569220; c=relaxed/simple;
	bh=Nhs+F1/Ux3/GUaROEHf188icqClLbb94b/l3GRvYQMo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lIP90l7Na8Y2GIsABwG2xGDh0LZFt0Fjhe6NCVfaoCLwk9uVpRgIg2KFebE6I5abPo+gPd7ulMV5uSO8FSvrWyTlNmHmKN4YqFeC3U9ARWXouQ8UptlOLesDyNQya56PKSEQhoWt3vNzU6KmqbrYiSf3woCrYenByiIz89ptKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLxYjy29; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7810289cd4bso1349813b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569218; x=1763174018; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bKq5Kbap+TGIzkU08hwTVasn8Atv2TAiFfbpOuCLu4=;
        b=jLxYjy29ijrB6Qeejutw9pWLNQ0sAShg4X+P9fdCcPoWSNvKSQyt9ba1e/tJKryNJy
         59wVDD7SMeVNgpdDpI7Ve5L3yj3Kjt1SmoTLMziNfLw/0i2UtmCUBukJ8U3z2gFMVjvx
         C1U+yhSw7SEuNrtnx/WdX89bojM8pokn834lejq1hXP5MG+4nbpm9oCmAeP+oatFsQ6l
         bdO+JA2PRxvEc6fmC0P4aM/uzR5bo+yZTnl7VF8I2uuk0tVj1P/PX8CDXmVgbB+euE9f
         J0MRd0jiTh4zerKJoC++jwEd4eikd3bcuMmczUp9E4sbvMbItS2qW3iScbjc/VZbGrGx
         L58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569218; x=1763174018;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bKq5Kbap+TGIzkU08hwTVasn8Atv2TAiFfbpOuCLu4=;
        b=RREroW1diq8dinzz6TlsyVpR1V7W0EcknWZZDP2dyvf43Hu3Por0x2P3Z0pF5cmCZ5
         zgKflxDzYybRDrOukVO2dlSLnmQJouYbdKWR5eWvVT0p1xOqlq6J6p/dEoV+O4XTr2Ws
         3dFvw5/JCWg5Oq76p9LDWuV+ox4rOdpaIvUvMHanZF6HtJrywoL1jyNwi3wysdSoLrSu
         tYY4LpXzh6tnzKC4KPEHwYWaYhEq5/8ZkxsUnW529di2n3FhLN+/88LVm71dBCNaZwsD
         Sbe45vitelgBdr/wV7Prlyc4faosZzDKuhVIPr+xlEdFOvjGZxJ3QRM2T1kDEMsPMz6H
         Mlsg==
X-Gm-Message-State: AOJu0Yy9L1ku1B5W4iqT27ThkWvI3rcMBEScgtBGp4w172DobZPL6aE2
	Rt1LMxCiJkmYIaKZ8SDoqie4bsJqm5QJNFo27mpMO/iAF1BNyMoYlrGC
X-Gm-Gg: ASbGncsKaRfBBGZBXKIWERMZnjgLCFGhNESJSZ7u1wHdQrLDuMcgNwgdBIO2lRmJXnZ
	kHDzXTm3lgmKWKOJiScItFPG0K/Wvnk1X6tSJmHjhCOTL7EAEjBKCS3VCqVOVmzSyv21kesOhzi
	flI9gSprPveXNrLzoEmFTWozktQ4dBjWnI6MbbzQydOwYnAJ0uft6ruDN/m+ZtuEThCz1M2+lMR
	ARv1hQsGoYXK9a1TGKstuK1z80C+3iBT4shh1sDKPAoB9AVD3feGt5+IV/5irOjHi2jlvZmm0Nt
	84OuSJfeAxvZtrffQQGzb2tmppRgfHh04xbBCrd2SyiOg7XTbD4PpDmpWvSgSegOw/quKc2L74c
	3gdBmHURdFgFsWMd6BPeKu6PvDNGaAmzb4ALy4t96dQrQWb5dtDSWjAsHkbCrvMBgDiOmx1i9b6
	hwgsKb
X-Google-Smtp-Source: AGHT+IH/Pe7wf3Ci181tpT0LHXQVq+Kf1iV5vunI2sKT5fx4KiiLBfIeJu3hgL/jAYkDOG6ZWRYxGw==
X-Received: by 2002:a05:6a20:12c5:b0:33f:9581:5d2f with SMTP id adf61e73a8af0-3539f99e63emr1740681637.3.1762569218334;
        Fri, 07 Nov 2025 18:33:38 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm6587378a12.2.2025.11.07.18.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 18:33:37 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Juergen Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB flush
In-Reply-To: <b3e4a92f-5b51-4eee-bfb8-c454add0f0d2@arm.com>
Date: Sat, 08 Nov 2025 06:05:17 +0530
Message-ID: <87cy5t4b0a.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-2-kevin.brodsky@arm.com> <87qzud42n1.ritesh.list@gmail.com> <b3e4a92f-5b51-4eee-bfb8-c454add0f0d2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> On 05/11/2025 02:46, Ritesh Harjani (IBM) wrote:
>> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>>
>>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>>
>>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>>> Therefore, the batch re-activation code is never called, so remove it.
>>>
>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> ---
>>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>>  2 files changed, 27 deletions(-)
>>>
>> Since the commit referenced in above disables the preemption in
>> arch_enter_lazy_mmu(), so the expectation is that we will never be
>> context switched while in lazy_mmu, hence the code changes in
>> switch_to() around __flush_tlb_pending() should ideally never be called.
>
> Correct, that's the idea.
>
>> With this analysis - the patch looks good to me. I will give this entire
>> patch series a try on Power HW with Hash mmu too (which uses lazy mmu and
>> let you know the results of that)!
>
> That'd be very appreciated, thanks a lot!
>

I did give this patch series a run on Power10 with Hash MMU. I ran the
following stress-ng tests and didn't observe any issues (kernel warnings) so far.

stress-ng --all 0 -t 60s --perf -v --verify \
--tlb-shootdown 0 \
--fault 0 \
--userfaultfd 0 \
--fork 0 \
--exec 0 \
--memfd 0 \
--numa 0 \
--pkey 0 \
--remap 0 \
--vm 0 \
--rmap 0 \
-x swap,pagemove
(Note not all options shown here will work with --verify)

Let me know what else I can run for validation?
Do you know of any specific tests for validation of lazy mmu feature?

>> For this patch please feel free to add:
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>
>>
>> CC: Venkat who also runs CI on linux Power HW for upstream testing :)
>
> Ack, will Cc you both in the next version.

Sure. Thanks!

-ritesh

