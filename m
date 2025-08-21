Return-Path: <linux-kernel+bounces-778806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC1B2EB62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E91C88910
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBB2652B2;
	Thu, 21 Aug 2025 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klvBs9Ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF0261B91
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744033; cv=none; b=oK3sRXTvYZ5OfOHiXKsALrEbIcwFhvDbHHvAz14xaekWTfcpav2lDfJms+yGLJHMpj2ZgYrwSiZgwLTjahAM7Alh1f7FUllRcPY7MM36LAXen7zgYWvLIBvK1G9Si3FHxIkbidENoWF0DP6cZhMjb2FzN6zVk5RVFJ4O8m8x45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744033; c=relaxed/simple;
	bh=aXuO83ahAy8rkUHy5j81fv7qlC2lpPGnmdUGTUBiO8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RGtuoaNPhu3xE1zpLVh4Ct9aQrMhu3CZyS9h12yQROAyVuhTIneuV2r9gqD/4XreT8JUaOGoEyJnIaE2yjr/ipubL8K6l2v0BiaJPFiSsVJlFLuyn5o0dJAi7ZALW9pxTaaUphYNmVHi0TWCf74lPS1wrgMyjqqRRyCi/jwPDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klvBs9Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6BD7C4CEE7;
	Thu, 21 Aug 2025 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744032;
	bh=aXuO83ahAy8rkUHy5j81fv7qlC2lpPGnmdUGTUBiO8M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=klvBs9OvrurRM+E8HLuGqZwoh9MOyRL2SVnGznpgOxR4SZZuS1VMDC1qTP2mW5co0
	 mg61m6iDc7LhM6TqYEeKuHTHN6Wx924uySsqapz7jsbQYk1S9usVhr41uNvZhVIfeN
	 OmwJWfscLoofOa+quYIwkSOIwvntHVUNqvuNVFOtt0TLmdsriA1t9gYbTKq7T/03m6
	 7mu8b5zY5/g1k7WrxfEgNnoE3dhECdCANm9lVyX4Y1Azq4ssTTqvOrONtF3WLBsYpH
	 sb0kz9jeBTiGrtbgPQZrPlxkQsmZKaGfXB2xAWJG4KVQz51KyIeWQyIFGI3vvTxuV6
	 S6pfUubLMcMuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC50FCA0EE4;
	Thu, 21 Aug 2025 02:40:32 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Thu, 21 Aug 2025 02:40:05 +0000
Subject: [PATCH] f2fs: skip checkpoint for compressed file write
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-dev-v1-1-17895dcd6de5@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAASHpmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMD3ZTUMl1jwyRzS6NUi1TDtCQloMqCotS0zAqwKdGxtbUAqe5cjlU
 AAAA=
X-Change-ID: 20250820-dev-31b792e8e1fb
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Tao Zeng <tao.zeng@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
 Tuan Zhang <tuan.zhang@amlogic.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755744031; l=4919;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=wya5DJZMk39l246MFX6Ep0FIXV5z0kLcEUjj/zgmqaI=;
 b=G5KBIf5K81W0tkR5CiKqDJVQU7RucYNqi8LD6FZF1mG+LcYobV47qSunumqd9VVimzcRB1Oil
 WxUGiWKJN7pCJmOYIAJE214iesp4F4iFos1L0rULtD29ttXW8ihurgz
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reply-To: jiucheng.xu@amlogic.com

From: Tao Zeng <tao.zeng@amlogic.com>

Always do checkpoint is a heavy behavior for compressed file.
But for contiguous writing of a file, checkpoint need to be
skipped to help improve performance.

Tested with iozone for always do check point on compressed data,
results are:

File stride size set to 17 * record size.
                                                  random  random
    KB  reclen   write rewrite    read    reread    read   write
