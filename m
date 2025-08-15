Return-Path: <linux-kernel+bounces-770946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272CB280C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A1F5C3851
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F43019DB;
	Fri, 15 Aug 2025 13:42:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C7433AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265363; cv=none; b=HmNGPR4/JN6uN22w3rYbfr1ewRYq3FOGP8IjIhkAe9KmxG1SzAEpcIYHIBSJSVFTGrSnYNVSrASwmJ/K3bAE3zxkR28yl6b/3fYekPE9jx4n7osbLjoWGnPdA4IbhD/N7LkOUA5CKrfTpxAbkwlrhMih64bSe7T9sL/tJ1WQhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265363; c=relaxed/simple;
	bh=mU03G21BAZ9Dqp7pIfH6AFdrfgfYqK8sLcAIBUgQxiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNuwNwGWB25aIw3EH8chXvSRw4UM0XfpuFNmQbjPrBbNGbN0SNnUNtZhBjX3dhWEk0dLoMuXPgoYKl7dSruFJDuTHm33mBtvy2Uy3t3oxS9boh7R8xppmMY4yBSrUKU99J7bD1tiads+sQJkHu79xGy4CffqFLlbGtONdMj3wWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737D91691;
	Fri, 15 Aug 2025 06:42:32 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.29.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5EC3F5A1;
	Fri, 15 Aug 2025 06:42:39 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Daniel Stone <daniel@fooishbar.org>
Cc: Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Karunika Choo <karunika.choo@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>
Subject: [PATCH v2] drm/panthor: Simplify mmu_hw_do_operation_locked
Date: Fri, 15 Aug 2025 14:42:24 +0100
Message-ID: <20250815134226.57703-1-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only callers to mmu_hw_do_operation_locked() pass an 'op' of either
AS_COMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT. This means the code paths
after that are dead. Removing those paths means the
mmu_hw_do_flush_on_gpu_ctrl() function might has well be inlined.

Simplify everything by having a switch statement for the type of 'op'
(warning if we get an unexpected value) and removing the dead cases.

Suggested-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Steven Price <steven.price@arm.com>
---
Changes from v1:
 * As well as removing dead code, inline mmu_hw_do_flush_on_gpu_ctrl

 drivers/gpu/drm/panthor/panthor_mmu.c | 57 ++++++++++++---------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 367c89aca558..9d77e7c16ed2 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -569,15 +569,37 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
 	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
-static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
-				       u32 op)
+static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
+				      u64 iova, u64 size, u32 op)
 {
 	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
-	u32 lsc_flush_op = 0;
+	u32 lsc_flush_op;
 	int ret;
 
-	if (op == AS_COMMAND_FLUSH_MEM)
+	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
+
+	switch (op) {
+	case AS_COMMAND_FLUSH_MEM:
 		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
+		break;
+	case AS_COMMAND_FLUSH_PT:
+		lsc_flush_op = 0;
+		break;
+	default:
+		drm_WARN(&ptdev->base, 1, "Unexpected AS_COMMAND: %d", op);
+		return -EINVAL;
+	}
+
+	if (as_nr < 0)
+		return 0;
+
+	/*
+	 * If the AS number is greater than zero, then we can be sure
+	 * the device is up and running, so we don't need to explicitly
+	 * power it up
+	 */
+
+	lock_region(ptdev, as_nr, iova, size);
 
 	ret = wait_ready(ptdev, as_nr);
 	if (ret)
@@ -598,33 +620,6 @@ static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
 	return wait_ready(ptdev, as_nr);
 }
 
-static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
-				      u64 iova, u64 size, u32 op)
-{
-	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
-
-	if (as_nr < 0)
-		return 0;
-
-	/*
-	 * If the AS number is greater than zero, then we can be sure
-	 * the device is up and running, so we don't need to explicitly
-	 * power it up
-	 */
-
-	if (op != AS_COMMAND_UNLOCK)
-		lock_region(ptdev, as_nr, iova, size);
-
-	if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
-		return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
-
-	/* Run the MMU operation */
-	write_cmd(ptdev, as_nr, op);
-
-	/* Wait for the flush to complete */
-	return wait_ready(ptdev, as_nr);
-}
-
 static int mmu_hw_do_operation(struct panthor_vm *vm,
 			       u64 iova, u64 size, u32 op)
 {
-- 
2.39.5


