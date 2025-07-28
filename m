Return-Path: <linux-kernel+bounces-748195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA45B13DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8D1170AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86126FDB7;
	Mon, 28 Jul 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QualhVTJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076426772C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714524; cv=none; b=UB1v40nBRPUc7yeoWd++v5jWIlgRADDVKGPU7cAGnEozA9EhCrerr/T53Z+hTM9k+hT0dUS/yp+hiF/XhTVq5vqQHUq/Uy1X6vTiiGlArPGc30RW0cJPmf6ykvd7w6xPQ4k5ktIDxL1RIbMTxDdbdzqEK0wSKd7gD1ACoSqXNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714524; c=relaxed/simple;
	bh=hF55f9cCUF9A77oKaeQNM23FK7uytR/sEEkHNjDN2lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GGrtxu5oOgVitDNq3VPqe9JEUjXs4EUu8b09JGvSJMGdnLd+YI1NGbwVc6YtSTFKW8MI68Sy3SvNRNUpD7a7z++JKDgdcBW3nA+NPSRvL/E8rY6lMXq08WJNa4hx+NtzkPF+ISv7s/jMrro7KdotbY7gHCqerL1BuzTkpfv9Y+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QualhVTJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E3DB40E0256;
	Mon, 28 Jul 2025 14:55:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WruyO6SjSreR; Mon, 28 Jul 2025 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753714515; bh=m1bsJakO/tDB6t7iC5R/MU0poHgrYMpXV3MiZ8TBeg0=;
	h=Date:From:To:Cc:Subject:From;
	b=QualhVTJPXh3Y52c1Z52YwDFk8QF2+jonDBPe9yijRbrf33UAyVlx0vxqfTbrm3BE
	 /rmwkb9LNcEGHzcvs5FOXubU0NcuM0X0slT0JdMWPiwgHxe7PhbzDHU2gaP+sSS+Oj
	 6B6eVFgRM7Qg87NGc0LobjFPSNOH4Vn2J1/3YyB+vaFHMSQigTHXVd7nHo6T3VlZOA
	 xl+DlVDVF89LCdy8XwtLZHQ0lAgedLlwstTM9kpr8UzCDN856LXJJ1JC7CuFd7FbAo
	 wG5ht2l1L1ImbKxPgGMIVehLcV0pPB3cDwzXwSGmHIsj0o2yJhZrS9R+unwu7k1s93
	 U/WOVa8bBwoZeNhHWbtgQIX2EPuSyStms8IF5FSumdvRgn3FE84LBT76TVlCWNkS9T
	 8EW4Dej9jvg/PenjyBGEDMM6zv9C02vkCPnim5h2baLkwikeJk4Qx2pIEPEZ5H2Kzf
	 ZJq20APekY/UKqT7IEb/juxbNiPXSlQxXPC9FHlN2UCw5AuHPrg7SGW7iF28bt0nxp
	 CZOQP0IpuqHAMMjjHNFfiobqwTPSzqPzdzzC4o85x7Cq2k/ixIup8eKPQg9n0T4I/j
	 SubFqTTG6LrN+Ws5W0c2lKdBrbi05lPrVSDIsmseA3TO5jus9N9JjxSlMdKDqD5j39
	 fdjlcZcJ9KKH/UOh4yzv/i5k=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E462E40E0255;
	Mon, 28 Jul 2025 14:55:11 +0000 (UTC)
Date: Mon, 28 Jul 2025 16:55:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.17-rc1
Message-ID: <20250728145504.GAaIePSCpIIIRnc0U-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/bugs lineup for v6.17-rc1.

Thx.

---

The following changes since commit 8e786a85c0a3c0fffae6244733fb576eeabd9dec:

  x86/process: Move the buffer clearing before MONITOR (2025-06-17 17:17:12 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.17_rc1

for you to fetch changes up to a026dc61cffd98541e048f3c88d3280bcd105bd4:

  x86/bugs: Print enabled attack vectors (2025-07-11 17:56:41 +0200)

----------------------------------------------------------------
- Untangle the Retbleed from the ITS mitigation on Intel. Allow for ITS
  to enable stuffing independently from Retbleed, do some cleanups to
  simplify and streamline the code

- Simplify SRSO and make mitigation types selection more versatile
  depending on the Retbleed mitigation selection. Simplify code some

- Add the second part of the attack vector controls which provide a lot
  friendlier user interface to the speculation mitigations than
  selecting each one by one as it is now.

  Instead, the selection of whole attack vectors which are relevant to
  the system in use can be done and protection against only those
  vectors is enabled, thus giving back some performance to the users

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Merge tag 'tsa_x86_bugs_for_6.16' into tip-x86-bugs

David Kaplan (24):
      x86/bugs: Add SRSO_MITIGATION_NOSMT
      x86/bugs: Use IBPB for retbleed if used by SRSO
      x86/bugs: Clean up SRSO microcode handling
      Documentation/x86: Document new attack vector controls
      cpu: Define attack vectors
      x86/Kconfig: Add arch attack vector support
      x86/bugs: Define attack vectors relevant for each bug
      x86/bugs: Add attack vector controls for MDS
      x86/bugs: Add attack vector controls for TAA
      x86/bugs: Add attack vector controls for MMIO
      x86/bugs: Add attack vector controls for RFDS
      x86/bugs: Add attack vector controls for SRBDS
      x86/bugs: Add attack vector controls for GDS
      x86/bugs: Add attack vector controls for spectre_v1
      x86/bugs: Add attack vector controls for retbleed
      x86/bugs: Add attack vector controls for spectre_v2_user
      x86/bugs: Add attack vector controls for BHI
      x86/bugs: Add attack vector controls for spectre_v2
      x86/bugs: Add attack vector controls for L1TF
      x86/bugs: Add attack vector controls for SRSO
      x86/bugs: Add attack vector controls for ITS
      x86/pti: Add attack vector controls for PTI
      x86/bugs: Add attack vector controls for TSA
      x86/bugs: Print enabled attack vectors

Pawan Gupta (7):
      x86/bugs: Avoid AUTO after the select step in the retbleed mitigation
      x86/bugs: Simplify the retbleed=stuff checks
      x86/bugs: Avoid warning when overriding return thunk
      x86/bugs: Use switch/case in its_apply_mitigation()
      x86/bugs: Introduce cdt_possible()
      x86/bugs: Remove its=stuff dependency on retbleed
      x86/bugs: Allow ITS stuffing in eIBRS+retpoline mode also

 .../admin-guide/hw-vuln/attack_vector_controls.rst | 238 +++++++++++
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 arch/Kconfig                                       |   3 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/kernel/cpu/bugs.c                         | 465 ++++++++++++++-------
 arch/x86/mm/pti.c                                  |   4 +-
 include/linux/cpu.h                                |  21 +
 kernel/cpu.c                                       | 130 +++++-
 9 files changed, 713 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

