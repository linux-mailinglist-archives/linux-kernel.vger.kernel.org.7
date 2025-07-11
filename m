Return-Path: <linux-kernel+bounces-728154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D392B023FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEBC5C778A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830412FC00A;
	Fri, 11 Jul 2025 18:38:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380B2FBFFE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259131; cv=none; b=u7MJ0KJEHHevscYpDXoeAqqcrjOuJvj2kgpDjldfODRtq71CtYBjcRYQNE9xP9zd7SegdYHfwWhhzWd6GdyAOmV2oeWA16UMO6sB429sKjazXG55LaFPWdJH+zu6Wkf8Sg0x2zMIV+wVed5pQupqPgTkRkEX5m1R54ORhZck7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259131; c=relaxed/simple;
	bh=5KjAXQ2HAIck+Xt8m3qo3SxrT8IkPyuHEDdH1KU8WWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icAgbEC/oqxFVbJcIS3XuF/2714aBrMBlyxb/WdgwDmhxDUgU+lOFuqoa/sNOfZ04PoRng6yFjm3uirJrrSpKHwIDNjYC8G3rftPX323Dz0zszGf0gzalOyGpYIQp6WqmAW2DN9eicmTmRHhvw7Ti/x/8JRm5rcH89LPfNpOY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6678A16F8;
	Fri, 11 Jul 2025 11:38:38 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBCA93F694;
	Fri, 11 Jul 2025 11:38:45 -0700 (PDT)
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
Subject: [RFC PATCH 32/36] arm_mpam: Probe for long/lwd mbwu counters
Date: Fri, 11 Jul 2025 18:36:44 +0000
Message-Id: <20250711183648.30766-33-james.morse@arm.com>
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

From: Rohit Mathew <rohit.mathew@arm.com>

mpam v0.1 and versions above v1.0 support optional long counter for
memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register have fields
indicating support for long counters. As of now, a 44 bit counter
represented by HAS_LONG field (bit 30) and a 63 bit counter represented
by LWD (bit 29) can be optionally integrated. Probe for these counters
and set corresponding feature bits if any of these counters are present.

Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 23 ++++++++++++++++++++-
 drivers/platform/arm64/mpam/mpam_internal.h |  8 +++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 5da2666e9ee1..774137a124f8 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -860,7 +860,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 				pr_err_once("Counters are not usable because not-ready timeout was not provided by firmware.");
 		}
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
-			bool hw_managed;
+			bool has_long, hw_managed;
 			u32 mbwumonidr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
 
 			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumonidr);
@@ -870,6 +870,27 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumonidr))
 				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
 
+			/*
+			 * Treat long counter and its extension, lwd as mutually
+			 * exclusive feature bits. Though these are dependent
+			 * fields at the implementation level, there would never
+			 * be a need for mpam_feat_msmon_mbwu_44counter (long
+			 * counter) and mpam_feat_msmon_mbwu_63counter (lwd)
+			 * bits to be set together.
+			 *
+			 * mpam_feat_msmon_mbwu isn't treated as an exclusive
+			 * bit as this feature bit would be used as the "front
+			 * facing feature bit" for any checks related to mbwu
+			 * monitors.
+			 */
+			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumonidr);
+			if (props->num_mbwu_mon && has_long) {
+				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumonidr))
+					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
+				else
+					mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
+			}
+
 			/* Is NRDY hardware managed? */
 			mpam_mon_sel_outer_lock(msc);
 			mpam_ris_hw_probe_hw_nrdy(ris, MBWU, hw_managed);
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index fc71afce3180..fc705801c1b6 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -178,7 +178,15 @@ enum mpam_device_features {
 	mpam_feat_msmon_csu,
 	mpam_feat_msmon_csu_capture,
 	mpam_feat_msmon_csu_hw_nrdy,
+
+	/*
+	 * Having mpam_feat_msmon_mbwu set doesn't mean the regular 31 bit MBWU
+	 * counter would be used. The exact counter used is decided based on the
+	 * status of mpam_feat_msmon_mbwu_l/mpam_feat_msmon_mbwu_lwd as well.
+	 */
 	mpam_feat_msmon_mbwu,
+	mpam_feat_msmon_mbwu_44counter,
+	mpam_feat_msmon_mbwu_63counter,
 	mpam_feat_msmon_mbwu_capture,
 	mpam_feat_msmon_mbwu_rwbw,
 	mpam_feat_msmon_mbwu_hw_nrdy,
-- 
2.39.5


