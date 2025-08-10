Return-Path: <linux-kernel+bounces-761608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBFB1FC72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749C31895BB6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1E21C179;
	Sun, 10 Aug 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jIe3SHNS"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C14AD2D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862383; cv=none; b=JGhsqUDXo768bF6LgVQGx+KtmOuhrYaY3uOlmPAP/saqzqbOeZlEJNbSgot15UaglHcIrORxY2eH80GL0Ft6hjSVXDkJDdjMZPczz+QranXPYhJk27W2nZi/NbIdPCmY8VIIxTRNarS6kt/WsfJ2XGeMhTJp4yQEbHUCDQpGcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862383; c=relaxed/simple;
	bh=3lb7CNWXWj/0lVz3lq5IWv1xf83j7ci93bPWMzEtKn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/o2JBXArQn7zBGI8WvMqhAyyKTeku3e2nb5ls/7q1On7+uhjw4eIt/rgzscbpdXmurIqEyLo/jvE49m/ALD+qLPBDkJv3THXeuvZ53WQ8OV2Dt+rTPWmHXhtdFMmxhDpT4PsD7Yr7wAc9Gv8l30uSy/aKY5iMxN6+ubu0YTIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jIe3SHNS; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754862378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KJWYSmh0vtV383XJHV8tlONMgw6pZPjQQlSlvf2Ndis=;
	b=jIe3SHNS8yF6IVW4KdU540++UJBWMNwSHbjl439zZJKO4NYzUv53LNEJAnI7iR+rfy839U
	o5ZpSQa0lR195AhfRfpw1u/Z7mgmx9Gc0A/m69VZB0j+WoZ47pVCTIvZMzu0IzbyAyTvT9
	TGE4EcRpRkehtEW3oClM3KIAH6qeNK0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Petr Pavlu <petr.pavlu@suse.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] params: Replace deprecated strcpy() with strscpy()
Date: Sun, 10 Aug 2025 23:44:53 +0200
Message-ID: <20250810214456.2236-1-thorsten.blum@linux.dev>
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
 kernel/params.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index b92d64161b75..88765f2d5d56 100644
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
+	strscpy(kps->string, val, len + 1);
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


