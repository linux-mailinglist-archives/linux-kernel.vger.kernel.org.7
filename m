Return-Path: <linux-kernel+bounces-870368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEEC0A887
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00743ACDBE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8521C19E;
	Sun, 26 Oct 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOtHy9aC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEE749C
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485195; cv=none; b=bEF1nJonibTrJoL+SfxM4UZsPNcWK+leCZM9hUxqWU4IiDip2oUZEBmCH4VEG+cZZfAElnMbAK1o/xX40u2ikPy/FG3XC78fgp8fMGuNkIgBQotxG4xodsctkYHYY+NVq5QmrUS/0ACm3W6RTCRZZW9qakxgj4Ik3KeRGVdEwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485195; c=relaxed/simple;
	bh=JhBg/DEYtFnFZiVEkgExHhvzklfayDTyXLhykAU3v5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBfMFocUy+VDu6WmcxINYamYj6nJ4OHMJ1srdvl4DfG5baS1an6NxyfAuSuYI1JlYf/bijjou8xrx0l3VrCb2TNPpRjKZa1qgrP/iNcOTzfP6ZUAySe1yflytf2/zWPzuJ1aj1ft3t3qr1zZ8b1wH84CbPhixZ4ZixbwT/axY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOtHy9aC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33d896debe5so4254027a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761485193; x=1762089993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvVdsjYVtY6FXc76drGJeGdtb/RwYklmlZOHVZSsLtA=;
        b=cOtHy9aCqQQ1tnOhNEFss9B3XW1Ph7IQi7wsGK1950IUnfNqSTnC5c/72KHcRO7GCj
         fnqcFfc78UDzRMO/FGSyA+GPIr4mWeVVXKiZb3V4BuKMpTsev3V8bULm72EMb/6/rS+H
         ikqB/A5TT0jpnz0Kf6OPpF90Db3nGAx/+1bmnHNrJqZbnUXAn3iqVWxFIM4D3oi88kGW
         oHvzZBJSB84/ehPXipotqVRxkSnMSp+TjVEjJIMCHEl0L2VSpQbV4mBy7JkBgEL+HbyI
         Yt5k/u7CvxWORygM8YYxLbBzJHFFRjibpxZM4OOYFzSW0o69s0gL4+fRVBZcDWSem1NC
         ZlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761485193; x=1762089993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvVdsjYVtY6FXc76drGJeGdtb/RwYklmlZOHVZSsLtA=;
        b=xQvqvBZiorh5Vrx4xqDZiG0NVPNeV+Wf1PNyQDFCyt2jlWpinM5stNDb3h8y0ZbBdX
         zZeoyKjGhDSncx5wf7IETTvQk6QjB0G+TgK1GCfR1u37bApGV5iSvEYEKhhxjY2U3Cpg
         Fd8IGo7K/0tyDzr7Jl+hfPfd7yAA78BIVK/WZN0/bT5Hl7lB5VDpkLeiaCnPdhz/7Rhz
         4bFPCo3RnJYxF7TiwIcS6ugPCyZqmeUHgLPeBsXN9Wbce3IRlXu8rv8vqx+b1pdp13WP
         sz8cWpCPI8DJRl99chLoaZ0LxRdqiwygemrhbp17ChDfqYlCS9qOYPsXo1dePTPXS6Tb
         aj+A==
X-Forwarded-Encrypted: i=1; AJvYcCVl2Zf5SuFx1GhBdXPP8ZIuUB2/xSY53c95Dxg5KoViNcoR8ph0j01QGWjaY6VtvVnPHXLAc5uidd7U/9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBTCPE533uQSItFpZVzj0a9WI3EnfW2NirYorisHrVemLxDHU
	PZfRYZK5RWYLcazoLTOzpNCaIeHzbFZSqm/9kwfiYqCupYE3Wy8vlok4
X-Gm-Gg: ASbGnctgVtTGec6RTlzpHOpGHk6jcOMmNK2z25lrJjU1THciU2fKMApA30qn6Sk1ly9
	iQcAsWX4JqWcYtOCdXojFO9iPx9YWmoD96tpSADrIRxwxfDsLA6c4p2963SbdukEXrtGWc2z3WV
	cPyFSjbEXaKCxZyMJJUSs84mLm2olz4Jsx2ZSQGKE6tB5Yy+JVR7Jc8KkZ//SzVTupPtZfmBGI4
	zyc3HuMnk1kr/f93FbV8D05rHrw+66MbZhwB/BCDSi2fXtJCsm2B9DtDTPKc7hOqQrv8YAzdpU8
	88FAbPGq1LUq4LiMPwgJn6oqwRDfrUjB6F5pzNGZvKG2ltE7zqLTl3hUtyvQBiBdk8TI2UFtNrD
	kWMCPM+zk/8nZB0fe1Vq662zj/fIgCSWVhjTmp3/ZsfqrRz7KKyJzWhALEFEd1rJqfQRs6xzI1Y
	llSJi3SAqqoTSJwy2LELl1V2S/jWtaqgfhb8c=
X-Google-Smtp-Source: AGHT+IEfSgoONaltrGxb9fBnmRXofDodRrDKu8WknVv+/bnHYU+2XnDqJZWq1FrL2wLBBvbJsoIF9A==
X-Received: by 2002:a17:90b:17c3:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33fd6502cb7mr10730797a91.16.1761485193038;
        Sun, 26 Oct 2025 06:26:33 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:18af:8c3a:faa4:5c0a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm5060678b3a.45.2025.10.26.06.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 06:26:32 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: validate cl_bpc in ocfs2_block_group_alloc to prevent divide-by-zero
Date: Sun, 26 Oct 2025 18:56:25 +0530
Message-ID: <20251026132625.12348-1-kartikey406@gmail.com>
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

This patch adds validation in ocfs2_block_group_alloc() to ensure cl_bpc
matches the expected value calculated from the superblock's cluster size
and block size. This validation follows the same pattern used elsewhere
in OCFS2 to verify on-disk structures against known-good values derived
from the superblock parameters.

The check is performed early in the allocation path, before any resources
are allocated or transactions started, ensuring clean error propagation.
If validation fails, the filesystem is marked read-only and the operation
returns -EUCLEAN (Structure needs cleaning), prompting the administrator
to run fsck.ocfs2.

The validation catches both:
- Zero values that cause divide-by-zero crashes
- Non-zero but incorrect values indicating filesystem corruption or
  mismatched filesystem geometry

With this fix, mounting a corrupted filesystem produces:
  OCFS2: ERROR (device loop0): ocfs2_block_group_alloc: Chain allocator
         74 has corrupted cl_bpc: ondisk=0 expected=16
  OCFS2: File system is now read-only.

Instead of a kernel crash.

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/suballoc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..9f3db59890c3 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -667,10 +667,22 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	u16 alloc_rec;
 	struct buffer_head *bg_bh = NULL;
 	struct ocfs2_group_desc *bg;
+	u16 cl_bpc, expected_bpc;
 
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	cl_bpc = le16_to_cpu(cl->cl_bpc);
+	expected_bpc = 1 << (osb->s_clustersize_bits - alloc_inode->i_sb->s_blocksize_bits);
+	if (cl_bpc != expected_bpc) {
+		ocfs2_error(alloc_inode->i_sb,
+			"Chain allocator %llu has corrupted cl_bpc: ondisk=%u expected=%u\n",
+			(unsigned long long)le64_to_cpu(fe->i_blkno),
+			cl_bpc, expected_bpc);
+		status = -EUCLEAN;
+		goto bail;
+	}
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);
-- 
2.43.0


