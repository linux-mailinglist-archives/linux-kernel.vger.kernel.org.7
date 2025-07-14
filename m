Return-Path: <linux-kernel+bounces-730011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7CDB03F17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C13A1ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2124A051;
	Mon, 14 Jul 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="dYUAqwO3"
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DF1DEFDD;
	Mon, 14 Jul 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497877; cv=none; b=M2iIv24kImge7WzAvQzRGiJPuLru6Vg9yohnV+wi3UGiaY51KI3DfNviPvHgrzmcRw3jrsX1IevW77VxVoKO5TPwLFK4RIZEf/V26x7hXSHND7/bZ1bKkazletb4q5KxTOVXpBhAwCO+NatTGnUKl5XHtGh8MS16n1xMn9376IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497877; c=relaxed/simple;
	bh=uKbAbfvz+XZE7TH/g+D66NU3AsiaHka3Ejus0cO4b20=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=Qr4wpVbfNKMo/1TvuqX/peofP+ZwsxkFaC1IPSkr1UpSIU1ZcMshVTCHXf9OaFOV0LoQEMZOsxfy3UmZBIQbqKZIaUhYmOlJVXR15kCbyU2jIk/ZhGNHn1k+Pjv2pAoZYZtcJ26O3qVeLyIu0QsUJdJcD8Dj7ulw69o6N/g38tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=dYUAqwO3; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=dYUAqwO3;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id C5F732444CD;
	Mon, 14 Jul 2025 14:57:52 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id Ppfz7W-WyujC; Mon, 14 Jul 2025 14:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1752497871; bh=uKbAbfvz+XZE7TH/g+D66NU3AsiaHka3Ejus0cO4b20=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=dYUAqwO3LmWva+vex2eh5Ta/Ker3HfhQLgmTDWR64itIaTWfZTSNdIndSB36u7HaJ
	 niGY0mYcWwjHq2+zTlpylF8pp21wsQ+5fEfxenQ/88dVP9vf4rFIeQiwqiojEztfGg
	 XB/Da4sWCuXiZv2dUmaHHcUly4Tj7hK+lvvQYeixndht7aEZ9voW/HIlvYgnPSI30K
	 NSG/rxKnG7fpAkJS2iqEd5S0GU9cIHfVfkCc3Oe0H4qtsQ/L/34fnxJO8WFTTBjcda
	 nVcXYJ8hsZ228pIf5oPCB9lf/ozM8LldWk/KlarBEW4nzNSQfOr8SyvOMgQMnAZgJJ
	 e5z+iRrixcpBA==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id A75652444CB;
	Mon, 14 Jul 2025 14:57:51 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 85B231601BA; Mon, 14 Jul 2025 14:57:51 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: [PATCH] platform/x86: asus-wmi: map more keys on ExpertBook B9
From:  Anton Khirnov <anton@khirnov.net>
To:  Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc:  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:  <4a828765-abf0-4b19-95c8-bfde01d7026d@kernel.org>
References:  <20250702070231.2872-1-anton@khirnov.net>
 <4a828765-abf0-4b19-95c8-bfde01d7026d@kernel.org>
Date: Mon, 14 Jul 2025 14:57:51 +0200
Message-ID: <175249787152.21445.16925102541286211351@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Hans,
Quoting Hans de Goede (2025-07-14 14:34:04)
> Hi,
>=20
> On 2-Jul-25 09:02, Anton Khirnov wrote:
> > * there is a dedicated "noise cancel" key in top row, between mic mute
> >   and PrintScreen; it sends 0xCA when pressed by itself (mapped to F14),
> >   0xCB with Fn (mapped to F15)
> > * Fn+f sends 0x9D; it is not documented in the manual, but some web
> >   search results mention "asus intelligent performance"; mapped to PROG2
> > * Fn+space sends 0x5B; it is not documented or mentioned anywhere I
> >   could find; mapped to PROG3
> >=20
> > Signed-off-by: Anton Khirnov <anton@khirnov.net>
> > ---
> >  drivers/platform/x86/asus-nb-wmi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/as=
us-nb-wmi.c
> > index 3f8b2a324efd..42d7b435ba63 100644
> > --- a/drivers/platform/x86/asus-nb-wmi.c
> > +++ b/drivers/platform/x86/asus-nb-wmi.c
> > @@ -573,6 +573,7 @@ static const struct key_entry asus_nb_wmi_keymap[] =
=3D {
> >  	{ KE_KEY, 0x55, { KEY_CALC } },
> >  	{ KE_IGNORE, 0x57, },  /* Battery mode */
> >  	{ KE_IGNORE, 0x58, },  /* AC mode */
> > +	{ KE_KEY, 0x5B, { KEY_PROG3 } }, /* Fn+space */
>=20
> What is this key-combo supposed to do, is there any icon for this on
> the spacebar? What does it do under Windows?

I don't have Windows installed, so I cannot test what any of these keys
do there.

I searched the web for any mentions of this key combination and found
nothing whatsoever, the manual is also silent. But it does generate an
event, so it seemed reasonable to make use of it.

> Based on other laptops I would expect this to maybe need to be
> KEY_KBDILLUMTOGGLE, which toggles the kbd backlight on/off ?

Keyboard backlight is Fn+F7 on this laptop. That said, I'm fine with any
key that is acceptable to you and/or other maintainers.

>=20
> >  	{ KE_KEY, 0x5C, { KEY_F15 } },  /* Power Gear key */
>=20
> Why KEY_F15, Why not some other KEY_ ? Generally speaking
> the key-code send should match the intended purpose of
> they key / key-combo. E.g. If the button opens
> the control-panel under Windows use KEY_CONTROLPANEL

Err I'm not doing anything to this one.

> > @@ -609,6 +610,7 @@ static const struct key_entry asus_nb_wmi_keymap[] =
=3D {
> >  	{ KE_KEY, 0x93, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + DVI=
 */
> >  	{ KE_KEY, 0x95, { KEY_MEDIA } },
> >  	{ KE_KEY, 0x99, { KEY_PHONE } }, /* Conflicts with fan mode switch */
> > +	{ KE_KEY, 0X9D, { KEY_PROG2 } }, /* Fn+f */
>=20
> Same remark as on the other keys. what does this do under Windows ?

As per above, cannot test. But in this case a web search suggests that
(on some other Asus laptop) it switches between performance profiles.

> > @@ -623,6 +625,8 @@ static const struct key_entry asus_nb_wmi_keymap[] =
=3D {
> >  	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notificati=
on */
> >  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
> >  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
> > +	{ KE_KEY, 0xCA, { KEY_F14 } }, /* Noise cancelling on Expertbook B9 */
>=20
> KEY_SOUND ?

Can do, but then what about the fn+ version? Ideally they should be
related.

> > +	{ KE_KEY, 0xCB, { KEY_F15 } }, /* Fn+noise-cancel */
>=20
> What does Fn + noise-cancel do under Windows ?

As per the manual:

  Built-in microphone: Toggles between single presenter conference call
                       mode or multi presenter conference call mode.
  External microphone: Toggles ASUS AI Noise-Canceling.

Thanks for the review,
--=20
Anton Khirnov

