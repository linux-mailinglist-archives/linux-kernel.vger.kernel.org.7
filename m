Return-Path: <linux-kernel+bounces-761208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95531B1F5C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5803BC109
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21832274B44;
	Sat,  9 Aug 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c2NsZUvZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241F263C9F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754763776; cv=none; b=C9TFaciu3Duq/c6Oq9rSUPMR72RrO1Z6tKfiAIgp04U0lLIBS2/yHfCT63vVeOdyoOO1uQcxrZpGqN69gs9Dxlsy/e+6QXLWEqUmdg6tCv0MPPDvsT8dAmX9tFSbVRZ6vusdyABPKrYTNpf4oZpjMOK/PrP/YpUBpam7ybHX/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754763776; c=relaxed/simple;
	bh=pTpqOtc2j+f3D/BOlYRu1KpjwnWfGNJ7ew8bm39Vfi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a3NlSngyg2cqUkCCI6GXJb1a42qGOpWhOJzbneYVX1SvDU0wBOi0Ar4jZgOuCiF6gQiJFEgDYOL4PBfmebSPcdYWQ2J4NSNMa0wxtXwmVQuife5jdM9x+zj7jMdelL4tcAnQY5cR9ic2AjDXvlWrFGCwTmrhcYdQgLhQG6Hr6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c2NsZUvZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8241940E0191;
	Sat,  9 Aug 2025 18:22:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9WWnsssNoVp0; Sat,  9 Aug 2025 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754763769; bh=cbuDFYxAA8WsHA9AbXezXkVT0zhXB75exnCXpa7knPg=;
	h=Date:From:To:Cc:Subject:From;
	b=c2NsZUvZkG90BsGgt8mm0kxrLFZcvVd1QAAPNrjLb1F/pTk/LxmH6995HaPgkhmx5
	 VeNGVMLIyEVuCd7UeuCXQ321C8y0ZxvvgDB6Nq7IvOjNZ0UOfeyUcFZnuSMf4XTWbL
	 lhgGbgu/DFYHZbjloJxOWaC909HPFzvY5wM3K8aRpm5IjSR4xAtF57i0I/E+nxwLZm
	 DcO9VRw5VKumj9q8+HKop91aEL8u2iGqADPWiIfcAeD+L60evLKETz+VTzzgYCzWJi
	 uyHvhp/Ca8+pBwDVo4a9Gy3r9L+JO9JnMhcNmhH9XbQ+NWMYUjgD9szdVahXIeKI8S
	 ART9Z0T8+gMxHYS5eQ0YEF7da8dLq7vlwoTj45RWQK8K040+4RN/6xIF1sjGHKkpur
	 h0kpw4hZF08RORnGFjfKOFRQ+aEEwseZ557r0AbheFLye8hP4QmiEipq3wyjP0fWRa
	 s1Ie3sDGVZA6K4JWcQJwrzJ8x2+n6j7qY2FNzcbKnUtq/5CMzKnE27Bo6DSjR8TNKE
	 NnM0Jt0Duw/4tm3oNL1UkIECvDaUdFlTKacJGY7bZhgYVMZAQg9EMOVuYYi+3bFB5Z
	 Bfuy9Ndhgksdm19RwRZ2p0r4+0cik3+TjgBv3YhNsUZacaHFCrYuDUqWa9QwnT9s/u
	 83RHdn+jCTA0bMxeA0WqxHj0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04B3740E00DC;
	Sat,  9 Aug 2025 18:22:45 +0000 (UTC)
Date: Sat, 9 Aug 2025 20:22:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.17-rc1
Message-ID: <20250809182238.GAaJeR7vm8fTw4FPEr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.17-rc1.

Thx.

---

The following changes since commit 7e161a991ea71e6ec526abc8f40c6852ebe3d946:

  Merge tag 'i2c-for-6.17-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2025-08-04 16:37:29 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc1

for you to fetch changes up to 9f7488f24c7571d349d938061e0ede7a39b65d6b:

  irqchip/mvebu-gicp: Use resource_size() for ioremap() (2025-08-06 17:00:40 +0200)

----------------------------------------------------------------
- Fix a wrong ioremap size in mvebu-gicp

- Remove yet another compile-test case for a driver which needs an
  additional dependency

- Fix a lock inversion scenario in the IRQ unit test suite

- Remove an impossible flag situation in gic-v5

- Do not iounmap resources in gic-v5 which are managed by devm

- Make sure stale, left-over interrupts in mvebu-gicp are cleared on
  driver init

- Fix a reference counting mishap in msi-lib

- Fix a dereference-before-null-ptr-check case in the riscv-imsic
  irqchip driver

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip: Build IMX_MU_MSI only on ARM

Brian Norris (1):
      genirq/test: Resolve irq lock inversion warnings

Elad Nachman (1):
      irqchip/mvebu-gicp: Clear pending interrupts on init

Lorenzo Pieralisi (3):
      irqchip/msi-lib: Fix fwnode refcount in msi_lib_irq_domain_select()
      irqchip/gic-v5: iwb: Fix iounmap probe failure path
      irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS for ITS IRQs

Thomas Gleixner (2):
      irqchip/riscv-imsic: Don't dereference before NULL pointer check
      irqchip/mvebu-gicp: Use resource_size() for ioremap()

 drivers/irqchip/Kconfig                    |  1 +
 drivers/irqchip/irq-gic-v5-its.c           |  1 -
 drivers/irqchip/irq-gic-v5-iwb.c           | 11 ++---------
 drivers/irqchip/irq-msi-lib.c              |  6 +++---
 drivers/irqchip/irq-mvebu-gicp.c           | 10 ++++++++++
 drivers/irqchip/irq-riscv-imsic-platform.c |  2 +-
 kernel/irq/irq_test.c                      |  4 +++-
 7 files changed, 20 insertions(+), 15 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

