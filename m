Return-Path: <linux-kernel+bounces-870302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE6C0A6BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCDC3AEB02
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E841B21BF;
	Sun, 26 Oct 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DlMjKYU7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272313FEE
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761478559; cv=none; b=lfPKh+zz/Zg3ctfmVqZK+L+hCW+H2S8AcyB+twcFj8Xd/jAeNVXlRY+gvYFvibPRkkuXEZj2HL71apdDCTuzvSBecJfad4NdjsAoXTArF2xr2L/kCUBv8/LCaaQgI9FOp1/f2GGal4M9ZNuvAh6sBxhnleZ2NhyXJIjMDRMiiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761478559; c=relaxed/simple;
	bh=UxhS6urnvIXKP6Cxjo/I/5ot9bfrkwFb+4Hll2ex5PU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BPk/FRxp1oi9Zd6jBp8BmeXTPyoGBuam4gfOgyxXXo64Di7g9E0h+dRVN88tmW+Cnico1Sx98JqFvRSqhjYdpjdqeN5rJ4sd855u3luatLx07cAnSs/g25mnYbWvs1/NH4d2V5ntM8o04suZ6RthunSJ3gjZMLL1wHZfwTMY2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DlMjKYU7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48E8440E01AB;
	Sun, 26 Oct 2025 11:35:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lDOJRbbvRBtl; Sun, 26 Oct 2025 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761478543; bh=3bG8529YX6WpUImO6K3iKgS/DeaL5dfIG41cPwxMepk=;
	h=Date:From:To:Cc:Subject:From;
	b=DlMjKYU7c+EQYckDPRQV1TpAC6qTVxqF5ih8d9XybRWdR0hE1Q2azANZ4OjmrzM6V
	 uQ+2Ic1P4mtRle8YPeQlWrn0DCvm/l6ppb770wV2e/52Wj+QgyhOeHybwm+0rwfr99
	 ajDX6liyDfNcbepIdd7xXyCnZgIwcGs9Z/PxPNwp7tv7WQtboR1LbDn6e0p6A1rcap
	 5GVIGS7S2w0vXZ+zjFJ8MAUxhCYcVIJcCA9PHsJZmlF+VJ3UeFMWvEBP9qjkYewI5T
	 7hf1ryEzVyKu0l9u0GmFQKEzKJmbbQbIdtFkfI5KRvtvDm5nax2qoOF7schXuab+X1
	 YnZaNGr9lJd+Nx96ekgkLiqJwBDCqIAWtz8D/RzUk6T14nLu/C6EUII1NbYu7XgR+e
	 9nP84MWwnBLrreR8lanLD9rrO29IrRotR2rCXeCHJdCOfqGH+CSPBVCqPMATlxemyp
	 R+X6GqwwquRu+vYEaJqF1RtzxzfI7MnYSsoEkrefp3cErqZ/uzUh4h8D2GLv4kYRx0
	 b9QaZVEOWIe5kqwWofryn46mKSLrNS0TKfCDY+TAqHQNJwU5NhwBM8Wv+LHqyixxhZ
	 g4qSjzuPAMHpUfB+KaBzYDSKjGdJKFDeVvDRhRKmFd3W1VyBSqwdk40Tx8bKnbrOhZ
	 Q3oTioDvs2g0dQuV5axBOjdc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C049140E019F;
	Sun, 26 Oct 2025 11:35:40 +0000 (UTC)
Date: Sun, 26 Oct 2025 12:35:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.18-rc3
Message-ID: <20251026113532.GAaP4HhADWuKp1XI16@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a timers/urgent fix for v6.18-rc3.

Thx.

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.18_rc3

for you to fetch changes up to 39a9ed0fb6dac58547afdf9b6cb032d326a3698f:

  timekeeping: Fix aux clocks sysfs initialization loop bound (2025-10-20 19:56:12 +0200)

----------------------------------------------------------------
- Do not create more than eight (max supported) AUX clocks sysfs hierarchies

----------------------------------------------------------------
Haofeng Li (1):
      timekeeping: Fix aux clocks sysfs initialization loop bound

 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

