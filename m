Return-Path: <linux-kernel+bounces-735959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58449B095E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3093DA44B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FCA225A39;
	Thu, 17 Jul 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="su0tjRDp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2722370C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785006; cv=none; b=dn4BmzPLWWJA//+Ypj+pDR6Sg8YyYjcFh1bHLrrb6muFiKcsdyvaK4s/AjGBaHV0OVsMFvJZ6tHxT4tKSSNrCzabn4EaJ4oJZMJ6ClIC5rJJf13voAVz0uOIyXRC4IU5EWFSU1WIRztHF8RzCVRtT/mRTm0mzMMmYAvjosJwWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785006; c=relaxed/simple;
	bh=r0oMkv3OMfB5/+73UptezlQrHtmfzQYUnJiDVo4LFQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psV+wkNWbqDF8nKvY/yj6rGRoQAsZg14PYvIvhU02z6F5KHCzOlEv1HenSNi7CnpTohdMQaM/CkBZQCyeVaIRwaSX56CIQ2rU0n8vv1n0cl+X+msttYExdEVXuL6W2bE1ZplteOT5d91yhCUrKU2NB3w+QOMgFJsX6ToI/YPlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=su0tjRDp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553c31542b1so1226487e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752785003; x=1753389803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGMN5UTJKcHxRHTgA7W5UA3KAEyLNTKya3uMYL5K6U4=;
        b=su0tjRDpuXIzt67wdleEy1/P4N+td20o++K5FqXt3RRt44zhLmw4PXWSdxjuulmVtb
         wHVZhmKQxggsR9J3FAmuaa0UZ2MrPXSGLt5RLDputUkyWWLC92frJjiNLwc8VJQcBz5t
         nLQvCF/ihepCTTVV9t/IMmE/2YOhNThFNIsHsnHowElcN/OFJAGRB/Mqy2455GvX+/Fp
         Lv6WSKhU421zwKplXBjW1TugiB2Wr/BnwQXErU7dBFVmAdkbU1IgqMNrxkd+8HF1DD9F
         RGjQGDmLk85m9UdPH5NiVfwhsNKCRO3VhVyRzuV4xmM3yG/m23homeOApqvaMS++8LEk
         eEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785003; x=1753389803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGMN5UTJKcHxRHTgA7W5UA3KAEyLNTKya3uMYL5K6U4=;
        b=fUVIZVniPn0uoXOKrOQY3RvrnqGkwf7MlLUYZpP9FLYOcnHsYJjiDlZhlsF3gLIdAq
         DeP4mnL1bEFwgOalkHzTvQksg0jyCNGwev/xCCaGOgJk+hlvDmouHVzpugSU6YIegY0c
         LX5ZahfZgL7IoAMXvh1DaMIeye7v0XDV0eAY0jtoOuD6IpTTaHbwwYLNJrzPzTzscDxH
         eBYiaHnXzJd54q6WQNaTOQ8TalIf9MVCeMMazZfTPGraTgokwRvI6ym7pFMM16CmmTkC
         sv2Im3ezuJD8sni0iBv8NCryszUsG6jrQC6Mk7HJmMrFv5M0axVxeSTbjeviMtrPBI2z
         /iBg==
X-Forwarded-Encrypted: i=1; AJvYcCU11BGge65B8LNQtIm1GZc/Btvf0lcR+THXmy1zw9sdzyeGyAv9Uis8gc3tpOETAP+/1gRsOqsTCHKKoNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcEmYr5Frdt0uOp+GSfPlr7mAmusqMr8VtfuvPpBxWgLyfBcO
	v6Cd3s9xzUuGWK1IqgTWoTHdEtpOn6YDXQkz6Nt+gLI3h35/kSJrr1ls6lKNXFEDLbr90NGr1Wy
	QKrA4wpVFym+KLSP1NEku7J0115ZiT6lPUcVTzKk=
X-Gm-Gg: ASbGncsRsVv+m+f1H8hs6YeD18lV1S4aGdggTS+tpIfX3H7b1/BFMGk/l1SA3zdJxL4
	xf+DJYyFROR2cHN2lnJxY69LkGGmMILjBT5F4OczFx0jI5J31q6O/TMh7MS1fTz568lt4Q1K6tI
	Nm/T4mqETbq6dcEEic6mvcNR6WTy+JR4/kV8aefSJm4xnPJEU9FQt40FmnSViMcTF9OmGjSn21H
	nN+IhdNRQeTUJRuDA3Q4h8ylyZtw+guhPjG7yCFKuHvM1Q=
