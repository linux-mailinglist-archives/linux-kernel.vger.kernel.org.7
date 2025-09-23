Return-Path: <linux-kernel+bounces-828131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D074EB9401E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0B54403F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DA1D54E2;
	Tue, 23 Sep 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1L9VdhD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F40111A8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594718; cv=none; b=cy3wGSpl9f96ZWvnipS007MX3OZpLLbvvXaHgiRDFRQpi7GqhRj5Flw8q3P+GPw7j1dCTYHtHXAbCpQdo2jCFlM6smmbfT6wFGmhOkk9Xm7qlW+QxQXQQtcgdYHWRApqBl21VslKLNW/rNGAWYWNKzUeSjzgEQtgGs8mOequbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594718; c=relaxed/simple;
	bh=FcPDJ0r5DC2wcBffd6nQD2vniyv49dIXa7kGnY4Szwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2g9eOQTFI6QD0VHGqZGMGMHzwBqVur11xjJaVbSC19X2Ajoat/kgTtJ/265yi687WKezmQEU3yXJQDhUyZNrgIhiKUJ6VYZKBQiVVMKNVVWke5/TzEzVjqbvAXpbkytJ9LcZIGJwvAFpiPSVPsJYXRIfGf5ZfotLACSkHcdbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1L9VdhD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso2711500a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758594716; x=1759199516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoweYivaZta7DUjVBF/vL7chb8GkjKFoKawijevmV4I=;
        b=a1L9VdhDKAsav3yR9vx2VnNLqp3o6UoE6bnZ1JnLA7L7JLH5n2Bz5cY98B2BovZssc
         R8B3oAq9vufqZZSrjYibPnD2tazrYAxpoolh0yy0QxdU15k+aib1ElWKVkT4iKfg5sn1
         ydgfddvt3/Y2XifdCKUsKOpHmCrylXFHLdkFLC6euhNn3wEk4qbUj473r2tBdk5h9dOp
         1c05WjQnv0ZKLdwWbixnQIPreoMn2dQE0JNJXMVB9IW0ZOu6FQR5PZnJOslghNFKphlj
         5Op2Ps3haq8b/u7Yg+xN829LVzpa92kJR8Hj/fRCw8oyPy4H23a/pkj/lK/i+9l90nic
         wCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594716; x=1759199516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoweYivaZta7DUjVBF/vL7chb8GkjKFoKawijevmV4I=;
        b=EsvUsR8YXimyb2yVp2v+nsJ4CaDm27mg2hFAx8oGSJn9OIHbnoQkC63ImmkQbRju01
         za/xARR9H/v3w68F3wzjnu2voiWx5TDuBEYMl0UHFgW2auanwAxlnycpYg2EBsuUkETD
         YUgsq09rtJ1KG4CRv0PtBmNvnaudp3gKkl9rJqtHefX/oN107F9f+uJMsxFMXTmqtfAl
         63yTQUpL+Um0FH52ACoaJuSFr6OYrRESYFsjbCfno9GKHJKFQObw3TvXJpMaZyxzX69Y
         sKuCmcaTNt0MgtdlyyhbJgDm04AMJptLIQX2n58OUq0lIWZ7zrtg66CLrrhxTDAYYPzy
         sPJQ==
X-Gm-Message-State: AOJu0YwZx8e2Aih5qewrbftvDGOVJaH61ocf6gfudtGvy5YZfXOE4mJ5
	f9cDi4Ln7E94bddtyi8+8+rU769QIq0Nepq7Ajge6+l8I/JXic8DbR6G
X-Gm-Gg: ASbGncvpZ/SrH/YQRltCj6t4hGba5mLWY4TrFR4Xe7MDDw8/jFIEO3BglOzSbV6MhDe
	4JsmH6E4GFV3LVPFMTVDLbDg91sEJAQ+k6nlG8P9xXxPpghbLlG3wscKkZC1cHxboK84J6T1vey
	7K0lnK8hKjkO/8WCj6YC0cr6R9IXPL91bOUBE5vLjIZo47rYb0EUmpebLVuvNYteZ46wte622Ei
	8xTryqS3c+THV41eZ4ptWsbMlWYqOoxSmaV15cX4w/XLsJGNw6jtxEcqd1sgAt0qyGb3zFknO5b
	Y6gA0SpcaQc57qE/6aOjnwvay8WUJXlGEKwrCrw+dUnjYhbgTX4CIgcT/tiR3dl92QbxrAH2TUL
	Zk4RGOkSlSOTpip6RapKhI3SsVOCj/wYVceFVdNOGMkvnk5vUdIW4p3Kronqgw6hNC+IX/s5PvG
	albxaf3jEzRJ2HvA==
X-Google-Smtp-Source: AGHT+IHjDCkxdWMBbTp6+RDlX2KF2TPM1PjQW+TbG++l9Td8pqqPZAA5pbSpxmC9m92VNg2tA/C9Lw==
X-Received: by 2002:a05:6a21:3291:b0:2cb:93ab:7edb with SMTP id adf61e73a8af0-2cfdf479597mr1538070637.4.1758594716337;
        Mon, 22 Sep 2025 19:31:56 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:e2e5:573d:ece2:1f90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4952ee59sm2293502b3a.37.2025.09.22.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:31:55 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] ext4: skip inode expansion on readonly filesystems
Date: Tue, 23 Sep 2025 08:01:48 +0530
Message-ID: <20250923023148.1074924-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Fix WARNING in ext4_xattr_block_set() during orphan cleanup on readonly
filesystems when debug_want_extra_isize mount option is used.
The issue occurs when ext4_try_to_expand_extra_isize() attempts to modify
inodes on readonly filesystems during orphan cleanup, leading to warnings
when encountering invalid xattr entries. Add a readonly check to skip
expansion in this case.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..480f1f616e7b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6403,6 +6403,8 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 					  struct ext4_iloc iloc,
 					  handle_t *handle)
 {
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 	int no_expand;
 	int error;
 
-- 
2.43.0


