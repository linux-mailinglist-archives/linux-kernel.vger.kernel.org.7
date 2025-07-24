Return-Path: <linux-kernel+bounces-744055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90FB10786
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172EF17D24A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45E260582;
	Thu, 24 Jul 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOvxIEhd"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD025FA10;
	Thu, 24 Jul 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352065; cv=none; b=hHHfnkuo4pYKKW1NcEG2wGjmhBLDlRlKly65GMvEbwA/Y+PP9PKHPX1jU4N+WRbVuoDZkIJdKIge9JI/sW4Qi4JbvTtsYD3hs14lp3zH6y//ihuxARrkE6lfq6sm5KkWBGerlTgiUHiNaAZQKGh+nN1qXVnN16dM1+2r6BnBuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352065; c=relaxed/simple;
	bh=j/tNROBJ9AqaM/+F/rmOXFHzO6aVOQ/0E5dPcthSGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXY1uwk0Bca0uYIAV1HLAkY76vmpPorJPFQAlN7pXDq1az3NVpY4JyL0V3kxdyP1LIMCYmBbPhNGE7epFsUxWjJ26Yr0hMAHFoBI0VXVcF4fQdLgLmSYvGNHj9H4PbXi8nYnI3ONykAo6y2quc+PAPc0a/y9sHKam760w17ZXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOvxIEhd; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso3989175ab.1;
        Thu, 24 Jul 2025 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753352063; x=1753956863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoxQrE9BQllINJgA23hOAwgoifAhEszw6BlmYIQoAW8=;
        b=VOvxIEhd5xgO4Dm+vHyxrJNul3L0D3LoL5JxBdkX487Q5c6hJsHm8yn2q8HCZBLj1n
         /MFg5LfY2SUzETrwuiZndxiT1+Jykj9oyHbXNSS+3GOHGnAvJ5yA8ce6ffA99LI7iiY0
         P/c9WJQGrQ0jSlbIFbej0uTIIZFDlPlNkybZXHY3/coDrK1P0qR3owko8mtoBDcEjQIy
         6kWiPEYO4ludeFcDF0WepAsI6LZ5QTjqN3/uh6/gIjkGYT+2bUXVdwC5VbNKRL3hHd9V
         s6qStlwk7FKmh9jh19io/3EGkZVy2opoQHSzdA8ye/u+38kDNwiKDwEJsBLSBAfWT74J
         6AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352063; x=1753956863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoxQrE9BQllINJgA23hOAwgoifAhEszw6BlmYIQoAW8=;
        b=VH8+vxa3ckxvBA77hGeuPZS6c0EJNeowuh0i9RdK04LbVYHQ/0RCH9uCLNcc3u4vjI
         bhOWWP0dOiBNRrT2GMP2HvbYPVHg4m67GCHCiMOuc00zHSv9UeJd30iE6NGuomGKXmfc
         LZc3uJwJVxmQuUsf6cXzt6m3Aa11lt+ngRj/mZAiCLjEiD0u60eQY1je4W6R6dn/QRYl
         G3fSmGTcXlOcStQdMBUzE8q0pdswB0yQ0/y9slszGLWjMpcjfYH3+5c23n8hpNRpXc5C
         a0s8pn6UOuv6WwpDOj2MpQGX3XMbocrPXoQmQgCIyZiAXInKACaOc9XTptRiT5T3LqP5
         q88w==
X-Forwarded-Encrypted: i=1; AJvYcCUz2ILIO9XFDs+YzOkIS5Z1Mz3wnRwAUHz12Y4qR/u9TkF2vIvojXHraz62qXDoAFMt1I4dOxy9n7TsCpjx@vger.kernel.org, AJvYcCWbIlBHpZoYAcIABgfkb6HZLf2BJS1fCmsQVHoT9enK9fm8Cyz8xIK/Eq1GSKAnoVi3gHV7e25VDbfk@vger.kernel.org, AJvYcCX7EnApAad/Lv7NkZ1CMBKPtyIuZSLn3/yhJoAEtMRvAXj5caYdiVJtLEtf+TkhuL+EAZcus9ZpeNRxOP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjwLCgOrQFZ8IoYabMv3FcU7aCqHYc59kCygzHwhY/+3yqEx6
	+RNVa1Jf6rldD7I3m564kzJ4kVQ1TsimE5m4iX6mJ0+Zg1mbfaLcbAielV3ZiVlMx6L3rHTxfEL
	m5VDNFmUVKu/AnFt2egqseaJCIiJK2nc=
