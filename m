Return-Path: <linux-kernel+bounces-729579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C151FB0389E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2045A188F872
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451E23958A;
	Mon, 14 Jul 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="tL3yj00f"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0E1E32C3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480253; cv=none; b=cT5lKZLd3LrB6Ddv3pG3e/KuYi9Y/ONWoeY18eBr3sq8SUa2bi5dRJ5UepZ0j48MHl+Ap7Y2DJX/fc72fK2APc8GnvV1OxiZGO6w80iQqkoz2J+uhRgcJayNaSEkxtZ8sW7lDvIkmGx+dfIi9mjNMweJucGcLGw6r0bC9AcyG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480253; c=relaxed/simple;
	bh=f+o9WVDsyRj3e9aXVc3KN67EOFIQrJYY2xIcE0eTzEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEq7fdti8TuSo55bFV6GEyAgfkZSHRvSzbUO7pju8fTjlxkYAd5OyKW+Dc0nz3p70LvXyahgpaUj4htB+ESuDvoG7Pfe5mpyr2EJtfx69BNM2vRyea5BwDDjxXoLsVQahSYUtMpkA1sW6bOu4AAB/w/88wGTW8RxM2wwXDM7KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=tL3yj00f; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3df4bdadca5so15675885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752480251; x=1753085051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZgIQGeH6iTe1iCoPtim6lSFnAFbmo2QUEBDo1A3JBQ=;
        b=tL3yj00fNL/H6AzWzxrsDV+69GuYO5036L104qSA1sZJ4oBiXtvJbLiygI6YkPtswg
         l4MJCXCegnoTrBEaYin6YCFVnEhMVEuLUZ3bd0/7LfjdBTTgciZ5Tu+AcgtgAbaV8U1J
         ZAxLf+RB+g5DK1+UYedfK8/yixClNC5whozruCCu8S0TZhYqUTJfYslvrrrm3hahfju3
         f2giv9mU8Q0Ivo9AqHbsdgvVQ+dqh9SV1zHnj5IeHrRQ/jGpIl+foybYCo7ow7S2/whs
         Xtzzx1B+TpAmLnUaIR6AjtnWqm7E0q0luSIhAFBMDaFI7NKkoOrsgRiyMTfwuCT1cm3n
         it6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480251; x=1753085051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZgIQGeH6iTe1iCoPtim6lSFnAFbmo2QUEBDo1A3JBQ=;
        b=KFScgc0PR1+ogYqpg9ONJtl6KaU4o/VeFW7e6REy720vQ9mPHCEbmzSVEA9upmGb28
         J59jIU7XUsTvpjHf5p0j/IR1W1lrUSHsCUxNORel7CEiZoiPCr+k5oSh6GrhYCh0xSj6
         U3M2K7dL4OpN5FMELX84IpwZwRfwk2PM4tI5aUVlW9sGAOasVcryCIrFMhphF6faw+v8
         2khwrIvz346+pGLteYInbd9IC9ureCSW6izEP0ySL5LZX3IJsaNj9EMkUChY+u1pA3Ly
         NCrBajMz4kJQFvDyVUyu6bkpDCLxa+gP3FakXX1leKAjmwabBcJq+E4xSqRhXRzyMEOA
         goGg==
X-Forwarded-Encrypted: i=1; AJvYcCUqbG+MAOSQJ3PhL+P6hTn5J4EIRwucnXpnGOcnD6aqxMFoPm2s3q5yZVC7fwnJT9zVhyhPpDVzGZQcvLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RdT/7FfOOoFhHXhlfvNJXK+aFo50JaxvTxIsZkgq28/U3Fhq
	Z4XPrYnmWqlOcnxSgWjKh5TLV2kadr4QKNpOFmbEeSWmM5nPnSEp0sAhDadZLREiobNge5Dvf35
	8K/3K2iEz6s4EhNdU5MMPbaAcepi5lKsvlpYDX9exuw==
X-Gm-Gg: ASbGncvMTNRUee7YZw/HZSVRdjFNptHWS72RhRvSAvSXLryHtekh+bcUjBsJr5hoo3N
	RZinBduNIjIJgcEK0A6vxOsBnGyx9tF+iLKbnrT3tkOVQiTnmR27mA5FAsYGy9cpSQBvYgZxtkA
	PUYy6XL4cKR1oEDEInOMMDB+IZKRcocMmFtMQ3wYGp/LQ1ItS3JvtIlKbzO9kygRKTSzeYWpHQu
	NZkzrjUkh0k9qiPRNI=
X-Google-Smtp-Source: AGHT+IFRHVQzoAt1qKkfWgKOuTxoczx2KhtXwBF+kniHBzyY3kBO8gLSgMJy+LXX+IM1zlPXQQUK731W+/4cNca4pWM=
X-Received: by 2002:a05:6e02:304a:b0:3df:4046:93a9 with SMTP id
 e9e14a558f8ab-3e25325550bmr122893985ab.5.1752480250607; Mon, 14 Jul 2025
 01:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711101537.16308-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250711101537.16308-1-luxu.kernel@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 14 Jul 2025 13:33:59 +0530
X-Gm-Features: Ac12FXxof_i54yoTN6sBpKdXuMFJfg4CBnTxqLczo_oXcUYHd6dY56mBe6MespY
Message-ID: <CAAhSdy0OumSXbJEEafE6q-LPu2PTdN9Tzx_aoapy=RJD214uBw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Delegate illegal instruction fault to VS mode
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: rkrcmar@ventanamicro.com, cleger@rivosinc.com, atish.patra@linux.dev, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:45=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Delegate illegal instruction fault to VS mode in default to avoid such

s/in default/by default/

> exceptions being trapped to HS and redirected back to VS.
>
> The delegation of illegal instruction fault is particularly important
> to guest applications that use vector instructions frequently. In such
> cases, an illegal instruction fault will be raised when guest user thread
> uses vector instruction the first time and then guest kernel will enable
> user thread to execute following vector instructions.
>
> The fw pmu event counter remains undeleted so that guest can still query
> illegal instruction events via sbi call. Guest will only see zero count
> on illegal instruction faults and know 'firmware' has delegated it.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/vcpu_exit.c        | 5 -----
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 85cfebc32e4cf..3f6b9270f366a 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -44,6 +44,7 @@
>  #define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
>
>  #define KVM_HEDELEG_DEFAULT            (BIT(EXC_INST_MISALIGNED) | \
> +                                        BIT(EXC_INST_ILLEGAL)     | \
>                                          BIT(EXC_BREAKPOINT)      | \
>                                          BIT(EXC_SYSCALL)         | \
>                                          BIT(EXC_INST_PAGE_FAULT) | \
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6e0c184127956..cd8fa68f3642c 100644
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

Lets keep the illegal instruction trap handling so that if SBI implementati=
on
forwards VS-mode illegal instruction trap to HS-mode ignoring hedeleg
due to unknown reasons then we still forward this trap to Guest otherwise
such an illegal instruction trap will cause exit to user-space and eventual=
ly
kill the Guest.

>         case EXC_LOAD_MISALIGNED:
>                 kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_LO=
AD);
>                 vcpu->stat.load_misaligned_exits++;
> --
> 2.20.1
>

Regards,
Anup

