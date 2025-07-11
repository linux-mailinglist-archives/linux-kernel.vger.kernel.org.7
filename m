Return-Path: <linux-kernel+bounces-728160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C41B02405
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305D7545CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078002FD5A9;
	Fri, 11 Jul 2025 18:39:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA362FCFC5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259141; cv=none; b=oDNYZZeLYOpB40PbMQBk4qPFXK9nY27PVcxGQ4A8IhHXyRFQAYRhWwAmBnk+Un2KfhhXY7viPb1xJZBorshFDiI1SqAptkt5rfqYm4JeqxIZ6I4NiVb/3ANOkWxM9BfxqKnwXxwe1aVaUIk9hfa+olaKE9VOUmR+v/iS4Ut141Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259141; c=relaxed/simple;
	bh=i5c6Pf7PVnhfYe8YGhJR5kvRwDoiv1B8pCUDjNVvwTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxABar+21RK1tG/HEMxg5CuPuHX5ILyFJf7hHupxm//o8RfJc2TJyF+GNw/+QFcK9IewRofeuQJRXGIKCMb/54rLSBnPYXQ4WONER7u1Sn5ecrlOsN0Jkmzvu05koEYIwi5q2wblW3bnFHijg3xaW03K5YunIrB2vr3tFrfUx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C56216F8;
	Fri, 11 Jul 2025 11:38:48 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB673F694;
	Fri, 11 Jul 2025 11:38:55 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 35/36] arm_mpam: Add kunit test for bitmap reset
Date: Fri, 11 Jul 2025 18:36:47 +0000
Message-Id: <20250711183648.30766-36-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitmap reset code has been a source of bugs. Add a unit test.

This currently has to be built in, as the rest of the driver is
builtin.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/Kconfig           | 13 ++++
 drivers/platform/arm64/mpam/mpam_devices.c    |  4 ++
 .../platform/arm64/mpam/test_mpam_devices.c   | 68 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/platform/arm64/mpam/test_mpam_devices.c

diff --git a/drivers/platform/arm64/mpam/Kconfig b/drivers/platform/arm64/mpam/Kconfig
index b63495d7da87..861e4b946ddc 100644
--- a/drivers/platform/arm64/mpam/Kconfig
+++ b/drivers/platform/arm64/mpam/Kconfig
@@ -4,7 +4,20 @@ config ARM_CPU_RESCTRL
 	bool
 	depends on ARM64
 
+menu "ARM64 MPAM driver options"
+
 config ARM64_MPAM_DRIVER_DEBUG
 	bool "Enable debug messages from the MPAM driver."
 	help
 	  Say yes here to enable debug messages from the MPAM driver.
+
+config MPAM_KUNIT_TEST
+	bool "KUnit tests for MPAM driver " if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to run tests in the MPAM driver.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 470a3709670e..a7f301b0da84 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -2904,3 +2904,7 @@ static int __init mpam_msc_driver_init(void)
 }
 /* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
 subsys_initcall(mpam_msc_driver_init);
+
+#ifdef CONFIG_MPAM_KUNIT_TEST
+#include "test_mpam_devices.c"
+#endif
diff --git a/drivers/platform/arm64/mpam/test_mpam_devices.c b/drivers/platform/arm64/mpam/test_mpam_devices.c
new file mode 100644
index 000000000000..8e9d6c88171c
--- /dev/null
+++ b/drivers/platform/arm64/mpam/test_mpam_devices.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Arm Ltd.
+/* This file is intended to be included into mpam_devices.c */
+
+#include <kunit/test.h>
+
+static void test_mpam_reset_msc_bitmap(struct kunit *test)
+{
+	char *buf = kunit_kzalloc(test, SZ_16K, GFP_KERNEL);
+	struct mpam_msc fake_msc;
+	u32 *test_result;
+
+	if (!buf)
+		return;
+
+	fake_msc.mapped_hwpage = buf;
+	fake_msc.mapped_hwpage_sz = SZ_16K;
+	cpumask_copy(&fake_msc.accessibility, cpu_possible_mask);
+
+	mutex_init(&fake_msc.part_sel_lock);
+	mutex_lock(&fake_msc.part_sel_lock);
+
+	test_result = (u32 *)(buf + MPAMCFG_CPBM);
+
+	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 0);
+	KUNIT_EXPECT_EQ(test, test_result[0], 0);
+	KUNIT_EXPECT_EQ(test, test_result[1], 0);
+	test_result[0] = 0;
+	test_result[1] = 0;
+
+	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 1);
+	KUNIT_EXPECT_EQ(test, test_result[0], 1);
+	KUNIT_EXPECT_EQ(test, test_result[1], 0);
+	test_result[0] = 0;
+	test_result[1] = 0;
+
+	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 16);
+	KUNIT_EXPECT_EQ(test, test_result[0], 0xffff);
+	KUNIT_EXPECT_EQ(test, test_result[1], 0);
+	test_result[0] = 0;
+	test_result[1] = 0;
+
+	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 32);
+	KUNIT_EXPECT_EQ(test, test_result[0], 0xffffffff);
+	KUNIT_EXPECT_EQ(test, test_result[1], 0);
+	test_result[0] = 0;
+	test_result[1] = 0;
+
+	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 33);
+	KUNIT_EXPECT_EQ(test, test_result[0], 0xffffffff);
+	KUNIT_EXPECT_EQ(test, test_result[1], 1);
+	test_result[0] = 0;
+	test_result[1] = 0;
+
+	mutex_unlock(&fake_msc.part_sel_lock);
+}
+
+static struct kunit_case mpam_devices_test_cases[] = {
+	KUNIT_CASE(test_mpam_reset_msc_bitmap),
+	{}
+};
+
+static struct kunit_suite mpam_devices_test_suite = {
+	.name = "mpam_devices_test_suite",
+	.test_cases = mpam_devices_test_cases,
+};
+
+kunit_test_suites(&mpam_devices_test_suite);
-- 
2.39.5


