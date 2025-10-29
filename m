Return-Path: <linux-kernel+bounces-877271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D848BC1D9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE412188A62A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEA72E1747;
	Wed, 29 Oct 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeM6XZZP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8562E0904
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778353; cv=none; b=rPdDaTcRrq5GNexLvKmncJ9z60t/zCUOmTPTDipSqj7zBkrNwi/NGlP20Eq5CXpLWzz8jw7UztovcKVYtmwL3FzhUcD1o2JJhl8gBjrGPmJJKZTtAUj6vgSH44KFkk+DrtU3udbjTgPy8if/dLtt3H1dixxgwnUYF/3uRNJiULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778353; c=relaxed/simple;
	bh=1ZhsIcRLP7+IYtwf3LWzzjumhrTQGEFECTJ35YVT8uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpbc//5mXPYjXmiC7XkzK1wQQa+iXA+dPbUO472c2uvIPYZgH4D8mZYcZHQ9vvbxwA3yj0mFULIXrBK2Kj75TbK9/YL5uQZXImhshQIgF80bWfr0h/ewp/2PZ4goNnupru5DCB1FSUgWWdZhgVmurcl9EyDr00bik+IBHhK6Kf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeM6XZZP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-294cc96d187so4673395ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761778351; x=1762383151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa/M9rWrlNILi0zFUiuPfvMm44JyZKpzB3uqveEBnzM=;
        b=AeM6XZZP7+v14dT4V7+2Bz6QaBm9o5pcqcmHXjyxqwK3IBcpd58Xlxmov4jLp2Q6Xq
         FH2Nrf0k7ZWmPUKIjT63AvE3aD7J/WY+LUrie7zkzx46j5tQbx+m43OIP6TmKTiylz2g
         pJTMIS4LO8PyHjexbx9YnWKfzmtC+wSS0v1KwqEZKX7wYd/VwyM2PR5V4mjEK2xD8H/4
         Fktvfi8mScNJ6o2gBlKtFsEsIIo3LN9PGIT34bZ2soE6FX5bxCLgykueBLIJy4b6ZotO
         WSbfZ+NFKqCjvjzKpjvS7vOMCdX2V4ogq//ho9paAo58tFhSHMRUndchSmnaGjl9lEhr
         wMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778351; x=1762383151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa/M9rWrlNILi0zFUiuPfvMm44JyZKpzB3uqveEBnzM=;
        b=h5TG4BzJlftJIaxb+lsFvt8Gibu1vI7zLE/HeS0jpDslztfi40CtwlB1rT4Der1kQm
         XvM8QIkmZeU1UPzzDQAqIVtrD5FuEt1bKkGIFut0XXJ8A3l63PZHXJ/QhPZppKFgDT7n
         i9IKAC2KA+uaJoShEAbmZds/GHXhbaDgkqi60BApzFPpyspsTQjCGpMzu83IFkN05DBp
         DUWYqGKR1phKbH0873/1X0eA/UYZe+1RXBSeaQiYGZZ2okJmJj9qI+RUHnzBw8CS7cCK
         OUhw9m3CS3NzpibyDaSNhpOxUwPBhJzVoziYluWjRdmGXFF92P3GCY8JiRlgqY7NRtqg
         TbyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNkm+xWUeByJaRT8jLW8m3yO8nqnviclg60xZ8nWNnBmK9VU2O1ssxrgUOftXN9dDKgXKYhSQ5hEG5ym0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DF5xVKyQGifPB0sNLslroULSySOk5pHsdseWTK5hUn1jWIxp
	pHSDglmz8+ODQLQEIS6u5tv3tggyyA3jxMnUHp82LF43PE8oMWLxFZ+E
