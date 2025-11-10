Return-Path: <linux-kernel+bounces-892603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B8C456E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0415D3AA31A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC762FD7CF;
	Mon, 10 Nov 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZIqpqclA"
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763A2FD1B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764546; cv=none; b=TczKYMEBvfmoRoMtwwKbhROutrJvejq+gr2wY97RiD4LxIh2dw+xa7NlVxaaDNBjzU3gBlxDe9OfkIRAi71Fw+td/T69MplSqJ5sh4t47xxCqvVVL0Pp08lgg/UgeMli5Z17FoEesmwqB4wbiUg9oCxAgbkGp8hILoJxiDhCxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764546; c=relaxed/simple;
	bh=hxRdUa/iz8BiV0PmRQYC+2KvMuhW6n0eLYtH1j07rMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N12EpjGjKX7h2fQ5ZfaDE0iukqalElCP1bq9gn8BjgqKqtPUPdaqMWxmEH2/eODiU4YRaLB9a51oSzBZpDofQPgBBNAqPlRE0osZmag50iBiTdHB2vfawR22+P7P4uYdvYJ/R0hnahMGIvq/Y+4OTOsBB/6OqzJX/AnHtLeLYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZIqpqclA; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29056fe23;
	Mon, 10 Nov 2025 16:48:58 +0800 (GMT+08:00)
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
	nitin.r.gote@intel.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/i915: Fix improper freeing of GTT resources
Date: Mon, 10 Nov 2025 08:48:54 +0000
Message-Id: <20251110084854.750219-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6cf4407703a1kunm60fb54dea58d19
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCShkaVksZHR8aGh5KSkMeT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ZIqpqclAxMTuBpVxDXAljoWPvTLRG4w9zf+DU7lfiJeSbYcGmcO6BZ+kOJUjmg2tvwpLcfzIEG3AsXjtpDXI50Q8qXN005DeIdmcbXN3ZiWto+BCEXJ8uS2po2ezzV883E9sKJisMQ+GsrcdXR9oq+VPX5GZJfFOXEhjArebiEo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=NNeu8X5AfKIaZAoYrzMFyvH5cUOsd9q1DZT/gH4VelI=;
	h=date:mime-version:subject:message-id:from;

In the error paths of reserve_gtt_with_resource() and
insert_gtt_with_resource(), a vma_res object allocated via
i915_vma_resource_alloc() was incorrectly released using kfree().

Since i915_vma_resource_alloc() allocates objects from a dedicated
kmem_cache, using kfree() instead of the corresponding
i915_vma_resource_free() causes a mismatch between allocation and
deallocation routines, potentially leading to memory corruption.

Fix this by calling i915_vma_resource_free() to properly release the
vma_res object in both functions.

Fixes: e1a4bbb6e837d ("drm/i915: Initial introduction of vma resources")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
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


