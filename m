Return-Path: <linux-kernel+bounces-875347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA452C18BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CC1AA63AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC830EF75;
	Wed, 29 Oct 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iq+UgPcI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44719E82A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723829; cv=none; b=oDCQge0r4nPrOlhGXZb5Z9DucRmI0RJps7OGq9DqSpiZby/tBUD7NhogPkQlJ7UghlCYdqCodJ1OZMGy70szyxLBL7K7zrI5ExV9I/5LKoHPqXKoTqL7E6SX+952p0H4gik2Z5on3r2WIKus2zHBbQy+iqCUhE+oIR76jABg+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723829; c=relaxed/simple;
	bh=IB9sd6gipX/qYArJRhrpjQ+BcWNXqqrHglUJou/5I2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knXOp+EK/O+lMbQ22qjxqa1cgS9TWZ6AEKc5wzgdRsuA0OApJ8fSMzfyXv6FggclWQ37NYRTCuJMvQuqZw1lcnW1jcMvmta8FeJoGseBwW+V0aMDFRvozo/pOI7ZQHYykEtIe/nN7HnCUg6RgncYdIlOm+OP7Z01CYRbg2nTHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iq+UgPcI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso1626665a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723826; x=1762328626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QJdsB3CjdVCbfqrBmJ9+o0taTFoapIJ6xy+pwiqQzo=;
        b=iq+UgPcIZzYTar2YamFjB1hNgOEZ/Sue+32X+vBlAWG9gp4LlbzcqU74z+i3ceGP95
         QcbiBvhrRTKtOu+USXYXWcjhAMKRiRse+S0e+up6zLw1zQm9YXuuF8z+le9/OiKOU6CX
         4vnfc4+GCFhLMx0l2vkLvwSik6rYBWtzLF4kUfyD6bB8g+fG4zL2NMrOWIonvl/xGrPB
         XkzteU0VhuUDewJC+CAOjSKYcCHs7zzQ4KAggBM9VVWyBBEs32OfupGqOJX/OlufLwzT
         oTQy5h7Mx1c8Vztwlc6JAkxYn5zAr7sWj9PmEsC6Y2tw/BfpGvWIIi/7YQCIKq+i9doS
         ao3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723826; x=1762328626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QJdsB3CjdVCbfqrBmJ9+o0taTFoapIJ6xy+pwiqQzo=;
        b=Fk5i78c/tncTOsClQPYQgXyG3J9TIl5ZbCks768Zf3s00/saQbls7utRxtCl79BlWr
         JycKeeQlmziEcKhO2eVFMslM60XNCa/NyeRbl8j7PqvuYS0JXOS237hv7sbK7+7RIwzI
         RVyITxwIcMqurM9CjnuebtbDEqZNLud9hhtn0T1ytwNOsb5JWvYTyro0SLJe2HOPkNfs
         qibbFLk0Ac2gZMdwm8aQ63SAYQOam/xxWwinJor/LC+WrsPuDKVRWlCgAqg4JYCmQRZ4
         h+tuuTKpdhl6JZXpOLb03db3IVOamFzNp3AcBcI0tazj3yKBEfc4Qu8ZkwNucEL9tR1z
         8h8Q==
X-Gm-Message-State: AOJu0YyOirsx8j16GChoHKDWYZU17VFIqtmnR8ObbQ2K6sb8KOG1eVnF
	Gzg9AZZ1c1EE0BdOUvGqTJ8TavkhwrVCvxomlsvxasgJEodZv2fnhc/WE2Vd/bJ1tHJKQrO5JM3
	4emHDc4Qis/8bu/l4UAJrWjyn1/N/dUz0lnX1cBG6hQ==
X-Gm-Gg: ASbGncuRpBFT0REbxIB6a8WSZbnB0PpYnwvlc19FJG19tGLAEsR4o4ePHHDDx5T2wY3
	g/Lwj33QgMK7lopssXRt5wLFK2sOIA0AvGeTxaDy3H+8DiR7Lf5XX2prwRY6iZSTJ7U158gQGpM
	hYcxNBJyk5ciXXjekGnc1ZYUrPgTBG+qRBIVQYYWxpCe2TJMkZZiOsaElKx/Hmv24NnncpYjPNN
	BGfkpIxY1LneIfHGTc2199Gnntb2hZboHnrfqAMIFF+kl8QVJVxzZTRcD1JOb11tcx7mMNfKeOh
	42k7Qr19UnG8yg==
X-Google-Smtp-Source: AGHT+IGwa7kxpUV7cbF3Gyr4ts2tbnj1GVUS4cjO7t5XPX0Dwt2qV9vPpavgEaPmQhBv+TC5JU0symBxgYRwUmmqHWY=
X-Received: by 2002:a05:6402:34d1:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-64043331cd2mr1603470a12.18.1761723825601; Wed, 29 Oct 2025
 00:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029060757.2007601-1-srikar@linux.ibm.com> <20251029060757.2007601-2-srikar@linux.ibm.com>
