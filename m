Return-Path: <linux-kernel+bounces-751765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D69B16D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCD3A1745
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993D35971;
	Thu, 31 Jul 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvjShh//"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234D1D618A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949200; cv=none; b=O5uJB59Y+otIK/lciyGuPJrNhkAwYWRIkB80kU90MksGZg5yBMyXdra7m+7LDdheDRKY9TfCGBhwNdz2p/bZsBmgmrE4gFVsc5SIRbWXNvkwwWnq+1OQ57NNwPdQOFf+S+tElHKPQ8Y5MXisU2GMXH350RGQvozqk+dNTjAtpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949200; c=relaxed/simple;
	bh=mr0LeiORXgN+VmAIgPtWf5qfGXghcxDMKHFS+n+CGhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdPoR9eHXl+1eZ8nQLlesMRYyog/MxcW2NBoqi5un3Lb6geIe6o1S0Fm61RtQ7h7P+qCI231so6I7Lvlzhh5QmSJpMuLCEAGi6lD3Blpk5JSDW15w0HZUoyOfwOAdy6t4MbOKFSC7B5DvKKl4LYYB9P3m1hdP42usalFYSYP0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvjShh//; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso273611cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753949197; x=1754553997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOwcbIZz6KNHT+FXEYQg3/sY0h2+iUCdrhvHC4IZbB4=;
        b=EvjShh///dY5RE+Bk8yDRhehBMnBMtvqit5rREc4jEUotNJSCwceDtEp0+LSA1/pMD
         Le4u7oEEesI5e+XxaI0hBEYZWfzK634aSRDlFrcqHWpN2gvn7lglq5PLxA6XturQluky
         plRgUAwQk9SA5v5Q/bPT+8s6jGc6PG3MvCbEWwQsgkLIHImEbWLRAW/l7voD0vDM3Iud
         skFvEL6IbKEGz5ys+92jiVuCOGw5uopDCPY3V67F401pkB77gFEg6vV7JveosrasQ+Ei
         QBz+wRvFnnh++fjyJr6Nk7pHcHnIKGWELnE7794moAndfndzzMCIE2HMdN/WiU0pMzmf
         nuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949197; x=1754553997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOwcbIZz6KNHT+FXEYQg3/sY0h2+iUCdrhvHC4IZbB4=;
        b=PwfFiWOnfcMUnUgufSH6PdoITy7C6j7RSwjRw+w3V0ELXv6PRJe34XfZWrDYyPF6Gx
         NdaQseAg6nugFrdOA14P7PsQ+F9tzvwhUFNBFnUkbFBQ6s12zYs1K6uI0Mb0LGtBt/xr
         qNPBbjkl3MN/h2Iabvhg39aNx3RaG/jJVaPM2IIx5g416J+LggFeLq8zrQ54xI2Tu47n
         Ldo8SvqXZurmzafkbn7r/KJpPfEEqyq4A5BWMWKWyspsIA5mVLMcDN2Cu/YHePdzVcOw
         UaxE6pzcmNXtX7LOZYb9tHbOA8Sg3xFKGxlhINn3hhfRUEyck5RDajDk+vMgEsO8M++5
         13Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVP3csjUPOnyULb2mbAZVdY1Q8wp+YIySag4MZlzywPKBJqEGDYjlZ/D9j/FlVocxy1GEJzvYs0YHejx8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlClN58/GT8jigjze5ScUV4GFp34LkiGrB2BgA+0ZLsd1HS8Xk
	vr7pPmH3jG0XBr7v0k9zSj1/3e8beXbzjIndlNSnj5md+vR0T8f5SgAxX44sJ96Pm3cHLH++A4X
	A7Z3N11OfInGWd/hDx47OvU0Wj+mW5tUlaK+QVLYp
X-Gm-Gg: ASbGnctVhInRYlMALslVY5i69qtsQUePCFtb7Btv691TYBp/0UvRO/NXMbEysX51jnd
	5c79WcPV3j0sFGw1WaaI5NAboYLdqWcYPl+2h0jIWIiwgdf+VgEu93tusY7FqEsrceLKadS8FQX
	nnIHyRxkHyCJF8t+JnYHb/mLpW7i+47prCS3neQ5FX6c4teY7+cXh7VmPA5qnn/Xh3xzHhD2cHF
	fZKPbs=
