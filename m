Return-Path: <linux-kernel+bounces-738205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E85B0B5C0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF37AA614
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC9A21128D;
	Sun, 20 Jul 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrAKPM3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zaIj8RHN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E820A5D6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013105; cv=none; b=gi2A9v1hAvT81bJhjwbJI96A0lhvHQ4UKlxdXXAsChOiJ8x6HUW/Csw52GPKLA1LL/PFzj23aoSqhbb/Pki/5d68FhMwBaeLvq/KCmt21SK7kHN/pgWkugFcE5N5b5YBUh0tJklFmOOM9acTUGM+m/q0EHKwi11LYpDPYV7uAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013105; c=relaxed/simple;
	bh=wmuIAth/fohvD7VMd5Ay9gtiq0O27z+QDex4yENdaog=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=U2RX7m7e9EUxFh9JBmEuQzlWqZi4QGCxlYa22xLT7W0gX9M/4Y2r39eMPZbSCXedhG7xJZQXH9IEI5V3UlKOEKX+tufw6NRo4FguiIiRxLwSc9LTuuBH/eyUdp0ZRTyMbBjc7NiWrOzRJWLuHwbT0v82XzAwkxGGY+N9nCYUPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrAKPM3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zaIj8RHN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753013102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=svE2gPo034u/ldSgjAdSyRa6ihIHN2+zoj7zQ1EAqjA=;
	b=ZrAKPM3wCZKArRgApqsI4677xhUiSfUSqm3+5ic2e9n3PPkEenMCMFZXzFBBrD5sdn90oz
	9zrWNcFlP9q3jPP9NCbN4raYt+Tc40yp1t58Xh0vwGBhM0n8jjZRcec+JcEFen8MpfA5EI
	BATZ7X76xTVX6MEeNmmbKd4MLW7S3X3fwJnARw/FtkbHdoX14cEs5ff+EzukbHezijiUxV
	M+3aMr+flSpHnjFElRq2aidk8t3siKBXyVNgIJOcf3dSiEdjk42lFz1aUvkIWcdRaqns2T
	j937g+D4tXtaZ+xztKD3eoHc2K53mO0VE+YEVSLr/N3rZDa9/iaXPLxu2mUABQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753013102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=svE2gPo034u/ldSgjAdSyRa6ihIHN2+zoj7zQ1EAqjA=;
	b=zaIj8RHNUvmtMjwrP2HXIpDuHzpRCXb6Yvm4AnOor8JznSg60tZxZWNqUcbHnf06vM9Yli
	EYdlumpnXM3iiDCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.16-rc7
References: <175301303546.263023.1426155806374119244.tglx@xen13>
Message-ID: <175301303889.263023.7762556142250207604.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Jul 2025 14:05:01 +0200 (CEST)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-=
07-20

up to:  6b995d01683f: x86/sev: Work around broken noinstr on GCC

A single fix for a GCC wreckage, which emits a KCSAN instrumentation call
in __sev_es_nmi_complete() despite the function being annotated with
'noinstr'. As all functions in that source file are noinstr, exclude the
whole file from KCSAN in the Makefile to cure it.

Thanks,

	tglx

------------------>
Ard Biesheuvel (1):
      x86/sev: Work around broken noinstr on GCC


 arch/x86/coco/sev/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index db3255b979bd..342d79f0ab6a 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -5,5 +5,6 @@ obj-y +=3D core.o sev-nmi.o vc-handle.o
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlini=
ng
 UBSAN_SANITIZE_sev-nmi.o	:=3D n
=20
-# GCC may fail to respect __no_sanitize_address when inlining
+# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
 KASAN_SANITIZE_sev-nmi.o	:=3D n
+KCSAN_SANITIZE_sev-nmi.o	:=3D n


