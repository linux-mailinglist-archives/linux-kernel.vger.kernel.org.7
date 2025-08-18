Return-Path: <linux-kernel+bounces-774220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA2B2B007
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718217B1F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074B2D24A1;
	Mon, 18 Aug 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRMKiFUr"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA212773C5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540837; cv=none; b=q2inttbXk78KCdo1zBaDNnDE3LVUeIm6UgasXbNGFbWqHrMcqeJTyurmY7MuNQkNW95WYGogv9lguIq4O6TRWHOO0ybfynSN6PeL1h4QZTD8jIhG+PPn7PNzuDQeqEl5iYCQthyUYTyvIhJnn7y81dmZaA2LtIz3u+P/JYa5ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540837; c=relaxed/simple;
	bh=Vhlp670jIoJlZ3xHQzXSWtWPJcSriIWz20Lo5ruwtIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db8FPEZMB3P5JrimNLT7PN7e8x+UyUbL/V8FTP/EIwsW8H8KE+jt/0b4GhD/Ztz4U90m4Bf+tcQaHRocutEaPopdYN/zmJdbAY3FCmSBAlS8U1WpdJ70EdafoDh5/yUhCnne0g9c01nlYTgavtCfD6QfPYXwslLZ9WjY66Eu7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRMKiFUr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755540823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zavKxT3WRsPMSCRKqhVeovVHLiznL9SJiEUmezaibh0=;
	b=cRMKiFUrzrwk0xkdc1bJ+8av3chXjVF950LPMwAf1YtF+rPW/1Pb8pq3mVXwElNPjs4qWf
	2gRnF3stPIC6wExoiaI/NGcb4c7fM+X55vzk8zBWVSVaV9KUUufJmN453CBBmzv6J0RdD/
	J+WU3kAFcKDleev5bR9u6ieaG00y/LU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Zhang Heng <zhangheng@kylinos.cn>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kdb: Replace deprecated strcpy() with memcpy() in kdb_strdup()
Date: Mon, 18 Aug 2025 20:11:41 +0200
Message-ID: <20250818181153.661431-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_support.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 05b137e7dcb9..d36281142fa1 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include "kdb_private.h"
 
@@ -246,11 +247,12 @@ void kdb_symbol_print(unsigned long addr, const kdb_symtab_t *symtab_p,
  */
 char *kdb_strdup(const char *str, gfp_t type)
 {
-	int n = strlen(str)+1;
+	size_t n = strlen(str) + 1;
 	char *s = kmalloc(n, type);
 	if (!s)
 		return NULL;
-	return strcpy(s, str);
+	memcpy(s, str, n);
+	return s;
 }
 
 /*
-- 
2.50.1


