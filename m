Return-Path: <linux-kernel+bounces-881809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68AC28F74
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E28188C48A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB9199FB2;
	Sun,  2 Nov 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="d7PctEau"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847AA48
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762089699; cv=none; b=Z1JCQyXgVNL7ltGQrOv4J6pzlh7ZACj/NIgQHJpPagC0fEbPtKZAni7vPuJMrbfwGXhyrcaGCk25MwmQKgwT8hyBSyo9VTxpfCxsOUR/tw71xVB3ZNTcHgdgq0n8bHoEO3CXoWimL7gfANdvLGS3W1DMPyYqHvil/L4yhiVE+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762089699; c=relaxed/simple;
	bh=yHnIo/N8SHs4pQbTBrkWZWd1JgpOrx2RkJfVy1RtWJc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AUnFOgaHMWAeyOzHS59zj3mhZht+KrCI+03atSyIHerlArVdCGsxETrCak04tTA/lGmWg0fR7bKIYa8dpBJndfZ13rbyLanLMqne2ufVToY62CGP97XJJ7VOIW8MezS4BFd9aD//SU2KU7unYd1SvnUTNZwxkcSCARig8ZupYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=d7PctEau; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762089694; bh=e3yckeFunAE9xK5O09Crsr//bUtU/PybUuzy76H5o/A=;
	h=From:Message-Id:From;
	b=d7PctEau0Woj5rch49l1rBJ6u2z2Uv04KG2osxuPfw3W+FtSX5LL+3UqlxbHWR17M
	 SXtNUwi7Uq2Dv3EpLlxpZTFcDBU/EVHXOwuE4dLqTdItnwuDz5S82g1P7LTL8DmGnF
	 OH4EEiXUpfv8t0uADR09URmxiOP4WLvKroa+MdUA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 393F8C06EE;
	Sun, 02 Nov 2025 14:21:34 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2DLXwl027263;
	Sun, 2 Nov 2025 14:21:33 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3] tools/nolibc: add the more portable inttypes.h
Date: Sun,  2 Nov 2025 14:21:28 +0100
Message-Id: <20251102132128.27221-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It's often recommended to only use inttypes.h instead of stdint.h for
portability reasons since the former is always present when the latter
is present, but not conversely, and the former includes the latter. Due
to this some simple programs fail to build when including inttypes.h.
Let's add one that simply includes nolibc.h to better support these
programs.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
v3:
- include nolibc.h instead of stdint.h from inttypes.h so that everything
  is known at once. Just like with limits.h, this file is nothing more
  than a convenience for users to port applications and doesn't provide
  anything, so there's no point including it from nolibc.h

 tools/include/nolibc/Makefile   | 1 +
 tools/include/nolibc/inttypes.h | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 tools/include/nolibc/inttypes.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 585937c7d346..ff0e646acda9 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -33,6 +33,7 @@ all_files := \
 		errno.h \
 		fcntl.h \
 		getopt.h \
+		inttypes.h \
 		limits.h \
 		math.h \
 		nolibc.h \
diff --git a/tools/include/nolibc/inttypes.h b/tools/include/nolibc/inttypes.h
new file mode 100644
index 000000000000..8db9c2542b44
--- /dev/null
+++ b/tools/include/nolibc/inttypes.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+#include "nolibc.h"
-- 
2.17.5


