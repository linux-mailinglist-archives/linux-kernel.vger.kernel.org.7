Return-Path: <linux-kernel+bounces-833879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D6BA346D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07322560C19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35F2BE041;
	Fri, 26 Sep 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kApA18/L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153726AA94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881047; cv=none; b=f5r0l2tTSZS6S2ThsEG6xkGmepfI9jFCdVJL1mY0PUhqMlZ31pDjTJE0ww1cfumyOXa6D2qLIwaIMg/TwQ9nZBoqImlu3d5QjBoS9jFNBfi6tmrEs9JtekZC/pzvkIUvUZcW7C9bFCm2USObeXQ5clSuJueTzcK0TZkMBwZAUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881047; c=relaxed/simple;
	bh=TDO6+CYBk/avgVyI3VQr8oj/Os78LzB4Yu81zLXQ2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPGdaqpskelAnD23RWs8QsoutHPYbQ9X15f/JAdMIruy2RHyAOnkcI2E4LHoBzTt365TzvDd65BS8wB3k1PXiMvwD7TMbofmls6sDILjsr09y29SxvQWNSjyAG/YSof/fHz26l6TBRZ9rVXgJL0C1vhRSC9twSaHaU1QpHvYIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kApA18/L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F3C6940E016D;
	Fri, 26 Sep 2025 10:04:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fe5n37o0wIln; Fri, 26 Sep 2025 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881039; bh=s56wg21j1cmd7Rs4aE3NtuEXkw7AhEr+P+FZ/PNtEfk=;
	h=Date:From:To:Cc:Subject:From;
	b=kApA18/LUGsUTSjuldDLs4qkLfhBiaFgpyVYCLk3ltRx8oATiGCx370CGvjuxVihW
	 f51rraaTu/coWCt5n7zYBDWQg605pLrkv2aozY0uaLfLgywD83K7Z9dgJjGDU8AuUL
	 jLW5VhuyNuXXvr2k6IMwSsk3jgoGuui3L78e+/hsHm0wu9r6QaMTnCWHsRkxhSqpRF
	 8TWna68LTjmxe2qvhP/+tNFwZV3CsjGmkzxNglEqp2yyY/xiieYBRaOu1JzJjq/5Al
	 uoSVYh5RdqR2RE6prGLTjdpeTJwcwzpAe2FXrNfletIc+cL1zraBE/b/69S/MQ06oN
	 ENIc0fv9NBK3X6J8IZFns9L6qxZr0xcpNU1h8TXK6CrPbULsL7dy7fwYczZhjIwEmR
	 Pn4GeHlwljGiUaxFqFIraL8L1hHChWqW+CzycREmnJC1bo4SIvGmfxnkofZ7WGoOsi
	 DJF2mncOe7qxhxxjBqjMDcLXOgzn1LQFlfLWp4fGRcoX6gIOHsJstj7Di7+NBWd5qa
	 xtHeG21jzDDSMhMxE1pGayvDpCiV0/uj3Z34spWjKPlTSG4nlQ2viSVjSbUq4h/dVn
	 dSVTTk9AiwB4m9Z3AtGZuskk8dVbYalPeCdDdVRPxhUzGxWS861e2jXLtsa40gXWhW
	 CDN+jBis99GYpSvmVA9Xc5yA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B0BB440E016E;
	Fri, 26 Sep 2025 10:03:56 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:03:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.18-rc1
Message-ID: <20250926100355.GAaNZlC6-pchBQ5opr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single x86/misc update for v6.18-rc1.

Thx.

---

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for_v6.18_rc1

for you to fetch changes up to 26178b713f2b3f5bc411ed8316d1635615896111:

  x86/insn: Add XOP prefix instructions decoder support (2025-08-18 17:15:02 +0200)

----------------------------------------------------------------
- Add instruction decoding support for the XOP-prefixed instruction set
  present on the AMD Bulldozer uarch

----------------------------------------------------------------
Masami Hiramatsu (Google) (1):
      x86/insn: Add XOP prefix instructions decoder support

 arch/x86/include/asm/inat.h                        |  15 +++
 arch/x86/include/asm/insn.h                        |  51 +++++++++-
 arch/x86/lib/inat.c                                |  13 +++
 arch/x86/lib/insn.c                                |  35 +++++--
 arch/x86/lib/x86-opcode-map.txt                    | 111 ++++++++++++++++++++-
 arch/x86/tools/gen-insn-attr-x86.awk               |  44 ++++++++
 tools/arch/x86/include/asm/inat.h                  |  15 +++
 tools/arch/x86/include/asm/insn.h                  |  51 +++++++++-
 tools/arch/x86/lib/inat.c                          |  13 +++
 tools/arch/x86/lib/insn.c                          |  35 +++++--
 tools/arch/x86/lib/x86-opcode-map.txt              | 111 ++++++++++++++++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk         |  44 ++++++++
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   2 +-
 13 files changed, 513 insertions(+), 27 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