X-Google-Smtp-Source: AGHT+IHA3J7LZJAKRJ99scN7c7ARq+UBlGN3HkIGNVkFjCG5DU7qogR7qV0uuCgZR4Tq7z9c3HzsMPaQwvZlYCSFprg=
X-Received: by 2002:a05:622a:468e:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4aeefcc71e5mr1779041cf.6.1753949196737; Thu, 31 Jul 2025
 01:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-14-seanjc@google.com>
In-Reply-To: <20250729225455.670324-14-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 31 Jul 2025 09:06:00 +0100
X-Gm-Features: Ac12FXxldpoIc_5xKiLw2SYzn_frwTTJYhqrP2B7q7n9BwFJdyNg9FxkWuacl9I
Message-ID: <CA+EHjTymOVqvWYfMxS=NAa1HuhfGj+aN=zPtTUTephmPbOqNzA@mail.gmail.com>
Subject: Re: [PATCH v17 13/24] KVM: x86/mmu: Hoist guest_memfd max level/order
 helpers "up" in mmu.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 23:55, Sean Christopherson <seanjc@google.com> wrote:
>
> Move kvm_max_level_for_order() and kvm_max_private_mapping_level() up in
> mmu.c so that they can be used by __kvm_mmu_max_mapping_level().
>
> Opportunistically drop the "inline" from kvm_max_level_for_order().
>
> No functional change intended.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/kvm/mmu/mmu.c | 72 +++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b735611e8fcd..20dd9f64156e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3285,6 +3285,42 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
>         return level;
>  }
>
> +static u8 kvm_max_level_for_order(int order)
> +{
> +       BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> +
> +       KVM_MMU_WARN_ON(order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
> +                       order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
> +                       order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
> +
> +       if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> +               return PG_LEVEL_1G;
> +
> +       if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> +               return PG_LEVEL_2M;
> +
> +       return PG_LEVEL_4K;
> +}
> +
> +static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
> +                                       u8 max_level, int gmem_order)
> +{
> +       u8 req_max_level;
> +
> +       if (max_level == PG_LEVEL_4K)
> +               return PG_LEVEL_4K;
> +
> +       max_level = min(kvm_max_level_for_order(gmem_order), max_level);
> +       if (max_level == PG_LEVEL_4K)
> +               return PG_LEVEL_4K;
> +
> +       req_max_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn);
> +       if (req_max_level)
> +               max_level = min(max_level, req_max_level);
> +
> +       return max_level;
> +}
> +
>  static int __kvm_mmu_max_mapping_level(struct kvm *kvm,
>                                        const struct kvm_memory_slot *slot,
>                                        gfn_t gfn, int max_level, bool is_private)
> @@ -4503,42 +4539,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
>                 vcpu->stat.pf_fixed++;
>  }
>
> -static inline u8 kvm_max_level_for_order(int order)
> -{
> -       BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> -
> -       KVM_MMU_WARN_ON(order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
> -                       order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
> -                       order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
> -
> -       if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> -               return PG_LEVEL_1G;
> -
> -       if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> -               return PG_LEVEL_2M;
> -
> -       return PG_LEVEL_4K;
> -}
> -
> -static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
> -                                       u8 max_level, int gmem_order)
> -{
> -       u8 req_max_level;
> -
> -       if (max_level == PG_LEVEL_4K)
> -               return PG_LEVEL_4K;
> -
> -       max_level = min(kvm_max_level_for_order(gmem_order), max_level);
> -       if (max_level == PG_LEVEL_4K)
> -               return PG_LEVEL_4K;
> -
> -       req_max_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn);
> -       if (req_max_level)
> -               max_level = min(max_level, req_max_level);
> -
> -       return max_level;
> -}
> -
>  static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
>                                       struct kvm_page_fault *fault, int r)
>  {
> --
> 2.50.1.552.g942d659e1b-goog
>

