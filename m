Return-Path: <linux-kernel+bounces-750512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53DB15D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7795C188B19B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33917277804;
	Wed, 30 Jul 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="dOYfO7V6"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514911F5834
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868981; cv=none; b=HQG0E7m4dMpp3bYWoWNPOHbhJQlC6eqG6RfKBSRtKarFXvziibC1TyySpmZiBZw/RoWJhsqBRhNqHzc835rM5vs4S/I24/Talgzqo32f3Ib/+NcCS/MJrUGALIWSM6Ityowq2NTAHiQkgu+ZXTPfb29CRdXwkWgzi5opGPXs4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868981; c=relaxed/simple;
	bh=ULSog3kf+bL89KMT6vB8XVysrRKIR0SeaCEF3WPDjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJd67Y5My6g/IXwXOoq+dCZX7Hf1YKRGdvzvPbkScm41RhfWQJFP6cr5XJ7yIIwIXsEIgK7CMiyThCfDb/oAafi6AIWmomvkLV+iN5XJ2tG4olAf83iio9FkdciXdCMppNkpfc4/83W5UA1mT1MHv2SA9oP/SLpqUtcxlvm+p0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=dOYfO7V6; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 435F31C008E; Wed, 30 Jul 2025 11:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753868976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbgfSAKg2C6APSx5l0p1+ObE37mdrJbXnh0D/kcfFvI=;
	b=dOYfO7V6l4vIT0ogyD5m7DmLzKTnCwEmy2qF9EB1W4U2toUh4dBHseMcIaPWB2RuXBeVjT
	kgUW5deDwgEv+n4qNA2auwlCv1K9nJPJUei4AISraNRBt4IPk0eYHf1M3ZMDCbhQSNbcvo
	5bTbNC7ilLo6LEuefpvk3FLD2wJTq7U=
Date: Wed, 30 Jul 2025 11:49:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <norbert@preining.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lenovo P1 suspend to ram regression
Message-ID: <aInqr7C08F+Ex0II@duo.ucw.cz>
References: <aGFvYQFhGi_ytgDB@fettsack>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KQM6ti/BwZko7uVe"
Content-Disposition: inline
In-Reply-To: <aGFvYQFhGi_ytgDB@fettsack>


--KQM6ti/BwZko7uVe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> (please Cc, thanks)
>=20
> since some time, probably some kernel revisions, my Lenovo P1 Gen6
> goes to sleep (suspend to ram), but produces considerable heat even
> in sleep mode. Not surprising, it also drops battery level within
> short time.
>=20
> I am not sure where to report this bug, as well as which information I
> can provide.=20
>=20
> Kernel is 6.15.4-zen2-1-zen on Arch Linux
>=20
> >From the dmesg:
>=20
> [    0.000000] DMI: LENOVO 21FV002EUS/21FV002EUS, BIOS N3ZET48W (1.35 ) 0=
2/25/2025
>=20
> The supported sleep state seems to only be s2sleep:

You may want to Cc Rafael and regression tracker.

And no, this is not easy to debug. Start is to determine good and bad
kernel versions.

Best regards,
								Pavel

> =E2=9D=AF cat /sys/power/mem_sleep
> [s2idle]
>=20
>=20
> Around suspend:
> [47798.668789] PM: suspend entry (s2idle)
> [47798.795045] Filesystems sync: 0.126 seconds
> [47798.931393] Freezing user space processes
> [47798.933739] Freezing user space processes completed (elapsed 0.002 sec=
onds)
> [47798.933743] OOM killer disabled.
> [47798.933744] Freezing remaining freezable tasks
> [47798.935141] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [47798.935143] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [47798.953325] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
> [47798.953498] CoreFreq: Suspend(0:1:19)
> [47799.413769] ACPI: EC: interrupt blocked
> [47805.654440] thinkpad_acpi: undocked from hotplug port replicator
> [47807.218125] NVRM: rm_power_source_change_event: rm_power_source_change=
_event: Failed to handle Power Source change event, status=3D0x11
> [67168.670527] ACPI: EC: interrupt unblocked
> [67169.622762] spd5118 10-0050: PM: dpm_run_callback(): spd5118_resume [s=
pd5118] returns -6
> [67169.622773] spd5118 10-0050: PM: failed to resume async: error -6
> [67169.622816] spd5118 10-0052: PM: dpm_run_callback(): spd5118_resume [s=
pd5118] returns -6
> [67169.622828] spd5118 10-0052: PM: failed to resume async: error -6
> [67169.635622] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_7=
0.bin version 70.44.1
> [67169.635628] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bi=
n version 7.9.3
> [67169.644108] nvme nvme0: 20/0/0 default/read/poll queues
> [67169.650551] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all w=
orkloads
> [67169.651715] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
> [67169.651717] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
> [67169.652243] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
> [67169.654296] CoreFreq: SoC_SKL_VTD: request_mem_region 0xfed90000
>=20
>=20
> What other information can I provide to debug this issue.
>=20
> Thanks for any pointer, and please Cc.
>=20
> Norbert
>=20
> --
> DI Dr Norbert Preining                        https://www.preining.info
> arXiv / Cornell University   +   IFMGA Guide   +   TU Wien  +  TeX Live
> GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--KQM6ti/BwZko7uVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaInqrwAKCRAw5/Bqldv6
8uT9AKCqvz6p5LS83ofL7gg8wZwAUTzfkQCgj7/evPemY/evF/mU0lSQgGsbhnQ=
=rPpU
-----END PGP SIGNATURE-----

--KQM6ti/BwZko7uVe--

