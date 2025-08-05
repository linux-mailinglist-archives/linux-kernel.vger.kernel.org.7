Return-Path: <linux-kernel+bounces-755958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B0B1AE11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431116201E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90826214814;
	Tue,  5 Aug 2025 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iugcPsXV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBE175A5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374686; cv=none; b=IlJklZndQz260bI2sveaS/C60bbw+WWhNWKCqfeDpG8riKu+Et3RF/bt6xXW5Yzq0ohoO+yWh/3KNp52vsRnNNjuY9ZAAby9w/hPsjeW50++LLItauXbnz+vzdG3EuxtJSpEADPrKOK3o1NTqEVf/F9NxKqwX05sW/PftBgCjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374686; c=relaxed/simple;
	bh=DgJ6jHIbxLVmiXFgEe6KR9nH8EMJtdShONp10yEpRuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKZXa1ji9+L3miHnLjxkH1r2GdEEm69R9sidIvP8rUMt3jRiszdeJCszc75Vt8QlrbgmdwpVobjrzbuSv0or3AM16YwNn4DQapMljs+eXdUE30E+0sKtIC+qR8MDvchmM0INWvRo/iiodw11edf4cFa86b0mcxxbsK4cch5kP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iugcPsXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7736AC4CEF4;
	Tue,  5 Aug 2025 06:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754374685;
	bh=DgJ6jHIbxLVmiXFgEe6KR9nH8EMJtdShONp10yEpRuw=;
	h=From:To:Cc:Subject:Date:From;
	b=iugcPsXVN40dyxh6qeY63pueNSJoFp1Su4a2x7lykPOQTZi4OBwcuBDSbV0+Asknt
	 8IqffZzhfSURGRH4khM4ql+HmEZcF6d1ZqCWlGs6RitXFfv3quZs1EathBSNBNUjdJ
	 6vvIF67bLG6qWDwFZtq61o7VDk6vuoxHeRv8eM0wI8omFXmuUe9nK2jCjx3Fq5tZ0E
	 eF3HmIrVWGwbi8kz4hxJyvGSYVkXfp2FlNFxCj/GyW5uT8kc43sSpQa9bIKnemohvF
	 43kxj1Q2FDw5uewualYomPHrsx7/EZCHOwK1tQF5PTHGtt8XwJ39OZ7CcFs6Im5E3s
	 ESW/yTXLa8rgg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: fix to return -EOPNOTSUPP for uncached write
Date: Tue,  5 Aug 2025 14:17:33 +0800
Message-ID: <20250805061733.3067254-1-chao@kernel.org>
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


