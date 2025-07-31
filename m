Return-Path: <linux-kernel+bounces-751694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608DB16C60
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8644E580AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA428D8E1;
	Thu, 31 Jul 2025 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKL2j2Cl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00722F76F;
	Thu, 31 Jul 2025 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945518; cv=none; b=CCNepXJIS04QqV+W8FFBxk5RdpPJwsDh39yGWL1kfhEobEOcUqylR1pwMjURlpwwgewP+g7syBPzCEI/cL1kqN7xM0d0hy1O98wLdTICCntA5EjYc8g5dPErA6JL/MtE8o3C2OOQ2kfeHZuOL6YTuPzv2gzJDQxYcGLVncEjwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945518; c=relaxed/simple;
	bh=Kfx4wMQ2oqGEzf2+5LC+8JZc8ABFgIzVSmTOF91ZxIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQJJOEOd40Inrb5DaWRC3LXwo49Wo7heAlShlQbFKY0/DFFeR69nGdk4caQpLHn53s4U1GIxRf4ZJ6VCceVNok2EMKsUKA7Q4CDf0db4lJMOJt+SgOoC+dDrUUAj9np1nA2VmIxOq3Slhu7UxSytWU8MnwZc5k35VCy9NPJJzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKL2j2Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF04DC4CEF8;
	Thu, 31 Jul 2025 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753945517;
	bh=Kfx4wMQ2oqGEzf2+5LC+8JZc8ABFgIzVSmTOF91ZxIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WKL2j2Clre2ZSPaVOKCEwgNdRQWXYQYodHiFtrfPTKOtEf/G39rJxOF0VjjyBvKcd
	 XptWVq6k/jzk5nDvRkVeE2g2s2g+oClsO9x5iGrKv47E9QraB7bFChKmGGf+tazP99
	 NHa9qEIGUqlTrdxztmt78JYISGj9hPmTnkyWLNWmuJxlGkn1zpbcoYS8QVMUCsVEdE
	 EWRJLpbV/Oq69I9dJ0CATUy4QD8Gk8Djko6VmT/tqWpxz2Btqv0clrSkl6VPgnsjV+
	 zgHyT2B1iEJsh8UQJBiVwDtvLqlF0E0yPcZWeyVbh6VeP80Is9sAejsdUwBgO8j2LI
	 tNLacTv/zFyZQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso691982a12.2;
        Thu, 31 Jul 2025 00:05:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXu0hpM0cvmtDI5Tv/71SL3od6zoRpj4P5jL+X8LZY4k0xpq74rg34tPeVMhRoetmjSraEtlSGrWBEMCCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrWuwtYkFqP4zdbnWAYnrV/R18dXUvnMosAEodJJeggEBbCwU
	k9JEVrHQYUO60ELwtJwY1D6F90+ih/sekXnCpjxhAxMiBEo0/vGNqG9B7uhLK/Z/qlE0j0REjbk
	+oVMsyDDM/vMiD4dATIN7QoE3aCWLsqw=
X-Google-Smtp-Source: AGHT+IF46nilfNzJSqM6pDFJO9kITYZ0pBMldJy1JEetckck0FOoRiEe5A7lFrHMaIVm02BVW8nAN012zCIpRxlZBi4=
X-Received: by 2002:a05:6402:51c8:b0:615:226c:4b0b with SMTP id
 4fb4d7f45d1cf-61586ec8a87mr6760988a12.2.1753945516372; Thu, 31 Jul 2025
 00:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731064813.1622-1-tiwai@suse.de> <20250731064813.1622-3-tiwai@suse.de>
In-Reply-To: <20250731064813.1622-3-tiwai@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 31 Jul 2025 15:05:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
X-Gm-Features: Ac12FXyfj4aiyV2QemMPOkkR1NLS9F9qC38VYM6V4eG3i7Xp8L0xv_HvVK3o5rQ
Message-ID: <CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Update HD-audio codec configs
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Takashi,

On Thu, Jul 31, 2025 at 2:49=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> The HD-audio codec driver configs have been updated again the drivers
> got split with different kconfigs.  Add the missing items.
>
> Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> Cc: loongarch@lists.linux.dev
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
I prefer to select all Realtek/HDMI codecs (except
CONFIG_SND_HDA_CODEC_HDMI_NVIDIA_MCP and
CONFIG_SND_HDA_CODEC_HDMI_TEGRA).


Huacai

> ---
>
> The changes are only in sound.git tree, so I'll pick up this there, too
>
>  arch/loongarch/configs/loongson3_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index 0d59af6007b7..ac00d815b478 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -784,8 +784,10 @@ CONFIG_SND_HDA_HWDEP=3Dy
>  CONFIG_SND_HDA_INPUT_BEEP=3Dy
>  CONFIG_SND_HDA_PATCH_LOADER=3Dy
>  CONFIG_SND_HDA_CODEC_REALTEK=3Dy
> +CONFIG_SND_HDA_CODEC_ALC269=3Dy
>  CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
>  CONFIG_SND_HDA_CODEC_HDMI=3Dy
> +CONFIG_SND_HDA_CODEC_HDMI_GENERIC=3Dy
>  CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
>  CONFIG_SND_USB_AUDIO=3Dm
>  CONFIG_SND_SOC=3Dm
> --
> 2.50.1
>
>

