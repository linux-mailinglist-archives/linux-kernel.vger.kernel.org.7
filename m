Return-Path: <linux-kernel+bounces-826595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71080B8EE11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACEC3BD6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367A228CA9;
	Mon, 22 Sep 2025 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sQVkI9Jg"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A626219E8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512879; cv=none; b=VPvhYQ0ferKJoggn2YEi45Gic/T81H8we3aPNmxPiPvhIcSmaKIDwXfUkpvXKfQL5ot870LhFRqstvbjLsx0F5/J/wUNnzpsD6uAyVZpe+721sstyrr/YTfnKWs2M3Dc/sjqT1a4fItbfLdCoPxVGLprE+tlteG8ODYwk3GiJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512879; c=relaxed/simple;
	bh=Hb5osIRW5aBHxcNDa1DydZU4XR5TrroyUg9M2K89b7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qjlvydpzrr57qgNEX94spkFByb97sG5cB0rWbMN0Qgnt9j72KX0wUMIptXG3tc1hAAEtGV3Cp9+43QM47Va722Yc6vfGlyecG7pJe0hkVEIUEr2PPE4Zmqgyv1XqRqehJQnuFFpzRJeEDY3EdIHG2irGkoWnCy6MZlK40OKkS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sQVkI9Jg; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-425635acc4dso16333225ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1758512876; x=1759117676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGuVEvHGyfQ2BFC63znl+bSOQQ/TN+svZB+fJgEKx9M=;
        b=sQVkI9JgD93sqVP5sSevU21mHPL0HFSKkJsiwTRJ0yBBZU2Po3eQt2avWyajHn4tHu
         wKSyEuEMYEGLrRpMHsPhDspnXw0Oh+5jO04WE4PNCMAeelNuIB5OVDHuT3USiGlT3Bmo
         XjV74x0AE+xY2vb3bBpWyVOJxFez/y7h3+eHBY5jzLlir2wTKKrZlVQhJFRlqe07PLyM
         dlGyrO8e+D6v2kS3lkHmHEW/ieg9QaMMvECRW6vsP2btHpHAJPdQmZws+xInzos2b7hA
         DdsaRcr7yGVn3UDIEutDDCBQJqPoS38VXveF/cgnFfpAS5UhyZkM8ykC6UheosLojbD/
         0T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758512876; x=1759117676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGuVEvHGyfQ2BFC63znl+bSOQQ/TN+svZB+fJgEKx9M=;
        b=AsveSYBQB2JNb6EMYaoCkJgfMFqQucOYkDuTXq3MOcUNrV8i4TaZeEwSM1ONFaprU2
         h6bLE4NhgYoc1p33R1hRSP5PEMu67byzo3dsSkqHOrLIW1qf7u4+UhRC+6lHim7rvIgy
         sPNxBa89y0WTbbvm9mH0fzow2UFBGDtTNqZMmTQ4DbITrs4FGE+Mb1HuyxFkGxmiSq03
         RH+Nc2HiuudsYq4wdtYsM6FsRJWy5KHmUfiRU2fVuLJmb4xZF3onVI9C6fdnaRi79U94
         865YB3iiR8YnkgCcUufi5KF40eJ/TwrRsxN9VVTPP8JIkI1/aBhQMpndgRUbMuToTS4h
         4qfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhHhAepcJwuRIdk30ocO659JQ67qUbWX+NI6P3vLVOqHtg6lgS0XN/648yAmQX7WjxJY8bUNaxdgpMs88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/300MQLSn59xlf1DtL59OQ3ydeluFzz1gSI+uX7l1uVsM2hQ
	U2i3+QdIIA1s21HZxY2Ewv4Yo/7zQJ2w3JQv1TKsk19/3MOd5SkSQrDIgUeglhJqkrOEmTJw91m
	u5I4jE9UU/uJGtPKhzsjLeNdWOcZj/QLym8XsFXcIpw==
X-Gm-Gg: ASbGnct3uPp8zjOlCJ2l8O71GXop1oPQixQn3PsNOGqiaD6SphWoxqxqWASvt8Cf52L
	NzpR4fZINhYtRDaq9s15sumofgNjDfYgLLHuuH3dnednrD0cgxfaiUtZVrbktEqnr+yR2f81JDA
	mlla23JisvQgzGtHwX4BwjxL9NrFUYdK7hg4gBew7DfAxF5PSCla/RYoQtiCUWRrqMtvzvVHOEd
	JvXFL0Lj4I3innDpGLv8wJQiIB8/34y1SWtc5o1
X-Google-Smtp-Source: AGHT+IHO8DNLPyWRRVhnXNw51Hz0e4MEtudltvnf2lQqnZc/nn0n4GS3gLJxQNB6R7/XqLb0csBtp5kh4GKuFoaudA8=
X-Received: by 2002:a05:6e02:18ce:b0:424:7de2:61ca with SMTP id
 e9e14a558f8ab-4248199c624mr163717175ab.20.1758512876440; Sun, 21 Sep 2025
 20:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714072051.1928-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250714072051.1928-1-xiangwencheng@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Sep 2025 09:17:45 +0530
X-Gm-Features: AS18NWCodXxq_NwRnNatjdWFDrBUIO_QWr6YpBDyOo-YuWb6ERuQ-Hm3OHSaNi8
Message-ID: <CAAhSdy1WaaSSdPqHQfNGdc98vfvF83YZYetd4jVPpHWQJEY5GQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Introduce KVM_EXIT_FAIL_ENTRY_NO_VSFILE
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:51=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Consider a system with 8 harts, where each hart supports 5
> Guest Interrupt Files (GIFs), yielding 40 total GIFs.
> If we launch a QEMU guest with over 5 vCPUs using
> "-M virt,aia=3D'aplic-imsic' -accel kvm,riscv-aia=3Dhwaccel" =E2=80=93 wh=
ich
> relies solely on VS-files (not SW-files) for higher performance =E2=80=93=
 the
> guest requires more than 5 GIFs. However, the current Linux scheduler
> lacks GIF awareness, potentially scheduling >5 vCPUs to a single hart.
> This triggers VS-file allocation failure, and since no handler exists
> for this error, the QEMU guest becomes corrupted.
>
> To address this, we introduce KVM_EXIT_FAIL_ENTRY_NO_VSFILE upon
> VS-file allocation failure. This provides an opportunity for graceful
> error handling instead of corruption. For example, QEMU can handle
> this exit by rescheduling vCPUs to alternative harts when VS-file
> allocation fails on the current hart [1].

Currently, we return CSR_HSTATUS as hardware_entry_failure_reason
which is vague so it is better to return a well defined value provided via
uapi/asm/kvm.h. In general, this patch is fine but the commit description
needs to be improved along these lines.

Regards,
Anup

>
> [1] https://github.com/BillXiang/qemu/tree/riscv-vsfile-alloc/
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/aia_imsic.c        | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 5f59fd226cc5..be29c3502fe4 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -22,6 +22,8 @@
>  #define KVM_INTERRUPT_SET      -1U
>  #define KVM_INTERRUPT_UNSET    -2U
>
> +#define KVM_EXIT_FAIL_ENTRY_NO_VSFILE  (1ULL << 0)
> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  };
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 29ef9c2133a9..69b0ab651389 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -760,7 +760,7 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *=
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
> 2.46.2.windows.1

