Return-Path: <linux-kernel+bounces-728128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F143FB023E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5550B47498
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF82F509B;
	Fri, 11 Jul 2025 18:37:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF92F50A6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259055; cv=none; b=NrMdGAIsU6gvlg3NsDRnqlAzTwpDTGYNo92FJUx90qjXdx/+flxzAeB+8JhtHLx5f5PbiNLkYiPZ251GqilTXQ8JzQfL0GpCnsHodgMxUujEUGZ0pvR9fOhK/v+aaOLg1wLZyUsa9lAkMp96Pqh3kq17ZNzZYX3HkdcKUPbnGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259055; c=relaxed/simple;
	bh=fB/Mac7dloTJr+URythrGwfMFmVqdLQ+Qxj5a4PU3mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQVfBvz/p8gEs1xOYaKXY/oppYJfzPUdgSRSOCPPsqHrKDtWdKlOAe3/3CUz+tq77WQsxBP2d8SUTNA75MHEpqlPtFbgzKTxhDJPaLvjVQWAyQkhy/zjWMxQxzzRmxPS8iAfrOXOkdD7i7nqCW7PIIQp4+7bDxmI3fxWMJFaTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBFB12247;
	Fri, 11 Jul 2025 11:37:22 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85B573F694;
	Fri, 11 Jul 2025 11:37:30 -0700 (PDT)
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
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 09/36] arm64: kconfig: Add Kconfig entry for MPAM
Date: Fri, 11 Jul 2025 18:36:21 +0000
Message-Id: <20250711183648.30766-10-james.morse@arm.com>
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

The bulk of the MPAM driver lives outside the arch code because it
largely manages MMIO devices that generate interrupts. The driver
needs a Kconfig symbol to enable it, as MPAM is only found on arm64
platforms, that is where the Kconfig option makes the most sense.

This Kconfig option will later be used by the arch code to enable
or disable the MPAM context-switch code, and registering the CPUs
properties with the MPAM driver.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331af337..5f08214537d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2058,6 +2058,23 @@ config ARM64_TLB_RANGE
 	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
 	  range of input addresses.
 
+config ARM64_MPAM
+	bool "Enable support for MPAM"
+	help
+	  Memory Partitioning and Monitoring is an optional extension
+	  that allows the CPUs to mark load and store transactions with
+	  labels for partition-id and performance-monitoring-group.
+	  System components, such as the caches, can use the partition-id
+	  to apply a performance policy. MPAM monitors can use the
+	  partition-id and performance-monitoring-group to measure the
+	  cache occupancy or data throughput.
+
+	  Use of this extension requires CPU support, support in the
+	  memory system components (MSC), and a description from firmware
+	  of where the MSC are in the address space.
+
+	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
-- 
2.39.5


