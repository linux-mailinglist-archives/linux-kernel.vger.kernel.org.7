Return-Path: <linux-kernel+bounces-735515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9AB09061
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165233AA874
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CD1E8322;
	Thu, 17 Jul 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="VUtassdx"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555418FC86
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765441; cv=none; b=uQ/QlmCY5k4qos42d11KzdOzgYYWXpi3JXxajaZsToipjaapXBMP51VPai+8Jtpk2dNGVqu6NLQio6XkleeVh56sMP5OYdqPMnJbjDuH5JQSP6GBDU/+T5ODq/OiB25X5zfxBVAcRA8yJSCXvk1HznU6RcK8PbHwg+ec4zeUxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765441; c=relaxed/simple;
	bh=Dmx0deA06SazWXaBN/smo57DbddeC1VfCpawbGBHF8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk/skEy0UXenUSXpOJxmzQb+dadUXqVipPSdT7y13+yRIK6juPW++fUOhP02OLvFeAHDrBIHwT79/IJEz23xL6r9RsNqytDX0i4juJyAAaDvYFgQNAc1cjhKxMNPwWBvWXI+Ei7qRAR64NsZAw+pPAZEhAe5tO3TNPwHnML7AtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=VUtassdx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e32c95775aso102556385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752765439; x=1753370239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3tUz+FrzCtl0Vbggujp06ap3pA8xukaziREmjLBWYA=;
        b=VUtassdxmZuxujJyHhBBCWVJJbQW6YGCfJXjFNFG33B6stU1Vs3C0qwGt6TR9YXmAL
         FY3KfiwDTAnNly1ZeounXNX63lB4zxlxdVKTvSk5ujVQ7FfS50T0TMIq6DWycrREh4dW
         c6weV9nAmgyFZHTfifxsnHlF4FXZa5zf7UNXQXqdmPH29jSC36Ga+v+QWYZuubadNkYm
         bf5wRFpOUnl8Y0Jvng+WN0PimNdQjkFHxjf3TRU1v98dvNalTJkuVWcH0Wvk5tux+c3n
         Us5ezcJ2lompT/cOStjg0vwsjUvkXQAp1d/zqw4XQNbYVr/KyvTeKW2g3iwlpZ+osNDX
         gXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765439; x=1753370239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3tUz+FrzCtl0Vbggujp06ap3pA8xukaziREmjLBWYA=;
        b=AyK5ss5zPMaF1gXOIyXZP+TVPAz0UTRX23LgxgsHlnyaKc7aMLuC/0keSpJhH9Ioqe
         pLR7bmkcOhTNgudUZ2HGBMmaNwGebu+KWUq4gvGMjUbDxyHnfjKdkr3rKOy3Du59S8zD
         laA+e4dkb1HjDpHB18EXNJ6lM2HzPJE6lX9ddTgt4iK73d1zjyFDdTE1qstDXyHfiNCc
         w7lFOW+DF3L9lYu6ltppVc55RLKF1BqTnqT0WudGFQsFFwcpRqj3WPcMkcFi7OupvXdz
         1JCnkX5YoHyryF8Jjrxrvv8w4P/C/GLmjAuI7vU5Lub2skbpWtl+L4mPKleyFJ9+gKIO
         PYbg==
X-Forwarded-Encrypted: i=1; AJvYcCU6hhzdWzGnTH0m1atceXp0VKVmYUaL1RnLcbO1zbn8NBSZbSXBXlY5Yf1gdTgovxl2N5P+K2l1Dng/4s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1mzv5qhyxXeJ70ly8lyb1FU5Hz4+9dx7336TKVTqrHGXgOou
	eRSt0pLFHpL30ApDL5LxTONc1Sq0gFVlK9QFRxSEC34uGRi/1hMQ2PtmUc6A4kfCFQcBEk7nsD6
	YUDd16Y3I217lUX/T5ywspbR89XTB1qEAYjXf2DN2cA==
X-Gm-Gg: ASbGncvhfOHyTgmgEGU6OS7EL08+Y1oCQUGG3+R6cTkXkSQMBj0aK5kFpWDaZI/IKX3
	uxBDgclHCUPuHoXL9CJ18NoA//uNqDNMLP3sbFU/c77f17XLmrI+uiV5p+Cc0lMSGZqPc8NSwFe
	ThMs77dVc8XGnag2jQyrQv7ukpXvJ31rG4DhB2qJUqK/Q4dCCPQpbAVYOmRXkcT3jlNwejfzDc/
	TtdP5qC
