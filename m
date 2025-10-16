Return-Path: <linux-kernel+bounces-855652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6DBE1E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AC1A60AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE62FB97B;
	Thu, 16 Oct 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe7JBxze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A32FABFB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598572; cv=none; b=WHhDYX61plCDxXWp5a3qYX9r4tHS6dD/nAcGRKga6BnZ2rlyE/epQhM0ofaerxQ9ocgJDqPW/9ZtMGaMaazixIw3Mx+sD7l713gZkmhuGATBqiBNsnWLnGGq+CnEGE3jrqsp/m+qSFbDGTtBwGBp63J4hTspFyF6N/cydqYG1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598572; c=relaxed/simple;
	bh=tqV9FavTAJh9wwxG6Et9o3AWwjkTpQ0pr7p3j83KK8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8L7GwBl1+oxQilZRTafWRMgFPWDBXAsz/pnf0CgaN4CMr4d6rYnyz1JAU5naSKhfcuMEO0eVB04fAmajDoVjy0FGwghGBEfLsPO+M9tWGYGnDUYY+ypYKEBYDK78JSQDFv7TY+W3Ecyc8Sopzu2Ljazd737C/9xSqRSdkKYWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe7JBxze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9CDC116C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760598572;
	bh=tqV9FavTAJh9wwxG6Et9o3AWwjkTpQ0pr7p3j83KK8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xe7JBxzeInVfqXCl30crkAoZKPlv0JxDULRpxKeiQx5o7l/IMchBaq/par5aRtcp3
	 gs/axer1A7kCXMl2dVcSnwWYn3g8Khc69FdttLNmUCWBWQbJIyuZ3nEpXO+XUQmM7P
	 MXhIZFuholGSfKnSaDKNnDhjYfMSuaPukvUwLuVv3Ht+eBnyRW9K5e84fsHnHyl9Jz
	 9LHb0qhZFtAWBxrE4Z5JsEAvfJUNreyFhgz+EELrIoT0GBkPqJ/02W3LT5FIVykC9k
	 BVk3gVv3uleoVfGdhyLGpjV4uvK2PdShwc8NK83LSgT+UnQUZCzcELYQahlvTtvtTa
	 BwaynlFdF9frA==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b303f7469so2452405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:09:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq43vldPYk+0H9E/n2/45uJoFlDb7TIJKyFU2IDq0zr2yANzRd3MVNSTWD20hXuxYaVgFJN2bjvvMvxBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXZCtc/x+OO9treVOmYXXbLjbdXBnxECDfsbW4/rGLagDFtTY
	ua8D9sBaMIdSmq019jAPxqlM1N6DidkSMn5m0nhBYxi7CoMmRZ1jpuSbPmC0PQmMlSONuNcYZEc
	Gmzf/ZUdB7KWC79qzIWsAsMsR0230qiM=
X-Google-Smtp-Source: AGHT+IHHL1wmC6o8ypcfmXssG1HsqaRz5sLpx25KrCBoheuAiefWNbSeD8xiWWhZW3/XWyXX6/AoCKLYw9iXj/fvMCk=
X-Received: by 2002:a05:600c:5491:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47114afc8b2mr2348225e9.3.1760598570695; Thu, 16 Oct 2025
 00:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016012659.82998-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20251016012659.82998-1-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 16 Oct 2025 15:09:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQLkddb-eGhkMSOBib9_fMt1Loo9aoR2tH-kVdekQdQzQ@mail.gmail.com>
X-Gm-Features: AS18NWChYWNrMcrxKh1WVuaWbDYhak1Eefs61R7VEYdLZUYyFemN78y3cS5ohSc
Message-ID: <CAJF2gTQLkddb-eGhkMSOBib9_fMt1Loo9aoR2tH-kVdekQdQzQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Read HGEIP CSR on the correct cpu
To: fangyu.yu@linux.alibaba.com
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	liujingqi@lanxincomputing.com, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:27=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> When executing kvm_riscv_vcpu_aia_has_interrupts, the vCPU may have
> migrated and the IMSIC VS-file have not been updated yet, currently
> the HGEIP CSR should be read from the imsic->vsfile_cpu ( the pCPU
> before migration ) via on_each_cpu_mask, but this will trigger an
> IPI call and repeated IPI within a period of time is expensive in
> a many-core systems.
>
> Just let the vCPU execute and update the correct IMSIC VS-file via
> kvm_riscv_vcpu_aia_imsic_update may be a simple solution.
>
> Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC vir=
tualization")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  arch/riscv/kvm/aia_imsic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index fda0346f0ea1..168c02ad0a78 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -689,8 +689,12 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct k=
vm_vcpu *vcpu)
>          */
>
>         read_lock_irqsave(&imsic->vsfile_lock, flags);
> -       if (imsic->vsfile_cpu > -1)
> -               ret =3D !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfile_hgei))=
;
> +       if (imsic->vsfile_cpu > -1) {
> +               if (imsic->vsfile_cpu !=3D smp_processor_id())
Why not if (imsic->vsfile_cpu !=3D vcpu->cpu)?
if pcpu changed, the kvm_sched_in() would update "vcpu->cpu by
raw_smp_processor_id()".

The smp_processor_id() may involve DEBUG_PREEMPT code, and
check_preemption_disabled() may cause a problem? Anyway, a full
smp_processor_id() is not needed here, vcpu->cpu is enough.

If (imsic->vsfile_cpu !=3D vcpu->cpu), then:

Reviewed-by: Guo Ren <guoren@kernel.org>

> +                       ret =3D true;
Agree!

When a vCPU migrates to another pCPU, we could assume the interrupt
has come in to prevent the missing interrupt.

To illustrate why ret =3D true, consider this example:

1. Guest WFI VM_exit.

2. Host Trap -> kvm_riscv_vcpu_exit() -> kvm_riscv_vcpu_virtual_insn()
->kvm_vcpu_halt() ->
    kvm_vcpu_check_block() -> kvm_riscv_vcpu_aia_imsic_has_interrupt() loop=
:
        for (;;) {
                set_current_state(TASK_INTERRUPTIBLE);

                if (kvm_vcpu_check_block(vcpu) < 0)
                        break;

                waited =3D true;
                schedule(); // if pcpu changed, the kvm_sched_in()
would update "vcpu->cpu =3D raw_smp_processor_id()".
        }

 3. Back to the outer loop in kvm/vcpu.c:
        while (ret > 0) {
                /* Check conditions before entering the guest */
                ret =3D xfer_to_guest_mode_handle_work(vcpu);
                if (ret)
                        continue;
                ret =3D 1;

                kvm_riscv_gstage_vmid_update(vcpu);

                kvm_riscv_check_vcpu_requests(vcpu);

                preempt_disable();

                /* Update AIA HW state before entering guest */
                ret =3D kvm_riscv_vcpu_aia_update(vcpu); // Update
imsic->vsfile_cpu with vcpu->cpu;

4. VM_enter Guest WFI
    If there are no changes, then Guest WFI VM_exit again.

5. Host Trap again, but the vsfile_cpu & vcpu->cpu &
raw_smp_processor_id() are synchronized.



> +               else
> +                       ret =3D !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfil=
e_hgei));
> +       }
>         read_unlock_irqrestore(&imsic->vsfile_lock, flags);
>
>         return ret;
> --
> 2.50.1
>


--
Best Regards
 Guo Ren