In-Reply-To: <20251029060757.2007601-2-srikar@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 29 Oct 2025 08:43:34 +0100
X-Gm-Features: AWmQ_blZ2yqBcrOpuaElvS05llD7_qQHEAblunp_kpRtAliljejhoeSfrPPCPYM
Message-ID: <CAKfTPtDW9rApEm+4qSrEpRDMA+68BnVOgegKUZUa5S-gKnR--A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/smp: Disable steal from updating CPU capacity
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Ben Segall <bsegall@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Srikar,

On Wed, 29 Oct 2025 at 07:09, Srikar Dronamraju <srikar@linux.ibm.com> wrote:
>
> In a shared LPAR with SMT enabled, it has been observed that when a CPU
> experiences steal time, it can trigger task migrations between sibling
> CPUs. The idle CPU pulls a runnable task from its sibling that is
> impacted by steal, making the previously busy CPU go idle. This reversal

IIUC, the migration is triggered by the reduced capacity case when
there is 1 task on the CPU

> can repeat continuously, resulting in ping-pong behavior between SMT
> siblings.

Does it mean that the vCPU generates its own steal time or is it
because other vcpus are already running on the other CPU and they
starts to steal time on the sibling vCPU

>
> To avoid migrations solely triggered by steal time, disable steal from
> updating CPU capacity when running in shared processor mode.

You are disabling the steal time accounting only for your arch. Does
it mean that only powerpc are impacted by this effect ?

>
> lparstat
> System Configuration
> type=Shared mode=Uncapped smt=8 lcpu=72 mem=2139693696 kB cpus=64 ent=24.00
>
> Noise case: (Ebizzy on 2 LPARs with similar configuration as above)
> nr-ebizzy-threads  baseline  std-deviation  +patch    std-deviation
> 36                 1         (0.0345589)    1.01073   (0.0411082)
> 72                 1         (0.0387066)    1.12867   (0.029486)
> 96                 1         (0.013317)     1.05755   (0.0118292)
> 128                1         (0.028087)     1.04193   (0.027159)
> 144                1         (0.0103478)    1.07522   (0.0265476)
> 192                1         (0.0164666)    1.02177   (0.0164088)
> 256                1         (0.0241208)    0.977572  (0.0310648)
> 288                1         (0.0121516)    0.97529   (0.0263536)
> 384                1         (0.0128001)    0.967025  (0.0207603)
> 512                1         (0.0113173)    1.00975   (0.00753263)
> 576                1         (0.0126021)    1.01087   (0.0054196)
> 864                1         (0.0109194)    1.00369   (0.00987092)
> 1024               1         (0.0121474)    1.00338   (0.0122591)
> 1152               1         (0.013801)     1.0097    (0.0150391)
>
> scaled perf stats for 72 thread case.
> event         baseline  +patch
> cycles        1         1.16993
> instructions  1         1.14435
> cs            1         0.913554
> migrations    1         0.110884
> faults        1         1.0005
> cache-misses  1         1.68619
>
> Observations:
> - We see a drop in context-switches and migrations resulting in an
> improvement in the records per second.
>
> No-noise case: (Ebizzy on 1 LPARs with other LPAR being idle)
> nr-ebizzy-threads  baseline  std-deviation  +patch    std-deviation
> 36                 1         (0.0451482)    1.01243   (0.0434088)
> 72                 1         (0.0308503)    1.06175   (0.0373877)
> 96                 1         (0.0500514)    1.13143   (0.0718754)
> 128                1         (0.0602872)    1.09909   (0.0375227)
> 144                1         (0.0843502)    1.07494   (0.0240824)
> 192                1         (0.0255402)    0.992734  (0.0615166)
> 256                1         (0.00653372)   0.982841  (0.00751558)
> 288                1         (0.00318369)   0.99093   (0.00960287)
> 384                1         (0.00272681)   0.974312  (0.0112133)
> 512                1         (0.00528486)   0.981207  (0.0125443)
> 576                1         (0.00491385)   0.992027  (0.0104948)
> 864                1         (0.0087057)    0.994927  (0.0143434)
> 1024               1         (0.010002)     0.992463  (0.00429322)
> 1152               1         (0.00720965)   1.00393   (0.012553)
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog v1->v2:
> v1: https://lkml.kernel.org/r/20251028104255.1892485-2-srikar@linux.ibm.com
> Peter suggested to use static branch instead of sched feat
>
>  arch/powerpc/kernel/smp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5ac7084eebc0..0f7fae0b4420 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1694,8 +1694,11 @@ static void __init build_sched_topology(void)
>  {
>         int i = 0;
>
> -       if (is_shared_processor() && has_big_cores)
> -               static_branch_enable(&splpar_asym_pack);
> +       if (is_shared_processor()) {
> +               if (has_big_cores)
> +                       static_branch_enable(&splpar_asym_pack);
> +               sched_disable_steal_acct();
> +       }
>
>  #ifdef CONFIG_SCHED_SMT
>         if (has_big_cores) {
> --
> 2.47.3
>

