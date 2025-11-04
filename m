Return-Path: <linux-kernel+bounces-885155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE6C3222D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F734A535
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B0337108;
	Tue,  4 Nov 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Geqq0g0b"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65348333754
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275010; cv=none; b=nSk+w4MOIoL8JmQub5wi+imhgyEUZdwRpKTaG/+ozXAu7B/ceMWdfowPZ9SpQwL8cWGhVF6/hgvXhAhBlufq5eMDq1ADUCRNmP5A+Vtco8Sxvlqo6+eI2J1TdKXbi9PSkt8Wm2topidpi+9u67KjIDrU2El/WPqNp1DFB/sv1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275010; c=relaxed/simple;
	bh=eBpkPlO29A8M7ikSKjAPGZMl8dFPu0v4vf3XdWRDI7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEH4dRxFCToOtzFKropSR31LCMowRVTqxR5dQgZRqpFzHcOjLh7HMqUBuTHfnWKAF7KYC06RVbEKwl6u1ie6zmYxrD+YLDzLdOsjBanbPKAf7eUEwK3e1VZcc7t2C2XbWxm9XNbRejK7huMpBeD89LD46mphjkTZ1Sk9iLC/haI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Geqq0g0b; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bccca1e8so2785769f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762275007; x=1762879807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdZgp8rFwisH6sL9hW06vie32Q/MJPgK1VmXTcKs3fA=;
        b=Geqq0g0bIzH2FOP/mN2FCQQwXrE4DGoqH5RglkLLOOr/oCCdTusH+E96Ab2FBP+f4q
         i8h2JAZeySqBr0uwu8pEJGW6UWmdDn81kYn/hBtXhQpLUndHEmEXHWROnY2EXpVzC23W
         fwPnHY7ndMH7AntoLTuNrvcjzLazUfNAGL+30wSWLu2TfYtj/cTMpVTvy0rYhsGt3pSv
         G1AYfdNX5znxE47X+FQgUV9OdhNxIScdsblrjSwVN5KDxMKGa3IHhjXgtPNGxsWB8SKs
         rdLhv0T5vR7/QMgnbq95Ex6JKTgXBPyiQCDNKyGpq340EGG2M6TAwUYIfTDJEyMJ34Ur
         LA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275007; x=1762879807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdZgp8rFwisH6sL9hW06vie32Q/MJPgK1VmXTcKs3fA=;
        b=cmwSzU1DZm8pO4pdQOsuRHJDsVkGIP1IwS3mfRTjzOzOuzFGX0B46CmbXygVjU6f3/
         tSXEnrJu2/kEw8PGuC569sWL+9PLw3+W2dmyb94zFDE7owh/6UAYENSOsvP+UiyW8mNl
         vmtyM0PnP+xYsRYbxqCPAye5ZEu/5C20EbDX7Dt9rxIUxPceupmqxOtttm1HzgypMjXv
         c2iu66zwyPPSvlBo9vq8lcUsOVWjm6usCRDPfKEGwrSLEkVfnt9G8A37Q15K2NiPCnMP
         suiJAR2Na4tNeAmZVcQYOr9qwcagVEk5+OLv9Jix74TZtC7SQvLl3jU/FQ1bsrFjExgF
         3sAA==
X-Forwarded-Encrypted: i=1; AJvYcCVRaJePgCmWgKmgs5W43yOWpTSv1sS4R+IVylYqIKz33j38AGS6pDwg1K31YA2cYc5uotYimtX522AiSeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjih/d7nJbxAeQCo+glOvl1GQwwhZtHMlc4YGfU8PbSBkF3kum
	R4dSHVR84f64zzIelb/SxvxNIpp0BRZdgPM10/iCo5L7PoZOEvPiab98
X-Gm-Gg: ASbGncsTCuP+Kh0AehyWjOimGChrESmceE5C5yUS0pTYAOSTLng3+rcyE8Hzyc6gLxD
	ljp6phYMwCN7B8vCrSxt6B6BisnXatQrMWEURgNEp06Qo6z92bxoMMx3EKnL/0DV8v3TEU+0JGi
	8mb3My5n7JZSTb8F2d9chM3abkNc8HRwV+IWsC0Llg1+fSN/ANYtmtRwecQLUNP9lVd+2x6oDer
	K+O60ll4o9z5FX6OkRwE2PZU0cCCaZqo4FJMAV+0XvTLmVmZNKcL/YBTGXwtwWDzjOo0xPfOgaZ
	tpV27W2vNZkKprz7ol2KEVHjVEyLl1BJghn0OAGj/D9ZWkvzCYVmi8/5sgO+3OkKiuQitikulnL
	jyxWHcCPFCdMal1Ji8i+YwYGwEI+ktgHJWvq2q24qtSsObcQmwepNpLvOOun+bwezhk+hcixexr
	zOSlibE4ZyW+Sa7DVox3HYZFcZ02BkF339Frx8Ws8D9tJYp9V3AdvpDP60gT1GL24CY6c=
X-Google-Smtp-Source: AGHT+IHsOmcFgrKN0VFuIMGhIpJEUqqSZDIXndB9GVdXwqoNi1GsBka2e33KfnMwqvPBDWre8Hxpqw==
X-Received: by 2002:a05:6000:186b:b0:429:ce81:fe2b with SMTP id ffacd0b85a97d-429ce82013amr7678935f8f.23.1762275006529;
        Tue, 04 Nov 2025 08:50:06 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5be4sm5345170f8f.31.2025.11.04.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:50:06 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 26/30] drm/sun4i: mixer: Add quirk for number of VI scalers
