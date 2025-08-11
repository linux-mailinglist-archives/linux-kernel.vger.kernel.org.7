Return-Path: <linux-kernel+bounces-762181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC0B2030D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351913BADF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237EE1FC109;
	Mon, 11 Aug 2025 09:16:40 +0000 (UTC)
Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A794414
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903799; cv=none; b=YM6PoEO5pSNIEgtD94zerYDcP7SagbaQa0rBl8QZkmZS8SP2woUsGO44OKdkvYSLYPJlvoqAN+lNaI9apAD8V8v87T0s9TCsiahdW+VieufXpmI7ZsoGIxSzYdORmU+DTVNUp9t8KIhNrAdqALCVNXr/hmQjKKRPL72n5DulidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903799; c=relaxed/simple;
	bh=BFsYVD8rf6QLrjeviFb8yqUMUVWxi09UIoPpd6S/ZiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTLCgzld2LRwolTtu0RPF3Up4duFW70144hfoqZ0E7htaKNUiwxLgAo9ocZ2WSxj2zeShVPcd3Zv08q+Gfgf08tGzEDIr89ChnJ9cFpa6xCyIg5BbYEnwSLokiUWK1x0GopO1JnlodX8wr125hN9gNVuf+rc8EFBkt1aXtIUAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4091:a240:8387:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id 3C59E4A018D;
	Mon, 11 Aug 2025 11:09:15 +0200 (CEST)
From: Florian Schmaus <flo@geekplace.eu>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux/export.h: Fix a typo "cam"
Date: Mon, 11 Aug 2025 11:08:42 +0200
Message-ID: <20250811090842.141421-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the comment of ___EXPORT_SYMBOL(): it should read 'can',
not 'cam'.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 include/linux/export.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index f35d03b4113b..07239c566caa 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -25,7 +25,7 @@
 #endif
 
 /*
- * LLVM integrated assembler cam merge adjacent string literals (like
+ * LLVM integrated assembler can merge adjacent string literals (like
  * C and GNU-as) passed to '.ascii', but not to '.asciz' and chokes on:
  *
  *   .asciz "MODULE_" "kvm" ;
-- 
2.49.1


