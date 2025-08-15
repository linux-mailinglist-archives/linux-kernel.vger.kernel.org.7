Return-Path: <linux-kernel+bounces-770721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC2B27E35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165E4A261F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DB2FDC21;
	Fri, 15 Aug 2025 10:26:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435591A314E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253559; cv=none; b=Bb9tjm3D36FUVuNCvrGj6Sp+IeX3Idj6zz5zLIvDaCqTRYzW6w0GB3/0TvLSiWdeyUmp2G919bxzYq98M24NifX1zcq//Rxpp1grExnQNUyRIJ3ZeRx4Qixo6g7/FINGWpugnZDrzjvSEc6G6HUFqWqRuohzwOhXiJaV4r0mI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253559; c=relaxed/simple;
	bh=WsbGjxyxR1NecPxWrz4TfjE2ShUDhJJFUUS7X4n8iok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMbgXMqk3h0u8ILRaXsA/ONN0oLq0t6Baathi+8zyQoBjBJ/dw09LNnRVdeuQZIAE+yIQWAARtI6aYODO4T8QIzhLzNk7E5Wd2OdSos/EoMAMavb03Vx/9Ux7m8IlQKZ6QL2NccuBWKV2l488Y8sfXK7tF74etnEcSJAndq9y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0511691;
	Fri, 15 Aug 2025 03:25:49 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.29.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155723F738;
	Fri, 15 Aug 2025 03:25:55 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Karunika Choo <karunika.choo@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panthor: Remove dead code in mmu_hw_do_operation_locked
Date: Fri, 15 Aug 2025 11:25:39 +0100
Message-ID: <20250815102539.39711-1-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only callers to mmu_hw_do_operation_locked() pass an 'op' of either
AS_COMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT. So remove the code paths
that test for other operations and add a drm_WARN_ON() to catch the
posibility of others appearing the future.

Suggested-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 367c89aca558..b16f44aec725 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -612,17 +612,12 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	 * power it up
 	 */
 
-	if (op != AS_COMMAND_UNLOCK)
-		lock_region(ptdev, as_nr, iova, size);
+	drm_WARN_ON(&ptdev->base,
+		    op != AS_COMMAND_FLUSH_MEM && op != AS_COMMAND_FLUSH_PT);
 
-	if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
-		return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
+	lock_region(ptdev, as_nr, iova, size);
 
-	/* Run the MMU operation */
-	write_cmd(ptdev, as_nr, op);
-
-	/* Wait for the flush to complete */
-	return wait_ready(ptdev, as_nr);
+	return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
 }
 
 static int mmu_hw_do_operation(struct panthor_vm *vm,
-- 
2.39.5


