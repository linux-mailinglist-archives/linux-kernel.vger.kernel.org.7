Return-Path: <linux-kernel+bounces-885228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F720C3252C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879841898C58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD06334363;
	Tue,  4 Nov 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwNnK3Iq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA0333752
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276895; cv=none; b=VcducyjsFsa08rPZ5xuQOwfKLyR6CuL28d98iBkTMBobOuklcrbqYfT2V4mIvWMnyj46v0Qv/9nPM0LFL6SibPADpouPswm5A8aYOq0Zgq1dFSUiYLDXqkv15dlT+JWfEydQJa5yXcgfiwHavlmDNZSkCyhgrGqBvpbGOXeKwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276895; c=relaxed/simple;
	bh=bA2jIZ7Kc1WcFGSU0I+T8TPROwwA+k34BdJqOp9H0lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xp+05SQwlBKuIuyTE9zS0jNDmCoYI44nl9+QU7xmAMZuYJWUKwhQVYeXB1KKNQH7DVL0BM731VLIUBH8K6GhNC6mUXFJE8E5Wx3Wbhe2mmHYR7NMIklzR2l3/6kCUct8VJk6yXgBvUWyT/ZtFa0CXuJJBapGvwhjBm65tQquf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwNnK3Iq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so5079529f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762276891; x=1762881691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk7uqFJsT+OuuyILG2i0M0OWp3LEmpDri8uW85tcWA0=;
        b=dwNnK3IqI8jZOoTi/+alyL+qSuSFmB6gMGUq8DoEZdNR/+73YbZos3q8AhER8p8+ed
         HDDXK5dimWsGywqVP9eht2AjinfHYtKRZHhQZALRVKLzVSyYY0CDla8MXu2NGIMaTJd0
         JXFENbCihooF2kyatRCC3+Kxn5fJTOiye0lxIDJm3p98Gvxo8gIsGtCBf1BwlI0yw3Fg
         i3ohTSpU/vDqw0KHIQL/RNsWgZoZna/bhNISfkLVZ0LB55YH9Eg1758i36ta9beSYVsN
         WgH72l7oZCuGym1GY3zqNsu+iO3QDcw8cQ9XjO5rtXqxcRiDbCgt+zl7D1LsNtVoUCyL
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276891; x=1762881691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gk7uqFJsT+OuuyILG2i0M0OWp3LEmpDri8uW85tcWA0=;
        b=RZCUTp133w9M0c7rGBiTGMjgfTvuadIWbP1Uoilfjnh14wVBmCT+I27/wcSBYyXf1w
         UCLMhVHfTEhisDgQBf/3/mOnOQhrZwd6dP8GCR0UWD+w48bJYuQZx/UXztKxrdT4a0Jl
         m2nW8Sc9SGJaAyqhaA7UEWCzSL4Y27EcMfypBZ2sf2cyntKt3JhgjTZ/UtpuzwPC7GP3
         5GEWmG+dR18KlYCzoUkfBnpkBVtJOkWmnPsc5whuOt8JQ1ELG63Di1PtoLaPHxNAyAxD
         iF2esiOi2hxQFkI5pavsMWipSlmUG9OUh/Re/ELplk26rvmw1j/EMkdDpE6hJcuPvr2d
         3Xlw==
X-Gm-Message-State: AOJu0YwxW5icbijlMiWCOwS/ZfGt20dpfBY3zak7nhCdlhGJmqYeBIOg
	S6sMw48N62xijjbz4YPIUyx+61U9aKv8GvTtTAewq6GlZ5kHLkL4o98P
X-Gm-Gg: ASbGncsRLfOpikf5nH0OQ2hYpPQSZL4TAVDLfxM2Q/p3qCudoU8wrCDa148TWsUYM/5
	vUfa5gBLTcwJmAX3gcJpzNumbEkKJvVwNuF37XpqV7K1cOAkyW3Q9cbLhCkHeXijuwCXVR1qj+g
	hGbs2aNCHYKTBryi8s6lgxB903TUTcCZo9b64ZzyimANULwXmvFw9h27u7LqXZZmbv1WOLq/kQg
	XNHa4vWFOQBpQozj5kvr5emyM3jmOnSBsq614v9r2Q53wDmlePvUl3i2AxKuLXqj/Fx3KqfrFUO
	+ZT94261XT9ZKUwQH9cP2jGjYLgjK0VL0UaZlqGdraf0ys9volfTWWTCyQEnt8tlnrp+NHVBPhk
	U6NjcE6r+c95bHHy8oEO5tGT/eBOENKlI/rouYrxloR6UdaESn+i6DttwBT/jRQQNoab8xwIjNH
	1r/z9UGNTiXyg=
X-Google-Smtp-Source: AGHT+IELoaHLTPtLdfqtX2gyAJ6rc7yZLL/Fk6dfAmMUtx7g1a7eIhcZzPNyI+EikioHE3gnkd5PRA==
X-Received: by 2002:a05:6000:2681:b0:429:bb4c:9589 with SMTP id ffacd0b85a97d-429e3276a4emr106522f8f.0.1762276890618;
        Tue, 04 Nov 2025 09:21:30 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9c8esm5724211f8f.33.2025.11.04.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:21:30 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Subject: [PATCH] bfs: Handle directory bfs_inode->i_eoffset == 0xffffffff
Date: Tue,  4 Nov 2025 19:21:22 +0200
Message-ID: <20251104172122.4029513-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bfs behavior for interpreting i_eoffset == 0xffffffff
as "unused". When the field is marked 0xffffffff calculate the
inode->i_size field from the number of blocks allocated.

This prevents spurious reads outside the device during bfs_readdir and
bfs_lookup. This is the only on-disk value of i_eoffset that will pass
the initial corruption check if it is larger than the actual disk size.

Syzbot stumbles upon the bug by mounting a bfs filesystem with root
directory having said i_eoffset, which passes the initial sanity
check that compares it with the total filesystem size:

i_eoff = le32_to_cpu(di->i_eoffset);
s_size = le32_to_cpu(bfs_sb->s_end);
(i_eoff != le32_to_cpu(-1) && i_eoff > s_size) // This is part of the
					       // corruption checks in
					       // bfs_fill_super

Since BFS_FILESIZE expands to i_eoffset + 1 - sblock * BFS_BSIZE
when sblock != 0 it wraps around back to a large value (~4Gb).

Later when listing the directory or looking up a file we start
attempting to read past the end of device multiple times,
which takes some time and we are stuck failing again and again.

Testing:
  As this is a relatively simple filesystem it's operations were
  "manually" tested, meaning filling all 512 inodes with random
  data, random reads, writes, deletes, etc.

Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/bfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..aa5e66290f6b 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -79,8 +79,13 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	i_uid_write(inode, le32_to_cpu(di->i_uid));
 	i_gid_write(inode,  le32_to_cpu(di->i_gid));
 	set_nlink(inode, le32_to_cpu(di->i_nlink));
-	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
+	/* For directories i_eoffset == 0xffffffff means "unused" */
+	/* Calculate file size from number of used blocks instead */
+	if (S_ISDIR(inode->i_mode) && le32_to_cpu(di->i_eoffset) == U32_MAX)
+		inode->i_size = inode->i_blocks * BFS_BSIZE;
+	else
+		inode->i_size = BFS_FILESIZE(di);
 	inode_set_atime(inode, le32_to_cpu(di->i_atime), 0);
 	inode_set_mtime(inode, le32_to_cpu(di->i_mtime), 0);
 	inode_set_ctime(inode, le32_to_cpu(di->i_ctime), 0);
-- 
2.51.0


