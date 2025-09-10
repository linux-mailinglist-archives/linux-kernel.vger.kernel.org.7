Return-Path: <linux-kernel+bounces-810488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78912B51B54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3661899D42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0022571B8;
	Wed, 10 Sep 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxGzkRd4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658751F4289
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517438; cv=none; b=WGiEC+na4hqSC4ejztkj8yiaqHFwXqN8VSS/fDAA95qZRo/sww+jMnTyFWMflj6+UdDaWkhK/azO1xVoMd6r4QqxUMBm3RNJlRusnMj+mHRDMRYvx0glHi/gmyBQMmlTwSZVKbWLbbiWpGts8bG1NYL1fOJ92BJAKifsb8FzzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517438; c=relaxed/simple;
	bh=j58Ug4xAazb5e4BSWh0QoB9IC+jg9pk4B5u7PD4jvkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2/kpeUV0n7H1tFUmcpMG/01uUdjHPWVY01RYZdl4tNGA0wCJbX6+or7YiR857tR1+sBgbXcwvxn/v4y6bx7ubVs1omJ8YGN25Yxy3X1XzHbACdpjEblVKiEbIlAiF+KV1Bzv0n+2n5/1OhPusmbYVHdGov5fw4+H4p3RdOOb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxGzkRd4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445826fd9dso82745125ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757517434; x=1758122234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOQkYwriVDSKMxqkuzjKeOZZnOVXvsFhF9wM7M7C4ek=;
        b=QxGzkRd4OMKkmO+urPITJIrwZ4k9gcNgyPmEZ6CAvCZ++xMlh5Qvo8gkX0U2VX6OT3
         +zL10Sq0vdKxPKdyU2Cwz+iGoWLC1OylofjodH4vemplFywRhMkiAfTQplL8eLjNQhss
         8AYg7qec6+g2mte/3X6GKWc00UyHaIK6sbSr+dZEq3ElAjEcEik/M7JKPjfemftc4nMP
         eguadWZ+2+vnUwYm22TWTxc8hJqW8TmPbs+4RVo8+o9rQklLGGYQtiOHGTl/te8AwAOk
         d3ZMXZC9u+KFII4Q3GKSmrJnmfRHXsZQVF0Ae0gLdga4kmR2so0ZLyNrpDM1CEEcxP5Z
         3+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517434; x=1758122234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOQkYwriVDSKMxqkuzjKeOZZnOVXvsFhF9wM7M7C4ek=;
        b=UKdc1LYBGtRTHeckDKXIhjBMcf3Z2+TitPpLhXKPFDfzMCDbzlsJBlteoC19S4o0LF
         ZqcVPhAHWDY6L+eoPxi7g9jhVOdhV+QPIKYSrFd04CP8vqDjMhBkePbiQcZY8gX6N9pW
         SEkLnn+gESPf/tJW+9820wEv4HqDd/8k0P/guRmTIsoyHxKV654N6st+r7hO4w5/0b6M
         7AxJJMeqZdkxcXgYD4taJPLb5q72PYGSj2vQ5jlBerduVxAST6lY1DnVv8VNLltpoRgh
         uZg2XQfm1NfMjjE80z1hwoia0BpaLuqvewF+gnao7f+3AVyS9sttmxPmgkob2/BiFQcA
         fmXw==
X-Forwarded-Encrypted: i=1; AJvYcCXd0191ae03YrJazOT4mik+H+P/mtNkWdivM0gZmsk+OQBnYgb7c8Dh5E4aAu/8sIvKsmZ0qbdmc5vALzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOfGwpe81NdoCqcsgeBjl6QVLdV07yBhIdYMNdisvYEWvI1Q+
	85NhMJNSm4xlnbwJQAkx/sRsKgAV/zcabM6aVXs10DnzPH9lGzVO2hxJ+hQMZ/5EdqU=
X-Gm-Gg: ASbGncseyC4Ff12evXNe26LGqsgz3DlYyE+jb9X+V/6M7CR19p5b9/e3LernHkoGavj
	eiqvqrqLx9zoOxa/cseu8q83bV5O9gVkI/fH8ukD4MOD+Rcj3umfKIdff49kUBTBb5bRB+GBKJp
	MIetOYMBO45hpofTOUMQ2u8CMdcq2923lPs2fGb3JI9NCaS4+vm6XGFuAiQct6/5e/agIqGgeOF
	pguUJ5pqXx/uvJ5eARSd/7V1QQPAj6G1X6BXYt+on53fmeCZOGPoCpiloaU7S7KVj4vcCCgcj7F
	jPqUI5eIbCKxIuWObGbyeAlGThpqryLfMeLr6VEo9ZFTZx3sktvOdN9LbC9kIlTcmlS0YNIVkjw
	N+ClbyNZoaMLeyuEZtLeZbJ+LrO6ItDWh66W4HsZ1+61XdOmvwzaPQg==
X-Google-Smtp-Source: AGHT+IEwRx8/O/DEAP8DJpiN/GPPSAmWaGA6Oc5zIGvkeOWwhsN6U5j/+KWlpC0rHUTO7NUIPnzWiw==
X-Received: by 2002:a17:903:1c2:b0:249:1213:6725 with SMTP id d9443c01a7336-251753d88d0mr219820145ad.50.1757517434355;
        Wed, 10 Sep 2025 08:17:14 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2ab0f924sm29795595ad.115.2025.09.10.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:17:13 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	YangWen <anmuxixixi@gmail.com>,
	syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com
