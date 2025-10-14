Return-Path: <linux-kernel+bounces-852860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE0BDA1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77EB19A1055
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6C3009E8;
	Tue, 14 Oct 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrXVpJHB"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75803009DA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452792; cv=none; b=QFvPBE4z88RXOxTj/NL1hwauR5BF/e7BJB6LqoIkhYPD/6GIpJBjeiwoUbNIAN7VZdo8Lb5QFJ0HeOQ7Vig867OLD3eABX9oTl1xCil/kxVm3Dk/nfDRaLhbYdfVePZZDAI/ebRG/F4z5gvwDw4ry3wJOdSLkIwAVjpslJzXH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452792; c=relaxed/simple;
	bh=WIOkiYGxwBcs1eU4tW/avXuwBnMd3CcrRYCF0ppl228=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0bsfmDhv5sRyLKl44jqHGsJuGyBOMuQPAF4D2xUsa0D6VF7uKyH9HRuAgvyshjmXFXsMOMm5nmrKxzbM2Ev9ifkRU5dRSYdcLcRQDCXHxbFkB0Nha4Sqx00f71alkIME3lw6m0Ms/ZAZfyxeHrJz+OuiWC4FfuGDwkEw2mv0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrXVpJHB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so6679207a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452790; x=1761057590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPkNQt7GNnutvvFwrtniwfY3OpeKDI+MEgUBsglPSrQ=;
        b=MrXVpJHBye94nv7P5FDT4PDuNdUO5GQhYtP1ABNC5KiEQtqkR4FqAYqPWP3VyDmUW0
         iHqatfrP4xh9pLRX+WuA20XE6ProBd8uX0JGhW1qINwfcXn1XXzFlubHzmpoEz9OlWmb
         mKvAM8cDMimcsqBZo573Y/xW9S5mDFV+INaAovv9OA/sF0PKZC0BwSK3F9yHJxOtCJsA
         TIvDYAb/8S77s74rFRJdcHsPs57vC4kaEAG1MxL0BecxfrQtVJLVQWmXFRAdwnRE7MIn
         bxgUwnn5la74WayxiZo8TmR2W9ykPzBJ4oPcuJ1+jX74HY3ouMKtX61/BxXudrZY1y2w
         jKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452790; x=1761057590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPkNQt7GNnutvvFwrtniwfY3OpeKDI+MEgUBsglPSrQ=;
        b=a5AK+Vkt4jb9HZw4o1PyQk343fAdBmWulNdk62YeYvjHZwqSuWcSgbFcSmeaFUV0L/
         jDZRBEGKuWYoecuxUbmUbo0E+5H86RulFZauskNTxxn7Xm+BL2OudPUvHO008HVKTptb
         R4IzzOqS1t8qaSyaeMgfwU8xrbCUUhwcdS3icbyKeeogJNHlpFT9svjdIhO60qrpoTSj
         CRqRTuPwgfxXGF4WmyMCsxdL6egPJyM8/FAHeL0iik+ffF9V6tPSN6ru2zQlYAkfuLSV
         xHN4driUsxZUlrLPdo5OkeUdqwVKz7b+YqJNbnE/0juoeUEnPu2aNz54cRbamQsIpOiU
         smEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWlAU2i7I9qrWtnOKsMZuDcDs8+oXcmQyDHM9uVBuhbmNANqaNzqPofrzBmjjBSa5OB/2FvKqIJvDoNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaKhqIiwW1lb2SB+MvQl4nDP76W0Wq7oKFUZKry39sSm1Zr/F
	0MSfeHy22Te9B/tt4in/3YUWXZ+Gn5oAVShZ5aq6xUVlqjH1W7hqdf0N
X-Gm-Gg: ASbGnctGrYqnUZy5tGuNwlBncQzGN6lU6E29DitgYWyYf0AJScsLE4N+0/slcfd181b
	NLwXZJ6c+zV7CXh4jjVgAc+URL4K7/uOUhgtXZ0OLWEnJ0AISA0neH7MdLrvt9NNTiOAz1npFzp
	iNcbKXiamN2eFtRpDyZi+Q3H5ZXt02Ivrq+2CFiPIJLaCNHSQCELIgnodBAL2FtpcHVJ2hY6hD9
	13icNpLisf/rO6Y0+njhZx2dIE/8o/efIKFL52Rn6DYKiJFHoSsQD0pNEZ1hWKp3VOzmUfxyMgF
	h4RYpPxQeCYIgtUIomdIUp9QVn/DpdQLfwh7eYG8N/djvtef6IMpR4r0yRvWM4M0rn0bz2k21P3
	xwh5d6zlmMi4M65TgNefEI/xYj2p2bC7CLR6+EUcW4Db5iBJyYZcVGtnbG1fVFhDb9U0WpNNW/U
	+wD4LIc2YSvvqwFe88tw1O8evHQhsShIp4
X-Google-Smtp-Source: AGHT+IFL7TRKOFtqiIwJDvYHBSN+yEIpm11+iedBhhUvsR1btr/qYb0D18VFXNkYpeXXESEmDsmcbA==
X-Received: by 2002:a17:90b:1651:b0:338:3156:fc43 with SMTP id 98e67ed59e1d1-33b51168e39mr40215981a91.11.1760452789966;
        Tue, 14 Oct 2025 07:39:49 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:6b4f:6ef8:4d88:7543])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5288eae7sm13432681a91.0.2025.10.14.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:39:49 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: penguin-kernel@I-love.SAKURA.ne.jp,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Subject: [PATCH] ntfs3: prevent operations on NTFS system files
Date: Tue, 14 Oct 2025 20:09:42 +0530
Message-ID: <20251014143942.643856-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
set the mode for $Extend records to S_IFREG to satisfy VFS requirements.
This made system metadata files appear as regular files, allowing
operations like truncate to be attempted on them.

NTFS system files (inode numbers below MFT_REC_FREE) should not have
their size modified by userspace as this can corrupt the filesystem.
Additionally, the run_lock was not initialized for $Extend records,
causing lockdep warnings when such operations were attempted.

Fix both issues by:
1. Initializing run_lock for $Extend records to prevent crashes
2. Blocking size-change operations on all NTFS system files to prevent
   filesystem corruption

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Tested-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/file.c  | 6 +++++-
 fs/ntfs3/inode.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..c5b2bddb0cee 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -792,7 +792,11 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (ia_valid & ATTR_SIZE) {
 		loff_t newsize, oldsize;
-
+		/* Prevent size changes on NTFS system files */
+		if (ni->mi.rno < MFT_REC_FREE) {
+			err = -EPERM;
+			goto out;
+		}
 		if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
 			/* Should never be here, see ntfs_file_open(). */
 			err = -EOPNOTSUPP;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..180cd984339b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;
-- 
2.43.0


