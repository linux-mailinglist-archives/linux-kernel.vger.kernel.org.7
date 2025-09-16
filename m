Return-Path: <linux-kernel+bounces-819603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD68B5A393
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DD016DF71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C558283FF0;
	Tue, 16 Sep 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkgvyzH7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3131BC8A;
	Tue, 16 Sep 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056803; cv=none; b=Yk1lOjvrkIAgeCssFhIpXNMpyIbsMHf/zDJtjZXkbHkkSZfxQFqKbEeJYYpJfjv1n34SWzk5LhxdwTywUr3y6iDD5Jo/SOOefwSgZsxURFKUiAoExGywI8US5tdwE5eA9mNTVYBpJKTeMwZqdIURic/G/3AWQzHB0nBMWswKBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056803; c=relaxed/simple;
	bh=FKML9B+xutopDFpliFQu8+zNb4BvyiQsZ0gb3XSNvlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GM5f80k2xgWGgeyVd6QvWdCBjQnnG/z0lo+4GgAa6c3dAw+W0CsHgrWm6G3SQd6ekGVHMNoE/7Kpw4kVPjxNvy5E861zO1SKMQih963Ujokdccl9Ajy6bxsmQMNT6y3dnDh0x8l1sHLFs9PwKK39K08HOYEXbtSAbFLvWrCZI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkgvyzH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4119AC4CEEB;
	Tue, 16 Sep 2025 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758056803;
	bh=FKML9B+xutopDFpliFQu8+zNb4BvyiQsZ0gb3XSNvlo=;
	h=Date:From:To:Cc:Subject:From;
	b=YkgvyzH7h4oIYIZqK4VlPI7lvX/aPg7Nydan1K0rJKtBXM47LgRSroPFkzsfrRftD
	 l3eCitq+Ny8yTZkiGieU7lVOBCB9b9x0feBmqyOpKm7qZXPisWzthkPUcChmaD1iQa
	 bOhze5yRM0PB300OuyBBj0Bnho2T9bk9l+wgWcQIyPhRNq+qZWiAqSAzvIDWvtS4Bs
	 Xg4HmTVMYXwkwlUDQu9eXmpnlatM/d4p9cpo6Qbrizf6K4pRu3ru8ATa9BF3hoMJb/
	 dKuGKoZ4FyUROOnmF8lwOItyejj7Xzx8L2sscol9Gd8wlZrFDnhCuro4l8LZ3GLJyI
	 Dgdi3S8TXiPjg==
Date: Tue, 16 Sep 2025 11:06:42 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH sched_ext/for-6.17-fixes] sched_ext, sched/core: Fix build
 failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED
Message-ID: <aMnRYuUvbYsc9S2L@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While collecting SCX related fields in struct task_group into struct
scx_task_group, 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct
scx_task_group") forgot update tg->scx_weight usage in tg_weight(), which
leads to build failure when CONFIG_FAIR_GROUP_SCHED is disabled but
CONFIG_EXT_GROUP_SCHED is enabled. Fix it.

Fixes: 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct scx_task_group")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509170230.MwZsJSWa-lkp@intel.com/
---
Peter, I'll apply this to sched_ext/for-6.17-fixes and send it Linus' way.
Please let me know for any concerns.

Thanks.

 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..ccba6fc3c3fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9551,7 +9551,7 @@ static unsigned long tg_weight(struct task_group *tg)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	return scale_load_down(tg->shares);
 #else
-	return sched_weight_from_cgroup(tg->scx_weight);
+	return sched_weight_from_cgroup(tg->scx.weight);
 #endif
 }
 

