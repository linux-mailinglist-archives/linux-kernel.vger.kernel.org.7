Return-Path: <linux-kernel+bounces-891701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDB4C43486
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D40194E5229
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C52139CE;
	Sat,  8 Nov 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6m1nDj9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03B283C83
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762633123; cv=none; b=JS1/Vf8KsSy5P4lJ1XnNAH5CGW0bAPYZ9iR96ohFG7S+l8w0FFjoByroDhZR+s7Ugpbj6YEsDVMRNnhNO2hBxClf+jnlzbvVyAB+jNIPzdy0OZk071bZ0VapBDAoFLrLGB2VtFd6b5w8Z+ZmI8T4dg5pzJs2TOU1CiIuNX2pE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762633123; c=relaxed/simple;
	bh=QZB+9bmhvWHDjQPJRe2j20VBCE0mgV8B9lEu5QR51gM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ur6rHQYDrnzkWk3u+lI3H+Gibu81yibOdRDIAPEHBHp4d6e5oubquC4W4SOVOuelq0BJnL0liUJtL9gD9KXADArheiy5l8C1PgxstzL295vu2JlWde57+RdpFP7lp5mwZPtD7ZFSUouRRnANKg0vvjHT3Pl6b/beFhmApcUppXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6m1nDj9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ba507fe592dso1105605a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762633121; x=1763237921; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eptMmi/rSmOF7zh3lnbB0jvPX8L9rhMmLXfTARMvAA4=;
        b=g6m1nDj97qsJZ7zD5A6a/SaUNiThkJ4R+GClR03ZrpPn5stUbhjRbmsc5EMM7WLlQo
         GBMUdMOUfgJCbTEuN3oonoTvo7Wskax06RiSTmfnhrwl1zViIY25TMStZgkMznC3nQw2
         K1p0X61XfBVImntb800guJFkNxp4G3Rqv6NtX9YRcDNoeqefs876kK4ezxip7PMW4Knw
         EDj8p0SNN1KZ9mglvoXUWS10cjcTyiBS6Eih8jXwnKcubeADGuUWUxG5U6YDqD6hvEOx
         cxHHLiEwmIlfw2dlxu2/wdWDxB0pEh3bJB55W/p40OXQFnodgx2LSse/zFTJbhQi9EJN
         r9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633121; x=1763237921;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eptMmi/rSmOF7zh3lnbB0jvPX8L9rhMmLXfTARMvAA4=;
        b=bvLWDU42m9IcYb1G6Yjc8R9yVMTnYnpEyejfVAvKAt2o4D2RAt4dUmyDRnV5JLkZGL
         CTeYF3nv3YeKAkQ9q86Mb3AJXJ1P3VbPmnjuB4X8X04uAyYHnTfSrhHdrYSHD3BZMnmG
         Jy9MfsAKlyD1A5CwiL9L+7XPCumaD9MnMQauddsS8TABIJ/8+64gMz1cNMQwMRqeItpI
         UWy9MoM8UKEy6wlqqlt6PveYPdIB0yZIEUlbVNhs3deBUjyFbveR6QZ6cWpwpm+cmjqA
         ub7JJssqhGzHitmwIa09OiVuVlxmHozpVAvezMfZVkJwPjxcDfKvyfltE8HjqCLj7mSZ
         yDow==
X-Forwarded-Encrypted: i=1; AJvYcCXrvpKCergnm0jp2Cwi89wBIsBG0CD19RLFLjSwR4m/CU8aL5rZXSlpOE48Qk3md6Pf7wYPemXMx/F+Afo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLq0PmFGG1JK753OS9KlIhkI8AdAnipc77l4WqhFTuDUuyNyI
	DbCjFGaWXyq3yB1iIRSrFfxEHWkmVYx+quJemTHM2wnMAiRUiIUcT5/W
X-Gm-Gg: ASbGncuyf7At2M15JorEroKI34R9hHGrJbAkxyekG6cOk4X5E9uMSH2Pt6/SJUw/D3g
	0NE6423SUceRAQ+LjWjnyboJyyo6JZSxeix+zPXiXyJLpg8geQylwkRdq5Ui7XZE+eEE3oaQB1D
	6LUTkHlVtF6xmNPb71GHSfk+BBBHAtzfnqXHDNgcmcxjevanRbBxsdgnIMQCAmS9bsyfEKH0FeI
	1A5pEEunA9GCcaaqvNgKzfIYsYjW/JD3S4pgXXW638mWoWQmBqk1r4NyjazEjRgIfZKzr2T6Llz
	7c1p63JRgRVsjp5i31NvZtrHORrjXfbtRgIfnQemNrqkYfvjrNVgEuklkzdxdPSQIunFkrB/YXu
	4OWPMMM383j/FEx/A0M6LGoKGYo+CcMvcXZsT+OFIB2tTLLlMkdfX3Os5yCmOzqTpBJbvBg==
