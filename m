Return-Path: <linux-kernel+bounces-833515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F850BA233E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101AD386A97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB825A34F;
	Fri, 26 Sep 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BNiipk4o"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D6258CD7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853423; cv=none; b=lqgbEmMGcCjBEjT0714kVEovLfFIuHImP/viBUsG8yHTxyKjUq0XBh7y2UxnZmGcexkLj7rD9eS0Ky8XZWAy25XRfwUMfe7E4cQSqj4cQ6z9xtYLSx/yzTCn6niyUqLGfGVEyulWTFnOXYymoumeT323ndCZcTqgBL39550oysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853423; c=relaxed/simple;
	bh=03intFBuR12n5Xre+XE44wZlrnRELjVcZ4XDVUx8RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWO6r4Y0Y+zG0T2E05b4Gki1/tyfckiqkD8D6ZiN5fvwX2jRUXKtQLxFWwiZXL3YjQcb3OJrtYQDSJhRbcRXsW2PNZeRUuBrVgXqbM/4QRGmpfjATS3rXveLX0qrYYK1+XcYyivubWJsmTlkXUvRpKHNHHUVvovylQfj9iNdlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BNiipk4o; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758853418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zANDTeVI0tZPCMAhDyTdeSxz2VUrPHZhrCLKm1twdBY=;
	b=BNiipk4o8RtLlbVthb7EA9hU0SJLmSFpohGEW5ezyJfim+VwLZdkWU4x8NQi70LoQZp6Fd
	2bGIGolWRjTxuwtatvCerlYAt8LxgIHcU9/Qzc2cqiTyBE3R6HqS8DB5m7x8/me+6jSLEw
	IYHodkPKh4i2DU+erMxd4G9pAxLusXg=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/3] bcachefs: return -EMLINK instead of -EINVAL when hard link count exceeds limit
Date: Fri, 26 Sep 2025 10:21:48 +0800
Message-ID: <20250926022150.493115-2-youling.tang@linux.dev>
In-Reply-To: <20250926022150.493115-1-youling.tang@linux.dev>
References: <20250926022150.493115-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Currently bcachefs returns -EINVAL when the hard link count reaches
U32_MAX. However, -EINVAL is a generic invalid argument error that
doesn't accurately convey the specific "too many links" condition.

This patch changes the error return code from -EINVAL to -EMLINK
when the hard link count limit is exceeded, providing more precise
error information to userspace and making it consistent with other
filesystems' behavior.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/errcode.h | 1 +
 fs/bcachefs/inode.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index acc3b7b67704..b22a694ec750 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -215,6 +215,7 @@
 	x(EINVAL,			varint_decode_error)			\
 	x(EINVAL,			erasure_coding_found_btree_node)	\
 	x(EINVAL,			option_negative)			\
+	x(EMLINK,			too_many_links)				\
 	x(EOPNOTSUPP,			may_not_use_incompat_feature)		\
 	x(EROFS,			erofs_trans_commit)			\
 	x(EROFS,			erofs_no_writes)			\
diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index ef4cc7395b86..5765144b4d65 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -1193,7 +1193,7 @@ int bch2_inode_nlink_inc(struct bch_inode_unpacked *bi)
 		bi->bi_flags &= ~BCH_INODE_unlinked;
 	else {
 		if (bi->bi_nlink == U32_MAX)
-			return -EINVAL;
+			return -BCH_ERR_too_many_links;
 
 		bi->bi_nlink++;
 	}
-- 
2.43.0


