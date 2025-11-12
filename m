Return-Path: <linux-kernel+bounces-896834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E8C51597
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257913BFD43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659B2D878C;
	Wed, 12 Nov 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4jXFHSf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4D2BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939164; cv=none; b=Am5bgBkQypxddN7f0O5NeaT2/gMUdvrjmKt6fbyOZh0jnQysgS4B31m5Ee8scYYfXt5nnN7jF1WaBt8Hat3pWcS7Z9ekSF8ot0RAcmqqJ3wfcP+TYSzskFK+cb2Wvp+fs59DhM/WC9bYuPV6ohHbriWQoV884rb7KRUr3vzgOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939164; c=relaxed/simple;
	bh=TUBMdqXZtBxlRTi5nLhrFDdltLTrJzBC9flXUcPYToM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmZyl8SaotnuE1aheTAZFblyyoVU6MjN3tmJxwpibVEtQ2qfCaKnrpLc2S1KL4ACfwaDSI71dN65i/P6+P6f9UbMaqUULGDVxGAS82YIwYKRkTon6+HesYrw1r21KsDS5pgBUUg9ZwbmatKF+j3dKfMKXTvzTVHNMACbzaPqkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4jXFHSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70027C2BC9E;
	Wed, 12 Nov 2025 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762939164;
	bh=TUBMdqXZtBxlRTi5nLhrFDdltLTrJzBC9flXUcPYToM=;
	h=From:To:Cc:Subject:Date:From;
	b=K4jXFHSfp/JHxBeWG/JwKzJ7dsy5723jKztLydy1AOzcFcQwwWx4mRw2rIBiUNjYs
	 ug81FRU4bs38vYu0iEktCXUfRmYCwSG6nlYWoQON0WoPfHn/zsN1w7fwKBuC9a92ts
	 iv7IWYJkNvKyFWTfBvKfDVf+cs2n3N91vWQ3ky4gJL01SvIY2Oun/hgJ2V/XYnnX7V
	 PnDcc7aWpVEHxyUbMVWd38xLnDvDn55ZlRIt1ba5r61QB6s8g2fkj/mB+AbsjMBaWa
	 6BkttLqM9OvuEg+MNTpW3uOauwxUJegsCc8ZOT4tFJZmvoGeD3Y3HjXIJ+QQ6i6ses
	 KH0p1iR5Qiu+A==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/sched: Don't crash kernel on wrong params
Date: Wed, 12 Nov 2025 10:18:53 +0100
Message-ID: <20251112091851.104443-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
entity being NULL. If the entity is NULL, subsequent accesses will crash
the particular CPU anyways with a NULL pointer exception backtrace.

Remove the BUG_ON().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Drop BUG_ON() instead of replacing it. (Tvrtko)
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1d4f1b822e7b..05eb50d4cf08 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -857,7 +857,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_entity *entity = job->entity;
 
-	BUG_ON(!entity);
 	drm_sched_entity_select_rq(entity);
 	sched = entity->rq->sched;
 
-- 
2.49.0


