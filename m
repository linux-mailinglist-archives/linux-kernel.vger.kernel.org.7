Return-Path: <linux-kernel+bounces-887863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF668C3942C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077653BA956
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94502DC771;
	Thu,  6 Nov 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="h/VX9yxP"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4325A2B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409912; cv=none; b=HBXiZZ+dfZZjfixMU4lUxiVZvHpIK02sf/T94x/aF8sY5KAXdmr4MsGOnGB4jKPwVrM/6/lANy0RAcYPTvQUFFT49rB4sfFyh3oSJ3AskK4xiB8f1q7a/u/4i2H+2ebLXAD/Or15dajz9eOes29MePMjh0+V9mnqJ0BbTZ6MXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409912; c=relaxed/simple;
	bh=aKe4/0MN7whjYPYTVCTx7LB+LHZM61tX/dP9I9RAcNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8VsMlRUiA8SrqpQMTNbHe65A8Lx+DA7zXdMScPfizWQj6YnJfJ7vv8iuHWTIzA590sYdJuoHC+xxBeP2ILRcdnyJHn1F1G2y3T99hrzR4Vq+dlX6m8qfabk0jSrWApLiLmvI7D/pjSK8tyXUFWTwgTt1DQkiiKZitU5KDJpsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=h/VX9yxP; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so17480339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1762409910; x=1763014710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDlEAMtwezpxLrpFe3CnV9gmK4kKgusAvfJ9H5INCMk=;
        b=h/VX9yxP2gXF2TTIzYAVODpcFjsDu5mBEs0o+2jJqu/7gLzu3U+jLZdswBTbjOe1uW
         sw02ACBUBDrq39yL8DwFXqOcbJZgUzY6Taf+tnnHiODU+cbFJ01ZCyCdEyPluwNGd8vq
         6A9jRK6yy4rNcCw2uvnNcWqvsO7jqSO8o+jcGLOhemEB4VyJ/O6ynBGO2J3XGgAplhQs
         zYcZNEGiCb8HZ7ofj+MI6yTGGo3ZqGxfAo5xNZ3Turms7TZ82+7tJE0P9UYUSppx7+xf
         hmpQZygW0CLkdwcIjjU/YzUN9zoSou4u6wXv+SaVrYgqqDJnsK4e5BCVnXzeIt/SZicg
         hd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409910; x=1763014710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDlEAMtwezpxLrpFe3CnV9gmK4kKgusAvfJ9H5INCMk=;
        b=a+xTX07r0bU4eMwBs5iqYqGLMLdNRht9XqNNc2JdRQtC9M7Zfw7eku3haI3JYvcfIo
         BPI0kTtet9uaRc7TbyZ7Q/sNRi1r3g7feQWYxpin8l1xcFlKM13LDMi44SMB2t9xmePF
         8tdNeFPLYOBDvVEpXEGB8/GLzEjm5/Wo59eMZlVkm2rzVRyPkmRMGGyeGvI51eC7Ez5/
         t90c6MK6S6qa7gjZi4+4MALCzD3aUHxlAC3DZ1nXBDEQGExWEHLv64UG/FQE+XsnQzt8
         nrL+/no1MkQ9w6pEJrtlwQjjyZ2EMmf6ONcfvNqjGrynaiFZXlKEGmu+DeUUqPIdn9zd
         I3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUkUIefRZJdnJtbzYKIY0b2UZ2V5/QjpvUGhQIjVstGu2Wh0dPK46Zcj/W7H0f5LaoD09Fu9yFb+zTRFgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWb9cpgBJyV8OiWg60Wg00+1OabJNwR+R7eks/c7qkSLWfnkcu
	jngZECoUD1RHzCVPVii5Rkd/UruApxzyS+VRSideyXo18kwvafNfEPKlR3O4Kr6D9gOmJXYQzke
	CAOzUs8kap3LemX7/kkaJbsF58Y4RdZR1iyfA/pHoxg==
X-Gm-Gg: ASbGncsdakeYgR1vsfrg1NGv2VQt3PbxQ2PVmoUuxqXyZDd6eA6+vBp+5gS87vhCWYi
	IrmjvWi8D/oSXqXburm55SzkePWDQ95wEyE1OkBzm+C99jLUpKvLpaqOSYMSX3jyWJWfVVRhMmr
	s2MV+T+7guNLuH6RGcFGmZO3kiS+9aONAgFmbiSqgYDHOOL2bs2Ltc9lUVPvAnJ3xkwaiYGKfuT
	FbW83evcVU92cijTI9k8oyjIT8rqbqGpTb6UiSF+dbQBRF7fH5PSzPHY4Rz5VD0Nmat0Fc+
