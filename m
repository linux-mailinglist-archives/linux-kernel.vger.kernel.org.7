Return-Path: <linux-kernel+bounces-781688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D3B31590
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E06AAA106E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524912F5469;
	Fri, 22 Aug 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="IPNhGFuT"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B422F49F8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858783; cv=none; b=Vqa4jNHZ1AMFsV/6lfndxMUokjyG4/LVK0eJ//PBngrKe0ITwPibOw+aRIN5inE5ztoIwxa2LmcabsiUWDEczmsJ/a8p+cnBlhaz5jhPAjcBsL1vGSkFLh2bjdhC6MMp+kw5hUqazO2f9LBNxK2Pu54oEchKZcAI77kkPeTsUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858783; c=relaxed/simple;
	bh=CU41YE7iOuiEUBXAR1fHUTzQP9FmIAESCXuQePsKguE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oakf6xg0tpsfhFiIgoGtMU4BzobzTDnG6qysX8j3QZZGJhuctLRHTau5yjb8Hf/C7RzJwVriyC4ue/kmHyLuVm5K2jtsM4+i6T9t3ZKqTyJw6vxmV2HKnfcSTif648fk+hkIkB8efWp364BrUbx3X4hW2wv4ei7APKFITRYG0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=IPNhGFuT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88432dc61d8so172761539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1755858781; x=1756463581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpW5veLMLPdr6OKMte0tGA4PuK4ym/yIcC2Y9SUMkpQ=;
        b=IPNhGFuTvwlRZDywjyRsnBvCuYN04DJDwRFCCA/GWupO12Cj2rOTNw8Sysg1wxPxM+
         p2Z94UVD+Y3eQ5Zm2KfanHUdHBVRj2+3rH39/wk0kkyZTTN8KCmJmiRCVr3G53VCZLm1
         OHnTaVpqxBGFEqAjx/UFvH3MhVQMM/rA+09377gL8fNNJqb+8Ga6tN3FmSNYgxTrdc61
         lYvZRRJyiur+tFnt8kLBc9CeIHg5pz/f+XiVuIpAdRYmk/QpcS0qKXgydUeCKy22Ge3L
         KG4D3YwM0JVfiqol5UyvQl6eUlgBwUCeNz7fogCnr0N3GaHVJFwJHMVI7qKDnc/bZvwP
         whvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858781; x=1756463581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpW5veLMLPdr6OKMte0tGA4PuK4ym/yIcC2Y9SUMkpQ=;
        b=AQPxCC9UCDn9kgZqNzbNzevY/pzhzjFk3ydDN/cA0bEb3ynnbwxsA9D9LsMvUnEX+z
         dqSZ9qz9I+0Mk93mnZsoDu8d+KkNbVXZBON/4EpdydGCNqo8yVCeBT0WqnPWsQAShymJ
         hZJpyuNLLzlgzWpBcp7yW3XeZ67evawd+yglpGqEvnUCavVS2YoWRbTRXvFn8RoL0Cn4
         SQsNkb3EfyPQLHj1OvMF+wv//hzPzm1oIiitfhA21OJLkZBTXG4Z9O9K4S+YpfYub0g7
         Q9TwwkK6hnAckVnwG1Hl9BbhMAahpHWCgRh3vC7tTu3/7PdcBcJpnib+2j8J34I55bQY
         V06w==
X-Forwarded-Encrypted: i=1; AJvYcCVEqa5oB/13Fy1RpTq3eNbQmX1t9wMnb7/uXag2F22/h1d6uesD+40H3HCbG+F1kcfqbnVh7Bw5yvdxVy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVFCt7O08OVBl2kZEHvl5eaK6r2f/b1VDm3DCAUwxR6a3jdjm
	mIr7A9sEMLZp4YoQmtdDR4ERMWIJMhlOhYm12MQ6TYkfupo8uBKy5xFnLUxY9cM47AIHDbYr7JY
	ja+GjYsAQBqNjgW4+NuHNCq0uL8gwGlqQmt32E7tW6A==
X-Gm-Gg: ASbGncseylPDX6ymEU6sptjtMfEy23ORRFlBjCEIIOI1ZO0OJJ+ALiSSe3xVeKTS6d6
	fSwgAk7G5N6v7J5WOlDeiacmeKfXOMLyQjV7KD1rh0mpebyQaSiZ9i9g8n9FakbodZC5lcA5GP/
	1q3CaoTBMMXj5qitWz1MErMcKy1LLRXD6scI4HGFi4akwdg1JxxCurThrWwODhCBguMhgzVQ8cK
	IX0hQyG