X-Gm-Gg: ASbGncuJLdQDl18+fY3iIPpNHDIdgaVtQaWA7ACgj/+cfqnas6eVjOV3wD1PPEdOygb
	VKzMOze3WFKjYGmtAnZ5zP0OEgO0lPfBj09DgiMDFsneXLH5r2d0+wsNf9zWSbVxbQ5wpWNTLw0
	0s1vYMIauqBpqtewDu6XGzFMIL1NayLUYgtu/VxpetJbMKCjJ2nxWnN32iRUBSQRoFUt6IsiwoL
	IqAKmPIgj3/Y7JXApKWCi8ab2QhXd5eWrn5OQ7tAhXRQ7rS9FhSh/BKl9MzQSwpLX6CP/PU9/Gy
	trHnU0MMpMbPj2a02mXIXZbtoRbtUsbZoqQpBH/W6XCF8jevHIw+dD7sarPWQ/lrnaK7rauHOaZ
	1FIDyyvQHu/ZFNTO9nwxqgycFK6PBjEv7UKZ3CSNWT/nUSSWL0fi3BJ1ptuXrX5EK/i/xUuTpgg
	JFI2ZxrTTn+UmZTt3PzC1w22myWt09Baft6nf3TLjmNQnKX4a0XUwtRo0narM=
X-Google-Smtp-Source: AGHT+IHuHo99Vd2q+n3paxG/Mdr/LKbfWyALc22D4g6ejN4rzMFZ1N7kqVPTYkcjWnoApxq6lFrDPg==
X-Received: by 2002:a17:903:22c3:b0:294:df5f:ffc1 with SMTP id d9443c01a7336-294ee3637f1mr8643055ad.23.1761778351175;
        Wed, 29 Oct 2025 15:52:31 -0700 (PDT)
Received: from carrot.home.local (i114-180-53-102.s42.a014.ap.plala.or.jp. [114.180.53.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm162387445ad.101.2025.10.29.15.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:52:30 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Avoid having an active sc_timer before freeing sci
Date: Thu, 30 Oct 2025 07:51:52 +0900
Message-ID: <20251029225226.16044-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68ffe1a8.050a0220.3344a1.03a1.GAE@google.com>
References: <68ffe1a8.050a0220.3344a1.03a1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

Because kthread_stop did not stop sc_task properly and returned -EINTR,
the sc_timer was not properly closed, ultimately causing the problem [1]
reported by syzbot when freeing sci due to the sc_timer not being closed.

Because the thread sc_task main function nilfs_segctor_thread() returns 0
when it succeeds, when the return value of kthread_stop() is not 0 in
nilfs_segctor_destroy(), we believe that it has not properly closed
sc_timer.
We use timer_shutdown_sync() to sync wait for sc_timer to shutdown, and set
the value of sc_task to NULL under the protection of lock sc_state_lock,
so as to avoid the issue caused by sc_timer not being properly shutdowned.

[1]
ODEBUG: free active (active state 0) object: 00000000dacb411a object type: timer_list hint: nilfs_construction_timeout
Call trace:
 nilfs_segctor_destroy fs/nilfs2/segment.c:2811 [inline]
 nilfs_detach_log_writer+0x668/0x8cc fs/nilfs2/segment.c:2877
 nilfs_put_super+0x4c/0x12c fs/nilfs2/super.c:509

Reported-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24d8b70f039151f65590
Tested-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Fixes: 3f66cc261ccb ("nilfs2: use kthread_create and kthread_stop for the log writer thread")
Cc: <stable@vger.kernel.org> # 6.12+
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew,

Please apply this patch as a bug fix.  It addresses a recently reported
issue by syzbot, where a timer might not be properly shut down.

Thanks,
Ryusuke Konishi

 fs/nilfs2/segment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index f15ca6fc400d..deee16bc9d4e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2768,7 +2768,12 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	if (sci->sc_task) {
 		wake_up(&sci->sc_wait_daemon);
-		kthread_stop(sci->sc_task);
+		if (kthread_stop(sci->sc_task)) {
+			spin_lock(&sci->sc_state_lock);
+			sci->sc_task = NULL;
+			timer_shutdown_sync(&sci->sc_timer);
+			spin_unlock(&sci->sc_state_lock);
+		}
 	}
 
 	spin_lock(&sci->sc_state_lock);
-- 
2.43.0


