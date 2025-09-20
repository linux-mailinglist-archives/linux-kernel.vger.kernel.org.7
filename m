Return-Path: <linux-kernel+bounces-825567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2FB8C3E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948157C4217
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF527816E;
	Sat, 20 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khguxPeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807D277023
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356926; cv=none; b=jP8xXIY+Bz2+/7rQYE/jlnDgT2m81/3URRntHa3BWk7qoTnB154rNWEw3O4ngo0A0j/vB+wqureGrgU5zmqbv3377d4QrM0/dAvet0kuapPIKbTVfR8YXkxuz7/2qQj4QHAndFyBVQVsZv39aJ0I8Mk+It7li4+MI8swn+R1Klw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356926; c=relaxed/simple;
	bh=aQ8h0DN7B0Out5OlTQuSkYgFptmJpMspiAfFmqvgCuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tOA40r+a+vUuqnHlLB+hrPZyPlguVSKyW2QTRsP+OOgIRDuwv8qMvvBoEVXUf7dUV0dTJ5yQEuHR8xwhLJygSDgHCzugvdgcMptF9JhfH+NITKHMYcetgWl9MBGt+JUCkn3TiVzeqxBz7lzKskghfTlOjlrXXw57L4KuvTMZw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khguxPeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D620C4CEEB;
	Sat, 20 Sep 2025 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758356925;
	bh=aQ8h0DN7B0Out5OlTQuSkYgFptmJpMspiAfFmqvgCuc=;
	h=Date:From:To:Cc:Subject:From;
	b=khguxPeYzIlUYcw+K1BzTnWgaUuDQM0fZjGjhCEwMnHMZwRoV2nt+/F3l7s/Jruq9
	 c3r1HIhrb/rCrGQetz1xCpczB9T1ji3O1sTqJ9veplvbQqVh9C7KL+hLmae1I4713S
	 ml4F3xJ7CijZ8TsyMNzA7E3U2v0lo40/MGYIP1yBztCJ1vrrUih2hdRbm85OfuKOik
	 PEGBH7RmMU6X+NB5wRs0cBXE/ViKlRfxwBaCnQkjFdSF67C3an9UjiV55gD2qZj3us
	 VDGhaiQ3hvmWzseqv93QGpB0oJsxw6mVNbUapqRm4cOgMTUCMelGOLuvHJUIDAPley
	 8gGVDHQQ3f2/w==
Date: Sat, 20 Sep 2025 10:28:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fix
Message-ID: <aM5luGlAgWDxXL-7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-20

   # HEAD: 7f830e126dc357fc086905ce9730140fd4528d66 x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

Fix a SEV-SNP regression when CONFIG_KVM_AMD_SEV is disabled.

 Thanks,

	Ingo

------------------>
Tom Lendacky (1):
      x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT


 arch/x86/include/asm/sev.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)


