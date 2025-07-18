Return-Path: <linux-kernel+bounces-736257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C899B09A99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D1A60377
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50817A2FC;
	Fri, 18 Jul 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="V5TS1EEM"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2217CA17
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752813651; cv=none; b=i3QRkPuv+2pnBwsxnU6/Jw90z6MdfU+Knb10iRGL1TpuU95PY1iHSM9npOAQOIXKOx3O4vBw1/Nhae06KGPbDb1kL/3OrUYZEKtmC/sn9HO8F+V0nGVGxRcq3hk1YmiT5Sg6iBciunLFjoVONmU+xnKfzsibGu69dhFaMws4UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752813651; c=relaxed/simple;
	bh=5zM8DCe1lBw38qNyO5y7XCt1O6HiCZVd2nvimi22HCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAJd7IZQBmnJnukyFY0l8QbCDfvtdXTGadYfjM9d6aSRJvCqH3Tkns2PIPnL7T+zxqgbMUuDbpgQjQv+MeXE8REzDEjHAfGUwgGxarmwbWpltjPUaGRP7ubqQx2yXYzpkKxtI9kNvVoZZAstKDT44nowtfhl1Q25sJDMPl+9d/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=V5TS1EEM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so6736475ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752813648; x=1753418448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk5P6Goql09+zLhT4UFf1bxLMW3kkptTgrc0lcznfeI=;
        b=V5TS1EEM/jU7RSBbsMAkyD86s/zQ0sOKa7y5DI1iuIImuP9IQHvemz4INiIDaSaAgX
         nPpazDTNOJV4M4ZV6vtqg/WvgjrafqQf0l91HRiJe0cDbT/dmPSFXd1D5vRhoiGIjYVH
         tSOInHw/SZMEQADakdBqlNjWd9PddGgd+QykckAK4aiR/cGYVbCrUbfMd0wvW1GWdHgu
         1szaVBrJ9RCQo3AWrSlPMtjyMfiWRmUZIL9j96jkzii6W4AVr1QcOZTT0RTUf+3Ydzv9
         L12zXe2xUEeVZBApqjch9XF4neiK4WjiPTI+zKdFWQaNLkSGVF12F1v66QlXawFoJi9D
         kYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752813648; x=1753418448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk5P6Goql09+zLhT4UFf1bxLMW3kkptTgrc0lcznfeI=;
        b=jCFvq+/4yOF0GwlTpA7KdjyvTixaXnnmj2dDtWdHCaoxi94Qh1OxO+bOW1PNF921lB
         bvxLaV6pyPan7wzy+OJpn4T40rePPGIwR5AvYX0EI9l4zYv8G6VetFTlVZInijTCxiYv
         Wvl4N9hjK1qIu+lksQkB6k+TL6LCajuF1JTMMmFoX8fivL4Wi+Sj9dS+MRugMTq4YSim
         qp+KWY7zHtkdTlDZry0rni+G3SDr8JcreMCrZT3OnvsDlbdzosPOs8TjmDWsuBsV7X0u
         IJla/Whu5S8pcBNYMlaICp4h711l3OLQzWhN/8zqq4VR453xJwCCuxStTRjQeqHFx2oD
         Yonw==
X-Forwarded-Encrypted: i=1; AJvYcCUz3MQ7WUNG1qwsqhyJLAD/x8Je5VE4P9eg96qvWcNrbKSX1+TgNA1QbTqoVxtXOdOh2TM/jnOZOFMP5KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYdcpKTY/LW/L6dqDoSe55ZNlbF/Qq0dSiB1LxlH2H6cbGde6
	M/lArGmDCV7FhD98ya22pa6DeyMIzxG2B5U5U7ydrJw7+tVluR22P12ymoi6YNOTXDc64R7B25r
	mYpI+pswYKABwl229w7TbVKDSIslzFW13ulCNf6kzN61dMXVZ/ihE
X-Gm-Gg: ASbGncu1XoDqtF614wEjiyfFb2eFr2gWqJWMU1jL0p08pyked6jn+THrjxKanPv+KP8
	4ayngYGxRWIzFHnjtuo1HiMA1ryvH25Pjil2PgGiy1x/EYLit59GhbEGdlIqICA/k6tZYIwk+e8
	1oARWHWxjpqC879z76f5uSfICHJKkj+0oXZbelLIS43IV83/SdguaW9d1jbnhFGGkX3/2Bltsxr
	6+Io7QC
X-Google-Smtp-Source: AGHT+IEaxS0XjYOehQPTaQpINVNdrhTY0WgdZfr1X928tkogrZyS3xluTJGJB4k36Lrfe/UfgaiC4ceggmbdl7StqFo=
X-Received: by 2002:a05:6e02:440e:10b0:3e2:91bb:c075 with SMTP id
 e9e14a558f8ab-3e291bbc1c1mr30213165ab.22.1752813647913; Thu, 17 Jul 2025
 21:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-7-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-7-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 18 Jul 2025 10:10:36 +0530
X-Gm-Features: Ac12FXxfH_kRUff1qKzc565myWI6pwy0mWoGInqqgjbhV1vA028RQkFxaIa9Vtg
Message-ID: <CAAhSdy08d8DJL_kurFwHSTEm3i+0wv=Nfd0xP+kKR=6rFdm27w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] RISC-V: KVM: Use the new gpa range validate helper function
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
> Remove the duplicate code and use the new helper function to validate
> the shared memory gpa address.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c     | 5 +----
>  arch/riscv/kvm/vcpu_sbi_sta.c | 6 ++----
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 15d71a7b75ba..163bd4403fd0 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -409,8 +409,6 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_=
vcpu *vcpu, unsigned long s
>         int snapshot_area_size =3D sizeof(struct riscv_pmu_snapshot_data)=
;
>         int sbiret =3D 0;
>         gpa_t saddr;
> -       unsigned long hva;
> -       bool writable;
>
>         if (!kvpmu || flags) {
>                 sbiret =3D SBI_ERR_INVALID_PARAM;
> @@ -432,8 +430,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_=
vcpu *vcpu, unsigned long s
>                 goto out;
>         }
>
> -       hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writ=
able);
> -       if (kvm_is_error_hva(hva) || !writable) {
> +       if (kvm_vcpu_validate_gpa_range(vcpu, saddr, PAGE_SIZE, true)) {
>                 sbiret =3D SBI_ERR_INVALID_ADDRESS;
>                 goto out;
>         }
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 5f35427114c1..67dfb613df6a 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -85,8 +85,6 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_=
vcpu *vcpu)
>         unsigned long shmem_phys_hi =3D cp->a1;
>         u32 flags =3D cp->a2;
>         struct sbi_sta_struct zero_sta =3D {0};
> -       unsigned long hva;
> -       bool writable;
>         gpa_t shmem;
>         int ret;
>
> @@ -111,8 +109,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kv=
m_vcpu *vcpu)
>                         return SBI_ERR_INVALID_ADDRESS;
>         }
>
> -       hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writ=
able);
> -       if (kvm_is_error_hva(hva) || !writable)
> +       /* The spec requires the shmem to be 64-byte aligned. */
> +       if (kvm_vcpu_validate_gpa_range(vcpu, shmem, 64, true))
>                 return SBI_ERR_INVALID_ADDRESS;
>
>         ret =3D kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_=
sta));
>
> --
> 2.43.0
>

