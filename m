Return-Path: <linux-kernel+bounces-843745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1460EBC01FC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64603B5756
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86421257B;
	Tue,  7 Oct 2025 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HBwEoR2N"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5328682
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809849; cv=none; b=LE8ad2bXCuGEkwoFPJ+ORwBW/gRuNUq6Ag7oWS2ROJmKF+TZUL/sGMnVjl9AL721SeiZsCMH/RepJpVvT6kc9b+cOJ+DZLInw1Hd+8NTlGMh8AQRrROHPAgBHbAITzq77/ibjeOpwfXBLbbvAvE+ty9z7qSrOo7CpKWwP8HgPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809849; c=relaxed/simple;
	bh=Q7n96OT1S3HEVJQQ62629j6qK9RQsTV06PQ5yf6xPek=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KnwMSwGFoOTl63Wk9HM/1/KhrjUNB2uJ1fzqA+idXcnbSckx8R17V/Vb8l0XptNKD/SaRcXeXac3IswvhOLdnzHj/Dwi6HdMVrVd4yiCfI6nxe8o/5iXlKwcg6hj9vr6w4Gr9v8QXJ3e9o1vWMYU4Cq/6rqBuEH2cFNxPwhuUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HBwEoR2N; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759809839; x=1760069039;
	bh=hm33+6RvR1Xga3nPacnfP+2dz5bbV9St/6yjtM/0Gc8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HBwEoR2NGpGdWyWyZVp4cFbosfw/mqu+wzaP9S0y9xZnGTyvyM4hxgyJsgfhuU5kS
	 Ej0g38tUnHOwCX+WCPvhUCStIuJLDbriNAlSyAK1MrfJAPoTPAzsh0JBoi9x7an3rW
	 mjSSAkiUdTgldrObBIy0zfhaxxJlG55JIQL9BYcPAg0d39wU6P38jJbvdU4X58iMGZ
	 KNSNvoJCWDVlhwyUTSD+jg3Wq4it9mcl2sqWHbrr1SWGgxrqKDvcyXnBp2G400bCWf
	 W/eKMy25aAHE2yrTzoJbZ7ew36s5bdCmygobir3vtk4+a1IXCe82uu1IH3jMHxLoVn
	 EbLzCTkawJIBg==
Date: Tue, 07 Oct 2025 04:03:55 +0000
To: torvalds@linux-foundation.org
From: Steven Paul Jobs <ispjobs@proton.me>
Cc: Waiman.Long@hp.com, chris.mason@fusionio.com, cl@gentwo.org, ia@cloudflare.com, linux-kernel@vger.kernel.org, mingo@kernel.org, penberg@kernel.org, peterz@infradead.org, sim@hostway.ca, viro@zeniv.linux.org.uk
Subject: Re: Found it! (was Re: [3.10] Oopses in kmem_cache_allocate() via prepare_creds())
Message-ID: <DnE1A1Mf1HkvwdOL4Mdu_EDtCKOJhDljfQNaIL4RkJPctcc01bKxUtEFENMUkUWRCVUzHV3e1Q6WXf0iuHne82iabcITMF_vOB85OLNn760=@proton.me>
Feedback-ID: 138924760:user:proton
X-Pm-Message-ID: 1ba98a655a7b8c7f1fca75faf7df4ec294fb9e05
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------94d5f5a69004a1e8111523fd8a353514477de50f2f8e18bc37b8e8799995f924"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------94d5f5a69004a1e8111523fd8a353514477de50f2f8e18bc37b8e8799995f924
Content-Type: multipart/mixed;
	boundary="186c19b4d4d89119_c5808bffc8e51cfc_ef45c839a0c11c0c"


--186c19b4d4d89119_c5808bffc8e51cfc_ef45c839a0c11c0c
Content-Type: multipart/alternative;
	boundary="186c19b4d4d8d59c_63b805b9482f9911_ef45c839a0c11c0c"


--186c19b4d4d8d59c_63b805b9482f9911_ef45c839a0c11c0c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



Steve Jobs


Sent from Proton Mail for Android.

--186c19b4d4d8d59c_63b805b9482f9911_ef45c839a0c11c0c
Content-Type: multipart/related;
	boundary="186c19b4d4d90730_1ef7f72c77a1526_ef45c839a0c11c0c"


