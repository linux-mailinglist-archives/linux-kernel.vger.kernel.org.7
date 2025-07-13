Return-Path: <linux-kernel+bounces-729021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FFB0309F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C91733F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4126CE06;
	Sun, 13 Jul 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LXFy1wCA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476E1E7C23
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752401332; cv=none; b=EFXCUl59UTxoEk8GJLwbw/sH0MY/O1txl+jJJhs0cADEFuBdcvSMyCSleG++sRYhvOe6D0JwODTyvR5ccCd8JLczQxMCQP7jHi/GaRyQgJvB738GfX+9GogVbXPnb55Bi8JXlBdQ2Ag/cODp4h9Ee+Ly32/3fZpAOfMP9tgRKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752401332; c=relaxed/simple;
	bh=PJcKBelo8mfAeaKNjw6Er9u//bxXdfiSzWBLSanZnyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=emtqWII1Z4cFRrwkmn2NRV0maEWoxIgxn19vmpr/YT6BHo3UxhXCxxGwoSvofFTG+EPaoDHYBX3sjg/HVszpyKq1hZObji7pYazrV+WcTU787SxTd87NjqweVmuY9+QTX8Vgxg9dAhhPXb3aFZ2Rs20Hzj7cB6CaK6+xh/PI+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LXFy1wCA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E38140E019D;
	Sun, 13 Jul 2025 10:08:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TiilM658mwCA; Sun, 13 Jul 2025 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752401321; bh=GoN9KOCVTETyIQL8qB1caxKUKUBNRXro6judFRxUxyc=;
	h=Date:From:To:Cc:Subject:From;
	b=LXFy1wCAPWOVct/JiCuFimDpYdLKecwiuTBuvhGkUYGnwDFzKndpdtK3Raxh/MCQ3
	 /tH5hEKLkPNhe1FAboqwzZKHnyr4yxh9en2fnuGPUe9OVrjIYce73OHEV+ZHDK/zY6
	 o3RKE8frop1GPML0hWLYVkKEZx1o9bLEkbOLwRS7BM/pvPP/4p9FNyb2qOiLAjngxB
	 O1EhsnTj5XnQQGoXFrHKoEbA8+zJFEroDK/u62sjQGbuljBURIzujLAwguhXXOUZnC
	 4c+pgUuOR/VkVd4j0vdEMHGoa5Pe34A0yV/E2M2PVnc18xYj2fyzeXrsy/4CDiN3WM
	 wUb+zO999V/Ai/WE8YG5/rnZa8qcxg5PDA3SCY9nfWDbUeFdL6DnDwPm/D1c2YJjcv
	 75QE8rYlVIIufUK+3XNbt2ZSjuDXthHxFH7qLSXAZQUxUnkb/e/yK4ET8Gmz/93aCn
	 U/nwSsgamfSpVtwTf56LWgJVOFFej0a3mJB6KpthvjHOIv+liKC0zoaQx1RwaDr8Bm
	 Gwlx5MySr04KEiGOAcSEPNWu9mQbhottojqkP98mYiO2+zRX+9GB1K8W4hX+5zxJyG
	 MnvMSPtEyWzZjpbSyF5+F6kinlUWYXEXNIKz5dAxj5m6GHnIzoTle3uXLSA3Vf+5oM
	 BZMEqr8PIF2M1NMKr4t87v1Q=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18B3940E0163;
	Sun, 13 Jul 2025 10:08:38 +0000 (UTC)
Date: Sun, 13 Jul 2025 12:08:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.16-rc6
Message-ID: <20250713100831.GAaHOFn2t9qPFNlkf0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a perf/urgent fix for v6.16-rc6.

Thx.

---

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.16_rc6

for you to fetch changes up to 3da6bb419750f3ad834786d6ba7c9d5d062c770b:

  perf/core: Fix WARN in perf_sigtrap() (2025-07-09 13:40:17 +0200)

----------------------------------------------------------------
- Prevent perf_sigtrap() from observing an exiting task and warning
  about it

----------------------------------------------------------------
Tetsuo Handa (1):
      perf/core: Fix WARN in perf_sigtrap()

 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

