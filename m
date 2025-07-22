Return-Path: <linux-kernel+bounces-740655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E027B0D751
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB45169380
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCF2E0919;
	Tue, 22 Jul 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ftjrvg9T"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCE288528
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180073; cv=none; b=B1D0bQ70XHGSEZwfIPXNXCNMkFg88NjKGazrfA4lDxtjci5LYeDSe9V408jh2tgXVAPXA6Iz7KNgVzX2sHSxm9CpFPmmyd/rw+TeKnwt+3yyRfXG+2K70d/JLBS/hUeeZkN/l6JoeBRK6yYBg5hmv8/12ZLP/DRSiQzlNbDjefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180073; c=relaxed/simple;
	bh=ZA8vXYmj2axQOYi02RwWpQXyR+lzyL2z0lMdOGcy8Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BSwGFa5WviAbXmnwcZlXAKwxpq+JBUmvOtHmPUeRwqn/2bqwJFowqBb7bBEeuH0CN9/02h1oHQsYj7T7G397AATICfK3etguttSqIw1Ni3o+tuwE2ENWkFEsY72kAhFLbrk3GDLU6PnQeqvCe4vhGmGNbpKWhGHRshFvI/LOQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ftjrvg9T; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lB
	XlC4JtAXtnVPhmyXizUjaqmuQupzk/Y7wvzszghCU=; b=Ftjrvg9TBeiuY24kr7
	BGQ62H4MvR6tVQkYOJiOlnGEv1bDbl3naT7Pbx++Q6pjyNY0/ONlaN6vuDk5gGYQ
	Rmswb/dBiRf4JKdysheR1DVDjygVozlnPILIAXfHY7NHf8xDJC/6H2s6qfJzqcu0
	eS53lXHoybyQVkz4nARY6kPbI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnt9KGZ39oRKU8Gg--.16241S2;
	Tue, 22 Jul 2025 18:27:20 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/shmem-helper: Remove duplicate dma_resv_assert_held
Date: Tue, 22 Jul 2025 18:27:17 +0800
Message-Id: <20250722102717.2247698-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt9KGZ39oRKU8Gg--.16241S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFWfuFWDKry7Kr48Cw4xCrg_yoW8JrW5pF
	ZrA34UKrW8KFZ0qFZ7Zws7Aa45CanaqFW0qFW5W3y3uFn7JFnrtryFkFyDZFy7ArW7ur1Y
	qryDCFWrCryUKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWlk-UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQWSD2h-YTh75QAAsV

From: Shixiong Ou <oushixiong@kylinos.cn>

The call to dma_resv_assert_held(shmem->base.resv) is duplicated
in the vmap() and vunamp() function.

Remove the duplicate call to clean up the code.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ac0b1fa5287..10e20209f3b2 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -355,8 +355,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-		dma_resv_assert_held(shmem->base.resv);
-
 		if (refcount_inc_not_zero(&shmem->vmap_use_count)) {
 			iosys_map_set_vaddr(map, shmem->vaddr);
 			return 0;
@@ -415,8 +413,6 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	if (drm_gem_is_imported(obj)) {
 		dma_buf_vunmap(obj->dma_buf, map);
 	} else {
-		dma_resv_assert_held(shmem->base.resv);
-
 		if (refcount_dec_and_test(&shmem->vmap_use_count)) {
 			vunmap(shmem->vaddr);
 			shmem->vaddr = NULL;
-- 
2.25.1


