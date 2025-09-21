Return-Path: <linux-kernel+bounces-826009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E64B8D544
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED437B24E6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772B2BCF6A;
	Sun, 21 Sep 2025 05:23:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D978F4F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758432205; cv=none; b=t5eOhoVOM0ugd9fMBamS2YESZTJkEW/4wOKEMvAg9pCF+0CXnRbRH9lIpKEyUKMXg4VlyKa7CQd/TrIRRh+3lIvWxFZJA4f7rSOJYmM6R3cJ3Yk3ZHUEQSx7fWCvLMl3ldlYC1KBJbbK40u8ckHQSbgPfF37/RPuY9sGk3ZnzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758432205; c=relaxed/simple;
	bh=B02Cv+PGaZ31kDay6tOEHuuOWETe4O+JW5G6ry69iZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gtM57tztiAXe9JRdHzlALpPeiZZN12lRiv5A1TJ2JMHKY0QMDh1rw3zq4ZtX0z8B38lLrR1jGB9rmtMvtUPYd151ONjdptWxZch8AbsKtZvRnfKNq/w3rqVCO3XbGWClTaJi7l5L2iuAS5ChQw8+mwred/TcjUu/GVGYe1TPEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4248b59ea91so39603155ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758432203; x=1759037003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c673EhIOfFXP7ZRa+SGVS76BZ1G6Oa1KPFzaNIv+gUY=;
        b=obOzweFYrLyPPtVLgXN80l1+83iZ3xxaZ0YHufo3vMah/OIJhkgg3Oye3VahaXSEah
         tHTBrOiYjYOLviSIeMzRxN2+48pFvIKKd++WbT4nqIFHrfSxVwMqAgG6yWCSfZK0eY88
         NgFHimgzEIBNui6xlX5vngtLClpc4ZSuzj/92rAWT5hs7PbAjnand8cBZLojMm8LhS84
         S4FHck+Fi5h/LIk9GoFCQti67sxuq85jSBAribCt9KCtbr+yJN7G8Psce7r8g/mQySKX
         3NfquegZF4sZj6dlD1fN5AiSy9ipKr9YZLJPY2AHT8Jfd0wHro+XDVf1BDYIvbfcdGWz
         iedA==
X-Gm-Message-State: AOJu0YyDmckq96FQWMm88lQeBPnkf3BZjpFUAhnjwJ0idFaJSp98OlIK
	1KMJk9tGYR/GNdO7zux1voqXEBizxBrXdIr2Tj1jVoWqdvKAnSKxjagxBKkiXWf64cSeodd1mya
	QrHVvnJEAfdRn05ARNnzGNpoRyyIKVDN+XoLnRRRE55gIdbony+ltRza71PI=
X-Google-Smtp-Source: AGHT+IEaPCiWhbcYUpIDzDvyZ/e6xC4FvFNYxBemglPspPuS4oBbb9ymU8+DZ8nsmQ4229OkrLmkS/XmEWqaJq/qU9itmRvWvcJj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:424:8166:9b7b with SMTP id
 e9e14a558f8ab-42481927117mr128602005ab.9.1758432202804; Sat, 20 Sep 2025
 22:23:22 -0700 (PDT)
Date: Sat, 20 Sep 2025 22:23:22 -0700
In-Reply-To: <68cdf1ae.a00a0220.37dadf.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf8bca.a00a0220.37dadf.0038.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: reject file handles with invalid inode number
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] nsfs: reject file handles with invalid inode number
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Reject nsfs file handles that claim to have inode number 0, as no
legitimate namespace can have inode 0. This prevents a warning in
nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
file handles.

The issue occurs when userspace provides a file handle with valid
namespace type and ID but claims the namespace has inode number 0.
The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
comparing the real inode number against the impossible claim of 0.

Since inode 0 is reserved in all filesystems and no namespace can
legitimately have inode 0, we can safely reject such handles early
to prevent reaching the consistency check that triggers the warning.

Testing confirmed that other invalid inode numbers (1, 255) do not
trigger the same issue, indicating this is specific to inode 0 rather
than a general problem with incorrect inode numbers.


Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
 fs/nsfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..42672cec293c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	if (fh_len < NSFS_FID_SIZE_U32_VER0)
 		return NULL;
-
+	if (fid->ns_inum == 0)
+		return NULL;
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
 	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-- 
2.43.0


