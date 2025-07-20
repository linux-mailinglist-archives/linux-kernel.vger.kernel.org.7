Return-Path: <linux-kernel+bounces-738203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE945B0B5BE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BF217A5CC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABF1F4E59;
	Sun, 20 Jul 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B3rDj/h4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5PvHHP0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4217741
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013102; cv=none; b=jAEVj8RA3zz9USkuTBoTAzGRPBBEkPg46qpC1U9FABXXGUWAC3juNo7hxvREdc+xC7mIorcBX+YOyzIM5zBbP9zQ6GKEbSREzFp8TMsk1YoJebZfsbHRx3ajDZNNqDT4MrSuRk8MJsE0TUcHVQE2RGBa8vM3+3NvN/u4g7ld5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013102; c=relaxed/simple;
	bh=UOA4YQ2UKL/6uW0EE0Bf1uT5EWK8i7p0dNgPVxBF93c=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=an7pGfQv2Bxyr8oRbTVbSUsuutPkLLiyjhg6qQt65H8kRwVJiLJX+QJsNJ4SS6s2WFqBh0U1xjnxlF0kOTNFMaEzYeLNclzsnAdEtIXsb9I0vF9PlbVLsQtGMbUDpSl2nAHM+QuTIT+ZofM5+nsfepH37PD9xO5FVO1VTmnq58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B3rDj/h4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5PvHHP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753013098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEDyxPelAk7fVyMNpb0xkJpxxIcfXyVPpCD/Og+cpWQ=;
	b=B3rDj/h44XMMBFW69/fXPBe2vmZvnSWCpn92erwIKJWhDDPeGSOfEaggPEQbz12YX01JVp
	ij06+yBiL78s4QhbINI+c9ZwOWWyyNI/PvVtNsPrYIQJK+qEs4YbJhgY65VrncmbeqX62c
	T1rOvqP9K2ImG2pehmVEAwGV7Xjycape4o+tl/TLtgDVHXue9oTrMeYcncwWPeZf61GJaJ
	QRl5sdXA8W4lwjdCeAX6HmjoFc6EvagknrAiBap/oFYJoyAmCXFLJQPpQucn9s9gDMrzb/
	axQ8zVgtms69JRHDwDy5m4AkWteP5Fwm/Dopc+6VXkd79Ov+SuqXX7xyfIMHYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753013098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEDyxPelAk7fVyMNpb0xkJpxxIcfXyVPpCD/Og+cpWQ=;
	b=s5PvHHP0M4vdqdZXkLEEJEseBnLmqjvtBFezggAqlIfMykOC0hFy3qvA4KqhDFP82H1u8b
	LNlzws5jKMKCDYBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v6.16-rc7
Message-ID: <175301303546.263023.1426155806374119244.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Jul 2025 14:04:57 +0200 (CEST)

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
025-07-20

up to:  d0a48dc4df5c: selftests/futex: Convert 32-bit timespec to 64-bit vers=
ion for 32-bit compatibility mode

A single fix for the futex selftest code to make 32-bit user space work
correctly on 64-bit kernels. sys_futex_wait() expects a struct
__kernel_timespec for the timeout, but the selftest uses struct timespec,
which is the original 32-bit non 2038 compliant variant. Fix it up by
converting the callsite supplied timespec to a __kernel_timespec and hand
that into the syscall.

Thanks,

	tglx

------------------>
Terry Tritton (1):
      selftests/futex: Convert 32-bit timespec to 64-bit version for 32-bit c=
ompatibility mode


 tools/testing/selftests/futex/include/futex2test.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testi=
ng/selftests/futex/include/futex2test.h
index ea79662405bc..1f625b39948a 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -4,6 +4,7 @@
  *
  * Copyright 2021 Collabora Ltd.
  */
+#include <linux/time_types.h>
 #include <stdint.h>
=20
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
@@ -65,7 +66,12 @@ struct futex32_numa {
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned=
 long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+		struct __kernel_timespec ts =3D {
+			.tv_sec =3D timo->tv_sec,
+			.tv_nsec =3D timo->tv_nsec,
+		};
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
 }
=20
 /*


