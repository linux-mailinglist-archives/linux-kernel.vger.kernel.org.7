Return-Path: <linux-kernel+bounces-896558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792EC50AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2CBD4E8380
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5442D97A9;
	Wed, 12 Nov 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZStueS/4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB491D618C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927750; cv=none; b=Rf7Bpawa5oAU0Rb6IhJC0pWQ4qprNo3EAg8CJPXV7RwWBHo+2GBky4XzQcV/jNqPu9AOy+qe6+33Xzr5rx3Bhj1QVoTqvWz4cSQBm3HspGabhC/+e5b143F2vYN69efYQmo8riF7wpbTxCvnjRI+WNkfBDQQNOhctLdN09JRT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927750; c=relaxed/simple;
	bh=/x4XZIRoMLNhyu0rYcHubu3u5VIXlH9V8B33W9iRICc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=a/O38Yc5dCznWOqeb373jvF6P/2AJsZzBMlXeL5Mnm7VRYeZZc3oNrm1E5Viu/lmpwpfrhp/JSOEAdkihPLXlArbaa8uhdYpJBRKEDhHOLMbLJKf9qh8TKv1vI7QuvmOdcxEltQaqGVnPEgw55EKLSmqAD1coF0Wlc+skFbj/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZStueS/4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2980d9b7df5so3910165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927747; x=1763532547; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vf+V3xa9EgGUbHOlQxF1xdJJTU0DRTndVUemiyXUeyI=;
        b=ZStueS/4trU8f6sSvf0LHZO/9mt+nOLXLu/UldJSpb0skHlV2NCwhyMNjEhT9Mx6bg
         JZphKb90/LWOdsCdLL6a1oscPuVO3PfuBiNxJJuRSDCknrvaqcqai47qBKBtt1SyoSSa
         9Yzv52CUEFx8g3CYcYF/4LS/DHQunNAuGYKyF8qgunax8RBNUVFUwxYf2vhsVIGOWSKm
         rgIq5bG8u63J3/x3Rz23s5ACQ4OOABHU4/sZs7bIYZ6tdJOTRrAeNC8KfhHeCcNPZqgz
         3/75OIN0SPOk4olRElfFQHrCJhTPjyQ6uy/eSWOig6pDdsWvkwbOEZ7fmPfQbHX1F++8
         /SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927747; x=1763532547;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf+V3xa9EgGUbHOlQxF1xdJJTU0DRTndVUemiyXUeyI=;
        b=S6nHw1ZrJ8kcIEIjoWdeYi5DLu7FvCvQbTd0HYUzx/B8nXDLACflfEbSP5ghBVpL4c
         +svMnAcwSSQhYDuT28skSZKHQ7C0x/ZyetTU48ixtjFobPkiCMbEtCb7GJtfa+YRTi28
         KijNZsL59ioF5C69iCTrNp0ftKb4GT8McNEZAtBCK1KUKpADq75Gu42hQoArqmyQyY/5
         I3lQjyewIu2mUYDNgcR1ymt5MKwbVibmR+4aVrEK5ukxqtXtUxGUrj4zIeEf1DHkT4mi
         uZ4R/8YB2e46PBOO/CC3oMdOa9c+jPysfoW7KotP7oB5jhlF1snCqgxvT4GND4xrONkz
         4eyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMb/BJZp6EVQpYdSy67efOeynC5KfbRWlpAVJt8EPOl+950Ar6lsmNG2tXERAVMy6zxJ1Imb3yEimeOcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlp63dTwQyiEjX1TlLy7AATxWnAmrcJrzzDR0opPcOAoEKjATJ
	9KW6sX1XjdJ0bTPTUAjWXxx6oHpOGxTy2kLfsUZ4iVRXO6FQrWyPa+7N
X-Gm-Gg: ASbGnctmiXczXG0dGVmqGVZZnImyN7a1mHyviSMFs6O8gPC6MB8O1pjFa2o320H+3Jm
	eTY5p9xWI3Z6kBR98JgiYAW3e/czcsLd7/8BHusp2tpmmyY1Y7jywrEQcbdJ4dL97WDiWOd6Zv8
	fAfVnlBgSeNXlMHLjq3uqcElRk8Rp5B17JrPuFo6x8ZhrAzf7K0fa8V8X3Q3QswVFP4GhgSm1K5
	ZW5eV5IxKeYdeBqIhgGnmKj+sOQV4Bwotp5VkHt8BfCHnhtes8KrXWiHQa7X4qILua2Iqbve6Ua
	fiXU4WUkoAF5JWwd6a7NhKI6KOUvRUuF+z7/tghkff3wwQaKi7LWlYsz+h+GOHKOgrSviQDQ3xy
	qQQbJwHgi0+sGQPH40eCbxbGHNYlEcHyjUvVcCkdIrWFHILEeGg+rO3f+aCn2Lxikp+j5OGU=
X-Google-Smtp-Source: AGHT+IEohiT6l/U6Q6cSeQX1Sd4BBaq0PAFAEVh2j8GuYXQZDYJogJ/Y0Dgu8WSYVH4jJhCDgr7O2w==
X-Received: by 2002:a17:902:e804:b0:296:1beb:6776 with SMTP id d9443c01a7336-2984edf314amr25324145ad.58.1762927747094;
        Tue, 11 Nov 2025 22:09:07 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbd8cd0sm18094405ad.4.2025.11.11.22.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:09:06 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nadav Amit <nadav.amit@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Dave Vasilevsky <dave@vasilevsky.ca>
Subject: Re: [PATCH v2] powerpc, mm: Fix mprotect on book3s 32-bit
In-Reply-To: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
Date: Wed, 12 Nov 2025 11:03:52 +0530
Message-ID: <87ikff95mn.ritesh.list@gmail.com>
References: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Dave Vasilevsky <dave@vasilevsky.ca> writes:

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
>
> Fixed by making tlb_flush() actually flush TLB pages. This finally
> agrees with the behaviour of boot3s64's tlb_flush().
>
> Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Flush entire TLB if full mm is requested.
> - Link to v1: https://lore.kernel.org/r/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca
> ---
>  arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
>  arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
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

Maybe I would have preferred the following naming convention for hash
specific tlb_flush w.r.t mmu_gather, which is also similar to what
book3s64 uses ;)

- hash__tlb_flush() 

But no strong objection on this either. BTW - I did run your test
program in Qemu and I was able to reproduce the problem, and this patch
fixes it.

The change overall looks good to me. So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

