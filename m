Return-Path: <linux-kernel+bounces-844362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F7BC1B05
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D392634FAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B9213E7A;
	Tue,  7 Oct 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AealL7oq"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D1189BB0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846791; cv=none; b=ZGKDo8dASJ8NONT7TEz9h+olMink04W6d+wbe/PijjwD2Vgsb3dLuN+I/XNhDaS3bkawaMrSAODkAO2aIFuSmRMOBsaCr74pywJI7NgUlnhYxslD2/7icsTav+qCBzY/BjXbbHqAF4lOrfC9T+mj/rwR4FizufffTH/KD0xPjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846791; c=relaxed/simple;
	bh=qb9S6p6BSPuPyiWGx9zNnwR1agJIZ18Pok86vtrLQHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERZGFGvEV/xCLbv0QWwnTs4QyRapzL/iQGK69kOkDojnkSMqeg+/ovXUaIHMwoF+sUmeclacEkpffX9RApENxPkEGBeut2gu9SoeDogDioSEomMl3HFhz5Ch8pGeCSkOL/UV4bZMRBVoWSHbldGu+QPqdk4pvRp5ODyZltmfrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AealL7oq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759846785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6suQz5WzIz9+U9FFWaCDcwSjFxvIbWZ0QfKfsFShpSU=;
	b=AealL7oqMOOr90eO+hFWynNR0ox46KU+M9uJ2Af+XYQWffpuzjdLVjFFCtphYNKIKLT3iq
	/271N/jwNLwdecc7tJ94H+hChLaC2Us2gzM+2qLaA5X6rKV/dKc99oMuaSQtMih6bq8JVB
	yHJsEBHXy5XzDtO7J0cLDXc3Z3y8Ay0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/vsprintf: Improve vsprintf + sprintf function comments
Date: Tue,  7 Oct 2025 16:19:06 +0200
Message-ID: <20251007141905.202067-2-thorsten.blum@linux.dev>
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
2.51.0


