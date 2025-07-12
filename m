Return-Path: <linux-kernel+bounces-728774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0EB02CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F11AA0044
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531628FA84;
	Sat, 12 Jul 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZhCx5mB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A628ECE0;
	Sat, 12 Jul 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349823; cv=none; b=jKbPUBsn04BovRELrbJEyalkXI/oFqPcQcsqeNMi2fwPH8LiOavvbBQXx7VkOrDJkwTmPeaLxaEY5lrOWUzC1pCxNekxUp3UtVi4UxER+A0gZEWtpPZG7lMJddVSFaOb4qQVg+0hx/dTCf4TnUjyQPyT3AuQKlYC/i1LkafWGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349823; c=relaxed/simple;
	bh=zg5wCAX53+Zaz9D4ii0pAZ1fdfy4NlBPdESVNdjo6HE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNlblZ41uBGPTOtVNImm2s3oNC40sKq+mw2+vjx41fp/Q1rkBeg8FooymWohsgfGrVyYkZD4nsBN3V4+oKRc2bbx+r+PkMRcP3QiC1birVnkksdExKVaeyyKmJHV0OjgUuGyYbFdSu0YRlfbZS15z93lk3WK2BNDN+LfKfMBNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZhCx5mB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D4C4CEF5;
	Sat, 12 Jul 2025 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349823;
	bh=zg5wCAX53+Zaz9D4ii0pAZ1fdfy4NlBPdESVNdjo6HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZhCx5mBp1+DmVO9gPRsFOjjrVDd0+M7Ain/KZjwWiIFaBhl1BKhE8j6sB2AtTXxR
	 PexvP3cWaiJTTCJjphxyMs9xoWE/ppkV8kFIGVPzXhxA4u3yc+WcORyNFtvCdlDuEo
	 /bN3XYWiqcOscvlPbfVvtAXJPwfeK10ZeSlFaaY7rNxoZaS5q8RXDvR9WUG1+zlCiK
	 ku925kWoJlzXlxbA/lp10XKYE+knsMG1nEjJQZhTqe3wNPWv3MooACCzisIpaN5zIY
	 Cf6PUwW1mQRP4ixjBYA8P+xCd7toRYAU+L0Xly+rcSmwZIE/rw+znYZANQmk2J96e0
	 Td15cpGo/q+RQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/14] mm/damon/stat: use damon_call() repeat mode instead of damon_callback
Date: Sat, 12 Jul 2025 12:50:05 -0700
Message-Id: <20250712195016.151108-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT uses damon_callback for periodically reading DAMON internal
data.  Use its alternative, damon_call() repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b75af871627e..87bcd8866d4b 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -122,8 +122,9 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 	kfree(sorted_regions);
 }
 
-static int damon_stat_after_aggregation(struct damon_ctx *c)
+static int damon_stat_damon_call_fn(void *data)
 {
+	struct damon_ctx *c = data;
 	static unsigned long last_refresh_jiffies;
 
 	/* avoid unnecessarily frequent stat update */
@@ -182,19 +183,29 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	damon_add_target(ctx, target);
 	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
 		goto free_out;
-	ctx->callback.after_aggregation = damon_stat_after_aggregation;
 	return ctx;
 free_out:
 	damon_destroy_ctx(ctx);
 	return NULL;
 }
 
+static struct damon_call_control call_control = {
+	.fn = damon_stat_damon_call_fn,
+	.repeat = true,
+};
+
 static int damon_stat_start(void)
 {
+	int err;
+
 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
 		return -ENOMEM;
-	return damon_start(&damon_stat_context, 1, true);
+	err = damon_start(&damon_stat_context, 1, true);
+	if (err)
+		return err;
+	call_control.data = damon_stat_context;
+	return damon_call(damon_stat_context, &call_control);
 }
 
 static void damon_stat_stop(void)
-- 
2.39.5

