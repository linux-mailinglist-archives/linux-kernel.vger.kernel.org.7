Return-Path: <linux-kernel+bounces-890415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06DC40012
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE5494EC009
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7A2BD5B4;
	Fri,  7 Nov 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5M99Rb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0863502BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520119; cv=none; b=Srmu+Ir7y7dclCKM57icmqx25zDWR1QssZzuVv8f428fZxaboM9XWid7AxL6jQrtrONjDqhFOR2JX8Tj2CTG398dkPUAK4M6TCHarFT7nGHl1jl/mzCkXc2rtTd/sR8dFTA4UNBonLpViCA0vIz5Vu174EUaNiACeji2na4huXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520119; c=relaxed/simple;
	bh=8exqftc6e8NNM5I43fsBG61/6stXhGyx+oICt/2kdtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1srHSt8lkWp5EgvWgs9rzjYky/jiuHzvAEvHXcjaZQpL6mhFAlag39d8vk9qfTb7MnRD83eWmgJuLitXFn12v/xJlL2d8yPcZ42bd8tEMYNzSY7KPTj+88/rS749CVCHume0a4iHjXLwlI5DJNYG6rRD8Qi4+9PMAH/L3Anbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5M99Rb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97371C116B1;
	Fri,  7 Nov 2025 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520119;
	bh=8exqftc6e8NNM5I43fsBG61/6stXhGyx+oICt/2kdtw=;
	h=From:To:Cc:Subject:Date:From;
	b=p5M99Rb3eMQ2A/JdOoZqvdpixzbKFHdpwerowTLytfv78JJn+/k8MTHw0XD5RS0lb
	 i1fK7eUigw5Kd//N9z+T9vaBg/j4dVkyHPO0wS+nKssMkJgcuRwP6K6INz3EcXckOr
	 nlPdIfItdkLxk+wImNWzyyIMCkXEo51PChQTPE9ufOQRKAR3j4jdNqwuB3rkdW9EMm
	 +ApptYRZZEIhZDh+s8HV7mS4YzT/q6IJfyiteRQAyJJ3Fb3mSq5RTgDIJCvjq4tFaj
	 F724dXsVN9TRCFZjS8XMLlUfc1Nt6l8wM7G09V13jG95v9wdR6bGZPg9oaFPZXS5s6
	 KJCGCm2UrM9Kg==
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
Subject: [PATCH] drm/sched: Don't crash kernel on wrong params
Date: Fri,  7 Nov 2025 13:55:09 +0100
Message-ID: <20251107125508.235449-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
entity being NULL. While drm_sched_job_arm() crashing or not effectively
arming jobs is certainly a huge issue that needs to be noticed,
completely shooting down the kernel reduces the probability of reaching
and debugging a system to 0.

Moreover, the checkpatch script by now strongly discourages all new uses
of BUG_ON() for this reason.

Replace the BUG_ON() in drm_sched_job_arm() with a WARN_ON().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1d4f1b822e7b..3bf4ae0ca4bc 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -857,7 +857,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_entity *entity = job->entity;
 
-	BUG_ON(!entity);
+	WARN_ON(!entity);
 	drm_sched_entity_select_rq(entity);
 	sched = entity->rq->sched;
 
-- 
2.49.0


