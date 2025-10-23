Return-Path: <linux-kernel+bounces-866421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57629BFFB82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE54188C3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206812DCF69;
	Thu, 23 Oct 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3tZAZdc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CB2DC777
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205966; cv=none; b=Luha8qrUfsFbUucECYKr97sJul3BhFrosnwlVZj/6lldVLpbk/orUu1wvGJhgdY/T3psrcugWqZ8HEbYpTOL1ytNGlhYG9zWTs6b2uPd7dkTEUHFhmRFaG25DgAu363DMyVvkWzAeJXPd9lSDkGngYIH8Dwki93aIv90j1m7i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205966; c=relaxed/simple;
	bh=Vdsehfzan7Wo4JdUx6x3JP7AsXeDExJDtppR5Qbz9rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxkGa13iJ1H/3sqwwcJX5saRFneQCi9Uuy9wQtRdJApU0NLCaYgDwSTFQNrDcYjZjjSLjYFEC6cpt3qGTyIII5u7JTSzKqtO706hTeT0ld7OIF3U8ZD/5Frw5WGDz34YBje6sqIBHVrAZlkQinAHd1OkZm/72pwRu9aoJFsKL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3tZAZdc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a226a0798cso411223b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761205964; x=1761810764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDxToBSJlh6pwttSjRukYxP0hoFnewOMMeOaj3DS4H0=;
        b=T3tZAZdc/sqPtjmZTZ/QIsRuZm9R1EhHUIzgHVDxSGdhjLyCuZ1VtO3vuemRPuexYG
         yBR6Hq9snMaX6CxzNd1GoLwKeEmsEoQ21xPSn9pMuxAdqh6w17F8fFQwd8MIdqqFKfZ0
         87bVxY9DVB+q7mUuiDyzMBckTFhp9KAedjNvo6v+WdnU2L1Ipyi2If7vbu6KNCkPCofe
         hYTsZCm5O/+lR1whLGPDoEsE0+KcoueC72s4qNAdPF36SPyyEgpbXq9Ni/+fs7SiXQtj
         F7Vly8pfdnA3Of8jxmcFPRGFoUGyUtIliJuUUwKsJW03M1ZCgP6tSFOyZEfBdZs2SdQe
         vV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205964; x=1761810764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDxToBSJlh6pwttSjRukYxP0hoFnewOMMeOaj3DS4H0=;
        b=ki18t01aTh7NEtkebsUH1eoMFkPqz2f406DlSd1lnRNH0k8g/9FBT+wtphfpdcOdEH
         WCU7mF7XR8DmW2wIaPD/9GEKccIx99kayjdg8tRSvyAsP1UN6RC7PebzhSHB0epC2LeN
         xm2m6nk2sA2PDbDPm2NZPYXARsZyNcfh2jC4/8p5yG4LUAV9N9uODBbr5BOXS41tEigq
         XPre3dghhMLECcGzr6EVfz1IbA5I3Rz6m2pQP3wiH8z4onJcPP2V4nct619bsSCC97CV
         RgwgBA2EZiF/KK5HRfte+1HaE+oyNVJoehRMwdeWSjKKCZ3cwguXNTGCBkWnm0x3wee0
         5JLA==
X-Forwarded-Encrypted: i=1; AJvYcCVNuld9H23g5p/EIGaND4qxU9m+3UMW6fM+Iw32gseK9czLWafop1/Tm9kH4H5NtBVwsF1uo8t823k++Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrungE+GvO0L0/SLwCTjJsDYGg1UbO81gT9xkhtn5Q/xL74cum
	9lJWNgQPv0PeYL/aOlNki7pX9aP83tbn8u/gFq7thSo3icGd+zhQ5uwMPfQ+HdwMLTR2KfplSJ4
	9/PWlGVFBtr3iXYQIf697VMC3qJl8+Ew=
X-Gm-Gg: ASbGncuxdjkcAkFH/+tTcLkVmGCl0lBo/WrEtRFJJd+lGwF9PBqrq89jldq+skInyVD
	uD7RJBOMNiMfaC8YOJ9zdYBlb95CtOVaQOrAxC4S+8dWc27mHEfIADxQbj/UTSKz3sojEtEeL+j
	oFI35vC75+pJmd/d5nBZewer/5zvZyrPy8biUzuPVvTbFdliFy1vDpzA8GPIf/qiy83z9i6yuQs
	Jb8mPi2Xl8kHkrIjvGOBndQx0pNrTkoK/vX634aYfXZx56EbdzDQtIdBvODJ6k7IW/by4w=
X-Google-Smtp-Source: AGHT+IHZm7YHicY9t1s+9cg0DRHa1Ixx5JoRyuU7gM6pUgzxiSEpAdgekh3BcvYqugXkHXZmy2Soyl8hMWKn/Jc8zpc=
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id
 d9443c01a7336-290cba4edf7mr245675835ad.37.1761205964066; Thu, 23 Oct 2025
 00:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023064538.368850-1-shengjiu.wang@nxp.com>
 <20251023064538.368850-3-shengjiu.wang@nxp.com> <CAEnQRZB+rFudpHB7TKFOCumh4Ni9q-421X3jRL2y8UbV74e-xQ@mail.gmail.com>
In-Reply-To: <CAEnQRZB+rFudpHB7TKFOCumh4Ni9q-421X3jRL2y8UbV74e-xQ@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 23 Oct 2025 15:52:32 +0800
X-Gm-Features: AS18NWBwB2MtjnQIiGgglXV9h8USjZRfSHjjPdz0DOn_3hzcucQZP-krZ_KRb7w
Message-ID: <CAA+D8AP4t+vS_n=VvRR5YYYrp0DGdWvqSN+4U0ZWMaGHmmt9ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_micfil: correct the endian format for DSD
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:10=E2=80=AFPM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> oldest - > most significant bit.

'oldest' is from the time perspective, which is aligned with the descriptio=
n in
https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm.c#L2050

Best regards
Shengjiu wang

>
> With that,
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>
>
> On Thu, Oct 23, 2025 at 9:48=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.=
com> wrote:
> >
> > The DSD format supported by micfil is that oldest bit is in bit 31, so
> > the format should be DSD little endian format.
> >
> > Fixes: 21aa330fec31 ("ASoC: fsl_micfil: Add decimation filter bypass mo=
de support")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_micfil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> > index aabd90a8b3ec..cac26ba0aa4b 100644
> > --- a/sound/soc/fsl/fsl_micfil.c
> > +++ b/sound/soc/fsl/fsl_micfil.c
> > @@ -131,7 +131,7 @@ static struct fsl_micfil_soc_data fsl_micfil_imx943=
 =3D {
> >         .fifos =3D 8,
> >         .fifo_depth =3D 32,
> >         .dataline =3D  0xf,
> > -       .formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32=
_BE,
> > +       .formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32=
_LE,
> >         .use_edma =3D true,
> >         .use_verid =3D true,
> >         .volume_sx =3D false,
> > @@ -823,7 +823,7 @@ static int fsl_micfil_hw_params(struct snd_pcm_subs=
tream *substream,
> >                 break;
> >         }
> >
> > -       if (format =3D=3D SNDRV_PCM_FORMAT_DSD_U32_BE) {
> > +       if (format =3D=3D SNDRV_PCM_FORMAT_DSD_U32_LE) {
> >                 micfil->dec_bypass =3D true;
> >                 /*
> >                  * According to equation 29 in RM:
> > --
> > 2.34.1
> >
> >

