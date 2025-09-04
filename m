Return-Path: <linux-kernel+bounces-801458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3FB4452A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89505543021
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4992FFDC6;
	Thu,  4 Sep 2025 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvrz0CiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B72BD03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009805; cv=none; b=ReYGNy1BIXyC4eQWVSTKw0Kagb+B5uUfdkaBQEj5vg4RmBPD7X5zehq3bhO5NCKa0DTsnPOBdQy56MPlDRzDAaLcNi8FiW5EeNDsZcG7iFrmXsxdlns8zoBL+zB2JCw8gVZasL0Qm3wYoSXNPT1eAlgB+H05BzLk3E7jZvipnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009805; c=relaxed/simple;
	bh=QKt4HUZt3Xzmmkzkk5AcnkXfi7gRQ+D2WMregxN1t+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0LQ/ROzVXepLe/OeLWRLgX/oaOiRzhw9COvUYbgKzaU9O6akdQYWCS1AJ0+9li87h0Zz/EtNCTgODbd/bz5IUL8urnyvupM50lsuOzVZweihuRi0v7p5KorH5MLMIs8HT1I3PWEzCgLxm5FBzbSbvMBEzJFAQWyxVpqAlif/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvrz0CiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64209C4CEF0;
	Thu,  4 Sep 2025 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757009804;
	bh=QKt4HUZt3Xzmmkzkk5AcnkXfi7gRQ+D2WMregxN1t+I=;
	h=From:To:Cc:Subject:Date:From;
	b=lvrz0CiIPp64pem1tmSx3BDWIMCftEu3EiJ1VdFvDjVDNFO8LNF1sX5mKQ1iLc9Ea
	 cb7ytPVt7DVNFpLSEnA3ifpChNEvE9t/ABGE60diJQAH/X4LeP9/lK2xRe0JE+aTkg
	 +UPz1M+kkjcS7b6emWZHDNJ+PZE8c7Nox3xeKrgWCJBbFZSa4Gtu8mw7u5t1ZbLiSw
	 qDYs50hPMEH/yBbjbjZXzxLOtF1vRV07TBl689o+hw5pYjFPG6wEgntIcxcSFYA9sY
	 vEcjJFmveC8H2vP5ytXdsO9vG7un7P8/nxhOUvH/skQOzvI5457Q+GmAyOr7HRg318
	 rXDbSAZv946UA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: merge FUA command with the existing writes
Date: Thu,  4 Sep 2025 18:16:42 +0000
Message-ID: <20250904181642.3879283-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUA writes can be merged to the existing write IOs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..30cb2f230690 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -733,9 +733,11 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 						struct f2fs_io_info *fio)
 {
+	blk_opf_t mask = ~(REQ_PREFLUSH | REQ_FUA);
+
 	if (io->fio.op != fio->op)
 		return false;
-	return io->fio.op_flags == fio->op_flags;
+	return (io->fio.op_flags & mask) == (fio->op_flags & mask);
 }
 
 static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
-- 
2.51.0.355.g5224444f11-goog


