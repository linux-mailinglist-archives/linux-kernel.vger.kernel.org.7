Return-Path: <linux-kernel+bounces-795800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5363B3F800
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6AD3A1EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2752E92B8;
	Tue,  2 Sep 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpSpWKkO"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335E2E6CB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800807; cv=none; b=CRCJWauvX5WKIrCrv+lC9xnNamp3eZRnsdRAKZdt+ZOkMEE39V1JV49HNW+Gazl0Y+S0JMM4mlojoK6knvvW8lDa+o53JjKfUXT+v2xF3TqqPip2OIZ2bEqzladFatw1qortbRL0LRZdPP8/4jZK1Yd/lRA/gApB5VFjM2bHYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800807; c=relaxed/simple;
	bh=3c03N9Is8V8LH2XSuyCynLBGCq1eArZb4rBQYNZgurg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gClpU0hBGDbZW8rTSv39Xqrk1nmruI3JMntzaWMR0ODBsW+w79MfVBGHkRKJRIDoDdEQTZZxARCQWulu3qV3TfUHDkpGx5nsu01Gdn5kZCehtJ0/k7hFPIzf+xwAsiyGRRAcABXrLyB+H+LfKNXx7aqGhb6pj2aTxEytex/dST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpSpWKkO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756800800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=29lL7/RHKWS3+5nqR/m2P+13Padj37R/bQqCAmj2wno=;
	b=lpSpWKkOVo6I3i2IWYM4ucRCzxS+xMDCyEX5rpF0h/xecKuBGPx12EVLeSu2CvgGa+LKlt
	sr7PRhEPDcA+4QKrb/zBqpE2HvYJwAmzDh1iTmGr42/7GIu0yyuvHaSvMYRgl42ctfXjnl
	mrK0dVzEeJdcC6zf6j4y9M1aCdp2tnY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nitin Gote <nitin.r.gote@intel.com>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Tue,  2 Sep 2025 10:10:42 +0200
Message-ID: <20250902081046.35463-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify set_context_image(), and to silence the following
Coccinelle/coccicheck warning reported by memdup_user.cocci:

  WARNING opportunity for memdup_user

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this (with updated patch subject and description) because the
CI logs [1] from my first submission [2] about a year ago are no longer
available.

[1] https://patchwork.freedesktop.org/series/139319/
[2] https://lore.kernel.org/lkml/20240925141750.51198-1-thorsten.blum@linux.dev/
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 15835952352e..ed6599694835 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -2158,18 +2158,12 @@ static int set_context_image(struct i915_gem_context *ctx,
 		goto out_ce;
 	}
 
-	state = kmalloc(ce->engine->context_size, GFP_KERNEL);
-	if (!state) {
-		ret = -ENOMEM;
+	state = memdup_user(u64_to_user_ptr(user.image), ce->engine->context_size);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
 		goto out_ce;
 	}
 
-	if (copy_from_user(state, u64_to_user_ptr(user.image),
-			   ce->engine->context_size)) {
-		ret = -EFAULT;
-		goto out_state;
-	}
-
 	shmem_state = shmem_create_from_data(ce->engine->name,
 					     state, ce->engine->context_size);
 	if (IS_ERR(shmem_state)) {
-- 
2.51.0


