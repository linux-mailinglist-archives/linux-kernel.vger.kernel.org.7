Return-Path: <linux-kernel+bounces-835343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4EBA6CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E7E18950A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA142D29A9;
	Sun, 28 Sep 2025 09:11:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA22C21D0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050708; cv=none; b=CbkNO9mkykd32p6mOA5gH2uFvATEvUlpGZ3W65lzYt3Pf4lcVRQndKmguUmBP/HY0jJH8P+cjfLggRGOJMKxdG1r66TEWNDZcJMk3C2RTbl8vRNVkG0sHq/ehZ8k2PFi/opIYmS8ynRqOs1HGbV1meRSo96rILf6Sd0GLP70QsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050708; c=relaxed/simple;
	bh=6B+luOQSjYf1AJsM/Q6K77B56UsB827rEs4sgFU8rS8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eH0fx9FeDA+0rQzFGP6wZX3185JLnQjonOCeDJcZIrdJ1Lm8l4HRk531LJbay/ntXDMsATTsdGh3F1/kKSfhdNatJMxr75G+4qItkDrVH8I/n/NilsPw3lvcA4nCxCt8tTbgk8phVoKB58EghBNocDzEdwjhizcYLpLrfy6E+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42955823202so8956365ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759050706; x=1759655506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/PO4xGhJUkTcxJFqnPlSTZklfyrrbwTptLy31ouXI=;
        b=XW3Nryh3/EsVG4cUGZkQK6cfLlgZgwYTLCjmYH6pjVxCgp+J8LN6zflifk5Eror90w
         skLgQOo5BdLJsaIF02A9zJ3MVohKxq5F23ND+0/ALL+lWmGa9I6oVE/xbxH8tGWwvgEz
         R8GBwhjZ2SRyF8OvW8oaUDvH1cY7Vm7g8EhXNXUdLa0HSdk3CDFP2O4fZCYG6v5vGbMB
         vDwKoq3JQBuRO38iSOXTlk3OlalMMtYW8V3h1PTSLUot1RIUuteu6ajcw8KVhZEwHmh6
         cg/qSJorIy1VdVJWE4AwFM40Q0RaeZQyclFUqCKB4Jf2w0KFMjThJ81OIoOJOzAJp+XG
         hd/Q==
X-Gm-Message-State: AOJu0YzQ44nRnndrZMUf4Go44WrnBjFfHEP8KlytKt5SiMD/PbH5mZoM
	sCW2rgVTWCiF6y87Ekt9hQLOLc8uREqDfAfGiN1Gttw7TKOq5D055pqEekQrDwnE6hraOz26DEF
	7/xwbWikYS5CeqMIv7lGaicdv9KkA/fLTxHH6LryhAHXwYSf0ZfP90cjFruE=
X-Google-Smtp-Source: AGHT+IFsohpehbqOZV04fjGhHEVCRATG/RCtw7XGHbuvMgjxnb1hEAksoK4W8wygZ2lapJ2+OczqpxEb7qDMB39PK0/MyRSvbO3S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-425bdaf0355mr174449325ab.0.1759050705940; Sun, 28 Sep 2025
 02:11:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:11:45 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8fbd1.a00a0220.102ee.0028.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix BUG_ON in ext4_es_cache_extent due to
 out-of-order extents
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: fix BUG_ON in ext4_es_cache_extent due to out-of-order extents
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


syzbot reported a BUG_ON in ext4_es_cache_extent() triggered when
opening a verity file on a corrupted ext4 filesystem mounted without
a journal.

The issue occurs when the extent tree contains out-of-order extents,
which can happen in a corrupted filesystem. In ext4_cache_extents(),
when processing an extent that has a lower logical block number than
the previous extent's end, the calculation of the hole size underflows:

  If prev = 4352 and lblk = 1280:
  lblk - prev = 1280 - 4352 = -3072 (as signed)
  = 4294964224 (as unsigned)

This underflowed value is passed as 'len' to ext4_es_cache_extent(),
where the end block calculation overflows:

  end = lblk + len - 1 = 4352 + 4294964224 - 1 = 1279

Then the BUG_ON(end < lblk) triggers because 1279 < 4352.

Fix this by adding a check in ext4_cache_extents() to ensure extents
are properly ordered before attempting to cache holes. If out-of-order
extents are detected, report the filesystem corruption and return.

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Fixes: a86c6181109a ("ext4: cache extent hole in extent status tree for ext4_da_map_blocks()")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
---
 fs/ext4/extents.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..2e630b500a31 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -535,10 +535,17 @@ static void ext4_cache_extents(struct inode *inode,
 		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
 		int len = ext4_ext_get_actual_len(ex);
 
-		if (prev && (prev != lblk))
-			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
-					     EXTENT_STATUS_HOLE);
-
+		if (prev && (prev != lblk)) {
+			if (lblk > prev) {
+				ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
+				     EXTENT_STATUS_HOLE);
+			} else {
+				/* Extents out of order - corrupted? */
+				EXT4_ERROR_INODE(inode, "corrupted extent tree: lblk %u < prev %u",
+					 lblk, prev);
+				return;
+			}
+		}
 		if (ext4_ext_is_unwritten(ex))
 			status = EXTENT_STATUS_UNWRITTEN;
 		ext4_es_cache_extent(inode, lblk, len,
-- 
2.43.0


