Return-Path: <linux-kernel+bounces-760901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FDB1F1D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C441887DF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272C2777E2;
	Sat,  9 Aug 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="w+Ntyf/N"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B571B0420
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702310; cv=none; b=UUB4UPYtaDhE+HeEBjzWbe3sHrku2MA4G3lomDD2KoV6RZ8Bsi9xvlgypiyWMarBe01OTHmpJIVYmGRPOOUsdPZibTRVHDzHYfUyRPjeGp6lJwruwUJwZ7ysuWkyCpdC8LiHVEmmSaClZJUz0Jtq+I+dhMEH0yI0Fy1j0SML67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702310; c=relaxed/simple;
	bh=iU7BXTipsFED+ZDQbRbSu5G7hc4i8CJS6CcuKnSTBs8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=GH3LqOqKaabL72o6n8WyMMdXGUj10sLsGH9LBXPO8wNq7JVZxNgqxdcmmuzIvq2oTJiymo34BioIQE/bq+X++ZVc/qnhPZnGpXAmfv+ICJ3KoHLOsK/xzWsol9urdFU1Fuj5O/xZu8XUFN78yqgzb4bRzyMcdfs8daV3uAt9Tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=w+Ntyf/N; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1754702299; x=1754961499;
	bh=iU7BXTipsFED+ZDQbRbSu5G7hc4i8CJS6CcuKnSTBs8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=w+Ntyf/NE2JgUSQtNFUmMvLGbJdQZTl7ms2N3Y3/oAghrYrZV97pAKx7DuvwCTorN
	 41w4jNkGMjAztt01AOZ8lIGn+il8QuS+Qqr1kUttnp3zn0FC9DaZdnkPf0ZjJWNR3+
	 5UG+b5OImHfvVOCpunf9zino/RS5YGblzlefzOAS5JgZpLoZaVxLptHq4YD5AjEroS
	 bkLSTpClwkmSqoXi5LEEc2SdiYrdAfsthn4VZavklcvVvnp8V6Mu0SphTPOXeBF19X
	 cTk3ep7YdO1kYE6ESZRns1zP/EA2V0zulT4OrWbOmQaib6uDC7DICnsta+xHg0tGfq
	 sYaNyb3GSycmA==
Date: Sat, 09 Aug 2025 01:18:12 +0000
To: "CC:  Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: andreasx0 <andreasx0@protonmail.com>
Subject: [BUG] x86_64: build failure in switch_fpu() due to missing x86_task_fpu() declaration (v6.16)
Message-ID: <sKlZWc4ZTdYjcxIz044xyWaiwKFcUX0hvTA1IJ_QTzQ3sXhTuLidgIZS2d51P-t1TQHt3F4eXLfXLGbXpisbBqpsZxCsWhpbWUoNe4ESC-o=@protonmail.com>
Feedback-ID: 4793980:user:proton
X-Pm-Message-ID: b3db9d91ed473375d240d3b04b82d43d4ade6cc8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------69b27b14c2bbbb6de862d3a1a33a82f180b60fd50f24b5393c4a6048ab668b34"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------69b27b14c2bbbb6de862d3a1a33a82f180b60fd50f24b5393c4a6048ab668b34
Content-Type: multipart/mixed;boundary=---------------------adb7d254faabe080e780393ed3ed758c

-----------------------adb7d254faabe080e780393ed3ed758c
Content-Type: multipart/alternative;boundary=---------------------ba4b00fdff4d86d5e3604f5e9f5d1784

-----------------------ba4b00fdff4d86d5e3604f5e9f5d1784
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,
When building Linux kernel v6.16 for x86_64, I encountered a build failure=
:

=C2=A0 In file included from arch/x86/kernel/process_64.c:46:
=C2=A0 ./arch/x86/include/asm/fpu/sched.h:37:39: error: implicit declarati=
on of function =E2=80=98x86_task_fpu=E2=80=99; did you mean =E2=80=98set_t=
ask_cpu=E2=80=99? [-Wimplicit-function-declaration]
=C2=A0 =C2=A0 =C2=A037 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct fpu *old_fpu =3D x86_task_fpu(old);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ^~~~~~~~~~~~
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 set_task_cpu
=C2=A0 ./arch/x86/include/asm/fpu/sched.h:37:39: error: initialization of =
=E2=80=98struct fpu *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]


Thanks
-----------------------ba4b00fdff4d86d5e3604f5e9f5d1784
Content-Type: multipart/related;boundary=---------------------a8877c96e12b2375f6be333060d0f419

