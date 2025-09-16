Return-Path: <linux-kernel+bounces-819696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E51B7DE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C446270D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7A328588;
	Tue, 16 Sep 2025 22:28:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0A2F9DB8;
	Tue, 16 Sep 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061686; cv=none; b=T+l2kyApoC1QSRVeRuHaIMcvExkr5s+jyW0TtMV22nI6RCbE6vzjobK1o9rljKfVlvkLNj8tIC4yBEHplklN5+UiNUcLut2KmPDeRYnoQv/2q6S65FANs1eWe4btT4kjXvEP55bPvMtNyKmeYphdRS/c6Ser06urELiqR/knyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061686; c=relaxed/simple;
	bh=OnlJ98DJmCrqKhRxQ92Dvr87NADcGzpz+7495TFSHPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJQveLnWdBraWlJdqxs6yXotGDuvJcUJ77em6yz+C+pBtCAf1Za1hzr54LgYEhfDewtXib3Q6wT7pFUbS9puE95OobrXXC1vxaYbmaN9ogBXyAEsnVroznWGI4WKmcDN31p2jIibetgV4cV5IBBDNNjRHHySwcNk1X0/xLtGegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909E212FC;
	Tue, 16 Sep 2025 15:27:53 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3F533F673;
	Tue, 16 Sep 2025 15:27:57 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	scott@os.amperecomputing.com,
	jhubbard@nvidia.com,
	pankaj.gupta@amd.com,
	leitao@debian.org,
	kaleshsingh@google.com,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io,
	david@redhat.com,
	yang@os.amperecomputing.com
Cc: kasan-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v8 0/2] introduce kasan.write_only option in hw-tags
Date: Tue, 16 Sep 2025 23:27:53 +0100
Message-Id: <20250916222755.466009-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware tag based KASAN is implemented using the Memory Tagging Extension
(MTE) feature.

MTE is built on top of the ARMv8.0 virtual address tagging TBI
(Top Byte Ignore) feature and allows software to access a 4-bit
allocation tag for each 16-byte granule in the physical address space.
A logical tag is derived from bits 59-56 of the virtual
address used for the memory access. A CPU with MTE enabled will compare
the logical tag against the allocation tag and potentially raise an
tag check fault on mismatch, subject to system registers configuration.

Since ARMv8.9, FEAT_MTE_STORE_ONLY can be used to restrict raise of tag
check fault on store operation only.

Using this feature (FEAT_MTE_STORE_ONLY), introduce KASAN write-only mode
which restricts KASAN check write (store) operation only.
This mode omits KASAN check for read (fetch/load) operation.
Therefore, it might be used not only debugging purpose but also in
normal environment.

This patch is based on v6.17-rc4.

Patch History
=============
from v7 to v8:
  - remove useless kasan_arg_write_only and integrate it with
    kasan_flag_write_only.
  - rebased to v6.17-rc6.
  - https://lore.kernel.org/all/20250903150020.1131840-1-yeoreum.yun@arm.com/

from v6 to v7:
  - modify some comments on KASAN kunit test.
  - rebased to v6.17-rc4.
  - https://lore.kernel.org/all/20250901104623.402172-1-yeoreum.yun@arm.com/

from v5 to v6:
  - change macro name for KASAN kunit test.
  - remove and restore useless line adding/removal.
  - modify some comments on KASAN kunit test.
  - https://lore.kernel.org/all/20250820071243.1567338-1-yeoreum.yun@arm.com/

from v4 to v5:
  - fix wrong allocation
  - add small comments
  - https://lore.kernel.org/all/20250818075051.996764-1-yeoreum.yun@arm.com/

from v3 to v4:
  - fix wrong condition
  - https://lore.kernel.org/all/20250816110018.4055617-1-yeoreum.yun@arm.com/

from v2 to v3:
  - change MTE_STORE_ONLY feature as BOOT_CPU_FEATURE
  - change store_only to write_only
  - move write_only setup into the place other option's setup place
  - change static key of kasan_flag_write_only to static boolean.
  - change macro KUNIT_EXPECT_KASAN_SUCCESS to KUNIT_EXPECT_KASAN_FAIL_READ.
  - https://lore.kernel.org/all/20250813175335.3980268-1-yeoreum.yun@arm.com/

from v1 to v2:
  - change cryptic name -- stonly to store_only
  - remove some TCF check with store which can make memory courruption.
  - https://lore.kernel.org/all/20250811173626.1878783-1-yeoreum.yun@arm.com/


Yeoreum Yun (2):
  kasan/hw-tags: introduce kasan.write_only option
  kasan: apply write-only mode in kasan kunit testcases

 Documentation/dev-tools/kasan.rst  |   3 +
 arch/arm64/include/asm/memory.h    |   1 +
 arch/arm64/include/asm/mte-kasan.h |   6 +
 arch/arm64/kernel/cpufeature.c     |   2 +-
 arch/arm64/kernel/mte.c            |  18 +++
 mm/kasan/hw_tags.c                 |  45 ++++++-
 mm/kasan/kasan.h                   |   7 +
 mm/kasan/kasan_test_c.c            | 205 +++++++++++++++++++----------
 8 files changed, 215 insertions(+), 72 deletions(-)


base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


