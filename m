Return-Path: <linux-kernel+bounces-789684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD3B3991C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56238179168
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860823081D4;
	Thu, 28 Aug 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDiCvMBu"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672873081A9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375671; cv=none; b=jveSx+MLAdxRG8yiPqgdqsUs/RWfCzqdaThnrYjbxk9v9jA81qld/wADNyo4tH9IomJcNZkH10ef7BhWU2Ph6bJVakHumyQO2BozVNQzXxJZZ5ashRYHO9fjveMh5drxUZb8UlY4WWUhlh6p6quNLxhgQgcBO5fCI3KL0GYrOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375671; c=relaxed/simple;
	bh=TJWOQ9Y/D8amR26SYM4qj8T+TSWFnuMR5SCM6u632Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnrTGbB7/ePdRUS81w/qSMl30Lr+Tr+JTL6kPb+uvHCPR/V6k0pQnMqa8QhwbIEY0rbVdMn5xgYLF9xDj4Hbmq/xSeUxjlYo9o4MIm50oYOoVT7pVY4dH3enK7+h2uuFtZlZHll5bfCgNwH2SdHM7J+Dwisr70VgTETBMGBWz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDiCvMBu; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b12b123e48so322031cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756375668; x=1756980468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9E9CQIEDOr2UcYitZQ4gvIXZ41Noi3g2Rn0AmT7jQqk=;
        b=xDiCvMBukmDrwQWP9NfcVu92/hmzjPNT73QlcFd/GE9MoqlBdckobXLgM0ORwMD2nz
         hWS9XgjR1PB5tVLKDf/ZZ4/WKKW1P+vkbqYdqp8eI79pyEVq98Bhklkn921iVvPE7b3G
         42COmKXbQd/u+M9X1YDC5mB2YEdTTotTo5JLVyDglwNmGGZg9qknv8YmHx6kF9t5hd5X
         8/Qms1AOMABxeLj3HKtnjgI7GQuUAj+pWYpZCfChvItilsayrSLOCSqyztu6VIlvmKPY
         50ZW1OU/Xhxwr5s/qbVoN8h9M7rFWhit0/EwMepevEfOE/nNmoUVDw7X+IpWpTKscMe1
         38oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375668; x=1756980468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9E9CQIEDOr2UcYitZQ4gvIXZ41Noi3g2Rn0AmT7jQqk=;
        b=GkJKoYLfERJRDYqVWZDY8okIpp6ecBm2ZQBHqqIeB36IJWWgqUcbf7Fj2Tx5x9AIeT
         O34Exv81sL5sO4lGln7NdDua8s56pPcmr8BTH165Ir0aN59BGZIq2yqJJzfa8pgzEhL2
         KhOa5tj/T/us1CZlkOitOdKwZvvOSlDCufqGopueyfukXvQ/i00aKDpShR71y89Z7aXK
         tu7NWeE98nVQbpeS3j/tJu+VeedkYIpwoh4DvSV5xGdYoY6uBXdNcdkCkUlIeJ08abq8
         FtAFY2jXpF7LRDHO2Vk8xUXwwNEVCtfClaNsW/pomKkJ5ULrGwYTu2+lgY+N4TxcXtdN
         hoGA==
X-Forwarded-Encrypted: i=1; AJvYcCU1yqcqrRA7gfeWTpXJER5QJW6JPiLbNKWzP+hLVIdPc6Cev4BS+DAYINJToFhIc6Nva+CAcdGv5nR5BQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPNyGcreckuC4LUOXU8nazbFdB/qd2tSiTEukgd86dHEa7JrB
	wkx2mpcOlT3sjuFfaeALhVi+IkL4jzBDy2gHgry+Nh+mftg9G1pJb8QuGZh750mYd4Yy4YXwxca
	vHtUJKAW68Ztllruxhrsk3qofezP9gda1HKfdteIL
X-Gm-Gg: ASbGnctL000AWWVxOU1FnKsNAcDVVw+kTjUfok6QStxw/m8DTjI/MWhshFKZQbJ1c25
	Z/9QmyhZtEbQkeM/ph1cP8AdUvQrwpNQbmRp5wDL70lh6tmgx7jDx+r+1wY1QaeCAHgj12mvTRH
	o3GBLCpqbKESpk7YnEMvR3IlMV5np8R5dx2kaSkRpJ34O514eFEg6EfxLmS0UgLcb8HKls5cm45
	BzF/P0BN3SBlus=
X-Google-Smtp-Source: AGHT+IFRjTT6s+Lga012dxByxsEc3lbr9K1CdoyVsw5ZK+adWd1hKzUTB9FTJRCdYTn8BAJBAZ04Flo9bNZpApNjkqk=
X-Received: by 2002:a05:622a:1816:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4b2e2c55f8amr18542401cf.13.1756375667872; Thu, 28 Aug 2025
 03:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828093902.2719-1-roypat@amazon.co.uk> <20250828093902.2719-3-roypat@amazon.co.uk>
In-Reply-To: <20250828093902.2719-3-roypat@amazon.co.uk>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 28 Aug 2025 11:07:11 +0100
X-Gm-Features: Ac12FXyRDhAk_TvQ6RybLCFXLNR5ZeiLskg-xMwpbNc02N3Vn5Fv4ySMEuemdfk
Message-ID: <CA+EHjTwDZ-FRV2KfC5ZG9SJYeeMRVUHQ8rVtb9dx2AQwCriPQw@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] arch: export set_direct_map_valid_noflush to KVM module
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "david@redhat.com" <david@redhat.com>, "seanjc@google.com" <seanjc@google.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "will@kernel.org" <will@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Thu, 28 Aug 2025 at 10:39, Roy, Patrick <roypat@amazon.co.uk> wrote:
>
> Use the new per-module export functionality to allow KVM (and only KVM)
> access to set_direct_map_valid_noflush(). This allows guest_memfd to
> remove its memory from the direct map, even if KVM is built as a module.
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret enjoys, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>  arch/arm64/mm/pageattr.c     | 1 +
>  arch/loongarch/mm/pageattr.c | 1 +
>  arch/riscv/mm/pageattr.c     | 1 +
>  arch/s390/mm/pageattr.c      | 1 +
>  arch/x86/mm/pat/set_memory.c | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 04d4a8f676db..4f3cddfab9b0 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -291,6 +291,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>
>         return set_memory_valid(addr, nr, valid);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  /*
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index f5e910b68229..d076bfd3fcbf 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -217,6 +217,7 @@ int set_direct_map_invalid_noflush(struct page *page)
>
>         return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
>  }
> +EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");

This should be after 'set_direct_map_valid_noflush', not 'invalid'.

With that fixed:

Reviewed-by: Fuad Tabba <tabba@google.com>

>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>  {
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 3f76db3d2769..6db31040cd66 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -400,6 +400,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>
>         return __set_memory((unsigned long)page_address(page), nr, set, clear);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 348e759840e7..8ffd9ef09bc6 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -413,6 +413,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>
>         return __set_memory((unsigned long)page_to_virt(page), nr, flags);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
>
>  bool kernel_page_present(struct page *page)
>  {
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 8834c76f91c9..87e9c7d2dcdc 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2661,6 +2661,7 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>
>         return __set_pages_np(page, nr);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(set_direct_map_valid_noflush, "kvm");
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
> --
> 2.50.1
>

