Return-Path: <linux-kernel+bounces-871574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B62C8C0D9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9F34E0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9542F693F;
	Mon, 27 Oct 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5puTKS+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF501F1518
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568901; cv=none; b=DcxpldyxPphq/ivBcXwLpxFadTj8pTcgr691xC2TMcT4QAkYv2Bn1DsVsHsbtAzKmTExMQiZp4KBTtl9W6dEDjl2hb+WgghdIwx5G0FK3K22Ul7Vwelskm3nZ31DlmDiv0qYR5ob4SyCk+6V/491tV/4EORufBLzb56b0PmVpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568901; c=relaxed/simple;
	bh=f/KkUu++3KmiYz5DrCSj7Frxr4e4wx4P9/+YNJ1WUh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQjY7wWc6Az9lieAfjouVYSpXYZB54tF5gmOklzdKWl98WjLL9sZ3rPFPCT6owJyDSPvhRPBSMkJHBHJFeFbI3y8IedN1pMXjs/v3WJqKZejYq8ylxjtEwojrb+2QSxTxCFFiNnf3JP4SJC6JQ/IMZeecH70DafgtEiKLBRslmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5puTKS+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eec33b737so66300415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761568899; x=1762173699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyI+DPCtqdRhIJ8G1CS/+OArsT7nhwtmjf5oWIejpt8=;
        b=M5puTKS+DcV+u3Cufsk8WZIZPkE0FvI4syTcgagBWfWw6Z4jMRvaH4Gcld5MoXtAiD
         wJDattzZw5zusBT2Trhv4GTemeUeeaz+ra4yPAJoTjVORd+OUYuhdko6CiMpCMqLOdUd
         qDTZjekx8cGnu1miAQ6eJSRFBplVzzLO1yBK/2TBjqQZamMzlA5Mbo9T5ZpP78KcJIyq
         hGbVEucZv7Qpvfc9ujPJJ4RxcIogrMRTTJtL/Uy7knhI49OEnueVPzF1q9NFLd9giFyl
         wwVp7E8OUE+L9hgR8INBmIlCUlsVGYoMDGIJcejMC43xZDxHybCEoyxyX8yPWAJXcvSR
         G7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568899; x=1762173699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyI+DPCtqdRhIJ8G1CS/+OArsT7nhwtmjf5oWIejpt8=;
        b=J7zwiFfvmmgyG1RU8iDABRejqGpeZ6qvWDUnqV8/I7lgaZXe2YlD0hGYd6J7BhahaN
         haxnIr0i6I+jSze9AYUzx8LeXrUBNqfo/oSw1WrAAbnvEA7o1TEU2kU+UemD5buBu6Rl
         Z1A2JPn7GXqDjyWYY4QzBN364QgWb4+W1mjtE287eE9BucaHdCCpxNT4ab72CARTp+bj
         oUsa3H1CmTL206BN0MuCuDNP4M78Cqfgrfjt3voZWiuRei65/kgPJOytlxSg3HiFmDYi
         bwt6k2vhrsU+Hc7VsLYUvzOZBnxxHkDWdzPx/iMqV3/nJV33tZddVhsguYufXaLKYSnx
         EcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd/8C8Yyd2DkR/1VkzaJol6c4OA/fBiGDE1cgiwVwbBv71cAsMwyiKCRkf7f7DpvC9FpyEsKUrEi63V+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKllbVTFNckaCYMOP8QLoLbrDRlvUqaebQJbdlDPZwr1rov4K
	lkIEXSau5rkzTfqX7OoaElYoSAVbbICoWb8SXvYHLy+eidZwtoy/F0Yi
X-Gm-Gg: ASbGncu4gaiyPhhMUkVLcyQSd96ARgZjigAqL2+Nm7yJSQrI0CYPjW0GuH8IzCAcADH
	uaYBEtovwaQTjKT6OvICQS+BbXn0GBTNlhzg+g0gu3XCgAi8sP1VKqFkIi5C1lwOJH6JwQakyew
	JikJrPHIjzV6j9dlpniNvwCMe2JMHgwIKSriMXTApx/OSuzGNf/Yi+B4vv/7fzxCkCR6S7P4W9x
	hS5yCp33CIn+G/VC8IxmXI8yY8IlLK2uhkMRT3OBoLfCXRFmPwfglzaYhXYh309vT+5OURllBdY
	naPcvC4ynEqIqHtzcq8/y+vEPRFt566AIlkwaAcYqLOapR1TG/NJWWqvI08ReAq6zUcZEv204NW
	of2gvYPRPl8k7BSO9jvM/HxqqxsXiV3+OLmhxyKImk0L9SnHnI63BAYJz8nqMHHOFG8eRIdgCne
	kkwjyPuuMo7cL5W9hjQxX82PQQRwAq7XsLZw==
X-Google-Smtp-Source: AGHT+IEqrgMDJfWtwihWC/Q4q/MATvDY1V66B0J6iABhpmp+mFfhJ3MbgAArMnFCcD/bsbmr2oAYLw==
X-Received: by 2002:a17:902:dad0:b0:24b:270e:56c7 with SMTP id d9443c01a7336-290c9c93b02mr497221485ad.7.1761568898580;
        Mon, 27 Oct 2025 05:41:38 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:fac6:8aa5:82e:7fef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127a09a8csm7516159a12.11.2025.10.27.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:41:38 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Subject: [PATCH v2] ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero
Date: Mon, 27 Oct 2025 18:11:31 +0530
Message-ID: <20251027124131.10002-1-kartikey406@gmail.com>
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
Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Moved validation from ocfs2_block_group_alloc() to ocfs2_validate_inode_block()
  as suggested by Joseph Qi to benefit all code paths
- Added OCFS2_CHAIN_FL check to only validate chain allocator inodes
- Updated commit message to reflect the new location
---
 fs/ocfs2/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..1b30bf336961 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1502,7 +1502,22 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 				 le16_to_cpu(di->i_suballoc_slot));
 		goto bail;
 	}
-
+	/* Validate cl_bpc for chain allocator inodes */
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_super *osb = OCFS2_SB(sb);
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+		u16 cl_bpc = le16_to_cpu(cl->cl_bpc);
+		u16 expected_bpc = 1 << (osb->s_clustersize_bits -
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
 
 bail:
-- 
2.43.0


