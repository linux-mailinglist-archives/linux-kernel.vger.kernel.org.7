Return-Path: <linux-kernel+bounces-735592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0930B09157
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EBE3B16DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11D2F6FA3;
	Thu, 17 Jul 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="xIBlWW/c"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037D2F949A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768459; cv=none; b=VrW4yaHHpP26Fd4CnwLFZxeI9STuq1jtA9SsKbd+ubAsAXBgVvHK/NydsidevmOGQ9p2rNHT2zR9Q4KH/IVBqaR5tKxttqI/Sy9vFmffXuNO33zrdysQmVkErfhUc00KkA1WKwQME+C2vJlhskZdu954EmTwsCI2w7hqUKOq23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768459; c=relaxed/simple;
	bh=lyLH5zPYEo/90zXKov9olGhnt0IMM0Xu8LtN9jXR2gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD3sB7ckAzGou8TlRerQvuv7bxHWsyKTwVQffrlHJy1A8oL3kJ3l7qua1wHzIKN/XIReAJhD5S9mnh63xX3W5vSfK4LgjiCqrpYfmILKbsK3XWCkbWb8vQ3KiboJp/dh/AE92ry2WDq79PIGwGPm4jz2od6rFw++WdteZNneDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=xIBlWW/c; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86a052d7897so94851539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752768456; x=1753373256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgpunb85reZG9xTZwbNVBuO0rswFdgZzY975TX/jRuQ=;
        b=xIBlWW/cq3uKkbFl8m9C33O7fLQes4KdNBqtNhhFQOnhqAs7XKZu9qYv/NbsW531uq
         ZgmOnLm5hc0UdmrOSq+AbHgeBhCeyLC0hThoXH/s6n3M57WCg+XH6KovAiu3+SSWiACs
         Dj+TfB4/IvOJfxq0mTeuUH7mH4MqqEuwRLsZQ1NcBzFmGcgVSxXoXkSqRCFZ9qD7ZvKC
         y7BeVaEdjXfO+rJSD5MSvr1eRiuEk+jgBUh3SEWeMcxOUg3u6kGQe1xueuCqUt+9gjcK
         95/jCpBQcaO+uRLnVecEkI4jHZeQ2kDYCo+Jj0p0QGLha1mguBccm4P/7JyhC2mWZ6MT
         NQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768456; x=1753373256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgpunb85reZG9xTZwbNVBuO0rswFdgZzY975TX/jRuQ=;
        b=HYJfnRWebQKT/T4g/fK7GFuw2M5X65QWJJYXJ9sVlZEjCXh1uz4OK1AFU1KrHeX3LF
         kqu/VoDrNbqNnuVj+dmXSmgL202PSCsB6Xgoqj/kqGZ8/uXVYFemnlNVvGbTVG6zbkmK
         reCfVCOcRh9euelOUuDZi4c8HNETDWiIOqC5m8xEPVs7DnBN3uhBizdcYLU+sWfMtjiV
         C3jWnwnl021z2wnQEKBywW7Dfcs4AXxyN/2/gEwKgC9UVMMOu67bnn7qxXnRZcOLaJaz
         ycnwDsIhzC2MwFvg7KPj9cF84vJph2SH9J23ncrozvyj6vVAsViqOBJP7a2sw/CLXYsK
         h2qA==
X-Forwarded-Encrypted: i=1; AJvYcCWnK3gZV4BoSixgZui+rv/98KLqHk+Q1zACKAII2FUDaT5OK1opgJyfuIwmyWpwmdk+9nzjQVB3N2nG03A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEa4uyG1lebxtBv00dZm2oftmwAD/ctyfocj3ImDbN1e7cH2lV
	k3/snKPlhWVS0QN8f8ClmhI7PctZPu8HPjveXZQe8HDI2QP3mFo/TMhzcqKjZlrvQmyWdACfivE
	rx1GrdT3v6nFKn8DoNt6uKjLSD1G3XbsOcb0CisSr0c2zFcXGxs+/D6o=
X-Gm-Gg: ASbGnctD3LDBC28gTOxyl9na+g7dgOt+iidPWbwIh+SE4cFJ3u6p2WkaU7LPWERVmHd
	6Je87MlxPVkKIS78+AI7H6Tn7nT9CPO0EFGyj6NDX4kDxPPbQJTG9gUoclnhdNbdJb/wmK0f8Fg
	QGWOF3eJjfKU4pIs6NFrY5yy1YVkGiXctrgX3TiXmpfkvLFm9FMojWwH5eSu7MZhZ/QBBi1jIqD
	qIDsgRj
X-Google-Smtp-Source: AGHT+IEvFzIaLhWODX98bcuKZ7fOXM6ICF0D1a2FOT238qB2mbI8P4hj1EYgmfVXY5KwbAkFGmwNg5EwCX4keK/F3+g=
X-Received: by 2002:a05:6602:1688:b0:86d:f35:a100 with SMTP id
 ca18e2360f4ac-879c08a6227mr887776039f.5.1752768455796; Thu, 17 Jul 2025
 09:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-6-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-6-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 21:37:25 +0530
X-Gm-Features: Ac12FXzE6RMfrSSbSC6EtRsKNfdVOghcMO95e74CACCW8lH380ZKbHD2qUlzeo0
Message-ID: <CAAhSdy3UGPjrdzY2x6c=SCa11i1fKZUOna_vEf+8a=ieSvgPug@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] KVM: Add a helper function to validate vcpu gpa range
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

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

Can you please review this common helper since it is in virt/kvm ?

>  static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
>                                        struct gfn_to_hva_cache *ghc,
>                                        gpa_t gpa, unsigned long len)
>
> --
> 2.43.0
>

Regards,
Anup

