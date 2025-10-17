Return-Path: <linux-kernel+bounces-857460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E976BE6DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883A83B5AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498730F7EB;
	Fri, 17 Oct 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Li29ECCu"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4830F818
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684340; cv=none; b=LcK/IAUtbqG0yp0/0NNT8c9aopETFmyvji6GQ4tALKEZUyVAta7sDSzUzmN6QZ+r3Q27BTGgS+o2BwxD5/RQyiQzAGFDsq5tLWLKc5hYPUjuOzk/3GQ8pL120BjyBecgXkgpTpG148NI+iCZSdQq17QkGIu9hItHCyElzn0Z3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684340; c=relaxed/simple;
	bh=I3bc65zO/JWcs456H5HuVEZ4MsfMb6nc7AHpCv6K92c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvM3cnzqdFoDxrSsaZBql902peF9YyOLzLpXdrsaF15Or7bSKzjAIIjpdfpFJE6lqiCh+msjFqp6MBPVbAG0j+z0Z+HiIVfTXXOH+LM88bsiSt0zLtysmG7Mun+QAj6VDJzP9W7lCMh2UPHmnqSu3a2s10/N91zN75OyTdTnvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Li29ECCu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso144431739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1760684338; x=1761289138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tBllN1KPXGz1kwWkEqmZXoXM1+36pBPLJkHM98NsOQ=;
        b=Li29ECCutySd4W2lsbfU+PBfWmqRYy8jB5GlRX9s4991mL7NM42zAhOJfu5Us9fktr
         dmElduOLOfQzpcZFbrYqceg3kzrN8sn8Gz92QtCmNTq5NOii9faM0zKQCTScubhszrXa
         cSlk+YdyqY4zJyjOdfeqJmo8D3xkQbHV6PAN+BYkHWJ3nSBgZuSaWD+9UX96vqtLSNZ3
         3/LKjiZM8/Uj30HXC2lxHwzpn/pKzvWoj0WUm8fKd+MMNCYAq09EPm7unJ2DGDslmosY
         FHtSyzaHbF1MymwL2utyJ6WEb5fJG6++iZmVQnZcmE6mm/SG0184qnjDX29r2oKIpF0j
         6w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760684338; x=1761289138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tBllN1KPXGz1kwWkEqmZXoXM1+36pBPLJkHM98NsOQ=;
        b=q0DzOwVf5UkOcQYulyatHW0Z7J4zUWev0jNsyVSw//Y0AEhLNMUlno0iNJ12PRzgQc
         7Z3UZO2QDvfSgedEpO6MwPkhasCOP998g/qRrUWRJdWtZc9u8ZJOOTcoNwfaveb6nvVc
         5zrucKqJYV6a6b4YrPog582Q1nMS9xlC6KddnBjVpBbqzLcZTWOYzsRl+VXwnOmXQuDk
         t7sISQl6AL/4welWuA531BDBnHo+bVjUCCDwUzuyEqLdNamvB6qZMAjCom9KGKvRoJQP
         7e3yTcORtTc0Fnyp1ge8cpqXwwQ3YoAMZgUjfumAbehiLiFZqp3p3VqdYXGwTu/0t2It
         Gkvg==
X-Forwarded-Encrypted: i=1; AJvYcCWdz+oCxeIb4KGlxsTuuGh9+eVs6rfckPQ+frzk8gQqFfHY4eJJBmwT/uFdgaL/7im/MvXd0vNr6ggqcUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9X6R/eSXebu2fqHaxZESV+kFaqyFm7jtU7QRax8OEXbFJ2nY
	d3W5KAKUNvf44Ai5HreuuW7375d8PE4MZI7v4eT33ZZqX+88sGFM7jV7Ps3xgc3QKTvMKr0UQBY
	S8Vfyur+x7LvOwUdoZh0MvVfo9DD2hlBaf+ggbluCqQ==
X-Gm-Gg: ASbGncvYjzOKWAXJEjjmEYZI2rluhAkXfmSu78EFAGQlC+FxwH8tGH2nOpq/gUBrwgk
	qDpo0O3RMJ7UEYR3ecc7OnIJk9aL1JH06mVrN3jGw97EclptCnR8owlr2/GLuLBT8xkAiksDspF
	wmdkrV65qQ11eDGW/Iv0Pf3lcyrlfnQpk3vNsOqpsljEy0nELyLa/ATzPwofEUuuZkg/aZGjPsu
	RalyGb5dgHYF8OCCoDGKPeE0Vb8qm5gtVujhlhuINbP+B4v+bAAgRTcYxnYi4ogI16A0x5+FqGm
	MvNWiH6PorfIMGNfL4GcUfqqdbhz
X-Google-Smtp-Source: AGHT+IFCshVxKTQarSYu+mbLMq9+cdps146TZixf/9pY/HK3AnNs9jHylKnsUq6JcPr+g9YcoZphbOzJ+VMIjriDxuQ=
X-Received: by 2002:a05:6e02:3e04:b0:430:c394:15a3 with SMTP id
 e9e14a558f8ab-430c528d628mr41557595ab.22.1760684336325; Thu, 16 Oct 2025
 23:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016012659.82998-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20251016012659.82998-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 17 Oct 2025 12:28:44 +0530
X-Gm-Features: AS18NWDRRpVn-G-IgqIpz7eW2arnxdgcUvLxINosb7XYvEXa1letznEamlVSgow
Message-ID: <CAAhSdy2UcmoPLF0CGBrsF1bRdJe-X05YA7UQOVffxBjZTourMA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Read HGEIP CSR on the correct cpu
To: fangyu.yu@linux.alibaba.com
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, liujingqi@lanxincomputing.com, 
	guoren@kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:57=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
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

Good catch !!!

I agree with Guo Ren. We should use "vcpu->cpu" over here
instead of smp_processor_id(). Also, I think we should add
some comments for future reference. I will take care of this
at the time of merging this patch.

Queued this as fixes for Linux-6.18

Thanks,
Anup

> +                       ret =3D true;
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

