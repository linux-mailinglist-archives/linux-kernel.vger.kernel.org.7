Return-Path: <linux-kernel+bounces-881746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EDC28D8D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D6347A3F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413AF26CE37;
	Sun,  2 Nov 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="Ey1vju6j"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E2AD2C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080384; cv=none; b=YIAnr6mcvZJU7dtTIXJnMk91bC88MamhotmYxWu5nICVBftu/ZMYe0xmZ1N0aVClhCtKd+kvv9PgsRwG4xBfxYLuRIakoRAMbPSUULyaTdLna73c4bYjQW8SoJC6yEEYbL6J9/BhyvD+eVKKv/c2J45LEj1bdTdgi1CGhQkqBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080384; c=relaxed/simple;
	bh=BJFldBb7E4BDpFWi9SM/MvEx/koRmsrytfUq9han2DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q5k3n84xeijn17/Y99w/nvUwKX5izZ/hRTDlmHhVSxnk5HGF1s/n+YOM6mZBdh5f02OzSQUyB/p5h9JPmlZYtFobcesFippTydEeijmj+Qwjm9+Lh4eepToNmkFIZTkCvPmyZ4joL3qKAQnehrjrk62XBjtzHQvBQdHDb5MEMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=Ey1vju6j; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762080380; bh=8rxloVPacP7eWnfAHkA7M3DFF/jwKsYjtau41FN2yVw=;
	h=From:Message-Id:From;
	b=Ey1vju6jnUMOf6chVNPVPJZR8Hur4qFo+lCJGdMpJSIuTcFQDp0T4J3HMfDcEOKrY
	 jLDL+7OC3aGfk7ylWcJS65V+Vq5mo6CpPLSeJUlvR4rEHXBlyICre5H5IaCvU/CpFe
	 3qbkIx4JtZePGo5CH49JVJOKQnv+l5hVf4VF98PA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id E9973C06F2;
	Sun, 02 Nov 2025 11:46:19 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2AkJPb024502;
	Sun, 2 Nov 2025 11:46:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 2/4] tools/nolibc: add the more portable inttypes.h
Date: Sun,  2 Nov 2025 11:46:09 +0100
Message-Id: <20251102104611.24454-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20251102104611.24454-1-w@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It's often recommended to only use inttypes.h instead of stdint.h for
portability reasons since the former is always present when the latter
is present, but not conversely, and the former includes the latter. Due
to this some simple programs fail to build when including inttypes.h.
Let's add one that simply includes stdint.h to better support these
programs.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile   | 1 +
 tools/include/nolibc/inttypes.h | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tools/include/nolibc/inttypes.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 4f617d91a5ff..0d312f1159ec 100644
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
index 000000000000..1088034ef7cc
--- /dev/null
+++ b/tools/include/nolibc/inttypes.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#ifndef _NOLIBC_INTTYPES_H
+#define _NOLIBC_INTTYPES_H
+
+#include "stdint.h"
+
+#endif /* _NOLIBC_INTTYPES_H */
-- 
2.17.5


