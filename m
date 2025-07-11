Return-Path: <linux-kernel+bounces-728151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830EB023FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4013B72AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891B2F94BE;
	Fri, 11 Jul 2025 18:38:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891182F94BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259121; cv=none; b=DWnOnbUwkT+KNBX09qMhbCt0gn2BU1l9tVMdGCPGZMlfpY5gUGJpd3l06uV/2cMolC5N0hHyh67nVsXvgh0ujNFa18j1vMKb6H+OlMDzo0+RfIpfgXg1zRoroRGgYMWSLjSFJImOwgBluEYwqI/3uoWmbR+vdLutLcNL5tk+5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259121; c=relaxed/simple;
	bh=H9XLVRXKtvTqDNpf8uXu69UrLbHRoWhT89o1SU3vd/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFcZy5NiCCj/3a6/rMkmFvar+Ng0kFLGhiSQsZC3FfqoSF+Hbjlxi/nolleiSOPl0thTMCvJS22zL4nrKuuBfXPfEFPM61Se1hYUjTlsLbKoWciUxVqIpttYRoUvUtB879szOqQCOy0rSA2DJf8teunSpWteRDh7rrInIESx4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3E12247;
	Fri, 11 Jul 2025 11:38:28 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A013F694;
	Fri, 11 Jul 2025 11:38:36 -0700 (PDT)
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
Subject: [RFC PATCH 29/36] arm_mpam: Add helpers to allocate monitors
Date: Fri, 11 Jul 2025 18:36:41 +0000
Message-Id: <20250711183648.30766-30-james.morse@arm.com>
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

MPAM's MSC support a number of monitors, each of which supports
bandwidth counters, or cache-storage-utilisation counters. To use
a counter, a monitor needs to be configured. Add helpers to allocate
and free CSU or MBWU monitors.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  |  2 ++
 drivers/platform/arm64/mpam/mpam_internal.h | 35 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 2cf081e7c4b2..b11503d8ef1b 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -338,6 +338,8 @@ mpam_class_alloc(u8 level_idx, enum mpam_class_types type, gfp_t gfp)
 	class->level = level_idx;
 	class->type = type;
 	INIT_LIST_HEAD_RCU(&class->classes_list);
+	ida_init(&class->ida_csu_mon);
+	ida_init(&class->ida_mbwu_mon);
 
 	list_add_rcu(&class->classes_list, &mpam_classes);
 
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 1586d6bd12f0..aca91f7dfbf6 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -230,6 +230,9 @@ struct mpam_class {
 	/* member of mpam_classes */
 	struct list_head	classes_list;
 
+	struct ida		ida_csu_mon;
+	struct ida		ida_mbwu_mon;
+
 	struct mpam_garbage	garbage;
 };
 
@@ -305,6 +308,38 @@ struct mpam_msc_ris {
 	struct mpam_garbage	garbage;
 };
 
+static inline int mpam_alloc_csu_mon(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_msmon_csu, cprops))
+		return -EOPNOTSUPP;
+
+	return ida_alloc_range(&class->ida_csu_mon, 0, cprops->num_csu_mon - 1,
+			       GFP_KERNEL);
+}
+
+static inline void mpam_free_csu_mon(struct mpam_class *class, int csu_mon)
+{
+	ida_free(&class->ida_csu_mon, csu_mon);
+}
+
+static inline int mpam_alloc_mbwu_mon(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_msmon_mbwu, cprops))
+		return -EOPNOTSUPP;
+
+	return ida_alloc_range(&class->ida_mbwu_mon, 0,
+			       cprops->num_mbwu_mon - 1, GFP_KERNEL);
+}
+
+static inline void mpam_free_mbwu_mon(struct mpam_class *class, int mbwu_mon)
+{
+	ida_free(&class->ida_mbwu_mon, mbwu_mon);
+}
+
 /* List of all classes - protected by srcu*/
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
-- 
2.39.5


