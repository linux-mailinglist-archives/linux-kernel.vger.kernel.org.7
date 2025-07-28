Return-Path: <linux-kernel+bounces-748444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568EB14167
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFEE18C0517
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D83273D8C;
	Mon, 28 Jul 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="at4j5/jp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55021C9EA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725054; cv=none; b=NTSPx6s7g8ohJndZlbVixEMc9wwxk+7wfGLz7uFiArcScXC1LJAK0wAxq/58TrCWAIms64O9fVEHtfNO6TF4V8t35aNypCcNbn6FR8PApNzi4pk5vvmnpdVcX2MYf6GxXwqQ4/SA2HtTOi3C45vNErM4JIf6iVP0K7I8B4ViPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725054; c=relaxed/simple;
	bh=sg/0XBFo+UsTvzYsQHQs1/AiXKiYrbdoZpE+bRMvgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a4ctu7rjfXj+YqgdrhiksyIgvmWAMwQgyscAqFb9R4CuubsFgUMiV1zlwB8dhdfUs3hf6rd2bQhRb1bj5z6Mg+/T/d6To11ymJF5I2j8S1euJBxmjbHQc8IyOw6w05w1cgOjqEc++Q5NdwAirMXY8bh17QGLWRwIptFmLnmGIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=at4j5/jp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A37C40E0256;
	Mon, 28 Jul 2025 17:50:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FmmVDvhxLdIE; Mon, 28 Jul 2025 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753725035; bh=HK+EOgpTW+nwgA8tE7jMrn9ZgTVBuG6a4qhs3XQi+2o=;
	h=Date:From:To:Cc:Subject:From;
	b=at4j5/jpUulzf8zgaQnfHhHoj9bO4RfxjBJjTd34NxBfe/V7UjKMDmit5Bh/RuB70
	 3RKf09S5zyF24coVLc+talsW/XExKu0CmQB1oiYQUuiXVX3P/3gh7jW5mYAQRllBpG
	 8uyaVCvBneJjIobHs6/EeomG0Ce4sfcKlCKiNGZubW0C13kQTkgbcmGx/lExvSFOKr
	 W787w5tEzs2WDmIxC3oUXVK7kPKJdntpVzzxqfLGTgVqLDEGSZXluG7V0XvYI7ONNn
	 FD3F0te5ind5fZMeruNB9N2zIlBMlc8LeEkN/gppWNEHkbly1hwXdevWoGnJDQtopu
	 S1ndQS9Z+qErBiE4ANyf8ZjD4ed3S/6Zyu9PHyjmIl4xsIfalUi8QPKnbT7X4fWclO
	 dl/YXlB/zkxJ1gL0QEl/bgvmTYDQkjgXrfJBWjeaqxyFceO8pgleSs/8i6v8RtueZE
	 fuRyDqhP0ZPuZkSyLN9bMYtLZz6bSTngX4DWxCZER6QIKWBq+793eKdQ/WEhYOLtTl
	 qo4eMinuX5U6uumtbuuqeYG3YpKMdSaNNfpKVOY6xQBLa+timj5NZJODH87m94AB8M
	 EfLQND8+FVLRVvpNqiK1MmXE6VtVHkYw1iHGQ/a08YeQ22Usws648+y3wFLkTl2saQ
	 WCPWWGpx8Hc7vOeg/5tc2jUA=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3A2E40E0255;
	Mon, 28 Jul 2025 17:50:32 +0000 (UTC)
Date: Mon, 28 Jul 2025 19:50:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v6.17-rc1
Message-ID: <20250728175024.GAaIe4YLM-e-HL3BvH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/core lineup for v6.17-rc1.

Thx.

---

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.17_rc1

for you to fetch changes up to 4fdc3431e03b9c11803f399f91837fca487029a1:

  x86/lib: Add WBINVD and WBNOINVD helpers to target multiple CPUs (2025-07-10 13:30:17 +0200)

----------------------------------------------------------------
- Add helpers for WB{NO,}INVD with the purpose of using them in KVM and thus
  diminish the number of invalidations needed. With preceding cleanups, as
  always

----------------------------------------------------------------
Kevin Loughlin (1):
      x86/lib: Add WBNOINVD helper functions

Sean Christopherson (2):
      drm/gpu: Remove dead checks on wbinvd_on_all_cpus()'s return value
      x86/lib: Drop the unused return value from wbinvd_on_all_cpus()

Zheyun Shen (1):
      x86/lib: Add WBINVD and WBNOINVD helpers to target multiple CPUs

 arch/x86/include/asm/smp.h           | 23 ++++++++++++++++++++---
 arch/x86/include/asm/special_insns.h | 29 ++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                   |  3 +--
 arch/x86/lib/cache-smp.c             | 26 ++++++++++++++++++++++++--
 drivers/gpu/drm/drm_cache.c          |  9 +++------
 5 files changed, 76 insertions(+), 14 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