Subject: [PATCH] ntfs3: fix use-after-free of sbi->options in cmp_fnames
Date: Wed, 10 Sep 2025 23:17:08 +0800
Message-ID: <20250910151708.28810-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BUG: KASAN: slab-use-after-free in cmp_fnames+0x292/0x2a0 fs/ntfs3/index.c:50
Read of size 2 at addr ffff88801f6da2dc by task syz.7.385/9323

CPU: 0 UID: 0 PID: 9323 Comm: syz.7.385 Tainted: G        W           6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT_{RT,(full)}
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 cmp_fnames+0x292/0x2a0 fs/ntfs3/index.c:50
 hdr_find_e+0x3c6/0x630 fs/ntfs3/index.c:762
 indx_find+0x516/0xba0 fs/ntfs3/index.c:1186
 dir_search_u+0x15f/0x2c0 fs/ntfs3/dir.c:254
 ntfs_lookup+0xfb/0x1f0 fs/ntfs3/namei.c:85
 lookup_one_qstr_excl+0x12e/0x360 fs/namei.c:1697
 filename_create+0x224/0x3c0 fs/namei.c:4140
 do_mknodat+0x184/0x4d0 fs/namei.c:4272
 __do_sys_mknodat fs/namei.c:4313 [inline]
 __se_sys_mknodat fs/namei.c:4310 [inline]
 __x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4310
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f763f38ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f763d5d5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 00007f763f5b6090 RCX: 00007f763f38ebe9
RDX: 00000000000021c0 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f763f411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f763f5b6128 R14: 00007f763f5b6090 R15: 00007ffca1693878
 </TASK>

Allocated by task 9322:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x1a8/0x320 mm/slub.c:4396
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __ntfs_init_fs_context fs/ntfs3/super.c:1761 [inline]
 ntfs_init_fs_context+0x54/0x4c0 fs/ntfs3/super.c:1806
 alloc_fs_context+0x659/0x7e0 fs/fs_context.c:318
 do_remount fs/namespace.c:3299 [inline]
 path_mount+0xc25/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9322:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x195/0x550 mm/slub.c:4879
 put_fs_context+0x123/0x790 fs/fs_context.c:524
 do_remount fs/namespace.c:3326 [inline]
 path_mount+0xe57/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.:qc:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is that sbi->options points directly to fc->fs_private.
If fc->fs_private is freed while sbi still exists, sbi->options becomes
a dangling pointer.

This patch ensures that sbi->options is a separate copy of fc->fs_private
and duplicates nls_name if present. On superblock release or error,
sbi->options->nls_name and sbi->options are freed and sbi->options
is set to NULL to avoid any dangling pointer.

Reported-by: syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com
Signed-off-by: YangWen <anmuxixixi@gmail.com>
---
 fs/ntfs3/super.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ddff94c091b8..6f4aab96e999 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -697,6 +697,14 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	if (sbi->options) {
+		unload_nls(sbi->options->nls);
+		kfree(sbi->options->nls);
+		kfree(sbi->options);
+		sbi->options = NULL;
+	}
+
 	ntfs3_put_sbi(sbi);
 }
 
@@ -1198,7 +1206,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
-	struct ntfs_mount_options *options;
+	struct ntfs_mount_options *fc_opts;
+	struct ntfs_mount_options *options = NULL;
 	struct inode *inode;
 	struct ntfs_inode *ni;
 	size_t i, tt, bad_len, bad_frags;
@@ -1215,21 +1224,36 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.high = 0;
 
 	sbi->sb = sb;
-	sbi->options = options = fc->fs_private;
-	fc->fs_private = NULL;
+	fc_opts = fc->fs_private;
+	if (!fc_opts) {
+		errorf(fc, "missing mount options");
+		return -EINVAL;
+	}
+	options = kmemdup(fc_opts, sizeof(*fc_opts), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	if (fc_opts->nls_name) {
+		options->nls_name = kstrdup(fc_opts->nls_name, GFP_KERNEL);
+		if (!options->nls_name) {
+			kfree(options);
+			return -ENOMEM;
+		}
+	}
+	sbi->options = options;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	if (options->nocase)
+	if (sbi->options->nocase)
 		set_default_d_op(sb, &ntfs_dentry_ops);
 
-	options->nls = ntfs_load_nls(options->nls_name);
-	if (IS_ERR(options->nls)) {
-		options->nls = NULL;
-		errorf(fc, "Cannot load nls %s", options->nls_name);
+	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
+	if (IS_ERR(sbi->options->nls)) {
+		sbi->options->nls = NULL;
+		errorf(fc, "Cannot load nls %s", fc_opts->nls_name);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1641,6 +1665,13 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 put_inode_out:
 	iput(inode);
 out:
+	if (sbi && sbi->options) {
+		unload_nls(sbi->options->nls);
+		kfree(sbi->options->nls);
+		kfree(sbi->options);
+		sbi->options = NULL;
+	}
+
 	ntfs3_put_sbi(sbi);
 	kfree(boot2);
 	ntfs3_put_sbi(sbi);
-- 
2.43.0


