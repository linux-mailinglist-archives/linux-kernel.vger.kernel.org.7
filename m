Return-Path: <linux-kernel+bounces-825560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88634B8C3BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59C61BC6F01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA42798EC;
	Sat, 20 Sep 2025 08:11:44 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAC25DD0B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758355904; cv=none; b=eAF4CSFa0s0qU6AvtCv3n6EKfwmnuWhFBvnME50WcY1lI232afXV+71X0mUOa4UgIn5/8xTuxFYjxuYRaoOk6a6EorERM2VHMChLwfOUmoyFLqkQPZmwDao9pRiTqapqhJ84IX72t0BNqOWt+oUwaPLvcEtPWiN7AR//Xpu6Lvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758355904; c=relaxed/simple;
	bh=zFNpe3SBlBIE1r0hFwEJI1XqG7yghnlnXS12yjn8hao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uoNebIQxtpat2vgrljcf6pznfXHlSG2pEjId79dPlssshHkvibKu4Byb9dScCOP894/EIocnULiTqwSCQASb42/lK/seaDvb8rFqe1Bv0rtuYfUX2oSLTn+J+jnPSb3KzsNp9X4nX6OPAp+peb4NjbyMMdZkKCzTsNtk3SjwoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424877bb4caso34398345ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758355902; x=1758960702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4sWT4Ge+xTgmMZWU5fco27yU6P/Z/1Oh5oD+RScSLE=;
        b=YYOfXep9wpuaeK6MHhoFJC04njNVF+8yJAwBOuhAiucC3Q09l+son60X6ru6coqet4
         xlZYXmkIFpD0gyyX0Gnw5P1cyTx1RVQNBB3UtKqot48zISEBC84IFUdHIDCDX73KKyw5
         cbQE9MPaxSShMuxSUlzZsG04iCdl2/6L9VrLJ05ReuKdnYZKJzZudDuII/iCs4Lq3Cfg
         ez+fmLrG1rekXFV92imkK3eSJFxTEq+YdAwt0cGjm9YQ4WnRW3pqLXfxuKMp7Yi6xz7t
         6Z7LaAUoAqzvyzTHhW9x4xGS+4aYVbpDL3DaT+WPAya0EGI9FboEQqRape1ta28Z4DOR
         G1sA==
X-Gm-Message-State: AOJu0YwKe++VCG/FkdGs9aacfVZVeMF5JLtwDYBLia730NKm+sOHKe4Z
	LhuSLUakNSCyZctFC2sqjh/eulXCrqN8kA0ZROkwT3jLmPM2U+tSFL+jQ/WDF/7XhFKIJlX0KcD
	QX0k10kIASsN1UDvbiWqiNuAIyt/sP6ZizGusl57XH1+RHGCVOZ++wwfZQiY=
X-Google-Smtp-Source: AGHT+IF+fLIOaSnl1Q0d4sv6sPgubs6P8Qh9Cmj6XBSYrAcWXTo5wLrAbTTlAcMEaxb8vfh37ehzRgE6winbuv03fapBF5pe2zgc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:424:8013:c7dd with SMTP id
 e9e14a558f8ab-4248190b458mr83491055ab.1.1758355901817; Sat, 20 Sep 2025
 01:11:41 -0700 (PDT)
Date: Sat, 20 Sep 2025 01:11:41 -0700
In-Reply-To: <68cdf1ae.a00a0220.37dadf.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce61bd.050a0220.13cd81.0014.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: validate file handle type in nsfs_fh_to_dentry()
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] nsfs: validate file handle type in nsfs_fh_to_dentry()
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add early validation of file handle type in nsfs_fh_to_dentry() to
prevent processing of handles with incorrect types. This fixes a
warning triggered when open_by_handle_at() is called with non-nsfs
handle types on nsfs files.

The issue occurs when a user provides a file handle with a type
like FILEID_INO32_GEN_PARENT (0xf1) instead of FILEID_NSFS when
calling open_by_handle_at() on an nsfs file. The generic export
code routes this to nsfs_fh_to_dentry(), which then processes
the incorrectly formatted handle data, leading to validation
warnings.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..050e7db80297 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -461,6 +461,8 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
+	if (fh_type != FILEID_NSFS)
+		return ERR_PTR(-EINVAL);
 	struct path path __free(path_put) = {};
 	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
 	struct user_namespace *owning_ns = NULL;
-- 
2.43.0


