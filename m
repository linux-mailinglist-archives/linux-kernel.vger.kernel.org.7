Return-Path: <linux-kernel+bounces-881827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF5C2903B
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F06A188D83A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82851F3D56;
	Sun,  2 Nov 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="wPLoqYzf"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9634D3A0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093562; cv=none; b=ix2f7LwsHYSYQSjjCRWN2iFSZ9LyUv/x0XxuAeLGIxzV8r1BkisZSktKF8Nj09yBzT0OWJQDMMjyiMjy/mjQtV0WjX3VAYJFsz5D1bGSOZ1tc6H3xVpVIWivVjpsSCPrwl7WGiWjOzdadAhyhCrfMAo7cmMSfMb7sFrUXRgZexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093562; c=relaxed/simple;
	bh=74TN6lGuQf/vT6BZxqArP749yrLOuZ/r/G4NSgVLkpA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RF6aFdc4H1tHWUPc9E5ba8xhuSxn1x9fnxHpBZ4oKk42KS+pgI4U8qo7lh/UWbdtRI9cboNr3o4G6jQEZX1q4aTS0cFn8Laq6K+8zEKe6IDBWC2OhkMw7uWETLrb8b/NOlOs6hvxfgwpzNOrEKHh66YQogDPZOoHM8p9WQ6AUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=wPLoqYzf; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762093557; bh=Pvt5fc2DWTiodjtOiDQn3czdC9FarPA1n6gr3AKGLdI=;
	h=From:Message-Id:From;
	b=wPLoqYzf330Jvlxz4WdDp3apk4yir69aVcWzn6muj+LjyWyJwOJj9aBCa6g4PnHun
	 NON9FGTlQsRo+nOyjmU5ir/y8+5Ln0nv4N+UPiEUfBPBUQ5DvquZfierDbGi6bOuSK
	 xBN/TH4+KyEWrtzmaylSJf+aKTMehO01LCpLVFaQ=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id ECDA9C06EE;
	Sun, 02 Nov 2025 15:25:56 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2EPufB015524;
	Sun, 2 Nov 2025 15:25:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/2] tools/nolibc: clean up outdated comments in generic arch.h
Date: Sun,  2 Nov 2025 15:25:48 +0100
Message-Id: <20251102142548.15482-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Along the code reorganizations, the file has been keeping the original
comments about argv and envp which are no longer relevant to this file
anymore. Let's just drop them.
---
 tools/include/nolibc/arch.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 426c89198135..0871c439be7d 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -3,15 +3,6 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-/* Below comes the architecture-specific code. For each architecture, we have
- * the syscall declarations and the _start code definition. This is the only
- * global part. On all architectures the kernel puts everything in the stack
- * before jumping to _start just above us, without any return address (_start
- * is not a function but an entry point). So at the stack pointer we find argc.
- * Then argv[] begins, and ends at the first NULL. Then we have envp which
- * starts and ends with a NULL as well. So envp=argv+argc+1.
- */
-
 #ifndef _NOLIBC_ARCH_H
 #define _NOLIBC_ARCH_H
 
-- 
2.17.5


