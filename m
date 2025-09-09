Return-Path: <linux-kernel+bounces-808225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF3B4FC14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4361C60A59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DCD33EAF8;
	Tue,  9 Sep 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="M9m4+FCQ"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C533EAF1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423300; cv=none; b=SApD2AYOmlFhFjbOFfPg+zAFhN16oJV5ZB1NRiyjo1bC1Pxl19oaMFRogaYbc402sg/fokQk/SK7Ll+t3urJE8oJ27a1HE19s4lGaZrZTkx9i45lBQtO7nbye6o1uWSnZu3KuvIDZWLQkLrakEcLgArfH9s5AJym+iJdhLdcNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423300; c=relaxed/simple;
	bh=zjw6MVBkpDIQn6iVFR8tdf1TpY8gbblM4BAHW35TjzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPDDw18xCCgNgQucFsjkd4snXYSAwpBQlDI9aR8UdMR4AKMmgH2lrUF7LgAl3PFc60ULUnVQ5ZnVBmKBuAJ+1TgmmtlQyENqdR09bIzwKUvQEbo1QWIpD49nPXGDWCKmptv1/qvwaRpus6AJtHFE0vDd3FbVhXRR717C7J/tCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=M9m4+FCQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-411498d92deso6404065ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1757423298; x=1758028098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H02U+YPaV9x25+zlEas3Ch0Yf6NwtoizNMk25VmvRb8=;
        b=M9m4+FCQWMfpV4rJ5Cc8HSp/ZPewVVWK1Oe9KV51QWSBbDXElqBFFGzoH5iZ4hYTY/
         ROclV46RyjrxklOol1GSy+rczzBxxSiQSIoXhl8TKI919obtkjEKIIeXvE+abN40mY1o
         EnqY/jPvFdmjJWvgdV8P50RbaLxKq0mdrPQwSZA2KcCk0FLzdNTPiLU/Lk6cC8u9/YSw
         6CLdeLsxFs3u9Lf2JFr7dC/lD1u9OpzEpsuUms34jotjIigBApcWGzdmFBtnj90xrgAV
         2wvJ2kK9d5ORmhqOInKDPIhsiIlcV3AYQtUlP+FGW15lbdTyQkDyrbZXAnD5AnjVbuRT
         WqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423298; x=1758028098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H02U+YPaV9x25+zlEas3Ch0Yf6NwtoizNMk25VmvRb8=;
        b=R4iHDlyGuPRU+ZeGYlNVhWIK/veYo80ALKECzmd2qhp5oljQ3yKv9zWXtigOa39Pzp
         wFToqQbgoDN94oLhasj5NXfgjc34MJw/WJuOvTa4q4fq6kt27HHTWbLI0eFMNo6k/f3p
         CuVSzIRHstjWdb0WdqYVyVAY8uXUKKBLc2YYkky/tVb70fFpaubzZcv0psq4GGAhq9eF
         PFIuRqMOhFTLnHBXBPlVo8wpA+YVpQMsp2pta6qDkw5QV9oCLI2+j8TK096cgov6yqfP
         L1op9fZByOiWbRf5to0niIu3xgwZXwEbPITcfGG4vBBnyjGwUMe/+JS7uCGTJr9/PqSg
         x6qw==
X-Forwarded-Encrypted: i=1; AJvYcCW2FvyqWAUvl7J/hnLvkosxF3ZUdWztiYoE9EFfm9OqM7onAMOIvInmlTYn2FCUB5iFvD3lx46fxueGlY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWo61F+ndj0PfDdrGoGGi1rLDEAPhNnX7ua555MPifa+uccf1
	QgSs9OaE4DZF5U6qwaINexHBnQjJCPVBgEV7wZ61nWznmGZDomDmsZCVqYDctx1LfZnl1RJBlvL
	gRvpRX7USg1pgEYWqqhnLgl6VYZoGxorAIolVQES2QQ==
X-Gm-Gg: ASbGncs4ap1kC+i/P+LpspAd9z1kycvYII7BOM7MUQzN1x2XJgYewe2FaEip1a+cmOA
	ebPTJ4VsLxWlVo/Bzd3/LKd/DOKEE4OXEY3v8OUn1M5S12Xl39aJhxM0PTpikwg2s1Vv9Dn7b5f
	8QqR0Uz8E/YOhR3Gm4d9cgVq1rRbrR0UIm6RpaVC/rYsopuNC8cXYe62K40fLqKzpj7VjAvlQ3s
	4+edYXvuaxXuHTFcExcWrxvnkpjjNvm9clSGZXychPFE8TdEr5zbpVsId3pkg==
X-Google-Smtp-Source: AGHT+IGIXFEd6NKG4t1EShH+ohsgxoCLtKtko69/nI1/uYg3PQTsrCp5aYkq76x9El7gzpg8jEvl7mss/PUosQ8Pi6Q=
X-Received: by 2002:a05:6e02:1987:b0:415:de5:2e1 with SMTP id
 e9e14a558f8ab-4150de504admr1018785ab.18.1757423297934; Tue, 09 Sep 2025
 06:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com> <20250909-pmu_event_info-v6-4-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-4-d8f80cacb884@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 9 Sep 2025 18:38:06 +0530
X-Gm-Features: Ac12FXxyfsjvXfBOgxxqCKAcoZ2p-9S1up8nmISURF_bFVVeW9nkGyF0NIeOPT0
Message-ID: <CAAhSdy30m5uwt1HBPoKdh6VMUjZxR6tPznUGBmb5D6YWMYPw3w@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drivers/perf: riscv: Implement PMU event info function
To: Atish Patra <atishp@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:33=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
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
> index 3644bed4c8ab..a6c479f853e1 100644
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