X-Gm-Gg: ASbGncshhLWcAJF2Ypp5dnVp7Tyt6ispUW1HSJU9BpMvyeHSC/ecVBjEZvegjrSHyxI
	crIrjekH5TMGYAeatipF+EiCeRnGCmr0OimezMEouhyPlN0HdMBV9K3yRH+sD0uAar4uOvcE/wI
	JBRE6+9P7Uva7DN10x0mOeQ3W3QsDC9CbHLDOlyFHfFsdOUTDBMBxiUS/gCCNe3liKJZQxDTfbF
	Fme0VM=
X-Google-Smtp-Source: AGHT+IFuX+HkjjMmIqfOcPi1Vf9XVVv1BJDb7TK2k3LjKb0AvDjYDmsh1XyejNfF4igxDfky969ahsCQGQoG5Rin4/s=
X-Received: by 2002:a05:6e02:1945:b0:3e2:a40e:d29f with SMTP id
 e9e14a558f8ab-3e3418d71c5mr88504975ab.9.1753352063278; Thu, 24 Jul 2025
 03:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
 <20250724072248.1517569-3-shengjiu.wang@nxp.com> <87jz3ykpju.wl-tiwai@suse.de>
 <20250724-fair-sheep-of-success-e02586-mkl@pengutronix.de>
In-Reply-To: <20250724-fair-sheep-of-success-e02586-mkl@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 24 Jul 2025 18:14:10 +0800
X-Gm-Features: Ac12FXy8l34qKKJsPON1hex-xaVDf1J211wM6fAeHOddOjpvI8f17HQ8iYSYGc8
Message-ID: <CAA+D8AN2B_RZ9iZ3qE5zMBfs7BMAkruSRQupoXyrsr7Tt+Gfkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ALSA: Add definitions for the bits in IEC958 subframe
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>, Shengjiu Wang <shengjiu.wang@nxp.com>, imx@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com, 
	festevam@gmail.com, simona@ffwll.ch, robh@kernel.org, rfoss@kernel.org, 
	airlied@gmail.com, tiwai@suse.com, jernej.skrabec@gmail.com, 
	p.zabel@pengutronix.de, luca.ceresoli@bootlin.com, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, tzimmermann@suse.de, jonas@kwiboo.se, victor.liu@nxp.com, 
	s.hauer@pengutronix.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, 
	linux-arm-kernel@lists.infradead.org, neil.armstrong@linaro.org, 
	lumag@kernel.org, dianders@chromium.org, kernel@pengutronix.de, 
	cristian.ciocaltea@collabora.com, krzk+dt@kernel.org, shawnguo@kernel.org, 
	l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:40=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 24.07.2025 09:37:09, Takashi Iwai wrote:
> > On Thu, 24 Jul 2025 09:22:44 +0200,
> > Shengjiu Wang wrote:
> > >
> > > The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are us=
ed
> > > in HDMI and DisplayPort to describe the audio stream, but hardware de=
vice
> > > may need to reorder the IEC958 bits for internal transmission, so nee=
d
> > > these standard bits definitions for IEC958 subframe format.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  include/sound/asoundef.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
> > > index 09b2c3dffb30..7efd61568636 100644
> > > --- a/include/sound/asoundef.h
> > > +++ b/include/sound/asoundef.h
> > > @@ -12,6 +12,15 @@
> > >   *        Digital audio interface                                   =
   *
> > >   *                                                                  =
        *
> > >   *******************************************************************=
*********/
> > > +/* IEC958 subframe format */
> > > +#define IEC958_SUBFRAME_PREAMBLE_MASK      (0xf)
> > > +#define IEC958_SUBFRAME_AUXILIARY_MASK     (0xf<<4)
> > > +#define IEC958_SUBFRAME_SAMPLE_24_MASK     (0xffffff<<4)
> > > +#define IEC958_SUBFRAME_SAMPLE_20_MASK     (0xfffff<<8)
> > > +#define IEC958_SUBFRAME_VALIDITY   (0x1<<28)
> > > +#define IEC958_SUBFRAME_USER_DATA  (0x1<<29)
> > > +#define IEC958_SUBFRAME_CHANNEL_STATUS     (0x1<<30)
> > > +#define IEC958_SUBFRAME_PARITY             (0x1<<31)
> >
> > I'd use "U" suffix as it can reach to the MSB.
> > Also, you can put spaces around the operators to align with the
> > standard format, too.  I guess you followed to the other code there,
> > but following to the standard coding style would be better.
> >
> > With those addressed, feel free to take my ack for this patch:
>
> Or make use of the BIT() and GEN_MASK() helpers.

Is it acceptable to include the headers in this file?

Best regards
Shengjiu Wang


>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

