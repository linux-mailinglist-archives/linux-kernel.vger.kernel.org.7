Return-Path: <linux-kernel+bounces-763250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C709AB21259
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E06188C432
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA32472BD;
	Mon, 11 Aug 2025 16:36:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C133214812
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930202; cv=none; b=JOoMWpIL0SEOzG+0Jh4OA4AZBs/CRzkhB6DGcC/BA6X/4qIOLvB0vQQhRETienG+ydF7drtZ+4XZDNwKb8N6sLAtOZFmPsd9nFpGxE9XXuPjA4z+vuo2Gvq7EF8xI3jkK29gtbPWe4rm1QmFEytuNVIP/r2dS6PSj2rfnfBV6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930202; c=relaxed/simple;
	bh=JRBP8zDIWqAU3V1gMYjNzlbH3Yn+OK+L1xIxtT2cwVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6U/lLCIaK3d/2EW20BTGbohSrYcETspRpAJk8QYP6GrnSNxgzpIisZ0zG+QEWMlUhevCeWSuaK+vbYtKA1kxfNxzHe7Ug/ZKtDDm7lFBhnpr1KgZuCEvNssoeqS1iC0/yWtxHe6G0Yv61/DeUr0OI5Zelhd0qa5A+I8s9C6YOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593A2113E;
	Mon, 11 Aug 2025 09:36:32 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B3CA3F738;
	Mon, 11 Aug 2025 09:36:37 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com,
	joey.gouly@arm.com,
	james.morse@arm.com,
	ardb@kernel.org,
	scott@os.amperecomputing.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 0/5] support FEAT_LSUI and apply it on futex atomic ops
Date: Mon, 11 Aug 2025 17:36:30 +0100
Message-Id: <20250811163635.1562145-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
previleged level to access to access user memory without clearing
PSTATE.PAN bit.

This patchset support FEAT_LSUI and applies in futex atomic operation
where can replace from ldxr/stlxr pair implmentation with clearing
PSTATE.PAN bit to correspondant load/store unprevileged atomic operation
without clearing PSTATE.PAN bit.

Patch Sequences
================

Patch #1 adds cpufeature for FEAT_LSUI

Patch #2 expose FEAT_LSUI to guest

Patch #3 adds Kconfig for FEAT_LSUI

Patch #4 refactor former futex atomic-op implmentation with ll/sc &
         clearing PSTATE.PAN

Patch #5 support futext atomic-op with FEAT_LSUI

Patch History
==============
from v5 to v6:
  - rebase to v6.17-rc1
  - https://lore.kernel.org/all/20250722121956.1509403-1-yeoreum.yun@arm.com/

from v4 to v5:
  - remove futex_ll_sc.h futext_lsui and lsui.h and move them to futex.h
  - reorganize the patches.
  - https://lore.kernel.org/all/20250721083618.2743569-1-yeoreum.yun@arm.com/

from v3 to v4:
  - rebase to v6.16-rc7
  - modify some patch's title.
  - https://lore.kernel.org/all/20250617183635.1266015-1-yeoreum.yun@arm.com/

from v2 to v3:
  - expose FEAT_LUSI to guest
  - add help section for LUSI Kconfig
  - https://lore.kernel.org/all/20250611151154.46362-1-yeoreum.yun@arm.com/

from v1 to v2:
  - remove empty v9.6 menu entry
  - locate HAS_LUSI in cpucaps in order
  - https://lore.kernel.org/all/20250611104916.10636-1-yeoreum.yun@arm.com/


Yeoreum Yun (5):
  arm64: cpufeature: add FEAT_LSUI
  KVM: arm64: expose FEAT_LSUI to guest
  arm64: Kconfig: add LSUI Kconfig
  arm64: futex: refactor futex atomic operation
  arm64: futex: support futex with FEAT_LSUI

 arch/arm64/Kconfig             |   5 +
 arch/arm64/include/asm/futex.h | 323 +++++++++++++++++++++++++++------
 arch/arm64/kernel/cpufeature.c |   8 +
 arch/arm64/kvm/sys_regs.c      |   5 +-
 arch/arm64/tools/cpucaps       |   1 +
 5 files changed, 281 insertions(+), 61 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


