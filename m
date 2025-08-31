Return-Path: <linux-kernel+bounces-793338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04FB3D208
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C317DA93
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5324DD17;
	Sun, 31 Aug 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mjyzh9Ut"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69762036FE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635277; cv=none; b=kSS2gH0uDmXPPFQr+u1cvzTnFQe7nh5SYlFEPLBBiFU08np00F88kV+t58AB1J9H8tX6X1rjlTJA7cMgoeAMey68Y85wauEjevcIso5Xsjw4S9va8ggYYLn9HtKW/6KiO+4dQcxQXsd85bK6VlHl8eMaTHJhfHaFykqr+kaLeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635277; c=relaxed/simple;
	bh=zFcrOKEVSz2lEIu2/v2ECXbA3G4Fm2M3/cTRCm7mhpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ecm6fytGEsiHfEx486NAlGo/nMwtOF32mvHCAKHzTwT/Vj0850WzMfvtMquZa8b/hSj5ocMDgMOQe2/NzEHfbI2/jU+yMvZgv9/fNZhHS/G7NKoQgzDOAo/P+hbAXR0u88njg02NSYGgsnvyxMSieYd+qaweCM8OF0jMG23DMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mjyzh9Ut; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B841A40E0173;
	Sun, 31 Aug 2025 10:14:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W4ZP6i0s5HRB; Sun, 31 Aug 2025 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756635269; bh=Xa21vcqncbcx8wZ4HZFNIZrv7kk7WqqHAKq1GV0fcMQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Mjyzh9Ut6ZSC1DXth2eZMcyFLMNB7fktAf/KpuOKzW2FbCkMKkkewjT6ZlrkPNEaf
	 5zckLzTPLo7EH3OUGohlISlYS+ltHhlkmFwCxCjzI2Taz/u2pNuf+HecbUtqUwfBXi
	 dQq1FQYFRmjdM5uI/cgJaC6ZEufZQF3cw6hQbEvp4jo3aYAPcP+Yd+fh6OFjoXRna9
	 hpNVmoNlUY8OELfG2VEj4QHwLrQuGymepd4QJQb6NaZvI8iXCuSwZvIJaW/puZOspx
	 /XHSR95YOwYALZf+DZCVzGq02KS9QUfBlf5mE4wQsJTISevLafEXg9aafIbAM2G73h
	 CF2gF8vsEOWxKs6T0ECfyC6caXVXr/I3OicoC647CT9ZgQ1xIFPMPRtG+asf6JJhhM
	 K2iJ4i2ghOluX8Kzv94cLQzMVJgCY0WrjcN7dEEjPG4LvhOkArPaceIM5z3xugHgzA
	 0u6fnaQFnfshYSw7RLm6cmsVlKKg320C/ZVSSYUJn3aKnaQL5JH3l3gubXCtFJplI1
	 h5V7K5iAI+9IUojY5s4iRIzko1JXtt+Gfzdv3OVi0GIKcdAlxR6fxsmEJ1YAIqKQqc
	 BWOCOZJpugxtCEzNE3A1X4DOfp+EbAwRmfYG1JnUbYRxiVUpHd0hNiX+/WO9ijnvbr
	 qAhhpLlQ7coZr0kN1cWZYr4w=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7DC6140E00DA;
	Sun, 31 Aug 2025 10:14:26 +0000 (UTC)
Date: Sun, 31 Aug 2025 12:14:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.17-rc4
Message-ID: <20250831101418.GAaLQgepm-XMwE4n7x@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.17-rc4.

Thx.

---

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc4

for you to fetch changes up to 8b3641dfb6f902407495c63b9b64482b32319b66:

  x86/bugs: Add attack vector controls for SSB (2025-08-27 18:17:12 +0200)

----------------------------------------------------------------
- Convert the SSB mitigation to the attack vector controls which got forgotten
  at the time

- Prevent the CPUID topology hierarchy detection on AMD from overwriting the
  correct initial APIC ID

- Fix the case of a machine shipping without microcode in the BIOS, in the AMD
  microcode loader

- Correct the Pentium 4 model range which has a constant TSC

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Handle the case of no BIOS microcode

David Kaplan (1):
      x86/bugs: Add attack vector controls for SSB

K Prateek Nayak (1):
      x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON

Suchit Karunakaran (1):
      x86/cpu/intel: Fix the constant_tsc model check for Pentium 4

 .../admin-guide/hw-vuln/attack_vector_controls.rst |  5 +----
 arch/x86/kernel/cpu/bugs.c                         |  9 +++++++++
 arch/x86/kernel/cpu/intel.c                        |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                | 22 +++++++++++++++++++--
 arch/x86/kernel/cpu/topology_amd.c                 | 23 +++++++++++++---------
 5 files changed, 45 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

