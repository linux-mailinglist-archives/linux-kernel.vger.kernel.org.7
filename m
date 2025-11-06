Return-Path: <linux-kernel+bounces-887832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C64C392FE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFF73B7935
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D462D5944;
	Thu,  6 Nov 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="jwMybd2v"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E91D88B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408085; cv=none; b=ftzCUoJ7NJeYBXaU5NbqZuHvj0lM2yYwex752mKQApx7VaUAt5RUhneTYnU2q7vDL8/mR56qfioIBz01JTNrVUmyhXy8RilRAjKdJGOBfUQf3gBguRaLEHK2Ppkm7/a24j1thEQTUCwZEiA5EAokEyv6zzfqMegfjRQz6ldeteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408085; c=relaxed/simple;
	bh=8XRNkDGcev4wjXeN5rtSeb2UjJZSMlpIuFc4FifvGkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw2sEMP2GHHyRb6kABCS+YakBERYGeS+PFXmyAPSI8Zb4ANcQ2Rb0jpn1vGbWegPBv3ewmSuMN0CvQn+mPc/ZjsyDa17SObV/mzikAGExV4HVpEiuL4dvy2+PoLuNFvDWvnF+WVL45wa3X74fnSvAO+SfXLHlAL/kqOMMzCx5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=jwMybd2v; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433261f2045so4921855ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1762408083; x=1763012883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uoew2SarmiylnjDmk3L9GFoWwHK51enAJRQNH2IHjc=;
        b=jwMybd2vspIS0ixUv3Vji9As6RoIfO1BG8XcrHsra78OiMmKRs9+XZlyJhcpGjHtHZ
         CiiRoFnrBAtxS1+vxsfzyp2fWM4XudwlvK5fnbsBk8QrH2oyoFxot17LbLQw0QJ6BgVa
         WDZQfdUA69kP8YnaWCDx8kLtz6vW6FsDJgTOk/h030PMWqPnYFt6vJEMCQfgOct7aXbe
         EomTu4ruux8PhFNHcNc5bNH6nyVcJVOcIs7Q/JW1UsYZGnGmMXsn/xMJ0hBicLdgGLTo
         CcP1C9+DH4wYOWnXd57nBwt/+svRR205yDq9z76DLHoNV3MaO1LD5UvW11ZXwB4mseJK
         3ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408083; x=1763012883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uoew2SarmiylnjDmk3L9GFoWwHK51enAJRQNH2IHjc=;
        b=Lf+tFSBXk2y6z2QPRawCMzRTzHofRGK9qRCUkqg3UwLkcIxPhqK7yhC/EmumQTTwjW
         u6eKwXxCxSrbvVgPBSqi5ErTWDgoraE995CCc47FBF3IcvNBtjioBV4fWMJzXqlNt5v3
         3LmIcBHHEQHxXOP7+agBWkrq/a+nkwrarDIDK7ADtcE+8fh7jEgdIjQ5F0Xhzfp30Zvo
         2Pvb2wJV52YOTSv1+Lc6sxmx0dmm1sPvfOMq1s6uDFefYgbgLqnLePqgmKEcWNqUmnw0
         z9cQOM2EtEsppwMV9sQa5TBvt0iefvsBUbbKcOKrx6VVRdMMYnu7gy1/vB/F1zZVKnTW
         R4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRrquIHlL16sdeBFqVC0GLnvZYlIqW3OLTaDAkbQLAkj40Y15fMg96qB/Ov/3bxvMrUc4FPlLouLJ71Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0sYrf23OogvUr4CE1E6jo1L0jwg68hWPeybNSi6Q7Q0sKkkW
	gThkRxmyM4JGeEuEsQS1FjUDGhcO5Vb/wvnhtdN/M7mlCBBmsqQ2J7lXHs4AyhBrw0r7r0DHek0
	VEZ43RzJL2KiM2p+HGXE+15Iisxy3eOEmmwgncTxR3Q==
X-Gm-Gg: ASbGnct6yCr8dK0gRWK0teTVcnhRiEBmEVJD8mfHzixV5AdzfoIVDz0OUwgw+LaX5G7
	wgs9sXGqvHR1TKjsqc9y4d3dkkYJh/MnUaDVxbXTdl2uR2tCrswcVxum3DmvNGxIcJeOLSGfE2Z
	HT7BZiwbRw8aSphMFG5M4rDkhJsl/kYcUQS8rtmesXrTMQKqruukthgyGeOKEClxUQRWWZE/IeK
	RWHzB9dPdojVyrxb6KFvDrL15K/crvcdsWq16aeG289296LlRNxF6WDqYmBNQ==
X-Google-Smtp-Source: AGHT+IFbNEYpDbiUd8mOqCap1mJWhYJV/tTSDvIy+00/QF2eXniMKHHbQXm4twuBcloi6qoxWYJp8gwaXR8SH9byI/k=
X-Received: by 2002:a05:6e02:240b:b0:433:23f0:1ebf with SMTP id
 e9e14a558f8ab-43340779d13mr96165935ab.9.1762408083096; Wed, 05 Nov 2025
 21:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923053851.32863-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250923053851.32863-1-xiangwencheng@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 6 Nov 2025 11:17:51 +0530
X-Gm-Features: AWmQ_bllfHXAxLhpsO6n51JY0CLvNreW7JWG-sL9GnCN1uB2qpTsPmrk7YdRxzE
Message-ID: <CAAhSdy0OSCxo2oPYEhWjUJbOfx3HJ7Ak4KoVv4fi3ukKm6dRCg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Introduce KVM_EXIT_FAIL_ENTRY_NO_VSFILE
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atish.patra@linux.dev, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:09=E2=80=AFAM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Currently, we return CSR_HSTATUS as hardware_entry_failure_reason when
> kvm_riscv_aia_alloc_hgei failed in KVM_DEV_RISCV_AIA_MODE_HWACCEL
> mode, which is vague so it is better to return a well defined value
> KVM_EXIT_FAIL_ENTRY_NO_VSFILE provided via uapi/asm/kvm.h.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this for Linux-6.19

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/aia_imsic.c        | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index ef27d4289da1..068d4d9cff7b 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -23,6 +23,8 @@
>  #define KVM_INTERRUPT_SET      -1U
>  #define KVM_INTERRUPT_UNSET    -2U
>
> +#define KVM_EXIT_FAIL_ENTRY_NO_VSFILE  (1ULL << 0)
> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  };
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index fda0346f0ea1..937963fb46c5 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -802,7 +802,7 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *=
vcpu)
>                 /* For HW acceleration mode, we can't continue */
>                 if (kvm->arch.aia.mode =3D=3D KVM_DEV_RISCV_AIA_MODE_HWAC=
CEL) {
>                         run->fail_entry.hardware_entry_failure_reason =3D
> -                                                               CSR_HSTAT=
US;
> +                                                               KVM_EXIT_=
FAIL_ENTRY_NO_VSFILE;
>                         run->fail_entry.cpu =3D vcpu->cpu;
>                         run->exit_reason =3D KVM_EXIT_FAIL_ENTRY;
>                         return 0;
> --
> 2.43.0

