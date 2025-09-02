Return-Path: <linux-kernel+bounces-796424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A7B40073
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D7F189D0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF212FABF0;
	Tue,  2 Sep 2025 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9j6pB2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FB2F745C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816050; cv=none; b=uDxRqhhQawbb2iTB+F46vbfCL0sPyEodLxMdMesYtTnE/JWx6BGk/lr6J+l9YzbWK1v9Pk43KquM9KwR+szezakBk6Mv79VwxjxVvJ11XRvi1EQ7NPoqb60uo80uiI0/7DYm7Mv61KoEy6mi0kqy2iKWjbRXlJXiJU2HsADuCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816050; c=relaxed/simple;
	bh=SkEzvjXJB8k1VwWANxpWR/5w4miCis0fDo9h2eYkSE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmvdpBuT4ZZUfIz8GYLQAYwRHo1vHKkfKgCcLodAd9iaeqlGkgTGqOiccBu/0+1mO41sWS+2sgMSfx4hdTG1frOUA1S03Zb0F+kz5/iyNNHhTkbUspDAPEJPI2eH7M7lbVgrhjRjeiXXlZ1AuM8D/G6d29xsbP2Did7PmFICGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9j6pB2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD89C4CEF4;
	Tue,  2 Sep 2025 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756816050;
	bh=SkEzvjXJB8k1VwWANxpWR/5w4miCis0fDo9h2eYkSE0=;
	h=From:To:Cc:Subject:Date:From;
	b=L9j6pB2dBvXf42I8CMjdOnguCCxQYscb4rFJ+RdnyKthJKvdFLA8IfNaU3mj9K6f7
	 nyiGcGd2PTxvSxD9Us67TO4RiP4MM8X0mDoTOlBmplBNkrqO5JLwCm53Y9Z9cQdNUp
	 QHG78kDL3buILstxzjrOe02q9juh4ufETn9LLR9AkdWLgDJ2MMvmQ1/YiiYewMiw/E
	 ZAeloMrHlEqi8i9dF4NjI6qzPUa3yx1jlrF2LNirB+f2FYbBbLLC4Y8feHavqRwgP2
	 KmpMEPTPG7leAHhIt/A9bjcdgOVyFaZ+3kKF4KAQ9p0VuOz/1wg/z5nrHt3dq4ReOJ
	 1PWXYN3YGzdOA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid unnecessary folio_clear_uptodate() for cleanup
Date: Tue,  2 Sep 2025 20:27:19 +0800
Message-ID: <20250902122720.2750481-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In error path of __get_node_folio(), if the folio is not uptodate, let's
avoid unnecessary folio_clear_uptodate() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4254db453b2d..482a362f2625 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1570,7 +1570,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	if (unlikely(!folio_test_uptodate(folio))) {
 		err = -EIO;
-		goto out_err;
+		goto out_put_err;
 	}
 
 	if (!f2fs_inode_chksum_verify(sbi, folio)) {
-- 
2.49.0


