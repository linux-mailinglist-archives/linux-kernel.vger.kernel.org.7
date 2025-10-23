Return-Path: <linux-kernel+bounces-866323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2CBBFF76F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEEC3A5AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FD2C029F;
	Thu, 23 Oct 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YylWJdDA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8562BEC34
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203423; cv=none; b=EY77HCyvZBGvVEPVzWdXlr4muvjkFZ4+eXZKgNe9pHCVRiLOXmTuHRE0I87s3f+Uvc2eXu2QIWb90wA1zeZhrNltuxJ6xELnsFG+YZTwOHpTJKDXltGBs0NLXB3pwrxePUSBHI7swtVRlpk/1igOyxJv3vo547EvkqUqNm4S3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203423; c=relaxed/simple;
	bh=atSHiBv6EOD3kMNIDMzYEJsOitPHWi/LcNVnt9jVTkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuVHb5Ot5NQArzqCxvN/MdC+ApQIrHI7SQtnC1MHVKTRwh25XOb+JJhj/mp8cEbAtPui53Y/Mcyf6V0eTpSsSVakecXJG0rbI/gy01Lz/7qqcwfsSdoGxms++PA47OgGDV5p7gPoMAO+FI8Pu5nTZjDOjAlwr5WdCkon9sQErTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YylWJdDA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eec33b737so6874735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203421; x=1761808221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojo0D0SUrVi8rANl2uoQB3ZeIV6seeVTI9tIuETGh2U=;
        b=YylWJdDAWIKc4/vBOz+vbSYll8wN63MLpsI9Q0obiDNraaiEQFbeM0U0YwKnDsnpIz
         fS5KZ03I5LZ5/ny42IoAM4R3KyGX1r/L8rPaypxUWT25ZQxy6iCsqJ9Ww5ufi+qEkFDK
         baCUwAyA+Z475dvwyd5zAmHrZWPiKArdx/2bTy/Wjt8ku7VBmTThtxzvtTxeDSkjnnaZ
         P9hu3lawAU0RGgdItt8HoCy4yIU5gPWNWnEV1TphPEz1uxIb86DXgyNxUrOUgrwWEnE8
         q8GxG/x7byEFSmRe2np4MBJJu4MqMEm8wK1jplX5wSVGl6tnmyXVICRJu7dxSj2kVjM/
         ll6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203421; x=1761808221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ojo0D0SUrVi8rANl2uoQB3ZeIV6seeVTI9tIuETGh2U=;
        b=lQYRaQ0xc4qY7Tu+EL3lhq0FPnrPR7RI1rPbMR0ho+y2QK2t7lAnWcuxqxi4SVFwHr
         jqFWwr6BGTiVHaedgozMhFpC8dOTIUiBnBm8n1wYiyMvKap6QKYDhtkvkIm8D0UXuwVE
         lUAGEWlVzRcBPVgsJf7L5bwwEqVbHb8cHh9NnUXsiSruypewJabS5hxr1d7QfW6lmuHR
         tuEko3UJuCUvukUStGLcmGinNTz/tPLUpu1qRvvPOkoG2SOtxOxhyEBf1nenBN1T5RLk
         u9USUFEw3gyrHRLUK1kxS8QlIE5EeFY/kzUwM/HA6NjWxc39vH3c5idhnvEGzng4cOiO
         E8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxv6ofmU1Rt0iI8Y3lPDmcPw810ZG9F53qLyLSqGvIOnuOzWTODNM81eZ6StuuUF8De7X/kkh+Agt6Ctw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CCDJghI4TCd9jpyURqxa7MkrEl92eyRE0xqOjwdNcDbR3UZ4
	wcWvB4y+pznr9y3LqcA5QBdHcbRfQ1QfzFCsSwnaSdhhMvMcnANIZU1B0qpMWd8Br2+vKL0nCsF
	tjI9MNfkyti8yGf8fZ2/1QuV4+ffivAw=
X-Gm-Gg: ASbGncsssylhXiRHHaVBGWvtJKqU6oqyMaHQFZRrL2uPXf2gzAisrb62JpB0ukDIMvh
	vp/v3WWZv+tpJQgDtkkNh8w1wlFBKG8NyhoJRvwcA/aSf6sSQ78pT6XS671Ewd3KvEYu7UheQzL
	x/QYrf4HE28Xf3jms1oPOYM68YymUY6ntQNu7l27KocJCpwPTBsN0wPhG+YUvs2GkasItc9KLkx
	N3SIrzp+F+a9FkVn+8CJk/kLoV9FBMdY0SK4K45WQEZN7pStSb7n1NO1O+2dEGbVUFLK3e5V0tx
	QWGACA661Oc9Ng==
X-Google-Smtp-Source: AGHT+IEtJBcARSautKMltyAqLGBQ/Gd8B1xihDkjxP19PBXKTkpvD+Eo/uq58hE6h11K8gLvUb2NUw09soHy4QEpmTY=
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id
 d9443c01a7336-290cb65f861mr305187765ad.57.1761203421516; Thu, 23 Oct 2025
 00:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023064538.368850-1-shengjiu.wang@nxp.com> <20251023064538.368850-3-shengjiu.wang@nxp.com>
In-Reply-To: <20251023064538.368850-3-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 23 Oct 2025 10:12:39 +0300
X-Gm-Features: AS18NWCgBWlr59lTgB1C8kcLIypbCmmlbtXSZ7g6CCjdzuXK7TY5j-4JWGWmtC0
Message-ID: <CAEnQRZB+rFudpHB7TKFOCumh4Ni9q-421X3jRL2y8UbV74e-xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_micfil: correct the endian format for DSD
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

oldest - > most significant bit.

With that,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


On Thu, Oct 23, 2025 at 9:48=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The DSD format supported by micfil is that oldest bit is in bit 31, so
> the format should be DSD little endian format.
>
> Fixes: 21aa330fec31 ("ASoC: fsl_micfil: Add decimation filter bypass mode=
 support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_micfil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index aabd90a8b3ec..cac26ba0aa4b 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -131,7 +131,7 @@ static struct fsl_micfil_soc_data fsl_micfil_imx943 =
=3D {
>         .fifos =3D 8,
>         .fifo_depth =3D 32,
>         .dataline =3D  0xf,
> -       .formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32_B=
E,
> +       .formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32_L=
E,
>         .use_edma =3D true,
>         .use_verid =3D true,
>         .volume_sx =3D false,
> @@ -823,7 +823,7 @@ static int fsl_micfil_hw_params(struct snd_pcm_substr=
eam *substream,
>                 break;
>         }
>
> -       if (format =3D=3D SNDRV_PCM_FORMAT_DSD_U32_BE) {
> +       if (format =3D=3D SNDRV_PCM_FORMAT_DSD_U32_LE) {
>                 micfil->dec_bypass =3D true;
>                 /*
>                  * According to equation 29 in RM:
> --
> 2.34.1
>
>

