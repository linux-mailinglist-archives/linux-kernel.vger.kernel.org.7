Return-Path: <linux-kernel+bounces-842359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0DBB9933
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0DF4E51E2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218319ABDE;
	Sun,  5 Oct 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="Uh2GnAdM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92E3AC15
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680328; cv=none; b=Ntolh3wPEtjnOYc7n5gEJVsbq3jm0krzI1px1ABdLoDsn7F+z5dW4CfNX/yfa2ocQS1NyygIko9rQ4tF4AdPd8JJm1i534Mcs+X40EHKlqDZE8KPezQSLYv1D8BOYgsDO0zmCcKn4Qi3BMS/tB5ENz+0t7cQfE1qWZg8z9d3hcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680328; c=relaxed/simple;
	bh=XH2xXUswwjYui6iwKQscZaPoZe7ppMJZ6Sgoi/ykVGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gULQWSmBV4sD17aiV2HftCL4YecL9HNUL/KLUjseQT+uv3Y1FlUIaaEoeXrM1wX2YvZuTov6/tKIEdrI1RCV04nRnoe61hJVwR/dyOpwv5cFcgOc7AFsoPd36CRbIuMA+7K5kHIUDoaSmDiuItGHLkOw6gH9fVnIGPo4UNop/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=Uh2GnAdM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso4670151a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759680326; x=1760285126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Apb38vvwB4yx6ZuSTdH5FloXnDPkndq4ehFPRMxQ1PA=;
        b=Uh2GnAdMcaTbe+soMKte6d95AXFQ7QWCCKO9kIa0vbJ4NeasA9SmfgaH+xPkwefy31
         m9+CX9w7ms3rlYktz6SvAEbZH4nvME1fd3P++YF+rUssIetHQ1DBk9SjzybLUuZGyQ2Z
         VlTRNZVBi6/cn6obbIIvG4sN+HAkQ0BA/wr4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759680326; x=1760285126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apb38vvwB4yx6ZuSTdH5FloXnDPkndq4ehFPRMxQ1PA=;
        b=KSg4iR8agF3SpzyFRmRYBU5XtXlIgS8oF5SYli98RN2ELAwgZPLnp03acd5tixEhcR
         jfKUgAx6PDojc1rgSRmP2ukfHDV4KacOAMTfT93x+M6NWbsyKCrFZLyfN0vvj38Nnt9x
         CzYDh0rye1qS2Xd/Qo7Gk/Rr1Z/fJ2tgOGgKTu0fS5fiipksxhZOGGyGBQDhV2f6xbfs
         gITZcU+Sw1fNaDZHJrYbPGH+7fI3+wHfQ/9GrcU0D7Jzhj4XSj+J9SEsWa1692EXZKey
         aSsFj+qVo9w8j9PKOGmf1rt8fXkF8K+RmT/sSMsqhnVuWGTFWi5ttzs6LKipnl6B5NvG
         KnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp9i0AXeoDqGh1GSvt1TE3H5G1/Gp2V57HYPTRWnaTe9A5396V9D/bUj0JHGd8Gs3Ao+incUhY3tx4JYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziteK8ktE4bXhYX18gCQWBm/ZJzPZWksbEus8hrqf1FZ4rIW2s
	0AzaPH2Ykv86EUJEMjsJNH5raOm6DQ5MV61nm82NsCbNpvUsJrFd4sqXRNzF5gQl09g=
X-Gm-Gg: ASbGncvekHL7MZtHsWuEFD64PznbUMZO6UIjTcYYcsqxScLsAM9Wr65VvuY/WCfL69O
	DBNgLf1p9RHbX3Hk/lsL1YKdu8c8CnezrkKJjSQvh00e7/hEDEIg6tWXidTmurEF7UQgMY+VKPG
	mgWzV/3Ln9d8/eU0JIPT4fg5Qunbbp+oAS7L9WcpRlBQ8JTBjmSAs39UGXzVuNK0q92LwnFMqnP
	c6dtOKkSLCSw0wN5tXRpkz2pSc/cgx3+CWUADd6QeSOn1z540/ruIR+KzTCLoEEHLvkS7GF2tXy
	zL5vHBBM3MueIPIMWCooi8FHRXaHbhtwK4O5TjNZAm0uRjuYlU58mW1FZ2OBM88JJmq/h0L0v+s
	cOk7ihUFDtLYAbCuAwJiVWl+wozJBPSkf7VRHZA+1oop+Xt3KC+P/0GKe5rCwqWGBBxsgjd8gg7
	J9faWeoULrEZNLHBQ9kf6W10+VA90=
X-Google-Smtp-Source: AGHT+IFtAPsMcbWTsTzzk6FNbUS5ZUy5nzJQgGNyx0ZUq06fFmSWxW/ID+JTwnNDcwgVq0RlGrbwyA==
X-Received: by 2002:a17:90b:1d8d:b0:32e:37af:b012 with SMTP id 98e67ed59e1d1-339c264d739mr12476273a91.0.1759680325632;
        Sun, 05 Oct 2025 09:05:25 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:767d:6919:46bb:bc81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm13903271a91.11.2025.10.05.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 09:05:25 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Subject: [PATCH] bcachefs:fix use-after-free in __bch2_bkey_fsck_err
Date: Sun,  5 Oct 2025 21:35:18 +0530
Message-Id: <20251005160518.10000-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

When mounting a corrupted bcachefs filesystem, KASAN detects a
use-after-free in the error reporting path. This occurs due to a race
between error reporting and key deletion during fsck.

The sequence of events:

1. extent_ptr_validate() detects an invalid extent pointer with a
   corrupt disk offset
2. It calls __bch2_bkey_fsck_err() to report the error
3. The fsck logic decides to delete the corrupt key
4. Meanwhile, __bch2_bkey_fsck_err() calls bch2_bkey_val_to_text()
5. This traverses the extent entries via bch2_extent_ptr_to_text()
6. sector_to_bucket_and_offset() is called with the corrupt offset
7. Memory access occurs on data being concurrently freed

The crash happens in bch2_extent_ptr_to_text() when it attempts to
validate bucket boundaries using already-freed extent pointer data.

Replace bch2_bkey_val_to_text() with bch2_bpos_to_text() to print
only the key position (inode, offset, snapshot) instead of traversing
potentially corrupt or freed extent metadata. The position is part of
the key header and remains safe to read even as the extent data is
being freed. The specific validation error is still printed in the
subsequent lines, providing sufficient context for debugging.

Tested successfully locally using syzbot provided reproducer

Reported-by: syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=564efbe31172fe908429
Fixes: d97de0d017cd ("bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/bcachefs/error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
index 267e73d9d7e6..b0bf08915aa2 100644
--- a/fs/bcachefs/error.c
+++ b/fs/bcachefs/error.c
@@ -688,7 +688,7 @@ int __bch2_bkey_fsck_err(struct bch_fs *c,
 	bch2_btree_id_to_text(&buf, from.btree);
 	prt_printf(&buf, " level=%u: ", from.level);
 
-	bch2_bkey_val_to_text(&buf, c, k);
+	bch2_bpos_to_text(&buf, k.k->p);
 	prt_newline(&buf);
 
 	va_list args;
-- 
2.34.1


