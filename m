Return-Path: <linux-kernel+bounces-889024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC52C3C78B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F141D3525CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236234C144;
	Thu,  6 Nov 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSpKoGMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD93376A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446788; cv=none; b=JLOmmRjX4VtjkeTezU9DOj8ssXM0lnj5wkhVlAz4TF8U4sTdIbhUf1PE2fsY2muTFVm5aCwRBqbzmQBoc15f+nbQ0FL0UkFUyVjTtAMZUy66d4Oah51PEsxVCcMoxgh1BFQNaiPbnP6/82V9oqsJw7ieQiucQsPN+QEiCSZj5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446788; c=relaxed/simple;
	bh=d6t8VCDtVkzg2tyFSGAJ0Kp7H3//Z+lwp247CTf/+KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUP269ebR9i1T0I2bwIr/Z6OktQQpGIF/bYX14xCawWi1FAKSSrRJtGEtgfsmf+akXOA8Axz7TaEuZerWtkg4tXQEDUpi52YSLRFf45Lsluhve2iGaCva7Aa2fNe+LFqtf22YrDb2oJeE9OGJ+DvsYMoR4hPvs2WYScgvr3FPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSpKoGMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FF8C4AF09
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446788;
	bh=d6t8VCDtVkzg2tyFSGAJ0Kp7H3//Z+lwp247CTf/+KA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WSpKoGMV8Wwf2m/UKpUYS11e6M5f9hopt15TGpNQAnOZBrK/i7IMoc/AoWgCfwusa
	 mpj79K8bkQ49pOMb5ihHlXGOsD1qzzBka97RPyKxlBbBsxXlXbg+DmKJW0PEZGVfJ0
	 jvmR/39u1Jcppw0lQInRKcOGyyzpIOx+FhgfHvkorvgsx8FI9FcUeKMeVBdHeGYatL
	 UyCkGa7fPOmNFpIa3i7oIZOdewaXs+DGpYUAFc+rxeI5tmUHZs2ZwaWQpegdQrOFC9
	 uM5YVQeSY+IfybZkiXWxOA83VkPETJYSGBhrIFxrIsbr2vyZm0XzE+KFJhrdDqGSVY
	 Bp+19bxobtqMQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594330147efso1224282e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:33:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK8CqnscPEl/Vk9+IKSC7tGuR8T8dPYRrrLAoe6wcij6BgY8xEqLU1oHveLsqI1Asq2c/16F4+7kEy9P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw97nrOp8KgDCXo1tbkQ1DVHYoileJJaRlvyo3A231vinb9GTG
	Ru2+tAFFQBnBLby2/xp+JYvMI5VVHRSiMiC5CwCWktzP7/UcsEyyzlbI/rApoEdXvOawV1QJORs
	4DJhXujW7mLEWzoXTnl5tubabj/JV5u0=
X-Google-Smtp-Source: AGHT+IEhhD9njjfUVAqVHB5FaOXmdh17RU3QYw1j6NvOm7obm1z5UqtY1UySh/ipvlLN53qhZsWvUeDBr9oTo+u1qeM=
X-Received: by 2002:a05:6512:110d:b0:594:3caf:bec1 with SMTP id
 2adb3069b0e04-5943d7fd616mr2551307e87.47.1762446786573; Thu, 06 Nov 2025
 08:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106162311.2705162-1-mclapinski@google.com>
In-Reply-To: <20251106162311.2705162-1-mclapinski@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Nov 2025 17:32:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFc5fcXM1UCtgev+7LFyc+vuTD-M0ma31fNasOGmpQqUQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmgUhwej99AV8Blkp-FE0fsUEHyUVBIodtTRGYOFW0SgqIkuLpXsoL04i4
Message-ID: <CAMj1kXFc5fcXM1UCtgev+7LFyc+vuTD-M0ma31fNasOGmpQqUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Michal Clapinski <mclapinski@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 17:23, Michal Clapinski <mclapinski@google.com> wrote:
>
> The intent of the code was to cancel KASLR if there are more than 4
> memmap args. Unfortunately, it was only doing that if the memmap args
> were comma delimited, not if they were entirely separate.
>
> So it would disable physical KASLR for:
> memmap=1G!4G,1G!5G,1G!6G,1G!7G,1G!8G
> since the whole function is just called once and we hit the `if` at
> the end of the function.
>
> But it would not disable physical KASLR for:
> memmap=1G!4G memmap=1G!5G memmap=1G!6G memmap=1G!7G memmap=1G!8G
> The whole function would be called 5 times in total. On the 4th run the
> last `if` would not trigger since `str` would be null. On the 5th run
> we would exit early via the first `if`. That way the last `if` would
> never trigger.
>
> For the second input, the code would avoid the first 4 memmap regions
> but not the last one (it could put the kernel there).
>
> The new code disables physical KASLR for both of those inputs.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> Suggested-by: Chris Li <chrisl@kernel.org>
> Link: https://lore.kernel.org/all/CAF8kJuMvX31n8yNWn11bo1wCgXXOwOAp8HbYpSEBy94LR6phDA@mail.gmail.com/
> Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries")
> ---
> v3: added a link in the description and a better explanation
> v2: used Chris Li's snippet to change the flow of the function
> ---
>  arch/x86/boot/compressed/kaslr.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

This looks fine to me, but as I noted before, I'd happily simply
disable physical KASLR entirely if 'memmap=' appears at all.

> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 3b0948ad449f..649264503ce6 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -162,14 +162,18 @@ static void mem_avoid_memmap(char *str)
>  {
>         static int i;
>
> -       if (i >= MAX_MEMMAP_REGIONS)
> -               return;
> -
> -       while (str && (i < MAX_MEMMAP_REGIONS)) {
> +       while (str) {
>                 int rc;
>                 u64 start, size;
> -               char *k = strchr(str, ',');
> +               char *k;
> +
> +               if (i >= MAX_MEMMAP_REGIONS) {
> +                       /* Too many memmap regions, disable physical KASLR. */
> +                       memmap_too_large = true;
> +                       return;
> +               }
>
> +               k = strchr(str, ',');
>                 if (k)
>                         *k++ = 0;
>
> @@ -190,10 +194,6 @@ static void mem_avoid_memmap(char *str)
>                 mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
>                 i++;
>         }
> -
> -       /* More than 4 memmaps, fail kaslr */
> -       if ((i >= MAX_MEMMAP_REGIONS) && str)
> -               memmap_too_large = true;
>  }
>
>  /* Store the number of 1GB huge pages which users specified: */
> --
> 2.51.2.1026.g39e6a42477-goog
>

