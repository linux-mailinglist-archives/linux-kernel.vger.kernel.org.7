Return-Path: <linux-kernel+bounces-744582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22BB10EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96946170877
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB22D3EDF;
	Thu, 24 Jul 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VX7+Xb6f"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D662EA479
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371088; cv=none; b=mAY8rp50MLE50l44g5sogfthG28hIuRX9cTilBLsDW/pLSklDP3pUA9P5DhW/jOMQG6DhrsGUcFqaYMRkbWaWhwS6YtGMUMtytfF/TQRe4UaxEknzrCQH5GCCNFFQOj5bvjq0D9fBR4fhWxPTg++5uz09Nqd65wIqifVYuzGQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371088; c=relaxed/simple;
	bh=+Dulj+iTI3ino3AiwM/woAISMYXNwrb0Ix3LW6bh0M8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qjqlQpI/D3CvlHs++WPbHkBilbXIC/N5dEkiC2ezwkoelINqhTZHVT5dR/loEXM99qG3RcLNolNWA1qgCPAcMp+YT8GLL3v6bnYbBN3B1fgGVnZa0y5cWXshOESxZx9L7MKs5zAHxWMLz800Z+zZbNS3iYo905oXWLh8s4jkBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VX7+Xb6f; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-607c91a207dso1373621a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371085; x=1753975885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SkEsdQ4L/pIchUqNG93CRYH8IJsJl5uVsGM6GRXeRvQ=;
        b=VX7+Xb6fZu92p1lqjGtKiuo/MMKrH9Ng6LXobKjUOH6d35rczbN+fDOXcBrdYj+UXH
         Xf3msZPB8EwEHQTz5Hl3VEXEt6di+zGXnOWhoqqAlRVVfV5QZaEdzUe3muXxarbhsiXy
         1uPLSegpld0+XzT3Iz7lUyfHKRKITkySgLs2IEM979FUY+OrR015tKsvXA3RA+nqn7Fe
         hyjTXiXrtFwKqVo6z0hqJJ2smCGRdou4SmIQHRQ9OZrm6PnoAa66crAqsMJb3UcALSAH
         VYTMPqKKEA6Wj4HBXKsauqn94pFQgEFxJ2DLNIONYPPFm0HVw0WHRdN8KbkImdperHXk
         BIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371085; x=1753975885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkEsdQ4L/pIchUqNG93CRYH8IJsJl5uVsGM6GRXeRvQ=;
        b=no7yHItuCIAZCWkGzxeSYhOiH9XkMyuQ6/RZDMj2n1C8AiFP8MO2U9fnbTGiFwdcP6
         /kuUW5DexUFdzFpJR2mou9DLebaVouaqrftMr7JzxqaYvwouCr3FAjps/TWz2tC+dNlu
         euubJKPU91/DRnapHj48A14tXa1o0qG+w0eu3OzgLlTC6GawTMDYJZV5QI3pxObPUiIW
         4Z02/j435Q0JT9yx9lmWUJEUzYIeQCtBYyIdAToyCrgIngegQ0d2VHzoYBuChSj9+X7G
         44zXeSHa1GBGQhZFUCuVwXUHr0QOwLraBKcwmOWU1Kgo03bTBPgAvouPSQ8YLAxjPw8s
         Knzg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zlEnxH3XHkpnBYWpLp3fKVvctbCfWfcLK9B60EbCw5LeC86Qz6spcUdPiFvu9zucde+xvOwqLaB93J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMnotx95PEtlRjRT/q/kA52HXPJ8iT9d8ecviuGYWRM6a06oM
	S8a6JgmXk0k6smsRZQEobZ+IWQppnZJ1oY4x0rILQeTzVSLBgkyylbWmLFqUHAlqFs7BLS97xKG
	6Lh4uyndzP9U2Wgsh7Rf3IyJ3aEFJuw==
