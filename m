Return-Path: <linux-kernel+bounces-764675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B611B225DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556C83A4CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053F2ED17E;
	Tue, 12 Aug 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C9RFMPjQ"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D482EA163
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997958; cv=none; b=fiVSJa6S+GsFAy2FSbXiC4RqhvOgXH3aKq5mE7ql3X5M6FTsV0Iyk6ZTZk4FX1e9DdS62DDpWmyvvJzZPqPxPQk7L4s2qKDTzyZFz2XowFezBUHjcBo9SI8EQQDWXg+xoTsbz1udw2nhDPfFVWR2dXXLiyDS7ppOiTt0euGNUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997958; c=relaxed/simple;
	bh=ZKKuolHihaGCQVn/G8GeT0Fv3Uj+qdXeNK7uItuc6nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bMlAxT2TrDynYe6JU3Yb923nKGVHIxEMzh1V6f8BP3n2EQQrciCxwkXbSQpSfLN0TP8PvzG1REqTJpxorK7NQun4gMgLtbvgxyxRg/ORmZVWKqfbAO3b0mCniSplW9cy12W/n/iWdRHYSlfmHWsAMPwvcxWknnidNwrY51Duems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C9RFMPjQ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-433fa926cb9so3621663b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754997955; x=1755602755; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjfyf5ayYUQV/s7vBTZ8Nh9S9lY0mAPp0Jy1qKR37a4=;
        b=C9RFMPjQZB+x+5CCIGJW15+GJGwgSO2pCUB22WGAQ5qn1sResuds0qqZ/Ea+ouOgpG
         mhe26CxHS0jal328pzqUbVOsbaTg5Mp3k7+VVv7BvZBgO9uRDMpOROGEOOTzQKHR1PxF
         sFI009h3e1+A41OjVNaT3pAlPCsSi7VB6F9ILYgtbxaNsW72YQWihHbh4MHV2rJIPTaq
         ZdAtk52aEbYuRupIEEN1XpGVtnEYpGbD5gY0t/tCbut6hg80hXkWoFyVzfMQ3eU67l0C
         kRxN6QY2OIA5Ic5tGE0v7GgAkH9PFwFAmRAca8JDFZL/AoI3oI1teC/PgmjkxzUeLat5
         LoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997955; x=1755602755;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjfyf5ayYUQV/s7vBTZ8Nh9S9lY0mAPp0Jy1qKR37a4=;
        b=SvTS/HuALczu5PBYDeGDLRClPtVRv78bsjmJhz3HSLq9Nvyko75iCcA6kBF9OQSbpu
         mMWOCPeDJpRMURlLXS2XK5kIDBU4bgOD/+p/6FiSJ6afxyce489SPrxWQx+OPGww2LZ+
         smJNeJdmGHyryHTGsGBD1/nGVNYHuIjNXfU/TxYLEKPJ63imtQjf411Ol1tTDntsiU9D
         2vGvt/BEsDZpV9ZvMyfP6JeQqwwGU9zPZ3V+pF29VzkpUHl/EoAo/jKnRiM8hFBJJ2uH
         tYcf8r7U7OQJMBhotXIFyFySJ5jxG4gAEk3zwGFXLBrkguj9diCjxuzFlLFX6ZbZDvZl
         wuZw==
X-Forwarded-Encrypted: i=1; AJvYcCWkd6vwGXt69Z6foMFreX3ao8Zlsvpjkf9VFNfwXRM4HxjVkls7zLSOpwDRXYRhkCEhFnyX1mTZGABPDEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmUCNOZtXLhtl6mgrHnpzTCXHE5xxNgz32cdw8J9pjJEDdHlo
	Xj7oUqnppzQOCoUWhBEsLIiHpcBRswhyqU1tZfFPY1C+4G6OVkzBG9kArwoN2Lve5TrkCdpftBE
	hhCajVaxChYrt1WNXRAx0aJKLSKI57bTL+sz1KXubEg==
X-Gm-Gg: ASbGncvuk+zwNbq/wfgKdFzMAPGcG5sR7thHwcKxr9EBF3wukdo1+3XhlV95V4pjD+Y
	8CeiTTQZMdWSeSltb7rN5TROFCrCHAtPh/52cmjeIxA4EsobCj6h6V+miE+DD8he14j2NGPmGHp
	uuHt5ymnrIA5HEX06xV2X56G9m1iKtfP3fm0zmPDKC1I8JjwgyZE/E2gbo7htLAjO3JKZH6q0mP
	ZvT6gCP0uWTExG+IKAxKMXT
X-Google-Smtp-Source: AGHT+IFcPYgbej7VXqBZ9l2ZGteq16uRDcRJtLkqmXUHtMhTcloMmWBdGKMKq/p/vubapwMbfjDcv+/odkkwRTeoq8c=
X-Received: by 2002:a05:6808:4f61:b0:41b:75ca:b104 with SMTP id
 5614622812f47-435c925f657mr1622625b6e.39.1754997955426; Tue, 12 Aug 2025
 04:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250515094301.40016-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 12 Aug 2025 19:25:44 +0800
X-Gm-Features: Ac12FXzJhCUBUv-F1HNVERzz4bnGfTnGrmHS9y4FCCPn4eJYOe2JOvnJfPiVMIk
Message-ID: <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Thu, May 15, 2025 at 5:44=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> to read perf counters".
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/acpi/riscv/cppc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 4cdff387deff6..c1acaeb18eac3 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
>         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;
>
>         switch (data->reg) {
> -       /* Support only TIME CSR for now */
>         case CSR_TIME:
>                 data->ret.value =3D csr_read(CSR_TIME);
>                 data->ret.error =3D 0;
>                 break;
> +       case CSR_CYCLE:
> +               data->ret.value =3D csr_read(CSR_CYCLE);
> +               data->ret.error =3D 0;
> +               break;
>         default:
>                 data->ret.error =3D -EINVAL;
>                 break;
> --
> 2.39.2
>

The purpose of cppc_ffh_csr_read() is to calculate the actual
frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.

CSR_XXX should be a reference clock and does not count during WFI
(Wait For Interrupt).

Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.

However, we know that CSR_TIME in the current code does count during
WFI. So, is this design unreasonable?

Should we consider proposing an extension to support such a dedicated
counter (a reference clock that does not count during WFI)? This way,
the value can be obtained directly in S-mode without trapping to
M-mode, especially since reading this counter is very frequent.

Thanks,
Yunhui

