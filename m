Return-Path: <linux-kernel+bounces-866008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC3BFE97E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7E13A587E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD3299923;
	Wed, 22 Oct 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJCPbqjF"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3295289376
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176039; cv=none; b=uZMhFGcFCD8VXA/yIV4fNB13jNJIBjTtT9AtW4NoTvIoGCTEHL4/o2Cynxot2H2pbWD2fLq+RNp+8wW7CrWUdQYO4a0CmYTuTo7DXdXOkTeM2BcgFdBRRSgeSYuHX+DwV8eXDNwXVEwlnDsZFvr3aK5SKAllQHM3xKw6wZuP7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176039; c=relaxed/simple;
	bh=tC+LN4ArABgmjhoTqmL7lKSO0v9oWlL/UItloU+HQUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugzHPjab6/SSoV2XQeEt7X4Gm5aOnpDSwBZOZeyadhHohYFqJqcuhLXHeWf5hSDvTGy1F9d/ucgMm0avb1pjdJNNYlSNLGSlL4c8wBiRXbdpi0qJW/M+Ug1r81EEw3ukGcIQvj2Tw5+TQuzg+Q4qvg80n23FauQymlFs8Uy6v8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJCPbqjF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33255011eafso192967a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176037; x=1761780837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mHGULrbhrQZXqL21jsyCNIXz//QNSU5dqpIYMZ4CNA=;
        b=VJCPbqjF+MN8VirEXRP+4maTI4MD0Si9Qw4KHKul/dqO6xMFQZKrzUZXnx1fdgnnil
         RIxLvIgkXyoAvbQpo8Hf9YscdRX5gYy5TeXPIEJ305zLmyCC/PP8PaaacSHl+yWTUl9z
         ewHd8tU8Ln3z/IusYS6y+8NnMHnHhmA+ipLd4Y0NOizEj0g11zrL02Exl4MjPZ8sW8Nk
         RZGsMW5ENSIrIBaMUtZox4thGfwom/8CD3JZRC1ltG9uC5r0hiOMMefGxbqKUPgf5uTK
         2Lq/qyunLthjWPh0KVg+vYL97+vLis8BtUgwv/n2APMKHgNoxTowa/VApiP7Q1mOvAnD
         FZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176037; x=1761780837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mHGULrbhrQZXqL21jsyCNIXz//QNSU5dqpIYMZ4CNA=;
        b=UUxTLZuA2e4ioYp2pVQEHLwpJ4vfFuvLyBxN+CV4jOIWNlTI8PS6oWYe3K70/ioeNe
         BiUNrLzJNVVVXrA3goEKx/5j+f71X494iMfqDyaLWfnnAeYZdWP3i5CEsyR6KfMMkqIs
         6rNHHjhO6RERosc85d8ZzHXmLa8APR2f1ef3eKy1HcVGTqAADgk/H6O7uqcNaruaVJiK
         iih1f+gTgCMwMUi7DDk7wIOjkBfdiqfKj/pu0qhYx+fdKBg+Zhy3eRGJmmY2zfNWcQlI
         MSOjNkVQtpi5FXXlAlOT9JeCPdahkISCxEv/vpnJtB8urYSPvLt74XqNBbGFehVe+Fcw
         +ekA==
X-Forwarded-Encrypted: i=1; AJvYcCXgTvy54AxI9LXvZQioCGx6k692WRTwg8OwDJhmFdI4ThrAB46sQ2OaRSS3thv3r9+QjgeQJpJ679dcFTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdVnkyGliRNG1oZ6J1k73lpc6F+0UazzOV0tH2YEmqqtuI7Oq
	d2qVkjP8TcYW72gNCISmi38k4282vEolfro4c0EOK+zXVmL2fwVr/8jo
