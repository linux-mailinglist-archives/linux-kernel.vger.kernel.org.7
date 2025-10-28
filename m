Return-Path: <linux-kernel+bounces-873028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10373C12DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9505872A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017702882D0;
	Tue, 28 Oct 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQKOJOMU"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF80273D81
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625772; cv=none; b=rLf9Q1H4zCBizH0G3cVPRDm9hM/wy8ki9VFWOUJGuDEtC5Z5d6qgYl9yzOlHRZ8CTMjHh46e0ZdLNtA8ZqZNmmNPX/hpN46AkvAQnKgxuczEzQJoYohprQGO9DKbLRd0XYG/kZFwzN3A4HLbwWJL/wKNmCXGq4fHPleAkT+gNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625772; c=relaxed/simple;
	bh=jSuLjpIYhO7/IkvgC28j6mVk4V73Q3ZkJbdO0xq9eN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYDx6QyJeIgebEiVHmDTsDeIie2csJmacQ427NGQhbxOk4iBHBSvT6fStGLaVF8a8VS5m23MdPNcXVENb0XB2ruDbYHactTg0fY/+GHDGnX1t6w3vI20hMgMNocj5/kiKUqYltef7jiliTExt20Yc34WnPnYqldslzXFJL7Op1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQKOJOMU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf1a9527fso2847224a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761625769; x=1762230569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxA31IVIvTLZC4PP61dBLgzgrOSxNFppcMG4DfzN72M=;
        b=YQKOJOMU8bDCMSrcodosJQOXS0xMfzA0Uan19pQFn5dxKSyRHOwXqagtJyCBnllzgv
         vPbX9uAA+RCAu0w56ubCLEAZFB0lD01S2t1jrraU30L4YBMRyI7oDtMEkGpC9DhytK6a
         +LF4ZI5XvsKf6uSpZgGeAU2xrUqL+PgZm0UuCQqwS3wr/JazFsKyx9RXsGcZzaFemKfy
         CDmYyz3Uo3SxZwKp2tcRb3MJ1Yzqe6h0z12OWBb5h6Vw/kJc4eWbary5juNwpphKammx
         KcDkRCxoFLVJB6udOwXGkYRGbhEn3Na/p4ahZ14/nihbuY7r2rJbIFAw3CtxLzBKy25Y
         bKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625769; x=1762230569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxA31IVIvTLZC4PP61dBLgzgrOSxNFppcMG4DfzN72M=;
        b=Os+QtkOzDnE+YIwuoUOkea/JhrDTDKfm/EGinWdxz2AzLtLGHT8qUv/xfGLAPilNY/
         9UmtgwSn71/HZKQ5PH6f13fTWYRJDm6h7EHT0ENMnQ+U8D1Uw37re0SVpv+Eg8grn1S2
         8anZemTRuPknPsvOVqYbWtSIb75oGARVY3ZeOu1ZCCUyEaBzSLAQmCtxU2ScUlQbBqok
         spsoEu4Ag5/IZIvauxjQM6HGkDzfwFjWnUPxnN650sgAfjXbRmqIr85XfTqDiqdjbXac
         uM8Pc6VOMM/3MdHC0t5kUK15rP8+DQMCJyLPirbJf60mzAclaAuLuRxZ12ieDY6pz2Ci
         IPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCwBu7nH9BrdJaPKlI1TXq9s+OPB7abAvTOqY+Yp7OOqgEBGTtEFFVDS2LL3RzkxtfTq6RMY0K+FHohSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzxkh3/9Aoa5CeC9M8LcJbzTUKcOFUUwbEBvYGHa4i2Ame73qB
	bk0YEfpBp2vzKMRJsFQbeqno8jxWa2Q3Jl4cxsPE1aXnjmHDvExSW6by
X-Gm-Gg: ASbGncuNst/hQz4k0i3l/fPHoo3SK5hQaP6S5g5rpGzcAkFWNYf9mVbp4KxReaVmP32
	/gJ9cbFrdpGN1yvQAac25ppzsuHC2doTNAEqrQtSOWZj3a+Xdy+ObIqW2OLo/Ei4QXPYqmw2R6k
	ofBFchupzFoAc9p1jAP2fzzo6JoWwP1hxt/4ZH/auF9ou7DAc4+Y3AEWAwcJ/2zgfAPMB5NjgLD
	leoaIvu0JG5AZEWESpCHdtjJXMbpJj1ULYmRRMePKMmlk634tI3OhYqCQgiEFmji/HwQj3Qe1dR
	haxbXanO2u5ZR0s3HRn5IhiEltQjzDF4LSI+ignSEaNk2oDrPljpJAcQXf9/1bU71ZeKObgI169
	PFO3KOSphD/oDQO0hkZQZVIo660N0Vuq6Z1ZiSI+WJkH0LpmURk0Kk765sFx5cwJWy7w8pcbLeY
	vRENXQxwQWCgjzrNZ84ltk9e4=
