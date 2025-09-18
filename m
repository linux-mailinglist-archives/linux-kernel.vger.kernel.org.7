Return-Path: <linux-kernel+bounces-772601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC091B294BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04FE4E845B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C76304985;
	Sun, 17 Aug 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nLtv3ZDa"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF91DEFD2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455900; cv=none; b=geRo8AJ7vazedXYBBzComQj6hEDcS8/X6byWr5iDFyBZJlI/nnXefE8sH23+fKYibELOTggolsGiv2p3JYhyz/civOGUfSt4XfItd7v/+zuRkIn90S2EZo+rttVt4Y5m4WpFRcJUZDMAMlA9AL3vTM44GyW8CLwGgoAhLJWrGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455900; c=relaxed/simple;
	bh=Q9w2dCNrA4kN8NRY/GY5eP2WjQuULGCDcQMAqKmWWtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2mZgv7IKTnyhlkzE1HlgiwLQm1nukmbUtPOo07feWzNuchHI0XlPSVs6Xg4kZiFMaC5leRgbY1EFKKqvHACpcL+5KypbYKxfmFTiVESrUEpTDA2rhTtcG8FZ1ns4Rdlq6OkgluUkBInmejyrZlOq2csANq5xQe50oezN8hDl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nLtv3ZDa; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvWt0RDVFqFeB1/WkPHZHsZh3V3kNmKNbsztkF5HYPU=;
	b=nLtv3ZDa+HH1AeZZCr3K+IXWtLU3C2XeBHoX7rhQCprcfeWHfLxdd6E2IFzCHg6Zh0scwd
	3pIMsOSpun3o/ov81YpFsEhtO+ZxzVSvg9+5XlnyCIR/1eTa3zUkcJD5/JKDtK3hxgQ0g0
	lhbigfXMHiVlKzoNVwFSOrLVhsMglYw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] MIPS: arc: Replace deprecated strcpy() with memcpy()
Date: Sun, 17 Aug 2025 20:37:15 +0200
Message-ID: <20250817183728.612012-5-thorsten.blum@linux.dev>
In-Reply-To: <20250817183728.612012-1-thorsten.blum@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
warning.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/fw/arc/cmdline.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index 155c5e911723..86b0e377b713 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -42,12 +42,13 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
 {
 	char *s;
 	int actr, i;
+	size_t len;
 
 	actr = 1; /* Always ignore argv[0] */
 
 	while (actr < argc) {
-		for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
-			int len = strlen(used_arc[i][0]);
+		for (i = 0; i < ARRAY_SIZE(used_arc); i++) {
+			len = strlen(used_arc[i][0]);
 
 			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
 			/* Ok, we want it. First append the replacement... */
@@ -57,8 +58,9 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
 				s = strchr(prom_argv(actr), '=');
 				if (s) {
 					s++;
-					strcpy(cp, s);
-					cp += strlen(s);
+					len = strlen(s);
+					memcpy(cp, s, len + 1);
+					cp += len;
 				}
 				*cp++ = ' ';
 				break;
@@ -74,6 +76,7 @@ void __init prom_init_cmdline(int argc, LONG *argv)
 {
 	char *cp;
 	int actr, i;
+	size_t len;
 
 	actr = 1; /* Always ignore argv[0] */
 
@@ -86,14 +89,15 @@ void __init prom_init_cmdline(int argc, LONG *argv)
 
 	while (actr < argc) {
 		for (i = 0; i < ARRAY_SIZE(ignored); i++) {
-			int len = strlen(ignored[i]);
-
+			len = strlen(ignored[i]);
 			if (!strncmp(prom_argv(actr), ignored[i], len))
 				goto pic_cont;
 		}
+
 		/* Ok, we want it. */
-		strcpy(cp, prom_argv(actr));
-		cp += strlen(prom_argv(actr));
+		len = strlen(prom_argv(actr));
+		memcpy(cp, prom_argv(actr), len + 1);
+		cp += len;
 		*cp++ = ' ';
 
 	pic_cont:
@@ -105,6 +109,6 @@ void __init prom_init_cmdline(int argc, LONG *argv)
 	*cp = '\0';
 
 #ifdef DEBUG_CMDLINE
-	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
+	pr_debug("prom cmdline: %s\n", arcs_cmdline);
 #endif
 }
-- 
2.50.1


