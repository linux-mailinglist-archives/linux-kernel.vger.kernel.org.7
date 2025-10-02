Return-Path: <linux-kernel+bounces-839743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD3BB24DE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0643C4F95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8230145B27;
	Thu,  2 Oct 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkruCSmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CE487BE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370210; cv=none; b=sX/BuM4boj/zMnWRs9S7UirIok9TN85rEbn2suXg+0U3KRkIxYKTLuZaO1kfUY32qhFfXoS2+TptDPcxuZSOT0vrrW91P92jOUo6YU8TZE+c18PpSzqgcuAS2lNlIiGbuB0IYH1vjcmBkDltbaLWpQoarJUyrK77X/ZLcTyGTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370210; c=relaxed/simple;
	bh=01fYEaXX5bM/2w1XwUy+dhIFMUhIo7WDFLeTNVXFsrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCS7hasvvTnMetAJiI0ntN2amfJHBbGDduLNP0OQq82cjVKlB3ucCaY0GHly49fZNv84yR1cRsOnfyNH0b7enQKdgae5sZ+39rCyMynm61lh8WFEVpmw11ydyL23JSDKXszkR94TO3ClLKM+l8am8WJR29CVItjKae8pnFkBNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkruCSmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94086C4CEF1;
	Thu,  2 Oct 2025 01:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759370207;
	bh=01fYEaXX5bM/2w1XwUy+dhIFMUhIo7WDFLeTNVXFsrE=;
	h=From:To:Cc:Subject:Date:From;
	b=AkruCSmMOw8vqDIFrHAsV3BOcQ1PF+iWbhRcGgzyocDxnOCEJJ/5fxWzbi3c5OQKv
	 ak7j7Hn5xyUZcY6jM3lG//UohIYrwRAAp+XMh2c35K+svtDbj5B/CsiRxadq7WX1a3
	 E6X59Lod4eYIuQTwPrWmzs2hFR7eQ313NySUNIgDPZitikdAA6rL5/l6jNFPYfEKwF
	 CAmTxkomPaMsMkIoJCFJaECyuRWevIpKzOSvCJRTjxKS12WoXSuL5PDeM1V/cc1fFG
	 jVQA4ijrTwZTQgwslFC96OTDd1BvRwvuEDXzdmXnJDcqCZOZFAbbBCxHphqWe0cGYZ
	 M+sXttM/C/ivQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add missing dput() when printing the donation list
Date: Thu,  2 Oct 2025 01:56:45 +0000
Message-ID: <20251002015645.3588322-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We missed to call dput() on the grabbed dentry.

Fixes: f1a49c1b112b ("f2fs: show the list of donation files")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7992386fb9e6..6d2a4fba68a2 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1845,6 +1845,7 @@ static int __maybe_unused donation_list_seq_show(struct seq_file *seq,
 				(loff_t)(fi->donate_end + 1) << (PAGE_SHIFT - 10),
 				(loff_t)inode->i_mapping->nrpages << (PAGE_SHIFT - 10));
 next:
+		dput(dentry);
 		inode_unlock_shared(inode);
 		iput(inode);
 	}
-- 
2.51.0.618.g983fd99d29-goog


