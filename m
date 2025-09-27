Return-Path: <linux-kernel+bounces-834867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F1BA5ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015A23B3242
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815602641CA;
	Sat, 27 Sep 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQbsl/LN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F21C84A1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758961515; cv=none; b=hdkG9cZ9e5sRl3R87NbAvjXAJK1+wPB9B1cnaLQTyHlAERaIpepNTCckIOuXqraK9L1VEG4xy8fHicTOprVRJTIQMMGqzEthk2AcIR4o5fZu0jMulH0AVkWpt9kktZ/+qgN+LBbN2xOMA9FvxUVHkGxuzE1M9fOdDFQJdSD6utM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758961515; c=relaxed/simple;
	bh=p5vz5xhbT7dt6WixoUghQiRDJb+PLQ3a3K+iSodMKOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPLCMaPm4C/m3Xm42Gsz2BEz8guqO3D8CLiP6H6bQEqtlcI1+9+V5+kRTmIqyhlwKzEm6FRzsO90znUAdqvwm2ETKcSKtOl+pNREZIxDsV1dwiGU04lv91Hty7Gw0Ew7eL12paUm7Xhz+z8A7e1kHcxV55unyCGYKb2zqsMd1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQbsl/LN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so30641845ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758961514; x=1759566314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcS53qL3vygg89yIrHdWsxucuF37fzAauEVoENx9lyI=;
        b=RQbsl/LNxsReAM+SpVeiN28krhPr8B5qRyd4bRKJAUuXkzb4E2mWUeL5yLk1VqtBGe
         nxuO82bFjkLHlR1pZUIKx2qGg3wqC7Pgi+UM9WAfzmtqTdr4aOfXEy0neELO0WQhyE3X
         RrVK/ft8wsYZDzSGoXqaiZOimHM9JWa3P3iRobOJ2yyLNa24i+y9Lhk8VYyTDYsUupIG
         Sh3jsEMTBcMzQAkxfWKi6yWcyMHbsLsBS8anK+b66H/LPQgrzJlSMRHaOFMSoEazMyyV
         xqDVik7V3wB2/wq4xXyg1FpZHYq4aGPL5Xxbs7RLBaPb7jXsrkwU7gv0/KY72EM8vBFs
         epCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758961514; x=1759566314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcS53qL3vygg89yIrHdWsxucuF37fzAauEVoENx9lyI=;
        b=PbMQPA14ikagyP8MxzUEW5c/yY0nrWr+6kQkPNfmHMmpd4TI1cyq88zwjXyz+xrllK
         KKgktM52DKo3aSjmEAPk4+94CffA5b1uekTMAnxAtx0pgkmBrgWdPAT8tQl5tIp4eh6W
         2sHedX5QVhxsX6uIIYmnRoOK7Ij4Mhp+9dDY+djWYSobIHWCLORfIAUIEq1rWKZf4X6/
         yvtnm9eF90s+IAgnAhlGgP3aASpGpEp1mAXvp+R+Of9OogB92s2f6v/Xbjio7LR5uyiI
         g2Gb+gNEdrtrRmuUVGkHREKcjuuUejFyvtnnSBY1P0+stMiLFUUxSVkay4IzPBN/Lvwh
         Ru+w==
X-Forwarded-Encrypted: i=1; AJvYcCWx6XxvaBUaTzTTXe8getFFpMl1ydhVExlxLn6vuEfnaaNfCzckLKHxLaAkfbPoti+7ofRTnF7JJ0XzPQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZWqbcCglNKFY7TB8r7fz/UUzb66s1dU4qP3ZvAu7fhK0ps5Y
	EdrTZnUtMTuhRC3JQallm+dKojZUBSIPU4k5zXpvyp1U/qxG54d1Wzej
