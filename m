Return-Path: <linux-kernel+bounces-777766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11EB2DD91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95055C5167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5AB31DDAD;
	Wed, 20 Aug 2025 13:16:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6381DEFD2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695797; cv=none; b=XMAn4WJgF8EGefXG8TaFu7lOAN50TWqMjURI+hFOClNfj7R/F5UBR6OtrwMimdvO6cjx5U/rwqoNGDMjwdGnNjpbt24uxi1UvDNeDj1Q53kK2h50pu++09MUphx5VDydvuzF1HiMDjUQeSfHSq4pzx9H3AN8jsHDh7MJr+935UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695797; c=relaxed/simple;
	bh=auAhK++YQG8sm3AjVHi9eeQAcX0ck1v/xlpsBfMUiqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVFmGhBbwdc4EZJJFc48hVahVnvXtzGAL13bZHKm1UAMaPosy6EwsprjcRpEVg1gVywOojUxDhOMZHJm4/B4Xxkzolf2FfRCqnCMrGpJMQWOnM31T5iosB1KI/haOq8PjDUn+Xl9f5XlyJAJSFIOcefxWQuj82GofyIEEq6jY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0524B152B;
	Wed, 20 Aug 2025 06:16:25 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B843F58B;
	Wed, 20 Aug 2025 06:16:32 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	James Morse <james.morse@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH] arm_mpam: Relax num_rmids parameter advertised to userspace
Date: Wed, 20 Aug 2025 14:15:21 +0100
Message-Id: <20250820131621.54983-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MPAM systems, monitoring groups are identified in the hardware by a
(PARTID, PMG) pair.  Two monitoring group identifiers are the same only
if the PARTIDs and PMGs both match.  This means that the number of
monitoring groups that can be created in each control group is the same
as the number of distinct PMG values supported by the hardware.  The
number of monitoring groups that exist in other control groups at the
same time makes no difference to this.

Currently, the MPAM driver takes the cautious approach and always
num_rmids = 1.

Relax this limit, by advertising the number of distinct PMG values
supported by the hardware.

Code/Data Prioritization (CDP) makes no difference, since although this
doubles the number of (PARTID, PMG) pairs available to a control group,
each monitoring group now consumes two pairs instead of one.

Suggested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

This patch is based on:

git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.16-rc5

 drivers/platform/arm64/mpam/mpam_resctrl.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index f1e565cd1aac..f4f6fa9acfff 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -1208,12 +1208,17 @@ static void mpam_resctrl_monitor_init(struct mpam_class *class,
 		/*
 		 * Unfortunately, num_rmid doesn't mean anything for
 		 * mpam, and its exposed to user-space!
-		 * num-rmid is supposed to mean the number of groups
-		 * that can be created, both control or monitor groups.
-		 * For mpam, each control group has its own pmg/rmid
-		 * space.
+		 *
+		 * num-rmid is supposed to mean the minimum number of
+		 * monitoring groups that can exist simultaneously, including
+		 * the default monitoring group for each control group.
+		 *
+		 * For mpam, each control group has its own pmg/rmid space, so
+		 * it is not appropriate to advertise the whole rmid_idx space
+		 * here.  But the pmgs corresponding to the parent control
+		 * group can be allocated freely:
 		 */
-		l3->num_rmid = 1;
+		l3->num_rmid = mpam_pmg_max + 1;
 
 		switch (type) {
 		case QOS_L3_MBM_LOCAL_EVENT_ID:

base-commit: b8e4905233fe45814b3c73be7e091f172cfb86ce
-- 
2.34.1


