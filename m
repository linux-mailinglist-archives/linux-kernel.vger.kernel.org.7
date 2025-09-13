Return-Path: <linux-kernel+bounces-815013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D8B55E25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC111CC30F3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0D1F4C87;
	Sat, 13 Sep 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cROztID4"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395071D63C7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734656; cv=none; b=u1V5k7NxGFr8LdlaPz4LtnQfbXLgqOCKFvpRWTyC80z2StKyuzgRg3Zc/51Pw+DeVqqomFy6aoK6n+iWWUDkUwDP4ew2FZFukWwbtseaxNG28xTVoJz2nIaZ/0rZqmkRNuEU98uhz43MKE+1RPyhPrXXCBXQGcIIYJ2otYmmIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734656; c=relaxed/simple;
	bh=ycpaoNa3MN6uF82TEzzmVwGPWKJsfjTrnr+qTVnDsf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/6dPjtce2ouujq3cLXpXmudNVDeCqSCwpAAiN0RV/l8znH8rnVSBzGo3e8MMjyLmnINmQ2uYIcr2zI7CerNEhBVH7VHA8+Jzpu6E/Dwcf0izFPpreTx7JFyyZmasnOxwKNnLzsdFUIj4KRNTtSjq5e0QrVGjpv022fHPyJNsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cROztID4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266cdf64so2219076a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734654; x=1758339454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=cROztID4fSyst4TeqU9SosaOvuP8PaVXUvHYyKXqpJZvd7+wITk5/wVzfEAddvyT2i
         96hR6N8zZ0c++t4psIugtNXV6MuQx1bTj3zkf+i7GEWzYXcIwt7DTJb2JHFZt1ulaUmX
         9RJEZ1rG3ee/47oFCpE2KCLjGzqhS1FePE40lajSbKXjktPbCPqFF8EZvRw1M/bMvAjR
         NWZ2yb9Q2NpgTW8PnJogiigKJ363hNEZ46Mfg4kl43DwnM9tZ1+HTQA4y8uPgn2Ja/9C
         lBKMXzJiLXvYc1kvl83JJmzkkEgxrFYTLu6p/t+DR/6TMQhIUnlfhjCz3wbgnW24UWvF
         OSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734654; x=1758339454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=n5llTo9uCiyq0lTxlPBbPhUfjbfmpmR/DszqDMTugRbPFb7Dfsgqw9N9gOjQE1dvYj
         sZ6RKkzsRkO++IrQB2FWlxCr8qzarevUULQ3430xgzHRlERBozhgW4yV+GNd9qFerKxJ
         7Ik5gIuBJ/UCoRO6u7PBirzi6DIxDWN4np3jClAvi7Sge7XO4iN3ttCSzgv30Oh8RnE2
         twjd0qaFm6MeFZeiL87i/WmIpulc1mnPCRWQ/mV4wshRlD71+hpFpHAU3nYFrC4XsjSs
         kzdDUstQi6OZ2tJzuQHmGq6YpK0NEV9YqYZikPF+wkjP1hOr0OqXkhKzJID6fuNpItAq
         Sdzw==
X-Forwarded-Encrypted: i=1; AJvYcCUrNvZ06qrcoR+CATLVEafQu822nSN66XT7vLtEjcuFs9XqoCWSmCcpYDQythVSWuaNIY866XUBtrTXjEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErbxseZ1lEgwjbePvhOnpW9r4zwWvw65ymh/Iu/IHUNT01Cdv
	MVPtoUc2SBD27Vd+NH3Yr6IhHlz8l9jKtfCcr8UdrPxq9WAQyCh12hO7
X-Gm-Gg: ASbGnctaqKLmymBX4yLaWbAEXElveQlOnpLmdfK6P0aTyNVDz91i4lkctyOWwNFxW8d
	z2EqIbBnZPV6n1EaGNVVS6s1vYwP0e/idnmISSi9AH/5ulcOjGo+N0g/pnofAkGfK7Y+GfjlY72
	6CXsT0oLTdgFN91UkFd0H9olelZKllzPq6k9RPgv+6GevUlGrHYvZqj8cDc5zqIYsvWuHeW8lhA
	lZmePHAh3GuI8/yfg0HyTowScEiSk1zReXeOGv0VdxuSvtTHc74b4TQjbEfWGDLyE4n2+sQydyj
	AiXJuiDrHeejj3SK5IlxArHMtgbzg0L6t7nqe8BRwJT9IEMKcASB5xlLyi5tWGOqL+sgoJ8P0f1
	qlB3JA08bS6SrkckOi9b54oNiSnMpWpBcdg==
X-Google-Smtp-Source: AGHT+IFTSjLSmIonQ/tT9ymELWFyPtl8pb8LOwBSdF0oV1rT/SaH3ISod88rjuwb2oTrX2uuYFgG6Q==
X-Received: by 2002:a17:90b:1810:b0:327:7c8e:8725 with SMTP id 98e67ed59e1d1-32de4f8ad49mr6517497a91.10.1757734654423;
        Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 3/4] iomap: make iomap_write_end() return the number of written length again
Date: Sat, 13 Sep 2025 11:37:17 +0800
Message-ID: <20250913033718.2800561-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the next patch, we allow iomap_write_end() to conditionally accept
partial writes, so this patch makes iomap_write_end() return the number
of accepted write bytes in preparation for the next patch.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 109c3bad6ccf..7b9193f8243a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,7 +873,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
-static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -890,11 +890,11 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return false;
+		return 0;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
-	return true;
+	return copied;
 }
 
 static void iomap_write_end_inline(const struct iomap_iter *iter,
@@ -915,10 +915,10 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
 }
 
 /*
- * Returns true if all copied bytes have been written to the pagecache,
- * otherwise return false.
+ * Returns number of copied bytes have been written to the pagecache,
+ * zero if block is partial update.
  */
-static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
+static int iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 		struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -926,7 +926,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
-		return true;
+		return copied;
 	}
 
 	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
@@ -934,7 +934,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 		bh_written = block_write_end(pos, len, copied, folio);
 		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
-		return bh_written == copied;
+		return bh_written;
 	}
 
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
@@ -1000,8 +1000,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, bytes, copied, folio) ?
-			  copied : 0;
+		written = iomap_write_end(iter, bytes, copied, folio);
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1315,7 +1314,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1327,7 +1326,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		cond_resched();
@@ -1388,7 +1387,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1406,7 +1405,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		status = iomap_iter_advance(iter, &bytes);
-- 
2.49.0


