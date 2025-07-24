Return-Path: <linux-kernel+bounces-743622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B696BB100FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1045518928BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C2226D0A;
	Thu, 24 Jul 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0BxHbfx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC875221703
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339339; cv=none; b=GOcaGuSE2qTR0VvKU/FdEud1MJGRQ5AEWpU0HxcSgKL5QpLWSHl9ELwEIw5Jg6/wvM7S7IYgu8Hz3gf2WjigjJklv3WhTP5YGI+JnSuR8GoDISbCwdol3KvagryaRMiqAuhjjv75DgqCSfe3zD4GH7U31OYcjfbkJH2enDaUxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339339; c=relaxed/simple;
	bh=Qm21j2pfERLfTsVWz+jb5fiVokJz7t4P3c1orFuj8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN6/qJZ8Rn31xEeiuy4nDItv4Davlgl0Y0kfhhuxeuVlz+qDmS4PmrH8/spEcKL7MonwG7oig2PNlHKTUYZFt+bomA3RiYw619m2CyuMryhkZZKEMfG+dVpaXhx2tA8TL0InsJeOzfW99qkncHuYo3k/OAn+I+1w1MnF+355AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0BxHbfx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c8a5053c2so4965965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753339337; x=1753944137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IB7EzD8hLBdajv6lhetUBhSMSuQl0RkekyBjrxZKRzU=;
        b=H0BxHbfx/8cnZ7Dh5hMkReHVJUoDH8fqQzbLHLtEWGf2dJwxerGOSUuTNJj6Ziv1jW
         lIL06znYOZiw2Apbho9OPUeb63HzfGqaOuvgHqs8V65VwFXAVOEWaVxWpjKfUZPFuPC0
         6coaSLh2ZScf1UICdPuzOrKg1bcEALFG/t6caolu8BzJ58DviInJWQ5N8MPc0arXRv8a
         VXj6+nLVeEePg2LTRFV22ez6ZVIZjYLiTSO6xllsFYBoi/dLUO/oHBtTu8yDpeDU1L5D
         +VQUeufHWGpKmHAJoelt3za4CA0BZsPw4jduCkCS6LIr3X1XuNtDQEpj7OTwahKFdAC9
         iB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339337; x=1753944137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB7EzD8hLBdajv6lhetUBhSMSuQl0RkekyBjrxZKRzU=;
        b=FKIpwJEdHFK80ogitoSzrCAeK5kv/2ST2taxwoMoYc3HrfIGM08TF2Ykui0OWk+lO6
         n8XZZL/dnwPoEo3p3u88Gw7grPb5tM2o0lhnlonn4P5YFUJsUTahaGxVRo8dgQb2piQz
         lwJZCBGDc6qCqjod0C4/oBGOwDbuOYpk1AmEFbzlI3c0tgKXN+N/7vlSz1Qjm/LRG8U8
         ItdlXO5h0CHSoKA9ahkTYbp74lDCw/0NYklUfhQONAJv5kTeWjh1FfTPoJJ81GdvoJa5
         GcEd6lOxmyKmUOqGUiA/UNb676wN06Drt+IkShLo3SKM7Nys6+KMLvqcnrvB3ANFbfec
         IsMQ==
X-Gm-Message-State: AOJu0YysUvPUgKGc4mYT82yxOhXzTJ1dQROY12cuV1DttCYN1e0kcSlr
	t0SbpxxpTLgNrl8Zq+c6Qq6cp0I28HVCeN0EBmNinRudBCC2k3WZpca0
X-Gm-Gg: ASbGnctdqkt6uLE0pPEwQlRyqNl4QYq3p+5ZJLljCun22M24n4/mIrcdELHnVgZ/Gbo
	f3++4YdsCQzo00j4AeaDHWokV5+5YREHsCdFvbCj2ze4dlQWeqCVtK33eNxZheMx2Ym0U4v1D/F
	nrX/HigCVKd/827UxNp3ao2OBCntiAgS6D9x4zByzKf/LbCoXVsd7M5GGHqmy0qBLgujMsonoly
	zUNHSBPzkLmIv8gSL/bbGD0RlCkKuP/aZdU4XMblH+w5zHqsDsa/ZMkaRB/ig3ucb9mrhXo133W
	0r86+Q8nSe4uNQZyZ86NRQ7XyryxMsFWUSUsczawjU6TOFw1+rCzAH45UNB2vRwWjXNC8RocTLC
	2W96vtblR3unm3lL5UlmvtGC+ZoU8BUneOPDkErZ1iBcFMD6cOjbpmpeWZj+YNzqKUKHnfxjXj8
	X7otFj