-----------------------a8877c96e12b2375f6be333060d0f419
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTAuNXB0OyBsaW5lLWhlaWdodDogbm9ybWFsOyI+SGVs
bG8sPC9zcGFuPjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTAu
NXB0OyBsaW5lLWhlaWdodDogbm9ybWFsOyI+V2hlbiBidWlsZGluZyBMaW51eCBrZXJuZWwgdjYu
MTYgZm9yIHg4Nl82NCwgSSBlbmNvdW50ZXJlZCBhIGJ1aWxkIGZhaWx1cmU6PC9zcGFuPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTAuNXB0OyBsaW5l
LWhlaWdodDogbm9ybWFsOyI+Jm5ic3A7IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzc182NC5jOjQ2Ojwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250
LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPiZuYnNwOyAuL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2ZwdS9zY2hlZC5oOjM3OjM5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24g4oCYeDg2X3Rhc2tfZnB14oCZOyBkaWQgeW91IG1lYW4g4oCYc2V0X3Rhc2tf
Y3B14oCZPyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl08L3NwYW4+PC9kaXY+PGRp
dj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMC41cHQ7IGxpbmUtaGVpZ2h0OiBub3JtYWw7Ij4m
bmJzcDsgJm5ic3A7ICZuYnNwOzM3IHwgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBzdHJ1Y3QgZnB1ICpvbGRfZnB1ID0geDg2X3Rhc2tfZnB1
KG9sZCk7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTAuNXB0OyBs
aW5lLWhlaWdodDogbm9ybWFsOyI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHwgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7IF5+fn5+fn5+fn5+fjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJm
b250LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPiZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyB8ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBzZXRfdGFza19jcHU8L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMC41cHQ7IGxpbmUtaGVpZ2h0OiBub3JtYWw7
Ij4mbmJzcDsgLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvc2NoZWQuaDozNzozOTogZXJyb3I6
IGluaXRpYWxpemF0aW9uIG9mIOKAmHN0cnVjdCBmcHUgKuKAmSBmcm9tIOKAmGludOKAmSBtYWtl
cyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbLVdpbnQtY29udmVyc2lvbl08
L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBm
b250LXNpemU6IDE0cHg7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6IHJn
YigyNTUsIDI1NSwgMjU1KTsiPjxzcGFuPjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9u
dC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPlRoYW5rczwvc3Bh
bj48L2Rpdj4=
-----------------------a8877c96e12b2375f6be333060d0f419--
-----------------------ba4b00fdff4d86d5e3604f5e9f5d1784--
-----------------------adb7d254faabe080e780393ed3ed758c
Content-Type: application/pgp-keys; filename="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"; name="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"; name="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWkk3bTN4WUpLd1lCQkFI
YVJ3OEJBUWRBN1NSTmw4bVlHN2lIZUY5QytpNWdzbXBZdUJpeXQzYjYKM0FlNGN4d1c3cUxOTTJG
dVpISmxZWE40TUVCd2NtOTBiMjV0WVdsc0xtTnZiU0E4WVc1a2NtVmhjM2d3ClFIQnliM1J2Ym0x
aGFXd3VZMjl0UHNLTUJCQVdDZ0ErQllKa2p1YmZCQXNKQndnSmtMWm8xSzhrbmExUQpBeFVJQ2dR
V0FBSUJBaGtCQXBzREFoNEJGaUVFOWh1eFNGUmFIWUNLNWdMOHRtalVyeVNkclZBQUFLOWsKQVFD
ODlZS20rT3YvdDl3OVo3WS95Z2x1anl2dFBPZkcrenpDVDNtcmpVTU52QUQvYTE0eENQZGVTSXFk
CnFRM1dhcktycXpnczVlSzBSNHVTU1h0MU42b0dUZy9PT0FSa2p1YmZFZ29yQmdFRUFaZFZBUVVC
QVFkQQpYUUE5aGdVcjRYazRXemU1TVhOTUIwOEMvcEtBR0lrcWNvd2w2MmpjV1cwREFRZ0h3bmdF
R0JZSUFDb0YKZ21TTzV0OEprTFpvMUs4a25hMVFBcHNNRmlFRTlodXhTRlJhSFlDSzVnTDh0bWpV
cnlTZHJWQUFBR2ZICkFRRDZkUmxnZmtKZWFyaHdLWHFtbWlHTVlmU1c0V3hhMVFvSm9JbHdzQXQz
YndEL1hTWmo4ZUFibStpMQpxaDRhbWh0eTFHYitTMGV3MVNicnRrSjREWmNNdUFRPQo9dGZYVQot
LS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------adb7d254faabe080e780393ed3ed758c--

--------69b27b14c2bbbb6de862d3a1a33a82f180b60fd50f24b5393c4a6048ab668b34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmiWockJkLZo1K8kna1QRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdbEcFChRUd6D40NfY++KEqIs6IKByJYX4WQeIN
yvJXFRYhBPYbsUhUWh2AiuYC/LZo1K8kna1QAABccAEAkXYQ57C1Hbu5o3IY
zaPOod3RmBzVa5b6nsIQ+oo9vVgBAK3zb6uJmodptjw/j75EcvS1Kd9T6phe
UCXavJgE+X4P
=7Ftb
-----END PGP SIGNATURE-----


--------69b27b14c2bbbb6de862d3a1a33a82f180b60fd50f24b5393c4a6048ab668b34--


