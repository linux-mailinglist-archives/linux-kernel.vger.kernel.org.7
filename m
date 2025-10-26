Return-Path: <linux-kernel+bounces-870319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8BC0A73C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D644A4E66DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEA2D9EDF;
	Sun, 26 Oct 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D/k6Bhwi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2262D9ED1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482069; cv=none; b=hDGoUWyc3G9lXUgEjcD6Hyd9UBdlcRcIqRc3Aa7HFtC/29X3MhqMB324mzBLjY1C2CBJQs0Ez57aBBfb8XAMBTtnFdSYZGKGdl4VYKCzyV7uATEiGNchRX5jPL1LNu7Q+IZEWHM6nfRH1Cf3p31rkkQngu9H7WkpxE0iwjbg36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482069; c=relaxed/simple;
	bh=W5XOPmJDhaMKymuFSpYmn867RjmrqspBigXG5gF+vtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rh2Myx0W3SYNR7QPEKtR+4bAoF9kyB3sOmL3VSZzlB3NpY57C0ZwAeez6ClDFLq/OIJQ0Vuxusc0Dx+IFK7IERi+uaCA+Oz7YkFhx6nAMOOvD+8/WR5SMk7VcTPVyaTQJ86G2pObh0K9dk2NF336KMJnp9sN0uL0orBn2YEFcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D/k6Bhwi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 85A1440E01AB;
	Sun, 26 Oct 2025 12:34:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BcKgSgwdliH1; Sun, 26 Oct 2025 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761482061; bh=k3CFEw6Qqcw3vyVIMsDdOQ1zCqCcvLTWp61aUptDJg4=;
	h=Date:From:To:Cc:Subject:From;
	b=D/k6BhwikUz4GfyMOcUKHSBiErRcyQFH+RKkoAVvmCCqoxt6on1NNKbUJ+gdKBG53
	 XeI0HKNPaTptTdP2ZQ0lRVIVnjzFXQpPnI4BhnBuiC8+aONmCgfYAkfyXmMULJUuwp
	 79zHxpkEdD8yaTJ018tQQgR0L5FRVMEnRu4keo6SSM1ceAfESRIef/JZUukFhdgbnR
	 zoQYafJGkGy3b8SWN2Uw66IeNSeP46ydqVAIdInMMqqxf+YF4W6G1m4q3GL+VH63tR
	 9PX4dA0jjw594eneoLmRL9JcPOjFmJoB7OUA+nx9Bxv3cbTe9YQntq3OpethpJBQms
	 kp91JHjdl6xsMykONR27xVgAKRsgVIDM0xjwzXiaEbSi8k08zDxl/flWKtqkHGBXAB
	 XwCcSUAArBMD76SgH2aOmSilBmhHrWC9S3N1oXeia4fCgaULk3tYOv6jj/HLfzUuIb
	 Qe0TzV3bqX25ZCAs9DcmiVYjeQkD+0rPklrBYQK8S3A2fsWA9xwxbZ/xGt9oPrX1QK
	 y96E8swp3AUXr+sTAAlVXxayIRCatYakjQsTJ12DoMaUo3evmrIxgdfdJ3yAjHcvgz
	 T8LdIDIVJMQVQ2PxooGwe4DaiEXwUQfXHVdmgfCoghOnnnauiLN2t1sygg+3xMGSyy
	 vKwLQRU4LWvJH7/BEUzAWnnM=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0730240E019F;
	Sun, 26 Oct 2025 12:34:17 +0000 (UTC)
Date: Sun, 26 Oct 2025 13:34:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.18-rc3
Message-ID: <20251026123417.GAaP4VSVbDKBgjZ9GJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.18-rc3.

Thx.

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc3

for you to fetch changes up to 84dfce65a7ae7b11c7b13285a1b23e9a94ad37b7:

  x86/bugs: Remove dead code which might prevent from building (2025-10-24 09:42:00 -0700)

----------------------------------------------------------------
- Remove dead code leftovers after a recent mitigations cleanup which fail
  a Clang build

- Make sure a Retbleed mitigation message is printed only when necessary

- Correct the last Zen1 microcode revision for which Entrysign sha256 check is
  needed

- Fix a NULL ptr deref when mounting the resctrl fs on a system which supports
  assignable counters but where L3 total and local bandwidth monitoring has
  been disabled at boot

----------------------------------------------------------------
Andrew Cooper (1):
      x86/microcode: Fix Entrysign revision check for Zen1/Naples

Andy Shevchenko (1):
      x86/bugs: Remove dead code which might prevent from building

Babu Moger (1):
      x86,fs/resctrl: Fix NULL pointer dereference with events force-disabled in mbm_event mode

David Kaplan (1):
      x86/bugs: Qualify RETBLEED_INTEL_MSG

 arch/x86/kernel/cpu/bugs.c            | 11 +++--------
 arch/x86/kernel/cpu/microcode/amd.c   |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++++-
 fs/resctrl/monitor.c                  | 16 +++++++---------
 4 files changed, 21 insertions(+), 19 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

