Return-Path: <linux-kernel+bounces-741307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD83B0E2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F563563653
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74DE27A446;
	Tue, 22 Jul 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="oebFX3ik"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FB268683
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205729; cv=none; b=i5hTTfmi6Jn68DJatftReX1JxKN/1aJjTN7ZjeB3BNGMcb91VHxic6Wb8qiB8wPcPVoJxf8ZpyMcwUDtfacRtrYfUZZVkxcvAGHI1rtauxf4iCNSp2+XGDknN+dwhsK8R5bHegeccFmcsjXlVuYgYTC2j6QsvHJtGkrGccKFUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205729; c=relaxed/simple;
	bh=egFOTGkOyDcV4J5NREJqL9Yw/K+BYd8iLqwvY4ED5O0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EePPQR1l4j+2TCnjvLXU0sHSUoFuhGchGVR8YM4PowEh9Qq6yacY1PaY3xaXouz/iBeyIWIO2DGUIU2PDXg31JW5jWSh7zG+fj/K4z/PS3/RPMPza/Lew5k+2HZxfgL7ZvdxCUSMYYjWj6LV53q87JazovWLXib8jtwBPl62BDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=oebFX3ik; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B6DC1C00C1; Tue, 22 Jul 2025 19:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753205717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=OfW7Jg0YMs+6IaSe1tQS8HPxTR9c5LDgzG/4nEotd2Y=;
	b=oebFX3ik8yrXaasDYIuDEynRjzbuFRHdRzKFV+NPapqSLjTw1Micawb9NGWuRAZSyC5+IN
	mwMZmOUpdA8Yp2qnCONb0u20ajTs2j7ce0MRJvEcRKeHNAosLeOyXTGDVF99pBBOwj7iQc
	zJGqWZ7wZJQZ80FEmC6ISVQmo5ZXw4Y=
Date: Tue, 22 Jul 2025 19:35:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: 6.16-rcX: crashing way too often on thinkpad X220
Message-ID: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F26XiQ8NZZXpyrH/"
Content-Disposition: inline


--F26XiQ8NZZXpyrH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have had 4th or so crash with 6.16. That's not usual.

This time capslock was blinking, indicating panic. Two crashes were
like that, two were just lockups.

This time I checked logs, and nothing unusual (besides this, but..)

Jul 22 09:05:20 duo pipewire[3473]: Failed to receive portal pid: org.freed=
esktop.DBus.Error.NameHasNoOwner: Could not get PID of nam>
Jul 22 19:08:57 duo pulseaudio[3474]: ALSA woke us up to write new data to =
the device, but there was actually nothing to write.
Jul 22 19:08:57 duo pulseaudio[3474]: Most likely this is a bug in the ALSA=
 driver 'snd_hda_intel'. Please report this issue to the A>
Jul 22 19:08:57 duo pulseaudio[3474]: We were woken up with POLLOUT
set -- however a subsequent snd_pcm_avail() returned 0 or another>

Digging through older logs, I get:

Jul 06 15:22:20 duo kernel: iwlwifi 0000:03:00.0: can't disable ASPM; OS do=
esn't have ASPM control
Jul 06 15:22:20 duo kernel: iwlwifi 0000:03:00.0: pci_enable_msi failed - -=
38
Jul 06 15:22:20 duo kernel: ACPI: \: failed to evaluate _DSM 2c176672-0b22-=
294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
Jul 06 15:22:20 duo kernel: ACPI: \: failed to evaluate _DSM 2c176672-0b22-=
294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
Jul 06 15:22:20 duo kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'perform=
ance'
Jul 06 15:22:20 duo kernel: platform regulatory.0: Direct firmware load for=
 regulatory.db failed with error -2
Jul 06 15:22:20 duo kernel: Bluetooth: hci0: BCM: firmware Patch file not f=
ound, tried:
Jul 06 15:22:20 duo kernel: Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e=
6.hcd'
Jul 06 15:22:20 duo kernel: Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'

=2E..

Jul 08 08:21:32 duo kernel: Bluetooth: hci0: BCM: firmware Patch file not f=
ound, tried:
Jul 08 08:21:32 duo kernel: Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e=
6.hcd'
Jul 08 08:21:32 duo kernel: Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: Microcode SW error detect=
ed.  Restarting 0x2000000.
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: Loaded firmware version: =
18.168.6.1 6000g2a-6.ucode
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: Status: 0x0000044C, count=
: 6
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00001030 | ADVANCED_SYS=
ASSERT         =20
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x0000C064 | uPc
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink1
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink2
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x0000D6BE | interruptlin=
k1
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | interruptlin=
k2
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x003B00F7 | data1
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | data2
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00000800 | line
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0xED408AD8 | beacon time
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x40AC6528 | tsf low
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x0000000E | tsf hi
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00000578 | time gp1
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x190D1D6C | time gp2
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | time gp3
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x754312A8 | uCode version
Jul 08 09:40:07 duo kernel: iwlwifi 0000:03:00.0: 0x000000B0 | hw version

=2E..

Jul 08 12:23:29 duo kernel: usb 1-1-port2: unable to enumerate USB device
Jul 08 12:50:42 duo kernel: mmc0: tried to HW reset card, got error -123
Jul 08 13:44:20 duo kernel: usb 1-1.2: device descriptor read/64, error -71
Jul 08 13:44:20 duo kernel: usb 1-1.2: device descriptor read/64, error -71
Jul 08 13:44:57 duo kernel: usb 1-1.2: device descriptor read/64, error -71

But I doubt any of that is related.

Any ideas? Does anyone see similar crashes?

Best regards,
									Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--F26XiQ8NZZXpyrH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaH/L1AAKCRAw5/Bqldv6
8qZWAJ9+XkxTCikOOb6QGVjBPEAsr+FYvACeIXk0V7yMxJdTP1x8id76aK1BU/4=
=FQ2n
-----END PGP SIGNATURE-----

--F26XiQ8NZZXpyrH/--

