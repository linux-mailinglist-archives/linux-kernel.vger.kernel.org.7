Return-Path: <linux-kernel+bounces-735587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B128B09149
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A25A443F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6D2F8C28;
	Thu, 17 Jul 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TWRmZN1w"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABB35963
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768291; cv=none; b=XOWfZViIaisTaot7l4shtnxbhNi0EJAD5XUO6dzsCzYRBTFnSfWH4QV7o34d5RV9ndx/Q0DcLn6H39UqUfja7ByGjwTYedeqEFZszscWfqR0RRlLYTzuCjn+Uy2shDGmxC86FcSXIimWRVI9sATW6/LGEYLylyoEtp3QnJVQN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768291; c=relaxed/simple;
	bh=WOIwx1hKJu8v/kYP52CvuHubvCiOsRZtEEd0Wy1EfwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2djKu/iPWv16J8X88E1w5/QObeve/tNQYpN0iUFOemaofalTP1DyMFnA0EaxYgd6Uywjbq7Aw1MEMPhQH6PiaOCEF8Pf6ly0lFw73P5qeLut634W7TisRgTovExjcurZWNncaEnqdO8sA1ZFLb/px7VKf1vVKjgi/KhObAC4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=TWRmZN1w; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-879c737bc03so32733839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752768289; x=1753373089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF4ZzdU4KPm05DxQhuE3nJR3OBuoI7+D+aCP85HQkvI=;
        b=TWRmZN1wWlexMhEcohtauG5rpKX28sYpyn5N01Vva0I044tb2UwJ9JA4CGVv5QULKb
         S9cHd+2NbjYOD8NXk2PS6ZPNz4pwGSODsv8w2v/Qh+lacq2FkAlcEMWl7bnxxOTBj7Ab
         EJa3RGIfP9jzTjgDtpGJPZ12/HS1WTEiUgPHCxwgvZCTmpaR/RpVpv6j9jlf94dzIYDi
         fiicQdXzDFKFJFQPeg2BuLOUgD3DfcU6QR4V9CKHnpk3Cz0mRW+Xa/SSSh+h54JAN8eK
         v7CJPRQSbywIImj8QiBzsGMtkc7LlV6OVKgS86edw4lRpMj1LW3MKWtXsvVFLxCLBBe0
         W0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768289; x=1753373089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF4ZzdU4KPm05DxQhuE3nJR3OBuoI7+D+aCP85HQkvI=;
        b=VTCIoZI/bhyJOuF4SSvHTZWLm3V3KNeh0EpRXEj2TzGudm3AVUZHTyfRDYsgGbPOGd
         90a7rtYJa8IaziLmrodojQgDtxFf9M/r3qYXMf1rCm/a7LqNTV50wVtfqt05G+2zt4fo
         ao1VAI6T9LTwtD4k+VwwyNQFKriPHrqgseZCntd7wCeQBhzXS+kvogkCcFI2yrc8wRnk
         WtpqFr4ueAk8fmRb7LqA63Gqu0yum7+YdWy2xoWz1m4oR6i6KDm6nObC1jLlY2s3n/bv
         BS1TUlnPSogzGEDVGNj3WN5mjjgAKdBhJdCYzdfWEnpog3WF4fp20Zv3qSjJ69jMdVPc
         iykA==
X-Forwarded-Encrypted: i=1; AJvYcCUNGQnFuge3vghFBSfu0nbESNDicLw0UnR9QXhMP3syg3W8ZDlnag3UOT22y3JzuZ/pzH057RJEF6lBdFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0LmNzgnDcWgBrdPD9MnJ1rlFlB+BOoDwS80fknpplrXfC8qO
	/kfaYGAweTkwbqx4a2KWI3JTkypPn5dz64FxU459P/pUt2UuCmzfXsoIKiJtyGvH8zAg8Y1N2K0
	3kZzVQdhGVk1yvoBWpg1yaEo3OmzBQyjcTkDzahEEpg==
X-Gm-Gg: ASbGncuLseCOBsVF4lxOULCOBRAyFD2g1zCuFllynRlrNSGqlCVxkHFvMKlmuilYLLr
	Ya/N8nIZ1EGFj1o5zCDgW6Q4syeksOwNmsyWsfI4dTnpM/lXWs9sEe+6AUKMqgKJoVMbVrYftuD
	N/nOIlCmm9oT0qKm+4e2JIssmDxHTHToAf6Z9pDT9cxdVpecJOYutSv4s/c4FSTZilpd9jmP3sb
	JEecIJTh8eh7ocM48k=
X-Google-Smtp-Source: AGHT+IFAG3wYGrY4xyVVSnggyKQ8Fmk+ZxX7eQXMdYOvL6ZpVVrOgjCMEp0iGPnFH5D2j6kt83DD42IjPEeujKO5F/Q=
X-Received: by 2002:a05:6e02:3e07:b0:3df:3598:7688 with SMTP id
 e9e14a558f8ab-3e28307abacmr89850255ab.21.1752768287054; Thu, 17 Jul 2025
 09:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-6-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-6-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 21:34:36 +0530
X-Gm-Features: Ac12FXxSVTcSMonhmD8rqZBxMoPIHtsKSpNyakGFXvSyptDFl2Kq_s4PkOsoVXE
Message-ID: <CAAhSdy2v4FSpekE6QNwsP8vVAH3NxW01cZOgECV2tcAOjgXD+A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] KVM: Add a helper function to validate vcpu gpa range
To: Atish Patra <atishp@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> The arch specific code may need to validate a gpa range if it is a shared
> memory between the host and the guest. Currently, there are few places
> where it is used in RISC-V implementation. Given the nature of the functi=
on
> it may be used for other architectures. Hence, a common helper function
> is added.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  include/linux/kvm_host.h |  2 ++
>  virt/kvm/kvm_main.c      | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 291d49b9bf05..adda61cc4072 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1383,6 +1383,8 @@ static inline int kvm_vcpu_map_readonly(struct kvm_=
vcpu *vcpu, gpa_t gpa,
>
>  unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
>  unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn,=
 bool *writable);
> +int kvm_vcpu_validate_gpa_range(struct kvm_vcpu *vcpu, gpa_t gpa, unsign=
ed long len,
> +                               bool write_access);
>  int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *dat=
a, int offset,
>                              int len);
>  int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa, void *d=
ata,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e85b33a92624..3f52f5571fa6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3301,6 +3301,27 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gp=
a_t gpa, const void *data,
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest);
>
> +int kvm_vcpu_validate_gpa_range(struct kvm_vcpu *vcpu, gpa_t gpa, unsign=
ed long len,
> +                               bool write_access)
> +{
> +       gfn_t gfn =3D gpa >> PAGE_SHIFT;
> +       int seg;
> +       int offset =3D offset_in_page(gpa);
> +       bool writable =3D false;
> +       unsigned long hva;

Nit: rearrange the variables in a inverted pyramid shape.

> +
> +       while ((seg =3D next_segment(len, offset)) !=3D 0) {
> +               hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, gfn, &writable);
> +               if (kvm_is_error_hva(hva) || (writable ^ write_access))
> +                       return -EPERM;
> +               offset =3D 0;
> +               len -=3D seg;
> +               ++gfn;
> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvm_vcpu_validate_gpa_range);
> +
>  static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
>                                        struct gfn_to_hva_cache *ghc,
>                                        gpa_t gpa, unsigned long len)
>
> --
> 2.43.0
>

Otherwise, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

