Return-Path: <linux-kernel+bounces-833887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6804BA34B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CDA625530
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9D2DC32C;
	Fri, 26 Sep 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EZ65DsGu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FE2D9EEF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881242; cv=none; b=mUoXZ3qt7zCPVP49T39YvIJgBdzVaOoVU/JHtWBL93s3MXQTAHbtcNAnI6Vgnh7EniHo/zjGtH7AGoBAdqYa7CzBln8Lv5CB5SZgumrBPO4nIO4sDR6wn0NHknQ/73TgHNW/fLHTXJ4RcHVB34C9Sicj5EUIYAD4vG5GAHdXe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881242; c=relaxed/simple;
	bh=Em0zRI0uOGCRmpgRXrzPh+SE4eK4amdzf5fhoYbMqnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DZiXo/8oKFOMlOLCj/9l0Q3PSvqoJssu9S7YGO8n93ojmw8OnuItW+zR9DF0n2wsG0UPEReKJhnbgXDklcewpPbgKivebV9FzQSYcvcw+UInkTrSoB09clW+sBcjPbXviDt37sBnmdY/aigsAb4D0E0dh8ty5Drqxl8wKfpTgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EZ65DsGu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3734E40E0140;
	Fri, 26 Sep 2025 10:07:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CaBGj3J8uVZ6; Fri, 26 Sep 2025 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881233; bh=XHZCw/OaWPLcgGbiWcCaaJU/LcshuyY8ILHoPMW/mGg=;
	h=Date:From:To:Cc:Subject:From;
	b=EZ65DsGujoczlHcY8JRr6UIb9vKeGKdvljWriKdeFDKHewKmJmqGC/rnvdcUqpKXy
	 WUk0Z8mrReaN6p3rLXSQkTLtEBX0LuyrG75cVz+cvZ/CvI3eYtuqvDGuvps+14aXyR
	 4GIm3VVqYpr+v08iCuoRoeLxWXurauhy6K7KlqZa/itxRPKogcGv5in5sTpIgKB/rH
	 Cf1+Z3P+RGYq3YpgigqPe97w3NyMcapECgtAiivBJ8Oiy1P1Lrrw7funz5RI9ZqMEs
	 IjPvKCYxy7j3NazcDhV8qRGv0lAcUMxlLopiBW/KVQh0Zu9FacvY18uDQDtnG0OAvP
	 n74bFEhhCKr1CkSxjlHR/BMto5UeLUYzNe8vv3w9UouQMd5qX6XnOFaT7fjHLGXxxF
	 ggY91gxyLWVGzBoLjYQoYo+3y+Tca5HaYBQwXNJso4XcPoWn9cUWL5jb/Zx/JIgAcz
	 oVD4+Dah9g+BkfTpPgANdSbny7infzHjVXhTZmt30ouYVue+gHlYfkryMOA1OYm6sx
	 7M0LQ2NjQgSg0fFYaToMKBazQaBSSBlPsMvaqjnsDJaDJzqigXtjgol9wIAZEAUH0r
	 Bt2x6kpRMO98xo08z+xT5e481i2820H/FRO2g7UcQg49O5Nsd0gzMrXjCbgFxoPrK+
	 ga5R6/xERPuLn2IjJAcUDnA4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D4E2740E0176;
	Fri, 26 Sep 2025 10:07:09 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:07:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.18-rc1
Message-ID: <20250926100708.GAaNZlzKcAZilZHRZb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/microcode lineup for v6.18-rc1.

Thx.

---

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.18_rc1

for you to fetch changes up to 43181a47263dd9f2bee0afd688a841b09f9b7d12:

  x86/microcode: Add microcode loader debugging functionality (2025-09-04 16:15:19 +0200)

----------------------------------------------------------------
- Add infrastructure to be able to debug the microcode loader in a guest

- Refresh Intel old microcode revisions

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      x86/microcode: Add microcode= cmdline parsing
      x86/microcode: Add microcode loader debugging functionality

Sohil Mehta (1):
      x86/microcode/intel: Refresh the revisions that determine old_microcode

 Documentation/admin-guide/kernel-parameters.txt  | 12 +++-
 arch/x86/Kconfig                                 | 16 ++++-
 arch/x86/kernel/cpu/microcode/amd.c              | 73 ++++++++++++++------
 arch/x86/kernel/cpu/microcode/core.c             | 47 +++++++++++--
 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h | 86 +++++++++++++-----------
 arch/x86/kernel/cpu/microcode/internal.h         |  9 +++
 6 files changed, 174 insertions(+), 69 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

