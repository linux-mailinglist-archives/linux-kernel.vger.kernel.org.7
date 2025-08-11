Return-Path: <linux-kernel+bounces-763585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC280B21713
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F9E1907B48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27542E2DED;
	Mon, 11 Aug 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2j1LxxX3"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7112DBF5E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946657; cv=none; b=jZEHvs57JUX0Gd3tL2EStz8enE1JTg9cayDcK6N7oy5KBHSN9Wle1aTFggWUeheN3BTHGP1BgrZ7XkQJxwZKx+AttWcYHVe8Cc8TpiIZybsiyP8hObkkfla0eCmpXXzfC6MLp0QrSfcqkPgH0+yRTptJhqMSpvGUb+VYwC0p5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946657; c=relaxed/simple;
	bh=wBLSCAldXdz6Aqzj2ZgVJBIXTJAMMxPB3VZz7oI849c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7XMykkxx7SuJE5h/m3tLvqQBoQtJlZ+ksDlmDvUcGnC2DNVk6+tcxqWgl9pnW0CMGa7o/BJRZBBMtKgB4yAmr+iyMYMCMHVtXQbGFQRQ5y4qB3ciFAmWqh/4b+2KVVRE6Pn+6MZoRDcwJfLcVZCARJ+UpRGZUjgg5YCv7l81Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2j1LxxX3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bf04716aso36771cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754946654; x=1755551454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8kpMVQN+kxcOUo8uXI1h/4+fugPUTPnI8qDv0t+xv0=;
        b=2j1LxxX3pDFT2AOSimcn+wTiNQufFzCZgDot76tTwapuCVzsbZ2i2EYyNxVICk0VwQ
         DL8FzsS+SI4tORdz5o54DxdVC5xCTFaKe6hV5l2I0vJ79974/ToW8tHQOlR5cleegg7m
         NfImwn/UrqcR9ZBdRUQljTY95u60gaYAdzRzEc5A44w6LYD8OwY6K2TDds2Yu6VKjm0L
         pF43f54l4LkJalxjTer8Dk7i/U3gix+3g++QwJGCFwETfVolywEPEkFVFUTxHh0IWV5U
         McVHcmSnJ126BIrv9bjLrVsffUZ69ebwGWW7tx3RI9iKA2ctXzlAX0RpYucOYCTqMWpI
         OlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946654; x=1755551454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8kpMVQN+kxcOUo8uXI1h/4+fugPUTPnI8qDv0t+xv0=;
        b=eLAUkBs6KtEQaEQbX577unRkK9QbbR6urH3WGrvFX40UDCk/NBpRkvthXtmfXDhMs3
         8u0bwzKVDK+/B2i7aRUXH6xZT57SymKHIF75pjBEgfIGkg7TAOSdwQ9Ku2qhB4h9wi1e
         zhETfC8BAw7grE1jtyQ51dGK9xF5nmxdx2X9uODMkfRdwK0hCatE4tXJ7fYZ7dAqYFUw
         QUCEmsGfT8gBLiZdmJTUxhL5CGO8XhKtpjjuqxn8fWPB7yorY1/PtK5FMgMO0SzQ8HMA
         XMghbHHfWnNYYY8vLeV8p+nFwFI74X1+dmopY3Ika+HXcap3GG0LwFpCyjppE8niEbj9
         /7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVJOPMnk7mKtBN88x/DsY3kisv9FJPftm6ET2Ej1iIc/VxvXzaf3Ojnq3XoLAepGvV0MzjlxYjzLCzrj04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKz6JsOm8t96aY4OJIeY2GVMmgEcpNGDgwxD4sXO7RlfxRxR5w
	3R1FCj8e/oWQl3UNozcf81xc6QoyRU5Qu1m40GjUdD8c+W2vLlLPd9F+0HESRKM2ag+6IYC88ft
	XhAtXG2VJgOKoPGE/vq4wnI0//G9hSzjM1YzA32F4
X-Gm-Gg: ASbGncvy80y764hNo+bPft+c7p2Y8aAxD13pCks6pnwVooahNbQdGSdwym4+vAGhCGL
	mw1U0jzOJeaePWpIrRSZ4sDitliTCe/lbg2Erjaf5s5RZ64L+KJqtj17qeDfmw10UUcXDqgJbZj
	9iGME5K5prDndk8TUwo+p390bhBzJ00FYc1y/6ouHjLzoz2+f45N52QyyC/CtJZ8bJRT1s/irOi
	SGceMtasML6hZmkZ8qT8WYZ6q9BQwqhmnukOXs=
