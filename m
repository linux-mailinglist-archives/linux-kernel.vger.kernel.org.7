Return-Path: <linux-kernel+bounces-826825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271FB8F6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F0F18A0226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F42FD7BB;
	Mon, 22 Sep 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGU2GMH7"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41792FD7B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528779; cv=none; b=s2/T2eLD2vISfX65W9abE5+m0Qk1Vz95QHGJVxHe2Auq3QJnzwBittj+6b3WynGAlS9d2rQzQL08WPr0LHBDwrMEtLwr0DeNZD5osgN56NNS5mSaqUejcPxKN14hN4Mf0J2l/BM47oVKcJP5v/Hs9OBdpZsjFlyyq0lcPOqqnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528779; c=relaxed/simple;
	bh=03intFBuR12n5Xre+XE44wZlrnRELjVcZ4XDVUx8RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUI8eUlPKTmMiSb3/Urw2/Pqw7MmxLoRvKfrM3QBZBuhPKQGWjfW/3qRT3e39oitZkrjVshvJOnk86UjVvDFwhue3I90NtyanMU73Ls0eBk2xTmEry7N5OrPTePYrb/Cq+wpPd+oa+on1MZXjwkh+Aw/MEUug+MLmcjHRo2gf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGU2GMH7; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758528775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zANDTeVI0tZPCMAhDyTdeSxz2VUrPHZhrCLKm1twdBY=;
	b=qGU2GMH7FB0mtYF0za+9l/X4OXqCrWNnwOBeXTriqDPIevQJOiKEiYIg/jPTMVckGid/VZ
	IjABKbvFELgsPxLFceBE0FJQGmsV59ZFOHrxxf2H3auZzg3ZUGIh9hjpr4zOxAWK/EVXxK
	I1xyAuFOsPwRInI2tqaS4ZymYII57u0=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: return -EMLINK instead of -EINVAL when hard link count exceeds limit
Date: Mon, 22 Sep 2025 16:11:36 +0800
Message-ID: <20250922081136.160829-1-youling.tang@linux.dev>
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


