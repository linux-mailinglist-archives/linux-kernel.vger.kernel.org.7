Return-Path: <linux-kernel+bounces-823869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C4B879CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C27E336C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7C1A3178;
	Fri, 19 Sep 2025 01:32:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F161E3775
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245545; cv=none; b=A5RARjrSxLQaU9FOVpIF/xPej1NrU02H1C1faI2jVs34yQ3JiHteUSg7uLmqu2rGt0t8KKD44CU7OicaFEfKUUngv/dcMGur9xI07dKwn7kStOxtoFIhDPWgYrIAOy4LofwLKweB/tZfpX6SgLf8ll1Lek+ITMCryAx+9T4tBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245545; c=relaxed/simple;
	bh=2aapVmtSEfOLZnTAU7b4JkgqnwTlmx+LgqIwDDWYnNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h8IfrmWT5o4xc2zx68HzbCt20OKAHHmfjwa8CUdCOeWXNsmcXPt6WQfOWSoV+cjkKIVVhe9EyK0EZEcVEkL0IMIbYk0BF2c60vtgBUACsM1xkC7F2aL7LHarcCjznpHF4kX7XPvXwtV/catLEBwaDpc7mP0+iN3AZs4m6U4encc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-423feb240a7so29061655ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245543; x=1758850343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wlppjYj41aw5CCRRweDouXR+nOxAm3G+RjJsE05E1g=;
        b=UhFIg096V7frDooUXsPX9P0FN3zENMbsUipyYmceVYHgmTuIEG0L1SB1sUaJINfDUA
         iwiVciGuGIkxiDD5OCghtTN3iQjT6pLTATkqmA42dZRUV+EZlDRtHwXQFjSeYfwH9Zr4
         u6u6m7cQ3j/hueErFGRp1FEDhcgs6IMjEjqxeJdHnZaPsMo9PbSuCBrtZIuQwiEbaWBq
         6FVbFiBpNjRx2EY14BEvleFbaSF+btjKso4RIS6XUhlYtNE9Zy0buIo9akxomS5ahMrD
         crSjJaMun7OfYO/RIOWEOtz4CnUAm935QDC/jr50G2C067RxxSLnD5tvuPtcC9X6rxo+
         KsgQ==
X-Gm-Message-State: AOJu0YzESIvoQCvZ3ONsG8DIYMKz0PMFQyIq8O8OsZP5GzgWIq6ibH6j
	vFKuew9YuENY9Ir1wBNoS4bBAcr2VZaRytzRLR+rHFezNA1nxPi/UzAANKE1Lx6UcYN8WVTHT82
	Xgg/0AZCoA5PNETyFEJfvwBAmmQEPAIdbZHgdViACSL0ds0z8H00Sflkjq0M=
X-Google-Smtp-Source: AGHT+IHC494ZMpiXthrk7hq8NH2Mk1TpNe/tg/sFp46go/soE8k/LCFwk/YybLZRJMIU49xIhIY8j2yVbJOp+1Hj0x0467Df/5Ny
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:424:1e7f:7068 with SMTP id
 e9e14a558f8ab-4248197c3e9mr24727975ab.22.1758245543061; Thu, 18 Sep 2025
 18:32:23 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:32:23 -0700
In-Reply-To: <68c7c2b3.050a0220.3c6139.0d0d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb2a7.050a0220.28a605.0015.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		gfp_t flags = GFP_NOFS;
+		if (!(current->flags & PF_MEMALLOC))
+			flags |= __GFP_NOFAIL;
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
-- 
2.43.0


