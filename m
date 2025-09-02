Return-Path: <linux-kernel+bounces-795806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98AB3F816
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341E54E0C31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0F18E377;
	Tue,  2 Sep 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3P+J9xT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8619F464
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801054; cv=none; b=lgCrDJRNxr+vdJJy4TTQpUcuL9s96dPubgwLJC+mvcYw7dWpxQidTB+nHt28l3wFNYnXuMGTHRw9SNMU15ycsQ5qV/4rhfc7VSRCD2D2viiVLWUNXi9wHZQEqu6xgnkgDxZyscJJehOK/uHmhkg36vY/b2ea80bOuDYMVXeLAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801054; c=relaxed/simple;
	bh=BKqpJ9oPGvcklA1ZKo0LRcikMIuvffwBb50mQ+lCy0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2s+O/ftzYJzAeK2E2ukxmJacuLXZloOPBeWWh9wwlZe2T256Y4NdRhmb8WhZUarY81kCBbwcBzabuF/EFR3TPs6q22D7/Memrh/Tih1+BnHGyQe0P1ec+EgpOKriy1IoJHZigd+P8DIKHJ3IFf3rNHuNFWFAU14aosbZSpu3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3P+J9xT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso1337699b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756801051; x=1757405851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ne3er9ThJYgdhxtzNOaTKz/0yuS1weWobLgF56619WI=;
        b=M3P+J9xTtBU4kQHxyJCspDJhqHIJ2ps656Y2o0FtsI5Gh9ZSDRiHYrX/rXSFmFk1cJ
         LDv9p/AVELPtC5aTDFzo7lgYlld8EJgMk3flsGoCVObEzr1OJestdYISnSTMbmt9+Dby
         JpzY3QgJ6muLmDcT3/1QHSprk+E39DX+3gSmUDfUrjh5ppuJiwEehnJePrORWCNqtNSt
         wKibVGESpi+m3406XzfGjfprJO0qIAYX8RjYQH6qVv2VkiZ2WTRL771hwFUdCZo6Ehqi
         IQAvbtIBcu0rgnB+ceEDuDbz94Mk44NaJAE9RNPo8zm/3QQUGZos2V52nUCglraixkPQ
         1yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801051; x=1757405851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne3er9ThJYgdhxtzNOaTKz/0yuS1weWobLgF56619WI=;
        b=McLG6eNGQQ8pMUsih4UbVHrUFett3Jgr3cOyWa85xvY5+1qrt63aXfbg3+bmbuVTJ3
         OGsIh1+OUswfxz5jDma3wJfBNwY/EscWaHY+TIPjVnMsm322Krm+kSAcYNansLaa3Jkh
         YEQ4evcclKquaQiTmcpcPZ2rK8fW5sV4DbT8PsY8tqGrPJ1dvCMM52G4ZIvfGH11xszG
         /dZaaJsp7Ax1GfcqOOVKWtzp7YgUdT1UTekF9R6MgIhPRkdax+WkmDhoiaWNDy+nihP4
         3aOSv8Vk5O7ZqPQFEIqbXMreYFGmeFqskmyBshToxzaqVtj4wQXf/6l/k39ucF9mFZZ9
         YAIw==
X-Gm-Message-State: AOJu0Yz+RSg9ifiei+LgWbCmj3LPsyI9+UsAaMw5ng+KtQiOTGb9/B2B
	h11bVGxihfhSEOmNg2W7RsXlpaMSWD0juHv1NAk0+bZzl2Njip9hq45MAR0XKsZjIIziTw==
X-Gm-Gg: ASbGncst8W/izAXBfDj+GMTvI9Xy72IxJCTslECCAnsq/OJvQizI7Mgsq2kMXnIsSEE
	5E6MFdoYvZOWwaB/ntkmhrHNfXkztSNLGPt8Buu4soFD8eRmKcc7YAlcjbeGI18bjswTR3bcOD2
	88r/pWI1jZcdqiV64Mi6zIq4ClmSXMHI4366bVkzUUnQUvJwFmwPrIqVzdqhQLh4DzRIrsMxruH
	FV0rIIhHRi3ShfzqBrq3qAXrjKF+yv9QaHTZVVmIfN1ifVW/s4Fb6WRI+m5wQJwHh0ZN3edSU5s
	lrfaMRx82ENspiIFyrVKCxF9g0+ujBDEsDiXHz3vFcapawefErASvYgWFUrgPhO1GW+/KNQD9mF
	MTdMb9o4zu2eOWQxxIahvlvOjpS2Qo7kutvlXfikT8eo=