X-Google-Smtp-Source: AGHT+IHUDQvAl3K6K64cGNJY7H9vtzlOFAov98Eo06hOpppdBvKNX8zUxmC9Yvv7oQQaZhNxOM98rw==
X-Received: by 2002:a17:902:db06:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-294cc6e8d6emr24561295ad.10.1761625769017;
        Mon, 27 Oct 2025 21:29:29 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:aa38:46c1:6cd:acc2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e3d2aasm102431035ad.88.2025.10.27.21.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 21:29:28 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Subject: [PATCH v3] ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero
Date: Tue, 28 Oct 2025 09:59:19 +0530
Message-ID: <20251028042919.18704-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chain allocator field cl_bpc (blocks per cluster) is read from disk
and used in division operations without validation. A corrupted filesystem
image with cl_bpc=0 causes a divide-by-zero crash in the kernel:

  divide error: 0000 [#1] PREEMPT SMP KASAN
  RIP: 0010:ocfs2_bg_discontig_add_extent fs/ocfs2/suballoc.c:335 [inline]
  RIP: 0010:ocfs2_block_group_fill+0x5bd/0xa70 fs/ocfs2/suballoc.c:386
  Call Trace:
   ocfs2_block_group_alloc+0x7e9/0x1330 fs/ocfs2/suballoc.c:703
   ocfs2_reserve_suballoc_bits+0x20a6/0x4640 fs/ocfs2/suballoc.c:834
   ocfs2_reserve_new_inode+0x4f4/0xcc0 fs/ocfs2/suballoc.c:1074
   ocfs2_mknod+0x83c/0x2050 fs/ocfs2/namei.c:306

This patch adds validation in ocfs2_validate_inode_block() to ensure cl_bpc
matches the expected value calculated from the superblock's cluster size
and block size for chain allocator inodes (identified by OCFS2_CHAIN_FL).

Moving the validation to inode validation time (rather than allocation time)
has several benefits:
- Validates once when the inode is read, rather than on every allocation
- Protects all code paths that use cl_bpc (allocation, resize, etc.)
- Follows the existing pattern of inode validation in OCFS2
- Centralizes validation logic

The validation catches both:
- Zero values that cause divide-by-zero crashes
- Non-zero but incorrect values indicating filesystem corruption or
  mismatched filesystem geometry

With this fix, mounting a corrupted filesystem produces:
  OCFS2: ERROR (device loop0): ocfs2_validate_inode_block: Inode 74
         has corrupted cl_bpc: ondisk=0 expected=16

Instead of a kernel crash.

Link: https://lore.kernel.org/ocfs2-devel/20251026132625.12348-1-kartikey406@gmail.com/T/#u [v1]
Link: https://lore.kernel.org/all/20251027124131.10002-1-kartikey406@gmail.com/T/ [v2]
Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v3:
- Removed unnecessary local osb variable as suggested by Joseph Qi
- Added blank line before rc = 0 for better readability

Changes in v2:
- Moved validation from ocfs2_block_group_alloc() to ocfs2_validate_inode_block()
  as suggested by Joseph Qi to benefit all code paths
- Added OCFS2_CHAIN_FL check to only validate chain allocator inodes
- Updated commit message to reflect the new location
---
 fs/ocfs2/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..dbbfe72b1dc7 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1502,6 +1502,21 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 				 le16_to_cpu(di->i_suballoc_slot));
 		goto bail;
 	}
+	/* Validate cl_bpc for chain allocator inodes */
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+		u16 cl_bpc = le16_to_cpu(cl->cl_bpc);
+		u16 expected_bpc = 1 << (OCFS2_SB(sb)->s_clustersize_bits -
+					 sb->s_blocksize_bits);
+
+		if (cl_bpc != expected_bpc) {
+			rc = ocfs2_error(sb,
+				"Inode %llu has corrupted cl_bpc: ondisk=%u expected=%u\n",
+				(unsigned long long)bh->b_blocknr,
+				cl_bpc, expected_bpc);
+			goto bail;
+		}
+	}
 
 	rc = 0;
 
-- 
2.43.0


