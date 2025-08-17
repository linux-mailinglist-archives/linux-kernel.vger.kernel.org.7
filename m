Return-Path: <linux-kernel+bounces-772419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA88B2925C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344EA1B22815
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8C22173F;
	Sun, 17 Aug 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eKbVA+LY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF081A841E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755421049; cv=none; b=UrVXCzG4/+JVvLXpkMvuzxeRAlx/Yf50mmEoBwX+r598NzeFGeQFFKaEYgQ8Yb327pHwhdHim5hR+BCKj8q3VdpIXm4ATxkYERUOJiY/WLgDYzgoKl7uMZwid+HiyOq8zDQ67sS1oNDoZvIYfMvqFaP2/Rt0EkjNFv2I94oFCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755421049; c=relaxed/simple;
	bh=fPUDi0DZzoqZfl8sl+wTGpuFJ3GTkf38jnCIeZxqurQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ku3vIL01l6jmhxPRmDwg/kRW/NLUNjtpBOZJEQbXd9xe9zCeIH0puWu7K7uol05J95aNB4FJQgUBI9KHxFkFzjFe1YNVU6RSp2EwVQZN8BX6pPIoRyiYtj3nhq5z6vvvcB/hs0TWQB9FiHqI9wEz+hg6ovTKgg+PVwQuRDpJZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eKbVA+LY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03DC040E0206;
	Sun, 17 Aug 2025 08:57:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 94RntjjoMWWS; Sun, 17 Aug 2025 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755421041; bh=t/GgKOh0JWWW4x61dOBo2v+zkBCxsrF+oUxXPJPET+U=;
	h=Date:From:To:Cc:Subject:From;
	b=eKbVA+LYAibCOR4J48BdXurC1uYwJ4YkTCDAvRGU+PJuU9UwPtNZCLP7W5LsWf9Io
	 Iodd3IPP9MZH3XiFY7T4QIcC2nEWqaY6d8OFn7HQ5hSPatRBhRauj+W8Ggc7r7Cbju
	 UQ9ppi1uAZb4HDFWq9n2WGvg06Gz07clGnzHBxmRNvw8no6SdsbtNiNl+MdFyvQjgG
	 4iF5itNfpI0Boo2jntidMW6j2D4GDMpnl7DSCtC2xfKviYxYXvaI2bLzaivQLFTeV8
	 W2aAtIB9few7CkmRaChSU0olawH3pxDbjMKPadzZkJN/pngqjGCpsonjhrArzfkoU5
	 +OEU0eAWXUgTD2QzJbSTFESKEyvIXPjwSRaQLqcHvfqKe0a795ta1pmMD4UIca4vnV
	 Z0aMhsrS/Y+rIyFLhGUrxhBy+PsMgytOpiI9EqPoK6sP+oiprTFSdb2nvzJFjk7cuG
	 yeBwTpLnb5beOgZnzTvQszo/w0Q6YH1uVArfdxbnfLOe5PZxtUxVPnq8MbQ0vp2ATc
	 AkRwWjyQBvcEOd5Tfz42c+ffZpcVD1IZCyCEjGGk1dETDlPKju7Ff4tA8idygF8BIr
	 bdE3UHoGpLQV2ePJZW4I2eg0c1t1YrWcP/sbeCz/Cr02jCtJw91GsNdHU/uZ/nYP6X
	 AWRYr4R0imqSqJ+OGktK2hcg=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB6D240E00DE;
	Sun, 17 Aug 2025 08:57:18 +0000 (UTC)
Date: Sun, 17 Aug 2025 10:57:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.17-rc2
Message-ID: <20250817085712.GAaKGZaP83Bp4ghNT7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.17-rc2.

Thx.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc2

for you to fetch changes up to ed6c4b657bca3b39f7b11cba1405931aeb490f3d:

  x86/cpuid: Remove transitional <asm/cpuid.h> header (2025-08-15 17:06:23 +0200)

----------------------------------------------------------------
- Remove a transitional asm/cpuid.h header which was added only as
  a fallback during cpuid helpers reorg

- Initialize reserved fields in the SVSM page validation calls structure
  to zero in order to allow for future structure extensions

- Have the sev-guest driver's buffers used in encryption operations be
  in linear mapping space as the encryption operation can be offloaded
  to an accelerator

- Have a read-only MSR write when in an AMD SNP guest trap to the
  hypervisor as it is usually done. This makes the guest user experience
  better by simply raising a #GP instead of terminating said guest

- Do not output AVX512 elapsed time for kernel threads because the data
  is wrong and fix a NULL pointer dereferencing in the process

- Adjust the SRSO mitigation selection to the new attack vectors

----------------------------------------------------------------
Ahmed S. Darwish (1):
      x86/cpuid: Remove transitional <asm/cpuid.h> header

David Kaplan (1):
      x86/bugs: Select best SRSO mitigation

Fushuai Wang (1):
      x86/fpu: Fix NULL dereference in avx512_status()

Nikunj A Dadhania (1):
      x86/sev: Improve handling of writes to intercepted TSC MSRs

Tom Lendacky (2):
      virt: sev-guest: Satisfy linear mapping requirement in get_derived_key()
      x86/sev: Ensure SVSM reserved fields in a page validation entry are initialized to zero

 .../admin-guide/hw-vuln/attack_vector_controls.rst |  2 +-
 arch/x86/boot/startup/sev-shared.c                 |  1 +
 arch/x86/coco/sev/core.c                           |  2 ++
 arch/x86/coco/sev/vc-handle.c                      | 31 +++++++++++-----------
 arch/x86/include/asm/cpuid.h                       |  8 ------
 arch/x86/kernel/cpu/bugs.c                         | 13 +++++++--
 arch/x86/kernel/fpu/xstate.c                       | 19 ++++++-------
 drivers/virt/coco/sev-guest/sev-guest.c            | 27 +++++++++----------
 8 files changed, 53 insertions(+), 50 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

