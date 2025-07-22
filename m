Return-Path: <linux-kernel+bounces-740903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE81B0DADF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4057A1BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705E28AAE6;
	Tue, 22 Jul 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ugq2dKgO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DA22094;
	Tue, 22 Jul 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191108; cv=none; b=UnNpP9M6kYQuo5F08yBQmQV2cwsBuKIU8rfSzq3QntncrJtUP7mFuLvMobf2SJOtZeEcsugFHb3b79NSVR3OVep5zKEz/14B5DUU3Q1q68BgKasRSUdOQ/t0Ync5l9ev2bn8ltySaQGCzqCXhQldw5q7Ta048wW9GCPhXs2EEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191108; c=relaxed/simple;
	bh=e0uI9tHQgMQf77YjaxHzIMxjYcTSwyPrvwYo4128UVY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K2X7+Tn5U+bkFFBDYvyV79HO3phd1QapRnWAwO+WATOFWgjNjpL/f0W27/9eNKb8VkPSUIMHJ+nCJlpyiyM2IXIyD5j9F9JA5OiFZ8gI2a/m2Xf8qcq7Km9mVQQ7z7GL5SN9CfdLDlZ0TLFBX2TG5VxPkuMxRb3lloMrm5dI2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ugq2dKgO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753191107; x=1784727107;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=e0uI9tHQgMQf77YjaxHzIMxjYcTSwyPrvwYo4128UVY=;
  b=Ugq2dKgOtM/VrQCfKiR1llZYTEC95vQ/fOOs2C6NljlwM4xuGTZ/J0jW
   8vmMMG7bAz0DmbzEu4SnqnKAWWMYUvd6omH9kn+yS305lju6qcrFevOby
   2XF4zXgbub9n4+xRHMpEEtiE55FcHWj7rkh4nEtGcZlO0iajmOyJUbPcK
   8l3dRMjgpes5LDaubj5kvoBGj0FbMyoa6AKSq2/W7DgdEwZcfJm7m61t7
   QdN3ZfP27bv4mxL71AscSTO0dDgdw6gQ7NbVW+JMr+6maufEAWa2Pmasg
   QJz5pqVwf7UmJbipMzHvTqdiYVmft2+e2M8HhEgeAyfzGBnWrqNxHhHI4
   g==;
X-CSE-ConnectionGUID: zZO1wlB9Sf2dLcPmsN8PWQ==
X-CSE-MsgGUID: vFl8XHoiRB6HxBZMsEgUtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55324317"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55324317"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:31:47 -0700
X-CSE-ConnectionGUID: 27QDQDHMR4a17TKj53r9tA==
X-CSE-MsgGUID: LOUQWW8uRPSai2T0nz+Pug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159697221"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:31:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Jul 2025 16:31:39 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, Eileen <eileen@one-netbook.com>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Fix turbo register for G1
 AMD
In-Reply-To: <CAGwozwFvWuXM_oSzY9S+2CdW+dHiusuYra6kJeA+Vo00NZFb4g@mail.gmail.com>
Message-ID: <73ae539a-96e3-bec3-f02c-e74660297b38@linux.intel.com>
References: <20250718163305.159232-1-lkml@antheas.dev> <710baf02-fc18-6752-b8bd-bbf1354227e8@linux.intel.com> <CAGwozwFvWuXM_oSzY9S+2CdW+dHiusuYra6kJeA+Vo00NZFb4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-812461108-1753191061=:920"
Content-ID: <27bc94a9-34a6-1ce2-f9b6-79dd743ccda1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-812461108-1753191061=:920
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2313014d-8f39-f8eb-6da4-98a80299e629@linux.intel.com>

On Tue, 22 Jul 2025, Antheas Kapenekakis wrote:

> On Tue, 22 Jul 2025 at 15:22, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Fri, 18 Jul 2025, Antheas Kapenekakis wrote:
> >
> > > Turns out that the AMD variant of the G1 uses different turbo registe=
rs
> > > than the Intel variant. Differentiate them and apply the correct ones
> > > to the AMD variant.
> > >
> > > Fixes: b369395c895b ("platform/x86: oxpec: Add support for the OneXPl=
ayer G1")
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >  drivers/platform/x86/oxpec.c | 37 +++++++++++++++++++++++-----------=
--
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpe=
c.c
> > > index 06759036945d..9839e8cb82ce 100644
> > > --- a/drivers/platform/x86/oxpec.c
> > > +++ b/drivers/platform/x86/oxpec.c
> > > @@ -58,7 +58,8 @@ enum oxp_board {
> > >       oxp_mini_amd_a07,
> > >       oxp_mini_amd_pro,
> > >       oxp_x1,
> > > -     oxp_g1,
> > > +     oxp_g1_i,
> > > +     oxp_g1_a,
> > >  };
> > >
> > >  static enum oxp_board board;
> > > @@ -247,14 +248,14 @@ static const struct dmi_system_id dmi_table[] =
=3D {
> > >                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > >                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 =
A"),
> > >               },
> > > -             .driver_data =3D (void *)oxp_g1,
> > > +             .driver_data =3D (void *)oxp_g1_a,
> > >       },
> > >       {
> > >               .matches =3D {
> > >                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > >                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 =
i"),
> > >               },
> > > -             .driver_data =3D (void *)oxp_g1,
> > > +             .driver_data =3D (void *)oxp_g1_i,
> > >       },
> > >       {
> > >               .matches =3D {
> >
> >
> > > -     case oxp_g1:
> > > +     case oxp_g1_i:
> > >               return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> > > @@ -757,6 +765,7 @@ static int oxp_pwm_fan_speed(long *val)
> > > +     case oxp_g1_a:
> > >               return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> >
> > > -     case oxp_g1:
> > > +     case oxp_g1_i:
> > >               /* scale to range [0-184] */
> > >               val =3D (val * 184) / 255;
> > >               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> > > @@ -796,6 +805,7 @@ static int oxp_pwm_input_write(long val)
> > > +     case oxp_g1_a:
> > >               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> > > @@ -816,7 +826,7 @@ static int oxp_pwm_input_read(long *val)
> > > -     case oxp_g1:
> > > +     case oxp_g1_i:
> > >               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> > > @@ -842,6 +852,7 @@ static int oxp_pwm_input_read(long *val)
> > > +     case oxp_g1_a:
> > >       default:
> > >               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> >
> > Do these FAN and PWM registers fall under what is described in the
> > changelog as "turbo registers"? Or did you extend the scope of this pat=
ch
> > and forgot to update the changelog?
>=20
> Yes. Perhaps its not the best wording and it should have said EC register=
s.

Indeed, it is not the best wording as there is a register which has=20
"TURBO" in its name so it's a bit confusing. I'll reword the changelog=20
while applying.

--=20
 i.
--8323328-812461108-1753191061=:920--

