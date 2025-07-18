Return-Path: <linux-kernel+bounces-736208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A495B09A15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B077B778C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68E1CD1E4;
	Fri, 18 Jul 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1rfweFK"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B717A2E3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808212; cv=none; b=sFGbq/ujY0j0fc4M28MFHH/SEPZFQovu7PMlDBr55mEggAjXYMdi3ojUd5A8riNnMhIHE9cFmpvAIbff9aheqMn6/4YK2Uy4W1iYHg/xO5b/CzqQoFkUnzmRB3DYQCkF+5cY8zagioC6drqseSFlOa+Z01cRroFSOeAyUUwRBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808212; c=relaxed/simple;
	bh=aeguEGMV5/fMC2F0m7bY27BDa9psRNUeE9WLxrQ/MzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgeqSUSicMJ1lld9DdTgrkvhEJuXc752+pRMpomktYeIaGIo24Oux2Oq+IvoOcgF8kIB00kMcrTCGbMhVfcM7SDWRwiYi7HbV0LbLwFhGuApMRHDOmZcWZppscnKFjch9AcnkOrHEnP5LTIZ5e5GxRr7CcIJY1GLy6ufHn7YsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1rfweFK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab60e97cf8so22013721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752808209; x=1753413009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUnATQmYYobkr0MYgQIyd52OrRVnu3RfjT3lUto82y4=;
        b=g1rfweFKrNVeXNg8H5JNZvAzlOeOJ381Z9dmY3KFtftE3S5Nuhx5yRsHzPIsm10rDK
         44bYQca1n3XC0hTTrEuEEvcGYpS9WVl7v9TW9M4IcpjYVRifz087Lftzgi9TX5O5Zh+X
         FDDwLtwuC/AOObN8+MO2J1BM0hcnqie7u3RgT68ScFMnwh+zRQcBo3szUA+RqAhc9axp
         OO8/w8CQh5YTWMpjSkFdbVT5pU/SDlA6IZ3hCi4ScG1mV1h4vRERRBc9MutORhj7IK1Q
         YyZhN9LG/IZMs7nYMsHPzEN1ZjjHkm7zRGCJC/BL3aL5qCU9vrrGSD8MrCTim2tm7Hkt
         t99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808209; x=1753413009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUnATQmYYobkr0MYgQIyd52OrRVnu3RfjT3lUto82y4=;
        b=ertjmxjKgdx8/1nHSoFU2TMEyXVSwOcV7bsvko4mcRXirqJLazbqqaQM/lIJ33SkmT
         BkIp2nSeMn/jzTglHpmwysxtHVgRlH5surgM3nYZICK8wWAvk2IhA6kDSaF2qChMalB5
         Weh5+Mb+yKHH9Djp/dPcQ4mR/NyvP1T/cgUfDISKuDl3c7xtmDC2NupnSmtbGbyjC0NN
         ZmbEANN+DTqNNPVRoAk9CnlRsP7qpZRgHcBHIAgupTy0nhis42YxOR0VbvudCoHo6kn5
         h/oYxzWYKr+0wZv3nu3bhOR+unoh7Q1RH0SKm61gyJ1MoXg7goE+iBQgB2k+WC9t86BU
         3hEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6URzGY5YNYdbGm9bISN6u5D0oTVqJnWkXfkwE19cTTZP+BRtJsg9PEzdpyHiqPcyVFBeAgnSPxkv9uF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+QqD1QLOZrcFzoB6E3Atnmvd+8O5GmHlhYp1LH6al7dc05m4
	o/sDPd3by9kNu0PSO4SKw+5IbPa4r2Af+ZMP56hsZ94CN2P/juzrD5A6nhgI1P4JJO5+XijIZVD
	r3dD++CIZRI28Mh8+bkM9AU287UBy58MghqPxhJo9
X-Gm-Gg: ASbGncsGHHaTdAOQMXeU/pKKVFEvVJlZxdzeVzkeQ+b85EN6/7PmbqMR70NxH7vmtpJ
	z6mYBU+j8O5Ijfplq9LPZKYCs+NA/2rMFefJvkwiPWUku6xLSqJsAryiGLPsgr/Tocqg4da7+aA
	iy7dvY2sJ4j9n4JtsEojmBuUyRIVV/Itqa0lhWb8kGVMt/u0tueO3RaccHxbxM15IvvHjvQcakC
	/lw69oG2RqSgy48UIWC9tssl6JMdtdaADxnZQ==
X-Google-Smtp-Source: AGHT+IEmizUZ5l+X4YotPR6ok+VsIV/wa/slge+11mb+u0FG6qNFqzkdn9s7tPa2hSXOaJivzvOLCrTQRm0bXPo7Ck0=
X-Received: by 2002:a05:622a:a547:b0:4ab:9586:386b with SMTP id
 d75a77b69052e-4ab958658c3mr105183021cf.53.1752808209144; Thu, 17 Jul 2025
 20:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714033649.4024311-1-suleiman@google.com> <20250714033649.4024311-2-suleiman@google.com>
 <CANDhNCp5ovDmFg-DWpDPNYBg-rMYBr0MBhHBaeH1HOiWF+3Cuw@mail.gmail.com>
