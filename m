Return-Path: <linux-kernel+bounces-873871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA9BC14F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA154188DE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF92253EC;
	Tue, 28 Oct 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx7oSTRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED626221F24
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659177; cv=none; b=hcevC4zRzuEXqUFFraQ0b2UJXWCgdj2u7TO4Cy0Fp1CpdoTe5flol+bkiEv/OuvSgi2up8AOsRLmj66CqUpwZ00eHafgKjo9RMeDmFFWUiELWmfSV+XZPavis/XkyiVOzl/XWf1FGBmm/WESkr/CoP8qunhkMp5h35Q5gETvP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659177; c=relaxed/simple;
	bh=w7f3xidSiMuMp3mDXJlUUc5D0wccUhU3tupiMlxaRc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtnYX5IaPtf9uMSbLqzJ+Xj8ge+oyXH3zedYnbJDBVA9xhKUf7JLJwPa38np7a/3mmwYwjX5Lll8c34k533m4Fgpc4ifrtEmPssVNkMWkWcInzvQmSbVDT15cV5wL0qg7T0tCT6/SBNYVr2F2gxjhACNtFBtOOh8ak1t2QAhLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx7oSTRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0478FC4CEF7;
	Tue, 28 Oct 2025 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659176;
	bh=w7f3xidSiMuMp3mDXJlUUc5D0wccUhU3tupiMlxaRc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zx7oSTRFwurmTdWXau1Z5IYE1gJR/tV9SO4p/Ycxp5J5gqUa4EVZiXTDQw7EMmww0
	 fJ7GOUecF3mfVIVyQvXD/Gn/rJ+UH6togC0DNUVAEc6v6Bdwm0TbtjyJkGmx2EC1Yx
	 e4Pb6WKzbseYp8fk0qIdvvJ7n7qR7sU0hZqco4RKlUyDLBlRJOmmGxAPQqfW67/7bc
	 W09jBQgot9r1DgricVqPjJ/MIM+WgBCtsNyGvo/q+//c54kQdrV++ZDInpwlxDchbR
	 EkidB072S6NQlCijuPnBx8TeEivoLS9NLH6vPrIf1JlN9NuAlS0U4XnJVQHir6lN9l
	 BISEH5KanAWQw==
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
Subject: [PATCH 1/2] drm/sched: Fix comment in drm_sched_run_job_work()
Date: Tue, 28 Oct 2025 14:46:01 +0100
Message-ID: <20251028134602.94125-3-phasta@kernel.org>
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

drm_sched_run_job_work() contains a comment which explains that an
entity being NULL means that there is no more work to do. It can,
however, also mean that there is work, but the scheduler doesn't have
enough credits to process the jobs right now.

Provide this detail in the comment.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..492e8af639db 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1237,8 +1237,13 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	/* Find entity with a ready job */
 	entity = drm_sched_select_entity(sched);
-	if (!entity)
-		return;	/* No more work */
+	if (!entity) {
+		/*
+		 * Either no more work to do, or the next ready job needs more
+		 * credits than the scheduler has currently available.
+		 */
+		return;
+	}
 
 	sched_job = drm_sched_entity_pop_job(entity);
 	if (!sched_job) {
-- 
2.49.0


