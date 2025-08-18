Return-Path: <linux-kernel+bounces-773416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF3AB29FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545341960857
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6530FF38;
	Mon, 18 Aug 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ5hEvgq"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342830F55F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514514; cv=none; b=nrKcL7LHLM1GNHGx4RsOx7sycELDoK1iJFohbIXNfyuLOAIQ113z8dHK9HAQLpQL3pJcCjhHEPwBiyAnWcs0Qeh0Wj+w4yw8pZdNHcidVCVwgRTk/0zE5kh2a9IRqJgwoJ7LD9t2I7sMeepF8cb1M9wMCjTA0Q3lXhuATknD8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514514; c=relaxed/simple;
	bh=HpNccza3p8v2vE6GFzePxRiQVMDCc6soH+W3WfHy8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGEh1l/LuTDfMWFAgH+iDgVOaaltFiy0DNIJUs3fzuYVjSLnliyChZAJq6ivADJ2Jp2eZqA3l3aiwKh66VRVemImUeoqhGB8TAlRkE5qo/dNaJ4hjX7VUuuob4ca3bjxR6A6xpTdxLYMfFJPmjMhn47e2zDzFPaUoSVEPvJgu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZ5hEvgq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6059fb47so29138667b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514511; x=1756119311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zy1IorWNS34FecdFEvi5FhAZbBdTEKAgjIL+i6/fu6Q=;
        b=WZ5hEvgqwdU+7GGP2AldpIwPArLri3vLOzYfIfHn4nHgCRK625R7V9d0QVr2qGAYLP
         EXlfDQBOgQdRO992/3Oyua7dZKVoU3rV6Z1zQDjC9xjaId/kWNRJB0hjUB15QJr7dP5u
         5YliamSRNtU2KeKTYjL7rRDv/CC9Tvs1sqwDN43b/VwfDb1CHyy8M4Wf2qA8Gzp2BblG
         fCQy6lLr7iJaiW6rQofm+zF8ef2smP8SkS8L7cbGoEJUQEc2i1Ztn6m9IvJ1zANrqhs/
         VL4xkacR2dyH6rXBWWIeLa4GC+2N39+B0XryaxRRcYLRBnqRzVSJ+YOGZynnO9dolD7Y
         0PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514511; x=1756119311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zy1IorWNS34FecdFEvi5FhAZbBdTEKAgjIL+i6/fu6Q=;
        b=Czl5Lk/qpAqCHuD9qTIJ1tSeprA3ql4UYnKMd9IaFwcwUR+o05zPapKlsQ08jmJPRp
         zo2Mqk3cZjnhi9G6usQAy0OGh1uXbD5ndfnSEI0ffMWTo9f38ifc/GhRSafdS+LVmcbn
         jKIAQQMBelb8i6XJgxZHfMst+5WdgdqhKlaYhg3wKnKhUVzhOWElyWJiA/1nhh+TpOq5
         wadm/nl+yUeBhMMmSE0iKM1jgjMG5C/2vizrHX1Xxf8cjo4FYWEA2z1IQRI7TUCeuUWg
         vw2k7Z2fGR7TryS4HoaNrDQ1Lb5HC3T5U7b36RQNf94FyTFLMeyJ4KLeixKxUNDqNDv/
         zUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVZwhOu+nYc6uDjPxlJCe+Hnjde4GyJQ2z0cxcIR0fapX43VONSoWNaMeKDqxdQ0yRWFTFLOrHzNRcr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtjp0y7zOSUzsUrNlN8yR5Bk88RhXyccFsUpDQ/I0XcWEiRtS
	taToP9aNdYlmTGbEy7+iDuHdbjmkYRDNwk8fCH3UgnDSKB3yy0+bV0iZqn5+yruYHgMNUx9Jhww
	LOV3yhRN5dOlYi8pDXkcr3A4yB4PglWvu7vFNtZVgLQ==
X-Gm-Gg: ASbGncuevqb78V/92L3D+geef8nOaqcME+i0sm1EsWgUbP2re+vCJd+nxHM6w02KJRi
	23UqaCwHpHANU1wLxYnquSnqX97w/n2LRN8rGmk0Kf5RYy15lS9frvyw1esViFp9M5T74j15dXi
	OxLzbk0ejvGRve0ahtq4VaS2cUnR2g2V3czL4yNLEsE3+WLgQnZ83+hwXUNK8xsyax3jXKpQrbJ
	bBgq7gi
X-Google-Smtp-Source: AGHT+IEboBf6c0njtMAWRhLMOeerkvYUC/RpB+BHwi3FJenNwXNu8sDBXzeAxKFWYduZF9LOAJuj4ffV/2Ux+0YYIgU=
X-Received: by 2002:a05:690c:23c4:b0:71c:4152:82f9 with SMTP id
 00721157ae682-71e6d9f11a3mr132543537b3.8.1755514511272; Mon, 18 Aug 2025
 03:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724112817.142784-1-colin.i.king@gmail.com>
In-Reply-To: <20250724112817.142784-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:35 +0200
X-Gm-Features: Ac12FXzzABoPhZpmLWeQec_PNYAHBcPqx-MkWfT1zRFWCwObMMPA2QDob8U7l2w
Message-ID: <CAPDyKFqQJsBjaVotzRmL=pHWLmJnOiXUaQN5yo0oheiKyw8T+w@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: Kconfig: Fix spelling mistake "referrered" -> "referred"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 13:28, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There are two spelling mistakes in the config. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7232de1c0688..4afa0130779d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -359,7 +359,7 @@ config MMC_SDHCI_S3C
>         depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> -         often referrered to as the HSMMC block in some of the Samsung
> +         often referred to as the HSMMC block in some of the Samsung
>           S3C6410, S5Pv210 and Exynos (Exynso4210, Exynos4412) SoCs.
>
>           If you have a controller with this interface (thereforeyou build for
> @@ -401,7 +401,7 @@ config MMC_SDHCI_SPEAR
>         depends on OF
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> -         often referrered to as the HSMMC block in some of the ST SPEAR range
> +         often referred to as the HSMMC block in some of the ST SPEAR range
>           of SoC
>
>           If you have a controller with this interface, say Y or M here.
> --
> 2.50.0
>

