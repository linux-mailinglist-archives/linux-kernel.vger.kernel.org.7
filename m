Return-Path: <linux-kernel+bounces-737381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E080AB0ABB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2601E583B37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7F21D3F4;
	Fri, 18 Jul 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnUUOWvI"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737196FB9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874864; cv=none; b=C72u5/sPqSpbh+xv8qt01EyvfUxS7uu8BGB30waLAwGtLKg/fCIHe1YG+2fku4k405vW7H48logrRqe7BbEm6Dwr25syBPiBbjhgcHWX1sl3vO9Gcx2AGiG8Z6HGxsREmYiJ8PI8l+3jdAzA5slhRz5kBHLL0IdnfiWq9rm2WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874864; c=relaxed/simple;
	bh=9gJN4BCqjjG8aHuP8cz+e/BgvZIZ8eMco3DyItys3J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAwFNVC4Ybnhb3e5Fgcuic/SJWay55E7tR2qqocKBeedloG1slyKkCtr7z+iCVvhu8lUjmwMkio3mbk1Yqnnj+19d08+Xm59hBJikOMplfDVlbXxPCxiztEpvPYskM4u7Odv556C6NQGfNWqCD6retpeueIC7PBjUSur7LXKfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnUUOWvI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752874850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QW4XK89RatdkYPZUcwlE29jtrnSLNj8LxMNSgYJVlUE=;
	b=WnUUOWvIiqT79DilmC/4FeC66HxD8L2uIH6N5+l5Au73TYHMtJ3hIpETNvOZqcjRpETe2e
	uezxaGT8ul4ttAhLabiOvBDDH00pL2RoginFofQvqKAyo3DauvCH2iYruBDTI0xwwgDJ2R
	e+5Z1zGCYsT9+HFw5iNlvlPtCHQeBdc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhang Heng <zhangheng@kylinos.cn>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
Date: Fri, 18 Jul 2025 23:37:23 +0200
Message-ID: <20250718213725.348363-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_support.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 05b137e7dcb9..158430a890b6 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include "kdb_private.h"
 
@@ -250,7 +251,8 @@ char *kdb_strdup(const char *str, gfp_t type)
 	char *s = kmalloc(n, type);
 	if (!s)
 		return NULL;
-	return strcpy(s, str);
+	strscpy(s, str, n);
+	return s;
 }
 
 /*
-- 
2.50.1


