Return-Path: <linux-kernel+bounces-730136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF3B0409D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28E7188234D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCE253954;
	Mon, 14 Jul 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="hK6chamL"
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183911EEE0;
	Mon, 14 Jul 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501240; cv=none; b=cZvll4UCBzVbDFFjzYLBfEXpHHDnpr4p0jFwHw/Q1E4xzL1umN3mECV6gO9Wfii9BW3zNt22QKwwzsHvucSq0SRvyRHNPSYJKiL6H460spG2anAtim7v+XmuGiZbKtozyzLZfsQEiWwD5rz/K7caAhRZVxpK5Cyp2dW8qURZPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501240; c=relaxed/simple;
	bh=MPM7OO/aKF0zDWeCaIzi0szuiYfnku+lOCVULGv2Ssg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=O0wl6fItbVCSbHCJ7hu9e049QSkPJrgnfXBxjkUbfq9qCK3Wi28EKvvg8fG+xkHqIRxiMXhX9m/WXvF9KV80iu1ZsMw0+BTvhyS1Ob2YoWaQnyd4WkFzGR7ui0Y8eYZ/8gtSP/0YtzobvHrKxv/CS5no4k+NIzpPRx6I+gqUAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=hK6chamL; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=hK6chamL;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id 793C02444CE;
	Mon, 14 Jul 2025 15:53:53 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id S30Lb9pqsdlI; Mon, 14 Jul 2025 15:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1752501232; bh=MPM7OO/aKF0zDWeCaIzi0szuiYfnku+lOCVULGv2Ssg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=hK6chamL7gDQFvbkf7bpFAeSbOMcgnHb32yCqdvGy2QwJEXwMKLM9474nNpBZtTzE
	 w6Jad4iU+MkxPd2bUGe5gi+V4/HjFJEANkMmPGKB5Ucetyt34zsVA2S9FhFAvboXpC
	 HIH2VG7I24Uwmv2FvoNmvi0Wnh2n8f2ThU5aMAtVs9/G4D+TQW+chKsmbXn8E68TSA
	 Yjt6cGWLIO/ek4HoQA3nRe6jWrQAHKbadrzQ+7geV/i4s30TYRbmsgfUFYgsc0TWkM
	 3QGxFdxSnKn2JL77hijTAih5BZJYTQG3ptiK9HR1wxMxe0OSXXaxIYkyqvGPgnN7WS
	 vV0Ac64ToK1Tg==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 4BC972412EF;
	Mon, 14 Jul 2025 15:53:52 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 3032C1601BA; Mon, 14 Jul 2025 15:53:52 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: [PATCH] platform/x86: asus-wmi: map more keys on ExpertBook B9
From:  Anton Khirnov <anton@khirnov.net>
To:  Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc:  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:  <62871f1b-85aa-4d8c-82a1-2fb65be83094@kernel.org>
References:  <20250702070231.2872-1-anton@khirnov.net>
 <4a828765-abf0-4b19-95c8-bfde01d7026d@kernel.org>
 <175249787152.21445.16925102541286211351@lain.khirnov.net>
 <62871f1b-85aa-4d8c-82a1-2fb65be83094@kernel.org>
Date: Mon, 14 Jul 2025 15:53:52 +0200
Message-ID: <175250123216.21445.8438057789120013393@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Quoting Hans de Goede (2025-07-14 15:27:58)
> >> Based on other laptops I would expect this to maybe need to be
> >> KEY_KBDILLUMTOGGLE, which toggles the kbd backlight on/off ?
> >=20
> > Keyboard backlight is Fn+F7 on this laptop. That said, I'm fine with any
> > key that is acceptable to you and/or other maintainers.
>=20
> Ok, so no KEY_KBDILLUMTOGGLE then if that already is at Fn+F7
>=20
> So lets stick with a KEY_PROG# option here,
> note asus-nb-wmi already used PROG# for:
>=20
>         { KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
>         { KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
>         { KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
>         { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
>         { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow */
> =20
> I guess you checked that this laptop does not send the 0x83 / "Armoury Crat=
e"
> events? What about 0x86 / "MyAsus"? If there is no MyAsus key I would prefer
> to use KEY_PROG1 here.

That is sent by this laptop as Fn+F12, which is why I started at PROG2.

> Or you can add a KEY_FN_SPACE to input-event-codes.h grouping it together
> with the existing Fn + X combos there.

I wasn't sure how big of a deal adding new KEY_ values is. If that isn't
too much of a hassle, I can do that and that takes care of Fn+space/f
consistently.

> >>> +	{ KE_KEY, 0xCA, { KEY_F14 } }, /* Noise cancelling on Expertbook B9 */
> >>
> >> KEY_SOUND ?
> >=20
> > Can do, but then what about the fn+ version? Ideally they should be
> > related.
>=20
> Hmm, can use KEY_PROG3 + KEY_PROG4, assuming that the Fn+ spacebar becomes
> KEY_PROG1 and that KEY_PROG3 / PROG4 are otherwise free ?
>=20
> If not then why start at KEY_F14 and not at KEY_F13, does this laptop's
> keyboard has a key which sends:
>=20
>=20
>         { KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
>=20
> Also are there no conflicts with some of the other entries which send
> F14 / F15 ?
>=20
> As in no other keys which generate the existing codes mapped
> to F13 / F14 / F15 ?

The reason I picked F14 is that the key is physically located two keys
to the right of F12. PROG1 is taken, but the others are free, so I can
do either F13/F14, or PROG2/3.

For posterity, here's a list of all codes sent by this laptop:
* {up,down,left,right}: ACPI button/{up,down,left,right} (in addition to norm=
al ATK event)
* fn-{up,down,left,right}: ATK {PgUp,PgDown,Home,End}
* copilot key (right of AltGr): ATK shift+win+F17
  press+release (immediately, releasing the physical key does nothing)
* fn-lctrl: ATK compose (menu)
* fn-space: WMI unknown key 0x5b
* fn-b: ATK pause (scancode 0xc5)
* fn-p: ATK pause (scancode 0xc6)
* fn-k: ATK scrolllock
* fn-f: WMI unknown key 0x9d (supposed to be "asus intelligent performance")
* fn-a: no event visible anywhere
* fn-esc: toggles between fn/f keys being primary, sends no visible keys exce=
pt ACPI event
* fn-(1-4): WMI scancode 0x61-0x64 (switch video mode);
  also ACPI video/switchmode event identical for all 4 keys
* fn-(f1/f2/f3): ATK mute/voldown/volup + ACPI button/{mute,volumedown,volume=
up}
* fn-f4/f5: ACPI brightness down/up
* fn-f6: WMI scancode 0x6b - F21
* fn-f7: keyboard backlight, sends no visible keys anywhere except ACPI event
* fn-f8: ATK win+p
* fn-f9: ATK win+l
* fn-f10: no event visible anywhere
* fn-f11: ATK win+shift+s
* fn-f12: WMI prog1 (scancode 0x86) + ACPI button/prog1
* mic-mute: WMI F20 (scancode 0xbe) + ACPI button/f20
* mic noise key (right of mic-mute): WMI scancode 0xca; fn- sends 0xcb
* fn-del: insert

Cheers,
--=20
Anton Khirnov

