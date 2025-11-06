Return-Path: <linux-kernel+bounces-887870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955DC39464
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B163C18C2FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED3B2D7395;
	Thu,  6 Nov 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ivnu9Bnp"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52FAD2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410675; cv=none; b=dd0nizSPkipzQWLP6TofOkGtVmmWp1sByzZXL2b5yZL/nzatFrs6DNwLjm/sf8Cq5E4sLoSwb6dzYbL8gt9grSOPZ3SdeeyGsIWQ99/u+3FUg53qAqLAHRJfniR31IrOF32RfDUfNN92X6rKuGGtFtp5s90LjvUf78XtIsMR9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410675; c=relaxed/simple;
	bh=mH++FUUWiNs6njLTnVHXr3I4PNEnL/QgVM/9ZKawPqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Unex9d6wuGYKCsFdoreciezjN1Rb2esc3JZGA0Gat5iS8ofHOw0Qs5B3783JuLkpjtVbLUtlVjjaQDZv9SbAynJg2LZpQJCm60FsFGVaRSXawd3Ptnfy81CE3dVeWXvr00F6jbCUWklokNBXA1QhNp4KG1XGWKXhu2kT9fxhxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ivnu9Bnp; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-433217b58d9so2121175ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1762410673; x=1763015473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wsAqJo0NXbvMDfBjbCfB9v96+a4KboR1hex7uLJfTY=;
        b=ivnu9Bnpdyr6HD37ODXkMpI/1eJb/GLduZXZAtmwH4maRvFtZGukq+L/aqNDwcCZcR
         CDRlMNRNLcW1ilohUHxp2gUvQUczlGxW28OMddnXMMbyG/cdO0iVJzzMkgOGfzjPcSc8
         W3f/mZ4/SJimtpJube0n2sTeRCXGPMgdg6GIYVxp6lIZo2Aet6ecwtRDNI9wDXYmYAMI
         D81PaB9dKodIicfpCfJ3f7lUU/L7dSXmEEgUHUnfJeMsJSHdyOaIcLwbwcC26UPBVyM9
         rGP4GPk+fVwzA2pYixP6dGZa3ZhYJRZiXc1qwlOfWPgutGiRwfT5CQ3ewTZPi7Qw4a66
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762410673; x=1763015473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wsAqJo0NXbvMDfBjbCfB9v96+a4KboR1hex7uLJfTY=;
        b=to+P7HTJg/CBI8HFP7VR1qtKZeGqKMLm8YJAIXLl2poJz9aeyyBdTJIyWTPQ5hv1Vz
         IlN8hQ0jQw37ywa+vIj/lMFlfZa9P4J2sFqJt+VdidE/OWf3jhyri1HF8EMnKQWuly3Z
         rn5R/kvxRVSOIph36AsL03n78JnhNw83n4So5zxeIcssyZcx/t2c6nhkKt9ZP/vNv821
         AIoL89avCB1wdA2Dp1GwneSqH2VPniv7BDpvakFIjl4He6vRJsoTtNL6dKEvQk8fjQQ3
         YxQo/JksW/iJzejxw3GQEHhdmHbFZcEKquDn9ouwWhWef4N9Tq/Z5JXzVDe1B1Uk1UDf
         BT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt6wX0YCd8MqmUqgTeXJ2jeLO2QJ1Ic0z7kBTOipyeuCuK9Q7XipJ3cpNB5idPZunCEDLPmv56EA0Ltvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXutJgZPERUzcbbFhGADwxrsNuOQtj6VK/FQcNmVZyaNu7bh/
	IDD1c0G4QVqTEnSb3fEF+u9+eYmW9H3gyA9QuWQKwuIwXdBNXLdbzz1HRJYqwdTT/BNHjR735U3
	Cd9u7NRWjkGqet96ZnMe9buESqjkF0OE0cGIB+zFgJA==
X-Gm-Gg: ASbGncvccwG1QH/f9o4/oCoFjQNgfBPtVU6RdAJ3DYgACLEFQHqP0jTgsWfMzEVdd8N
	qb1OYrHIASXwz+sQeXWQOVQVLIk9BVBWKZuUOz8BAP0bjH3182zb5re5iLRP/L8uDKjdQIInvd1
	Ex1VNqJAQ5wE/9dqPDNne1UfqB4zgJkg+osE9S9AT9pbJVZYyAIdVOfrQEdsP8B72wAFmvQmJoh
	JWOrNKlzccOTzW8c4TOIDaMZJ+CdyBR90E/y4xEVOO6l+hSP+RLKoNpiVTJ/GPBwTh8ACxedH1u
	k809ZpA=