X-Google-Smtp-Source: AGHT+IGephgNH4LuU4bJdMk2LAYalDyAVdQFiFmvCHw7m4ai9Esg7UkatB3g3mrEK/1PSLN2IGMF2mT8tO5ci6gvMtA=
X-Received: from edis29.prod.google.com ([2002:a50:d49d:0:b0:60e:414b:751d])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a50:a687:0:b0:602:1b8b:2925 with SMTP id 4fb4d7f45d1cf-6149b5a2ef6mr4796857a12.29.1753371085371;
 Thu, 24 Jul 2025 08:31:25 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:31:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250724153115.125311-1-jprusakowski@google.com>
Subject: [f2fs-dev] [PATCH v2] f2fs: vm_unmap_ram() may be called from an
 invalid context
From: Jan Prusakowski <jprusakowski@google.com>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Jan Prusakowski <jprusakowski@google.com>, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When testing F2FS with xfstests using UFS backed virtual disks the
kernel complains sometimes that f2fs_release_decomp_mem() calls
vm_unmap_ram() from an invalid context. Example trace from
f2fs/007 test:

f2fs/007 5s ...  [12:59:38][    8.902525] run fstests f2fs/007
[   11.468026] BUG: sleeping function called from invalid context at mm/vmalloc.c:2978
[   11.471849] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 68, name: irq/22-ufshcd
[   11.475357] preempt_count: 1, expected: 0
[   11.476970] RCU nest depth: 0, expected: 0
[   11.478531] CPU: 0 UID: 0 PID: 68 Comm: irq/22-ufshcd Tainted: G        W           6.16.0-rc5-xfstests-ufs-g40f92e79b0aa #9 PREEMPT(none)
[   11.478535] Tainted: [W]=WARN
[   11.478536] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   11.478537] Call Trace:
[   11.478543]  <TASK>
[   11.478545]  dump_stack_lvl+0x4e/0x70
[   11.478554]  __might_resched.cold+0xaf/0xbe
[   11.478557]  vm_unmap_ram+0x21/0xb0
[   11.478560]  f2fs_release_decomp_mem+0x59/0x80
[   11.478563]  f2fs_free_dic+0x18/0x1a0
[   11.478565]  f2fs_finish_read_bio+0xd7/0x290
[   11.478570]  blk_update_request+0xec/0x3b0
[   11.478574]  ? sbitmap_queue_clear+0x3b/0x60
[   11.478576]  scsi_end_request+0x27/0x1a0
[   11.478582]  scsi_io_completion+0x40/0x300
[   11.478583]  ufshcd_mcq_poll_cqe_lock+0xa3/0xe0
[   11.478588]  ufshcd_sl_intr+0x194/0x1f0
[   11.478592]  ufshcd_threaded_intr+0x68/0xb0
[   11.478594]  ? __pfx_irq_thread_fn+0x10/0x10
[   11.478599]  irq_thread_fn+0x20/0x60
[   11.478602]  ? __pfx_irq_thread_fn+0x10/0x10
[   11.478603]  irq_thread+0xb9/0x180
[   11.478605]  ? __pfx_irq_thread_dtor+0x10/0x10
[   11.478607]  ? __pfx_irq_thread+0x10/0x10
[   11.478609]  kthread+0x10a/0x230
[   11.478614]  ? __pfx_kthread+0x10/0x10
[   11.478615]  ret_from_fork+0x7e/0xd0
[   11.478619]  ? __pfx_kthread+0x10/0x10
[   11.478621]  ret_from_fork_asm+0x1a/0x30
[   11.478623]  </TASK>

This patch modifies in_task() check inside f2fs_read_end_io() to also
check if interrupts are disabled. This ensures that pages are unmapped
asynchronously in an interrupt handler.

Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d1a2616d41be..0acc25f996b3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -280,7 +280,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task();
+	bool intask = in_task() && !irqs_disabled();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.50.1.487.gc89ff58d15-goog


