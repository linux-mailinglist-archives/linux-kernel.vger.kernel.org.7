Return-Path: <linux-kernel+bounces-841745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1231BB81D5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56DE19E104A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B72451F0;
	Fri,  3 Oct 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVv4/lhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41C23DEB6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523935; cv=none; b=eCs0/jI/v84hP34ygcqQrzvDqyy3WyIIz8bG9fg2Ycn1obWuWSwsC6fFqRlYPNB+9rn5qMhhnaWlM5kwNFYrN1vTfRILDsselXVZvSCwdWmX7SMKBXRh3W7uNRo2T7lmVfO3wASVMeVsx0KU1OkXswEusCVRTg4UVAyjvxiB3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523935; c=relaxed/simple;
	bh=QYf5NoN4iCNnsX/4rgyF4h8KGvpOZHNtyc2i/D4d3Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw0AXqyBBjhMKzrBN2+sKWi/yjMrG9bSsmOwwFdGPfmCBeI8SA/eNc55kOhWiXqPnBXY1Xllzkg5VGJb2IKqc89FcFPjXz6axN5RmPT4QScoowAB9r2qkHjwLoOo3lHc5mTSKlT5tdBcQsAdmBF2v2E+Sxy7KcUGDXSriqEakQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVv4/lhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD7FC4CEFA;
	Fri,  3 Oct 2025 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759523935;
	bh=QYf5NoN4iCNnsX/4rgyF4h8KGvpOZHNtyc2i/D4d3Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVv4/lhP7CXRVGS6gZXty6SM2CuqqWMtV94l7WDc//YwsLdWRvA9OSEMFefrhAIc8
	 eD+0MkFrUaBHnOFc9MuMxvL1iv/8mtrG8Ant8Og95++U6GIAgmNKogDidifzS0tHlJ
	 Qq3b3jfvhfLTtBfMV94YLQ6Y3hwNn1ZBNk9jjHiFhOwXOWUYPudbac5AyJaX6QC+4g
	 tY9+XyBWcrd7FuttcbI76cyHxqzDkf1l8ZwzoyXp/dM0VPZutwFpp0yKW33ddZzQhP
	 EH/lKPXUi64pNrLFlO9IYbWvxwLUsAkbVfTSleDoDk04Cwd7/XjIobzm7g7poJJcIa
	 DEmVG9WD9KLeA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/zswap: remove unnecessary dlen writes for incompressible pages
Date: Fri,  3 Oct 2025 13:38:48 -0700
Message-Id: <20251003203851.43128-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251003203851.43128-1-sj@kernel.org>
References: <20251003203851.43128-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incompressible pages handling logic in zswap_compress() is setting
'dlen' as PAGE_SIZE twice.  Once before deciding whether to save the
content as is, and once again after it is decided to save it as is.
But the value of 'dlen' is used only if it is decided to save the
content as is, so the first write is unnecessary.  It is not causing
real user issues, but making code confusing to read.  Remove the
unnecessary write operation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index c1af782e54ec..80619c8589a7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -894,7 +894,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * to the active LRU list in the case.
 	 */
 	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
-		dlen = PAGE_SIZE;
 		if (!mem_cgroup_zswap_writeback_enabled(
 					folio_memcg(page_folio(page)))) {
 			comp_ret = comp_ret ? comp_ret : -EINVAL;
-- 
2.39.5