In-Reply-To: <CANDhNCp5ovDmFg-DWpDPNYBg-rMYBr0MBhHBaeH1HOiWF+3Cuw@mail.gmail.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Fri, 18 Jul 2025 12:09:57 +0900
X-Gm-Features: Ac12FXxgIX2gIfvs_OEi98e62tPYyZVdmSz4mRKC4cKNxbv4NqXYv_JMmjQZeZc
Message-ID: <CABCjUKAT03ficWMg+mkDWev15x+E3YDin1_9VkJBgb4g-F4UmA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] KVM: x86: Advance guest TSC after deep suspend.
To: John Stultz <jstultz@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tzung-Bi Shih <tzungbi@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:43=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Sun, Jul 13, 2025 at 8:37=E2=80=AFPM Suleiman Souhlal <suleiman@google=
.com> wrote:
> >
> > Try to advance guest TSC to current time after suspend when the host
> > TSCs went backwards.
> >
> > This makes the behavior consistent between suspends where host TSC
> > resets and suspends where it doesn't, such as suspend-to-idle, where
> > in the former case if the host TSC resets, the guests' would
> > previously be "frozen" due to KVM's backwards TSC prevention, while
> > in the latter case they would advance.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  3 +++
> >  arch/x86/kvm/x86.c              | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 7b9ccdd99f32..3650a513ba19 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1414,6 +1414,9 @@ struct kvm_arch {
> >         u64 cur_tsc_offset;
> >         u64 cur_tsc_generation;
> >         int nr_vcpus_matched_tsc;
> > +#ifdef CONFIG_X86_64
> > +       bool host_was_suspended;
> > +#endif
> >
> >         u32 default_tsc_khz;
> >         bool user_set_tsc;
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index e21f5f2fe059..6539af701016 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -5035,7 +5035,36 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, i=
nt cpu)
> >
> >         /* Apply any externally detected TSC adjustments (due to suspen=
d) */
> >         if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
> > +#ifdef CONFIG_X86_64
> > +               unsigned long flags;
> > +               struct kvm *kvm;
> > +               bool advance;
> > +               u64 kernel_ns, l1_tsc, offset, tsc_now;
> > +
> > +               kvm =3D vcpu->kvm;
> > +               advance =3D kvm_get_time_and_clockread(&kernel_ns, &tsc=
_now);
> > +               raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags)=
;
> > +               /*
> > +                * Advance the guest's TSC to current time instead of o=
nly
> > +                * preventing it from going backwards, while making sur=
e
> > +                * all the vCPUs use the same offset.
> > +                */
> > +               if (kvm->arch.host_was_suspended && advance) {
> > +                       l1_tsc =3D nsec_to_cycles(vcpu,
> > +                                               kvm->arch.kvmclock_offs=
et + kernel_ns);
> > +                       offset =3D kvm_compute_l1_tsc_offset(vcpu, l1_t=
sc);
> > +                       kvm->arch.cur_tsc_offset =3D offset;
> > +                       kvm_vcpu_write_tsc_offset(vcpu, offset);
> > +               } else if (advance) {
> > +                       kvm_vcpu_write_tsc_offset(vcpu, kvm->arch.cur_t=
sc_offset);
> > +               } else {
> > +                       adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_off=
set_adjustment);
> > +               }
> > +               kvm->arch.host_was_suspended =3D false;
> > +               raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, f=
lags);
> > +#else
> >                 adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adju=
stment);
> > +#endif /* CONFIG_X86_64 */
>
> Just style wise, it seems like renaming adjust_tsc_offset_host() to
> __adjust_tsc_offset_host(), and then moving the ifdefed logic into a
> new adjust_tsc_offset_host() implementation might be cleaner?
> Then you could have:
>
> #ifdef COFNIG_X86_64
> static inline void adjust_tsc_offset_host(...)
> {
> /* added logic above */
> }
> #else
> static inline void adjust_tsc_offset_host(...)
> {
>     __adjust_tsc_offset_host(...);
> }
> #endif
>
> >                 vcpu->arch.tsc_offset_adjustment =3D 0;
> >                 kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> >         }
> > @@ -12729,6 +12758,9 @@ int kvm_arch_enable_virtualization_cpu(void)
> >                                 kvm_make_request(KVM_REQ_MASTERCLOCK_UP=
DATE, vcpu);
> >                         }
> >
> > +#ifdef CONFIG_X86_64
> > +                       kvm->arch.host_was_suspended =3D true;
> > +#endif
>
> Similarly I'd wrap this in a:
>
> #ifdef CONFIG_x86_64
> static inline void kvm_set_host_was_suspended(*kvm)
> {
>     kvm->arch.host_was_suspended =3D true;
> }
> #else
> static inline void kvm_set_host_was_suspended(*kvm)
> {
> }
> #endif
>
> then call kvm_set_host_was_suspended(kvm) unconditionally in the logic ab=
ove.

Thanks for the good suggestions. I'll incorporate them into v8.

-- Suleiman

