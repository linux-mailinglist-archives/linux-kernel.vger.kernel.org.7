Return-Path: <linux-kernel+bounces-835342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF173BA6CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4386F1895082
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E32D24BB;
	Sun, 28 Sep 2025 09:11:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D742C0F63
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050708; cv=none; b=masBxyZaqpQDNOVSA8gA2FYmBPNspaLXucNSF8hCHnsvgqRweBHJ3I5ze+b6F3eysmR4WDPWsgAshHYitZcpV3vwqWcNsPm+o8AMVysJAJhtZS2eZf7rwvP6Rr8NgbJq/nSXXoRWUlu4t2GBoYepGG0E/6Ge0qxv/QWJ0nJbmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050708; c=relaxed/simple;
	bh=6B+luOQSjYf1AJsM/Q6K77B56UsB827rEs4sgFU8rS8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ogNqxlntila2GuEXKhF4TYVAP1kOWkpTDNHYnjTw17a/NgIGLsw3dng0C4ZkEjp3GKb0ELgZRlWK3upbiCDr6G8pfiGvYAsgWTYyJd+W/FZo/D0wsjT1S7Exr0E015achK0h33In39z6J4y6hQIqMNP604vECaKY81CV2Mi/Auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257ae42790so55588385ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759050706; x=1759655506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/PO4xGhJUkTcxJFqnPlSTZklfyrrbwTptLy31ouXI=;
        b=BTPT4x3LMU0T6rCWzSTT2LXh0rSZnsUWOJS6b0rQlaWesbHGgijs36l8g4VodCgDOY
         vq4MLF2rLkQlUnwvDSt4sMSC7yGkpxAuTRqnynthZPDG4tUOmCEcZXpzIlZtYfyByiCm
         35kBmqL+P0mAwH9XgOd45XNcCKk5UudF6ChD97S+7ccpwW8r0MOZF7Vb53R14sNXdP6Y
         z6qvKbXRebglLM+mv47p5m5pEsdkFiuPfV61qZntleVxmuxMjRLzMf2n1eV734dwG5l+
         D8lzfxvHfkuxQGhLO7/vl53l6SJzIQu61rSvlqKu0iykam93gENUwm/CUfpMek0yLIYe
         41eQ==
X-Gm-Message-State: AOJu0Yw9Lq0wtaXYgvmgY8N8EIftmJUDZ+QExAvAvpGUPhCmp1XR5Ay/
	/EFCvA0UuHENE9p4QxnYrmZ6KyxH6Y2dWUSJfXEzkmMfsDBD5yXpUBz4iiCYDY4Gphua4mokuLW
	k6z2MGB0lc3SBpoFbsMF2Wcf6iHBp05FvUvzoK/Sx0FT0d9wX5+gZA+tY9lc=
X-Google-Smtp-Source: AGHT+IFNUxeW7QNdBpSnShf79LLSdM0ZjM6TRyKzcn0qmoxMxz8EkiLSSLKvtYiFlEDREMOBfxwnaoQ9VKPQsRcdmIAJARNLor0w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194a:b0:428:306a:175d with SMTP id
 e9e14a558f8ab-428306a1868mr91608415ab.28.1759050705675; Sun, 28 Sep 2025
 02:11:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:11:45 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8fbd1.a00a0220.102ee.0027.GAE@google.com>
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


