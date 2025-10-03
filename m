Return-Path: <linux-kernel+bounces-841747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32455BB81DE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79CE19E1E74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802E2561A2;
	Fri,  3 Oct 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5WhN/8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE324EAB1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523937; cv=none; b=OJxSOdd3YrguzzPht7XqefN0rKuVGkEKlOu4Ah7F7BR1STbtGv8oP5La89udXIFlP7QdAPCSVbMYvueD7f78lBE60FzB0QDH50U3PpuLBGzYuki5nxiKk2419T2HRfQlm1U6HJhgyCZWoUQ3U2xGvgbp7M8Sbyxjgt5xlsmrzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523937; c=relaxed/simple;
	bh=NgT9HuawGnR8STlvRUNA5Z4q86GZ1SZe6LmbwqF2RCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqXO0x2zVsP8v4qL4SFbX8MQXG4wdweg5pxPbK0O1y2PYUZGsxG0905yDfwZvvnm54+NFtVgW7JfJJ5xa7XpqZonRWRsuOjovxvtrUQMG0GWAUtskgg1/S23jrFAYDOJbG1E45VcCcNYYqMqUXp0n1C2KAiF9K7hfb2sWGVfZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5WhN/8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29012C4CEFA;
	Fri,  3 Oct 2025 20:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759523937;
	bh=NgT9HuawGnR8STlvRUNA5Z4q86GZ1SZe6LmbwqF2RCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5WhN/8/0/J9r/s9eimc704yu7UUGyVuANQo1hLuh6QEm1xUCf3itmIaTm9dMmk/x
	 K4DCJnrUJ/SPeFUe1tRkOJ3zKRJe7Zs9XJwduKRZPGyFM6p2ae3syfmcP5VZxJiaj+
	 VzCVZlk3QUZVyskHaD1GEzX6V+juOdDk5WQoi5rZ328Zd/firom/7VV0tB42+wmzpo
	 2qUVzVWfUuSo7JorfDCq4TQjXBeTJM9YUQBDAHGGm6e8BNgwbxzzIvqoxxTNC/uMcB
	 BEzykhLqaJl4+qFaSsuDrn8J+EiR8WuKD6ti2MiR+qPP5qeye0NwL71X1aY+GnvdMd
	 7BxpTAm2uqQzw==
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
Subject: [PATCH 3/4] mm/zswap: s/red-black tree/xarray/
Date: Fri,  3 Oct 2025 13:38:50 -0700
Message-Id: <20251003203851.43128-4-sj@kernel.org>
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

Changes made by commit 796c2c23e14e ("zswap: replace RB tree with
xarray") is not reflected on a comment.  Update the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6b1c8832a4f..5d0f8b13a958 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -175,7 +175,7 @@ static struct shrinker *zswap_shrinker;
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * swpentry - associated swap entry, the offset indexes into the red-black tree
+ * swpentry - associated swap entry, the offset indexes into the xarray
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression.
  * referenced - true if the entry recently entered the zswap pool. Unset by the
-- 
2.39.5

