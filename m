Return-Path: <linux-kernel+bounces-842716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BACBBD611
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8525F1891DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96BE2638AF;
	Mon,  6 Oct 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoMITu2p"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741671DE885
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740396; cv=none; b=F1pJ5aiSW6CyLznHnrUMJByzBBCIePH6dvNUg1pH2A2Qu25KkAdHv2cmSxTdhqGMtu+ZT/uRZsuB2r6ijibrndoVVGJEMNObgnihmT6Mdav3+ZlVeitTM020viwzWY/1utXKIMCyXESV3vWhHuydrZMqJUwxl5rQmnlU4q8YH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740396; c=relaxed/simple;
	bh=5XZ4gBTQ1QA04cVW1SVAYTbNiQpTM90AQRfQGyx5ag4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XwR3Y/AOQnY+j9gCZA+nyxFdfEhsdydNb69cyPYSrr5HevRquJFIPhIC/EjC2lvD+jZl0ZcUPdstkN9ChkIkg1Or0hIGoI/bLeDYPoDHQ1F3beR2yAILIgbSykYGZLTPrfTQGtQH+q5D7CLw8R1tuLDB1pSnlJxsmPsbl3uYCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoMITu2p; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b4af88aba57so140843666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759740393; x=1760345193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJXxaJbkSA/3Xb5uNqWTj3oIOQXZmPEn5IRJe3cfIGg=;
        b=LoMITu2p9a2jkaegbrI9PJ/M3gL/vffuxxHBnFn/IDromNU/f/oWcNHKtjcTBxT7al
         I+oAHbmhVYe+N0TT92BZM8xO5thcbfme+P/dNttSHfB5XQ7/oGr0Gd6bVcEwqsRfQ7lk
         lUQgs4IXX5mJ1XlB2t5/yp+ZTeyDruvHiQzkYIXN34OD858ydxAmdYv9+jYACi+2JmDb
         lMI1VbJJeY/c65PFc51dfzYm7BfOkNuvuf1RkSfdVarnvc8yOOqOxhe0afocsn6JoORM
         trKQUzzB9vesOSfFL9J1gA9Qw6WHTGxNTBE6oamFf8N1EZn+GFHjBUvVtJc/SKGcFAYG
         bx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759740393; x=1760345193;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJXxaJbkSA/3Xb5uNqWTj3oIOQXZmPEn5IRJe3cfIGg=;
        b=LjAdCzLB/sKq5yHzXbmybPrSA42z/YUZ2UR3vtIDSDQoE5J0sewSxDnK3m8OW2Wbg8
         yOEpYip8H6gPE961+P9QltSoVVDaYmzqXquu0ivQUWpoHOphw6h/JdtbeoBvKM7ydXGm
         +Ce5gt85dSnr3iigLSSEwZHYJP3Xy9cVhEGD50+KBwaIrx3sk8Yq23nL3ZlDX1wzVWKg
         ZOqFZkmjwe/09JIilIFsGMl3G4xqhE1y9OnkIHkyvZ/3nYeodJPn8iTCCl/s94+dGoqg
         DyBFJrPNKYV1aZqff+a8evI/hwvZPsBaocM0LA67yXY6M9Eg3KbWepwahuEiZRsAuByl
         8Bvg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZgPaTVVEDn8EQpRRQDaK9BKMDP8WUCaGXbwAh+1x1PTyxP6pBQEYI5EgOArRKqmiy2zOv0uBitY+ldg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4A4DzERXNzhF3dZg0sQlqYEY7FCIKU4xddQ/wBKDCP32Ctcm
	LYC0c/qL4DyrWkzuPWVsXafZjcTMgjUuFZY3C9GyIANUMcIilV6CiWEy9vocO2L5R+PsCkNgBQ1
	NRYA1LMKa/CF46rERbWzNERiA6a7Jxw==
X-Google-Smtp-Source: AGHT+IG3L0nTzCEE3SV4kT0ZjhvKBhiX0rWparm4WD7kJhXXQ2yTr43Zwy/HZZQHhpAowp7zp90/DyaNjwbO2AKpPho=
X-Received: from ejdbw9.prod.google.com ([2002:a17:907:fd89:b0:b3f:de21:e9ef])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e93:b0:b45:c0cc:2fe9 with SMTP id a640c23a62f3a-b49c393a5eemr1610665866b.46.1759740392721;
 Mon, 06 Oct 2025 01:46:32 -0700 (PDT)
Date: Mon,  6 Oct 2025 10:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006084615.2585252-1-jprusakowski@google.com>
Subject: [PATCH] f2fs: ensure node page reads complete before f2fs_put_super() finishes
From: Jan Prusakowski <jprusakowski@google.com>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Xfstests generic/335, generic/336 sometimes crash with the following message:

F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
------------[ cut here ]------------
kernel BUG at fs/f2fs/super.c:1939!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f2fs_put_super+0x3b3/0x3c0
Call Trace:
 <TASK>
 generic_shutdown_super+0x7e/0x190
 kill_block_super+0x1a/0x40
 kill_f2fs_super+0x9d/0x190
 deactivate_locked_super+0x30/0xb0
 cleanup_mnt+0xba/0x150
 task_work_run+0x5c/0xa0
 exit_to_user_mode_loop+0xb7/0xc0
 do_syscall_64+0x1ae/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
---[ end trace 0000000000000000 ]---

It appears that sometimes it is possible that f2fs_put_super() is called before
all node page reads are completed.
Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.

Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1e0678e37a30..5c94bc42b8a1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_flush_merged_writes(sbi);
 
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
+	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
 
 	if (err || f2fs_cp_error(sbi)) {
 		truncate_inode_pages_final(NODE_MAPPING(sbi));
-- 
2.51.0.618.g983fd99d29-goog


