Return-Path: <linux-kernel+bounces-836485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83CBA9D36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821C53BD367
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F730C117;
	Mon, 29 Sep 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV8DM57G"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18E30BBB8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160599; cv=none; b=rIGb4mFB+g81wQzzt27FJlHBqibiqnBN33CDCsWb5IRrGfiAni1M2eyM64fcTB98tZpDKYi+DyMLp4tZja+TBf3wAG0vrGyZBun/RXJbJVjFN5Flf+btaf5eTrLqTuzwIc37ad6D6nR9Vxz9vjExEzK3Yagn3kTuLKunWjqfcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160599; c=relaxed/simple;
	bh=XXdR2qmKllkIUiFxVyiinwoSt8lzNPgpEvMfu1KvICs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUdJ7YnLP+I+CPZCiNixmMCBw1SDI3H7BSMSXu6vYzK/fHXnpQJTjOFIXlyJtOeAeF1avdod7HAJn/ALcClwLxj3k5CmDhyYScC5beHAVsSQyx0EkbD4/CG0vNI1iKCZjjXQQrSmcirOWO1j17mKuVWbiDgilbzwqDbSKbrRlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV8DM57G; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso4653424a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759160597; x=1759765397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPiBItbq+0cpdCmjLbGa83sTferT/K96z+KmXZmPzso=;
        b=CV8DM57GIrwk1bMIU/alsPOdRF9UWNvJSN+qbYc8hRjYiSJdK8EioGgwraMplKIaZg
         27R+F4tVEIXLtSJL09UwGmG1x3EIA0EbqMWBQ8LlycH1zIyNRaKH+Zlp9F6hKm6qaM1t
         S2iR49UpT8gloSzZqF48zdOn0Wpm3Y4U+1ldn0GgAtNZDzUrxPLxqno7wYRtSc9tTt3s
         RIGldMfnqQ+UJYvGMj5iJRvfowF5kVKgypdTQeb9MOvBjowxPYSfZ6rF+FmrQC5DC1GH
         +j5k11N73m/d13z4xxZLtJn2gDoQzl8s+QQcn9NfNvVtpHeCWKUa/Uw73iPRtu3771NB
         4teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160597; x=1759765397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPiBItbq+0cpdCmjLbGa83sTferT/K96z+KmXZmPzso=;
        b=XIzAI8xqfMonLdhLpvgbRld+bX/rBWO35n0W/lt9zkT11DbInnl7b2RZyb2mYgVYEC
         SmNmwxBu/V9gDQeFu/mFBGNLMBThEqKka5dn0CJUfbPeIlKM9HBTkZ7Y687zThwC5jfp
         4KBuRyhg6reHccdTLDQSU5pkrw/v1pdNDvxprmET+djBbqauhZTZyNYWQNQabes6/x4D
         dj34+azFQ6SNhIQVxdX+tHJ6qweel3wwsJsjky5bf7N91DE2HfuZE1DQXShVuv9/m9Zd
         GvGyAD2ubSGZnDzgo+DYTxslNEMLk6T8oTEZb2IjCgRhHDEZ85PjwQMzI3mjRG+uLpYh
         Yinw==
X-Forwarded-Encrypted: i=1; AJvYcCWwds1OhZ+wZXtt6sffHcRBYf5J9c5Zg3Ykn67SoYB284uSsxc4kNh8zlFHa4y/56NlRBF6qps6sN2R78E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJUhhJrbm7BpPdpj+zicfs8CBG/TQIumf/StBRZQXTI20Bqgn
	6l3P0S7HcFxUi4+rRD5rWGVviMM2KWQLc7gxpUrldh2T1zvUytm46B1a
X-Gm-Gg: ASbGncve5Xr+dKpRL7zHZDBeyHRQjeSwyy0/OHDZ8Mj/EXLTUpSDNwl+u+sqbX9x9J/
	Rf36lb3SIIYtPpbwXlEiwaN0xcxyo9jsA046S1MEv9RH2XcXOvMDgIFaGly7jJWu9vs2uhM1QKs
	ZzpmTKPE2MUcdoPs2jV7A2I7aHa3bvA7I64lA1dvFYV/RNgSEViG/ahZdCpe46bRdWh9de4fOvL
	TgdaRvVFUmcRU/O/bOZ57nbPUWubQOSdUrNE7DtdVWe2ULw8IUrPe0hsRghqGcYFHq1VVz9oHIW
	hAEqHfJxA0uk8Ls5whe91olCilSAkK8djBvTnpIkEiTAlw5v+c8t5apxEtBEwgJ6g07qrsLjpy8
	mqqx6Buv1ZQYgfM9YsO9/8PcYUHlfwlA73STaoy66AQhuJQSrnh0UbF2diSH1nKnmiKm+QyLl2g
	kcSUk=
X-Google-Smtp-Source: AGHT+IHnMsHOcovJMUJ6Qi4QLSkrybBhjKZgB1d/wSx8HcW6ykkQWUwWVtAywMlDiFpugHNyMA91Cw==
X-Received: by 2002:a17:903:2307:b0:26c:5c03:6781 with SMTP id d9443c01a7336-27ed49b8036mr191769995ad.11.1759160596670;
        Mon, 29 Sep 2025 08:43:16 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f3820sm132726145ad.33.2025.09.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:43:16 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Mon, 29 Sep 2025 21:13:08 +0530
Message-ID: <20250929154308.360315-1-kartikey406@gmail.com>
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
Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path

 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..71fa3faa1475 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
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

