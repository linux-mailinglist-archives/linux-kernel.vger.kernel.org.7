Return-Path: <linux-kernel+bounces-738709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C0B0BC29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCCB7AB49F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD581F3BB5;
	Mon, 21 Jul 2025 05:56:56 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78503D6D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077415; cv=none; b=WUxt7z3KCGN9XOM8pHraCZsCSkRKVEixeaev18K+i1WtXKRMQ/99NoGaPKQbRx5+AIR78Br9D+ZSOiJzJxrEZwLK1X8XCRUJ7yV0q9Kd19RNTZJLhCdVz2Ztpu1yliHpsi2BXakWCtGxLTrxLbzOIxDOjyF/CCetPT++qvpismM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077415; c=relaxed/simple;
	bh=jJYLsxdyvXzA4IcG7R70vGi2itW4jRnXIxJkt9r9GHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mi6a63+g/zTv0X4mukGnsK/vhJNMJLR7o3KnavrA1a+aj7dy6PcRWmfoXfLBSk6FeptdbM0JhbObVEtKvtpVonK1qzkVO6SMllAEUfrm2I2Oi2jc33JDP5NgKUIQ5tKtiBtsr4kirbIB9L9NdE9JwOCWGzajvysfOmedRmlGhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-057ff7000000aab6-de-687dd3149380
From: "yohan.joung" <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	pilhyun.kim@sk.com,
	"yohan.joung" <yohan.joung@sk.com>
Subject: [PATCH] f2fs: zone: wait for inflight dio completion, excluding pinned files
Date: Mon, 21 Jul 2025 14:41:34 +0900
Message-ID: <20250721054135.1919-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsXC9ZZnoa7o5doMg18bOS1OTz3LZPFk/Sxm
	i0uL3C0u75rD5sDisWlVJ5vH7gWfmTw+b5ILYI7isklJzcksSy3St0vgyvh67idrwS/Wimtf
	u1kaGL+ydDFyckgImEgs+XOBEcY+sX0XmM0moCHxp7eXGcQWEdCUONI5k72LkYuDWaCNUaL9
	aBMrSEJYIFRiw8eVYA0sAqoSjzp62UBsXgEziWlbm5ghhmpK7PhyngkiLihxcuYTsMXMAvIS
	zVtnQ9U8ZJVoWMgHYUtKHFxxg2UCI+8sJC2zkLQsYGRaxSiSmVeWm5iZY6xXnJ1RmZdZoZec
	n7uJERhOy2r/RO5g/HYh+BCjAAejEg9vAUtthhBrYllxZe4hRgkOZiURXo/jVRlCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGF0EpXZ+u6p7/HZwT9bB
	JO+Dh3eLua5iOX1i8/KLlZo63rfzC8qVnGZc5PI1Xv31zI4f3gmFdacUZ+/4+7CSif3H4o0L
	DB8tCGg/Mn/vbTlXJ+msTx6aIr3JhYV+bNo6en8ly9cp8h17Ee88M+Kgw4M/UvIPrSO7HlnJ
	2P24IZ/Plpdi2fM8XomlOCPRUIu5qDgRAKg9BHUjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsXCNUNljq7I5doMg++zLSxOTz3LZPFk/Sxm
	i0uL3C0u75rDZjFh7lUmi/db7zE6sHlsWtXJ5rF7wWcmj2+3PTw+b5ILYInisklJzcksSy3S
	t0vgyvh67idrwS/Wimtfu1kaGL+ydDFyckgImEic2L6LEcRmE9CQ+NPbywxiiwhoShzpnMne
	xcjFwSzQxijRfrSJFSQhLBAqseHjSrAGFgFViUcdvWwgNq+AmcS0rU3MEEM1JXZ8Oc8EEReU
	ODnzCdgyZgF5ieats5knMHLNQpKahSS1gJFpFaNIZl5ZbmJmjplecXZGZV5mhV5yfu4mRmCI
	LKv9M2kH47fL7ocYBTgYlXh4C1hqM4RYE8uKK3MPMUpwMCuJ8Hocr8oQ4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYFwg+ECLSXziDv13H6unGb1waZtl
	mZiX+GTlkbbziovWm2Un9h1s1FrptMCo+lXRgU87N866EvrpYZTFp1n5zG912daceLxc/8Ok
	W68OFQfsuDnvjFJLrJ7UA1kWQ8nOK1O0tp85YrBz9X6WHdVbeFiE35soqPCkCH9dX/Tlctn+
	BX5sbso3WVYrsRRnJBpqMRcVJwIAtLdvag0CAAA=
X-CFilter-Loop: Reflected

pinfile is excluded as it operates with direct I/O

Signed-off-by: yohan.joung <yohan.joung@sk.com>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4039ccb5022c..cac8c9650a7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4844,7 +4844,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	/* In LFS mode, if there is inflight dio, wait for its completion */
 	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
-	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
+	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
+		!f2fs_is_pinned_file(inode))
 		inode_dio_wait(inode);
 
 	if (f2fs_should_use_dio(inode, iocb, to)) {
-- 
2.33.0


