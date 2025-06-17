Return-Path: <linux-kernel+bounces-689848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C76AADC736
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 11:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4EB3AE2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9172C1588;
	Tue, 17 Jun 2025 09:51:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592C2C08D3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153880; cv=none; b=litqR4CUFQbaBh3X0JuphQY0SoPCfYJCdHHIZz0cc7p2S941NYOhmlsSIfL6q/aKd5xKjDn92hwknuXTLXMQ4dR++XZAAqjw97ddv6gX74rOmYcyMF7dvoHHLDbUEAw+dQtoRfVTOzRvJO5pHC0HDyleNwE0ZO3HoFX0LBseNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153880; c=relaxed/simple;
	bh=19BWeT1l3twLQbgUh0QlC1Bw0/SsCaY+KVVp2+1hOP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSvimTzhQWX1nfHbas2Ew8qmtRM8zDD172pxUSq0sp6Q+IQUX7WdPbd8nj6HhvjoFq1zV57DM25XSyeQVo6r8viACJ4+xZtEkdMlNylsimKUE9fANP0iQ78lkhvGUIdKHxIC9QqmEOhwa8MO4Vv+XQ5rnep/oo6RXFPcfPeX92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2795D1596;
	Tue, 17 Jun 2025 02:50:56 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5683F58B;
	Tue, 17 Jun 2025 02:51:13 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v7 0/4] Initial BBML2 support for contpte_convert()
Date: Tue, 17 Jun 2025 09:51:00 +0000
Message-ID: <20250617095104.6772-1-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series extends the cpufeature framework to add support for
easily matching against all early cpus, and builds on this to add initial
support for eliding Break-Before-Make requirements on systems that support
BBML2 and additionally guarantee to never raise a conflict abort.

This support reorders and elides both a TLB invalidation and a DSB in
contpte_convert(), when BBML2 is supported. This leads to a 12%
improvement when executing a microbenchmark designed to force the
pathological path where contpte_convert() gets called. This represents
an 80% reduction in the cost of calling contpte_convert().

We clarify both the correctness and performance benefits of this elision
with respect to the relevant Arm ARM passages, via substantial comments
in the contpte_convert() source.

This series is based on v6.16-rc2 (e04c78d86a96).

Notes
======

Patch 1 extends the cpufeature framework machinery as discussed in [1],
to allows checking for the presence of a feature on all early boot cpus
(and on all late cpus when they are brought online).

Patch 2 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Patch 2 implements a MIDR check but does not implement a AA64_ID_MMFR2
check, as the BBML2_NOABORT MIDR check is a strict superset of the feature
register check (all platforms that pass the MIDR check will also pass the
feature register check).

Yang Shi has a series at [2] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We believe this series is fully compatible with Yang's
requirements and could go first.

[1]:
  https://lore.kernel.org/all/aCSHESk1DzShD4vt@arm.com/

[2]:
  https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/

Changelog
=========

v7:
  - fix up some minor spelling and formatting nits
  - integrate cpufeature framework patch to each bbml2 detection
  - avoid making feature register check, rely on MIDR check
  - rebase onto v6.16-rc2

v6:
  - https://lore.kernel.org/all/20250428153514.55772-2-miko.lenczewski@arm.com/
  - clarify correctness and performance of elision of __tlb_flush_range()
  - rebase onto v6.15-rc3

v5:
  - https://lore.kernel.org/all/20250325093625.55184-1-miko.lenczewski@arm.com/
  - fixup coding style nits
  - document motivation for kernel commandline parameter

v4:
  - https://lore.kernel.org/all/20250319150533.37440-2-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc5
  - switch from arm64 sw feature override to hw feature override
  - reintroduce has_cpuid_feature() check in addition to MIDR check

v3:
  - https://lore.kernel.org/all/20250313104111.24196-2-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc4
  - add arm64.nobbml2 commandline override
  - squash "delay tlbi" and "elide tlbi" patches

v2:
  - https://lore.kernel.org/all/20250228182403.6269-2-miko.lenczewski@arm.com/
  - fix buggy MIDR check to properly account for all boot+late cpus
  - add smmu bbml2 feature check

v1:
  - https://lore.kernel.org/all/20250219143837.44277-3-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc3
  - remove kvm bugfix patches from series
  - strip out conflict abort handler code
  - switch from blocklist to allowlist of bmml2+noabort implementations
  - remove has_cpuid_feature() in favour of MIDR check

rfc-v1:
  - https://lore.kernel.org/all/20241211154611.40395-1-miko.lenczewski@arm.com/
  - https://lore.kernel.org/all/20241211160218.41404-1-miko.lenczewski@arm.com/

Catalin Marinas (1):
  arm64: cpufeature: Introduce MATCH_ALL_EARLY_CPUS capability type

Mikołaj Lenczewski (3):
  arm64: Add BBM Level 2 cpu feature
  iommu/arm: Add BBM Level 2 smmu feature
  arm64/mm: Elide tlbi in contpte_convert() under BBML2

 arch/arm64/include/asm/cpufeature.h           |  28 ++++
 arch/arm64/kernel/cpufeature.c                | 100 +++++++++++--
 arch/arm64/mm/contpte.c                       | 139 +++++++++++++++++-
 arch/arm64/tools/cpucaps                      |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +
 7 files changed, 264 insertions(+), 12 deletions(-)

-- 
2.49.0


