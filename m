Return-Path: <linux-kernel+bounces-818406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE64B59151
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582EA523B62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483D2857F2;
	Tue, 16 Sep 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDIGtnux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D22641CA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012771; cv=none; b=C+bEaggp33XXIRg7nleZFCdnYgD+xu73xha85bWTmhywG9hianxZWn2KKDHqgtJhrNmP4Qv9EpZaHbaqHAoGugBSO3UAee+hpDsA9bttdfSHXjl+XojEZfxw9xknUgW3OzmEtGAjP/x3cpL0Oijjem5JDuKhRQSgF0G69HkFFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012771; c=relaxed/simple;
	bh=l+/RfK5g9GcKZEi3R7jcYPPpt2faVDSXRVeA7XJaeK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH7rn1EyRPDpWLXDKXsG9l27Wurgp98G1Jv1JiKQ5E7xju+TN+bVEN1a5XnxtRFxVo71NoQi9svllB64xkLOwyKsU9F+HDek6gfEvkG0LVV3ZygEmEdPDa0wshUa9aLktERikq7DZsQLqNjynDChX+zCPeEFiMdr4TeVrjXC5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDIGtnux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE5C4CEEB;
	Tue, 16 Sep 2025 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758012771;
	bh=l+/RfK5g9GcKZEi3R7jcYPPpt2faVDSXRVeA7XJaeK4=;
	h=From:To:Cc:Subject:Date:From;
	b=UDIGtnuxXKhrcfFxMujVhMcCkz+lFOPx+UXHahOdQKUTYvwK5ib5XvpKX1DD/4YVr
	 sKAtzo8vSa8l/0iIu13rpb2Mhs6urb5HWLHZaG8gpFtTj9AUzftvTB6Eu8XwJ6SH3x
	 lK2h6cSUnNVzSRtrsfsm8cR0AUGNO2Y1YGbc/da8cHbLpN51FqVksa6ijWold2JeTy
	 UqMpS858IUl8TGpQYbIPQoplKiqebGltNX3PIB7gp771vGxaJPJGFYl3Klv7MeN3Sk
	 PfGPXrMTwYF+hHq5e8g5bmBHYVxvNAjn2IcX2yJUaU+EMle3fQbRynk7WWLnWp/BAi
	 cAsSF97WaB8bw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	wangzijie <wangzijie1@honor.com>
Subject: [PATCH] f2fs: add sanity check on ei.len in __update_extent_tree_range()
Date: Tue, 16 Sep 2025 16:52:43 +0800
Message-ID: <20250916085243.4165099-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sanity check in __update_extent_tree_range() to detect any
zero-sized extent update.

Signed-off-by: wangzijie <wangzijie1@honor.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 199c1e7a83ef..3070d1cb0676 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (!et)
 		return;
 
+	if (unlikely(len == 0)) {
+		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
+			"extent [%u, %u, %u], age [%llu, %llu]",
+			__func__, type, tei->fofs, tei->blk, tei->len,
+			tei->age, tei->last_blocks);
+		f2fs_bug_on(sbi, 1);
+		return;
+	}
+
 	if (type == EX_READ)
 		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
 						tei->blk, 0);
-- 
2.49.0


