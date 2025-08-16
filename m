Return-Path: <linux-kernel+bounces-772106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750EEB28ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097FDAE0AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4B2F0C79;
	Sat, 16 Aug 2025 15:13:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5A2E2827
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357213; cv=none; b=byPTEBqCz0z3F6So7Wx1Za6ZnB6OxJFqGwMQ9UfILumBGyDUI1iyKZAwWyndMoSa/6HlOgcBKbuAMPF7VvsLJK4EjAc/oI6LVVuuqsHnlygEnob/xGMyvShCjnlCYzr2CAvNjBkM1MLqc/TnccxuDObfopST0zyV4SU+JkZJ0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357213; c=relaxed/simple;
	bh=xXodPjKWGS/zj2sqUthh2Tf25lJejU8F2i0N+o/YoOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RndwVWaa2vtZaZBFaEZ1Z9mr0AKMy3Ne6ihaKDZ+BI7lhH/AFBfD3fH6lVYCLN8lXgW4x5xUGc09AK5yTADtrNB42YNPXqF59LzVvh/KS0YxgzfFpeZvYvRI4OFOfhts79D+wfERs4xCo6PGDFMQWuezXPf0CIqpyf+HQuD3OAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ECD81688;
	Sat, 16 Aug 2025 08:13:23 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 263E93F5A1;
	Sat, 16 Aug 2025 08:13:29 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
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
Subject: [PATCH v7 0/6] support FEAT_LSUI and apply it on futex atomic ops
Date: Sat, 16 Aug 2025 16:13:20 +0100
Message-Id: <20250816151326.195587-1-yeoreum.yun@arm.com>
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

Patch #5 applies small optimisation for __llc_futex_atomic_set().

Patch #6 support futext atomic-op with FEAT_LSUI

Patch History
==============
from v6 to v7:
  - wrap FEAT_LSUI with CONFIG_AS_HAS_LSUI in cpufeature
  - remove unnecessary addition of indentation.
  - remove unnecessary mte_tco_enable()/disable() on LSUI operation.
  - https://lore.kernel.org/all/20250811163635.1562145-1-yeoreum.yun@arm.com/

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


Yeoreum Yun (6):
  arm64: cpufeature: add FEAT_LSUI
  KVM: arm64: expose FEAT_LSUI to guest
  arm64: Kconfig: add LSUI Kconfig
  arm64: futex: refactor futex atomic operation
  arm64: futex: small optimisation for __llsc_futex_atomic_set()
  arm64: futex: support futex with FEAT_LSUI

 arch/arm64/Kconfig             |   5 +
 arch/arm64/include/asm/futex.h | 291 +++++++++++++++++++++++++++------
 arch/arm64/kernel/cpufeature.c |  10 ++
 arch/arm64/kvm/sys_regs.c      |   5 +-
 arch/arm64/tools/cpucaps       |   1 +
 5 files changed, 261 insertions(+), 51 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


