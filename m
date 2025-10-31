Return-Path: <linux-kernel+bounces-880962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3EEC270DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E5A1890E05
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB6304972;
	Fri, 31 Oct 2025 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+RVo2Rc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426382F12B5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946552; cv=none; b=fgV28iUPALpJ1vM91VeOl33v8SdCqf/7eoMJyrNk2Ywf+DICoM/B8iiypSpYndeXKhPJBz0q7V1bq9PzRvZAPZG5I723JErXiKnw2TFYFO+6kI1WD2eMNPEC64jTRha639Se4BBwe/OqXqjd6KuVUejsBUx4xf4k//ptLXdmCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946552; c=relaxed/simple;
	bh=x6L31CG0svo1i4rtHQe15pm7gZjhLeWBH7Dz36e3EoI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMzNTO3UFKpYLftIRZDJ2bmXN/QbfDOdAzSKrOgD2bLjJuanVo6UJr3Km2NyMX1I7jow4EWFc3YVnngxCRSjhce+yJkoYEG//Ann3nwtWa0/dEQDzJ4gWmzfwnHNP6sOzf7XhYtFPzkfdOHmaNj1oqfFhtgwN8vz63Dt9nScm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+RVo2Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB70C4CEE7;
	Fri, 31 Oct 2025 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761946551;
	bh=x6L31CG0svo1i4rtHQe15pm7gZjhLeWBH7Dz36e3EoI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=c+RVo2RcNbmb7uPQsgrPpFbqrLlRW6C2f25hvUJqpBUr6jXCvlzNSo4HOCu1gRyyu
	 O2zzKs416AeA2yAYwl8FZSzkSd5dtGnwIUwJAG4P2Y73ArbPI2cBjUBb9Dok7+1oyt
	 cKqivWnwFsQ+QpwPWAYdJLLIlWitXq2P3LRXNRIYeRxCIS/Ovv2kxZ0DAZZtO0Auyt
	 DiVTOR3d0+4fxk/5CFjWfwbB7wbLRCNuIy8NsYDAv64vZVx5uIgoEw3/+kh08jePn4
	 khlz9KVAqrddSZNoqLecb98wiG1fSaxXteeFBi2iP3sKIs6+ZbPAAnAc2JKJTviWc8
	 7IfEYeUb19nOw==
Date: Fri, 31 Oct 2025 21:35:49 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: add fadvise tracepoint
Message-ID: <aQUrtSAXWtHtLhtm@google.com>
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028195444.3181203-1-jaegeuk@kernel.org>

This adds a tracepoint in the fadvise call path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 v2 from v1:
  - use i_size_read()

 fs/f2fs/file.c              |  2 ++
 include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b966f6d40d2..d7047ca6b98d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 	struct inode *inode = file_inode(filp);
 	int err;
 
+	trace_f2fs_fadvise(inode, offset, len, advice);
+
 	if (advice == POSIX_FADV_SEQUENTIAL) {
 		if (S_ISFIFO(inode->i_mode))
 			return -ESPIPE;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e1fae78d64a5..e00611ead024 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
 		__entry->ret)
 );
 
+TRACE_EVENT(f2fs_fadvise,
+
+	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
+
+	TP_ARGS(inode, offset, len, advice),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, size)
+		__field(loff_t,	offset)
+		__field(loff_t,	len)
+		__field(int,	advice)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->size	= i_size_read(inode);
+		__entry->offset	= offset;
+		__entry->len	= len;
+		__entry->advice	= advice;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->size,
+		__entry->offset,
+		__entry->len,
+		__entry->advice)
+);
+
 TRACE_EVENT(f2fs_map_blocks,
 	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
 		 int ret),
-- 
2.51.2.997.g839fc31de9-goog


