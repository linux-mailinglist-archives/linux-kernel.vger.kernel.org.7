Return-Path: <linux-kernel+bounces-879523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A4C234D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CDC1A25024
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91C25A651;
	Fri, 31 Oct 2025 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UPnl7EGG"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF41A76BB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889676; cv=none; b=IZw3iX8QhQgMSOYSUTJUqKrDUZs+41L/IgntV/J2kRD33kmaPoh5Jztqa64IObS6ZrYFcgxcmZUU6LimZiiTDJVH8wee/yERj3fPkOFQNYvYVuFQcdJIDe9MKdrXOiiWZQLDeQL2QImX6D8z8FK8Q6S5n/BnOoBsU8ophWUxh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889676; c=relaxed/simple;
	bh=VJDbbvB0CrYiZo3mFa1LHXvTVP85LBC/tY2lks1F4Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3fcbf6XlWZhWxHYREGAVwd5cdHyPusprMzTu0iOn3pbN15x2v5F3lWjGjXQCjzysnpRDHcmqYBBb2MQMqPrOBibMXSKna8DS0GT8+WJmEo0YCY/m08Qr5x5n7NL14eDTJ1/Ke1JkoY9Yq7IWATF+PvoCWQXrpvi3hzihCndACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UPnl7EGG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761889665; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wfeFgdZvyu0jYTVA6vIV7jCk6gqYdTkVFzYAV142tGo=;
	b=UPnl7EGGf0/rRH1SdfcTmtldmHQ5Zvfn34dMiCaZft0EpLgrLO5W6/9/7eJYPLk+P+xo1Zo4itYwBup63ao17a7PJsv5epoHQjk3beZowm3e9Gt1pjBodxTleJhROPyc/G2iCQAxhPRSPTw3HApxU283zAvSvyHJ5GzApMQyav4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrNt.oV_1761889660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 13:47:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH] erofs: avoid infinite loop due to incomplete zstd-compressed data
Date: Fri, 31 Oct 2025 13:47:39 +0800
Message-ID: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the decompression logic incorrectly spins if compressed
data is truncated in crafted (deliberately corrupted) images.

Fixes: 7c35de4df105 ("erofs: Zstandard compression support")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/50958.1761605413@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Actually I suspect multi-shot decompressor lzma may have a similar
issue (but it seems deflate is not), will check later.

 fs/erofs/decompressor_zstd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index b4bfe14229f9..e38d93bb2104 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -172,7 +172,6 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	dctx.bounce = strm->bounce;
 
 	do {
-		dctx.avail_out = out_buf.size - out_buf.pos;
 		dctx.inbuf_sz = in_buf.size;
 		dctx.inbuf_pos = in_buf.pos;
 		err = z_erofs_stream_switch_bufs(&dctx, &out_buf.dst,
@@ -188,14 +187,18 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 		in_buf.pos = dctx.inbuf_pos;
 
 		zerr = zstd_decompress_stream(stream, &out_buf, &in_buf);
-		if (zstd_is_error(zerr) || (!zerr && rq->outputsize)) {
+		dctx.avail_out = out_buf.size - out_buf.pos;
+		if (zstd_is_error(zerr) ||
+		    ((rq->outputsize + dctx.avail_out) && (!zerr || (zerr > 0 &&
+				!(rq->inputsize + in_buf.size - in_buf.pos))))) {
 			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
 				  rq->inputsize, rq->outputsize,
-				  zerr ? zstd_get_error_name(zerr) : "unexpected end of stream");
+				  zstd_is_error(zerr) ? zstd_get_error_name(zerr) :
+					"unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
-	} while (rq->outputsize || out_buf.pos < out_buf.size);
+	} while (rq->outputsize + dctx.avail_out);
 
 	if (dctx.kout)
 		kunmap_local(dctx.kout);
-- 
2.43.5


