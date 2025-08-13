Return-Path: <linux-kernel+bounces-766739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B419EB24A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8510F17A31C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0D2E8DE4;
	Wed, 13 Aug 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovQEElHk"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E82E7BB1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091380; cv=none; b=X2vaOLfC2NsmDamwO+J6PqIccpRwOAIqEflLCVrFvVp11NMwaEYX/EKRTS/86dLjNKzKe3vMKE/8plKNlyrpbnafDMHT3N1/Cky3JeFnoD58WHhKcannb2k69dhzyJdQMd43uSpiwxuIqclV1siuoNwQ+uoAi4iBwvUWs7sKcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091380; c=relaxed/simple;
	bh=oAiDcLOTD2+MZmZR8DSv31qXF27wRMPdpljc9p2/9jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyoA0xGWxR2wrvvb6T7yiEWOaF8pK0Bzib3xCGd4E4EobGadUmCqJSiXPMHgHLgXvYMnx+xEz4snH7+0NcZ03/paiW9XulSMffYv4xrWk1J8rmxKx+c1p7aQkh9IC4O0rYZNxMuhe0/BHclrt/2bmQPJk6bo5MAcBxfvaVyXFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovQEElHk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755091374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45fqKdYmp0Gh9Q1rZbSUa2JM9MyO9jH489AeOdoZo5E=;
	b=ovQEElHkMK9yUzl7Hu8i9s2ql8l0kjxsd/rlgGmGwH5zJB2Q2u1470k+pD1sLfMB7E+sxC
	dcRNT1qPc6LEljr/5UYlkGgpU/aRd5Hm50zVwtsuqvsUSEg636V8m91XTVbXUpSLtZk+W+
	dYvswEZQ0oRYuS58JdSdP5j0dXxkJaI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Petr Pavlu <petr.pavlu@suse.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] params: Replace deprecated strcpy() with strscpy() and memcpy()
Date: Wed, 13 Aug 2025 15:21:59 +0200
Message-ID: <20250813132200.184064-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() and memcpy() instead.

In param_set_copystring(), we can safely use memcpy() because we already
know the length of the source string 'val' and that it is guaranteed to
be NUL-terminated within the first 'kps->maxlen' bytes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use memcpy() in param_set_copystring() as suggested by Petr Pavlu
- Link to v1: https://lore.kernel.org/lkml/20250810214456.2236-1-thorsten.blum@linux.dev/
---
 kernel/params.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index b92d64161b75..b96cfd693c99 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -513,13 +513,14 @@ EXPORT_SYMBOL(param_array_ops);
 int param_set_copystring(const char *val, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
+	const size_t len = strnlen(val, kps->maxlen);
 
-	if (strnlen(val, kps->maxlen) == kps->maxlen) {
+	if (len == kps->maxlen) {
 		pr_err("%s: string doesn't fit in %u chars.\n",
 		       kp->name, kps->maxlen-1);
 		return -ENOSPC;
 	}
-	strcpy(kps->string, val);
+	memcpy(kps->string, val, len + 1);
 	return 0;
 }
 EXPORT_SYMBOL(param_set_copystring);
@@ -841,7 +842,7 @@ static void __init param_sysfs_builtin(void)
 		dot = strchr(kp->name, '.');
 		if (!dot) {
 			/* This happens for core_param() */
-			strcpy(modname, "kernel");
+			strscpy(modname, "kernel");
 			name_len = 0;
 		} else {
 			name_len = dot - kp->name + 1;
-- 
2.50.1


