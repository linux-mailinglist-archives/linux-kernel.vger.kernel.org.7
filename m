Return-Path: <linux-kernel+bounces-827878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A68B93540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5108E1635CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2253176ED;
	Mon, 22 Sep 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="igowVKHz"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FB2FD1D3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575144; cv=none; b=fOSBuHpnxSFaoCCQnlHWNQQF0pjGCrjHUtPiEbliyKVYaVlfJWXa0JYwfgpWDaKlAhztC7/DhkcpiTUh1VJwQU4GqRlkBVaCgQuBHVyctjF9Yl47gcYhzmH+nZH6V8DVi2L5C7q5Sz78URW7OgO7PdYzulp6oRHBsfT9iTBVYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575144; c=relaxed/simple;
	bh=oC39NfVUWwvvI/zQNDG8D91R4fALtH0YHHVbll5Qkwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcVyaewvOhORhlZvwIpxzZibfCoGt9TcWZyKfYJLTdOGnsw8mfyMIOKvIqUoqUxG8aRYp8OV9DoqsqB8tYAwnahRyYe380Sn8nzai0HJ4zbgWk7rFTsX5wJwqID8YUITkqtDGk0Gdjzab8rR1F9jAxKhxautdVLQ2XFY66AxguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=igowVKHz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbQwBC7sCLtYutAoFwa4DNZySkR4ZwbW6QFT+jNgFfg=;
	b=igowVKHzDYXxdtTBgm5OFUP+MitrliTk/xXdqo2TGqC0VRqCYCQO0qnh4XB07IVxM3JqAI
	0gCts4OolWF1xJSZRpHQzZrsdYi9+sIpk4jf5F17HnqSgT/0ybO0JSVP1pnJeXW7Nl+sQG
	8anJMsZbxx6cZ4Nd0vMPMkVi1d5N/Wc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] sparc32: Replace deprecated strcpy with strscpy
Date: Mon, 22 Sep 2025 23:03:55 +0200
Message-ID: <20250922210408.1723452-6-thorsten.blum@linux.dev>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/prom_32.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index a67dd67f10c8..cd94f1e8d644 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -187,14 +187,16 @@ char * __init build_path_component(struct device_node *dp)
 {
 	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
+	size_t n_sz;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, name);
+		strscpy(tmp_buf, name);
 
-	n = prom_early_alloc(strlen(tmp_buf) + 1);
-	strcpy(n, tmp_buf);
+	n_sz = strlen(tmp_buf) + 1;
+	n = prom_early_alloc(n_sz);
+	strscpy(n, tmp_buf, n_sz);
 
 	return n;
 }
@@ -204,13 +206,14 @@ extern void restore_current(void);
 void __init of_console_init(void)
 {
 	char *msg = "OF stdout device is: %s\n";
+	const size_t of_console_path_sz = 256;
 	struct device_node *dp;
 	unsigned long flags;
 	const char *type;
 	phandle node;
 	int skip, tmp, fd;
 
-	of_console_path = prom_early_alloc(256);
+	of_console_path = prom_early_alloc(of_console_path_sz);
 
 	switch (prom_vers) {
 	case PROM_V0:
@@ -297,7 +300,7 @@ void __init of_console_init(void)
 				prom_printf("No stdout-path in root node.\n");
 				prom_halt();
 			}
-			strcpy(of_console_path, path);
+			strscpy(of_console_path, path, of_console_path_sz);
 		}
 		break;
 	}
-- 
2.51.0