X-Google-Smtp-Source: AGHT+IGVVPB9kHQbtlixUOjG0Y7Hw8kpk+hQH06fsz+qrgKiUjTZ5R46WTJyRShUXNf62AA4Mjn8RyKHMX9D8NeXXKA=
X-Received: by 2002:ac2:4c48:0:b0:540:2fd2:6c87 with SMTP id
 2adb3069b0e04-55a23ef9ac5mr2872704e87.16.1752785002907; Thu, 17 Jul 2025
 13:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714033649.4024311-1-suleiman@google.com> <20250714033649.4024311-2-suleiman@google.com>
In-Reply-To: <20250714033649.4024311-2-suleiman@google.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 17 Jul 2025 13:43:10 -0700
X-Gm-Features: Ac12FXzR_Ma-qJwExwNKytyrLvhKN8tppDYEJdJuvjDHEomuW7gmv3ZocILl3I4
Message-ID: <CANDhNCp5ovDmFg-DWpDPNYBg-rMYBr0MBhHBaeH1HOiWF+3Cuw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] KVM: x86: Advance guest TSC after deep suspend.
To: Suleiman Souhlal <suleiman@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tzung-Bi Shih <tzungbi@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 8:37=E2=80=AFPM Suleiman Souhlal <suleiman@google.c=
om> wrote:
>
> Try to advance guest TSC to current time after suspend when the host
> TSCs went backwards.
>
> This makes the behavior consistent between suspends where host TSC
> resets and suspends where it doesn't, such as suspend-to-idle, where
> in the former case if the host TSC resets, the guests' would
> previously be "frozen" due to KVM's backwards TSC prevention, while
> in the latter case they would advance.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/x86.c              | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 7b9ccdd99f32..3650a513ba19 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1414,6 +1414,9 @@ struct kvm_arch {
>         u64 cur_tsc_offset;
>         u64 cur_tsc_generation;
>         int nr_vcpus_matched_tsc;
> +#ifdef CONFIG_X86_64
> +       bool host_was_suspended;
> +#endif
>
>         u32 default_tsc_khz;
>         bool user_set_tsc;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e21f5f2fe059..6539af701016 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5035,7 +5035,36 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int=
 cpu)
>
>         /* Apply any externally detected TSC adjustments (due to suspend)=
 */
>         if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
> +#ifdef CONFIG_X86_64
> +               unsigned long flags;
> +               struct kvm *kvm;
> +               bool advance;
> +               u64 kernel_ns, l1_tsc, offset, tsc_now;
> +
> +               kvm =3D vcpu->kvm;
> +               advance =3D kvm_get_time_and_clockread(&kernel_ns, &tsc_n=
ow);
> +               raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +               /*
> +                * Advance the guest's TSC to current time instead of onl=
y
> +                * preventing it from going backwards, while making sure
> +                * all the vCPUs use the same offset.
> +                */
> +               if (kvm->arch.host_was_suspended && advance) {
> +                       l1_tsc =3D nsec_to_cycles(vcpu,
> +                                               kvm->arch.kvmclock_offset=
 + kernel_ns);
> +                       offset =3D kvm_compute_l1_tsc_offset(vcpu, l1_tsc=
);
> +                       kvm->arch.cur_tsc_offset =3D offset;
> +                       kvm_vcpu_write_tsc_offset(vcpu, offset);
> +               } else if (advance) {
> +                       kvm_vcpu_write_tsc_offset(vcpu, kvm->arch.cur_tsc=
_offset);
> +               } else {
> +                       adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offse=
t_adjustment);
> +               }
> +               kvm->arch.host_was_suspended =3D false;
> +               raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, fla=
gs);
> +#else
>                 adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adjust=
ment);
> +#endif /* CONFIG_X86_64 */

Just style wise, it seems like renaming adjust_tsc_offset_host() to
__adjust_tsc_offset_host(), and then moving the ifdefed logic into a
new adjust_tsc_offset_host() implementation might be cleaner?
Then you could have:

#ifdef COFNIG_X86_64
static inline void adjust_tsc_offset_host(...)
{
/* added logic above */
}
#else
static inline void adjust_tsc_offset_host(...)
{
    __adjust_tsc_offset_host(...);
}
#endif

>                 vcpu->arch.tsc_offset_adjustment =3D 0;
>                 kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
>         }
> @@ -12729,6 +12758,9 @@ int kvm_arch_enable_virtualization_cpu(void)
>                                 kvm_make_request(KVM_REQ_MASTERCLOCK_UPDA=
TE, vcpu);
>                         }
>
> +#ifdef CONFIG_X86_64
> +                       kvm->arch.host_was_suspended =3D true;
> +#endif

Similarly I'd wrap this in a:

#ifdef CONFIG_x86_64
static inline void kvm_set_host_was_suspended(*kvm)
{
    kvm->arch.host_was_suspended =3D true;
}
#else
static inline void kvm_set_host_was_suspended(*kvm)
{
}
#endif

then call kvm_set_host_was_suspended(kvm) unconditionally in the logic abov=
e.

thanks
-john

