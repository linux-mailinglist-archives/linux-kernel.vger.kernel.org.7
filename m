Return-Path: <linux-kernel+bounces-783551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A59B32EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93751B637CD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF42367DF;
	Sun, 24 Aug 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UEoozia2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35D38DD8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029753; cv=none; b=itJbLTc7qq9yTNUQ8v0j28V6zQ8xZ1r/rNU4tche9Lvu6pgSdLvT6OumZ0EbCAcMcmzWH7Kpv4Y6cwTR4WNyXzCus8gczL4h/tWMaRWYk3ruWmwC/HDnSsmJ9lQHjXS5g76HljsbVMpEmq2ZbuwJXT/rwX6fjoRhX3io5F3BSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029753; c=relaxed/simple;
	bh=2dcmlvELu4rw4MZISnvIq+cRxY5IGO6Gvsi7jo5G9Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B3OdA0VJPgMFbPbfAxpzWmoRYAdXeZOLGnx98ff+QO8Cc1v3Qrbs04Guee68c0F1aIXARAAwo+eMV/zN7Rm+jRzzTGjffQ0frIJs/ihwMrrKqX/rlqqcOFe5tZBeHlQKUYpCrt70x7RcKMITaicBbJFj1mcXJgjH7aeJ+OJIm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UEoozia2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 820F240E01A1;
	Sun, 24 Aug 2025 10:02:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S9g2mNWSsoGa; Sun, 24 Aug 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756029729; bh=OfE84+rboBPcQ/xSTYsXBDBTV/3kO+8pH+45f19+eAs=;
	h=Date:From:To:Cc:Subject:From;
	b=UEoozia2WjvpqwGRVJtWnsgTyr3MHOBz+nc9iCdDkFGTFzioQpS4EQcbehDxwf9qC
	 jIXWUetx7tObGe+YoO6BDqDsM0mcm5vla+4ImMmd44mB+g2ihVczCq79axPdSuROsp
	 eQxYixnRsuMn7Vg8lzzaNuxSBB1JBZROMxvmGbj0ILbJ55tc2yzv8fXqva5ydMo2T2
	 pZi3UeAbk6X5s3SIqsf8GLtVbzHbZmWJZ5wh7XfuA4bd4irPQG9HtlT4LgNBbl8cyr
	 T/7RthtpoS66uZFxxgzwt61ez5pi7a9z37oDdPnclPwRafcC2bL7rstztaX9UF6LxU
	 M4vrqh/cxZDmVhXgJekESf3OTg1HkeFpT3AIKKbO5NIKf+M3bPnF0HcsC6zCBIFowo
	 9ZpM/h/ZwNJdtiaN7y8QMn7NHhWX56l8mZ1+5XBKWmgQkbZP1A/TZjwvfpuLeZ01Sb
	 ehERy0LMsYHJxrYUQClrkBTbXbRM/IZtdoYjZc5f60b039Fq1yo7hfQ2ZaFHxBaQW9
	 57Zexew7fTAyz8oeVxkx5ATLvQIzd4MY8qAAZtNCbmicYfDB9CTyKr6nzyOOz7s3uz
	 EwgtTi4eFBsEPMpWquQJ3ePHIUX5Bva3SJEIwVUkNO+/Qysor6SDdp+tVWESM5DmjK
	 4kaDcF6bMUzZgHk8S9Fsjywk=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84BBE40E019D;
	Sun, 24 Aug 2025 10:02:06 +0000 (UTC)
Date: Sun, 24 Aug 2025 12:01:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.17-rc3
Message-ID: <20250824100158.GAaKrjFoDe38nh-ZWl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a perf/urgent fix for v6.17-rc3.

Thx.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.17_rc3

for you to fetch changes up to b64fdd422a85025b5e91ead794db9d3ef970e369:

  perf: Avoid undefined behavior from stopping/starting inactive events (2025-08-15 13:12:56 +0200)

----------------------------------------------------------------
- Fix a case where the events throttling logic operates on inactive events

----------------------------------------------------------------
Yunseong Kim (1):
      perf: Avoid undefined behavior from stopping/starting inactive events

 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

