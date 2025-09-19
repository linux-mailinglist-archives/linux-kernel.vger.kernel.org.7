Return-Path: <linux-kernel+bounces-824194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F2B8853F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5D3566903
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F1305066;
	Fri, 19 Sep 2025 08:07:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841A305055
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269245; cv=none; b=TE9JTGMttL+jRM9ZRDAFdapJcQB2vUKJ2WfXCZ3WKEOsaLj5TNt1yHfvwJ8xV88w4cFaQ1IQ9DoVGEGsrAsfbZgbt+qhAJ9yfWOY/wpxv1x3YCYO8nz1IlGY2sQGZXsWl374YX4iL80/pnJDmyf1qGP+aLDb2RqOW8wGWH17cH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269245; c=relaxed/simple;
	bh=aNa6qt93J1N6oyHx0uFZohovK10wx82qqcJFwU1p/FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oushXRfVo80TPjsBCGwnsLspovhdimJnQwGeefW7y00Oen3g1rD18yRBl+mnlCZJTqv2ToH3M/UR1T4cZQCbJurmIEbH0rSn2xOYM/mcfe/JIePvz68UPOggF4o6mOd+i7lYbY5qhAVCtCDwrblyLKxXtrxqfubCtH4T3BMLzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4562169E;
	Fri, 19 Sep 2025 01:07:14 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1E33F673;
	Fri, 19 Sep 2025 01:07:21 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Bump the minor version number
Date: Fri, 19 Sep 2025 09:07:00 +0100
Message-Id: <20250919080700.3949393-1-steven.price@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
added new ioctls to the driver and was meant to bump the version number.
However it actually only added a comment and didn't change the exposed
version number. Bump the number to be consistent with the comment.

Fixes: a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3af4b4753ca4..22350ce8a08f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -853,7 +853,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 4,
+	.minor			= 5,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
-- 
2.39.5


