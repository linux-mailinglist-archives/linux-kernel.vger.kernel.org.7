Return-Path: <linux-kernel+bounces-797480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E3B410EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFF5540DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311692EA74D;
	Tue,  2 Sep 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHDG9KrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2892EA492
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856904; cv=none; b=lPAH1tizugirAV5eKr73NoO8Zwcky3tgTuUWBw+oS7S9EDSRex4TuRRM+TIjj4FYOEE/109lrVBj0gq7t//d4kZ0jI/3e1cfJnH5cH5D91ohkLXx6CfOutol4ZHfbfnbZnAKGCvwI7voCz5eXx5B+DAFhdToLZGg2qbYnmSx/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856904; c=relaxed/simple;
	bh=IbuCInOCoGGlnGfyq6LjHZJqWe+lMG9Z3qxmnM1grb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxOZxgsYqMDzNEYllSlhm6ZIetpeBwopQeCiVmVEIhoTrEZliS5000pkzk1k2DiH/Eo9hJVsX0m6auCI6BUVeKALeoO3CFR2s6K9ZCCarcw6fKEmaHdeF5MiH18ZdD4t/y4CRpjmTPmO8DalSKpyiLsJjh+ZhlHWB6HnSARDKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHDG9KrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16311C4CEF7;
	Tue,  2 Sep 2025 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856903;
	bh=IbuCInOCoGGlnGfyq6LjHZJqWe+lMG9Z3qxmnM1grb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHDG9KrB2aJoEFmopXKk/HHgFdqnYpnyCdeSqTcdVbtphJ/RJ++zHrEActN/Sefhs
	 2aogKBU2NjPd4Z5I2snVTa8zEiUPFe5zCgNcyELOiFkv2DjTrmEZtAZqpqFkjHqKgd
	 kHrTGnIIW/D9fOUOK1ux0AKBam2tZQXOUSv7iGQ7wRPHzPJq017lh3/thPeYwDJC12
	 1TPc3HSyJZkombpLVRFMhhY7Tyh+m/yxalj5vMWXRRFN4AxYKAh5bYdNk9x4XN8i9J
	 5XprvllfJ0QRhv65LqycXAH8rxXMM5gtsd9HSQV4Ouyjq0bH+9ZTqXCoyvu4mJ6rsf
	 rmcocGaJhC+uQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Keep bypass on between enable failure and scx_disable_workfn()
Date: Tue,  2 Sep 2025 13:48:04 -1000
Message-ID: <20250902234817.279206-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902234817.279206-1-tj@kernel.org>
References: <20250902234817.279206-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_enable() turns on the bypass mode while enable is in progress. If
enabling fails, it turns off the bypass mode and then triggers scx_error().
scx_error() will trigger scx_disable_workfn() which will turn on the bypass
mode again and unload the failed scheduler.

This moves the system out of bypass mode between the enable error path and
the disable path, which is unnecessary and can be brittle - e.g. the thread
running scx_enable() may already be on the failed scheduler and can be
switched out before it triggers scx_error() leading to a stall. The watchdog
would eventually kick in, so the situation isn't critical but is still
suboptimal.

There is nothing to be gained by turning off the bypass mode between
scx_enable() failure and scx_disable_workfn(). Keep bypass on.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7f799345c899..fda2b4e85ee3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5794,7 +5794,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 err_disable_unlock_all:
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
-	scx_bypass(false);
+	/* we'll soon enter disable path, keep bypass on */
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
 	/*
-- 
2.51.0


