Return-Path: <linux-kernel+bounces-748518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C825B1422C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18CF189E6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B827603C;
	Mon, 28 Jul 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b="Gyw9H5ws"
Received: from ipo7.cc.utah.edu (ipo7.cc.utah.edu [155.97.144.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3E1DC1AB;
	Mon, 28 Jul 2025 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.97.144.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728276; cv=none; b=rXktdiMnLTU2SKNqZ4rf/TWIB2dua4a7fEJrSnSmn16oXAfocAzc36UQOjl3GvBtNO9SqQiqcVJQ/UGY/793hR0EY0aPOdd4eVA/D/Q4NKQgdz40w+YrmEEQwqrZ3yXwuaUvnAqerd5YkuObYNuhEO/0osCkIdGAn9cA6OMRBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728276; c=relaxed/simple;
	bh=h2slNLSpVmmqyD18w2BHpOp3DrQR4PJX6RRcua16D64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8GfjbCRHEV7T8njnxWffU9uEkB5JCNwfYex3iKc7FCdc+LWj4Ozd8RdphRIr+vq8UUyZHzH3K9z+898R5/dwdVKMdPssVjRF2i1BbLjE8Wou+txdvcCDTSml2GkXNEA/8D45ZOmWYWPh0L+wVvQvo+wvJxMjKqRaD1UhshEFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu; spf=pass smtp.mailfrom=cs.utah.edu; dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b=Gyw9H5ws; arc=none smtp.client-ip=155.97.144.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.utah.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1753728275; x=1785264275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2slNLSpVmmqyD18w2BHpOp3DrQR4PJX6RRcua16D64=;
  b=Gyw9H5wsFVtRZ6ZjTWhv4yULOFADGifxjtW0OY2gZXCe6om03nI8lx+F
   ZLTT8kuPbgVpnY2JYrXG1nnVFcX7Dovrxj2vpzXcW7vf2TwgFEPiDN+D3
   55RF2b7UmL+y/uGosFsyRA06TaCDeH6A+PenAxLbgf3q5lR22L2KHSAgK
   DFOPmfFJxt8fzVoLYEyW81suyZ2RuZyA8yR9lqTxV24ZnWGBw+TRUZUGe
   ttLik18abThqm5/UUxfSJhW7HDnUg19aA75ZR7fsfQb8D1osA/wFBezt6
   Pi5SjNR9m5n5ubsO5JwiBv0xoCgSnbauBADDw2KLYlaK+y/VcfCzxhZMF
   w==;
X-CSE-ConnectionGUID: hP2vyLc9QvKWD7m64bTLyQ==
X-CSE-MsgGUID: y+JZmYdYTSWX6T2DUuf2Pg==
X-IronPort-AV: E=Sophos;i="6.16,339,1744092000"; 
   d="scan'208";a="398910703"
Received: from mail-svr1.cs.utah.edu ([155.98.64.241])
  by ipo7smtp.cc.utah.edu with ESMTP; 28 Jul 2025 12:43:22 -0600
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 8798E3020EF;
	Mon, 28 Jul 2025 12:41:13 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at cs.utah.edu
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (rio.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5RmEL0Ur5UR; Mon, 28 Jul 2025 12:41:12 -0600 (MDT)
Received: from memphis.cs.utah.edu (memphis.cs.utah.edu [155.98.65.56])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id ABB523020E9;
	Mon, 28 Jul 2025 12:41:12 -0600 (MDT)
Received: by memphis.cs.utah.edu (Postfix, from userid 1628)
	id 556EB1A02A7; Mon, 28 Jul 2025 12:43:20 -0600 (MDT)
From: Soham Bagchi <soham.bagchi@utah.edu>
To: dvyukov@google.com,
	andreyknvl@gmail.com,
	elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	glider@google.com,
	sohambagchi@outlook.com,
	arnd@arndb.de,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Soham Bagchi <soham.bagchi@utah.edu>
Subject: [PATCH 1/2] kcov: use write memory barrier after memcpy() in kcov_move_area()
Date: Mon, 28 Jul 2025 12:43:17 -0600
Message-Id: <20250728184318.1839137-1-soham.bagchi@utah.edu>
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

Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
---
 kernel/kcov.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 187ba1b80bd..f6ee6d7dc2c 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -978,6 +978,15 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 	memcpy(dst_entries, src_entries, bytes_to_move);
 	entries_moved = bytes_to_move >> entry_size_log;
 
+	/*
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