--186c19b4d4d90730_1ef7f72c77a1526_ef45c839a0c11c0c
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5Pjxicj48YnI+PGRpdiBjbGFzcz0icHJvdG9ubWFpbF9z
aWduYXR1cmVfYmxvY2stdXNlciI+U3RldmUgSm9iczwvZGl2Pjxicj48YnI+U2VudCBmcm9tIDxh
IHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL3Byb3Rvbi5tZS9tYWlsL2hvbWUiIHJlbD0i
bm9yZWZlcnJlciI+UHJvdG9uIE1haWw8L2E+IGZvciBBbmRyb2lkLjwvYm9keT48L2h0bWw+

--186c19b4d4d90730_1ef7f72c77a1526_ef45c839a0c11c0c--

--186c19b4d4d8d59c_63b805b9482f9911_ef45c839a0c11c0c--

--186c19b4d4d89119_c5808bffc8e51cfc_ef45c839a0c11c0c
Content-Type: application/pgp-keys;
	filename="publickey - ispjobs@proton.me - 0xC9807EAC.asc";
	name="publickey - ispjobs@proton.me - 0xC9807EAC.asc"
Content-Disposition: attachment;
	filename="publickey - ispjobs@proton.me - 0xC9807EAC.asc";
	name="publickey - ispjobs@proton.me - 0xC9807EAC.asc"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYU1wTlRCWUpLd1lCQkFI
YVJ3OEJBUWRBNk44dFIvaG5WR3phand5SzRleC9wNk1Ob3FhbXErL1NQRWkzClB2dCtnNEROSlds
emNHcHZZbk5BY0hKdmRHOXVMbTFsSUR4cGMzQnFiMkp6UUhCeWIzUnZiaTV0WlQ3Q3dCRUUKRXhZ
S0FJTUZnbWpLVFV3REN3a0hDUkFHaGdnMmp6NFp1a1VVQUFBQUFBQWNBQ0J6WVd4MFFHNXZkR0Yw
YVc5dQpjeTV2Y0dWdWNHZHdhbk11YjNKbk83NWdoSG5MV2U3Q2VTNjFkalRzelh5S1JWSCswb1Jk
S1NTeDlxWXp4Vm9ECkZRb0lCQllBQWdFQ0dRRUNtd01DSGdFV0lRVEpnSDZzWXhHSHk0eHVCRVlH
aGdnMmp6NFp1Z0FBZ0dnQkFLdlMKQWFTZmtSbnkzVFp5em1mVjM4WnRTOWh0SStkYnZmSkl4MGVq
UzBKL0FQd1AzRjdkRHF0Z204WFVzNE9UdjVQZQpkMUlBZE1Lanl2enE3TGJxUFFVSEE4NDRCR2pL
VFV3U0Npc0dBUVFCbDFVQkJRRUJCMENRY0NZWVR0TFAvMWN3CmwwOVB0K1BscWRuTURNd2xldFVr
TXA3MDVDeFlJUU1CQ0FmQ3ZnUVlGZ29BY0FXQ2FNcE5UQWtRQm9ZSU5vOCsKR2JwRkZBQUFBQUFB
SEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJuQm5jR3B6TG05eVo2OC95dVBsZzljdwo0MmxW
SXlnVUJ4ajhtMjZVNjl3clhnTGlNd1dnNHVWYUFwc01GaUVFeVlCK3JHTVJoOHVNYmdSR0JvWUlO
bzgrCkdib0FBSjdIQVA5UXhwSHdwUEZsY29rQVJCSTVIV3F0VnFHN2lrbE5BY2RReVl3Nld1TGdZ
QUVBeDc2YkhsQ1kKcTBMQ0FrbjJGTFljS0R1RXN0alJtMFlpWlpKaHpaUEJsUXc9Cj01SlBMCi0t
LS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0=

--186c19b4d4d89119_c5808bffc8e51cfc_ef45c839a0c11c0c--

--------94d5f5a69004a1e8111523fd8a353514477de50f2f8e18bc37b8e8799995f924
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjkkRsJEAaGCDaPPhm6RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcWXwEPEKeSfmZTDnEGO+Fc9Df7Uo5+FArPIu+B
9q+zExYhBMmAfqxjEYfLjG4ERgaGCDaPPhm6AABqxAD/ZTJZ+gD9UCJRDLsy
cdbJge8VSbXW/l7RTCN8+o2rrFgBAOM/QPcruzOuXGcYrKWhkZGX8aGJvyZp
8c0nHExfqG8G
=AEET
-----END PGP SIGNATURE-----


--------94d5f5a69004a1e8111523fd8a353514477de50f2f8e18bc37b8e8799995f924--