X-Google-Smtp-Source: AGHT+IE62i5hdnOw1tkRcQojVd9lPnQXpVgG5xN5CqCFTDG7bifDDZ9QHqo5x/eJro/G00X8hkfIC+3pZrHlhszwkJs=
X-Received: by 2002:a05:6e02:3087:b0:433:2fa2:a558 with SMTP id
 e9e14a558f8ab-43340789f0cmr86438485ab.9.1762410672706; Wed, 05 Nov 2025
 22:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918073927.403410-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20250918073927.403410-1-qiaozhe@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 6 Nov 2025 12:01:01 +0530
X-Gm-Features: AWmQ_bnVS73erzCQONrC7p_TFgCPBgKI27B4YWN1vAUbG-ECAIYJMH0uCmATp_w
Message-ID: <CAAhSdy2asCgoU+2q2wTQVCMD+LvdQjhJSbKUc-yRaGqmHnQoLQ@mail.gmail.com>
Subject: Re: [PATCH] RISCV: KVM: Add support for userspace to suspend a vCPU
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:09=E2=80=AFPM Zhe Qiao <qiaozhe@iscas.ac.cn> wrot=
e:
>
> Add RISC-V architecture support for the KVM_MP_STATE_SUSPENDED vCPU
> state, indicating that a vCPU is in suspended mode. While suspended,
> the vCPU will block execution until a wakeup event is detected.

There is no clear use-case why KVM user-space would put a VCPU in
suspended state while it is running.

>
> Introduce a new system event type, KVM_SYSTEM_EVENT_WAKEUP, to notify

As the name suggests, the KVM_SYSTEM_EVENT_WAKEUP is for
system-level (or vm-level) wake-up and not VCPU-level wake-up.

> userspace when KVM has recognized such a wakeup event. It is then
> userspace=E2=80=99s responsibility to either make the vCPU runnable again=
 or
> keep it suspended until the next wakeup event occurs.
>
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h |  2 ++
>  arch/riscv/kvm/vcpu.c             | 37 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index d71d3299a335..dbc6391407ae 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -43,6 +43,8 @@
>  #define KVM_REQ_HFENCE                 \
>         KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
> +#define KVM_REQ_SUSPEND                \
> +       KVM_ARCH_REQ_FLAGS(7, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>
>  #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 3ebcfffaa978..0881c78476b1 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -496,6 +496,18 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu =
*vcpu,
>         return 0;
>  }
>
> +static void kvm_riscv_vcpu_suspend(struct kvm_vcpu *vcpu)
> +{
> +       WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_SUSPENDED);
> +       kvm_make_request(KVM_REQ_SUSPEND, vcpu);
> +       kvm_vcpu_kick(vcpu);
> +}
> +
> +static bool kvm_riscv_vcpu_suspended(struct kvm_vcpu *vcpu)
> +{
> +       return READ_ONCE(vcpu->arch.mp_state.mp_state) =3D=3D KVM_MP_STAT=
E_SUSPENDED;
> +}
> +
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>                                     struct kvm_mp_state *mp_state)
>  {
> @@ -516,6 +528,9 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *=
vcpu,
>                 else
>                         ret =3D -EINVAL;
>                 break;
> +       case KVM_MP_STATE_SUSPENDED:
> +               kvm_riscv_vcpu_suspend(vcpu);
> +               break;
>         default:
>                 ret =3D -EINVAL;
>         }
> @@ -682,6 +697,25 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>         }
>  }
>
> +static int kvm_riscv_handle_suspend(struct kvm_vcpu *vcpu)
> +{
> +       if (!kvm_riscv_vcpu_suspended(vcpu))
> +               return 1;
> +
> +       kvm_riscv_vcpu_wfi(vcpu);
> +
> +       kvm_make_request(KVM_REQ_SUSPEND, vcpu);
> +
> +       if (kvm_arch_vcpu_runnable(vcpu)) {
> +               memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->sys=
tem_event));
> +               vcpu->run->system_event.type =3D KVM_SYSTEM_EVENT_WAKEUP;
> +               vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
>  /**
>   * kvm_riscv_check_vcpu_requests - check and handle pending vCPU request=
s
>   * @vcpu:      the VCPU pointer
> @@ -731,6 +765,9 @@ static int kvm_riscv_check_vcpu_requests(struct kvm_v=
cpu *vcpu)
>                 if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
>                         kvm_riscv_vcpu_record_steal_time(vcpu);
>
> +               if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
> +                       kvm_riscv_handle_suspend(vcpu);

Why ignore the return value of kvm_riscv_handle_suspend() ?

> +
>                 if (kvm_dirty_ring_check_request(vcpu))
>                         return 0;
>         }
> --
> 2.43.0
>

Regards,
Anup

