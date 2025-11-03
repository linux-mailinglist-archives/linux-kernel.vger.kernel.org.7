Return-Path: <linux-kernel+bounces-882537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F52C2AAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241F81890E33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCD2E6CAC;
	Mon,  3 Nov 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0dIhbF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268214F9D6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160996; cv=none; b=IqRqMTjebXCd2LZVqpVlbP+UDYTPw1r6vCzNL/CcQPTVIOv8RotqrV5LKMuraDGHYUOfpWh3X0oNdSQKneh17o+IaSscJbveV4q9/Q2wLhH55OanJ04+lVRKqSwsQGVv3K/ihno9hMnIU3SBDoaTOCF0XVN65ebNFoJ9Tc8cDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160996; c=relaxed/simple;
	bh=Pz4RARoS3t59jewVdeEcIvG3LcpwFyzVpFQTf5qdx/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4TF2p6UB++5I657gx0wGdOmsngq639IDWrF0/dR+qR7MtO10aEL/WwjWOFIDa0kAQYVF7rbbSP9L84KJWOvR//GQl3PYl9OF6MKevOSaBD8FALKCRLiueBdY+z6nAV4vYxfP8PaKNXmzBttywM08hAb/C2hYUjcoFr73Ez9sk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0dIhbF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F2AC4CEFD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762160996;
	bh=Pz4RARoS3t59jewVdeEcIvG3LcpwFyzVpFQTf5qdx/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K0dIhbF5sB9h/u7I394UPjJMwCjgICv5u/G4q0WuObozs8vlLLEqBZh7O897iCHcd
	 eUd1rFIqw+VaEZ0VKb6xofumRHuSCFI3DDAJnnQpdgAtNGGfFWUUYsN4KvkO7Osdcl
	 gaYDcEaEZKCC9UWvr9eGJW2T7k4EevGgkDlFFKgGs4r9AEBtlrG149TGLfXT0pmJC1
	 htEd09q1QZjQOjgZoDAuFoDwJ3JRAhw5Sdq6wyk4zJISVmbFF61Z999IjyBv3yNScL
	 WqxHlhqGfK2QjIf7n0aTGUtAwCizxQ4DVRzGuEzdKZbd5Iy/4oxk7chnqk4WinEbzy
	 4yPLsbocLzKTQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7155207964so68864566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:09:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwQnRsmovJG4uhfuU+oXdqze5AJ54uCdvrYgsgWHNswTiqSDaMy5RZkVMRU9Gn5Qp6LOKFKZPuXFTBTHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj1Wi3iUIHYuuq/MNIuetUYQzMn+Z+IRE+yFLyGsNRurjyFJ5
	Xx92ou9BxhMLpnIOfYQ7oVMTi9s7rWwnNhSQoRaMW3Qe7+r0reR6tV0qpXuPMYCDfZK5oYT/ack
	R4/dqTMSpCTNwFcUl/Hc/AgAmz0Wvtlo=
X-Google-Smtp-Source: AGHT+IHH7GRdDkSolFd0DKvnUwGufJhMU7ivv5E8xIf9Cr4Xjt0Gpi6A0fSAtca/U2zc7oqlkzM9lEUk2yQyn4++emQ=
X-Received: by 2002:a17:907:60c9:b0:b70:b064:133 with SMTP id
 a640c23a62f3a-b70b0641cd1mr418428166b.4.1762160994556; Mon, 03 Nov 2025
 01:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014070227.22396-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251014070227.22396-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 3 Nov 2025 17:09:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6uRnP6MD7aV0fC-uL+rihuSDw=Opmx=0keQ9gFp9ERhw@mail.gmail.com>
X-Gm-Features: AWmQ_bkZB4Ki-eY515Azwze_fTHRu9a-drb485T57pjSbKfaeIiEUUlUNniRcRU
Message-ID: <CAAhV-H6uRnP6MD7aV0fC-uL+rihuSDw=Opmx=0keQ9gFp9ERhw@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: Refine init_hw_perf_events()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied without rename loongson to loongson64, because loongson32 and
loongson64 have different event numbers, they need to be
distinguished.

Huacai

On Tue, Oct 14, 2025 at 3:02=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> (1) Use the existing CPUCFG6_PMNUM_SHIFT macro definition instead of
> the magic value 4 to get the PMU number.
>
> (2) Detect the value of PMU bits via CPUCFG instruction according to
> the ISA manual instead of hard-coded as 64, because the value may be
> different for various microarchitectures.
>
> (3) Rename the PMU name without the postfix 64 due to it is redundant
> and may be inaccurate.
>
> Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-E=
N.html#_cpucfg
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/loongarch.h | 1 +
>  arch/loongarch/kernel/perf_event.c     | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index 09dfd7eb406e..89343b1a526f 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -128,6 +128,7 @@
>  #define  CPUCFG6_PMNUM                 GENMASK(7, 4)
>  #define  CPUCFG6_PMNUM_SHIFT           4
>  #define  CPUCFG6_PMBITS                        GENMASK(13, 8)
> +#define  CPUCFG6_PMBITS_SHIFT          8
>  #define  CPUCFG6_UPM                   BIT(14)
>
>  #define LOONGARCH_CPUCFG16             0x10
> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/p=
erf_event.c
> index 8ad098703488..ee5404d28423 100644
> --- a/arch/loongarch/kernel/perf_event.c
> +++ b/arch/loongarch/kernel/perf_event.c
> @@ -846,18 +846,20 @@ static const struct loongarch_perf_event *loongarch=
_pmu_map_raw_event(u64 config
>  static int __init init_hw_perf_events(void)
>  {
>         int counters;
> +       int bits;
>
>         if (!cpu_has_pmp)
>                 return -ENODEV;
>
>         pr_info("Performance counters: ");
> -       counters =3D ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >>=
 4) + 1;
> +       counters =3D ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >>=
 CPUCFG6_PMNUM_SHIFT) + 1;
> +       bits =3D ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMBITS) >> CP=
UCFG6_PMBITS_SHIFT) + 1;
>
>         loongarch_pmu.num_counters =3D counters;
>         loongarch_pmu.max_period =3D (1ULL << 63) - 1;
>         loongarch_pmu.valid_count =3D (1ULL << 63) - 1;
>         loongarch_pmu.overflow =3D 1ULL << 63;
> -       loongarch_pmu.name =3D "loongarch/loongson64";
> +       loongarch_pmu.name =3D "loongarch/loongson";
>         loongarch_pmu.read_counter =3D loongarch_pmu_read_counter;
>         loongarch_pmu.write_counter =3D loongarch_pmu_write_counter;
>         loongarch_pmu.map_raw_event =3D loongarch_pmu_map_raw_event;
> @@ -867,7 +869,7 @@ static int __init init_hw_perf_events(void)
>         on_each_cpu(reset_counters, NULL, 1);
>
>         pr_cont("%s PMU enabled, %d %d-bit counters available to each CPU=
.\n",
> -                       loongarch_pmu.name, counters, 64);
> +                       loongarch_pmu.name, counters, bits);
>
>         perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>
> --
> 2.42.0
>

