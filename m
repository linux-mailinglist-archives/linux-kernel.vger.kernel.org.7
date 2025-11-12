Return-Path: <linux-kernel+bounces-896383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC81C503BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF3F4E841E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841928B4F0;
	Wed, 12 Nov 2025 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIIWY48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA725A642
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912079; cv=none; b=Ur5bNEdA8RKNHUSC6rW2Yxwyc7JyhN0aRBd4YJMrCIVrGoqvuuNhykZYzYEPLSKnuOY0xOfaI+KQUSCDtodZSu33/3lMPH3n68XHgG2W3Tbl/rcvNNWFfUiehO8hIVo47opWxaW752Weii+GkeuzBaS569f9MwfFzUiVR8a3xUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912079; c=relaxed/simple;
	bh=7nv5fT4fdF0GW5Fyx2VzArTblyNuA16QWAh/M13oABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T86k/P0xntgLDQMbdhaDYp/r3xb5FYzQ/fhUrZRFLq5FKFap+jyIX6Kv5HEUMRZgxuzDPwNntKQZy0Yy2y9QRFc8XTH2BwpLW6C1ZyqmuhUXVqeFbyEHQEyXMRJfmafdQxehIOAPDdiEYLPGNQkRPbwXS6MJm3deYuSZIeImQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIIWY48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C2C4CEF5;
	Wed, 12 Nov 2025 01:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912078;
	bh=7nv5fT4fdF0GW5Fyx2VzArTblyNuA16QWAh/M13oABQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RbIIWY48hxQmIvBzZZvWl8aRbPpmsC35EYVpuUd9H0st4AZZl85rxnrSWe6kvXO3u
	 hxVU8lUltClEx7IWlmCvycCfn+5ylCQU627mJcMA6DoK8GuIcGYVj4uXcGuMHfUKG8
	 Afb/T3a4XYqP05qOuP6C+Qw88DMX7ApEhaHwS1hKltS5cScbq8TYhT+mqdHbJgyQp+
	 vKHWeh9ps+/IivR49PX7k7z8sGq8cgrDwtKxUlEMQRLEUhEwvkmr/9MXQvvCrkL0Dk
	 DwJDUpaf0eVXQEBhMNHl8GQmLikZrw4DpWMfi6kZErZ0PR/0fZmX/FXvrGfwdpOLPv
	 64FvLnp18nzPA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/3] f2fs: use memalloc_retry_wait() as much as possible
Date: Wed, 12 Nov 2025 09:47:47 +0800
Message-ID: <20251112014749.2006439-1-chao@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memalloc_retry_wait() is recommended in memory allocation retry logic,
use it as much as possible.

Signed-off-by: Chao Yu <chao@kernel.org>
---
use memalloc_retry_wait() instead of f2fs_io_schedule_timeout()
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/super.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 10d873d1b328..d968a4250b1a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -234,7 +234,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			memalloc_retry_wait(GFP_NOFS);
 			goto retry;
 		}
 		return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c2161b3469b3..2bd7c2320d4f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3139,7 +3139,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				memalloc_retry_wait(GFP_NOFS);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
-- 
2.49.0


