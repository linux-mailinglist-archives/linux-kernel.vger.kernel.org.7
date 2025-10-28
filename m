Return-Path: <linux-kernel+bounces-873147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20081C1339A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0330F3B2DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5123EA93;
	Tue, 28 Oct 2025 07:02:03 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A8611E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634923; cv=none; b=jSjudz6gPWD/VCw8n5NrZtyx5f9+eH+tLzo9zrrlf33ywCaFSHHDd90bWAE02GAR5Ep8wxnZtOhipHEm/aOJnsYVq54TbI6NJtEiLPWpQx9VR4X+BZMI4fUPug6+x5vVUA2ymxNxFuFtfbAfxPWoQy/yj74j31FTa4ihBD0KrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634923; c=relaxed/simple;
	bh=o6vfYRL670UTzvEYI0IYtYuh5lvpPmxDhpGNxYD+n70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BZfO//7QeoFzHs+ru0JGuToh1RiWPb2aZTyfyEbB+sXccsDcNW0EGQss/SMeQjXXzXqi8kh4BJKnNzksO5F0YJ5/3fsNa7FDr6SoDbDWuYUC6RtXaJ5LAUpTmt6PTA6mvn9ueqTqPQBwlvau5PLD2JbGaLDYOxzP+vEMl/UOrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c3232caeso70220515ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634921; x=1762239721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjjKvb/C0MS+AEY/AcDfzOoViNt0lKgCZMm+iN7N0lI=;
        b=aHqq21YJQjBOURrg8MUO5/ZDISWsJi0i6dbZ4OfmnBfQCaTKQ954mScmkwIXLNEmM6
         ICb/2pq2rsaufFpXzzx7bCue8yAWDH/2UWWIbJ2zSs0OmRiM48yFLo2cmo3x7jPlvLQt
         aU5SRkiFKS9yUnz6eDcXIYowhbVOW229riMO0yOycKzKdPjBhAUjClPv/mCsIEHA+dD4
         +vEEWw3uPXSGR9boePt/edGPc1pJTQkA7rwEm6h34R91vehmuvzbUfcJmqaq7YyHUZmr
         R63M5Q6h5lAt53/zh3r90Y3QXdFb7EKqrPF6IfQL6BkvlE6Qb5BwptyftJdFLwnL6AiG
         6cvA==
X-Gm-Message-State: AOJu0YzyfIFCAEGfuEu0RmGg9YRUtyisVMJtJfjtDB4Y4WsrEGnHP50/
	Cbn/rRAXms9MxKdCPjKh9OhULuAJg9rEpTXgZNo7KzCDE9VFCcKjVwgAemGd9YjHsHZxhYOg1j+
	eqJyi4GJwZuzbDRcIqadTEdCVH23pCpA4HZiQnlN1mHf59iwZJdu7CFTjJfM=
X-Google-Smtp-Source: AGHT+IHKxacRFYeMDcGwL1kE/xGZTgtjIBlv8E4aHmliKZ+3bWZSyDAxL9M51zLHEqYQHTGuC9YF0NK0qD6lsG90BsJCFXsI/KAL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:430:b27a:7702 with SMTP id
 e9e14a558f8ab-4320f6a76c3mr44675435ab.3.1761634920894; Tue, 28 Oct 2025
 00:02:00 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:02:00 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69006a68.050a0220.17b81f.0007.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 fd57572253bc356330dbe5b233c2e1d8426c66fd
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fd57572253bc356330dbe5b233c2e1d8426c66fd
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..1b6bdd9d7755 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1503,6 +1503,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+
+		if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_count));
+			goto bail;
+		}
+		if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list index %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_next_free_rec));
+			goto bail;
+		}
+	}
+
 	rc = 0;
 
 bail:

