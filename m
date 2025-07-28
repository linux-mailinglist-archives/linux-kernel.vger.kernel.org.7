Return-Path: <linux-kernel+bounces-748545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581BB14278
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A424418C0AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B27277CBD;
	Mon, 28 Jul 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eqAUduiT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3378F3A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753730454; cv=none; b=RhUYRI523QDeyKNgBQ8aCeXUd3mG2QLGbygZWp5IJ6eArmVB1oRbtbQgU1fk4ZoDieAmRPp8w/suiDi+Kb1zJhetbolDIZj+zwBfgzAjycNng4V8nLRQ9pVntBdhzHKLZnQXQvqbvNoQQ+9hGkuFBP5RakE38hdViL6ZQuNbaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753730454; c=relaxed/simple;
	bh=o16TPzrem/4R2jEksIRxP0YqSIUWlP7sJmmdiC8248E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R2Z/HS8Da9c18+4OUwQSt7pe0neKG62wfqBNS+QKNAUDt9nFh85D+1a6dXNd/MlyXfCrGD6gYrUOWtG9qBLBArn/5aeKMD3n4RZCR1Cky5ObEkq2BBfVinxJWYNPQb2QMVlD3X30ZsQV8fzq/Qz5ViUWJytMTOvvtM90UPHVXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eqAUduiT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 854CB40E0256;
	Mon, 28 Jul 2025 19:20:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pyt17ycu9uAd; Mon, 28 Jul 2025 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753730442; bh=Or+j8b9xOD43595enlvKV5ndSavP4XSn0XWe2sUm0Ro=;
	h=Date:From:To:Cc:Subject:From;
	b=eqAUduiT+omaa6ok4nzJs4MEavpLFWbXNA6wBj7hLkUNJkmAFVsG6UtrXoEdw6UG6
	 O6oQendnJSnGWfxzMlA4iUYjWmTW6LadBczu1cu7BsEuKuSO7UlQGNhjXnhrf1KKog
	 ryVGbMmZMXRN5QJ/9HAUPNwsyseIRqwteQW0ZFnP01oiYOVSowz77jHkHIcvjiDzOm
	 +FNe2EbFrLIiipolbXEsJNvXKReloMaBQ5ZJyDmArVwHXZv17NaynO7BY9lwE2DDb7
	 R839OlgWFNH6vpWAw/3yVVlYVDLPLq4gDROIU21cw7ryfCnVuayp2F6vaFjBTwiaSD
	 QBBXbxWP3dK5Z3HOhFU/khTj6TeR5E1kQzHwtYYKx74sikQJtqkjl06JrF9DYKwXua
	 +73VGoATgPlR4ivoKTc7nZfs5FIXIRw1+DuiJs/1TyeZEOFCmOa8WZe5/Z2GDPrVID
	 j5qdU1/vcwF19DLZle4w2xtTqhDbHzRaUdc3YUdHrDk0bKh40KllnfRLMJkmbuzJP9
	 hK+rsX6DtVmgILiG++BGKXozWDwgStN0UEFu65Xu1VtBvRiFJ5J8u+k1RLbv33gY9W
	 q2QZQhB42iI99yPBtDN8HX3Ny1zimk7JAsJ2UTSNFhHxpRwsD/MIpO2Rtd93zc0Ves
	 wWr3pML9v5DS/IdLwXEfA2cs=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B42AF40E00DE;
	Mon, 28 Jul 2025 19:20:39 +0000 (UTC)
Date: Mon, 28 Jul 2025 21:20:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.17-rc1
Message-ID: <20250728192031.GAaIfNf-ebodTlXs2j@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull one x86/microcode change for v6.17-rc1.

Thx.

---

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.17_rc1

for you to fetch changes up to 9b355cdb63b1e43434d7ac57430d3e68de58338d:

  x86/microcode: Move away from using a fake platform device (2025-07-09 13:12:08 +0200)

----------------------------------------------------------------
- Switch the microcode loader from using the fake platform device to
  the new simple faux bus

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      x86/microcode: Move away from using a fake platform device

 arch/x86/kernel/cpu/microcode/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

