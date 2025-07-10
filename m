Return-Path: <linux-kernel+bounces-725122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC6AFFB08
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF555678FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BD28981B;
	Thu, 10 Jul 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdnGQlBQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517723E25B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132991; cv=none; b=Dwrt6Q8mbgSO+P0E+LX6vfimkQoqJRk/fJztDbigE4GSTdRMyZNN5ypDb+Bjjr7JfuLk5BXOGeLmOJcaw5CLjVthKgXSv1HxyHmPpZQ7dZWZ7BU2Dzb7rKuvvLb5+3HVCWC5haXDepDNeZ2VzbS8jlPEgmeBgNFB5rWnHEpPU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132991; c=relaxed/simple;
	bh=GMlzRaxdgPmvNaWpauij4PKvNlwpIxfD/Me2XO52+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1Ld+IFYL+oZ2O38mniePOXzrMtKcfO0jr3nDA/yBrqFqukxOI7RoBzeCUU3bljweG9zkasAkJRcvCihcR+xb7NFU6KWGLoSoL6JiFFDwGjp/qw7753G6sXnnF7qQMwIYCm/k0rnFMHBjzUk/2DLIfpGcsnh9kRnvqHDyrdI9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdnGQlBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4448FC4CEE3;
	Thu, 10 Jul 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132991;
	bh=GMlzRaxdgPmvNaWpauij4PKvNlwpIxfD/Me2XO52+XA=;
	h=From:To:Cc:Subject:Date:From;
	b=LdnGQlBQ/PjAKADHhN9GqTbXiiwJoMbuB1Etc4dBbZOg5TULyRfBX/zWv+DeOIB52
	 BX2wB7XJ+DNRUoqyBfMK0ulwfVrlQ1v4Ul7lv9s1LczYOspq8PwISWwoA/sEysx6SI
	 jdUw9REfMjctqRbeyD5suIdyIgV1JuSZ3w1ZTD7rKl8X7FVh11chPzcmXsOY5KS+jD
	 xTfUQMgTIOxNK5c23Ui3bzPes0k2EDc2/JFBsvOey2IhnCpI/bRhv8QWYgkcNyv9oh
	 l0bj5WlevUB6qrobgyHnJSA8LSowhs1Y4BsS3XBJYHjNej5p3elzXBUWpG1mSThX0B
	 rlA0aPqCAl2Mw==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] erofs: allow readdir() to be interrupted
Date: Thu, 10 Jul 2025 15:36:18 +0800
Message-ID: <20250710073619.4083422-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a quick slow device, readdir() may loop for long time in large
directory, let's give a chance to allow it to be interrupted by
userspace.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 2fae209d0274..cff61c5a172b 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
+		/* allow readdir() to be interrupted */
+		if (fatal_signal_pending(current)) {
+			err = -ERESTARTSYS;
+			break;
+		}
+		cond_resched();
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
-- 
2.49.0


