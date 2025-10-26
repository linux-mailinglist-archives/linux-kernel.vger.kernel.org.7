Return-Path: <linux-kernel+bounces-870311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1DC0A6F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A47189F5E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62472367AC;
	Sun, 26 Oct 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E01zmAtP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238437483
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481552; cv=none; b=DguZq0n0U2MqZppl+2MPFTEBLkM8A9GPyPzsBbPztoikWZ8w3Thhqz0HO2N+EZaDzlcaVen2jzTAmUCiyaU9j6BPVPY5wYVm7sfoG76ixBr5uDQK8ItAUPv9ahs5unAovGEMRYf9ZttPGxpU5fJNXYrCLySmAYX5El8QITckuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481552; c=relaxed/simple;
	bh=VFeqIpKSyjOWkBCHr0jwXRbJnajBe9+TNrO4WxGNAKU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j2Kf0/rfv9FsCXyc5RV8kOHoMTF0yHYVZG+zKW9WIKvs8dL88qCeF530ClGsBbYrAFIVYFJ8edy6a9APSlg8ZwG0GkRJoGCiUruWDXMJXBbrva6bX2GfsmbNBOueFQlr8/RK76CJcChDNP1vELN8wf5iw3nbfPhJXDYteA5cUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E01zmAtP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09C4B40E00DA;
	Sun, 26 Oct 2025 12:25:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1xk_GPDU2798; Sun, 26 Oct 2025 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761481544; bh=pxEyRL82UuFXgTwyNGZHWQdvXQyTuRhS+Sr74VixTM0=;
	h=Date:From:To:Cc:Subject:From;
	b=E01zmAtP82mjlhaaAIoEmfHwQaaHZ4s6+JzvpzGEUVWGXyUrp5oP4IIV/VVX1zf0Y
	 DmGShm9u+EWYhrlqgBPFZB3D0o3wGrQ9A72QeJtj2gInkAGh1hOVbTLMQUdte8LMID
	 EnzwVyXZTk9ec/I7br417882He1OQ9k2wjgBj3hrCMX/i5WsCGk5bPTLc1Oacps1jo
	 L+qOiAAs9fQLl4gbMvmc4z8qcgZ4vLRGVVuAeuwPYx2Kvl9YQteHAlG715gvouMomj
	 iru8JhzZRxXgoRih8hM/gGmqnjLLp455dEEkojnKkO2E25ie/uS5zqkp7501FQRfhT
	 lbWZdYET1/F3njhk/ixNXm2F5GPpoH11SFAPwF7qgNY56Ci3BCKwHvG7Ho1oAzVkpB
	 MHpKP1+qV3/SJWEMGAakLwVf7X6BtohgbEn0v944SBJX/X70Xgjaj74+Agy07zklY7
	 N0oH8sjNWlHGvaeZ9s9ZiMOKpPq/ntMGiwxyrM3yKQBDsS3QEmsIxZk3aCNI3NyJrb
	 lo6fAYX7HHbFQ+X2QrzTQ0IC1/TbwmFR90Ey8Yd9ws2dr0MbQ6+g6oh6XSt+Au85hc
	 rcO5WWqzO+80Z37HhfptpjoOfA/qPSCXP2jFJJrbr1SQ0ajljE8YS37QJGF//2o0oN
	 PYMB0V1LrBOPBKghsWaX7lsU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2B12440E019D;
	Sun, 26 Oct 2025 12:25:41 +0000 (UTC)
Date: Sun, 26 Oct 2025 13:25:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.18-rc3
Message-ID: <20251026122535.GAaP4TP1aPktqUyeu4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.18-rc3.

Thx.

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc3

for you to fetch changes up to ef3330b99c01bda53f2a189b58bed8f6b7397f28:

  genirq/manage: Add buslock back in to enable_irq() (2025-10-24 11:38:39 +0200)

----------------------------------------------------------------
- Restore the original buslock locking in a couple of places in the irq core
  subsystem after a rework

----------------------------------------------------------------
Charles Keepax (3):
      genirq/chip: Add buslock back in to irq_set_handler()
      genirq/manage: Add buslock back in to __disable_irq_nosync()
      genirq/manage: Add buslock back in to enable_irq()

 kernel/irq/chip.c   | 2 +-
 kernel/irq/manage.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

