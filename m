Return-Path: <linux-kernel+bounces-835289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D98BA6A4B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83A3189B67B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CA529B778;
	Sun, 28 Sep 2025 07:45:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0B287246
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045522; cv=none; b=KrKKb6kHI0NCIIEtNSis1QNiYQYbsRL7vqtm6mvEGERehYEVRLFOFHt4RVn4KFuABUQrNF0K7VSzMAEqdfFNWBxr9SM7jny5IwzxxKoSCgU93jtzZQhqiNcucgULmUj5jFue6qWtCdHD8jftxX2sCfpp3muZlZBSU4s1taPGKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045522; c=relaxed/simple;
	bh=KJEzRsPxikD7PxoKw9oEo3K4tbCsWunyVucHHuKPPkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sE69eNICUkEsHt1qQk4EpANVV2H9DuHQ/nsxLogG/8hFntVaGFu0MoVuNpasZba3dfJseRZehAsXXp9GF4HL7r8bnxw6xBdqtyg7JYragBN0aY2nmzLcr4AbkOoxz3b8AlAGiajjtUMZPepIcnsLoXe7nSLUa1SHyCENffjRxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-429aa22e058so6407695ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759045520; x=1759650320;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNi3FFZaAT+Ikxrn30Lck+PnNCFGbNWVgbaTZtRCBi0=;
        b=bkFS1LRnQocRlifcUKzT7mhchC5EvkylEOj9n5J5SP2zHmiQMTUSYM6SugnpVZvwai
         S8caIrsE2om/ly6j6LBADOmbqsWPfwW1DTB+3uIpiArulqdSZKbs9/rMKIMRHd0QI3u3
         S2l9nRBoZYoQMo7V25+N2vHoY836sJ8uso1hbmsmF8sEfQyHRaBiO+9W6ZePRv9KGTDP
         SF26zZLnBrDbkiemkQafxwYktaala6neWmk9jLQjudQpgafV8ov0zwJ90wUvhljT8UVD
         lxsRsb2f8jhYMvBGrziKvHBVdkSwGhdkmkOItBwUj6fKIzbF/L+WG6GIu3IpJytLMW94
         DtXw==
X-Gm-Message-State: AOJu0Yzfc1+ydnHdoYWKOQ6fQObEOYfdwulpTGeBMk07ySnCADnX3QXw
	HmurKvTxQPMdcVOgCGMX8LlWv8baZ4ocn1Zmbk7Sos9yscSpxiRLEto3bWqtr+dKYN/IdjTOQpu
	GokhLiVdrft2je8cyh8iUcgdH7LlFGkMZxWq7RRrvON1vnFULuWHzMrp9ntA=
X-Google-Smtp-Source: AGHT+IFOf8Aj12se7xvvsB4wchITsyVR0RruzPu5UE6HksNNbOVeIMjgK+byR3PhMbZlHDcs6jtRLdrtl/wcmBmcJLi7uQ5Fk+ZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b704:0:b0:420:f97:7446 with SMTP id
 e9e14a558f8ab-4259567c94emr140167275ab.22.1759045519974; Sun, 28 Sep 2025
 00:45:19 -0700 (PDT)
Date: Sun, 28 Sep 2025 00:45:19 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8e78f.050a0220.25d7ab.04c8.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: Fix extent boundary validation in extent tree
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: Fix extent boundary validation in extent tree
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


This patch addresses a vulnerability in EXT4 extent tree validation
where logically impossible extent entries could be created. The fix
prevents extent entries with an end block less than the start block.

Key changes:
- Add boundary checks to validate extent entries
- Prevent creation of extents with invalid block ranges
- Improve extent tree integrity checks

The bug was discovered via syzkaller, which generated a test case
exposing this boundary condition vulnerability during filesystem
metadata parsing.

Fixes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..987a07a8554e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -418,6 +418,10 @@ static int ext4_valid_extent_entries(struct inode *inode,
 
 			/* Check for overlapping extents */
 			lblock = le32_to_cpu(ext->ee_block);
+			ext4_lblk_t len = ext4_ext_get_actual_len(ext);
+			ext4_lblk_t end = lblock + len - 1;
+			if (end < lblock)
+				return 0;
 			if (lblock < cur) {
 				*pblk = ext4_ext_pblock(ext);
 				return 0;
-- 
2.43.0


