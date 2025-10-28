Return-Path: <linux-kernel+bounces-873872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B2C14F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B529B1A205E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EABE23184A;
	Tue, 28 Oct 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILl/nI7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD002221F24
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659180; cv=none; b=IaZXrZWUVY8LEurGt5W9vZaW8EK0XCNZiTjXFysJAe+AZn914FDJe3RZPJVWcCBNfAZMDIMjssilm3ar5jYUuVqalMMu9/N+a6BYH68eWP74Nw52AhFCGTOOL80g5JfHv0n/tyyW8sXODV2xXciqiSwSNdg11oOWhKDgcYBswCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659180; c=relaxed/simple;
	bh=VoiscabQPRor6DkMinX+/cG24TnZhK5eJDrniLN5DIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/V4oqDcA3Kh97JVTaz5VOvjZwMRjDg06rOykvQhD8iuT5wt0oG6YdEOZP67RgVFJnNiVHCoFxTJx79alf3fPsU08YL7r+TmK6ksmQqhhH+JHwXz+5TWdZJgQDiOaE1s/tVhDLzWxTfag2Be1vtrU/O10UUzEKj/wDL+AWi3840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILl/nI7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6114EC4CEFD;
	Tue, 28 Oct 2025 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659180;
	bh=VoiscabQPRor6DkMinX+/cG24TnZhK5eJDrniLN5DIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILl/nI7kFfekVqR2DFI7+J9Vg2cPFUrSZJ3SvXzxDzW11ybKisnkQ/C3oVxqk41Mp
	 45yofm9nVnEgjeseh9U/naHjYrvZkNZVdpFEx5SEjVNE+iBu66XfdKxnc0MbKUL2Gg
	 4rsbSoqL0dlQ0eykSGypfWH/Qy/c+3u1WS6oEwODX7h55tQsyGhrEcoNOylp4H+c1L
	 sCRcouX2c+KzRMBMt5rEEXeEj0rPLlOqbYVcI2iQ1rTzn78XbP8lwokHcEWrkXsRjq
	 ynqpusAbOeQY/DUJRVhdgKv5UBsaYEqNPi5Q1106Pqug51EZ4+gdiZ1lmw/coAjzKF
	 2EObUYJB75QmQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/sched: Add FIXME detailing potential hang
Date: Tue, 28 Oct 2025 14:46:02 +0100
Message-ID: <20251028134602.94125-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028134602.94125-2-phasta@kernel.org>
References: <20251028134602.94125-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a job from a ready entity needs more credits than are currently
available, drm_sched_run_job_work() (a work item) simply returns and
doesn't reschedule itself. The scheduler is only woken up again when the
next job gets pushed with drm_sched_entity_push_job().

If someone submits a job that needs too many credits and doesn't submit
more jobs afterwards, this would lead to the scheduler never pulling the
too-expensive job, effectively hanging forever.

Document this problem as a FIXME.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 492e8af639db..eaf8d17b2a66 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1237,6 +1237,16 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	/* Find entity with a ready job */
 	entity = drm_sched_select_entity(sched);
+	/*
+	 * FIXME:
+	 * The entity can be NULL when the scheduler currently has no capacity
+	 * (credits) for more jobs. If that happens, the work item terminates
+	 * itself here, without rescheduling itself.
+	 *
+	 * It only gets started again in drm_sched_entity_push_job(). IOW, the
+	 * scheduler might hang forever if a job that needs too many credits
+	 * gets submitted to an entity and no other, subsequent jobs are.
+	 */
 	if (!entity) {
 		/*
 		 * Either no more work to do, or the next ready job needs more
-- 
2.49.0


