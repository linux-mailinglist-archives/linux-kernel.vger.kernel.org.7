Return-Path: <linux-kernel+bounces-727177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B96B01614
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F25188F3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1F1E1DE7;
	Fri, 11 Jul 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NVM00Gkt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FE1FF61E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222527; cv=none; b=VpeU3jb44/UZq1NZ2bdI1F4MURfhEoNbSxqXLVwp2CD1lnPc34hGxTsBEW5xaKZiX56tmZrXrRiwNQRHF9sTZdFYcxGPb3WklKXeFRRq87NmTh6QbjB1nEBzJWJQy8KakbTuY0aSv4dQlqTCBNs1MQn1qYynh3VqXxhUXRnvQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222527; c=relaxed/simple;
	bh=C63gSTJaFjfjDN2UWFDRtg1QOpvYxMR7H4rF2lT5drI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXFUQmOChOMZiZpAPkFDDlZiiVq+4Vf5Ap5qVNCE6p+2NaKR2wajuxsVhtC2PtqucW35JSatOHmvHS9/LUYAd6vjSZf2xBgvNMdktLYdadXrhoWcNv86iXZs2wLdsAVykM78OQt2p/OCBpdiFrKppkTVlY6/jF54WCK/ytjYSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NVM00Gkt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553dceb342aso1572799e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752222522; x=1752827322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V0DETkdpP2SJ8ZAwZpM11qaGZR3zWsJjRJIwEWhwAQ=;
        b=NVM00GktKXif7zA+3bfsJqNLb36npTdPBOQ7b0L+cwOKTmOEwBQZRarmWdK8DOx1dN
         iAgJ7dtMdvT6/9/Z4iGkcgp2dsN+hKU4qx0fv7km6Ye7YMcleJNUFKp0vSSDJ9/EDdpT
         fe73CtMHhFWI0NGtnVQdc54UVNDee0Tc7DYftlQsLWT/LDLpK+qyDAieSLkTQgTNF9TB
         9+JpuHcf2vdXbWTfzk4LMksJGke/XvEqv9CTm4P7jScizwa0mWHXl1tCvOgoBphUDjs5
         gRKhWwMwRaJcGj1eOziVTVrfCyuRwWiHAdMeZTJUb++5sU+Dn33jOHWGLF9wO6dOwPbl
         2fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222522; x=1752827322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V0DETkdpP2SJ8ZAwZpM11qaGZR3zWsJjRJIwEWhwAQ=;
        b=ZpkyvSOPUFyLVB3poO/URUYEiZpyYenixnXmptgwE5KypeIDbysKJ5HhSLAAcUcagy
         /gDiAhJ8P3JKreTuPVM7FvWybdh9Ef4NRX/J9se02Nk4yGsQlkF/D+kBkfIRw61QsASm
         ECIoFJ63Y5qu03x6gp3k61wEpX+qGJ4gkJulAON/OBn1yljrR3F7lLq5Y7ZOC71bZRyO
         pmPQ9aYaItJMs+tYWVDwSsqGA0dTzZq9PGpZ0KJ6l2udgOe1RRULOll0Hiqvrh+LWOFL
         EV9UIUSXB1UepJYyjCFa1PhNIDTz06iA4u+WCEYxrrMdQuDDKV01NqDHcYmGucrw+yJL
         CzqA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zEeRRq4a/FyRZ8DW4pBhtAkAmx6pZoTpCwqPtx1I/EuYMkP6EBN32UciFrpB11wMwHnm9xpRdnbPlGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EXYjFffuuIxkiwByZf1xuwbrBSViXsNnqE3KTyTYlj9fatha
	4kUcGirDvUil6FZslDkhnRuGKJG+AbNxqF8RDL9ImZcBm0JaZ5GFoA6Im7xYZpPfkLv2XzLE3pr
	2LvfUmAqRzzEq6SUvfNNtmINJDxrgwtldjycLBI0C6w==
X-Gm-Gg: ASbGnctsIp5RkD8u31URF1vOy9bBT4Of0E1vOyvHqrcHk8+1YUYpWYHlnJ+PVdiskDt
	x3ZM/cWMBM01BRLSHLpxHwsgxeDQ3dsITPvU7PK6LY6uF/eXrPppA2GzB6l3+rji1kNl1KBzEWH
	rIXkXTs90ym1fuzuT3p3L7r3eZk9WJoi/o7HEgzvLXT5vkJOdtFJjjockuRvKr1VCKILmI4vgHG
	W3w6BmA/ilNGoscvqE=