X-Google-Smtp-Source: AGHT+IFb5ZIMhb48UQ+0j2VRNphIuxham09NgnX5MSt7QH3z4h9Q5UU4rBsGOgTmioZaQIMKF6pn6w==
X-Received: by 2002:a17:903:f83:b0:295:5613:c19f with SMTP id d9443c01a7336-297e56f6b9amr42076845ad.42.1762633121076;
        Sat, 08 Nov 2025 12:18:41 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d766efe6sm44719285ad.49.2025.11.08.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:18:40 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Vasilevsky via B4 Relay <devnull+dave.vasilevsky.ca@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nadav Amit <nadav.amit@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dave Vasilevsky <dave@vasilevsky.ca>, linux-mm@kvack.org
Subject: Re: [PATCH] powerpc: Fix mprotect on book3s32
In-Reply-To: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>
Date: Sun, 09 Nov 2025 00:46:04 +0530
Message-ID: <878qgg49or.ritesh.list@gmail.com>
References: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


++linux-mm to get some pointers on how to test such mmu_gather changes

Dave Vasilevsky via B4 Relay <devnull+dave.vasilevsky.ca@kernel.org>
writes:

> From: Dave Vasilevsky <dave@vasilevsky.ca>
>
> On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
> unnoticed because all uses until recently were for unmaps, and thus
> handled by __tlb_remove_tlb_entry().
>
> After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
> tlb_gather_mmu() started being used for mprotect as well. This caused
> mprotect to simply not work on these machines:
>
>   int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
>                   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>   *ptr = 1; // force HPTE to be created
>   mprotect(ptr, 4096, PROT_READ);
>   *ptr = 2; // should segfault, but succeeds

I am surprised how come this was not caught? Don't we have any straight
forward selftest for this?

Not just mprotect then right.. Many other MM paths must also be using
mmu_gather right?

>
> Fixed by making tlb_flush() actually flush TLB pages. This finally
> agrees with the behaviour of boot3s64's tlb_flush().
>
> Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> ---
>  arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
>  arch/powerpc/mm/book3s32/tlb.c                | 6 ++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
> --- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> @@ -11,6 +11,7 @@
>  void hash__flush_tlb_mm(struct mm_struct *mm);
>  void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>  void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
> +void hash__flush_gather(struct mmu_gather *tlb);
>  
>  #ifdef CONFIG_SMP
>  void _tlbie(unsigned long address);
> @@ -28,9 +29,12 @@ void _tlbia(void);
>   */
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
> -	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
> -	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
> +		hash__flush_gather(tlb);
> +	} else {
> +		/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
>  		_tlbia();
> +	}
>  }
>  
>  static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
> diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
> index 9ad6b56bfec96e989b96f027d075ad5812500854..3da95ecfbbb296303082e378425e92a5fbdbfac8 100644
> --- a/arch/powerpc/mm/book3s32/tlb.c
> +++ b/arch/powerpc/mm/book3s32/tlb.c
> @@ -105,3 +105,9 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>  		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
>  }
>  EXPORT_SYMBOL(hash__flush_tlb_page);
> +
> +void hash__flush_gather(struct mmu_gather *tlb)
> +{
> +	hash__flush_range(tlb->mm, tlb->start, tlb->end);
> +}
> +EXPORT_SYMBOL(hash__flush_gather);

Shouldn't we flush all if we get tlb_flush request for full mm? e.g.
Something like this maybe? 

+void hash__tlb_flush(struct mmu_gather *tlb)
+{
+       if (tlb->fullmm || tlb->need_flush_all)
+               hash__flush_tlb_mm(tlb->mm);
+       else
+               hash__flush_range(tlb->mm, tlb->start, tlb->end);
+}

It will be quicker if someone already has a set of tests which we can
run to validate. If not, I will take a look and see what tests one can
run to validate mmu_gather feature. 

>
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251027-vasi-mprotect-g3-f8f5278d4140
>
> Best regards,
> -- 
> Dave Vasilevsky <dave@vasilevsky.ca>

Thanks again for pointing this out. How did you find this though?
What hardware do you use?

-ritesh

