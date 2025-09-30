Return-Path: <linux-kernel+bounces-837510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F788BAC782
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA063BB37C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2845D2F9C38;
	Tue, 30 Sep 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ5aTDp5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66F2F8BF1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227961; cv=none; b=saKmOX1R9vI9+Yo5TjbKf28dL8zWiDFxY5lJL6iIiBryNDqkTZ4U3a1clhIzGidHqAOKCT1V3vdMhW4cCx9+aACfcNw+mIglgFF20ewwzxI2pzyFSKO2BpUTk/HSbJmqmysRsK93NWuwAQVGJKf2n1bVFB/+uvU8djnJNDLiBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227961; c=relaxed/simple;
	bh=rcjBUVQ/qzqGAPyJDjq415/OqkbFTjgHYuWY7Q7758Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6JfIX44tag2KIB74wBtpjK2vSQBitmWkeWt4lgRqVP/VSnxPZWq5Dp02JxQJuvCzd5b2tbNM/QjYn6CDXRlLLZXkxEQLwTtegClyjgZnx71l4km6BBfAB90uLa1VgA3AqyGGoaKuuMLQY0sN8FDrZfb364dMwdF2I5EHk7Bj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ5aTDp5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eec33b737so60110645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759227959; x=1759832759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Usj+zGMFyo0Na2GYD3pfOZ6hylAz1eRVpObNmN/MNOw=;
        b=RZ5aTDp5dw30LT4EpHWwAyQov/KSsHT4SKpkjZGBzmoUjBcMVSlCxqpqpnovhhhF4z
         35nsxBkY91Z3JaQwZBCKlYUaB3o5NgqjKGDZP3ekkbVujMHbjLvAxFmDxQ1CqDOmH5R/
         CUxrk8+4UTmLWZrYTaL7669T1V0fdlOgoBZEJVzLDo8kByJNzhSE7zJrhUnolgGeapWK
         p2QmbWmRHjrZTzoYeFdZIOHmN0bE6+kYgi7DtFLuEuUjDo6cNfecoF5hkBMRUPRTgO01
         O4jUTBm19dVvfMMDJnnB5FgHD1Zj+abIP8vku7h3+VyqxtkQBCzv1OoTTZBQbLrsAicw
         xXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227959; x=1759832759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usj+zGMFyo0Na2GYD3pfOZ6hylAz1eRVpObNmN/MNOw=;
        b=LVcoKric4sF/O5eA3gdnAkE0D/rGUhxujZAJO3U5qCt/x73j2+cTks92shpojbg0Uh
         J63bXVHOs1Df089pyvG4GcGXKdlMEylE5BQ4dx3Av1GMOjU0swiDqvy+ga6ikSJYNeoe
         lbOH+VThql1WWVYOYj4P96FOZhUGJbD+vnUJPnfdmLL/zaYNmlv0g0d5ybln2gr0dckf
         3evQx4welga3t3hQKotEsHY84NeiwrOelhJI00dUdFz8YN5tk1eHthcefBQdbhKZezXN
         0/5gnS15hOBj1HXbEFNTf0lh+UhBLZMU34WlydEwUPzp6eNDaXCXb4VcrTYhCCcO6p27
         XbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQziqEO1ItifwsW20usVYP968JNAkkCsl1PG0Msfg3ID00obpBQWglrkZ5qizZEclZiOBwCsvRj4fINg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGbsXZCuG7/k1Q3p3/YHk4DBC8+6QF/Iql4gM2azI/+Gg8vK4
	Pf4R5utGX6/CvHLHHxZpI8CdYF6ySXsbcad1Xpf6pt5x4IU78W5J1kds
X-Gm-Gg: ASbGncvqbpru4ZZyhPxyF7YQPfOg5kJYzsLVzFKgI+oGEaNQji8PCe+myLmg3F+LAdG
	FZGlgLz4ypaM0rGW51J8rKyZRf2KvS9//LYq17WcKL7NtmN2XAmtsExt9fuGiEKNk2msE2LteNi
	qOrPlX3QvA3uHphzMCjqFGFg5wHveVRxmRH4cBlaAk4hVr6HBAa6nmD7t5NTP6t0XVGtbKP6RfC
	y5ASS1k2KjJQ5EcSm0O+qCcB/9YSfvtQ9+Iy+0RKRSdS4X9zs6C1YnLQh+Tprgef2IYkzxj3vDi
	Bz7OuvFw+/ek7gAmTe6rhAdkhKFtG6mWEShvFEi+171jRpfVN0+SuvPGxovzkj6wYf5aTpAgZuY
	2HMU++H4BRARzs7/EkL4snA++nYymUXBzpr4mVIc6rH9wpPS50kqRblbT2N6Jp0xuPI2VQyvSPf
	o2SS+z//4YZXfgHORYt01BXr0Gl+s8DfS08t0=
X-Google-Smtp-Source: AGHT+IHCbQEqQwID9i1SGsV/gT37SzgPwAgKzlUiVjvvwLB/MstniN5W45shljswpD3SsEPFWYW3IA==
X-Received: by 2002:a17:903:46c5:b0:269:87a3:43b8 with SMTP id d9443c01a7336-27ed49c7741mr229629385ad.4.1759227959040;
        Tue, 30 Sep 2025 03:25:59 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:86eb:e17:c717:ec3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm153429705ad.118.2025.09.30.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:25:58 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 15:55:49 +0530
Message-ID: <20250930102549.311578-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v3:
- Fix code alignment and use existing function/line variables per Zhang Yi
- Keep check after ret = 0 where all inode fields are initialized, as
  i_inline_off gets set during inode initialization after ext4_set_inode_flags()

Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..5c97de5775c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (ei->i_file_acl &&
 	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
 		ext4_error_inode(inode, function, line, 0,
-- 
2.43.0


