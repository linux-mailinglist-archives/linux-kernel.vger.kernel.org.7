Return-Path: <linux-kernel+bounces-766298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C46B244C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943FE188D5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9002ED165;
	Wed, 13 Aug 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fih5kiHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D252BE020
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075435; cv=none; b=Dgunznvr2tUhuQ4PNnpczZW49QZsd5/FvlrfO0/ZdGV9Js+4QGrTP745seTiyQLcoUknWMUVMH4QtZfjPQQkKwpal4yFdZUJ04rBJES4vtUs4GSMdqcQ7Y88RjntypynuMcXruQHiWqR9oO9mzrZds0FzeABa/x/Hqz66BOROaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075435; c=relaxed/simple;
	bh=tPv65mDfdZ0llyoTq/yFclRsFjMwzVQQFJKFvnEN1BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=at9353R53xFIME+jQI76i1k7zz/H+eN3tkbIGX7n2wQV0is/5UDkVJpQAmk95zQWy+2xkQwnb8muc3zpR6P+FAaru+TYELjIBfz4L07rnxU9p+yi9l+ch5gf8t4N2p7/J5+f3EEIEuTVlkRKX8zVCgEI568Vi8g1MKoF8pl8jFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fih5kiHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C3BC4CEFD;
	Wed, 13 Aug 2025 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755075435;
	bh=tPv65mDfdZ0llyoTq/yFclRsFjMwzVQQFJKFvnEN1BY=;
	h=From:To:Cc:Subject:Date:From;
	b=fih5kiHO4WkIyfwJXWpF18b7qsVzfXDW7l8SYOmBRrHZBnKEA7vHlL7ITh6iwyFYv
	 FZgfIPaKtlNafDg2xRR/RH2G3knrSxljuC92QnxENgXDzCi+kLa2p1spt7XqskWkrx
	 czoG6ckmHHqeEabTd5Qv4DnBdZcIFqA4JRsi/5Zz3ogWInwnhVBjnblg96qLfOOMN7
	 05LvmMBtMVnh8WsEBh3disiYIQCu51Bm2Tay7Kej/6kHghFv+EnbwxM6FDA6Y2ucxP
	 0rx2IttgRxtkXPXGQcOFFf6/8hSSnxJqoOztZBLX7OZEf4p/lqmA/vEn+CL9rUzjCO
	 NklAy7kbPnE6g==
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
Subject: [PATCH v2] drm/sched: Document race condition in drm_sched_fini()
Date: Wed, 13 Aug 2025 10:56:55 +0200
Message-ID: <20250813085654.102504-2-phasta@kernel.org>
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
Changes in v2:
  - Fix typo.
---
 drivers/gpu/drm/scheduler/sched_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a550fd76bf0..46119aacb809 100644
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
+			 * drivers that keep entities alive for longer than
+			 * the scheduler.
 			 */
 			s_entity->stopped = true;
 		spin_unlock(&rq->lock);
-- 
2.49.0


