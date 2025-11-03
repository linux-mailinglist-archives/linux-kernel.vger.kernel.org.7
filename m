Return-Path: <linux-kernel+bounces-882539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A8C2AB08
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8E7189237A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA62E2851;
	Mon,  3 Nov 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2fvqZZX"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A612E6CA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161031; cv=none; b=bqO/JMC3QlcHOdF1nM/UZTANkRXdZxpsmgtrQ40P0fLiy7SSxNHoTPlyOuvyNygLnJV4gZsfLA2EsPrn9RXPuaWXZxmZNuli9La3ML23GF/SGWp+I3BLVJKWltTcScRIWZckGs50HakzdrnRGj7RxRZknhV5o6U9G9QVWP/wNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161031; c=relaxed/simple;
	bh=1buZ8h84dAA2gcXxsEX/89KKbmocaeM1EKoIkbwmzYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3+U3NUZhO3j1NsaWAPq5YU4JGtpqpKFFu5seM21Pc+bDk0axY89zSEuxnPX2+EOBwfSUH+1Hz53+C/h4fR3Z8EXph4svs12pf0hBdbvWiagf9k+ghHk9fKd9gDuQk207C6qMWZG9zPtMgqTRLbu4pic0VkA6BnxwuA2zc42j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2fvqZZX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762161027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EE8PBMsMvxhhU7cRQzvpmoXuvh9ZBdxL+Dm6tbdYYvQ=;
	b=X2fvqZZX42QcJiAQEsnX5XacBS1Fl+awG+7S7GXPh/vFqpN+pXvrj7nT3wfMNZeVTwEegk
	sES6GfIeRueYDHBXXG9uqikCA+TPZIkh2MnfAB6KFgRDHwixmaABFKptUti9xgk9/DEvpj
	C+ukGgvnwXp21nXlASOAKWjldDYys8g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] lib/vsprintf: Improve vsprintf + sprintf function comments
Date: Mon,  3 Nov 2025 10:09:13 +0100
Message-ID: <20251103090913.2066-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Clarify that the return values of vsprintf() and sprintf() exclude the
trailing NUL character.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/vsprintf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index eb0cb11d0d12..e49f350ee549 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3054,8 +3054,8 @@ EXPORT_SYMBOL(scnprintf);
  * @fmt: The format string to use
  * @args: Arguments for the format string
  *
- * The function returns the number of characters written
- * into @buf. Use vsnprintf() or vscnprintf() in order to avoid
+ * The return value is the number of characters written into @buf not including
+ * the trailing '\0'. Use vsnprintf() or vscnprintf() in order to avoid
  * buffer overflows.
  *
  * If you're not already dealing with a va_list consider using sprintf().
@@ -3074,8 +3074,8 @@ EXPORT_SYMBOL(vsprintf);
  * @fmt: The format string to use
  * @...: Arguments for the format string
  *
- * The function returns the number of characters written
- * into @buf. Use snprintf() or scnprintf() in order to avoid
+ * The return value is the number of characters written into @buf not including
+ * the trailing '\0'. Use snprintf() or scnprintf() in order to avoid
  * buffer overflows.
  *
  * See the vsnprintf() documentation for format string extensions over C99.
-- 
2.51.1


