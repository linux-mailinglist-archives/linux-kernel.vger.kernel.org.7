Return-Path: <linux-kernel+bounces-837895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7828BADFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9173AC25D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812403081D3;
	Tue, 30 Sep 2025 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GH0GHCLo"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D11B425C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248181; cv=none; b=tPVSrncO5rVg0fJUJPVgUEuf59dC1CHBq3zm15MWIAvcm+oaeNmSPGec9gdPzdSwzD7JMwmEocJQN7aHB4cYaKa/91mHZ1a2bylcERVVQMVUKF5NQVnklWQ2e1Rg9DhmbqnRB09Flcv5nUG0UrlY4qDO4XFGT3MMC+Hg/ZIBEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248181; c=relaxed/simple;
	bh=4H5ivC42iGboDlNRg/jHLDzngsG9MUAp1XZj1FGUAa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSV8Yey6Gt2BAizIoQQl1bBuOJu/K2dh+sNXrG9wxa4/Lux3j0qJZfDcECtRf3lWLLZUgEVtkHTARXR0hGlxTWW9Gc/KurYOWqWh2rYbx9saIaS43qzxGAig/Dj3xGrHWZeYxSiI2WooAz0FLGaOqrHSjPBjiAazJ6oXoI07UCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GH0GHCLo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso10390a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759248178; x=1759852978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR5yab+3mAkkpNkpm+p0JIJ5oTzrX6iWyN4NvUKvqJQ=;
        b=GH0GHCLoXMFKsxIAkxuZO6FOnTDrL/IK5jLXL/Gi2yPnrmpXSBTRE8TzKnwAmEJWM3
         ZIWlnbokXlHlPyJsPyPA966kM8RkKGp+fqNHo0dl/J+UX6TZaVTitdPuRZysfl1YwvCL
         hUbXa6Fc7PK8dlBS65Tfh3JDF2Xt0I41ZDNE4EqYG5ZKGSQY9JihcZjsyea5Cwr8x1AO
         q2faBgImRG42eHiHaUMVk/zn/n+PYcQwrmq6wPPiSPDIx8//OGqe2VcMi7WtBSongK7p
         ojbtAoI/IZGhNZa8R3Tz8hczM/Zdtjtg+zdtsubZIfCFXetTma5cwdAHURVUc4KfJlCk
         Fovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248178; x=1759852978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR5yab+3mAkkpNkpm+p0JIJ5oTzrX6iWyN4NvUKvqJQ=;
        b=sf1vk+HVDAUnNhy1AUhzrznqKDEITga3TsPtvpc3SkmBQMVVovWETRBF+rzltSfCDi
         q8NrMDt57tNQLra1Lv1cX62t2y1fLbfTq3xqwObeqo0rp0WBGMmrKiMikmcPHxJLgsRD
         kmUIDH0X3FamQ5kV1xbwpO4ebRO+KW3wzysobcmIFd2Zpa6xbwiqR9p57U4xLNa5vf5L
         hthw/ILgvijadOL3sanqeHevQvcRXyCGaJ4hNRIa31VAy/3gXV4+Lvvpz82Di0/lu+QF
         lX7ODWg2L97mgtcPOONJJjOfoKO8ro+LGPUq532uVC41ozLQNBmdsRDManIfCD9OKzMb
         PPrg==
X-Forwarded-Encrypted: i=1; AJvYcCUV99EyPdyntwE2NFPCLPqySIrKGiU3nuX4d6gvrLzK1/Ez3+15fGjxsUQkYsqDbZsEHRg272bzh2r+hKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Qt0zLKQxiNpY17w4J6hSsa0vxWit10KYgjOLIhmaUvY08DQN
	6M5pZj/GVHYTGrgVrrZX6wEs0NSeRO7BIMJEU8qqUbpew1aKQO8eHXiUxmdWz0/m3psQi0/rs23
	8ZOTZkb+No5TXmjBbVH3281Loulg4o/rbs3zc483/
X-Gm-Gg: ASbGncvZGrA7pf3fMfSPUezLMOsXmiSAc9zo/rUk0n8iLOS57ePLecIKjJ5YUVt6rem
	UJBddPrgTBAwRpdWJkdFTwo3J587L0y5dMAMFmHkQnPA3syXHAc9cz8sfw6LKUhdUfRZrNvoNe0
	n7P6fPNLBB4QDkddfDGiAWeUqm7MwsyIyJgMAswEYroQrCqHJ3w43r+eiqP3d6BIUzVt6bLKQw6
	mcOs3XIwSniO/RV2Umvsfp2OSeDb7QCfs6gnA==
