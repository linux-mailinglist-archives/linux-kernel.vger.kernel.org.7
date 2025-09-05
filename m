Return-Path: <linux-kernel+bounces-802030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28F1B44CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FE2567F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC322422E;
	Fri,  5 Sep 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbPwi6Qm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCE1DF985
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047794; cv=none; b=npdwJwmgZfA4hAyykuon1k8ReD1MPkHE+ALMZe6Zvr32tt9geUkKy0Xm/rJKrPitrFt7wqyohVabY9Lt34YFHMh+twYITTQtL6PfQTz0Xl9y8W+yaPsKFEjTrIFBby5rE6/Kp7COYrtJXJ6JKHqnEupIKEhvZ8acpWxwPcJQ0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047794; c=relaxed/simple;
	bh=wPlK4BknEHsxBvw/mXR0l6iB3+LxqZmmew3RmhEOHxc=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=jj+bA52KW5Bh4W2A16vY2TEX26D19xG7O5WR3OxAcou2H7oNPaY3Xn9VK/FWNiqLZyi3qFHN2gmZCtPHelmCXXF8bPziSXMUcfXW/R2CAJU/PfoXvLh+NJsZVOfG6k2ag2r//P1hklLNwK8oq+Fgi/rmimF9sz1HmLNw30Wsgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbPwi6Qm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248d5074ff7so18882175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047792; x=1757652592; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxcFv1jGHHWePgPdTLSKcytFmfYfh0ATpkvB8I26vi8=;
        b=mbPwi6QmcHmTP6usXM5u/whhuxFs5UudsV38wv3hBDI4Prriy205bPi04DYkUGhVWl
         CdWOjxQb2sTSfi9wzh79RDSJ5GSReMUlBg6RMvJcM+rgOPh3+epekSFGHGSKYzwmnQ5L
         RrfNf8EapM0jCmpsDPuqYiQlxnPAf1U3rLCkWBqb2RqDk4nWsS1NTorXNQGYlsoB3dAx
         H3tbprINoYRGv6IgfBvGNck4DJqr7obFZErVokxoTieGeaYNx2qRQjv7Knr/7p3L7rzC
         Ob1dsePNhDEzHFJ8MGMqtL3bqKxykwoZvXw/NU5Y081hND1KMWDFHkxQ4ecIvsv5GESy
         Co9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047792; x=1757652592;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxcFv1jGHHWePgPdTLSKcytFmfYfh0ATpkvB8I26vi8=;
        b=EdxaxqkHxN2viK7ok9pGIPTe6RuLvGSQl5naIK9A6GfQ98lRaSry5szwOo8ajzFhoX
         pC0FdM0MFdStFs/ViX1I6K3Tox3Q+ywK3QP08BkGCOxNIiwBfeFPHn30VQZyJPUWwL66
         kWHPueAf6h0wLGlPGf2qM75DtoLnCyrYzxjG9xINVLzu40BRcucpNi1DofvdfFxQPLBT
         wxmXTppOg2n6KeLf+IJFSy6zdpSY4dS08cihuaXy5aoXoe52y2ClVbK/n+GO+WV0n5jc
         TYGTdQc+lz9/jErdq1P5PnR6Sbbwmof9aPmwVy9x6m9Zg+CP4ruaJLdtb9quFYj8XQ2G
         QHyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNy3daMqO2+SQvJLp+U744lQANrN2I7LnroRaElugriGfn1NMie2RuVqSrAo0HQJqS8cPaF9iCm2pvVaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wcNzTUI03auiV+DSZVB8XBcxPh/D9chEZQPMIvjFPeCUWNsz
	Y/dBjZ04Q7fLRjCvwDmeG36+Jg7Rb/PLSLj9rApVXdT54pTivWPM1nEZ
X-Gm-Gg: ASbGncsZ2bXCXugAPSZEXxsL5xr5tsbfsAHJ9PBtP+SddXMtDVZUtya6b10Z+ZWtJ+j
	NTAJlFI+Nrzd+ghjYqY5MxOqo1HdRmruiUFvVG4S6GWYsPucW1rtvRvoD1VC6CWi3I/zmE7Cl7N
	FgP9v+tDHBdWW7onVg4fXje9lJk4E9/GKsNJ+JKZxMN9sxky3j60KpxLd36PPjAaSo9jC6MoATe
	yhX+pEuB85W0WF9cUKLGpn+FNnfwKSBhRuILyqP5GydCIcM7p+nomw97S1K37oFx8jhzHCER43a
	WVhfZ9praMv9w80BAzwtPxkDzcTLaPe1Lk4/hJt4UHjobvdWmDRht6MGCQZPL1wByeDIFPnuf9i
	ecf83wBAd8xgf48HAXUaWBSdgrXWJxpZvsaxS
