Return-Path: <linux-kernel+bounces-761206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A2FB1F5C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8945218C13F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6F2BE7B3;
	Sat,  9 Aug 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="epBJJYlc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3B2BD587
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754763122; cv=none; b=LnBGFWpFeN+1FlvL+AhQ2ExrQNhnrGp83leAd+9XQkdR0ed0tymAtP4ef30nYXVFTAbPqtfdvji1g6yOJkzkluRN27eSp9lyP/n33CVQUD5GtHZg7/UKurhbDmdogFPcerzQfAhaPcfsUu0kcyak8RDLV4fWbOnOdp0WJSW6TOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754763122; c=relaxed/simple;
	bh=fEeFwC+/L6QrhxcJ8HZszMYzB2e64gb9ymZP9Mtxo0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bs1HrTlh5d2LYq1NhtkjOS9eLwQHXT+oC77GcGL7wvy0GdGRkPmN8qNw6mq29RblPIYbgbe79yIUtPAO3ajRC+es2UzsSLI0BSa1Bu86tPvCuA1NX2x/kpAyYtYmUQs4csfWO7TPyBaPQo+UdwKSwAiuNoJziSlzXCF+HJsTw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=epBJJYlc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE11D40E01FD;
	Sat,  9 Aug 2025 18:11:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1_-T55u3TL3a; Sat,  9 Aug 2025 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754763113; bh=ufHTacxAQRsC7C4xJRXkBE6O2TywptRtk2q6pWPAR50=;
	h=Date:From:To:Cc:Subject:From;
	b=epBJJYlcKe8IIfuzhTTvaSVrqHf3A9ob6aYTKtYMlzK3d05jbxdtFesphjenlzDSG
	 ZAD5yR+nmj2pALCHC/rFmhsAVoML/vE/U1MM65BoouhHX5WsB2JwGWKsMgJxDf5Opu
	 ryKzniU5GM0isxAHbwNQjUT1rwedo2P7Ghcm7Yuz96+XbnJ8nVGUWrIJumnqYEVu5g
	 +sOuAn67GjG6iusfbfA2UYrwqxbCk7tl/3sxy/7MqJtOFQo96zgvcLc0IWT16zbEvU
	 BqX1wSj+0KOcWs4MwS+TERLlV4nfdC50XViqrRtMAsnLGmbpyE230gpGb57E9rOKTV
	 1Qx8RJfTOEGCHJlHXPdiOoKnxpaTdVb7Y5FGC9AVx3360vgG0tPF/OwQypBjVrvXnS
	 XKF4KZRhuL59IaF0w0gFbBW38KotDdpHV5iRKJfFTMCKOMU4am3OW7ceRePMni7efC
	 f6Nub0Ar9fJGl+/+1RVmr43JRET5yGpsGH5a9YIPn3LzkRu5F4f7hnNQm9mSBXVGNA
	 BZzaw3wE3ZjvIm03aRd3FQDjSlSnsFsxReqxgKhBdjmqhvNT1po886rZB816MIZIYU
	 fvxR/T75uOWVTcH0W894yOTOMxW8jm9RyoUYcz5EcoyQkupIz5QsIDlpoCs1iGlVQ1
	 xULvmRRMHWV+/+456DwT0O/4=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06D9240E0176;
	Sat,  9 Aug 2025 18:11:49 +0000 (UTC)
Date: Sat, 9 Aug 2025 20:11:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.17-rc1
Message-ID: <20250809181149.GAaJePZT3hBq-Vk-hm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.17-rc1.

Thx.

---

The following changes since commit 98e8f2c0e0930feee6a2538450c74d9d7de0a9cc:

  Merge tag 'x86-platform-2025-07-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-07-29 20:05:06 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc1

for you to fetch changes up to ce0b5eedcb753697d43f61dd2e27d68eb5d3150f:

  x86/irq: Plug vector setup race (2025-08-04 23:34:03 +0200)

----------------------------------------------------------------
- Fix an interrupt vector setup race which leads to a non-functioning device

- Add new Intel CPU models *and* a family: 0x12. Finally. Yippie! :-)

----------------------------------------------------------------
Thomas Gleixner (1):
      x86/irq: Plug vector setup race

Tony Luck (1):
      x86/cpu: Add new Intel CPU model numbers for Wildcatlake and Novalake

 arch/x86/include/asm/hw_irq.h       | 12 ++++---
 arch/x86/include/asm/intel-family.h |  5 +++
 arch/x86/kernel/irq.c               | 63 ++++++++++++++++++++++++++++---------
 3 files changed, 60 insertions(+), 20 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

