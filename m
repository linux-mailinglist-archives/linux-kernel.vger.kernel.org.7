Return-Path: <linux-kernel+bounces-762220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031BB203A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D067160C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24732DECBF;
	Mon, 11 Aug 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/oxzYql";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAh/6cZb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2A2DECA1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904545; cv=none; b=l4d165BJmpnGGf+bwQV7jNTKmDCRXO/owuxJg/vUHx9acPzLqWy1+rs3RDYaQO13gjN5fIps3Dy8xb5MNdHbEDu2yHUeTQqJ5oY4cqyeJ6iEcTGHcpCPu/EZBljOFglawfmJHqnuluDflrPg3Em72pbewNuY4GgS/UC7JQ+86p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904545; c=relaxed/simple;
	bh=qj9YkYEdbOB8h+YRzo+1RlIxrE5/MHtlwX/g4CC3/Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dq6aq057N+NbL8L22uKkYNhPkPdCeBBRIXifJOqawHeDxndETG3+Yo22I35VsZA9SHOcOdmZR7Q/JUwm0fCDA9/Q9DUn0AT1b5cRxVgqnyZM7zsj+gerjj/1uhL8dykmOsIhUpOjqSPVdeirxm0fzfaZbTvP2K0an2LIMMYAFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/oxzYql; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAh/6cZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754904541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AXKzVCw7IsUb34U/kKmIY7e47KoojqYo9HB446Sbrjg=;
	b=x/oxzYqlZ+jopJclpXABwRfCmmhNSAxw/zAMigRGh/gXsH3CQ3AAgQgpMBvnGc9Wt8tEAL
	rPmpOMzzLkoMhJTH746XaQd6Qp4KNy2Flx1NiObT8MWu/F12ORjkPHuH0kHori96p1g6ea
	Ll343aYX7u7KkwdSLtQOzWYSg4q9Eu2IGKyKMmz6P0BNFv3qgwPaij0PXureexBI1zYnbV
	qNYnEyCeSma4SFLo1zH5feNR1JyGxm5NHPQAF7pBP/cj4VQ1w1aS5kOGl76h7XQNZkk6P1
	1sjEMJoocSznpnak3o9mVrymW7g8AwN8osMMeXvpyHv2SQ7jwEAZhrVAZDbQJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754904541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AXKzVCw7IsUb34U/kKmIY7e47KoojqYo9HB446Sbrjg=;
	b=nAh/6cZbbnnR1MjZsdwQK1r/HmAyyfsRbnB/eXeB6CgQp9zOYVZTtwK/kl+ajKiDSNQyRj
	9DhVImlDoky8wwDw==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/3] powerpc: Cleanup and convert to MSI parent domain
Date: Mon, 11 Aug 2025 11:28:53 +0200
Message-Id: <cover.1754903590.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial implementation of PCI/MSI interrupt domains in the hierarchical
interrupt domain model used a shortcut by providing a global PCI/MSI
domain.

This works because the PCI/MSI[X] hardware is standardized and uniform, but
it violates the basic design principle of hierarchical interrupt domains:
Each hardware block involved in the interrupt delivery chain should have a
separate interrupt domain.

For PCI/MSI[X], the interrupt controller is per PCI device and not a global
made-up entity.

Unsurprisingly, the shortcut turned out to have downsides as it does not
allow dynamic allocation of interrupt vectors after initialization and it
prevents supporting IMS on PCI. For further details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/

The solution is implementing per device MSI domains, this means the
entities which provide global PCI/MSI domain so far have to implement MSI
parent domain functionality instead.

This series:

   - Untangle XIVE driver from Powernv and Pseries drivers

   - Convert the Powernv and Pseries drivers to implement MSI parent domain
     functionality

v2: Fix up boot issue with NVMe

Nam Cao (3):
  powerpc/xive: Untangle xive from child interrupt controller drivers
  powerpc/powernv/pci: Switch to use msi_create_parent_irq_domain()
  powerpc/pseries/msi: Switch to msi_create_parent_irq_domain()

 arch/powerpc/include/asm/pci-bridge.h     |   2 -
 arch/powerpc/include/asm/xive.h           |   1 -
 arch/powerpc/platforms/powernv/Kconfig    |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  96 ++++++----------
 arch/powerpc/platforms/pseries/Kconfig    |   1 +
 arch/powerpc/platforms/pseries/msi.c      | 132 ++++++++--------------
 arch/powerpc/sysdev/xive/common.c         |  63 +++++------
 7 files changed, 117 insertions(+), 179 deletions(-)

--=20
2.39.5


