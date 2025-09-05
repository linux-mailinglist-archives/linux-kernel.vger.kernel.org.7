Return-Path: <linux-kernel+bounces-803666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64105B46380
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244495A7878
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1ED33E7;
	Fri,  5 Sep 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kHuJkxbn"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A381DE89A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100123; cv=none; b=CauUjRtw9eh8ZXWz+EPQYamjpH0EEwaReXQL9+CTCSYD6dGSwYxTCBDV6KbQhRuQW54K4cU/daL8AOoHJy/zdvEs/Ea6rwD0Xg+jOTNVj1gVFmX/LjvAJU479Pxz0VlQ8AogVR1BaJz0Ero8A+YhakzSj0JGwxnLo/ZLskRjt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100123; c=relaxed/simple;
	bh=b56PyGhSnpNehYj6T1uMpp+w6UN1jN6CXg65rEyxeJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izluahPlSKTVIr2TOPrc7Pn3Q/EkJ+LyH7UsGDCE5MBE0+MladyqhEhun2kadJ3YP7EojOLIoo/gLNG6+Qz1unqF/kCAhjyQYpDC1woyRjAmU90kWDC+itkv6AJOZSk8OG99WaeoKcCtYBTe91TyVIJgcE6bsPxieD8RAjDVD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kHuJkxbn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757100108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pkHeOlPdETL+hOiJxj40JWxkGH5nYJc3pWzCiTMWFoo=;
	b=kHuJkxbn5aslX+Zb/pLJs/nh2LGXYLdEnJKKVehgS/i/Py87oGfiuSK6wZRNNMSPrfhC57
	MY1FkJtBFsO6yMyE7uPm5fepGrwsHEUd9DDj1jRja1pK0c2LIosJDpZtorYAM6gYSV1wUB
	bEPLZ6N6zbgVKLnvjFAn+i6w/dPaMNQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Fri,  5 Sep 2025 21:21:17 +0200
Message-ID: <20250905192116.554018-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify osnoise_cpus_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/trace_osnoise.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..dd97f6bd03a4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,12 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
-	buf = kmalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
+	buf = memdup_user(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.51.0


