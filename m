Return-Path: <linux-kernel+bounces-751715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FAB16C97
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2745A3A5B80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50629B8CC;
	Thu, 31 Jul 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgSMzw3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24655209F45;
	Thu, 31 Jul 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946386; cv=none; b=DMWoy71SFuXCRxvCeaxOCedeH8crhpPLOkL7I7FhbaziKBkLTB7sNcligcaXn25NiukNs7b6nk/5sTEhceKc/AgphiVpGEU8rTVGxrbhplnojGWIPfdJsYiI4Pn2A6+a+xC6OdHX+L3GjATngA/GCTAmBVfvUaw5S/Spk0KDef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946386; c=relaxed/simple;
	bh=GLJAqlWbsxilCi2YvgNXfOUVkqyeHEZxhrOlRiRewR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN1qM9zaTlGQ3e9VVC8daKhx0Qe0aL/dwCIowlwhluA5x6EvdDqq4AWjtCvSGXmwUtZznBlsf9svekihW6vjCVrdPHnYGItWb7R501mjiZF/L1Uw722Q8OA54thA2oJfb+m0SiSFZoRA948ofFFw29y1Lv73/p6PW3AozVdz2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgSMzw3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDF1C4CEF7;
	Thu, 31 Jul 2025 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753946385;
	bh=GLJAqlWbsxilCi2YvgNXfOUVkqyeHEZxhrOlRiRewR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JgSMzw3bGyBIUUnDp+Q9CYmGwYtCa06kbl4lgLzcekizStlZ9lU0Fnwg8zrojbZn8
	 HrhVRGtm6g7alCJgA7Eyq9ziqNZ2ApXuTswyp0hxEtPH6EFMBuTabnni4KremQoea1
	 AAtsDp5q/UTttEaUnZ3ZmYM5oN6wSvQmE2Z4nH6Xa2MkwhZGR/iBKGjKrIgAejY9w2
	 CavD3f5L6MWIOiejQTUJXJolO449ZcFTTtFzrjyF/lwXLjLftLT0tq2yyCuVAa+ZbI
	 FW0kjdpV6CvAwjuYKerhxdgkIEBKDip3UrufBfaH0z7tXe/4iCITWNnfKHp4JuBHsW
	 XDp8T11Aq3rYA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so680606a12.1;
        Thu, 31 Jul 2025 00:19:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2YmdtnuovWvVxWb2Q2JpNdutPeF07OTOrl6Jxtb6lvd9iLEkUcCk4/ITB/iHAxWQITEF/7owYim4mtx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BNr3ZhBazKYh4e0H+HE4zWlZdFaBUck9WGclJjma6ijb6NNy
	opJ7dzy4eFJ+NVO3PdQuHEWay9PcdiLRqP//tA4qNbh8V9swzEd8JJL2ynYdo0diB0kpMa4TTDM
	Gxp4IMHi7GAUK9yy3h9m6tr3jaWoUU7U=
X-Google-Smtp-Source: AGHT+IGNAKCxnuv33rX1oi6ks72RtmWOexXWxDAv/eG7qbMMqY3YXUdEUBLSbBUvuwgQZqE3yxbOxX8su3K3SDbHls0=
X-Received: by 2002:a05:6402:210b:b0:615:8f10:2d4f with SMTP id
 4fb4d7f45d1cf-6158f10331amr4378917a12.14.1753946384269; Thu, 31 Jul 2025
 00:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731064813.1622-1-tiwai@suse.de> <20250731064813.1622-3-tiwai@suse.de>
 <CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
 <87wm7osurw.wl-tiwai@suse.de> <CAAhV-H5TC0jYbqu2M0CXEJ+80Svonrg8VHOF-ygb=ff7kWHX6g@mail.gmail.com>
 <87seicsuay.wl-tiwai@suse.de>
In-Reply-To: <87seicsuay.wl-tiwai@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 31 Jul 2025 15:19:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7bDDh5Pykg_MFN3x5aOEzWsidkyvLV7euKasby-QYd3Q@mail.gmail.com>
X-Gm-Features: Ac12FXzGtmCFWPa9372hv3yVJ1o6aJw0ogP7XAELRxcFjkhgJ15WSHUuUM62y9A
Message-ID: <CAAhV-H7bDDh5Pykg_MFN3x5aOEzWsidkyvLV7euKasby-QYd3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Update HD-audio codec configs
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:17=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Jul 2025 09:12:06 +0200,
> Huacai Chen wrote:
> >
> > On Thu, Jul 31, 2025 at 3:07=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > On Thu, 31 Jul 2025 09:05:04 +0200,
> > > Huacai Chen wrote:
> > > >
> > > > Hi, Takashi,
> > > >
> > > > On Thu, Jul 31, 2025 at 2:49=E2=80=AFPM Takashi Iwai <tiwai@suse.de=
> wrote:
> > > > >
> > > > > The HD-audio codec driver configs have been updated again the dri=
vers
> > > > > got split with different kconfigs.  Add the missing items.
> > > > >
> > > > > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as defaul=
t")
> > > > > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > > > > Cc: loongarch@lists.linux.dev
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > I prefer to select all Realtek/HDMI codecs (except
> > > > CONFIG_SND_HDA_CODEC_HDMI_NVIDIA_MCP and
> > > > CONFIG_SND_HDA_CODEC_HDMI_TEGRA).
> > >
> > > OK, I'll refresh later.
> > Also for the MIPS/loongson, thanks. :)
>
> OK.
>
> arch/mips/configs/loongson2k_defconfig has no selection of HDMI
> codecs.  I don't need to select HDMI codec drivers there, right?
Yes.

Huacai
>
>
> Takashi

