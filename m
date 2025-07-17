Return-Path: <linux-kernel+bounces-734557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C33B08320
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EB37A32D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED41C5F10;
	Thu, 17 Jul 2025 02:49:48 +0000 (UTC)
Received: from ipo6.cc.utah.edu (ipo6.cc.utah.edu [155.97.144.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533210A1E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.97.144.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720587; cv=none; b=DjBZ3RnXIuhVxaJgkvu/wgxjEOp5pG3VXbqhZlIJEp18JrIgLh5cUGnZlkCS4BT0lF0Cd238KBm9LtPED6U+5Iumy+E7kYniNNFJL1zPstUYIf+90bftBpKMTB8RCkjcec9ZdquSpw+rUrfn0yirFpckkVfuIE3aYJn1O81nhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720587; c=relaxed/simple;
	bh=q21lwMTRAzQeaBNb/5J/CjyDEI67R8TQCDDA0Boz36I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oZpLK6gJXMheezqV5k7iVcp0WTvJo7ziJ3CNM5soiG5MQm/xgAiatiYvSewdgVOoPNhm3M6zVdMQvKyUXQ3vvm5j+zlrnCQFqb2S2i3QJPWQ3ptjP2A3xdmj3qLEGsq0GkJfM02EsahZFtCMTyOHZoarn4s9J384t7VHrKYzaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=cs.utah.edu; arc=none smtp.client-ip=155.97.144.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.utah.edu
X-CSE-ConnectionGUID: PtUaXuSkQEK39q3iMm/F3w==
X-CSE-MsgGUID: 8CCVDYOAR5O+Xjf2s9ij/A==
X-IronPort-AV: E=Sophos;i="6.16,317,1744092000"; 
   d="scan'208";a="122990153"
Received: from rio.cs.utah.edu (HELO mail-svr1.cs.utah.edu) ([155.98.64.241])
  by ipo6smtp.cc.utah.edu with ESMTP; 16 Jul 2025 20:48:37 -0600
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id EC504301D66;
	Wed, 16 Jul 2025 20:46:59 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at cs.utah.edu
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (rio.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAeJmofh4QWz; Wed, 16 Jul 2025 20:46:59 -0600 (MDT)
Received: from memphis.cs.utah.edu (shell.cs.utah.edu [155.98.65.56])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 9829F301201;
	Wed, 16 Jul 2025 20:46:59 -0600 (MDT)
Received: by memphis.cs.utah.edu (Postfix, from userid 1628)
	id DEE3B1A029A; Wed, 16 Jul 2025 20:48:36 -0600 (MDT)
From: Soham Bagchi <sohambagchi@outlook.com>
To: dvyukov@google.com,
	andreyknvl@gmail.com,
	elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	sohambagchi@outlook.com,
	arnd@arndb.de,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smp_wmb() in kcov_move_area() after memcpy()
Date: Wed, 16 Jul 2025 20:48:34 -0600
Message-Id: <20250717024834.689096-1-sohambagchi@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCOV Remote uses two separate memory buffers, one private to the kernel
space (kcov_remote_areas) and the second one shared between user and
kernel space (kcov->area). After every pair of kcov_remote_start() and
kcov_remote_stop(), the coverage data collected in the
kcov_remote_areas is copied to kcov->area so the user can read the
collected coverage data. This memcpy() is located in kcov_move_area().

The load/store pattern on the kernel-side [1] is:

```
/* dst_area === kcov->area, dst_area[0] is where the count is stored */
dst_len = READ_ONCE(*(unsigned long *)dst_area);
...
memcpy(dst_entries, src_entries, ...);
...
WRITE_ONCE(*(unsigned long *)dst_area, dst_len + entries_moved);
```

And for the user [2]:

```
/* cover is equivalent to kcov->area */
n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
```

Without a write-memory barrier, the atomic load for the user can
potentially read fresh values of the count stored at cover[0],
but continue to read stale coverage data from the buffer itself.
Hence, we recommend adding a write-memory barrier between the
memcpy() and the WRITE_ONCE() in kcov_move_area().

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/kcov.c?h=master#n978
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/dev-tools/kcov.rst#n364

Signed-off-by: Soham Bagchi <sohambagchi@outlook.com>
---
 kernel/kcov.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 187ba1b80bd..d6f015eff56 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -978,6 +978,15 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 	memcpy(dst_entries, src_entries, bytes_to_move);
 	entries_moved = bytes_to_move >> entry_size_log;
 
+	/**
+	 * A write memory barrier is required here, to ensure
+	 * that the writes from the memcpy() are visible before
+	 * the count is updated. Without this, it is possible for
+	 * a user to observe a new count value but stale 
+	 * coverage data.
+	 */
+	smp_wmb();
+
 	switch (mode) {
 	case KCOV_MODE_TRACE_PC:
 		WRITE_ONCE(*(unsigned long *)dst_area, dst_len + entries_moved);
-- 
2.34.1


