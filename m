Return-Path: <linux-kernel+bounces-718916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451ABAFA790
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 22:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF05189C3D4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654D2BE050;
	Sun,  6 Jul 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu3ELqqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6B2BE03F;
	Sun,  6 Jul 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832031; cv=none; b=SUGpYWrvluh81GjISxZZvPSj4nt3j0r7ts9KWXCbw8LpN9UBjflY49jBRzAxamyVVaMg2YYe9TXUHksZtPn8pYhM6KTCsBwKjdA7DBtqX4M9wEtdyjA+JJJindU3yoeM7UVLjtNTTzborNbzd/U/t6asPnMnbP3sICPD3PFf6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832031; c=relaxed/simple;
	bh=4rlUnM41KWHBb9R2GQY7K2cpSu4qxxjH6BI9hmtiRvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+3bl7rT8YE13FNnDsOmPlflhrM5ev/C5xc6uCPWAU7GKQILEsn6wCAaJHGCoij0Pseqp7h+dRXPNJcIo32Ha21ihPcyLfDHLnoSkS3ihL1XLC6QgaG9rOL4IAPzM2dBpfBfcXvWNnQcL6l7VLDbuGs1boXPbp7f7Qu4C0X2jZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu3ELqqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E16CC4CEF4;
	Sun,  6 Jul 2025 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832031;
	bh=4rlUnM41KWHBb9R2GQY7K2cpSu4qxxjH6BI9hmtiRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu3ELqqOgQHEt+keoQhLPdyX8rut4DuHulVn/8mGyUWEU/HoEV6x7HOW6LB+FYDxV
	 5mBnMfXjCCSZvmMuV46mqNk836kS5ydl+Gm9Q/V6JwwrqTVZxa22zKsnQaoGo/Wi/W
	 H1uGWeVHQL9LQUONWb8bQoLI3KwTW/qfwaV2RMQ45ZdeTQ2v+CmihTF1JJsAMlyBXx
	 mWz0h35MWeAD7m6knzzPSJWx6J0VvPwy8TR7lH0JBgPwawURzjjeNkl9efYwGnM4aU
	 +aX8gaCSCNOP2RQgVjjXYj53/6Z1U+euVEuQstT3bMIOy1d/fCpkBqMhTw3dNHsC3X
	 lQbxy0NE8l+Qw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/14] samples/damon/prcl: use damon_call() repeat mode instead of damon_callback
Date: Sun,  6 Jul 2025 13:00:10 -0700
Message-Id: <20250706200018.42704-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prcl uses damon_callback for periodically reading DAMON internal data.
Use its alternative, damon_call() repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index d70f47924720..d3215699a5f4 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -34,8 +34,9 @@ MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_WSSE");
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
 
-static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
+static int damon_sample_prcl_repeat_call_fn(void *data)
 {
+	struct damon_ctx *c = data;
 	struct damon_target *t;
 
 	damon_for_each_target(t, c) {
@@ -51,10 +52,16 @@ static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
 	return 0;
 }
 
+static struct damon_call_control repeat_call_control = {
+	.fn = damon_sample_prcl_repeat_call_fn,
+	.repeat = true,
+};
+
 static int damon_sample_prcl_start(void)
 {
 	struct damon_target *target;
 	struct damos *scheme;
+	int err;
 
 	pr_info("start\n");
 
@@ -79,8 +86,6 @@ static int damon_sample_prcl_start(void)
 	}
 	target->pid = target_pidp;
 
-	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
-
 	scheme = damon_new_scheme(
 			&(struct damos_access_pattern) {
 			.min_sz_region = PAGE_SIZE,
@@ -100,7 +105,12 @@ static int damon_sample_prcl_start(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
-	return damon_start(&ctx, 1, true);
+	err = damon_start(&ctx, 1, true);
+	if (err)
+		return err;
+
+	repeat_call_control.data = ctx;
+	return damon_call(ctx, &repeat_call_control);
 }
 
 static void damon_sample_prcl_stop(void)
-- 
2.39.5

