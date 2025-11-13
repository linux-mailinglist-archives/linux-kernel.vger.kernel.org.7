Return-Path: <linux-kernel+bounces-898755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F1C55EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D331934E6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE3320A24;
	Thu, 13 Nov 2025 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="P5ZqKQ9r"
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1593203A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015663; cv=none; b=VapGB8g7rhgFM55rJEBSdraxLpCd7r8fSe4eyh4ol9WJdwOZVMkmUnorWuwFfEmBU4NvsUpgqtLg/eY56KJsCr0qEZ0HUMhymLCh7BpgoMyf4zsseGgA2kDMbvjqBX+ndiKbgFmwVfcTDGIzuDwsJf2DyYxEh4OfO3L8JqPsF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015663; c=relaxed/simple;
	bh=cRsgvm0G1O7+5bYptmQ08SL1ws55YK1M5C4w97Pxg50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZqBZu/4j5g89T0A7NjnRwDcTh3bqUuZ3hlXxzWpf/hYz2Mh9awHwsKQpUTrVsksNJtHlq97la4yIBpLbZsd5WTkALeHATFisb08SXiuQB8tdceamLm/Wi1+18I3XGZtP5n7/F2nnrgMmBZ9q101A3xCqgCicPZqlpqJ0iwKd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=P5ZqKQ9r; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 296eb3989;
	Thu, 13 Nov 2025 14:34:08 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jani.nikula@linux.intel.com
Cc: joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	andi.shyti@linux.intel.com,
	mikolaj.wasiak@intel.com,
	krzysztof.karas@intel.com,
	krzysztof.niemiec@intel.com,
	nitin.r.gote@intel.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] drm/i915: Use symmetric free for vma resources
Date: Thu, 13 Nov 2025 06:34:05 +0000
Message-Id: <20251113063405.116845-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7bebe2ac03a1kunm32325a7311214d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhlPVhgaTRpOGkpOTU0eGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=P5ZqKQ9rz1kEVvGKZ+XRtsZtVa8yDePzV24qvIJpzzCzY2tYwFUnpaAM6la7IS1Pbx0xVdAmCfnxYuj+wO/3nXAaOGEZkGb80CHraNCB9k1SA0dHixTVkEagfQun0JHpy8c3vF2p7qx2N9ORplOZjrhytdRHQ7vuqql0hnM9t7A=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ZSj4l+iI7JKR3Z396kPA7kl8a4f1l9OPjhSTji8cqHE=;
	h=date:mime-version:subject:message-id:from;

The error paths in reserve_gtt_with_resource() and
insert_gtt_with_resource() use kfree() to release a vma_res object
that was allocated with i915_vma_resource_alloc().

While kfree() can handle slab-allocated objects, it is better practice
to use the symmetric free function.

Replace kfree() with the specific i915_vma_resource_free() helper to
improve readability and ensure the alloc/free pairing is explicit.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Reword commit message to describe this as a readability change.
- Drop the Fixes tag.
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 7ab4c4e60264..16e72ef57bed 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1524,7 +1524,7 @@ static int reserve_gtt_with_resource(struct i915_vma *vma, u64 offset)
 		i915_vma_resource_init_from_vma(vma_res, vma);
 		vma->resource = vma_res;
 	} else {
-		kfree(vma_res);
+		i915_vma_resource_free(vma_res);
 	}
 	mutex_unlock(&vm->mutex);
 
@@ -1704,7 +1704,7 @@ static int insert_gtt_with_resource(struct i915_vma *vma)
 		i915_vma_resource_init_from_vma(vma_res, vma);
 		vma->resource = vma_res;
 	} else {
-		kfree(vma_res);
+		i915_vma_resource_free(vma_res);
 	}
 	mutex_unlock(&vm->mutex);
 
-- 
2.34.1


