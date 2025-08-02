Return-Path: <linux-kernel+bounces-753945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61235B18A70
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8643A5A058B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1E13B7AE;
	Sat,  2 Aug 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXmhydbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0C372
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102261; cv=none; b=ZO9+BDT4B2fZxtXAAntuh7hIVkTR6mjlshOSnwuKZx6RXB9zCIOP6HRCu4T0vYvFwH1ZH2jLPT983tdANZTOUTKkhch0vhJqL2sDV1RpiioXekKZr9xA6tcQz8S1rIPBZ4d9zBytytjjaYQTTdij1LG3swNx6ynyj+N3VzzirIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102261; c=relaxed/simple;
	bh=SnMGNBU0WevBcEDt0U0KrwRwiB+AubWXiRuNhkpiDR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6HV5AB3QReUW62QYZzIIfqNvWYoQ5hB/RqJZOyqlY+pjxqdQB9xq8DIwnQd2S69j5fzwOvSG3Zb74w1837t/3R9g+TprcKNyEPBjpdHtnrNSX8slpg4FLYObQC411qXL6+oC99h6B/J4hh2wWbdAEr057H7HbZHnGMSxs9koLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXmhydbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E105AC4CEE7;
	Sat,  2 Aug 2025 02:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754102261;
	bh=SnMGNBU0WevBcEDt0U0KrwRwiB+AubWXiRuNhkpiDR0=;
	h=From:To:Cc:Subject:Date:From;
	b=mXmhydbWdO5IiuKtmOjWtXxTEy6KJEAmvlSmKZ+6Pa7u1WtZT7IQ2cKpwK2k21484
	 TZcTDbt8MzqhrRdexg9BNy6RinGzGdfcBOykVVLm19dfm1HqIIsOIceFHUHis9KQFu
	 2+pO66zmKttEODPoSosqRFD6WLYovB8yoeizU5ABg08/OaJmVVr6KZRca2SnB2tltZ
	 TTLTj86P+p7wKc9PhOsNGjaZWaRIQlvQshADiltr40iIuyA4z7+dMpwUGDBLi0Oxl1
	 4nCqbgRNPOuHRWzt74vbKHWV1L/un0/bye/8p1kfioNky5+vDil334fPiCM7P3z4rv
	 WWxa4id4mh1pg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>,
	Jens Axboe <axboe@kernel.dk>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to return -EOPNOTSUPP for uncached write
Date: Sat,  2 Aug 2025 10:37:33 +0800
Message-ID: <20250802023733.1890349-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qi Han <hanqi@vivo.com>

f2fs doesn't support uncached write yet, for write() w/ IOCB_DONTCACHE
flag, let's return -EOPNOTSUPP instead of ignoring IOCB_DONTCACHE flag
and write w/o uncached IO.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Qi Han <hanqi@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
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


