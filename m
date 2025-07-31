Return-Path: <linux-kernel+bounces-751764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A406BB16D28
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73C7189DBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009821480B;
	Thu, 31 Jul 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKTz2HP1"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCA1D618A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949164; cv=none; b=O3/a46sToc//BH7TzHmSw/aWil5YACGM+lb6qPZsxw1eAG8+fZ32N7eDTAFei1/xLbTmFME7W/We2z6nWj3OX9pYoBYcdmxw+t1SsawH+gSBxR9ZS6m5+a9zVLmOlDboBhJXr4Ft+vCrQ+7YNnAAbhHJSKMqbgOnqMGg2l1AjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949164; c=relaxed/simple;
	bh=Dr25RX5UwdEyT/fw+Vjy8ZCDiwBHn/6iRJwKcG/4Kjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUoJD7XnEmFyk1fUNRP4OXgcIc0q6+GPs7gwt3Xjt6HXQ1bXRPUVonYQl7pJ9sEF0fVRFbacWP2LVKqHETsrI1yglPAxN5HagbsPnidsmEgnSHlgJUYkNpc2AV7JknT0CrhfGS3vGcwvdODWqr3CCIwbUgWa62OQoXpAcAIO9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKTz2HP1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aef56cea5bso59941cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753949161; x=1754553961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sX9GbqVIjmwrvhX5OSfDHPFCq4jInN5mZum+NpNw7Gs=;
        b=AKTz2HP1uvzPVuJEA525aoUDnBC4jITWqOe1Kp65VbD/+w/YzKfCq9SSB+yjVHM563
         mFxkXoVeeSAPwHKPfQIT3xDgUBaXZaPHETEzk+az6N10PWdHCQGzq8buJdhWjFfOjbJt
         kLIxjJCCT7dpp+Gruso8IkTUzZHpRLaw62+s5Liv5cT7G8Eps1Vn3IQj1/7TYqWoephi
         IyomvMQ6/h6ZYFAFAEO/AxcRLfT64GeyxBvVi1HbY3aCHWIr84JIkymWsQFam6JPyEoF
         aH5gxrznJdi5e+PaG74dQMcCJq9OItjCgSrfyYHBcxeW23buyqHwIgY7va3fvY8X3m+U
         +udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949161; x=1754553961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX9GbqVIjmwrvhX5OSfDHPFCq4jInN5mZum+NpNw7Gs=;
        b=pwOWXDz+cgY6gLO7iQ+Yq+uohJ/J63tUVCcoRpunY+OKW+bWVsS8ysKOUrospbAT9p
         qg9uKj2s8a/E6KJSIrpeto0dt88wCmaY9+gRY5Jx9+WPEPYZrZmwTtm1+7YpOGXiKFvE
         ZGL1U+KD08lFiHAzQcOto0wgv+sb3oHNDSKRWSEzOwT75Xn7vXOKiPa2tsLgPJNHFCIk
         pgQcS3cq5zq6SUIySqvz7cisiFoBxgpsn3crBTek3J+tjOm7ZyAY3uKiCc3MTjYnkBse
         lrvJVmZlyYf1Fj67ldkk4CPmxDYLQsR0pBWdyVCpPPzwwvmhE7+84fNj71Hp3N6i0amH
         BnvA==
X-Forwarded-Encrypted: i=1; AJvYcCVdzewUNMsIre3mZIYBZA7uUfS3E6WSYTzk1KvHywHyIY0v2tq/m3MZezA0c0FqGmTcmRQ9mQpG6pQLnmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wbABUlrquPrFzLkgWviR2azyeB6b+XI4Zx2ra8CQW9AqYMfy
	WjAGf8XqjfSridZa1kWuX4m52U4fVVVF4E/Bsgr09avczwjqS0LUFVaSrWrmkl/qKLV44G9xxvO
	YCqdm442D1+9hZ3eZu5q4EyGxmAEnvNhZPPM6Aass
X-Gm-Gg: ASbGncsw0oeM4ZjmXquayBTp6+MKAegfqVOKdyfvE/Ue71cb7QHu7XQxoNx0v50PnO7
	lUR2ES19TZ7pXDjxt+cbUwkRJfKzmqkYziMwktTu1C/YwlgR8THKNyA21kdjgziRX3eqHnSSw9+
	zYAhxT5oukI3y4G/53/QV5vOUhqLj6/jokFAtIEXYJcqVwKId5cJy+Twn5cyKDeNbQ9Okj+LT2r
	DY488q2YmMQj/KTKQ==
X-Google-Smtp-Source: AGHT+IH4yq+cZN4dHwzK7g8E7DSjy0bGu3xiXGytk3StPe2WtxT21gv+bvGK0jCbJI3gRQMQxRtljt9Le12kOsEdiUI=
X-Received: by 2002:a05:622a:1989:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4aeefd25399mr2167431cf.6.1753949160761; Thu, 31 Jul 2025
 01:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-16-seanjc@google.com>