X-Google-Smtp-Source: AGHT+IEZWtOBTyXxKQjDwzpjK2LyMs7bA8jlsXe9Xl8JwVi3T41PbSt+fNwdwvHnDfT8He10nUD1XufbqjenFQKFYl4=
X-Received: by 2002:a50:9ee6:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-6366271cc53mr107133a12.7.1759248178006; Tue, 30 Sep 2025
 09:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925202937.2734175-1-jmattson@google.com> <byqww7zx55qgtbauqmrqzyz4vwcwojhxguqskv4oezmish6vub@iwe62secbobm>
In-Reply-To: <byqww7zx55qgtbauqmrqzyz4vwcwojhxguqskv4oezmish6vub@iwe62secbobm>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 30 Sep 2025 09:02:46 -0700
X-Gm-Features: AS18NWCnJZ79ywsz3z1Wbi6tNHrDbksEtFYiwoRGwI8KWHvUE878xEuUFS3ZcU0
Message-ID: <CALMp9eRvf54jCrmWXH_WDZwB7KJcM3DLtPubvDibAUKj7-=yyg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Advertise EferLmsleUnsupported to userspace
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	"Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:31=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Thu, Sep 25, 2025 at 01:29:18PM -0700, Jim Mattson wrote:
> > CPUID.80000008H:EBX.EferLmsleUnsupported[bit 20] is a defeature
> > bit. When this bit is clear, EFER.LMSLE is supported. When this bit is
> > set, EFER.LMLSE is unsupported. KVM has never supported EFER.LMSLE, so
> > it cannot support a 0-setting of this bit.
> >
> > Set the bit in KVM_GET_SUPPORTED_CPUID to advertise the unavailability
> > of EFER.LMSLE to userspace.
>
> It seems like KVM allows setting EFER.LMSLE when nested SVM is enabled:
> https://elixir.bootlin.com/linux/v6.17/source/arch/x86/kvm/svm/svm.c#L535=
4
>
> It goes back to commit eec4b140c924 ("KVM: SVM: Allow EFER.LMSLE to be
> set with nested svm"), the commit log says it was needed for the SLES11
> version of Xen 4.0 to boot with nested SVM. Maybe that's no longer the
> case.
>
> Should KVM advertise EferLmsleUnsupported if it allows setting
> EFER.LMSLE in some cases?

I don't think KVM should allow setting the bit if it's not going to
actually implement long mode segment limits. That seems like a
security issue. The L1 hypervisor thinks that the L2 guest will not be
able to access memory above the segment limit, but if there are no
segment limit checks, then L2 will be able to access that memory.

It should be possible for KVM to implement long mode segment limits on
hardware that supports the feature, but offering the feature on
hardware that doesn't support it is infeasible.

Do we really want to implement long mode segment limits in KVM, given
that modern CPUs don't support the feature?

> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  arch/x86/kvm/cpuid.c               | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index 751ca35386b0..f9b593721917 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -338,6 +338,7 @@
> >  #define X86_FEATURE_AMD_STIBP                (13*32+15) /* Single Thre=
ad Indirect Branch Predictors */
> >  #define X86_FEATURE_AMD_STIBP_ALWAYS_ON      (13*32+17) /* Single Thre=
ad Indirect Branch Predictors always-on preferred */
> >  #define X86_FEATURE_AMD_IBRS_SAME_MODE       (13*32+19) /* Indirect Br=
anch Restricted Speculation same mode protection*/
> > +#define X86_FEATURE_EFER_LMSLE_MBZ   (13*32+20) /* EFER.LMSLE must be =
zero */
> >  #define X86_FEATURE_AMD_PPIN         (13*32+23) /* "amd_ppin" Protecte=
d Processor Inventory Number */
> >  #define X86_FEATURE_AMD_SSBD         (13*32+24) /* Speculative Store B=
ypass Disable */
> >  #define X86_FEATURE_VIRT_SSBD                (13*32+25) /* "virt_ssbd"=
 Virtualized Speculative Store Bypass Disable */
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index e2836a255b16..e0426e057774 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -1096,6 +1096,7 @@ void kvm_set_cpu_caps(void)
> >               F(AMD_STIBP),
> >               F(AMD_STIBP_ALWAYS_ON),
> >               F(AMD_IBRS_SAME_MODE),
> > +             EMULATED_F(EFER_LMSLE_MBZ),
> >               F(AMD_PSFD),
> >               F(AMD_IBPB_RET),
> >       );
> > --
> > 2.51.0.570.gb178f27e6d-goog
> >

