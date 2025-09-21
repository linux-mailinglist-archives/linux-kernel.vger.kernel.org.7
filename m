Return-Path: <linux-kernel+bounces-825948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F49B8D2E9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D118A1C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AD54791;
	Sun, 21 Sep 2025 00:54:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF22AF1B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416047; cv=none; b=Gquu/VhJIHQDn51xmlxE7xz44Fk7phL2Qzm4h+NxD+SfJeOAVmGB7uv0c5khftkshJzf7/n1jYojXuRlUAF4whHlPHXAz5gR+sJIpM2taI38rQMsEjpc7uUfDttZkS+82nuJCPpq/iy8nnAJO49Ek1otIwaMdGHGatRCflbDvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416047; c=relaxed/simple;
	bh=vw22GWl51uz7KK5I9yF9ho1jq3EFxeEgSAaP8vFm3S8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V4tXNfpGYzLsaMG24P7opWVi4JWdagu5YeUPhKFWlxhr+eooPc8/l+Tv15D93NRQiYgHAQyF4qhF40I8so9hxfQLQcvJkuMRy+SJ1Vs+W69mBO1apchjyOUp8u5bFZqoDmGSCToZOTpGWjxKuV8q1XokGhI07bF2cU0qh0/ootw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4247e23f070so25674815ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758416045; x=1759020845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZs+/GN/OiEqSti6vCpFdQA0haMk/pM4DO64NNqULgs=;
        b=tFklyMm8WS6tM1J86h9IN/r4l9uyf0U2a8Lujygb8EVR4xZpo7YZj3mXfJnXx99+LI
         +PrxwT4p6m2hdRAE4P07OtR/AzJ1LvHjII4Bd7QL5ATcATJ/JMGkfT75ADnOVQ29rQ0M
         9c87RfbBg7XdCyMtgB0GcRdU4dd0rl/j3ChZQGriKmX8OfFoqR9mzO2mExiHXveHz1Gv
         eFGM8vccWg68QBGr42oW9aZmUI7FpGy+GFpje2ovS2phJTkMZUKyXPuhiMzaKiVdhc6X
         MPNq1krk3SF8LrrFnu9NfJfjGTgJkjJk/u5W+8fH1WZ0gn+rxj5cy9pXABA/0M0vFZLM
         SKfA==
X-Gm-Message-State: AOJu0Yzal9xrx9PdM78WDsvOEKzs2i6skFcwjzgLYlgh10TWNsRwj1Al
	v0MpBaTT3+1yeY/L7k6c2LVB9F5ixayn9dSsoKEGKOqSzDU8hUx6EpwLGHh6qaFF2UUYr0dJljC
	1EzpC/C6Exd+A3xYPVgWErr+bP6/aMlsu009+GaOYuKJ72QYpAsNIe+/7HRI=
X-Google-Smtp-Source: AGHT+IG9CG+8u9WtteaFsYMrB0oH5MIXb2FJoaoYsRVk4NN7sh2IeKrXVrkG9DL4qcVuaUoGi05C9+yfqflOAHV83MpEo3yuM6Xq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:408:1ec5:ddd7 with SMTP id
 e9e14a558f8ab-42481984138mr105596325ab.20.1758416044884; Sat, 20 Sep 2025
 17:54:04 -0700 (PDT)
Date: Sat, 20 Sep 2025 17:54:04 -0700
In-Reply-To: <68cdf1ae.a00a0220.37dadf.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf4cac.050a0220.13cd81.0026.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: validate file handle type and data in nsfs_fh_to_dentry()
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] nsfs: validate file handle type and data in nsfs_fh_to_dentry()
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add comprehensive validation of file handle type and data in
nsfs_fh_to_dentry() to prevent processing of handles with incorrect
types or malformed data. This fixes a warning triggered when
open_by_handle_at() is called with invalid handle data on nsfs files.

The issue occurs when a user provides a file handle with an incorrect
handle type or valid FILEID_NSFS type but malformed data structure.
Although the export subsystem routes the call to nsfs, the function
needs to validate that both the handle type and data are appropriate
for nsfs files.

The reproducer sends fh_type=0xf1 (FILEID_NSFS) but with a data
structure from FILEID_INO32_GEN_PARENT, resulting in invalid ns_type
values that trigger warnings in the namespace lookup code.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..7f3c8e8c97e2 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -461,8 +461,17 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
+	if (fh_type != FILEID_NSFS)
+		return ERR_PTR(-EINVAL);
+	if (fh_len < sizeof(struct nsfs_file_handle) / sizeof(u32))
+		return ERR_PTR(-EINVAL);
 	struct path path __free(path_put) = {};
 	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
+	if (fid->ns_type != CLONE_NEWNS && fid->ns_type != CLONE_NEWCGROUP &&
+	    fid->ns_type != CLONE_NEWUTS && fid->ns_type != CLONE_NEWIPC &&
+	    fid->ns_type != CLONE_NEWUSER && fid->ns_type != CLONE_NEWPID &&
+	    fid->ns_type != CLONE_NEWNET)
+		return ERR_PTR(-EINVAL);
 	struct user_namespace *owning_ns = NULL;
 	struct ns_common *ns;
 	int ret;
-- 
2.43.0