X-Gm-Gg: ASbGncuo2uwSPUKVpBXf7R/PKMB+Nw1wCwSOzenTQj5NOcKmrdJYmGOqUBHvFaEgK9o
	mHs3t4JHlGmKlFdzLIhySoNvarjZsBJ7+IgDpNWi7lETA4VqdgqUxEWMdGsEsZnicGRBBoSi243
	h2/4SyY6e1LQ4l8ioJgB7hmvCdw3s4Ok0n9c6zfrV4L5WoOzcf/YZSALT2hZsoroQaj+jprPhmV
	RhreKf3m+6p+rSPzGnce1jAI7CzQQ6p52YRTg3EPftKquA1gj9Xj3Xj7oZh+UYdXKpXaHCDl5Ic
	6I2ynlR1mmTpibeUCp7ByU0PeBL/RvImhNqgPYS6cSBrUdcukvlphacF2QiTQS9EzdMUy4dDS59
	ziJpUQjY7or9+arQt96NfTwV5/qmtKCCAb4oDhNhRuPw0HDbuTodMdr79Q8fk4shPYfm+q6rhh8
	N/73XqW88xeeCyptTq50E5KuIJQD0KmuYKhh4=
X-Google-Smtp-Source: AGHT+IEpDb5bUgRrfuih7BhbijCAQcSf9aUmP/xnPQr+15ne4Jw27HzUw1UD5BeHNG7z0+PEo93KNw==
X-Received: by 2002:a17:90b:2412:b0:33e:1ed8:334d with SMTP id 98e67ed59e1d1-33e1ed835a8mr5313886a91.16.1761176036922;
        Wed, 22 Oct 2025 16:33:56 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:9293:1f1b:ba8e:b77d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2d19d364sm3023608a91.10.2025.10.22.16.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:33:56 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: invalidate dentry cache on failed whiteout creation
Date: Thu, 23 Oct 2025 05:03:47 +0530
Message-ID: <20251022233349.102728-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

F2FS can mount filesystems with corrupted directory depth values that
get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
operations are performed on such directories, f2fs_rename performs
directory modifications (updating target entry and deleting source
entry) before attempting to add the whiteout entry via f2fs_add_link.

If f2fs_add_link fails due to the corrupted directory structure, the
function returns an error to VFS, but the partial directory
modifications have already been committed to disk. VFS assumes the
entire rename operation failed and does not update the dentry cache,
leaving stale mappings.

This causes subsequent operations to use cached dentry information that
no longer matches the on-disk state. When a second rename targets the
same entry, VFS attempts to decrement i_nlink on the stale inode, which
may already have i_nlink=0, triggering a WARNING in drop_nlink().

Example sequence:
1. First rename (RENAME_WHITEOUT): file2 → file1
   - f2fs updates file1 entry on disk (points to inode 8)
   - f2fs deletes file2 entry on disk
   - f2fs_add_link(whiteout) fails (corrupted directory)
   - Returns error to VFS
   - VFS cache still has: file1 → inode 7 (stale!)

2. Second rename: file3 → file1
   - VFS uses stale cache: file1 → inode 7
   - Tries to drop_nlink on inode 7 (i_nlink already 0)
   - WARNING in drop_nlink()

Fix this by explicitly invalidating old_dentry and new_dentry when
f2fs_add_link fails during whiteout creation. This forces VFS to
refresh from disk on subsequent operations, ensuring cache consistency
even when the rename partially succeeds.

Reproducer:
1. Mount F2FS image with corrupted i_current_depth
2. renameat2(file2, file1, RENAME_WHITEOUT)
3. renameat2(file3, file1, 0)
4. System triggers WARNING in drop_nlink()

Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Tested-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/f2fs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..712479b7b93d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1053,9 +1053,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
 		err = f2fs_add_link(old_dentry, whiteout);
-		if (err)
+		if (err) {
+			d_invalidate(old_dentry);
+			d_invalidate(new_dentry);
 			goto put_out_dir;
-
+		}
 		spin_lock(&whiteout->i_lock);
 		whiteout->i_state &= ~I_LINKABLE;
 		spin_unlock(&whiteout->i_lock);
-- 
2.43.0


