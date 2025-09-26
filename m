Return-Path: <linux-kernel+bounces-834034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57722BA3A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CED9178D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F923E347;
	Fri, 26 Sep 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZbFko8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288C2AD3D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890210; cv=none; b=mQMAVcgyWFtlVwtI9rvwH9AS3jOAOlyKsYoP8kH4hfLI7imQH+TNLSk8PedGMqyAjH/ovHIUSU240gJGQ1X55eLyAqB7qFfbBx24B/Hwk2WwNOIgzr9OBVgGfDJG4HlKEIvfFP0YJBnvyIBDSpiakyN/1s7HuLaYaLqFwY9uDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890210; c=relaxed/simple;
	bh=6J7ciNSyBqrMlRToLA4gwKqu2Yswr/KFx9veRorLzXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkrHr7fjI1ZQqdn3N9IR8zIrdQgnLiKv0JtDoHi74f1jUjudoTEOqNiivol1gTbZz+TdiIupXRKZVbnP5LrpVn3WF7Ovc/b67fDdid2fjyYYVBZZg429S9JOex272i7U180nxVvE6d7iMndiJ/3+EVcTcUbcWWn6hGQzmDJlOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZbFko8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54E1C4CEF4;
	Fri, 26 Sep 2025 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758890210;
	bh=6J7ciNSyBqrMlRToLA4gwKqu2Yswr/KFx9veRorLzXk=;
	h=From:To:Cc:Subject:Date:From;
	b=DZbFko8dNr2VjhRUujjLQPi+jLQusq9B/622cZGoJ/ZUqax/uxvGCGrHDzALMdRDA
	 8kvund8T5Ym0W2vuHPejFNTC97S8/aa8Dej+xiNDRaI4dYLTbFpspjeAUYfjkiRg1q
	 JFN2/MfAU/V6fPtyz7IwpC83rb1naHgMB1T1IWOiolsTKCwuiRuY0MTBXZdrtoGF6x
	 fNWFf4B9LvwOKduH31ynODRPxSZquiFWvlJvq/5sXpk2jg9UTClPbLZHVce9wTYCvo
	 wZdcuKnyZW5DV775F/DQsJy4taP5PSQfgdJuaEp7wbintjcv4G3CUIdH0b+ySU2e+8
	 8ZtQC9Z7wSwfA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Mandate usage of drm_sched_job_cleanup()
Date: Fri, 26 Sep 2025 14:36:31 +0200
Message-ID: <20250926123630.200920-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_cleanup()'s documentation so far uses relatively soft
language, only "recommending" usage of the function. To avoid memory
leaks and, potentiall, other bugs, however, the function has to be used.

Demand usage of the function explicitly.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 46119aacb809..0a9df9e61963 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1030,7 +1030,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  *
  * Cleans up the resources allocated with drm_sched_job_init().
  *
- * Drivers should call this from their error unwind code if @job is aborted
+ * Drivers need to call this from their error unwind code if @job is aborted
  * before drm_sched_job_arm() is called.
  *
  * drm_sched_job_arm() is a point of no return since it initializes the fences
@@ -1038,7 +1038,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  * submit it with drm_sched_entity_push_job() and cannot simply abort it by
  * calling drm_sched_job_cleanup().
  *
- * This function should be called in the &drm_sched_backend_ops.free_job callback.
+ * This function must be called in the &drm_sched_backend_ops.free_job callback.
  */
 void drm_sched_job_cleanup(struct drm_sched_job *job)
 {
-- 
2.49.0


