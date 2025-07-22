Return-Path: <linux-kernel+bounces-740152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990EB0D0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED826C459B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443028C02F;
	Tue, 22 Jul 2025 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="jwzMcAPw"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557881581F8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156540; cv=none; b=MtlT5PFuM+7cYpisHzBK6iCeqgotUsAECmoTBbB72xz/SnH9APZD2FF7ZaoRN07PmXWrrOi5CdcDF4UK0DzM1u1NvHEcaGNOEs6S69qjwpnbcD5TFKChs1uxSKw9eIrMrLi/1QPi2EsVYBSHdDi7dmtOvjOOZQPzqmricCzfRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156540; c=relaxed/simple;
	bh=X8ELocRG2bbTVYA6DDgIJCfy248wuByj/BRhI/CuJIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSWykBXwGWvOUmQ+z57fAGdH+gxWxs8vR9jLRhifpNc7i+a83SFFPjlliZnjpNvCSZSkcUuea3PNR9qlDPiprembOOcG8pxiS+BiuYgASwY+5V3w9mJf9SDeRwu9E8NRx4nwxOiZXqch6M3qLEe9gMBeypAKSnaPiwPaRd/a5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=jwzMcAPw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e28bf4a350so26638855ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1753156537; x=1753761337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTiIswXCUeRqcifdr1qmaG/ebZiMNguVP5JbzVmVURc=;
        b=jwzMcAPwSlRKTmRftTuTAI8hnPY0MzaxbEhefINEprGGoaSHdoIKm16z6FB4mslcea
         Zzerpd9yU48pWhdcJojz5nrBNNaKfYyK2+cIZYbgAB70recR2TBeX9xOvKQIkjmtPB3H
         mQsKpqhhr7boHX2uJ0ujDSddUn3loGLmZ1Lu/dZ7Di0YwF/9iSn2hcWVaGOAN3Zysudp
         AdUkLppJGIkd8hm1hQdEs1t4lEiT/I+UDZeh/J+toFrpOUzvAgNm81sHf0fnP2x30zk5
         VsWXJXKSlgybVcwmdaejPbntdg+KYWjB6yYkc8Hvjg7vQylwnFi2rdAEmVXoUVgRWvNq
         oUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156537; x=1753761337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTiIswXCUeRqcifdr1qmaG/ebZiMNguVP5JbzVmVURc=;
        b=aRvhBCnMLd9Ntqf7g5SRUUVwU775Fmi6KPNwg3V2UTGkAiS43LUK/SgxxHV+zAAl3i
         ojkFwJesJCdBQEegljRv7JGZwinNCFS5bcNPi2p2+JfYeOB4e4CJq7A8FvV5OfST+K+/
         iFRK7NP0oWpV4o0oO67R73GhwP78Q/f4Mj5H1pwPuMsmBdnYXGX+xprsqFSPjif6u1iA
         3ovzgBJgzfAlRuVrvivtFRS7ZqPuTkaXBb1YnQYSv/RzXYqVvNxGqE0tgrlNxUHGvAMP
         Q3CeRcOD4tlRAb/pG7oyRWjqZjOrt6s/Re+rlZ8ZW6aoZUfK56fhGGhqbPmi+vWGU9UQ
         CdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPfoIM6ZPJbnm7eqGRvZWF43531jcPLJy6Cw53pmCdqApZoZw8i0Wks9V4PvYSgCYd7ZhsaMvj76supKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMC85H0hVELnh18Bu5hbMyT/tjJLwit6VCpzR4eB7EPeihX2W
	sgAd/b9aQXebZULqI3MC9NwySYsUZ3aYQVn2reMwapX/b+jdRJ3/4Cj0jNnDxSsr4J/fORdtiVs
	1qWD4wn90g5iMerkZo/aelpF6GBTZkE3oMnW1C3Lh+A==
X-Gm-Gg: ASbGncs9MyVonkej2rLuNwlJ6LWDg+4PHkIkFqLSIJWPRNvdNoSrQ/woaLjp0lUl/mz
	FEWTVt2pcn6ZfmBnlQw4Y8vu7Jg7VEPUZPNOiVvR44Xtzlzmwclt/1zC4NvhgQx948DTIPiYxss
	fWx1yn7qKSPzzJIlKed0owofaubFMPm+E/yL0MglntBBXJbhBhtQCnN8iq8qgeOdmms+e+VMpkW
	3gA38Dr
X-Google-Smtp-Source: AGHT+IEOqS8YGgVoprY+8f3pC+3mkVKAq8JUCoZfCHkL1OAyGAf9GO3LLl24tZ/Rk5tS5g9YXKMA+WXBYy2KvEy5e+c=
X-Received: by 2002:a05:6e02:3b85:b0:3e2:a868:8bfc with SMTP id
 e9e14a558f8ab-3e2a8689009mr128348475ab.17.1753156537299; Mon, 21 Jul 2025
 20:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com> <20250721-pmu_event_info-v4-4-ac76758a4269@rivosinc.com>