102400       4    1314   35488   234231  1683793 1212394   35334
102400       8    2387   54133   244584  1871789 1644952   52478
102400      16    5060    7059   298052  1901792 1894929    6600
102400      32    9315   13118   424723  1825565 1924235   12041
102400      64   17028   22258   491181  1844443 1968247   22115
102400     128   30551   38008   445192  1796615 1917466   38527
102400     256   46944   55006   509625  1630910 1715586   56201
102400     512   63355   70432   434639  1406089 1487569   72718
102400    1024   83036   86742   447141  1420505 1503320   88913
102400    2048   98577  101971   450287  1434918 1522294  106374
102400    4096  113300  116994   451286  1435321 1527404  119579
102400    8192  132532  133044   488503  1458688 1540595  141167
102400   16384  143246  143857   489376  1469878 1556530  151362

We can see that writing speed of small pieces of data(less than 16KB) is
very slow.

With this change, iozone data are on the same hardware:
                                                  random  random
    KB  reclen   write rewrite    read    reread    read   write
102400       4   14658   34796   232797  1985764 1219513   34509
102400       8   25980   53695   233218  2419198 1788989   51927
102400      16   49556   50325   266754  2780871 2256746   50593
102400      32   79947   80783   393452  2755413 2467949   77681
102400      64  104866  105830   531853  2816504 2596812  106223
102400     128  142097  142034   651876  2885805 2728473  143296
102400     256  146972  144822   535727  2542080 2450922  157390
102400     512  126591  152480   571581  2055442 2052839  156512
102400    1024  135164  143667   654547  2052594 2045214  130488
102400    2048  127587  124889   491258  2058457 2059454  141273
102400    4096  124280  123959   660713  2067394 2056889  131967
102400    8192  138240  136233   509709  2102040 2090773  149215
102400   16384  146524  145333   576519  2118162 2096482  158704

We can see that speed of write with small pieces of data increased a lot.

Signed-off-by: Tao Zeng <tao.zeng@amlogic.com>
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6a49de1b7e919eda12354c074b8b253b2a9ea3f..2f820d531cdb32c0fc050aca05ffd3d00395a618 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1531,6 +1531,7 @@ enum compress_algorithm_type {
 
 enum compress_flag {
 	COMPRESS_CHKSUM,
+	COMPRESS_SKIP_WRITE_CP,
 	COMPRESS_MAX_FLAG,
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42faaed6a02da01f2bd117a5c55e1761beaffde6..3561b407f45e7aa97c7dcf911d4dddbc01ec2ca4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -212,7 +212,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode))
 		cp_reason = CP_NON_REGULAR;
-	else if (f2fs_compressed_file(inode))
+	else if (f2fs_compressed_file(inode) &&
+		 !(F2FS_I(inode)->i_compress_flag &
+			 BIT(COMPRESS_SKIP_WRITE_CP)))
 		cp_reason = CP_COMPRESSED;
 	else if (inode->i_nlink != 1)
 		cp_reason = CP_HARDLINK;
@@ -5234,6 +5236,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			f2fs_dio_write_iter(iocb, from, &may_need_sync) :
 			f2fs_buffered_write_iter(iocb, from);
 
+		/* skip checkpoint for normal write compress file */
+		if (f2fs_compressed_file(inode))
+			F2FS_I(inode)->i_compress_flag |=
+				BIT(COMPRESS_SKIP_WRITE_CP);
+
 		trace_f2fs_datawrite_end(inode, orig_pos, ret);
 	}
 
@@ -5250,14 +5257,17 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+
+	if (ret > 0 && may_need_sync)
+		ret = generic_write_sync(iocb, ret);
+
+	if (f2fs_compressed_file(inode))
+		F2FS_I(inode)->i_compress_flag &= ~BIT(COMPRESS_SKIP_WRITE_CP);
 out_unlock:
 	inode_unlock(inode);
 out:
 	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
 
-	if (ret > 0 && may_need_sync)
-		ret = generic_write_sync(iocb, ret);
-
 	/* If buffered IO was forced, flush and drop the data from
 	 * the page cache to preserve O_DIRECT semantics
 	 */

---
base-commit: 3ea4ad0a1df0bcbfd5ccdcea56d57ca4678ae2a8
change-id: 20250820-dev-31b792e8e1fb

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>



