Return-Path: <linux-kernel+bounces-725038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C5AFFA16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1084A7CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD8DDC1;
	Thu, 10 Jul 2025 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1udXAMO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4522DFBA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130182; cv=none; b=qKzfKEc8YBZY8ShzARQP8UdCU/bJVdVEjOY8D+7Mcr5cGTQkpSlECgAMw/xm+VD8T2mc96mXSsCcvNUZG4l1zOUGDw1KsphuQ7hTuDCNv+v5YFwgaqeToEyAtLjkt3BT0QidDhE3veZ4zx1K6rhAuav9550+mZg80ufgqVQd4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130182; c=relaxed/simple;
	bh=ulx9d/DQxHSq8yBMGJGZdqGJWjD6S0fWVX3xk0ZLWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hq2dRD/HE2/knbqfAxuYTu/nqavtCW15WOmSVvlQnuMAJM0H+vl7XTE2R1W5t45PEy8vdUFvceWnNO22kBrIkOnPXQg0lCNOuaknOD+si5cN/sGaDY7ol6Jmtqwr5+mdCmKeN0buaZEMIKhd24pIKRaL4lUzqg9OAkY/b09rViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1udXAMO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so6992825ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752130180; x=1752734980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htp01S+n+HVlXHdLt7skX8tLW/BOHq74J5Zg1sPnI7E=;
        b=P1udXAMOnC5gL7XZV/mLSFu4XE3FjkbPfCF7ZRXOl6Pve3NtBnUFypGJXJNl2AH7mW
         4iQb1WZdC2zEoJsgS/r8/hJ1QD5YVtOr6mTrp4cqGY0bQPX8siF1L4VZm9huZJ7AAXbO
         AKy5m2hORElvBgUt4usFFi0TAodoUn8xdDFNanibjTjElra0rH3saonGU4xALgRFOJv5
         WWUNzvGddCZnmGPsxAHpKG1LH2ThguV0TrB4t2AsAc0iGz33gUi2pGBodYQd15NtT/zI
         gEL2JTzb7GTcNMJz4MxydFXDiGi7nQiiXCeaTei6YD005jRyaO1jTK64MLBf53CyzNQQ
         UqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752130180; x=1752734980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htp01S+n+HVlXHdLt7skX8tLW/BOHq74J5Zg1sPnI7E=;
        b=Zgwx+QBBrNoMYgbW1cLo7Nx5oYEz4IfEJyQOjWSl94CbV7DXxw195miYuW17sC9J8j
         l8wrKZLaLA0SgJEYY+47TBc+AztEScie9k5kBqNdSTrJ5xclRAsUWgtES/UfaJugvuRn
         Xitnbr8kd40C2OmT9W0u3uSo1CQ+uoxnTpPpGRdSvQccTDGlvmiPGvuzfHkhBp16hmXc
         2bmAVumFRT6/gCvoW++s/8C3Grl0pa39tf8txgA88CmPsMmaJAC5MSVmxjr64e3/QPgg
         ejMSbtCAMXyd+/42uOTixrZ5UfspPUFyN5/UJQz32t3szbPbPSqUXg9nuBiOoYC5KPYm
         +Klg==
X-Forwarded-Encrypted: i=1; AJvYcCVPivxWiGNher1jRIQTXIcBY4y7MIZ0CpIxfwsF8xGjvnzNhJidcK7NnKDIy+jv/Nog2qskm6caE4Nl35I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kYcxYNPrWU8GiyHcCLUSa9dSMd/+onikmwwSzx8/wyHw0OOb
	eTW3aifovJ6/TuLMFZRYXbuk1RzzP71UJ+BEsdPa8fFv6joPOfQ18av4
