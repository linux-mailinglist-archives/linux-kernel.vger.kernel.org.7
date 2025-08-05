Return-Path: <linux-kernel+bounces-755963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43712B1AE1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59706205D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F56175A5;
	Tue,  5 Aug 2025 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoXuP7/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1D21639B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374763; cv=none; b=i4RQhsWOd0GGNSO/13wd4pqEZ8jBA/1qwiguEyRPyzmuiApcvsFHMhpASbMgZjZaD64HWC8RA+kQQUEy8Axe43/S/UlVzXEmSCkIdwZ6cKWb1OK9Xp3QdBqYaLbYBN9RQA85RzEY8VYQZ428J2IImpIWRxAmYDsFKuzYqMFVn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374763; c=relaxed/simple;
	bh=DgJ6jHIbxLVmiXFgEe6KR9nH8EMJtdShONp10yEpRuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHrSlXS9DznTFut+Y2SMbT5E2dPzlY4DT6nWU7NniMODIFn2y2HGY3NZHgr6j82OwD7MrUSDIQjQqAUf5qURrKNPPaD5bX/6YuHMp+Skrr1uC21TcxoQi3MddcZI293ii8Q6ZzSRjDvfNdzU/vpCTep2edErlEFA8khy9wHRbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoXuP7/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EB0C4CEF4;
	Tue,  5 Aug 2025 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754374762;
	bh=DgJ6jHIbxLVmiXFgEe6KR9nH8EMJtdShONp10yEpRuw=;
	h=From:To:Cc:Subject:Date:From;
	b=BoXuP7/XHPnGo8bvR8bgj8MUSC9E/9FMTu198MFG24jHl9lIm/uLA+UpNhinzI8TD
	 i8n7rYsycPxIX0+qIXEJVq8RULdbCBvpcP/5lauxCDhKtJYvW+iIYO+X8UDqbU92le
	 a4/E50saBbAoJtpky/XRr1S+MLjA0jnAkg+xmlFXQGWnutkWgk84GtA/b1iV0IhLvo
	 TWF3YLy137uJaWVvpSeXWXGvXa8hOzf0+L8hdvlNmb7Mbqt6UQRJvOFuPR0INw8V4m
	 muDSgIA4h2++f767oY54Ki7VJLOywNprsNdR/Dhf8tebQ+jNBXU29rru6rMzQrAXlU
	 w43fINSO6TX0A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v2] f2fs: fix to return -EOPNOTSUPP for uncached write
Date: Tue,  5 Aug 2025 14:19:14 +0800
Message-ID: <20250805061914.3067747-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs doesn't support uncached write yet, for write() w/ IOCB_DONTCACHE
flag, let's return -EOPNOTSUPP instead of ignoring IOCB_DONTCACHE flag
and write w/o uncached IO.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Qi Han <hanqi@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix author info
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b8d24097b7a..7f09cad6b6d7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5185,6 +5185,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
+	if (iocb->ki_flags & IOCB_DONTCACHE) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 
2.49.0


