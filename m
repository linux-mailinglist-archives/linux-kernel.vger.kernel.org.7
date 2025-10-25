Return-Path: <linux-kernel+bounces-869929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C4C0905A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AD614EB4C4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8042FB62C;
	Sat, 25 Oct 2025 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qTkN+v8v"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A52F3C23
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395550; cv=none; b=PoLuuwkBAR8vcTJxK8FFPfZvCC/+6QynVifXMoJ8VD685efi4+9u4yT7+B8dPuLWEerQjKTedimNg3CEfFbJ78My40R4qRqCGFx3Hg+P2xwXOT0i0zwEboOAawJIz2xMAszHiiD/5r4Pm6oWNn9OaEvpKIFJ5bAyK1NN4ZxQDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395550; c=relaxed/simple;
	bh=bKtCQZeY01x+B2cRHqvjTuXRaaYy/xhx3/4vV8NPOdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UguHmpbZThEvqZO9z0t7IzAPxXkGdjIgM/r3zZ+PZENEyTirouCD82VXXdJCynrK4PXr3+gP+ycO5lMksn7lyt/jozl0crCpTxbU908op91HXR7NDrk6o7gUGD19FKpmWQDvUrnptatus4FvUgsBX/qF/u24Iz/gHmzkkWSNc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qTkN+v8v; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761395540; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8qkCxbBowUMsv9z5ivWjwIJlzY14VXRnGA0epcgBQak=;
	b=qTkN+v8vDFGgWbofYR+fpbbY1AazPGuYeYbVJckNFqCMMQHXHxz05pnxSzD90nMrjFVYsb/71HoOVJmbY3WOPbXv77BVKxzDmAudockSzkLFUOmhOl/COgNMIbfARWL6TXvMCG6fspFO6tgdLXw/EpBAMnRTyeCoE8G8uBON0WM=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wqwts6-_1761395539 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 25 Oct 2025 20:32:19 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ocfs2: convert to host endian in ocfs2_validate_inode_block
Date: Sat, 25 Oct 2025 20:32:18 +0800
Message-Id: <20251025123218.3997866-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251025123218.3997866-1-joseph.qi@linux.alibaba.com>
References: <20251025123218.3997866-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to host endian when checking OCFS2_VALID_FL to keep consistent
with other checks.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 0a0a96054bfe..dc4044a565b5 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1481,7 +1481,7 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
-	if (!(di->i_flags & cpu_to_le32(OCFS2_VALID_FL))) {
+	if (!(le32_to_cpu(di->i_flags) & OCFS2_VALID_FL)) {
 		rc = ocfs2_error(sb,
 				 "Invalid dinode #%llu: OCFS2_VALID_FL not set\n",
 				 (unsigned long long)bh->b_blocknr);
-- 
2.39.3


