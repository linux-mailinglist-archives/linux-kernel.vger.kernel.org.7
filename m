Return-Path: <linux-kernel+bounces-729024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB6B030A6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D490917ACC9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060B264627;
	Sun, 13 Jul 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RTiW8G9Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E654A00
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752402368; cv=none; b=C8OkIfoBBaHNo389PXABJhJkPvnaVcvvqA9CejpXAbbfT2eEIuKNb9i+ByqPu/7HRm5IJOnN1J7dq5V72RESAB0d0mAllTUCpfEnTNHPspcKQOuQ4CtvkO48s1eZJH0Ohc+bl6xLWY7dJeo+5VHFXCbRorJCWfc6hUvLlydGzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752402368; c=relaxed/simple;
	bh=OXy6AS2y9c96+85hMjbbYYJwWoTSVv8e1Xu6nbvkpLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cZgJ0YDM4FaF+NNoTI+lOwNrhl49Ls+l14TyC/OqD3g6Pmwvo73XkWGY9X1aVL9gLNmIYfx/UpOJgPA2zoacMNzkEbuQDIE1s0eLD3y4Nqt8X6Ig3EI2RyqNLiwIzfpix78tAEQOoMQKmC8/ODdMYuLC5c1aLqgJCKpAnfnl2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RTiW8G9Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2E9540E01FD;
	Sun, 13 Jul 2025 10:26:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2MTOUmwBh1ks; Sun, 13 Jul 2025 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752402361; bh=nA8XhBGbb5mkVQc6CcverNqDsDbRUVEf5kLBLQhmGVU=;
	h=Date:From:To:Cc:Subject:From;
	b=RTiW8G9ZHjXSdkgL7FZM5VQMQoZ8cfH347mU+FFvPoqYkywhxVxS02uBEm+4plB1P
	 ZkuEq+ZsZFkwC+fbuhuhcWOo89pEr7Yh3jo0gBsSVNdCsPCXD7m0BmazHXu/tLuan3
	 BCnKm+7+70Oi7Ly7wfhjeJCDBJrNaf4l/zDvvVMwh+26IJ+T3ZjLA7TpBa5O3gQEMr
	 DshxJu8Ds31ewFUkIk7I63GjPxIt9S9Ce2ckT8ap4oASkWLdG/mINijih9fETNKJ6A
	 0c4vwo4BHCFkgGuy5LpqydUYCTE3ibShMxUXLzMI+bzO76X5QxBCJEjGZ8F4rCSc6e
	 M6XCSsq8RplbYCLaez1m1lyCejP+JRtOA2JNoWILoJF+YAYL+k2ABWh3H0u7mvXUwr
	 6pkG6hjYWjq+S3uwzG1NikWQUqlCk5HN/9iffEhBBTvAJR+en6hNYYcCkBCqz3JM0Z
	 qy8tlHn5nva02rqyNxjCTdq5OS3G0TGLq7pO2hOtRjCdOIW3KYmwwv4TGdhb1NATX0
	 ljopRc66Q0EXMsTw88fmNGpXa62aqQj4N1KWxLt8KUZy8ytdOoO/19Zq4ocRktZloU
	 /2x+Zy1Ru+K22sxTMwvffK1EwL4ZGn05JrFAMHgl6ErNtdK75ghPPEsN0pyYIAcGGR
	 1xpYSPWmc4XAIima9bpzFWlY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EED940E019D;
	Sun, 13 Jul 2025 10:25:58 +0000 (UTC)
Date: Sun, 13 Jul 2025 12:25:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.16-rc6
Message-ID: <20250713102551.GAaHOJr6ue89FBosE1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.16-rc6.

Thx.

---

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.16_rc6

for you to fetch changes up to cb73e53f7c0700285d743e7afbe37cba9f7df8f3:

  MAINTAINERS: Update Kirill Shutemov's email address for TDX (2025-07-11 07:25:51 -0700)

----------------------------------------------------------------
- Update Kirill's email address

- Allow hugetlb PMD sharing only on 64-bit as it doesn't make a whole lotta
  sense on 32-bit

- Add fixes for a misconfigured AMD Zen2 client which wasn't even supposed to
  run Linux

----------------------------------------------------------------
Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Kirill A. Shutemov (1):
      MAINTAINERS: Update Kirill Shutemov's email address for TDX

Mikhail Paulyshka (2):
      x86/rdrand: Disable RDSEED on AMD Cyan Skillfish
      x86/CPU/AMD: Disable INVLPGB on Zen2

 .mailmap                               |  1 +
 MAINTAINERS                            |  2 +-
 arch/x86/Kconfig                       |  2 +-
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/amd.c              | 10 ++++++++++
 tools/arch/x86/include/asm/msr-index.h |  1 +
 6 files changed, 15 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

