Return-Path: <linux-kernel+bounces-860121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2503BEF582
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AE23BD3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469B2BE638;
	Mon, 20 Oct 2025 05:07:16 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87322AD3C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936836; cv=none; b=UsrxIAAsEUyJCwzcw1Qt+pCIuWQAKfBaKQcp5oGOw3V6LkyNFe9s7F6zHR5cc1Y0yNDPbU5godHRtUmiErFd2qK+C0O6CQIrXZulxGZ6d/d/B0CxstdP0dcJpTm5Swn8kbfaDFfaximdtZg5I7w5JawfDZld0QGqzvsqS+ZdbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936836; c=relaxed/simple;
	bh=zUB2g3AECxnAOw7faHNNWjkv2Y53JovcHFQ/3tBfPGY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GgptNjx42hsyX3Ku8f9RKoQMxJLk8Y+y8uu+2AzomME4qZVzo3o3GXP74d6lyGMaJV6IdlyMsBMOQ3gTcqP0RwvDjl1lni9+IvBp8nEW0SNFO+NFxyK3HVUCCNpQFMviMyY9DNNvGR+5Hn+f/Iw9yKze/gM8VoP8NCZ5FFOWNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e809242d0so635469739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760936834; x=1761541634;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svOFUgSkKPzmpuo6vMNkhQsklUncgAj20xgi8iPCxMM=;
        b=kHBbWJrE9INAxYAzpWEgfmKSpDD+3y4pRVu0oU27BSvq9chEOgKvHDq3lHb8UUYlsc
         R9oPFwokA8IWv1dFeMrik9A1OIKbiSbsqQhwJkFZMTiio+H8Ij/QuSYR2rDfhstyMVF1
         qRBTU3STMcMoBW7xhhVrUl7c+PoeWb0wh3+zaQ1Nf4+S61jsTuTUw/DTjxV8x30p56c2
         az9/eqMzG5MlNXI/sw6dJi2ewuLz0vuOSpuvD2DRKFqKoruM2g3j5Xt64a0sJpaxf1nD
         IEOmjaMoxGoMJy0VAhOKcx9uN1aip6MpnzTBzcuQs1HAiw8Q2JeY6CPh3ER7EganIshW
         JFgA==
X-Gm-Message-State: AOJu0YxX6vaaY0qqoN2Ez7GsPybwz78xf8mQdmPhjmh47KUNpyvwkFPo
	fGiDQZUFXE1Fuf8/7k3vfnVARtjSBOWQ2iwuQcnvOX6Z7t8N3PRb6ffp2piMZkHcifKMgYwWGqU
	1sxHLjJs0m08JLWHkJdsUyQFi+EIT4McCp2lh9BT5PAKIDVGgr3+4WiioWLk=
X-Google-Smtp-Source: AGHT+IGw4dL0S9HgZTeKPlWuXRLhamlodke0q1EpHDRg+GMmcNWRUanrmB9pRoLxA+a8mfEKDN5OWc20m5RFlbGMU5lsqcedARDx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd1:b0:940:da3b:6acb with SMTP id
 ca18e2360f4ac-940da3b7640mr309253939f.18.1760936833963; Sun, 19 Oct 2025
 22:07:13 -0700 (PDT)
Date: Sun, 19 Oct 2025 22:07:13 -0700
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5c381.a70a0220.205af.0026.GAE@google.com>
Subject: Forwarded: [PATCH v2] ext4: refresh inline data size before write operations
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] ext4: refresh inline data size before write operations
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The cached ei->i_inline_size can become stale between the initial size
check and when ext4_update_inline_data()/ext4_create_inline_data() use
it. Although ext4_get_max_inline_size() reads the correct value at the
time of the check, concurrent xattr operations can modify i_inline_size
before ext4_write_lock_xattr() is acquired.

This causes ext4_update_inline_data() and ext4_create_inline_data() to
work with stale capacity values, leading to a BUG_ON() crash in
ext4_write_inline_data():

  kernel BUG at fs/ext4/inline.c:1331!
  BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

The race window:
1. ext4_get_max_inline_size() reads i_inline_size = 60 (correct)
2. Size check passes for 50-byte write
3. [Another thread adds xattr, i_inline_size changes to 40]
4. ext4_write_lock_xattr() acquires lock
5. ext4_update_inline_data() uses stale i_inline_size = 60
6. Attempts to write 50 bytes but only 40 bytes actually available
7. BUG_ON() triggers

Fix this by recalculating i_inline_size via ext4_find_inline_data_nolock()
immediately after acquiring xattr_sem. This ensures ext4_update_inline_data()
and ext4_create_inline_data() work with current values that are protected
from concurrent modifications.

This is similar to commit a54c4613dac1 ("ext4: fix race writing to an
inline_data file while its xattrs are changing") which fixed i_inline_off
staleness. This patch addresses the related i_inline_size staleness issue.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Cc: stable@kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Simplified to single-line fix (refresh i_inline_size after taking lock)
- The refresh protects ext4_update_inline_data()/ext4_create_inline_data()
  from using stale i_inline_size that may have changed between the initial
  size check and lock acquisition
- Follows same pattern as commit a54c4613dac1 for consistency
---
 fs/ext4/inline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..b48c7dbe76a2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -418,7 +418,12 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 		return -ENOSPC;
 
 	ext4_write_lock_xattr(inode, &no_expand);
-
+	/*
+	 * ei->i_inline_size may have changed since the initial check
+	 * if other xattrs were added. Recalculate to ensure
+	 * ext4_update_inline_data() validates against current capacity.
+	 */
+	(void) ext4_find_inline_data_nolock(inode);
 	if (ei->i_inline_off)
 		ret = ext4_update_inline_data(handle, inode, len);
 	else
-- 
2.43.0


