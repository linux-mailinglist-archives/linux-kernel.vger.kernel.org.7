Return-Path: <linux-kernel+bounces-871639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07698C0DE19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC8118882FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D525785D;
	Mon, 27 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg20eewu"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF2257831
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570406; cv=none; b=DOtNjJKGBmmkz9tf0D7vYI30nqWvWBsW2uyWGQXux328aAeZ3Xj7cGZ22sJheIZMRh9LMjq52gclJ3r6U5HkZuUekYT2C6O+nTfDdkPL79s8Rjg/SvO96YIXt/NO+Hzx8ia/tSK5jcRwIkPZ4AqrXzcsb5OOBVWVCXPcvkeit5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570406; c=relaxed/simple;
	bh=BWcqAbM9z6t1HjdGNpyf0q26GXGRBkQkzcWNq3FrJa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCnd3VigaPW6+fSJBPhr8yeScL7kNIYImzjZ0LIdXREIt0ZD3Ac5V0uweUWTsMTBtkQEHGoL6xpi8QyUMI7aGpxuar3fgKjO5FG12x3laNCq72uwx3cW/0gKiDHl4ZdWK/tX5lIPv3/1Yn6XstEBRuAWFHLf1a8gvzzhV5Mh+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg20eewu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a28226dd13so3376256b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570404; x=1762175204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAcB94rt1uG1utYxMaaRSmp/fSyUuxxZEyS4GrV5uxU=;
        b=Wg20eewuQbEUDIPNY8EAu+W5O8fvohPNiFDyG4ZFCkmcvQlv9dnb1+a8KxoR2XVqQD
         UAoClKB5+b/+dCP2wqx3Mxb9pXbWS0qvKXVEH0CTcL0obONjrr8br3amKQIMvS4W6LRy
         VrNe7BO3suvOSW5O/Z1NbJ0Q85T0sbD0MONHoTyGfTKrmQ6ilRUu/huwvav8lUWc/0XI
         haP/qSlgHiEdOGZcBgCjemBGux1Er0+ChS1gLzGFWKq8T9Hs4xJgbFrsN7t6WhwAw8wH
         8LDsROZWtqZWOEMR2Gg/zABYW5IhznGXjNE1zBYhBYUOA4Qkihh+IjDgQC+eVWDuiR7O
         lPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570404; x=1762175204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAcB94rt1uG1utYxMaaRSmp/fSyUuxxZEyS4GrV5uxU=;
        b=SeUTG7dbenw/035ZtjFaQ6Djzne9ph/0vRBSwFNs13XGjNgIg/OHuTtBnRkvCgEGRe
         MtZZroFypu/jDxdnLd/iNTuvAwAxCbR/6uyYkDUA/sbI4po1bUdXq3DR3prrvud3KdPU
         gXRpJNQ0jhg5Vn7ZkDGONMimlvHDWInGa4N3O8uFB6gECCfqB1IYf4OID9McO84N/wXZ
         ixLAhyevzsVhcvIyUNvVus9B0mGz0ZfK6G6g/QU/MIlE3nlIzNDT5ovmLheWjrSR5A5y
         RSZJFmczvPiWiWYdKTPqI26b11HtFVySuBWLI1IUYW8W0GT3hIPl6PFWb/fnvOPVTLVn
         okMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgfQrPwq8BTDvNluq4xRCTZsIdDNFvzOfeNNquJkjd55js092kqrdMve7o103H5xuQQawObeJOQM1Pfsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ItN8+8s4jVgr/fI+CvxL3gEw4e8BQ8N73M6lxlIGPYkfZrc+
	0xc0iEBbmaoiTUteqg+fPifp2FUkEojpR84yc/EsnQYbxZ6NzUET6emn
X-Gm-Gg: ASbGncuZdUfI4UHZcGjiDUfdkdOwWM1QtrURj5dQn5kb8zIchBv7sfO2paT+NHbFtDn
	bpNrnL7oJvpRF7X4bs21L3H/QnwQH1leJQ4YY1dpOxsXLe3hRbqxmrr3Fh9X3G1ZAMRL7MCzCrv
	cr9BHM8pPUix7zOOq4i6TMIhXvi2sI9+WmntqbmRIzvwtpV2cEQPokI8J1wP+rbNg168d9BxrGJ
	QjQ7rsDdJj1dEhstit4TKoyKQE9L0ENFdG9P356oGCTZzbCbYuyKmXsBNb0/0fWudL/K07Zy8Aq
	LMTswYm3eqVm41J6j8RQiqxU0kTcW+M1WNlRGn33jrAi2H0OLXMog2Ficefe8y78m85lwIpXLM5
	NWRNHduo3kiq6h55pt8GP+HKgtVAhsLzw73sflJzXp1De6TTzACccVqrQR5b1sMDKkz3bp46ruT
	ISOBTtwf+U0uydRJMfe8UEaak=
X-Google-Smtp-Source: AGHT+IFDBFQhu6H8WRS3G5jmj6Lqwp/4wmrDvIHwDdiFCiGPdJW6/tnWwumkgtAM7uP2nl3Z20LJrw==
X-Received: by 2002:a05:6a00:9501:b0:783:7de9:d3c5 with SMTP id d2e1a72fcca58-7a220d377d9mr45674430b3a.29.1761570403480;
        Mon, 27 Oct 2025 06:06:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:fac6:8aa5:82e:7fef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012899sm8253997b3a.0.2025.10.27.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:06:42 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: invalidate dentry cache on failed whiteout creation
Date: Mon, 27 Oct 2025 18:36:34 +0530
Message-ID: <20251027130635.13739-1-kartikey406@gmail.com>
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

In the error path, VFS does not call d_move() to update the dentry
cache. This results in new_dentry still pointing to the old inode
(new_inode) which has already had its i_nlink decremented to zero.
The stale cache causes subsequent operations to incorrectly reference
the freed inode.

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
   - VFS does not call d_move() due to error
   - VFS cache still has: file1 → inode 7 (stale!)
   - inode 7 has i_nlink=0 (already decremented)

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

Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
Suggested-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/all/20251022233349.102728-1-kartikey406@gmail.com/ [v1]
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Added detailed explanation about VFS not calling d_move() in error path,
  resulting in new_dentry still pointing to inode with zeroed i_nlink
  (suggested by Chao Yu)
- Added Fixes tag pointing to commit 7e01e7ad746b
- Added Cc: stable@vger.kernel.org for backporting to stable kernels
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


