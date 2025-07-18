Return-Path: <linux-kernel+bounces-736753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB1B0A165
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E30C177A79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677462BD030;
	Fri, 18 Jul 2025 10:59:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B9249F9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836345; cv=none; b=PvixaSGqq+5wj2WLHEALmsGmRnM4QvR334BEUMFMIWxz3vwuG3IOf9z+/jBjvmNWgYfUtFG/36hXCciqTZ6uTdqDFHAgq+GhgXMSMA04nlFtG6HEJWjEJoiwiOdJrpwnz4uX3g503RXO8/k44X+r2fGP6XH9+FKvt4HQVTODjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836345; c=relaxed/simple;
	bh=8GNVxd4El3vltPK1OzAaGFMk/YkynjhYBs/lKmanauE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BGetyv21b9OFMzGCmrOz/VmxEDDUl2QIBD8cHIx40bgqLt4TVTIiluu9lE0NebbxyvscxybtX/tGg2cSDz4PLdOkDSMRLd1ThS8pVNwruZz2JXmVl6k8qKBXJD+sCx0TezTvpc1GyxNmJOhT/q1NW6VRnnnSVukwOFkuITn3ljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-869e9667f58so382596939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836342; x=1753441142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hle3V98MR0nEl01QFI9n0l/uijLXyWAeDaxEk7ayo0=;
        b=HTjh53Y/k5yNYEiw6yOduhNsW3tArUopOUGWcF6r1rEwyhC2s86Cd5x1/97Ij4vyZY
         ClVQWCZo4iIaiPXSWkdZ6A4brVwirWVUEgUSm0jLCtQWq0yZEvoYuoOrSqbxD26xupgp
         JeVM7EzaxtgONGZPbaxyQslcIETGQEgP0nwt6rEqjwsAbGOdM5iLgrZnMlIe63zeXvdS
         jea+drrikl5DKk78kUC6lQeCc9odrzw/x/BCa2r7Vyk0g8O8GUzW0lcFs/IIqjDZhUpE
         jjILfoXR9Fv5GfK0EPJjn4UplECJOnXilgH9f3JccWoTAUcd/N/ygHDuN8vrGZKXpRYh
         gsQA==
X-Gm-Message-State: AOJu0YyDyf0Hc258lVPuL4tg1U6gCexxKzLDvW91eAqqFpj2q9ZUDH/Y
	XkxHaGWPiku+gxCNZa6pfdVdbGEKZQTIicIIN/kOD050UXFpj+9AMXzC3Kvxa5p+JuW+0gaV+aB
	l3QtrwhFZ2hJxNly2dRUYDG5JyJ89S8zC5yNwIBYIBKox3FPJwnQLg3i6Hoc=
X-Google-Smtp-Source: AGHT+IENzoR0JBuoZqkQ/XOnSMf8+yyzalRzem902hfta7V+MCetpgFGO2MsFocqu4+HnWpRjOZ4ypo/wvbZT39l2vn4cQTpYTe5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0f:b0:879:c790:3ea2 with SMTP id
 ca18e2360f4ac-879c7904115mr1219166439f.4.1752836342720; Fri, 18 Jul 2025
 03:59:02 -0700 (PDT)
Date: Fri, 18 Jul 2025 03:59:02 -0700
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a28f6.a70a0220.693ce.0060.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] WARNING in minix_rename
Author: richard120310@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 78f4e737a53e

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 fs/minix/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..4dfbbfd905d8 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -217,8 +217,13 @@ static int minix_rename(struct mnt_idmap *idmap,
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
-		if (dir_de)
+		if (dir_de) {
 			drop_nlink(new_inode);
+			if (new_inode->i_nlink == 0) {
+				err = -ESTALE;
+				goto out_dir;
+			}
+		}
 		inode_dec_link_count(new_inode);
 	} else {
 		err = minix_add_link(new_dentry, old_inode);
-- 
2.43.0


