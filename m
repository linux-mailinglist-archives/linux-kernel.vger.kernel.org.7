Return-Path: <linux-kernel+bounces-881367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE6C28167
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 088D04E7B6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2821ABB1;
	Sat,  1 Nov 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XXuyroy4"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0560B8A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011363; cv=none; b=ndqMhcNC1+dcXqVluTUiXrfr5tq9GGNLx/z836Js+O5btc8m6feC7ffJt1fnQoInYCZe28FSesiC5Cx6cMIJIzRbp138DiDe6mUmgj8iy6q3bqpfSwwrcSULervnkFQ01l3TgHsUV7sMpS9m34FBgRZO8GK/VmALEyF2YZ0QkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011363; c=relaxed/simple;
	bh=d/Vi6umW296mUYSX4hNzCMgSwp/SLgfcmcKnoswc5Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mehOKr1H7aDsKQNvBObHPDXunf9lRfhir4FWz3e7OL/5j2RRM4rWwAeyqGrEmvyBksho879Hp+u9z2dbgdrsKcCMM5WX5aO1QtQfN8lZMvTuvvN6ZQbmjvXkBunujyqKeZl2tFSnBPveLGdDlsVQuOeao8QQfDJCFSIXFPFaDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XXuyroy4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0c
	Ur8pYzuWRmcI+WIvUB5HLHJAPKHIi3okUSE03VhJw=; b=XXuyroy4GKTVq7M5nd
	uc8+R4KVpDuMSntHoOdff99bGuCR98dOXdN6zNmbQXgWA4LvTGc6YUv/hO3hisAw
	rzh2zIUynSxM0W8UtJsCsczenyW9Dkttyj5HSae6TVF2zieT9vKeUp6SP89bUl/i
	u8pgpQgQLv0QdAxNydRKd3GlY=
Received: from MacBookPro.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHd5+rKAZpxWMyCQ--.37795S2;
	Sat, 01 Nov 2025 23:35:23 +0800 (CST)
From: cestbonchen <cestbonchen@163.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	cestbonchen <cestbonchen@163.com>,
	syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix invalid glock target state during withdraw
Date: Sat,  1 Nov 2025 23:35:03 +0800
Message-Id: <20251101153503.6019-1-cestbonchen@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHd5+rKAZpxWMyCQ--.37795S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3uw4ktw4xuFyfZw1xGrg_yoW8XF48pr
	y5Wr47Ar4DKaykXw4UKanYkw1kWa95Gw47CrWkX3W0yan0kFyxXr42g3y7ZFWDJFZ3uF45
	WF1a9F1ayFWUWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTBTrUUUUU=
X-CM-SenderInfo: hfhv3uxrqfxvrq6rljoofrz/1tbiJgT4wGkGGzHSMwABs-

During filesystem withdraw, do_xmote() may set the glock target state
to LM_OUT_ERROR when the intended target is not LM_ST_UNLOCKED.
However, LM_OUT_ERROR is an operation result code, not a valid DLM lock
state. Passing it to finish_xmote() triggers a kernel BUG at
fs/gfs2/glock.c:674 due to an invalid state transition.

The correct behavior during withdraw is to force the target state to
LM_ST_UNLOCKED, which safely invalidates cached data via ->go_inval()
and avoids further DLM operations.

Fix both the general withdraw path and the -ENODEV error handling path.

Fixes: 669d4eb0b918 ("gfs2: Clean up properly during a withdraw")
Reported-by: syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=f9cc39ae87e4716a6309e8f5d558432cd90035ac
Signed-off-by: cestbonchen <cestbonchen@163.com>
---
 fs/gfs2/glock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e19aa2e820c8..fb08660567ed 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -696,7 +696,7 @@ __acquires(&gl->gl_lockref.lock)
 skip_inval:
 	if (gfs2_withdrawn(sdp)) {
 		if (target != LM_ST_UNLOCKED)
-			target = LM_OUT_ERROR;
+			target = LM_ST_UNLOCKED;
 		goto out;
 	}
 
@@ -719,7 +719,7 @@ __acquires(&gl->gl_lockref.lock)
 			 * been unlocked implicitly.
 			 */
 			if (target != LM_ST_UNLOCKED) {
-				target = LM_OUT_ERROR;
+				target = LM_ST_UNLOCKED;
 				goto out;
 			}
 		} else {
-- 
2.43.0



