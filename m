Return-Path: <linux-kernel+bounces-740804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4EB0D972
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092D6AA47E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163F2E9EC1;
	Tue, 22 Jul 2025 12:20:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8FC2E9EA6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186803; cv=none; b=gWGx/ZZGPF29/aFhoWZ2RPyqUYGiY5f1Z3oB/KPcmSig7+WG86YcwCu56706q0ZlTMT0n6WxbP+Kp+TEFYRKt0kmxn2ZClkamzqdd6RxRELjQv9liPYHgCeQTWbmftSI1GmeKEMdA5BFCm/YtLnwSbGOk7IUufZheTCr1xFqsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186803; c=relaxed/simple;
	bh=zQq5I6w9GnNq0foLoZGjoiqj702stsLEWkBgmY0Zihk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nsdx4rfM67IGrPvumbFPAnZTdIp8vPPU6VZZ6WKRCBnPF2Lx8HJWRo8Z/l1q0szdBVlqgxDE7lqu9HwEiPZPCVrMoDLo3afrgtnPCMn5biLB4JO++nqN90DeMXjZeEcf37UfHPVVbEAzFbijNK8GOMXxCVPmJPZJH/APd+wN/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28AF0152B;
	Tue, 22 Jul 2025 05:19:55 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27C7B3F59E;
	Tue, 22 Jul 2025 05:19:58 -0700 (PDT)
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
Subject: [PATCH v5 0/5] support FEAT_LSUI and apply it on futex atomic ops
Date: Tue, 22 Jul 2025 13:19:51 +0100
Message-Id: <20250722121956.1509403-1-yeoreum.yun@arm.com>
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

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