X-Google-Smtp-Source: AGHT+IGtSsp8vscJn4tzXANU6jXxzJIchtHLYA0CLdSkilBhXH8dJCPNqfw6YPZF2NmYpG1AnNSZ4hh9Y0QgbqWWiuk=
X-Received: by 2002:a05:6512:3da3:b0:553:268e:5019 with SMTP id
 2adb3069b0e04-55a044c9ba0mr720126e87.11.1752222522119; Fri, 11 Jul 2025
 01:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710133030.88940-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250710133030.88940-1-luxu.kernel@bytedance.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 11 Jul 2025 13:58:29 +0530
X-Gm-Features: Ac12FXwuJjdqyUgP0BGYuxw7gbsx-L955BFg8zTc93L-MwymMDnq-8tfsptw_tg
Message-ID: <CAK9=C2W60a2otfJKucJc_d4=X9YBTep1zSp+wa8E7-kL7tJR0Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Delegate kvm unhandled faults to VS mode
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: rkrcmar@ventanamicro.com, cleger@rivosinc.com, anup@brainfault.org, 
	atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:00=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Delegate faults which are not handled by kvm to VS mode to avoid
> unnecessary traps to HS mode. These faults include illegal instruction
> fault, instruction access fault, load access fault and store access
> fault.
>
> The delegation of illegal instruction fault is particularly important
> to guest applications that use vector instructions frequently. In such
> cases, an illegal instruction fault will be raised when guest user thread
> uses vector instruction the first time and then guest kernel will enable
> user thread to execute following vector instructions.
>
> The fw pmu event counters remain undeleted so that guest can still get
> these events via sbi call. Guest will only see zero count on these
> events and know 'firmware' has delegated these faults.

Currently, we don't delegate illegal instruction faults and various
access faults to Guest because we allow Guest to count PMU
firmware events. Refer, [1] and [2] for past discussions.

[1] http://lists.infradead.org/pipermail/linux-riscv/2024-August/059658.htm=
l
[2] https://lore.kernel.org/all/20241224-kvm_guest_stat-v2-0-08a77ac36b02@r=
ivosinc.com/

I do understand that additional redirection hoop can slow down
lazy enabling of vector state so drop delegating various access
faults.

Regards,
Anup

>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |  4 ++++
>  arch/riscv/kvm/vcpu_exit.c        | 18 ------------------
>  2 files changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 85cfebc32e4cf..e04851cf0115c 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -44,7 +44,11 @@
>  #define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
>
>  #define KVM_HEDELEG_DEFAULT            (BIT(EXC_INST_MISALIGNED) | \
> +                                        BIT(EXC_INST_ACCESS)     | \
> +                                        BIT(EXC_INST_ILLEGAL)    | \
>                                          BIT(EXC_BREAKPOINT)      | \
> +                                        BIT(EXC_LOAD_ACCESS)     | \
> +                                        BIT(EXC_STORE_ACCESS)    | \
>                                          BIT(EXC_SYSCALL)         | \
>                                          BIT(EXC_INST_PAGE_FAULT) | \
>                                          BIT(EXC_LOAD_PAGE_FAULT) | \
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6e0c184127956..6e2302c65e193 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -193,11 +193,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struc=
t kvm_run *run,
>         ret =3D -EFAULT;
>         run->exit_reason =3D KVM_EXIT_UNKNOWN;
>         switch (trap->scause) {
> -       case EXC_INST_ILLEGAL:
> -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ILLEGAL_INSN)=
;
> -               vcpu->stat.instr_illegal_exits++;
> -               ret =3D vcpu_redirect(vcpu, trap);
> -               break;
>         case EXC_LOAD_MISALIGNED:
>                 kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_LO=
AD);
>                 vcpu->stat.load_misaligned_exits++;
> @@ -208,19 +203,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struc=
t kvm_run *run,
>                 vcpu->stat.store_misaligned_exits++;
>                 ret =3D vcpu_redirect(vcpu, trap);
>                 break;
> -       case EXC_LOAD_ACCESS:
> -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_LOAD);
> -               vcpu->stat.load_access_exits++;
> -               ret =3D vcpu_redirect(vcpu, trap);
> -               break;
> -       case EXC_STORE_ACCESS:
> -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_STORE)=
;
> -               vcpu->stat.store_access_exits++;
> -               ret =3D vcpu_redirect(vcpu, trap);
> -               break;
> -       case EXC_INST_ACCESS:
> -               ret =3D vcpu_redirect(vcpu, trap);
> -               break;
>         case EXC_VIRTUAL_INST_FAULT:
>                 if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
>                         ret =3D kvm_riscv_vcpu_virtual_insn(vcpu, run, tr=
ap);
> --
> 2.20.1
>
>

