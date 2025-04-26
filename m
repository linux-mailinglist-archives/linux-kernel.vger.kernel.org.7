Return-Path: <linux-kernel+bounces-621680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB82A9DCC3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6996B4A1B54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48625D53B;
	Sat, 26 Apr 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Fjv2xU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEF189B8B;
	Sat, 26 Apr 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745692858; cv=none; b=VhaLcSdTknKG/NpV+DsnJnrrG0o3bshlyHfn8xBwx/RiYf9nR7X5ZNkB6ogeci7qwkNsRgnyYrZCmdHABVOni4TNKTwYADGXOeBxj0jSpCnnc/VQ3hEJyTPpmjvZLbkkYPUs1Eli4OGQLnc85Me/nIsXR5ct7nuOZM81+iKKQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745692858; c=relaxed/simple;
	bh=ZaGIf7yCz3SC46Se03VJ0gSeERyiwwtS+yB+BWbbfOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thxGVyca5tEWKVlKM98E6rUqEcfcFtx2nggfA19eJl3LBNwUcS67YFMTC4YmOudqxP9QAi3jOwvWhDv77FnVvROkanGFuAPW/7YDppHv8k0HyZxbbEwVHZewE0rO1Scm3MT+mWRYLwhxyCfqSocMHAiTJ0FRwsqFcpQSrBV5vzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Fjv2xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A30FC4CEE2;
	Sat, 26 Apr 2025 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745692857;
	bh=ZaGIf7yCz3SC46Se03VJ0gSeERyiwwtS+yB+BWbbfOU=;
	h=From:To:Cc:Subject:Date:From;
	b=g8Fjv2xUKNIiqh8HwqWJiwBILyX6i9CuX2Pm3kqVOsuHLfyb+WoVpJ9/EhzEm/K+y
	 GMpe6JwDbk/3EbZaxPeJkVod93is1YBfHZFMDiFcSsV0l1S7VKZN2YYRoYp0cXMCnc
	 QV4LueADtGbhgj3fe+yaXGGVbT53G5s0q7ArsudSKgOYYUE0iwEjVjfp2SYpVf7/W7
	 /Se55mHoeG+FloRcMqvGgch3QYvXv3SGK+zY6qlVWG1y81LGhYxkMTXPcvLMENLgMo
	 pSlaQ/LmCH19LALnxOfsSF6ypOGVYXg5JhmNU8uk2INCAY3JtlvuELhdDKl2uip2+R
	 3oetxv7mr/X5Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable] samples/damon: trigger build even if only mtier is enabled
Date: Sat, 26 Apr 2025 11:40:54 -0700
Message-Id: <20250426184054.11437-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtier can be built only if one or more of other DAMON sample modules are
build-enabled.  This is because commit 66001f0476f4 ("samples/damon:
implement a DAMON module for memory tiering") on mm-unstable tree is not
connecting it on samples/Makefile.  Fix it by adding the connection on
samples/Makefile.

Fixes: 66001f0476f4 ("samples/damon: implement a DAMON module for memory tiering") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Makefile b/samples/Makefile
index bf6e6fca5410..0545e6a0e84d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -42,4 +42,5 @@ obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/

base-commit: 863dea93e0e1e959d3b277a98781081442f9cfbd
-- 
2.39.5