X-Google-Smtp-Source: AGHT+IE+rRbZRK5f4ZtDH8DjGPSvoL5SP2kkRip7iD92MCZ4BarBIUpiiJumXPAmNS0ZCoGwkMuOapcuWSF2WD95Ouk=
X-Received: by 2002:a92:ca0f:0:b0:433:27b5:1faa with SMTP id
 e9e14a558f8ab-43340759a02mr82201175ab.1.1762409909706; Wed, 05 Nov 2025
 22:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912134332.22053-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20250912134332.22053-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 6 Nov 2025 11:48:17 +0530
X-Gm-Features: AWmQ_blNuHZQBO2zDIsL_jsP12Ozv0UDhbowq70IYcJdfGZ1HSMpnvQsCEW7hdU
Message-ID: <CAAhSdy0azfC-L3buko7-mN1PDWxi08HN=3NQ+0VeyMR8gVJNoQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix guest page fault within HLV* instructions
To: fangyu.yu@linux.alibaba.com
Cc: atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, graf@amazon.com, 
	jiangyifei@huawei.com, guoren@kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:13=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> When executing HLV* instructions at the HS mode, a guest page fault
> may occur when a g-stage page table migration between triggering the
> virtual instruction exception and executing the HLV* instruction.
>
> This may be a corner case, and one simpler way to handle this is to
> re-execute the instruction where the virtual  instruction exception
> occurred, and the guest page fault will be automatically handled.
>
> Fixes: 9f7013265112 ("RISC-V: KVM: Handle MMIO exits for VCPU")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  arch/riscv/kvm/vcpu_insn.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 97dec18e6989..a8b93aa4d8ec 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -448,7 +448,12 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                         insn =3D kvm_riscv_vcpu_unpriv_read(vcpu, true,
>                                                           ct->sepc,
>                                                           &utrap);
> -                       if (utrap.scause) {
> +                       switch (utrap.scause) {
> +                       case 0:
> +                               break;

This looks like an unrelated change so drop it or send a separate patch
with proper explanation.

> +                       case EXC_LOAD_GUEST_PAGE_FAULT:
> +                               return KVM_INSN_CONTINUE_SAME_SEPC;

The KVM_INSN_xyz enum values are only for functions called via
system_opcode_insn() so return 1 over here just like the below
default case.

Also, add some comments over here about why we are simply
continuing the guest.

> +                       default:
>                                 utrap.sepc =3D ct->sepc;
>                                 kvm_riscv_vcpu_trap_redirect(vcpu, &utrap=
);
>                                 return 1;
> @@ -503,7 +508,12 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, =
struct kvm_run *run,
>                  */
>                 insn =3D kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
>                                                   &utrap);
> -               if (utrap.scause) {
> +               switch (utrap.scause) {
> +               case 0:
> +                       break;

This looks like an unrelated change so drop it or send a separate patch
with proper explanation.

> +               case EXC_LOAD_GUEST_PAGE_FAULT:
> +                       return KVM_INSN_CONTINUE_SAME_SEPC;

Same comment as kvm_riscv_vcpu_virtual_insn().

> +               default:
>                         /* Redirect trap if we failed to read instruction=
 */
>                         utrap.sepc =3D ct->sepc;
>                         kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
> @@ -629,7 +639,12 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu,=
 struct kvm_run *run,
>                  */
>                 insn =3D kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
>                                                   &utrap);
> -               if (utrap.scause) {
> +               switch (utrap.scause) {
> +               case 0:
> +                       break;

This looks like an unrelated change so drop it or send a separate patch
with proper explanation.

> +               case EXC_LOAD_GUEST_PAGE_FAULT:
> +                       return KVM_INSN_CONTINUE_SAME_SEPC;

Same comment as kvm_riscv_vcpu_virtual_insn().

> +               default:
>                         /* Redirect trap if we failed to read instruction=
 */
>                         utrap.sepc =3D ct->sepc;
>                         kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
> --
> 2.49.0
>
>

Regards,
Anup

