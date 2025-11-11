Return-Path: <linux-kernel+bounces-895806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34004C4EF62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F4718C354E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54022312834;
	Tue, 11 Nov 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWGoehvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F7338902
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877718; cv=none; b=Y29O4EEU8KcLvI+FSJBkjGhHAYFXCkfJxkbNMrhj4xV7BOuS41BGwrsd+OGkWFDJEI9QuRwblvynSsq2zNM0PyVxB8OV5VGK4KCvVCGtuGG5ai/pwrjnbq61vDT0AGQ+WikTW17RXSSCxKzU5w7SV5XwdhKsJsdJyVH8Urv2LPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877718; c=relaxed/simple;
	bh=fLUCOZcJGqs10IzWWpUN1U+QCtifLHFvmvQS6PWoXi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9hWdsKUW6yKlgza4FBI0euZ/7ItJonL67ZIzKp72Jfrbzpbp4Wdw57YiyU2xzpD1KobkO6fJovsjx6fgoOfA1Lb6jaCkz5mjhh8VeVtd7tvkC1v9Qhq5a9vbqJuHcDDwZ8Q7jSPmc3R5jDy/2lmtj12iFinfkF7VtHYZbQViYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWGoehvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644BEC16AAE;
	Tue, 11 Nov 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877718;
	bh=fLUCOZcJGqs10IzWWpUN1U+QCtifLHFvmvQS6PWoXi8=;
	h=From:To:Cc:Subject:Date:From;
	b=GWGoehvnXJiDbmFG8JSrPQbK/ND2R25jREsH4qUqkUpz6VdOsJCSB75/6+rdPPttd
	 rf9PfNB9biA1Ehi0597tOk99ZcBXbNLsmRvN8XATqFhy9UF7w12pfDVjFexjB56v85
	 naPWyVqvzmMTXpa7cV829H1xytWwLFRpcDpSzoQNA9sDOXqJmIGDOjysl2AUMMTqYg
	 XHJlaGM9AJtZ7Sv5si/xG3KQ1Em3c2CYV8x0t1Kwl5oUhEj2ysx+mU7jZprqChdw5k
	 WVZEZkuGMzIv/YCO9kNMacbKuwhlim2Z70vvPBtjZ7/OMZ/+fy5GjjWNq9MmEKkt4L
	 0F0v/cq97GRgA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Fix outdated sched_job docu
Date: Tue, 11 Nov 2025 17:15:03 +0100
Message-ID: <20251111161502.86180-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no such thing as a "done_list" anymore. Remove mention of it.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index fb88301b3c45..18d6210ce2d0 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -320,7 +320,7 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
  * struct drm_sched_job - A job to be run by an entity.
  *
  * @queue_node: used to append this struct to the queue of jobs in an entity.
- * @list: a job participates in a "pending" and "done" lists.
+ * @list: for enqueueing the job into the list of pending jobs.
  * @sched: the scheduler instance on which this job is scheduled.
  * @s_fence: contains the fences for the scheduling of job.
  * @finish_cb: the callback for the finished fence.
-- 
2.49.0