Date: Tue, 04 Nov 2025 17:50:04 +0100
Message-ID: <5959058.DvuYhMxLoT@jernej-laptop>
In-Reply-To:
 <CAGb2v65RecyHZVUN--oSmtzPDpmUHALd3Pqf79a1fKP9yxD8cA@mail.gmail.com>
References:
 <20251012192330.6903-1-jernej.skrabec@gmail.com>
 <20251012192330.6903-27-jernej.skrabec@gmail.com>
 <CAGb2v65RecyHZVUN--oSmtzPDpmUHALd3Pqf79a1fKP9yxD8cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Chen-Yu,

Dne ponedeljek, 3. november 2025 ob 18:11:07 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gm=
ail.com> wrote:
> >
> > On DE2 and DE3, UI scalers are located right after VI scalers. So in
> > order to calculate proper UI scaler base address, number of VI scalers
> > must be known. In practice, it is same as number of VI channels, but it
> > doesn't need to be.
> >
> > Let's make a quirk for this number. Code for configuring channels and
> > associated functions won't have access to vi_num quirk anymore after
> > rework for independent planes.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c     | 11 +++++++++++
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h     |  2 ++
> >  drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 10 +++++-----
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4=
i/sun8i_mixer.c
> > index 78bbfbe62833..f9131396f22f 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -708,6 +708,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixe=
r0_cfg =3D {
> >         .scaler_mask    =3D 0xf,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 3,
> >         .vi_num         =3D 1,
> >  };
> > @@ -718,6 +719,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixe=
r1_cfg =3D {
> >         .scaler_mask    =3D 0x3,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 1,
> >         .vi_num         =3D 1,
> >  };
> > @@ -729,6 +731,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0=
_cfg =3D {
> >         .scaler_mask    =3D 0xf,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 3,
> >         .vi_num         =3D 1,
> >  };
> > @@ -740,6 +743,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer=
0_cfg =3D {
> >         .scaler_mask    =3D 0xf,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 3,
> >         .vi_num         =3D 1,
> >  };
> > @@ -751,6 +755,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer=
1_cfg =3D {
> >         .scaler_mask    =3D 0x3,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 1,
> >         .vi_num         =3D 1,
> >  };
> > @@ -761,6 +766,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer=
_cfg =3D {
> >         .ui_num =3D 1,
> >         .scaler_mask =3D 0x3,
> >         .scanline_yuv =3D 2048,
> > +       .vi_scaler_num  =3D 2,
> >         .ccsc =3D CCSC_MIXER0_LAYOUT,
> >         .mod_rate =3D 150000000,
> >  };
> > @@ -772,6 +778,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer=
0_cfg =3D {
> >         .scaler_mask    =3D 0x3,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 1,
> >         .vi_num         =3D 1,
> >  };
> > @@ -783,6 +790,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer=
1_cfg =3D {
> >         .scaler_mask    =3D 0x1,
> >         .scanline_yuv   =3D 1024,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 0,
> >         .vi_num         =3D 1,
> >  };
> > @@ -794,6 +802,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixe=
r0_cfg =3D {
> >         .scaler_mask    =3D 0xf,
> >         .scanline_yuv   =3D 4096,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 3,
> >         .vi_num         =3D 1,
> >  };
> > @@ -805,6 +814,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixe=
r1_cfg =3D {
> >         .scaler_mask    =3D 0x3,
> >         .scanline_yuv   =3D 2048,
> >         .de2_fcc_alpha  =3D 1,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 1,
> >         .vi_num         =3D 1,
> >  };
> > @@ -814,6 +824,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer=
0_cfg =3D {
> >         .mod_rate       =3D 600000000,
> >         .scaler_mask    =3D 0xf,
> >         .scanline_yuv   =3D 4096,
> > +       .vi_scaler_num  =3D 1,
> >         .ui_num         =3D 3,
> >         .vi_num         =3D 1,
> >  };
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4=
i/sun8i_mixer.h
> > index def07afd37e1..40b800022237 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > @@ -178,6 +178,7 @@ enum sun8i_mixer_type {
> >   * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
> >   * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
> >   *     Most DE2 cores has FCC. If number of VI planes is one, enable t=
his.
> > + * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
> >   * @map: channel map for DE variants processing YUV separately (DE33)
> >   */
> >  struct sun8i_mixer_cfg {
> > @@ -189,6 +190,7 @@ struct sun8i_mixer_cfg {
> >         unsigned int    de_type;
> >         unsigned int    scanline_yuv;
> >         unsigned int    de2_fcc_alpha : 1;
> > +       unsigned int    vi_scaler_num;
>=20
> This could be a smaller type. Please do a sweep of the struct after the
> refactoring is done and see if any of the types could be shrunk.

A lot of things can be stored in smaller type. However, making things small=
er
may be contraproductive. Structs are usually aligned for performance reason=
s,
so it won't save any memory and accessing them will use extra asm instructi=
ons
for zeroing out parts of CPU registers since registers are larger than used
data type.

>=20
> And just a nitpick, but I would probably insert it above scaler_mask.
>=20

Will do.

>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>=20

Thanks.

Best regards,
Jernej



