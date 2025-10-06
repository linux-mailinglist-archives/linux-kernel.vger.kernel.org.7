Return-Path: <linux-kernel+bounces-842748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F5BBD75A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0761891538
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC511F4CB3;
	Mon,  6 Oct 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pR/TuOK/"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBD1F3FF8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743376; cv=none; b=Nz3iEcWe/y4UHzJxjoUTTYBmAqYKaZ/odgwVsUt6jK8FCuFcHS5BdAGIYOAb8spv/pMrEZQKonjxDb2/HgQxQngr6xR19xT+kqxiLJSLO7wZsCDY9/pCd/elFtWyT5qoEIlnvQgIOIO08thtldOVEEtdDQ+oZ92435mMVsHesx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743376; c=relaxed/simple;
	bh=3oxeDc9d7+dHtkwBHXH/UEikybnh4XqeVyaRtLhnTSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mm2SMEl2QYkcaXLY5hq7fQ9n6Ykxv+LFFS4qcEa02PMMl+8DG6I92TRBS0XaUan/gYOaN6mfNDN2hNFz3Aq+mcEBSL0tMuOHavnT5Gps9eGZMyTZnq8vg/IcMZmvf9qfXP9Uh30Cty0xLJN7rIRHXLwt6OFGYzY96ds/BwJa9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pR/TuOK/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XjIum+QqMpnb0kQoQ3QYCrvzzB3cnWXUx/4S7ppsB5w=; t=1759743374; x=1760952974; 
	b=pR/TuOK/WhQhCnMUR6ushqaDgUnDpO+n5vHvoMZ8b4k5oca0ZMfhNQArjQAKGlh5C2xQT6Q0U8Y
	yjoJ0uEyCmxoNLEO7Y3nLklIYqhv4s4/SC/p+Gg5vQydindRp/hQN56pASZC4u6aP6lFjBCeLSzwI
	NZjWEBZdVQusxUbi0psUtSjpG35srNYDpCNUR7fJ3+sPlb8kskRQoEeNHs/e9BbUQZxq5hh58Fr51
	BwyHVuJIlHIDGtWyqsDSftg3P5qLWTq+jJnU9MDPlp4d7tYRkpMlJx6nOoZQfCLuB6UO9wGA7IxQn
	vWAm3a7Yxel096M1I/elQNNPfl/jXRFKhaDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v5hdV-0000000EV8A-0Ltv;
	Mon, 06 Oct 2025 11:36:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.18-rc1
Date: Mon,  6 Oct 2025 11:34:50 +0200
Message-ID: <20251006093601.33082-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

UML doesn't have a lot of changes this time around, as you
can see in the diffstat and tag message below. I tested a
merged and booted it, there should be no conflicts.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1

for you to fetch changes up to e66ae377fe219c98d3d5b8a0d35da4413a5390ca:

  um: Remove unused ipi_pipe field from cpuinfo_um (2025-09-10 14:23:58 +0200)

----------------------------------------------------------------
updates for UML, notably
 - minor preparations for SMP support
 - SPARSE_IRQ support for kunit
 - help output cleanups

----------------------------------------------------------------
Johannes Berg (1):
      um: virtio-pci: implement .shutdown()

Sinan Nalkaya (1):
      um: Support SPARSE_IRQ

Tiwei Bie (10):
      um: Add missing trailing newline to help messages
      um: vector: Fix indentation for help message
      um: Fix help message for ssl-non-raw
      um: Indent time-travel help messages
      um: Remove unused offset and child_err fields from stub_data
      um: Remove outdated comment about STUB_DATA_PAGES
      um: Centralize stub size calculations
      um: Stop tracking virtual CPUs via mm_cpumask()
      um: Remove unused cpu_data and current_cpu_data macros
      um: Remove unused ipi_pipe field from cpuinfo_um

 arch/um/Kconfig                         |  1 +
 arch/um/drivers/ssl.c                   |  5 ++++-
 arch/um/drivers/ubd_kern.c              |  2 +-
 arch/um/drivers/vector_kern.c           |  2 +-
 arch/um/drivers/virtio_pcidev.c         |  6 ++++++
 arch/um/include/asm/mmu_context.h       | 11 ----------
 arch/um/include/asm/processor-generic.h |  3 ---
 arch/um/include/shared/as-layout.h      |  5 +++--
 arch/um/include/shared/skas/stub-data.h |  3 +--
 arch/um/kernel/dtb.c                    |  2 +-
 arch/um/kernel/irq.c                    |  5 +++++
 arch/um/kernel/time.c                   | 37 +++++++++++++++++----------------
 arch/um/kernel/um_arch.c                |  7 +------
 arch/um/os-Linux/skas/process.c         |  2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  2 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  2 +-
 16 files changed, 46 insertions(+), 49 deletions(-)