X-Google-Smtp-Source: AGHT+IFxa3sIYy8GmbrliB9vOURhQsISjHNbjP8q123c5R9HRTAMf+tU9qbPOd1N7VsCfi+G9RwFcCmvT1G6Qpsac28=
X-Received: by 2002:a05:6e02:1607:b0:3e3:fd25:f6a with SMTP id
 e9e14a558f8ab-3e921a5c447mr39155945ab.11.1755858780756; Fri, 22 Aug 2025
 03:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com> <20250806195706.1650976-17-seanjc@google.com>
In-Reply-To: <20250806195706.1650976-17-seanjc@google.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Aug 2025 16:02:49 +0530
X-Gm-Features: Ac12FXz94_OmeQku-x70DMZyHIHAiBydPtfIxKmb7IUME7_u-QmNy8EiX87dBF4
Message-ID: <CAAhSdy3Ee1K7kfwFUhdcjoe+c4oi06Tm+Jo7CE2ycqHjuBou-A@mail.gmail.com>
Subject: Re: [PATCH v5 16/44] KVM: Add a simplified wrapper for registering
 perf callbacks
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Mingwei Zhang <mizhang@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 1:27=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Add a parameter-less API for registering perf callbacks in anticipation o=
f
> introducing another x86-only parameter for handling mediated PMU PMIs.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/arm64/kvm/arm.c      |  2 +-
>  arch/loongarch/kvm/main.c |  2 +-
>  arch/riscv/kvm/main.c     |  2 +-
>  arch/x86/kvm/x86.c        |  2 +-
>  include/linux/kvm_host.h  | 11 +++++++++--
>  virt/kvm/kvm_main.c       |  5 +++--
>  6 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 888f7c7abf54..6c604b5214f2 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2328,7 +2328,7 @@ static int __init init_subsystems(void)
>         if (err)
>                 goto out;
>
> -       kvm_register_perf_callbacks(NULL);
> +       kvm_register_perf_callbacks();
>
>  out:
>         if (err)
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 80ea63d465b8..f62326fe29fa 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -394,7 +394,7 @@ static int kvm_loongarch_env_init(void)
>         }
>
>         kvm_init_gcsr_flag();
> -       kvm_register_perf_callbacks(NULL);
> +       kvm_register_perf_callbacks();
>
>         /* Register LoongArch IPI interrupt controller interface. */
>         ret =3D kvm_loongarch_register_ipi_device();
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 67c876de74ef..cbe842c2f615 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -159,7 +159,7 @@ static int __init riscv_kvm_init(void)
>                 kvm_info("AIA available with %d guest external interrupts=
\n",
>                          kvm_riscv_aia_nr_hgei);
>
> -       kvm_register_perf_callbacks(NULL);
> +       kvm_register_perf_callbacks();
>
>         rc =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>         if (rc) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5af2c5aed0f2..d80bbd5e0859 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9689,7 +9689,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *op=
s)
>                 set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
>  #endif
>
> -       kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
> +       __kvm_register_perf_callbacks(ops->handle_intel_pt_intr, NULL);
>
>         if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled)
>                 kvm_caps.supported_vm_types |=3D BIT(KVM_X86_SW_PROTECTED=
_VM);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 15656b7fba6c..20c50eaa0089 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1731,10 +1731,17 @@ static inline bool kvm_arch_intc_initialized(stru=
ct kvm *kvm)
>  #ifdef CONFIG_GUEST_PERF_EVENTS
>  unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu);
>
> -void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void));
> +void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void)=
,
> +                                  void (*mediated_pmi_handler)(void));
> +
> +static inline void kvm_register_perf_callbacks(void)
> +{
> +       __kvm_register_perf_callbacks(NULL, NULL);
> +}
> +
>  void kvm_unregister_perf_callbacks(void);
>  #else
> -static inline void kvm_register_perf_callbacks(void *ign) {}
> +static inline void kvm_register_perf_callbacks(void) {}
>  static inline void kvm_unregister_perf_callbacks(void) {}
>  #endif /* CONFIG_GUEST_PERF_EVENTS */
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ecafab2e17d9..d477a7fda0ae 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -6429,10 +6429,11 @@ static struct perf_guest_info_callbacks kvm_guest=
_cbs =3D {
>         .handle_mediated_pmi    =3D NULL,
>  };
>
> -void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void))
> +void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void)=
,
> +                                  void (*mediated_pmi_handler)(void))
>  {
>         kvm_guest_cbs.handle_intel_pt_intr =3D pt_intr_handler;
> -       kvm_guest_cbs.handle_mediated_pmi =3D NULL;
> +       kvm_guest_cbs.handle_mediated_pmi =3D mediated_pmi_handler;
>
>         perf_register_guest_info_callbacks(&kvm_guest_cbs);
>  }
> --
> 2.50.1.565.gc32cd1483b-goog
>