X-Gm-Gg: ASbGncuU9RmGUMmC4sx4u4nlC2+q1WDMh2ucaKJZNkvqcBZRzyxSZ91Mad8qzIDGJXc
	kfjlum0R3fHLNiMtLk4t67aGJssSQD40X2RN3kYSZLzDdE+pbeiZe/7RinAfNbfCIroQhimeLxi
	2N024WBYi/FmrgKXWRnnOt3xEBYtYmKqq12oYVGls5H9+FUduGjrDhcUAFhfpAHfXiaPnRWW3VF
	kCi5zOsHJ6vizTNZwm3QfcryVqCpN/zufMsHwnZ+6jcRJUty5PPs5+qxzlBBx05yUaAC5oGCPyk
	ysI4Ciwdi2yyMmnJyOmz1rMLpNUgk0M5xqIAmuBaFq4xI9pwNylzNbJ/cmGUzWkbycpAW7XoxJh
	JyXIp/8r/8Av4RJnY5zFbfaVl+H5uwPZMARlyzjeOjCsw7z3HkY6JceFe7WlMo6dCfW4g9wkth0
	KwdDrqaS9opW87AaNCAKwAG+kG
X-Google-Smtp-Source: AGHT+IECY6O9JpWVGyRWOnkVuWa9I4Cr7WOizR6qimQpbLIm+0WrHLfoZYMvAzc26KJNd3aVTvVaOg==
X-Received: by 2002:a17:903:19cb:b0:267:cdb8:c683 with SMTP id d9443c01a7336-27ed4a0e96bmr114981805ad.27.1758961513691;
        Sat, 27 Sep 2025 01:25:13 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:6bb3:b65d:f7d0:cab4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6700cb6sm73743805ad.34.2025.09.27.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 01:25:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Date: Sat, 27 Sep 2025 13:55:03 +0530
Message-ID: <20250927082503.40951-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


There are ABBA deadlocks between fallocate and readahead operations
at two locations in __bchfs_fallocate():

Thread 1 (fallocate):
  bch2_fallocate_dispatch
    inode_lock(&inode->v)
    bch2_pagecache_block_get(inode)  // Acquires two_state_lock
      __bchfs_fallocate
        bch2_clamp_data_hole (or bch2_mark_pagecache_reserved)
          bch2_seek_pagecache_hole
            __filemap_get_folio
              folio_lock()  // BLOCKS - Thread 2 holds it

Thread 2 (readahead via copy_file_range):
  bch2_readahead
    folio_lock()  // Holds page lock
    __bch2_two_state_lock(&pagecache_lock)  // BLOCKS - Thread 1 holds it

The issue is that drop_locks_do() only releases btree transaction locks,
but Thread 2 is blocked waiting for the two_state_lock (pagecache_block)
held by bch2_pagecache_block_get().

Fix by explicitly releasing and re-acquiring the pagecache_block lock
around both blocking operations (bch2_clamp_data_hole and
bch2_mark_pagecache_reserved), following the same pattern used in
bch2_page_fault(). Force a transaction restart after lock release to
ensure consistency.

Reported-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Tested-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/bcachefs/fs-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index a233f45875e9..66a60e5f03fc 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -694,13 +694,19 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
 						 &hole_start,
 						 &hole_end,
 						 opts.data_replicas, true)) {
+				/* Release pagecache_block to prevent deadlock with readahead */
+				bch2_pagecache_block_put(inode);
 				ret = drop_locks_do(trans,
 					(bch2_clamp_data_hole(&inode->v,
 							      &hole_start,
 							      &hole_end,
 							      opts.data_replicas, false), 0));
+				bch2_pagecache_block_get(inode);
 				if (ret)
 					goto bkey_err;
+				/* Force transaction restart to revalidate state */
+				ret = -BCH_ERR_transaction_restart;
+				goto bkey_err;
 			}
 			bch2_btree_iter_set_pos(trans, &iter, POS(iter.pos.inode, hole_start));
 
@@ -730,11 +736,17 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
 
 		if (bch2_mark_pagecache_reserved(inode, &hole_start,
 						 iter.pos.offset, true)) {
+			/* Release pagecache_block to prevent deadlock */
+			bch2_pagecache_block_put(inode);
+
 			ret = drop_locks_do(trans,
 				bch2_mark_pagecache_reserved(inode, &hole_start,
 							     iter.pos.offset, false));
+			bch2_pagecache_block_get(inode);
 			if (ret)
 				goto bkey_err;
+			ret = -BCH_ERR_transaction_restart;
+			goto bkey_err;
 		}
 bkey_err:
 		bch2_quota_reservation_put(c, inode, &quota_res);
-- 
2.43.0