X-Google-Smtp-Source: AGHT+IHz2ooSEYMwChi5WNQfJsDufDgq6WJG7AmXKC3wtaW/L8MYe8nihHSBFgq+2TYbHnsMVgzMJk9i+88DE/6bDYA=
X-Received: by 2002:a05:620a:7017:b0:7c5:5fa0:4617 with SMTP id
 af79cd13be357-7e343615e30mr946456785a.40.1752765438473; Thu, 17 Jul 2025
 08:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-2-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-2-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 20:47:06 +0530
X-Gm-Features: Ac12FXzD0efP_qu0iiVx1ulFC3dW-BDJaKPty1r8E1h77LH8P4Y_H1glg7EyAyo
Message-ID: <CAAhSdy02kKJ0PHjyeGaV1-pC3DVL8-VcQ=EB+ha69=_CAQb2xg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drivers/perf: riscv: Add raw event v2 support
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
> SBI v3.0 introduced a new raw event type that allows wider
> mhpmeventX width to be programmed via CFG_MATCH.
>
> Use the raw event v2 if SBI v3.0 is available.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h |  4 ++++
>  drivers/perf/riscv_pmu_sbi.c | 16 ++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 3d250824178b..6ce385a3a7bb 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -160,7 +160,10 @@ struct riscv_pmu_snapshot_data {
>
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
> +/* SBI v3.0 allows extended hpmeventX width value */
> +#define RISCV_PMU_RAW_EVENT_V2_MASK GENMASK_ULL(55, 0)
>  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
> +#define RISCV_PMU_RAW_EVENT_V2_IDX 0x30000
>  #define RISCV_PLAT_FW_EVENT    0xFFFF
>
>  /** General pmu event codes specified in SBI PMU extension */
> @@ -218,6 +221,7 @@ enum sbi_pmu_event_type {
>         SBI_PMU_EVENT_TYPE_HW =3D 0x0,
>         SBI_PMU_EVENT_TYPE_CACHE =3D 0x1,
>         SBI_PMU_EVENT_TYPE_RAW =3D 0x2,
> +       SBI_PMU_EVENT_TYPE_RAW_V2 =3D 0x3,
>         SBI_PMU_EVENT_TYPE_FW =3D 0xf,
>  };
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index cfd6946fca42..273ed70098a3 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -59,7 +59,7 @@ asm volatile(ALTERNATIVE(                              =
               \
>  #define PERF_EVENT_FLAG_USER_ACCESS    BIT(SYSCTL_USER_ACCESS)
>  #define PERF_EVENT_FLAG_LEGACY         BIT(SYSCTL_LEGACY)
>
> -PMU_FORMAT_ATTR(event, "config:0-47");
> +PMU_FORMAT_ATTR(event, "config:0-55");
>  PMU_FORMAT_ATTR(firmware, "config:62-63");
>
>  static bool sbi_v2_available;
> @@ -527,8 +527,10 @@ static int pmu_sbi_event_map(struct perf_event *even=
t, u64 *econfig)
>                 break;
>         case PERF_TYPE_RAW:
>                 /*
> -                * As per SBI specification, the upper 16 bits must be un=
used
> -                * for a hardware raw event.
> +                * As per SBI v0.3 specification,
> +                *  -- the upper 16 bits must be unused for a hardware ra=
w event.
> +                * As per SBI v3.0 specification,

The text here should be "As-per SBI v2.0 ..."

> +                *  -- the upper 8 bits must be unused for a hardware raw=
 event.
>                  * Bits 63:62 are used to distinguish between raw events
>                  * 00 - Hardware raw event
>                  * 10 - SBI firmware events
> @@ -537,8 +539,14 @@ static int pmu_sbi_event_map(struct perf_event *even=
t, u64 *econfig)
>
>                 switch (config >> 62) {
>                 case 0:
> +                       if (sbi_v3_available) {
> +                       /* Return error any bits [56-63] is set  as it is=
 not allowed by the spec */
> +                               if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MA=
SK)) {
> +                                       *econfig =3D config & RISCV_PMU_R=
AW_EVENT_V2_MASK;
> +                                       ret =3D RISCV_PMU_RAW_EVENT_V2_ID=
X;
> +                               }
>                         /* Return error any bits [48-63] is set  as it is=
 not allowed by the spec */
> -                       if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
> +                       } else if (!(config & ~RISCV_PMU_RAW_EVENT_MASK))=
 {
>                                 *econfig =3D config & RISCV_PMU_RAW_EVENT=
_MASK;
>                                 ret =3D RISCV_PMU_RAW_EVENT_IDX;
>                         }
>
> --
> 2.43.0
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

