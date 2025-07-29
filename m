Return-Path: <linux-kernel+bounces-749364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF2B14D68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CA14E0BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559129008E;
	Tue, 29 Jul 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GcZbTlCq"
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FD28FFC6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790668; cv=none; b=EhuzhuHg43I8ZdphHdVtZCHQIsStS+leCfjWNTy7Krd8B1XuqXSRw1B0MznTIidtBUtr1s0W5cjWFSjwDMNEXy+yPfrzxmFWCxYtfaiVGb4NJisS2IRqDvyYWo9iYps4hxcnYk56jGgTcrUtT32DWR/hHlWVnvh7Y1NQpwL+Vcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790668; c=relaxed/simple;
	bh=huMRB3PDMgX/+TDHTUI5IC4lbXtgdVwI7kNDwUhL4vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSAc3m1QLmu0kWPRdRqE29Wa6EAmCwfoTZC1qoiT3+vNFM8Afm9CQ5AmJ2mHiH8SHgmJ58rTrOt6osXJtnZl4QAEddKY8b/Kj3okw4OqOXoghfiWu/WhrO6ITHIcIzkpfrcAMgeElOqlASJEoBQHUNJNzqG9ESc8wg8eHw7Vljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GcZbTlCq; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 69DDA85A05
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:59:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:35a3:0:640:2206:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id E24EAC0065;
	Tue, 29 Jul 2025 14:58:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wwX6KCGMJCg0-tLHjVR8P;
	Tue, 29 Jul 2025 14:58:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1753790339; bh=TYmXHyl/57pTARUsH1w7NyJlmGIUqlnXKBUO09P3It0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=GcZbTlCqgqc2yycnqkdXFU1UmM0pkwwaRZjnupCsvpOrWx8d6m0ypS4g3ImZP1sMj
	 0tS/z4Etc7sRUdr/h3bAl93dMp+IXpgwf8id0n4ooezh0J5yeuVCWsbYS3WrMiF6yU
	 zrEexuKZnXWtMqpVP12EXYd4/9Ags8qgXfpsWr/M=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] objtool: speedup detection of noreturn functions
Date: Tue, 29 Jul 2025 14:58:39 +0300
Message-ID: <20250729115839.1002232-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running over KASAN-enabled vmlinux.o, some functions comes from the
sanitizer runtime may be processed by 'dead_end_function()' a lot of
times, so it's reasonable to record the result in 'struct symbol' of
the relevant function. Briefly testing over huge 'make allyesconfig'
result, this may speedup objtool by nearly 10%.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/objtool/check.c               | 22 ++++++++++++++++++----
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20ef1db1..21997f1846d8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -236,6 +236,9 @@ static bool is_rust_noreturn(const struct symbol *func)
 		str_ends_with(func->name, "_fail"));
 }
 
+static bool dead_end_function(struct objtool_file *file, struct symbol *func,
+			      int recursion);
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -313,16 +316,27 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 				return false;
 			}
 
-			return __dead_end_function(file, insn_func(dest), recursion+1);
+			return dead_end_function(file, insn_func(dest),
+						 recursion + 1);
 		}
 	}
 
 	return true;
 }
 
-static bool dead_end_function(struct objtool_file *file, struct symbol *func)
+static bool dead_end_function(struct objtool_file *file, struct symbol *func,
+			      int recursion)
 {
-	return __dead_end_function(file, func, 0);
+	/*
+	 * Some functions (e.g. comes from the sanitizer runtimes, like
+	 * __sanitizer_cov_trace_pc() or __asan_report_loadN_noabort(),
+	 * may be examined a lot of times, so it's reasonable to record
+	 * the result.
+	 */
+	if (func->functype == UNKNOWN)
+		func->functype = (__dead_end_function(file, func, recursion)
+				  ? NORETURN : REGULAR);
+	return func->functype == NORETURN;
 }
 
 static void init_cfi_state(struct cfi_state *cfi)
@@ -1359,7 +1373,7 @@ static int annotate_call_site(struct objtool_file *file,
 	    !insn->_call_dest->embedded_insn)
 		list_add_tail(&insn->call_node, &file->call_list);
 
-	if (!sibling && dead_end_function(file, sym))
+	if (!sibling && dead_end_function(file, sym, 0))
 		insn->dead_end = true;
 
 	return 0;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 0a2fa3ac0079..ebf930e42736 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -65,6 +65,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	enum { UNKNOWN, REGULAR, NORETURN } functype : 2;
 	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
-- 
2.50.1


