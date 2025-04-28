Return-Path: <linux-kernel+bounces-623358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997EA9F49F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C93B4050
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906225C6FF;
	Mon, 28 Apr 2025 15:36:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE61E008B;
	Mon, 28 Apr 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854578; cv=none; b=LAa135IOF8HDGq3OWYVY3EP6Ph90xv8wAX7Sg1I+5iVr69LWu3KGvFt9UhD1cMkwOOFFPqNtYSUfYwPhamwUuTyeTW8ljWSmFakZnRc2NR5pAEDAcDFJNBYcpJjwyvFaA+436stnVjWFvsxdGl2IAer52y3C4lWqo0KSxMjTWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854578; c=relaxed/simple;
	bh=0l9dI7M8qx7oSnZvluNIbOgdc4+hwl5omhl0ehfQ9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AA87I9F74laS4OdJ/0ExZznCwXMVDMICXTOiKaLmFZ4pcDApOvr6NCA7L2o4S0m+z8EQmGGLR57noBfxDcLANUSOC+kiyC7+f6ulNiuPMqqxM4BoWAeh3+unUy4nJmlyebElaOaD4re/imcimbRg9WoUkr86NcDztuE64fiODYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739BF1516;
	Mon, 28 Apr 2025 08:36:08 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FE33F673;
	Mon, 28 Apr 2025 08:36:10 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	baohua@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	kevin.tian@intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [RESEND PATCH v6 0/3] Initial BBML2 support for contpte_convert()
Date: Mon, 28 Apr 2025 15:35:12 +0000
Message-ID: <20250428153514.55772-2-miko.lenczewski@arm.com>
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

This patch series adds initial support for eliding Break-Before-Make
requirements on systems that support BBML2 and additionally guarantee
to never raise a conflict abort.

This support reorders and elides both a TLB invalidation and a DSB in
contpte_convert(), when BBML2 is supported. This leads to a 12%
improvement when executing a microbenchmark designed to force the
pathological path where contpte_convert() gets called. This represents
an 80% reduction in the cost of calling contpte_convert().

We clarify both the correctness and performance benefits of this elision
with respect to the relevant Arm ARM passages, via substantial comments
in the contpte_convert() source.

This series is based on v6.15-rc3 (9c32cda43eb7).

Notes
======

Patch 1 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Yang Shi has a series at [1] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We believe this series is fully compatible with Yang's
requirements and could go first.

Due to constraints with the current design of the cpufeature framework
and the fact that our has_bbml2_noabort() check relies on both a MIDR
allowlist and the exposed MMFR2 register value, if an implementation
supports our desired BBML2+NOABORT semantics but fails to declare
support for BBML2 via the id_aa64mmfr2.bbm field, the check will fail.

Not declaring base support for BBML2 when supporting BBML2+NOABORT
should be considered an erratum [2], and a workaround can be applied in
__cpuinfo_store_cpu() to patch in support for BBML2 for the sanitised
register view used by SCOPE_SYSTEM. However, SCOPE_LOCAL_CPU bypasses
this sanitised view and reads the MSRs directly by design, and so an
additional workaround can be applied in __read_sysreg_by_encoding()
for the MMFR2 case.

For situations where support for BBML2+NOABORT is claimed by an
implementor and subsequently built into the kernel, but problems later
arise that require user damage control [3], we introduce a kernel
commandline parameter override for disabling all BBML2 support.

[1]:
  https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/

[2]:
  https://lore.kernel.org/linux-arm-kernel/3bba7adb-392b-4024-984f-b6f0f0f88629@arm.com/

[3]:
  https://lore.kernel.org/all/0ac0f1f5-e4a0-46ae-8ea0-2eba7e21a7e1@arm.com/

Changelog
=========

v6:
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

Mikołaj Lenczewski (3):
  arm64: Add BBM Level 2 cpu feature
  iommu/arm: Add BBM Level 2 smmu feature
  arm64/mm: Elide tlbi in contpte_convert() under BBML2

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/arm64/Kconfig                            |  19 +++
 arch/arm64/include/asm/cpucaps.h              |   2 +
 arch/arm64/include/asm/cpufeature.h           |   5 +
 arch/arm64/kernel/cpufeature.c                |  71 +++++++++
 arch/arm64/kernel/pi/idreg-override.c         |   2 +
 arch/arm64/mm/contpte.c                       | 139 +++++++++++++++++-
 arch/arm64/tools/cpucaps                      |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +
 11 files changed, 251 insertions(+), 1 deletion(-)

-- 
2.49.0


