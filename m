Return-Path: <linux-kernel+bounces-890368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F645C3FEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA53BF4A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FDE2F39D7;
	Fri,  7 Nov 2025 12:36:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A326B0B3;
	Fri,  7 Nov 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518961; cv=none; b=PdbKqK+AKG5vq7luLLS/Pzp5lpWn2lcDzYOoNIATIGmp6bxdSPKOef/fMFqgfY+7x8HZ2ExSbnP6C2ihnbAgB6fNcAvPKSHfnwtXBEx6IG3AnCex5AxvJIigVxUh6DwmoWOqbFkrMakSDMzGdJ8dmqFKGeEdLTihlXj4lNBAalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518961; c=relaxed/simple;
	bh=tkMISjroAyeOX4TIXg+1sdubs6dtZebTDhGa4qUvm5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyWXOtML21vSNykDmlQc5V0vBqbKSMNbUBYXwkfnY+0um8BvhhfRSMG/VZ/e8a3kcDRitkcrhnm45GlApqy3jcJJIo+4gku98K4c+WWQGOkB4saalBsWmGTjJytLz5n9I3ybpXVOLVm951AaIIKtPHgDmv2ECNhWk0P+JCvXkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB7A1A00;
	Fri,  7 Nov 2025 04:35:51 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94EC53F66E;
	Fri,  7 Nov 2025 04:35:54 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH 06/33] arm64: kconfig: Add Kconfig entry for MPAM
Date: Fri,  7 Nov 2025 12:34:23 +0000
Message-ID: <20251107123450.664001-7-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

The bulk of the MPAM driver lives outside the arch code because it
largely manages MMIO devices that generate interrupts. The driver
needs a Kconfig symbol to enable it. As MPAM is only found on arm64
platforms, the arm64 tree is the most natural home for the Kconfig
option.

This Kconfig option will later be used by the arch code to enable
or disable the MPAM context-switch code, and to register properties
of CPUs with the MPAM driver.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
CC: Dave Martin <dave.martin@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 arch/arm64/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..67015d51f7b5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2023,6 +2023,29 @@ config ARM64_TLB_RANGE
 	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
 	  range of input addresses.
 
+config ARM64_MPAM
+	bool "Enable support for MPAM"
+	help
+	  Memory System Resource Partitioning and Monitoring (MPAM) is an
+	  optional extension to the Arm architecture that allows each
+	  transaction issued to the memory system to be labelled with a
+	  Partition identifier (PARTID) and Performance Monitoring Group
+	  identifier (PMG).
+
+	  Memory system components, such as the caches, can be configured with
+	  policies to control how much of various physical resources (such as
+	  memory bandwidth or cache memory) the transactions labelled with each
+	  PARTID can consume.  Depending on the capabilities of the hardware,
+	  the PARTID and PMG can also be used as filtering criteria to measure
+	  the memory system resource consumption of different parts of a
+	  workload.
+
+	  Use of this extension requires CPU support, support in the
+	  Memory System Components (MSC), and a description from firmware
+	  of where the MSCs are in the address space.
+
+	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
-- 
2.43.0


