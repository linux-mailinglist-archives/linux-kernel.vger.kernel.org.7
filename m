Return-Path: <linux-kernel+bounces-736884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C711CB0A49B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B6A16D9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA352DC329;
	Fri, 18 Jul 2025 12:57:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F72DCBEB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843454; cv=none; b=m+nh7Xr95Xbs3eZ/z4GIlOWHi0Hu9a9TQWr2ewACarBjdo2ZEHw/xtxV904cGKcM0jq7CpzXHcWFfMrOCFRgt1rJtj3VugXt4U5JHSL70uAkDHirFsaAOyQErcD5Sunh2EK0nsZX3DZYJGXYTlNgWnY/7+5XcwFDZ5uXofWpFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843454; c=relaxed/simple;
	bh=9QI9gQvGz2O+aUigmCxNyZWiqdHDygWWz2gSYH1jmZI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HeBW5S3X8RbJ7ekxKat5ILdlDVgGofw80B4rn63/YFkEgxh3cFhCcybvXHSfZ9N3Hq4LYR6J6ntdME6kKRbA5Fw9sHa3LSkjlJucTl9J9nxxjGSCKmedEnMquMIsB7RYgasoS5JYwM8uOi7ZPwCTko8UsnlRJ5nwfdBVJdd/hZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cff1087deso388121239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843452; x=1753448252;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IafqCpVzHsvptLgcHZRUUTrHcF1qc7C+r1Ulg9r4YvM=;
        b=j+fSzuPP1a+s6EV/biA9pV1a63reTeDCHyZV4irR9D1GJqVIK68odu86mHwdhcJt7T
         W2g8pZKBj5B+wpglWUNIPbc1tfyQuy2ewszfmHMrsIAKtDOi9A6cZzjp/RVj79ZoDBU+
         wcoMxJ/cK5jNGWqRlWhTK/7AkEuwbay72PUI6/8gXpyjhflfob0c5/vKq6/QcILYt2d9
         qzTHEE1yRQglweSVhX8rI+qjKk2iE+yDtSZDvkT5NWgrpAzcmR5mso0E6oYFJzHT11hY
         5XTWsKAKozL9eQOsKpxmP9R7NJqrGw9Q4NZTo4+fPpiqMe21Q+6t7dh6LA+Q+vcbwQ47
         AdxA==
X-Gm-Message-State: AOJu0YzLYUrJZwyR8050Q2F56UbwApHEzyXy4/nFcSN4gvdNkdpByqqy
	u8mFdDIRYdgZdghDSW0MVK/xe/VQHjJghqJkQg4MHuYGlN3KahD+m9jeQWgjrRf7AscO4q9QyQW
	YIztxWvTg6hl7K7yiIj609+f+Hoqzqlg0ErDmtBQjWffCdokxZE5Cjt7I2iU=
X-Google-Smtp-Source: AGHT+IHk3+82OUR+Aq3whAaUzx2H+NeNcJbWQiXuebr7PrPb4pwMLgudcKm69doo2Pn7w1ILye6ppKNlqScLScM+d0rWhQdcSmfi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15ca:b0:875:d450:9297 with SMTP id
 ca18e2360f4ac-879c2917a4bmr1191173839f.5.1752843452190; Fri, 18 Jul 2025
 05:57:32 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:57:32 -0700
In-Reply-To: <68794b99.a70a0220.693ce.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a44bc.a70a0220.693ce.0064.GAE@google.com>
Subject: Forwarded: Private message regarding: [syzbot] [fs?] KASAN:
 use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Private message regarding: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
Author: kapoorarnav43@gmail.com

#syz test 

From: Arnav Kapoor <kapoorarnav43@gmail.com>
Date: Fri, 18 Jul 2025 12:00:00 +0000
Subject: [PATCH] hpfs: fix use-after-free in hpfs_get_ea

Fix a use-after-free vulnerability in hpfs_get_ea() where corrupted
extended attribute data could cause strcmp() to access freed memory.

The issue occurs in the EA iteration loop where next_ea() can produce
invalid pointers due to insufficient validation of ea->namelen and
the calculated next EA position. This can lead to accessing memory
that has been freed or is outside valid boundaries.

Add proper bounds checking to ensure:
1. EA namelen is reasonable (< 256)
2. EA structure doesn't exceed the EA area bounds  
3. next_ea() result stays within valid EA boundaries

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 fs/hpfs/ea.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..7e6e43010fec 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -135,7 +135,31 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *si
  secno a;
  struct extended_attribute *ea;
  struct extended_attribute *ea_end = fnode_end_ea(fnode);
- for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+ for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea)) {
+ /* Validate EA structure bounds */
+ if ((char *)ea + sizeof(*ea) > (char *)ea_end) {
+ hpfs_error(s, "EA structure exceeds bounds");
+ return NULL;
+ }
+ 
+ /* Validate namelen to prevent overflow */
+ if (ea->namelen >= 256) {
+ hpfs_error(s, "EA namelen too large: %d", ea->namelen);
+ return NULL;
+ }
+ 
+ /* Ensure name field is within bounds */
+ if ((char *)ea + 5 + ea->namelen > (char *)ea_end) {
+ hpfs_error(s, "EA name field exceeds bounds");
+ return NULL;
+ }
+ 
+ /* Validate next_ea() result will be within bounds */
+ if (next_ea(ea) > ea_end) {
+ hpfs_error(s, "next EA exceeds bounds");
+ return NULL;
+ }
+ 
  if (!strcmp(ea->name, key)) {
  if (ea_indirect(ea))
  return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = 
ea_len(ea));
@@ -147,6 +171,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *si
  ret[ea_valuelen(ea)] = 0;
  return ret;
  }
+ }
  a = le32_to_cpu(fnode->ea_secno);
  len = le32_to_cpu(fnode->ea_size_l);
  ano = fnode_in_anode(fnode);


On Friday, 18 July 2025 at 18:10:08 UTC+5:30 syzbot wrote:

Hello, 

syzbot tried to test the proposed patch but the build/boot failed: 

failed to apply patch: 
checking file fs/hpfs/ea.c 
patch: **** malformed patch at line 36: if (ea_indirect(ea)) 




Tested on: 

commit: 6832a931 Merge tag 'net-6.16-rc7' of git://git.kernel... 
git tree: upstream 
kernel config: https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22 
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844 
compiler: 
patch: https://syzkaller.appspot.com/x/patch.diff?x=129db382580000 