X-Google-Smtp-Source: AGHT+IGrFd77Bx+EKopvRxbg+m1IeKplQHg0gCIDVl+wT9usSoAPtnU/AdsEjyhI0upm5xEdEbCeQ2tz2jz3wh0En3g=
X-Received: by 2002:a05:622a:1a9c:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b0ef35f647mr290581cf.3.1754946653817; Mon, 11 Aug 2025
 14:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807093950.4395-1-yan.y.zhao@intel.com> <20250807094516.4705-1-yan.y.zhao@intel.com>
In-Reply-To: <20250807094516.4705-1-yan.y.zhao@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 11 Aug 2025 16:10:41 -0500
X-Gm-Features: Ac12FXwox6fPzU2alMAVmH7V3wy02ekBTE4ia43sewPZz30re1TGyXyUMSAloFo
Message-ID: <CAAhR5DEZZfX0=9QwBrXhC+1fp1Z0w4Xbb3mXcn0OuW+45tsLwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/23] x86/virt/tdx: Do not perform cache flushes
 unless CLFLUSH_BEFORE_ALLOC is set
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kas@kernel.org, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vannapurve@google.com, vbabka@suse.cz, 
	thomas.lendacky@amd.com, pgonda@google.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:47=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The TDX module enumerates with a TDX_FEATURES0 bit if an explicit cache
> flush is necessary when switching KeyID for a page, like before
> handing the page over to a TD.
>
> Currently, none of the TDX-capable platforms have this bit enabled.
>
> Moreover, cache flushing with TDH.PHYMEM.PAGE.WBINVD fails if
> Dynamic PAMT is active and the target page is not 4k. The SEAMCALL only
> supports 4k pages and will fail if there is no PAMT_4K for the HPA.
>
> Avoid performing these cache flushes unless the CLFLUSH_BEFORE_ALLOC bit
> of TDX_FEATURES0 is set.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
> RFC v2:
> - Pulled from
>   git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git tdx/dpamt-h=
uge.
> - Rebased on top of TDX huge page RFC v2 (Yan)
> ---
>  arch/x86/include/asm/tdx.h  |  1 +
>  arch/x86/virt/vmx/tdx/tdx.c | 19 +++++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index f1bd74348b34..c058a82d4a97 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -15,6 +15,7 @@
>
>  /* Bit definitions of TDX_FEATURES0 metadata field */
>  #define TDX_FEATURES0_NO_RBP_MOD               BIT_ULL(18)
> +#define TDX_FEATURES0_CLFLUSH_BEFORE_ALLOC     BIT_ULL(23)
>  #define TDX_FEATURES0_DYNAMIC_PAMT             BIT_ULL(36)
>
>  #ifndef __ASSEMBLER__
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 9ed585bde062..b7a0ee0f4a50 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1648,14 +1648,13 @@ static inline u64 tdx_tdvpr_pa(struct tdx_vp *td)
>         return page_to_phys(td->tdvpr_page);
>  }
>
> -/*
> - * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
> - * a CLFLUSH of pages is required before handing them to the TDX module.
> - * Be conservative and make the code simpler by doing the CLFLUSH
> - * unconditionally.
> - */
>  static void tdx_clflush_page(struct page *page)
>  {
> +       u64 tdx_features0 =3D tdx_sysinfo.features.tdx_features0;
> +
> +       if (tdx_features0 & TDX_FEATURES0_CLFLUSH_BEFORE_ALLOC)
> +               return;

Isn't the logic here and below reversed? If
TDX_FEATURES0_CLFLUSH_BEFORE_ALLOC bit is set, we want to perform the
clflush()

> +
>         clflush_cache_range(page_to_virt(page), PAGE_SIZE);
>  }
>
> @@ -2030,8 +2029,12 @@ EXPORT_SYMBOL_GPL(tdh_phymem_cache_wb);
>
>  u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
>  {
> +       u64 tdx_features0 =3D tdx_sysinfo.features.tdx_features0;
>         struct tdx_module_args args =3D {};
>
> +       if (tdx_features0 & TDX_FEATURES0_CLFLUSH_BEFORE_ALLOC)
> +               return 0;
> +
>         args.rcx =3D mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
>
>         return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
> @@ -2041,10 +2044,14 @@ EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_tdr);
>  u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct folio *folio,
>                                 unsigned long start_idx, unsigned long np=
ages)
>  {
> +       u64 tdx_features0 =3D tdx_sysinfo.features.tdx_features0;
>         struct page *start =3D folio_page(folio, start_idx);
>         struct tdx_module_args args =3D {};
>         u64 err;
>
> +       if (tdx_features0 & TDX_FEATURES0_CLFLUSH_BEFORE_ALLOC)
> +               return 0;
> +
>         if (start_idx + npages > folio_nr_pages(folio))
>                 return TDX_OPERAND_INVALID;
>
> --
> 2.43.2
>
>

