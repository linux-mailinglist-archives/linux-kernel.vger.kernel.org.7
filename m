Return-Path: <linux-kernel+bounces-748559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E974B142AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557513BEBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5A262FC1;
	Mon, 28 Jul 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hkSNCMBO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE017BB21
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733080; cv=none; b=rxAbD/SxrksiLLRlSUZnEQiWDonZflbad6GiBK3BvpzSmoWlkO5ifL1AZcbXLfQPBECEE2CtEaXbuxVQpXRR9f78Fhc0NXQLapiQftzKI351G5JurKtg8jXemizGPDG5ZK25AZm0iBN0N/Clz5iSHt+xVTYRwXRZbcfFq24XL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733080; c=relaxed/simple;
	bh=wBtt22laEbZ80Avigfu8Ox9e4R0bezBejfH2uFom7ig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JVtYEEZ5aPAtVOThsUSXx2mBcHrI9ibE0H4o2U0koCklKt+KNBXTD+AdMXn9KdjAaApWprvv3843qlCNwlb3fJAbA/YKVAMR3rjU0hP5C6p8PQ0+3rrzmrrji53faJDjUykPzItGQnUx9dI7MBdpbp65vl/B9cMFAdPRYrpd8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hkSNCMBO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A1A4940E01FD;
	Mon, 28 Jul 2025 20:04:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lHNCFUy3hDFz; Mon, 28 Jul 2025 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753733068; bh=gAodAJfHj00dgpGwYU67lTWRs5LxSZWy6t7mMtUGqnE=;
	h=Date:From:To:Cc:Subject:From;
	b=hkSNCMBO0B8eHvIRT3t2oq7i/x/U+qVeXJJSBTcN2wZFt+5snWsA/DDYUAbp+VbKX
	 udo8TsNsduvu7JhxvoMxf4SKD8xBFLnu7C1aED06UPPCE0tWdJTOpNkIRiu3W7jFDD
	 k/+OP2yk4jRiH4AqXY2/yUiyJyg0ecNA4LJhmTRUgiPfnH2u0VozkFKdS4YbdsTq/f
	 LbldTdqQ0BdJ0OuKJKqd3mrxvsdQfjshgmkZYoClsA//K0tNx9rzzGHTdx86he2Ard
	 Ij3XHQzQydrP8NSibJwRbNFxo/0Ziojeva2CwC7eX3xIptxsdm0XAi43NTzUvtKKZb
	 aZLPKpZlsNKYrC91csAoihOZuKQrWOVQibPHTE1nXCZbebkIUb0wlKtVJeAFqX1tx4
	 Qxr5nOdPNe1b8BqTTvI+yvQyQvtWJ6tSfLW3QzUAKscW34Mpd2gyX87egkchhXfCui
	 m3Y65GycDDfjzL4Rspq0eLh9Rmh7HZFsrzGXG2STKrR+NHBlICUrXKv0535Lu8qUYT
	 CquUu1qcFjKGWfeb6ZPnrNiKj+DX2rDDBhilmvlzcTNWL1Vv1wuQEdA91OgdL49GA5
	 csUI3KFfOyk1x1syizMrrzqSYtqDteY7KCFqRE4aszBf9iSg53Roor+PVhGygsx4PU
	 wJZvawtY3N3azF0YDbE89d6M=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5949C40E00DC;
	Mon, 28 Jul 2025 20:04:25 +0000 (UTC)
Date: Mon, 28 Jul 2025 22:04:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.17-rc1
Message-ID: <20250728200416.GAaIfXwC7ZYKF70_Qg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/sev lineup for v6.17-rc1.

Thx.

---

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.17_rc1

for you to fetch changes up to a7549636f67f973474ebe1ad262acc2aa4d1327d:

  x86/sev: Let sev_es_efi_map_ghcbs() map the CA pages too (2025-06-27 14:07:10 +0200)

----------------------------------------------------------------
- Map the SNP calling area pages too so that OVMF EFI fw can issue SVSM
  calls properly with the goal of implementing EFI variable store in the
  SVSM - a component which is trusted by the guest, vs in the firmware, which
  is not

- Allow the kernel to handle #VC exceptions from EFI runtime services
  properly when running as a SNP guest

- Rework and cleanup the SNP guest request issue glue code a bit

----------------------------------------------------------------
Alexey Kardashevskiy (4):
      virt: sev-guest: Contain snp_guest_request_ioctl in sev-guest
      x86/sev: Allocate request in TSC_INFO_REQ on stack
      x86/sev: Document requirement for linear mapping of guest request buffers
      x86/sev: Drop unnecessary parameter in snp_issue_guest_request()

Gerd Hoffmann (2):
      x86/sev/vc: Fix EFI runtime instruction emulation
      x86/sev: Let sev_es_efi_map_ghcbs() map the CA pages too

 arch/x86/coco/sev/core.c                | 89 ++++++++++++++++++---------------
 arch/x86/coco/sev/vc-handle.c           |  9 +++-
 arch/x86/include/asm/sev.h              | 14 +++---
 arch/x86/platform/efi/efi_64.c          |  4 +-
 drivers/virt/coco/sev-guest/sev-guest.c |  9 ++--
 5 files changed, 70 insertions(+), 55 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