X-Google-Smtp-Source: AGHT+IH5SfiT+AWni92x5xi3TruXZz/fL3dlXNb5j7kH3CucqhbpejNh24pIDvDWCl7WiNZ2PkVkZg==
X-Received: by 2002:a17:902:ef0f:b0:236:9726:7264 with SMTP id d9443c01a7336-23f98161fb3mr78743455ad.5.1753339336835;
        Wed, 23 Jul 2025 23:42:16 -0700 (PDT)
Received: from p920.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476e988sm7713255ad.54.2025.07.23.23.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 23:42:16 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Wed, 23 Jul 2025 23:40:52 -0700
Message-ID: <20250724064051.431879-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main

A NULL pointer dereference may occur in ieee80211_sta_debugfs_remove()
when debugfs_remove_recursive() is called on a dentry whose inode has
already been freed. This can happen due to a race between STA teardown
and debugfs cleanup.

Fix this by checking that both sta->debugfs_dir and its d_inode are
valid before invoking debugfs_remove_recursive().

This avoids the crash reported in syzbot bug:

  wlan1: send auth to aa:09:b7:99:c0:d7 (try 2/3)
  wlan1: send auth to aa:09:b7:99:c0:d7 (try 3/3)
  wlan1: authentication with aa:09:b7:99:c0:d7 timed out
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000029: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
  CPU: 0 UID: 0 PID: 171 Comm: kworker/u4:4 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  Workqueue: events_unbound cfg80211_wiphy_work
  RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
  Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f   92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
  RSP: 0018:ffffc90001977400 EFLAGS: 00010202
  RAX: dffffc0000000000 RBX: ffffffff8b713286 RCX: ca5c1933e35f3700
  RDX: 0000000000000000 RSI: ffffffff8b713286 RDI: 0000000000000029
  RBP: ffffffff824067f0 R08: 0000000000000001 R09: 0000000000000000
  R10: dffffc0000000000 R11: ffffed10085cf24c R12: 0000000000000000
  R13: 0000000000000148 R14: 0000000000000148 R15: 0000000000000001
  FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000001b2f55ffff CR3: 000000005030a000 CR4: 0000000000352ef0
  Call Trace:
   <TASK>
   __kasan_check_byte+0x12/0x40 mm/kasan/common.c:556
   kasan_check_byte include/linux/kasan.h:399 [inline]
   lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5845
   down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
   inode_lock include/linux/fs.h:869 [inline]
   simple_recursive_removal+0x90/0x690 fs/libfs.c:616
   debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:805
   ieee80211_sta_debugfs_remove+0x40/0x70 net/mac80211/debugfs_sta.c:1279
   __sta_info_destroy_part2+0x352/0x450 net/mac80211/sta_info.c:1501
   __sta_info_destroy net/mac80211/sta_info.c:1517 [inline]
   sta_info_destroy_addr+0xf5/0x140 net/mac80211/sta_info.c:1529
   ieee80211_destroy_auth_data+0x12d/0x260 net/mac80211/mlme.c:4597
   ieee80211_sta_work+0x11cf/0x3600 net/mac80211/mlme.c:8310
   cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
   process_one_work kernel/workqueue.c:3238 [inline]
   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
   kthread+0x70e/0x8a0 kernel/kthread.c:464
   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

---
 net/mac80211/debugfs_sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 49061bd4151b..912b69abab52 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1276,7 +1276,8 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
-	debugfs_remove_recursive(sta->debugfs_dir);
+	if (sta->debugfs_dir && sta->debugfs_dir->d_inode)
+		debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
 
-- 
2.43.0