X-Google-Smtp-Source: AGHT+IE/+5qmtquzTUlB7Pr9oe2FXuo+gd6z4LCICiEffLRyHbMkcl0OeZ8f5d8rONyyxqkDDRBN7A==
X-Received: by 2002:a05:6a21:3384:b0:243:9c12:e508 with SMTP id adf61e73a8af0-243d6f09fd7mr15767415637.38.1756801051135;
        Tue, 02 Sep 2025 01:17:31 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8fa2bbcesm2889219a12.4.2025.09.02.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:17:30 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	YangWen <anmuxixixi@gmail.com>
Subject: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
Date: Tue,  2 Sep 2025 16:17:27 +0800
Message-ID: <20250902081727.7146-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reported a data-race between fat12_ent_put() and fat_mirror_bhs():
one CPU was updating a FAT12 entry while another CPU was copying the
whole sector to mirror FATs.Fix this by protecting memcpy() in
fat_mirror_bhs() with the same fat12_entry_lock that guards
fat12_ent_put(),so that the writer and the mirror operation
are mutually exclusive.

FAT-fs (loop5): error, clusters badly computed (404 != 401)
==================================================================
BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs

write to 0xffff888106c953e9 of 1 bytes by task 7452 on cpu 1:
 fat12_ent_put+0x74/0x170 fs/fat/fatent.c:168
 fat_ent_write+0x69/0xe0 fs/fat/fatent.c:417
 fat_chain_add+0x15d/0x440 fs/fat/misc.c:136
 fat_add_cluster fs/fat/inode.c:112 [inline]
 __fat_get_block fs/fat/inode.c:154 [inline]
 fat_get_block+0x46c/0x5e0 fs/fat/inode.c:189
 __block_write_begin_int+0x3fd/0xf90 fs/buffer.c:2145
 block_write_begin fs/buffer.c:2256 [inline]
 cont_write_begin+0x5fc/0x970 fs/buffer.c:2594
 fat_write_begin+0x4f/0xe0 fs/fat/inode.c:229
 cont_expand_zero fs/buffer.c:2522 [inline]
 cont_write_begin+0x1ad/0x970 fs/buffer.c:2584
 fat_write_begin+0x4f/0xe0 fs/fat/inode.c:229
 generic_perform_write+0x184/0x490 mm/filemap.c:4175
 __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4292
 generic_file_write_iter+0x8d/0x2f0 mm/filemap.c:4318
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x52a/0x960 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0xfd/0x150 fs/read_write.c:798
 x64_sys_call+0xc4d/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:19
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888106c95200 of 512 bytes by task 7433 on cpu 0:
 fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
 fat_ent_write+0xd0/0xe0 fs/fat/fatent.c:423
 fat_free fs/fat/file.c:363 [inline]
 fat_truncate_blocks+0x353/0x550 fs/fat/file.c:394
 fat_write_failed fs/fat/inode.c:218 [inline]
 fat_write_end+0xba/0x160 fs/fat/inode.c:246
 generic_perform_write+0x312/0x490 mm/filemap.c:4196
 __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4292
 generic_file_write_iter+0x8d/0x2f0 mm/filemap.c:4318
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x52a/0x960 fs/read_write.c:686
 ksys_write+0xda/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x27fe/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Signed-off-by: YangWen <anmuxixixi@gmail.com>
---
 fs/fat/fatent.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index a7061c2ad8e4..e25775642489 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -379,6 +379,7 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *c_bh;
 	int err, n, copy;
+	bool is_fat12 = is_fat12(sbi);
 
 	err = 0;
 	for (copy = 1; copy < sbi->fats; copy++) {
@@ -392,7 +393,17 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
 			}
 			/* Avoid race with userspace read via bdev */
 			lock_buffer(c_bh);
+			/*
+			 * For FAT12, protect memcpy() of the source sector
+			 * against concurrent 12-bit entry updates in
+			 * fat12_ent_put(), otherwise we may copy a torn
+			 * pair of bytes into the mirror FAT.
+			 */
+			if (is_fat12)
+				spin_lock(&fat12_entry_lock);
 			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
+			if (is_fat12)
+				spin_unlock(&fat12_entry_lock);
 			set_buffer_uptodate(c_bh);
 			unlock_buffer(c_bh);
 			mark_buffer_dirty_inode(c_bh, sbi->fat_inode);
-- 
2.43.0


