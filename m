Return-Path: <linux-kernel+bounces-896678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9DC50F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA653AB93F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF42C21E7;
	Wed, 12 Nov 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+Uy7WT2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8927603F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932713; cv=none; b=tJxc3g2pHuJ6fm+ez/dpbfmUU8sRj6e3k+uiPWJjzf89VCQCp4h9qytdgyCAhiGOAkUNiTWTGyy98Wz4qHvi6AbRFurhVg1z0Vm9Wuw4J+oIZES8zLxZEIE5E+yNTemJrDQRTR1us8XK5j3TvWbu97yPVBNxInFJpofQ5PqyhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932713; c=relaxed/simple;
	bh=mukyEYZU61HPqq/3z4Of9cSo849HTj7DUQobL9BMk4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8Kb/woM3kXxW0uQWMj/s0eAgfvlhzXwcw+Kz+on2cYw9kswZqsdd4iir23+PdJGF1wHTQrKyD5X3mIsbvm/+h/HJZpqifzIp+9pb8XvxMqxiixudXYf+5gaXRLO+WRgBh32Xjuy/Y3aeiedQFsb8OWaZVgCQr/6hkywSRzrvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+Uy7WT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D9EC116B1;
	Wed, 12 Nov 2025 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762932712;
	bh=mukyEYZU61HPqq/3z4Of9cSo849HTj7DUQobL9BMk4g=;
	h=From:To:Cc:Subject:Date:From;
	b=t+Uy7WT2gYSfhVWGNM8ovrPlC07Dndkkgj4V5Du4KyJq/FQ+1aHq7jEJBBSklk1hs
	 uwxvniCj+ekwRrNOyEQ2CfhJ+q23NjTi2AooXxGSAXnCuSj4UwkaqqO/KkhqWxzl4e
	 dZJYI5eaMIIylUUjumS2mt5gCIXUEaK91A2WY2go9XURMKfvmR1NHN/4A5DmQVN+bO
	 8y+XqI95NAtaaqDN9D6n+IwaEjHEXY1D1LZS6MCSfay0HQvOLDVpPqMOG2BeyukAZ4
	 pb30at2kxnSqpXakHja4Vyfh+17DKs9+WdJdJMJVqxScOEj4xN8eP36Ob+TTkZTQdb
	 O05ud4uuReC8Q==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Document racy behavior of drm_sched_entity_push_job()
Date: Wed, 12 Nov 2025 08:31:39 +0100
Message-ID: <20251112073138.93355-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes a
reference to that queue's tip at the start, and some time later removes
that entry from that list, without locking or protection against
preemption.

This is by design, since the spsc_queue demands single producer and
single consumer. It was, however, never documented.

Document that you must not call drm_sched_entity_push_job() in parallel
for the same entity.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 5a4697f636f2..b31e8d14aa20 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
  * drm_sched_entity_push_job - Submit a job to the entity's job queue
  * @sched_job: job to submit
  *
+ * It is illegal to call this function in parallel, at least for jobs belonging
+ * to the same entity. Doing so leads to undefined behavior.
+ *
  * Note: To guarantee that the order of insertion to queue matches the job's
  * fence sequence number this function should be called with drm_sched_job_arm()
  * under common lock for the struct drm_sched_entity that was set up for
-- 
2.49.0


