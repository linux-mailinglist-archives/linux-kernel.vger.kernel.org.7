Return-Path: <linux-kernel+bounces-737380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BFB0ABB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B1B3A6648
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0D22069A;
	Fri, 18 Jul 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg9n+anM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FE6FB9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874824; cv=none; b=LKn5IRpJIQPcDR2UBmMhUk/JPhCvFOiXDB90qIepk/07kUzGOeEsQOCC4NhHw4SPYF2vPH5v0EBjM4iOVpmVzb/IvkldUuc0m8C7QywWSUBySwLofUOkdSCv+L5REGSWWhi0quyWLzAvDblEjtconePunEZLlzyGxQRFkWN+as0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874824; c=relaxed/simple;
	bh=D8qYTnLVlbt02g0tZ7UFUn4xHvpvjr/9PT73JUz/sno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEHRMykQU8BhV5Bs31yAcMmGbubl6LkKXh2D1DMVQpbncKXfb9fLL0Cyc5WOWchAt72+kf96MScE6ij851UcFXwSGEppBbk0ndPW37xBMuRu/ROqU3L+ny43BMY2sz6yLak8QNq+OTjKYsfKzdlm5lrBn1KDBMdf55JmUF3AqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg9n+anM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1722669b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752874822; x=1753479622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfoGAqDs0KEygckjNWNCfRbMYzpWUQukgt2WdbLvfmc=;
        b=Tg9n+anMf5rRf9umiK6hQiihdSREbtfxxdvaD/x4Bj60sSAsMD6vfHc3ChkPK6B8C7
         YOhzBWHnTYjg/Atf19MvBe/qa3ifIU+OBHbqwkSSxIV8Ur/bYfzQ8ZgTo35sW4BH2s/J
         HSZOzqO0LMQrjyURA4/6jbVngihtuFlXiSSlWuD8+uqIgpLGjSpnIXAWZX7F+I0LBjND
         C8MrTpnZlHANPGhpNBcFNnezmwCivOUcB4+bpSkrFDYH3Jbw80LipzPSYNcGB0A6Hdfb
         UqjDcxu1zwMOyq/PHODK7irFxRpX8NuM9kykr/pfbwnaeaT8Ydax9dKGn7Kg1/N45Wnb
         5Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752874822; x=1753479622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfoGAqDs0KEygckjNWNCfRbMYzpWUQukgt2WdbLvfmc=;
        b=C//sYeHom0RhmGZRYpRAFmj0cPYF5qKFy2g+pMw7c1TMQfWE410A/yqE86jFal8zdJ
         Qg+Kv1phBwmJ0EonfoJJONxwNQ1NelZglsW8qqVJVgTbGkiseSwOBM4cBCV4QgJWTffZ
         RfD0yle8Z/EbLglnJnMWGcoslaDmBoQWR9nM0u4XDt2Bqu6IXAuIjezqEq0wYoa3YO+s
         LOcKiKMcAV7uygK1QZdI9bGoc4QN42rYDGWbyzmTOxlkcOXfMDPiCA0JU8kZ1etkx2nj
         g/TygFNIWIaIeEjjje1j9pZvqxUvlRkYj1FhjhfqxQFK7qgnuWKO8sOFSIJgrq8w/E8R
         j1qw==
X-Gm-Message-State: AOJu0YwjjCvUXzYsqHSavu07Rp4a2bdcFZogPVYKqh6dKEXghrBij0dZ
	ZIK/1OVCPDkPLHzHAMCGcUitG/gSN1m5wYQ0AYBNssYAnUQIDGu+2hkDjZ2/GA==
X-Gm-Gg: ASbGncuhL+Si4JXkDSL7Kvb4N9H1zDvz7fX5X4VmCMoHZHp5dzWq5WXCHhAhzkxs8W6
	ykdasGxCradL4Z4edFxx6nGOAkQGyT8uYWgkM9QcT2XGanqvJoOnCA9Cwx5eg2cA/LRlZdA6Wrg
	FjsXBd4hTeMm108oAoc6zIPN6RMWD15rGDzpz4T6ifv28QULPR+zEfDaz31X2lJ6DRDA2D+NbRJ
	MjB3XnRE2FLyTVLhNoZpbE3C2u9AMBrBFAqU8wzO+LvP5IOs8ODfhHCdoYMWWK3PG7x+c9pWW32
	6p1CNRpyTxs/oTw2DBOlRYADrfFI5/2+4Y8xTkoLRkqCMXDn/xqmrK5ilVzmSyQEy/9nSpFbLAB
	d8ouYZULtty9QfwfDwFI3aN5IDzhkLgeAKDXrMWTo92UXENskT6vmbq7aOWrhOWQA9iyMJx62Sf
	3Nc0aygwljP+MCVw==
X-Google-Smtp-Source: AGHT+IHzFM56WdAtgwpgdQme2yI48O+6b8pHbsuA1cfjaaC6Z8I1MfrtI83Gnwa4bohZNLfR7gYHyQ==
X-Received: by 2002:a05:6a00:4642:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-759ad4012efmr6197521b3a.14.1752874821444;
        Fri, 18 Jul 2025 14:40:21 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:902e:59ec:cd2a:fc00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678fecsm1731070b3a.118.2025.07.18.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:40:21 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add gc_boost_gc_multiple sysfs node
Date: Fri, 18 Jul 2025 14:40:14 -0700
Message-ID: <20250718214014.2277307-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Add a sysfs knob to set a multiplier for the background GC migration
window when F2FS Garbage Collection is boosted.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: limit the available value range
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bf03263b9f46..931c1f63aa2e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -861,3 +861,11 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
 		SB_ENC_STRICT_MODE_FL            0x00000001
 		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
 		============================     ==========
+
+What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
+Date:		June 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Set a multiplier for the background GC migration window when F2FS GC is
+		boosted.
+		Default: 5
+
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3cb5242f4ddf..de7e59bc0906 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -197,6 +197,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
+	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
@@ -1749,7 +1750,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					!has_enough_free_blocks(sbi,
 					sbi->gc_thread->boost_zoned_gc_percent))
 				window_granularity *=
-					BOOST_GC_MULTIPLE;
+					sbi->gc_thread->boost_gc_multiple;
 
 			end_segno = start_segno + window_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 5c1eaf55e127..efa1968810a0 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -68,6 +68,7 @@ struct f2fs_gc_kthread {
 	unsigned int no_zoned_gc_percent;
 	unsigned int boost_zoned_gc_percent;
 	unsigned int valid_thresh_ratio;
+	unsigned int boost_gc_multiple;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 75134d69a0bd..b0270b1c939c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1050,6 +1050,7 @@ GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
+GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1220,6 +1221,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_zoned_gc_percent),
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
+	ATTR_LIST(gc_boost_gc_multiple),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.0.727.gbf7dc18ff4-goog