X-Google-Smtp-Source: AGHT+IHX8e4Inpx2hBks4rAQrQfUIDHGhgp1fO6cFmLJ0IOo+VGkzueivYyMxmOU6vV1rXg0Tl/w0A==
X-Received: by 2002:a17:902:f688:b0:246:8ba5:f450 with SMTP id d9443c01a7336-24cefe326b3mr25473425ad.28.1757047791577;
        Thu, 04 Sep 2025 21:49:51 -0700 (PDT)
Received: from dw-tp ([171.76.86.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc1a82a34sm34286845ad.151.2025.09.04.21.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:49:50 -0700 (PDT)
Message-ID: <68ba6bee.170a0220.3b821b.ca9d@mx.google.com>
X-Google-Original-Message-ID: <87v7lxime4.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Donnellan <ajd@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure
In-Reply-To: <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
Date: Fri, 05 Sep 2025 09:25:15 +0530
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org> <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
> kernel text has to be mapped read-only or read-write based on build
> time options.
>
> But nowadays, with functionnalities like jump_labels, static links,
> etc ... more only less all kernels need to be read-write at some
> point, and some combinations of configs failed to work due to
> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
> access to kernel modifications.
>
> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
> possible options that may imply kernel text modification, always
> set kernel text read-write at startup and rely on
> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.
>
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org/
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/pgtable.h | 12 ------------
>  arch/powerpc/mm/book3s32/mmu.c     |  4 ++--
>  arch/powerpc/mm/pgtable_32.c       |  2 +-
>  3 files changed, 3 insertions(+), 15 deletions(-)
>

AFAIU - mmu_mark_initmem_nx gets called during kernel_init() which is
way after static call initialization correct? i.e.

start_kernel
  ...
  jump_label_init()
  static_call_init()
  ...
  ...
  rest_init()      /* Do the rest non-__init'ed, we're now alive */
    kernel_init()
      free_initmem() -> mark_initmem_nx() -> __mark_initmem_nx -> mmu_mark_initmem_nx() 
      mark_readonly()
        if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && rodata_enabled) {
           jump_label_init_ro()
           mark_rodata_ro() -> ....
           ...
        ...

Then I guess we mainly only need __mapin_ram_chunk() to be PAGE_KERNEL_X (RWX)
instead of PAGE_KERNEL_TEXT (ROX), isn't it?

Let me quickly validate it... 
...Ok, so I was able to get just this diff to be working. 

Thoughts?

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 15276068f657..0c9ef705803e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
        p = memstart_addr + s;
        for (; s < top; s += PAGE_SIZE) {
                ktext = core_kernel_text(v);
-               map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
+               map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
                v += PAGE_SIZE;
                p += PAGE_SIZE;
        }

-ritesh



> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 93d77ad5a92f..d8f944a5a037 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -20,18 +20,6 @@ struct mm_struct;
>  #include <asm/nohash/pgtable.h>
>  #endif /* !CONFIG_PPC_BOOK3S */
>  
> -/*
> - * Protection used for kernel text. We want the debuggers to be able to
> - * set breakpoints anywhere, so don't write protect the kernel text
> - * on platforms where such control is possible.
> - */
> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> -#else
> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> -#endif
> -
>  /* Make modules code happy. We don't set RO yet */
>  #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
>  
> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
> index be9c4106e22f..c42ecdf94e48 100644
> --- a/arch/powerpc/mm/book3s32/mmu.c
> +++ b/arch/powerpc/mm/book3s32/mmu.c
> @@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
>  
>  	for (i = 0; i < nb - 1 && base < top;) {
>  		size = bat_block_size(base, top);
> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>  		base += size;
>  	}
>  	if (base < top) {
> @@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
>  				pr_warn("Some RW data is getting mapped X. "
>  					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
>  		}
> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>  		base += size;
>  	}
>  	for (; i < nb; i++)
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 15276068f657..0c9ef705803e 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>  	p = memstart_addr + s;
>  	for (; s < top; s += PAGE_SIZE) {
>  		ktext = core_kernel_text(v);
> -		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
> +		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
>  		v += PAGE_SIZE;
>  		p += PAGE_SIZE;
>  	}
> -- 
> 2.49.0

