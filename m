Return-Path: <linux-kernel+bounces-751876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF973B16EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F806215D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A321CA14;
	Thu, 31 Jul 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDfTz4sZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204DF4FA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954248; cv=none; b=ETM0MSkP0d8ehM9J4n68E7ev695dIQAMI3y/PoUQuSIM6os/af5KdomvGvoWX/OoawsDBe2xXh3g8ugs0MHnc69ad5rvLn/tqCSX7mZqxZZiwLku+mhTDnO60/rvx4KuxA+sv5a/SXvEEDUtRN1mQss2tRWq9YMioox8gExhBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954248; c=relaxed/simple;
	bh=/aNQjQHtj7pCmn3Pkk5hk5UlaMfxeMxDUeslc601hdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHD7OCW3zO4iByO9Zlk9RWtrgYRt6tpTk4L1FGwRW2/qrVRJloinv6h0PKcI3wXj7yaHrHgkiFClD4+mlOQo7BB62ekmLKQNSl4cdxGCU65GcQdScHyYIqLm5vvhep0/R3s0Cux8oATpE049OzvamK8HFdSWKGdQAdiMTrLNvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDfTz4sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D23C4CEF5;
	Thu, 31 Jul 2025 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954248;
	bh=/aNQjQHtj7pCmn3Pkk5hk5UlaMfxeMxDUeslc601hdc=;
	h=From:To:Cc:Subject:Date:From;
	b=gDfTz4sZhUil6BEsal0RQrY+KKrMbzZuaRajDu8wsowGnjc6++giIR2Fwc7MYbDbn
	 2nbTQRuP5NhHhE9IL/uotJ+uBh9ph05RFwvK1xh0aOTMAKloWMs+vWEapv4r0ieay1
	 7+xjDYQSyOBD3rxVQziQexxLsR9Ov1MvGJ1JYWsZYBk8h4Dhk2w3lW/OIN3svND0UE
	 zQF448W0guVzDxeTkQVw0V05mt2e9cNuwkQ5dr/yRAJEv4tbMDAcxP2kedxUDecyTv
	 Ww2IlHqqoW7+sv5vvVjcZFNF/L98upeJYWH8ZbyCrHzsEh6QkIxYdRXaJkvWiIYN41
	 +QGIwcH7xwTOQ==
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
	linux-kernel@vger.kernel.org,
	James Flowers <bold.zone2373@fastmail.com>
Subject: [PATCH] drm/sched: Document race condition in drm_sched_fini()
Date: Thu, 31 Jul 2025 11:30:09 +0200
Message-ID: <20250731093008.45267-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drm_sched_fini() all entities are marked as stopped - without taking
the appropriate lock, because that would deadlock. That means that
drm_sched_fini() and drm_sched_entity_push_job() can race against each
other.

This should most likely be fixed by establishing the rule that all
entities associated with a scheduler must be torn down first. Then,
however, the locking should be removed from drm_sched_fini() alltogether
with an appropriate comment.

Reported-by: James Flowers <bold.zone2373@fastmail.com>
Link: https://lore.kernel.org/dri-devel/20250720235748.2798-1-bold.zone2373@fastmail.com/
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a550fd76bf0..738aefed727c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1424,6 +1424,22 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 			 * Prevents reinsertion and marks job_queue as idle,
 			 * it will be removed from the rq in drm_sched_entity_fini()
 			 * eventually
+			 *
+			 * FIXME:
+			 * This lacks the proper spin_lock(&s_entity->lock) and
+			 * is, therefore, a race condition. Most notably, it
+			 * can race with drm_sched_entity_push_job(). The lock
+			 * cannot be taken here, however, because this would
+			 * lead to lock inversion -> deadlock.
+			 *
+			 * The best solution probably is to enforce the life
+			 * time rule of all entities having to be torn down
+			 * before their scheduler. Then, however, locking could
+			 * be dropped alltogether from this function.
+			 *
+			 * For now, this remains a potential race in all
+			 * drivers that keep entities aliver for longer than
+			 * the scheduler.
 			 */
 			s_entity->stopped = true;
 		spin_unlock(&rq->lock);
-- 
2.49.0


