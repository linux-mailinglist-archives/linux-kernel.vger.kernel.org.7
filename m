Return-Path: <linux-kernel+bounces-738921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366BEB0BF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011251884E47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDED28642A;
	Mon, 21 Jul 2025 08:36:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769B1E50B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086994; cv=none; b=FxDl+Y9pEjMHutpcJcUXyQPzWsusOA63sMZpw7N708YgXbSGM2z1/l71T5dGjWB61Ua4BdKg5mRohsdMpzD3uw4SJ1TMm+bgVN65LUxsN2BCB2vYL9lxOTsPNDNwKEWYIPbNm+RtE9Bb3r98eejO5IxHH5SC72UrTqXFlYOdLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086994; c=relaxed/simple;
	bh=/tHkE0mjZS+IAtM4087Qzco1tLdlvXSwdNZAugOPw9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hTV7HiDGDZmvj8KzR+NMQX8LbYVcFxA+hqpolFxMe48nMIn4oqLgbmreWVBTW6Lr3rK+XsK/fugwXUEqEMyzGBhrefoXKTPLkdSRKiIBABxhxJw3QT/jWpX05HUZrX5CHIRUAITkzpWc4cbnHsijbTXGEKEF4N87A1b5lSzqa2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09584153B;
	Mon, 21 Jul 2025 01:36:26 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13B2D3F66E;
	Mon, 21 Jul 2025 01:36:29 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	ardb@kernel.org,
	frederic@kernel.org,
	james.morse@arm.com,
	joey.gouly@arm.com,
	scott@os.amperecomputing.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 0/7] support FEAT_LSUI and apply it on futex atomic ops
Date: Mon, 21 Jul 2025 09:36:11 +0100
Message-Id: <20250721083618.2743569-1-yeoreum.yun@arm.com>
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

This patchset support FEAT_LUSI and applies in futex atomic operation
where can replace from ldxr/stlxr pair implmentation with clearing
PSTATE.PAN bit to correspondant load/store unprevileged atomic operation
without clearing PSTATE.PAN bit.

Patch Sequences
================

Patch #1 adds cpufeature for FEAT_LUSI

Patch #2 expose FEAT_LUSI to guest

Patch #3 adds Kconfig for FEAT_LUSI

Patch #4 separtes former futex atomic-op implmentation from futex.h
to futex_ll_sc_u.h

Patch #5 implments futex atomic operation using lsui instruction.

Patch #6 introduces lsui.h to apply runtime patch to use former
implmentation when FEAT_LUSI doesn't support.

Patch #7 applies lsui.h into arch_futext_atomic_op().

Patch History
==============
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


Yeoreum Yun (7):
  arm64: cpufeature: add FEAT_LSUI
  KVM/arm64: expose FEAT_LSUI to guest
  arm64/Kconfig: add LSUI Kconfig
  arm64/futex: move futex atomic logic with clearing PAN bit
  arm64/futex: add futex atomic operation with FEAT_LSUI
  arm64/asm: introduce lsui.h
  arm64/futex: support futex with FEAT_LSUI

 arch/arm64/Kconfig                     |   9 ++
 arch/arm64/include/asm/futex.h         |  99 ++++++-------------
 arch/arm64/include/asm/futex_ll_sc_u.h | 115 +++++++++++++++++++++
 arch/arm64/include/asm/futex_lsui.h    | 132 +++++++++++++++++++++++++
 arch/arm64/include/asm/lsui.h          |  37 +++++++
 arch/arm64/kernel/cpufeature.c         |   8 ++
 arch/arm64/kvm/sys_regs.c              |   5 +-
 arch/arm64/tools/cpucaps               |   1 +
 8 files changed, 336 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm64/include/asm/futex_ll_sc_u.h
 create mode 100644 arch/arm64/include/asm/futex_lsui.h
 create mode 100644 arch/arm64/include/asm/lsui.h

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