X-Gm-Gg: ASbGncs7XF8m4NfpDH40iHePb3xEyUcXe1EpWPPxobwUEUMZD3nEukH2JzRKbKxc1zj
	fdRcHm0ipr6wtTm7wPywczcKd/dwMP09kmftFIyxSKBipkZCsrfCWhxBSG/UNpS+74ezv/b4RPX
	hnZjOqpOYyI79SPxsHM8NoQ/SjoVd6eyOID52v89qSpc7cmamQlfUKbNBYopd3tRIELEeus+MeL
	+iXRCAyHUJfuPXSVSqyxYBSLhEGgMhes8/YE88JAFprCYl57R39+H7qeVRWkn48vLIvE7ZhMWgk
	qzXaIWvTLHBhQkR+F4Kk54OEn9hNBNBKwGM9I97uKY3RC3J7N7pHjF6OcqNTTIJTonW9
X-Google-Smtp-Source: AGHT+IG6FYSsMU+7D5SufVGwPjK3najFyZaIrgv4/68hzwkgjCm49UP5b+rx+iASgM46KJQUZtmzUg==
X-Received: by 2002:a17:903:b50:b0:234:8c64:7878 with SMTP id d9443c01a7336-23de24331b6mr36245885ad.11.1752130180057;
        Wed, 09 Jul 2025 23:49:40 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359ddcsm10809255ad.207.2025.07.09.23.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:49:39 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	nhuck@google.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	shengyong2021@gmail.com,
	Sheng Yong <shengyong1@xiaomi.com>,
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: [PATCH] dm-bufio: fix sched in atomic context
Date: Thu, 10 Jul 2025 14:48:55 +0800
Message-ID: <20250710064855.239572-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong1@xiaomi.com>

If "try_verify_in_tasklet" is set for dm-verity, DM_BUFIO_CLIENT_NO_SLEEP
is enabled for dm-bufio. However, when bufio tries to evict buffers, there
is a chance to trigger scheduling in spin_lock_bh, the following warning
is hit:

BUG: sleeping function called from invalid context at drivers/md/dm-bufio.c:2745
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 123, name: kworker/2:2
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by kworker/2:2/123:
 #0: ffff88800a2d1548 ((wq_completion)dm_bufio_cache){....}-{0:0}, at: process_one_work+0xe46/0x1970
 #1: ffffc90000d97d20 ((work_completion)(&dm_bufio_replacement_work)){....}-{0:0}, at: process_one_work+0x763/0x1970
 #2: ffffffff8555b528 (dm_bufio_clients_lock){....}-{3:3}, at: do_global_cleanup+0x1ce/0x710
 #3: ffff88801d5820b8 (&c->spinlock){....}-{2:2}, at: do_global_cleanup+0x2a5/0x710
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 2 UID: 0 PID: 123 Comm: kworker/2:2 Not tainted 6.16.0-rc3-g90548c634bd0 #305 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: dm_bufio_cache do_global_cleanup
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 __might_resched+0x360/0x4e0
 do_global_cleanup+0x2f5/0x710
 process_one_work+0x7db/0x1970
 worker_thread+0x518/0xea0
 kthread+0x359/0x690
 ret_from_fork+0xf3/0x1b0
 ret_from_fork_asm+0x1a/0x30
 </TASK>

That can be reproduced by:

  veritysetup format --data-block-size=4096 --hash-block-size=4096 /dev/vda /dev/vdb
  SIZE=$(blockdev --getsz /dev/vda)
  dmsetup create myverity -r --table "0 $SIZE verity 1 /dev/vda /dev/vdb 4096 4096 <data_blocks> 1 sha256 <root_hash> <salt> 1 try_verify_in_tasklet"
  mount /dev/dm-0 /mnt -o ro
  echo 102400 > /sys/module/dm_bufio/parameters/max_cache_size_bytes
  [read files in /mnt]

Fixes: 5721d4e5a9cd ("dm verity: Add optional "try_verify_in_tasklet" feature")
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 drivers/md/dm-bufio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ec84ba5e93e5..caf6ae9a8b52 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2742,7 +2742,9 @@ static unsigned long __evict_a_few(unsigned long nr_buffers)
 		__make_buffer_clean(b);
 		__free_buffer_wake(b);
 
+		dm_bufio_unlock(c);
 		cond_resched();
+		dm_bufio_lock(c);
 	}
 
 	dm_bufio_unlock(c);
-- 
2.43.0