In-Reply-To: <20250729225455.670324-16-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 31 Jul 2025 09:05:24 +0100
X-Gm-Features: Ac12FXyz8RfnHssTX6SapaASSN1w3XZbMdMXGmxSRe7KK501NuRu89FkBwEbo-Y
Message-ID: <CA+EHjTz0g+Fd-893WYA9+WBhvMvbsrXvFtL3OGa8ohC6DdVbdw@mail.gmail.com>
Subject: Re: [PATCH v17 15/24] KVM: x86/mmu: Extend guest_memfd's max mapping
 level to shared mappings
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
> Rework kvm_mmu_max_mapping_level() to consult guest_memfd for all mappings,
> not just private mappings, so that hugepage support plays nice with the
> upcoming support for backing non-private memory with guest_memfd.
>
> In addition to getting the max order from guest_memfd for gmem-only
> memslots, update TDX's hook to effectively ignore shared mappings, as TDX's
> restrictions on page size only apply to Secure EPT mappings.  Do nothing
> for SNP, as RMP restrictions apply to both private and shared memory.
>
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/mmu/mmu.c          | 12 +++++++-----
>  arch/x86/kvm/svm/sev.c          |  2 +-
>  arch/x86/kvm/svm/svm.h          |  4 ++--
>  arch/x86/kvm/vmx/main.c         |  5 +++--
>  arch/x86/kvm/vmx/tdx.c          |  5 ++++-
>  arch/x86/kvm/vmx/x86_ops.h      |  2 +-
>  7 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c0a739bf3829..c56cc54d682a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1922,7 +1922,7 @@ struct kvm_x86_ops {
>         void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>         int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>         void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> -       int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
> +       int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  };
>
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 61eb9f723675..e83d666f32ad 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3302,8 +3302,9 @@ static u8 kvm_max_level_for_order(int order)
>         return PG_LEVEL_4K;
>  }
>
> -static u8 kvm_max_private_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
> -                                       const struct kvm_memory_slot *slot, gfn_t gfn)
> +static u8 kvm_gmem_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
> +                                    const struct kvm_memory_slot *slot, gfn_t gfn,
> +                                    bool is_private)
>  {
>         u8 max_level, coco_level;
>         kvm_pfn_t pfn;
> @@ -3327,7 +3328,7 @@ static u8 kvm_max_private_mapping_level(struct kvm *kvm, struct kvm_page_fault *
>          * restrictions.  A return of '0' means "no additional restrictions", to
>          * allow for using an optional "ret0" static call.
>          */
> -       coco_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn);
> +       coco_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn, is_private);
>         if (coco_level)
>                 max_level = min(max_level, coco_level);
>
> @@ -3361,8 +3362,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>         if (max_level == PG_LEVEL_4K)
>                 return PG_LEVEL_4K;
>
> -       if (is_private)
> -               host_level = kvm_max_private_mapping_level(kvm, fault, slot, gfn);
> +       if (is_private || kvm_memslot_is_gmem_only(slot))
> +               host_level = kvm_gmem_max_mapping_level(kvm, fault, slot, gfn,
> +                                                       is_private);
>         else
>                 host_level = host_pfn_mapping_level(kvm, gfn, slot);
>         return min(host_level, max_level);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index be1c80d79331..807d4b70327a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4947,7 +4947,7 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
>         }
>  }
>
> -int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
>  {
>         int level, rc;
>         bool assigned;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index d84a83ae18a1..70df7c6413cf 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -866,7 +866,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> -int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
> +int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
>  #else
> @@ -895,7 +895,7 @@ static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, in
>         return 0;
>  }
>  static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
> -static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
>  {
>         return 0;
>  }
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index dd7687ef7e2d..bb5f182f6788 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -831,10 +831,11 @@ static int vt_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
>         return tdx_vcpu_ioctl(vcpu, argp);
>  }
>
> -static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
> +                                    bool is_private)
>  {
>         if (is_td(kvm))
> -               return tdx_gmem_max_mapping_level(kvm, pfn);
> +               return tdx_gmem_max_mapping_level(kvm, pfn, is_private);
>
>         return 0;
>  }
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b444714e8e8a..ca9c8ec7dd01 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3318,8 +3318,11 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
>         return ret;
>  }
>
> -int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
>  {
> +       if (!is_private)
> +               return 0;
> +
>         return PG_LEVEL_4K;
>  }
>
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 6037d1708485..4c70f56c57c8 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -153,7 +153,7 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
>  void tdx_flush_tlb_current(struct kvm_vcpu *vcpu);
>  void tdx_flush_tlb_all(struct kvm_vcpu *vcpu);
>  void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
> -int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
> +int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  #endif
>
>  #endif /* __KVM_X86_VMX_X86_OPS_H */
> --
> 2.50.1.552.g942d659e1b-goog
>

