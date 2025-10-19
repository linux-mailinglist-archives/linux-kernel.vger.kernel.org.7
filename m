Return-Path: <linux-kernel+bounces-859665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5543BEE3B4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63CA834A127
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A82E3397;
	Sun, 19 Oct 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QuZQ4WTz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D411C3BFC
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760873266; cv=none; b=d+dDY320hpvLxq5eUCt67YSoi8ZJnRI5O9XU4MlxuhDQJ9wimZMr4YBzh4TSqCwCL2ugu+1rYyc4jTnAaS8OAJigveuycScrmRwBvi8nSAWYV8+1/eQAaUfXk6PuK5y4+RxvmpRUjmFg6MA+noo0pCONj1yHHgF0TXEHMCx/AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760873266; c=relaxed/simple;
	bh=9yhaLBB6+ztF7llHrGWr51Io6UtiQzEpvTy9wJtAtPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mMOpthevbeXp6YodHIhP9Km0XL9gtqNKCLgQAccK9L2iR6+56bLntrB2x18/2AQo/aJ37gMqScwc4RU5x2ZIMFXdWZkt2SlRG3nJl8CuE4QTRfara4DAH34m5pfKaejrE6QCdDAUU2RWqMqHKCnX2Bc6wZyusvCXUc4EeYMFCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QuZQ4WTz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1B0140E016E;
	Sun, 19 Oct 2025 11:27:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FVeFcqyNJKdQ; Sun, 19 Oct 2025 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760873257; bh=W2geO58V0Y56wZEMlMAq0iTV2sWTWRGnj6mK1B4us/Q=;
	h=Date:From:To:Cc:Subject:From;
	b=QuZQ4WTz5N/UKQDRYOimanqHlnBZE9st3VMcEctFzNB4S05T2SnTJNsyHtltWRybV
	 hgUWFfpKLB/Z8tc7/Da5GHGFCFXxqyc2DgqNjdAXwj0/ZITGaTAjxgTWo4ZOgWX+2Z
	 tHyLH1r6m63kFInjaL9gFS2yatobOPgkwxyUyGPAHcuNqztGJ9iFtfjoL9nTLsycPJ
	 u7pB2GiofeUK8So7VFGbjiUkJA3eI/fpSWAVAloYg/FjfsKp0wxoAXXluXC+OBkWUd
	 qbDeJDwVLV+N5KT+fLl0/0Kwv6PW5NGOctQoA+W3NoKZK1Xh6fm++Pq/cTum8lMHMp
	 a366Fd7gQX9huUqUFxt1Qd/taI9Sz6D8BxP+3J2IQGLgJx1K91ghxuaZG2ptTPplX/
	 55QbzicFA8OmbaWWZpvaZOsqWZwaHWNr4d2G9BjNe6Fd/L3JgTeK9th1SCd9bCin4w
	 iH3J2WJtYWvEHjz2d+H2M9p6B2LOb670BK4n8T+wmWFUCyc87OSXErSK7mtdbWoBsO
	 TwKSycEYd/1U9p+Yn3KgCAM8jZEvrolwBiXuZLhCOmo/ogctynwhamSzcf3C6OHAn9
	 5Kfdwu9vz8XHp3keBfEjxhG8mACJjj9MbYJX1wBX1UpDtL6XKOatMKOIV+Rc35zWAI
	 4PkPwQ2yjSBcEkmI/GZ7YiIg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2303C40E016D;
	Sun, 19 Oct 2025 11:27:34 +0000 (UTC)
Date: Sun, 19 Oct 2025 13:27:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.18-rc2
Message-ID: <20251019112726.GAaPTLHvdbKaUyBbMr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the sched/urgent lineup for v6.18-rc2.

Thx.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc2

for you to fetch changes up to 17e3e88ed0b6318fde0d1c14df1a804711cab1b5:

  sched/fair: Fix pelt lost idle time detection (2025-10-14 13:43:08 +0200)

----------------------------------------------------------------
- Make sure the check for lost pelt idle time is done unconditionally to
  have correct lost idle time accounting

- Stop the deadline server task before a CPU goes offline

----------------------------------------------------------------
Peter Zijlstra (Intel) (1):
      sched/deadline: Stop dl_server before CPU goes offline

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

 kernel/sched/core.c     |  2 ++
 kernel/sched/deadline.c |  3 +++
 kernel/sched/fair.c     | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 13 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

