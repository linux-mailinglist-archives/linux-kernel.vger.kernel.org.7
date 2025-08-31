Return-Path: <linux-kernel+bounces-793293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA8B3D1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B715189E043
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9B21B9C1;
	Sun, 31 Aug 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OOBfzhKJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE07212B0A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756632700; cv=none; b=bgug5kiFbM77kcF13u5ZDoquINlRE0vPPnrw3zQni+zxVgRt7FyeScp2bOeWHFtc3HibT9UBDlbd0ikCJdvm5HH2ccxW83Vfn6ROsGD9tKdxmxoCGEWxDdWx2+G6ILiYvK20rZfK9BK0Z2AfqtiQ7z3BZQzgeAXZMNZyg4LILxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756632700; c=relaxed/simple;
	bh=KAM5K51oDjFQaEFuJsdSWs/45wzGFbYurHWb1oeTi40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mdRd4RdzL+Qjg1HcWc6yRgDWDnMZTBLA+pv/osxWUmL4g1etgg2z2kMqsljqOwnUZ0PexG7+fFMrexpF08YRQhKuoMf3lkGeh0R2y6cG717usi3rSHfY2uIdjJQmIlKdiU8ItQPKTcZKjgKWxUkubULBNtoITCbBImz29MuUE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OOBfzhKJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C05F40E0192;
	Sun, 31 Aug 2025 09:31:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2D8NGNNL9zAU; Sun, 31 Aug 2025 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756632690; bh=jbds5ZcuYzLaYuM9LP2iUpe5yUddTTA+BMKWaImYZcI=;
	h=Date:From:To:Cc:Subject:From;
	b=OOBfzhKJx99+IX+nbmLmrDUnkIB+HTNztXlzvXZPm1i2ziEzCwabOzxnnCm9nIW8j
	 LrVZOokX00Qzz6eL/eYbqHsLJwaqBXu+3VhAgSVKwjKfqgbmUhePRDmZV8gamhCheS
	 Om1PN41CN7aBJPX/jU2EoLJirjuHkauBCG0guTbYq8GaoMXYXqmFVaCsI/7Z9HvLkV
	 CIh095GHnu4dbzke+FrEtFrtJfs+TIGoWflH7JZZGokvXpght/HvMBTpSdQh3et6RH
	 4AuSNZ4kkXJUITwb8yS3dpMdt+R1o14sqC9IQNhUHk4v83pVHnkA78yczjW3C0mDjo
	 ZUS/wA6Fx88OS5DEsUUf4k3HY6WuMvY1ZBL5xlA4SIKgbDyqrwwM+Fih+RqsmAjgxU
	 JbKBln9cqBBMubqLM5TYEslcggKfAhgS8GMmIxTlty5+YgrtZdc8gwomJq/ncJL3Eg
	 taCHM6qhHa/9i4KJ5N4i2Mxbh9Fe8J2YGWK2NBObsWNMKYXs3FoAVVJUUt2gX9LHkj
	 GtzLuWjK5UjQriVHroNO0BAH4beHpBFfU6y+XXL0HspOqGltfNF6spUCz6oIh6rp97
	 ul2AVsVxc7C4Quup1Z6/k3wHOs+3O/fGXiZd2tXPaH3BJNb1IDGzhwhjFBQkLTwD3y
	 xN5IDpr2kv6l4Daj9+H2QAgY=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 68B2D40E0174;
	Sun, 31 Aug 2025 09:31:27 +0000 (UTC)
Date: Sun, 31 Aug 2025 11:31:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.17-rc4
Message-ID: <20250831093118.GAaLQWZnsa4UZdyxFs@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.17-rc4.

Thx.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc4

for you to fetch changes up to 35c23871be0072738ccc7ca00354c791711e5640:

  irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing (2025-08-24 12:54:06 +0200)

----------------------------------------------------------------
- Remove unnecessary and noisy WARN_ONs in gic-v5's init path

- Avoid a kmemleak false positive for the gic-v5's L2 IST table entries

- Fix a retval check in mvebu-gicp's probe function

- Fix a wrong conversion to guards in atmel-aic[5] irqchip

----------------------------------------------------------------
Dan Carpenter (1):
      irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check in probe()

Edgar Bonet (1):
      irqchip/atmel-aic[5]: Fix incorrect lock guard conversion

Lorenzo Pieralisi (2):
      irqchip/gic-v5: Fix kmemleak L2 IST table entries false positives
      irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing

 drivers/irqchip/irq-atmel-aic.c  | 2 +-
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 drivers/irqchip/irq-gic-v5-irs.c | 9 +++++++--
 drivers/irqchip/irq-mvebu-gicp.c | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

