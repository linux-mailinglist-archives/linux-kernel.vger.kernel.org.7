Return-Path: <linux-kernel+bounces-749582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96132B15043
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6497A4307
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBE293C73;
	Tue, 29 Jul 2025 15:38:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB3293C77
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803513; cv=none; b=k38BlyNIdjiOdWkZUQkEV4M0Q4LX5Nle0nnm6sOcwIJ8EidzSYbmzXWVwfY9YUA3hizzPAaSx9Ipzl42fjf7MNcKIUPmr2IKMXXAqaqpVZ+jdjvSh3fVcRKzxM59p0B7BqvklV8gbOrgZ0MHia8Cga0nDpZ7xFKkC2Zr0V0j/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803513; c=relaxed/simple;
	bh=KJzheRQfyRAydciUNWS2xsbioY0FAmSaFYrR9j6Q/EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X70lGF8euzM9nSks8UKXcXrW42xRhkcN05eg9qlp/6sXX4SXOctSCbC2kuRBs/3m8grCdyMMN4MBIpt9Z9ZN57Xi5Z/1n2+nFdXWjMrTfo8mj9mQz7wqRL+LisKu6/NkSyhQmV2ZtJoKCukG+FD8xU/umxK2PfozJWFOf/K2W1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4brzvq2FLVz23jcW;
	Tue, 29 Jul 2025 23:36:07 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 31C2B1A016C;
	Tue, 29 Jul 2025 23:38:28 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:27 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 23:38:27 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<wangyushan12@huawei.com>
Subject: [PATCH 8/8] Documentation: hisi-pmu: Add introduction to HiSilicon V3 PMU
Date: Tue, 29 Jul 2025 23:38:23 +0800
Message-ID: <20250729153823.2026154-9-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250729153823.2026154-1-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
job of monitoring specific parts of a device.  Add description on that
as well as the newly added ext operand for L3C PMU.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst | 43 +++++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index 48992a0b8e94..4c7584fe3c1a 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -12,15 +12,16 @@ The HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
 called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
 two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
 
-HiSilicon SoC uncore PMU driver
--------------------------------
+HiSilicon SoC uncore PMU v1
+---------------------------
 
 Each device PMU has separate registers for event counting, control and
 interrupt, and the PMU driver shall register perf PMU drivers like L3C,
 HHA and DDRC etc. The available events and configuration options shall
-be described in the sysfs, see:
+be described in the sysfs, see::
+
+/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>
 
-/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.
 The "perf list" command shall list the available events from sysfs.
 
 Each L3C, HHA and DDRC is registered as a separate PMU with perf. The PMU
@@ -55,6 +56,9 @@ Example usage of perf::
   $# perf stat -a -e hisi_sccl3_l3c0/rd_hit_cpipe/ sleep 5
   $# perf stat -a -e hisi_sccl3_l3c0/config=0x02/ sleep 5
 
+HiSilicon SoC uncore PMU v2
+----------------------------------
+
 For HiSilicon uncore PMU v2 whose identifier is 0x30, the topology is the same
 as PMU v1, but some new functions are added to the hardware.
 
@@ -112,6 +116,37 @@ uring channel. It is 2 bits. Some important codes are as follows:
 - 2'b00: default value, count the events which sent to the both uring and
   uring_ext channel;
 
+HiSilicon SoC uncore PMU v3
+----------------------------------
+
+For HiSilicon uncore PMU v3 whose identifier is 0x40, some uncore PMUs are
+further divided into parts for finer granularity of tracing, each part has its
+own dedicated PMU, and all such PMUs together cover the monitoring job of events
+on particular uncore device. Such PMUs are described in sysfs with name format
+slightly changed::
+
+/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}_{Z}/ddrc{Y}_{Z}/noc{Y}_{Z}>
+
+Z is the sub-id, indicating different PMUs for part of hardware device.
+
+Usage of most PMUs with different sub-ids are identical. Specially, L3C PMU
+provides ``ext`` operand to allow exploration of even finer granual statistics
+of L3C PMU, L3C PMU driver use that as hint of termination when delivering perf
+command to hardware:
+
+- ext=0: Default, could be used with event names.
+- ext=1 and ext=2: Must be used with event codes, event names are not supported.
+
+An example of perf command could be::
+
+  $# perf stat -a -e hisi_sccl0_l3c1_0/event=0x1,ext=1/ sleep 5
+
+or::
+
+  $# perf stat -a -e hisi_sccl0_l3c1_0/rd_spipe/ sleep 5
+
+As above, ``hisi_sccl0_l3c1_0`` locates PMU on CPU cluster 0, L3 cache 1 pipe0.
+
 Users could configure IDs to count data come from specific CCL/ICL, by setting
 srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
 tgtid_cmd & tgtid_msk. A set bit in srcid_msk/tgtid_msk means the PMU will not
-- 
2.33.0