In-Reply-To: <20250721-pmu_event_info-v4-4-ac76758a4269@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 22 Jul 2025 09:25:26 +0530
X-Gm-Features: Ac12FXwLvJgSGjfrNWw90BLHUksAPu_rJedadgUcf1wkEVZ7pdyL3Xk4uR_QcQg
Message-ID: <CAAhSdy1KHTW4J+OKVgBof2gQDfFuKq0H9rrmsJ7L2KBRXtzuaw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drivers/perf: riscv: Implement PMU event info function
To: Atish Patra <atishp@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:45=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> With the new SBI PMU event info function, we can query the availability
> of the all standard SBI PMU events at boot time with a single ecall.
> This improves the bootime by avoiding making an SBI call for each
> standard PMU event. Since this function is defined only in SBI v3.0,
> invoke this only if the underlying SBI implementation is v3.0 or higher.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h |  9 ++++++
>  drivers/perf/riscv_pmu_sbi.c | 69 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index b0c41ef56968..5ca7cebc13cc 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -136,6 +136,7 @@ enum sbi_ext_pmu_fid {
>         SBI_EXT_PMU_COUNTER_FW_READ,
>         SBI_EXT_PMU_COUNTER_FW_READ_HI,
>         SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +       SBI_EXT_PMU_EVENT_GET_INFO,
>  };
>
>  union sbi_pmu_ctr_info {
> @@ -159,6 +160,14 @@ struct riscv_pmu_snapshot_data {
>         u64 reserved[447];
>  };
>
> +struct riscv_pmu_event_info {
> +       u32 event_idx;
> +       u32 output;
> +       u64 event_data;
> +};
> +
> +#define RISCV_PMU_EVENT_INFO_OUTPUT_MASK 0x01
> +
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
>  /* SBI v3.0 allows extended hpmeventX width value */
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7331808b1192..433d122f1f41 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -299,6 +299,66 @@ static struct sbi_pmu_event_data pmu_cache_event_map=
[PERF_COUNT_HW_CACHE_MAX]
>         },
>  };
>
> +static int pmu_sbi_check_event_info(void)
> +{
> +       int num_events =3D ARRAY_SIZE(pmu_hw_event_map) + PERF_COUNT_HW_C=
ACHE_MAX *
> +                        PERF_COUNT_HW_CACHE_OP_MAX * PERF_COUNT_HW_CACHE=
_RESULT_MAX;
> +       struct riscv_pmu_event_info *event_info_shmem;
> +       phys_addr_t base_addr;
> +       int i, j, k, result =3D 0, count =3D 0;
> +       struct sbiret ret;
> +
> +       event_info_shmem =3D kcalloc(num_events, sizeof(*event_info_shmem=
), GFP_KERNEL);
> +       if (!event_info_shmem)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> +               event_info_shmem[count++].event_idx =3D pmu_hw_event_map[=
i].event_idx;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> +               for (j =3D 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++=
) {
> +                       for (k =3D 0; k < ARRAY_SIZE(pmu_cache_event_map[=
i][j]); k++)
> +                               event_info_shmem[count++].event_idx =3D
> +                                                       pmu_cache_event_m=
ap[i][j][k].event_idx;
> +               }
> +       }
> +
> +       base_addr =3D __pa(event_info_shmem);
> +       if (IS_ENABLED(CONFIG_32BIT))
> +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO=
, lower_32_bits(base_addr),
> +                               upper_32_bits(base_addr), count, 0, 0, 0)=
;
> +       else
> +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO=
, base_addr, 0,
> +                               count, 0, 0, 0);
> +       if (ret.error) {
> +               result =3D -EOPNOTSUPP;
> +               goto free_mem;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
> +               if (!(event_info_shmem[i].output & RISCV_PMU_EVENT_INFO_O=
UTPUT_MASK))
> +                       pmu_hw_event_map[i].event_idx =3D -ENOENT;
> +       }
> +
> +       count =3D ARRAY_SIZE(pmu_hw_event_map);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> +               for (j =3D 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++=
) {
> +                       for (k =3D 0; k < ARRAY_SIZE(pmu_cache_event_map[=
i][j]); k++) {
> +                               if (!(event_info_shmem[count].output &
> +                                     RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
> +                                       pmu_cache_event_map[i][j][k].even=
t_idx =3D -ENOENT;
> +                               count++;
> +                       }
> +               }
> +       }
> +
> +free_mem:
> +       kfree(event_info_shmem);
> +
> +       return result;
> +}
> +
>  static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>  {
>         struct sbiret ret;
> @@ -316,6 +376,15 @@ static void pmu_sbi_check_event(struct sbi_pmu_event=
_data *edata)
>
>  static void pmu_sbi_check_std_events(struct work_struct *work)
>  {
> +       int ret;
> +
> +       if (sbi_v3_available) {
> +               ret =3D pmu_sbi_check_event_info();
> +               if (ret)
> +                       pr_err("pmu_sbi_check_event_info failed with erro=
r %d\n", ret);
> +               return;
> +       }
> +
>         for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
>                 pmu_sbi_check_event(&pmu_hw_event_map[i]);
>
>
> --
> 2.43.0
>

