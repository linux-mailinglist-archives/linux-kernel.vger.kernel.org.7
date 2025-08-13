Return-Path: <linux-kernel+bounces-767300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E1B25296
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223E717C47F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955312309B3;
	Wed, 13 Aug 2025 17:53:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867D214232;
	Wed, 13 Aug 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107624; cv=none; b=DEY43LqRd1GUjiyY4DqiE1A0YxEV5agRiP1guFHqo9i/YM4VjnYhUR4p7r9aJwGWDo2pIvQlno6wAY2TdQmDI8E8451gX9SCmCP3WSit+6Jv40hEpcqjg2j28IHuupw1ro0dnETktWuYAxyp+OwSjO164l8uGQL1Waa/o+iIkxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107624; c=relaxed/simple;
	bh=rqm8YhfoDu+gYeoQgniIzuJQxhpMYSxEL81Z/EUaH3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yqis5sXWmPj3rHYqLjgYTro82A9oK5ETKWmIKuDYd8mTDNmrbtjy5PIwfA+aBvbZPiOKGMESt1zBuB/e6SL77V7BQRpQE8/IISx+A572QEuLEl3I+kUa8uW85yVcNGfPagINpSXrFmSwp01wEyQz9P/qaEF10uwHNJi3VN8g6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3F212FC;
	Wed, 13 Aug 2025 10:53:33 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C05D3F5A1;
	Wed, 13 Aug 2025 10:53:37 -0700 (PDT)
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
Subject: [PATCH v2 0/2] introduce kasan.store_only option in hw-tags
Date: Wed, 13 Aug 2025 18:53:33 +0100
Message-Id: <20250813175335.3980268-1-yeoreum.yun@arm.com>
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

Using this feature (FEAT_MTE_STORE_ONLY), introduce KASAN store-only mode
which restricts KASAN check store operation only.
This mode omits KASAN check for fetch/load operation.
Therefore, it might be used not only debugging purpose but also in
normal environment.

Patch History
=============
from v1 to v2:
  - change cryptic name -- stonly to store_only
  - remove some TCF check with store which can make memory courruption.
  - https://lore.kernel.org/all/20250811173626.1878783-1-yeoreum.yun@arm.com/


Yeoreum Yun (2):
  kasan/hw-tags: introduce kasan.store_only option
  kasan: apply store-only mode in kasan kunit testcases

 Documentation/dev-tools/kasan.rst  |   3 +
 arch/arm64/include/asm/memory.h    |   1 +
 arch/arm64/include/asm/mte-kasan.h |   6 +
 arch/arm64/kernel/cpufeature.c     |   6 +
 arch/arm64/kernel/mte.c            |  14 ++
 include/linux/kasan.h              |   2 +
 mm/kasan/hw_tags.c                 |  76 +++++-
 mm/kasan/kasan.h                   |  10 +
 mm/kasan/kasan_test_c.c            | 366 ++++++++++++++++++++++-------
 9 files changed, 402 insertions(+), 82 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


