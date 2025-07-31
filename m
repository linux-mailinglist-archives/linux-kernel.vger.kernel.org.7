Return-Path: <linux-kernel+bounces-752007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5970B17041
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CCC560514
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270B2C08D9;
	Thu, 31 Jul 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkJriubR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BB2C08A8;
	Thu, 31 Jul 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960670; cv=none; b=llSic3FJ2CJ6jmnfx1eMvPTJttUYIyH14GSu0OIcvoeq4vZslXmL92UrOPUFSQIycSsf/lLjLY7cdAnTGVY3+93bcIEjEQTdxjtU5GmnG4XscgywCFmupYtnD/5bf/JRddpqc7cCg5TLyjpd7L5HTrmdEvs1EaGiLLrdFHBoQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960670; c=relaxed/simple;
	bh=YWu/J1z9qSPzIdGl7WaiOwtxEhLqY1keFDoxQ7nsjR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5GMtlym+EPvcizKlN2n+U6rTNrxMQPRw1Nivn06GYjHLvi6UlGSWdZJdLL8Wutv+FNsvAvusaCugwiXHTYEj88CzV1cj8oSNozdcV/na2KQJnEnvJJkQVrmNwZ8DpWJ/OTXsHOtZ5iFYzGhDWDvdg7+bz72jbWsuk/zPmdhe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkJriubR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9CFC4CEF7;
	Thu, 31 Jul 2025 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960669;
	bh=YWu/J1z9qSPzIdGl7WaiOwtxEhLqY1keFDoxQ7nsjR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MkJriubRuCPKQUv+FKFPxsSVndYbGpCI7v3xZsL4YAuuEythF4YUJWkQepa71VuyQ
	 D4vgGKmEmnW2NyLqjbX2uCMCRs6cF/kPpwaDUg2wIYyOa+Yin+85Oc1kZVFU6eOKRG
	 vy2C+hAmk7Q+YDD1avMfD8QW9XAJBVaIX4gOiG/So59qtW3TKTujSVoh9y8C55ZdlH
	 xH2EFV30oIlkw7cKB0ems/12X/vY+3f3zM0M1DsfQuOXQfA4xbcFF91X/W74KuEaGx
	 N6aeSuzU9cX9y78KNqxuRsVW7Ryx3JXBk67V3FX+9xKPpXArAGuJpsyJHUZsYH3Wq5
	 E4iJLJPB9dIkg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso1106633a12.1;
        Thu, 31 Jul 2025 04:17:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtfROVzrjjzCA2A1ekN2jAx9xu9gL4ie6eCPaRfe9hDEDmG31+38D69ZXRwiSoOyPQ1hUNFZYYjEPsp1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Fv2ONu3gnbbfhPyrDUGsVnABUU3OBNeHGzg6cErjDUPFScuO
	Cp0nyjHpJF1Y2BszJuoMjlDN9tDLhoAxcuzGdrhQ1KAunVhmN49kQb7pKiGRJh8ss0Uy4qwGX3K
	jqRQ3g+s47VLToLjupLpfs26bykm6WYk=
X-Google-Smtp-Source: AGHT+IEvztrvw0d6qmKf0xUerykCRVZo6PrnLWfPxQoZmA2VWnhPTMPLGX2eIvduq+3yFR5DyHb2R4kk2GarE+6kEdE=
X-Received: by 2002:a05:6402:24c3:b0:5fc:9979:78f7 with SMTP id
 4fb4d7f45d1cf-61586ee81ccmr6795038a12.14.1753960668331; Thu, 31 Jul 2025
 04:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731091109.16901-1-tiwai@suse.de> <20250731091109.16901-3-tiwai@suse.de>
 <CAAhV-H6uDytXrsWv43uxNic9PH=ed1M3=29LTqCoYxzNdESkfw@mail.gmail.com> <878qk4snpk.wl-tiwai@suse.de>
In-Reply-To: <878qk4snpk.wl-tiwai@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 31 Jul 2025 19:17:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qUDrjnOE059vH_+4Rxj85vwAadqGHDwH8tTbhiD+FNA@mail.gmail.com>
X-Gm-Features: Ac12FXwSCo2_9pBjrOhlio-SRoCtC_xxyQEm9XhUPWLdimEgCwezg8-JxwzBWCg
Message-ID: <CAAhV-H4qUDrjnOE059vH_+4Rxj85vwAadqGHDwH8tTbhiD+FNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] LoongArch: Update HD-audio codec configs
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:40=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Jul 2025 11:33:38 +0200,
> Huacai Chen wrote:
> >
> > On Thu, Jul 31, 2025 at 5:11=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > The HD-audio codec driver configs have been updated again the drivers
> > > got split with different kconfigs.
> > I'm sorry for making noise, but is SND_HDA_INTEL_HDMI_SILENT_STREAM
> > needed for common use? If yes, I also prefer it be enabled.
>
> It's better to be disabled, IMO.
> (And this config hasn't been changed at all.)
OK.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
>
> Takashi
>
> >
> > Huacai
> >
> > >
> > > Enable all Realtek HD-audio codecs and HDMI codecs (except for
> > > NVIDIA_MCP and TEGRA) per request.
> > >
> > > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> > > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > > Cc: loongarch@lists.linux.dev
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > v1->v2: enable all Realtek codecs and most of HDMI codecs
> > >
> > > The changes are only in sound.git tree, so I'll pick up this there, t=
oo
> > >
> > >  arch/loongarch/configs/loongson3_defconfig | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loonga=
rch/configs/loongson3_defconfig
> > > index 0d59af6007b7..7993020ffebb 100644
> > > --- a/arch/loongarch/configs/loongson3_defconfig
> > > +++ b/arch/loongarch/configs/loongson3_defconfig
> > > @@ -784,8 +784,23 @@ CONFIG_SND_HDA_HWDEP=3Dy
> > >  CONFIG_SND_HDA_INPUT_BEEP=3Dy
> > >  CONFIG_SND_HDA_PATCH_LOADER=3Dy
> > >  CONFIG_SND_HDA_CODEC_REALTEK=3Dy
> > > +CONFIG_SND_HDA_CODEC_REALTEK_LIB=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC260=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC262=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC268=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC269=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC662=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC680=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC861=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC861VD=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC880=3Dy
> > > +CONFIG_SND_HDA_CODEC_ALC882=3Dy
> > >  CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
> > >  CONFIG_SND_HDA_CODEC_HDMI=3Dy
> > > +CONFIG_SND_HDA_CODEC_HDMI_GENERIC=3Dy
> > > +CONFIG_SND_HDA_CODEC_HDMI_INTEL=3Dy
> > > +CONFIG_SND_HDA_CODEC_HDMI_ATI=3Dy
> > > +CONFIG_SND_HDA_CODEC_HDMI_NVIDIA=3Dy
> > >  CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
> > >  CONFIG_SND_USB_AUDIO=3Dm
> > >  CONFIG_SND_SOC=3Dm
> > > --
> > > 2.50.1
> > >
> > >

