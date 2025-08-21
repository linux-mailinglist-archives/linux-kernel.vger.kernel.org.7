Return-Path: <linux-kernel+bounces-779956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB53B2FB80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4155F1C84B60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882782F616B;
	Thu, 21 Aug 2025 13:51:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD82367CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784260; cv=none; b=slzx8+nKrAeoB9ttD2QoEDtklUn56B+FtXVhV8cPqv3ers6tqJ6wHTp33PYeI+wrRLsMmSm0QmaAkW4UW+61okOohGqCmDs7ajivJ05HB7VQDh8lwPeOoAzr8UARgQH/F4qy4AV93MgsfbLJYIyRu04hawpJvEb8btcXn7VUDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784260; c=relaxed/simple;
	bh=y9XkjoK5I8KPs5bHemIJST+fhadCrHXxN2DD/V7vMns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zvve+BUXBe1NXjxnMTNN6GghszLuZV9lUZoLba1teiElbr3myjmS+qraXY4jmjy+Ju2dS6l4B1gYrlZWHM4hy06+5qI4IAuKoxh9IdxTsr2vteIH4ZthE7dXBAWK7Lu7qbnfIunnMCw3O9cNzf1nwTf37BknSm5JxNNUTwGfSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c74Sh6YPdztTKF;
	Thu, 21 Aug 2025 21:49:56 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F16C180485;
	Thu, 21 Aug 2025 21:50:55 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:55 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:54 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v2 9/9] Documentation: hisi-pmu: Add introduction to HiSilicon
Date: Thu, 21 Aug 2025 21:50:49 +0800
Message-ID: <20250821135049.2010220-10-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250821135049.2010220-1-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
job of monitoring specific parts of a device.  Add description on that
as well as the newly added ext operand for L3C PMU.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst | 38 +++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index a307bce2f5c5..4c7584fe3c1a 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -12,8 +12,8 @@ The HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
 called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
 two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
 
-HiSilicon SoC uncore PMU driver
--------------------------------
+HiSilicon SoC uncore PMU v1
+---------------------------
 
 Each device PMU has separate registers for event counting, control and
 interrupt, and the PMU driver shall register perf PMU drivers like L3C,
@@ -56,6 +56,9 @@ Example usage of perf::
   $# perf stat -a -e hisi_sccl3_l3c0/rd_hit_cpipe/ sleep 5
   $# perf stat -a -e hisi_sccl3_l3c0/config=0x02/ sleep 5
 
+HiSilicon SoC uncore PMU v2
+----------------------------------
+
 For HiSilicon uncore PMU v2 whose identifier is 0x30, the topology is the same
 as PMU v1, but some new functions are added to the hardware.
 
@@ -113,6 +116,37 @@ uring channel. It is 2 bits. Some important codes are as follows:
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


