Return-Path: <linux-kernel+bounces-846831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D0BC9275
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10B774F5210
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC72C159D;
	Thu,  9 Oct 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3rEP6Fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D134BA3A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014820; cv=none; b=n8jI07Q+Hzi416u6h5dlAV4io+AMNEn9FJxd9AFIl/kEx3WIAmKPVg7GDq7uceNw25kQKuUrVRkXzb+PcMMhuS5uJ5AmHiyyVTfzZJUBOe8Z7BAvWjFJVlcToz98fwg64V/2mWraA5FSNIbaPGT47x3IwSna44rGoeTMMg/ooUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014820; c=relaxed/simple;
	bh=RYuJ6aT2S9Kz/9NlGFnc04Gk8G7jOeT+9XyFBA7w33Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9NpkYBaxCrDfx4CNUGejdSLCQLfAIX6hA5cYA4LtSlajz+9/41tjFI93lBv4cEk4TPA1cRSTjxTSxp4jP3gtO4jrfsGUt+9PjPO35K2jkJxKIrgAOCrFsnbz33vFvTbBilx1rSutwDYL1DY2NaQ9K8BalIkrDdMxwfYNs4SRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3rEP6Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C2CC4CEE7;
	Thu,  9 Oct 2025 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014820;
	bh=RYuJ6aT2S9Kz/9NlGFnc04Gk8G7jOeT+9XyFBA7w33Q=;
	h=From:To:Cc:Subject:Date:From;
	b=N3rEP6FzSfAMn4cxbh4kmoxpybZljYLmUfs6c4JGmsIEZx29Kfr3GVswnQHfSEwuz
	 aR/wWZaw13+n0CdKmyiRNOijEtwfiS43YwE8ksL5ZW3sWPPZ0pN/RSHlNcWOM04DjN
	 2f9us5pTYyP/fSo14xrZCzBu0C2sIwj3bvPsaW+fQGcSI7Bk1gkn7nYk5EPKo+QO60
	 PlIvqwOlheO7EQNtWsCoYWpJpF6eFNwuCP7MkQLtnvfSxz9ctLS4msadLjdkV4TysV
	 Z7imwc+jmOgw2lT3pRopjWUG6jrKY086FOPCbhjFDEZtTve8xircFe135Jf+7mj5Rg
	 wOteb/OtmLo9w==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Add warning for removing hack in drm_sched_fini()
Date: Thu,  9 Oct 2025 14:59:29 +0200
Message-ID: <20251009125928.250652-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assembled developers agreed at the X.Org Developers Conference that
the hack added for amdgpu in drm_sched_fini() shall be removed. It
shouldn't be needed by amdgpu anymore.

As it's unclear whether all drivers really follow the life time rule of
entities having to be torn down before their scheduler, it is reasonable
to warn for a while before removing the hack.

Add a warning in drm_sched_fini() that fires if an entity is still
active.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 46119aacb809..e69917120870 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1441,6 +1441,8 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 			 * drivers that keep entities alive for longer than
 			 * the scheduler.
 			 */
+			if (!s_entity->stopped)
+				dev_warn(sched->dev, "Tearing down scheduler with active entities!\n");
 			s_entity->stopped = true;
 		spin_unlock(&rq->lock);
 		kfree(sched->sched_rq[i]);
-- 
2.49.0


