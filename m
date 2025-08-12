Return-Path: <linux-kernel+bounces-764908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BBB228A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A63A23B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723F27FB26;
	Tue, 12 Aug 2025 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DaePAfMZ"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8D28152D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005280; cv=none; b=BEMj8IcluSFTNsVR8FWxaaxBEnQiUUQStX9Erw/emEq60P4JTy4kUf+5vuGoW4FDtHHbloCP+AII4rRi3v0uxoTHS2BH23zKUB9O6tMwzItWCBJYfsigQdIz/rYKQAsFZtIoTt/fnqMHfavWiFKgu94RuxHKFiKSqx3tKrVQSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005280; c=relaxed/simple;
	bh=uUQekeSvKTsCb7oOO+EoYwxc2+w8LsYYt2YRxgpULUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uilb9afVdPH//nS8fXD4OmVshSBwiw1piRziuyFQ8U7yOHb24SlcdKQ+BoJBfmKM7nVy7kbq7nSDIsx/S25dbKc81UVQQTtx4EbPxSZ2N88Y7Oh4cU4tf4CiBZXA8IuQXH/D2Na5fUTl0Jvk6Q1LnwthU1+w/kURBgO5dgEoCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DaePAfMZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755005274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYA302zJcMdsKk1KdP3gy61mJzhYwbPixdUGA0jPcRs=;
	b=DaePAfMZeHLDRsZ6v8S3bAZXf3PUGab484s2kCgPraf42WOLmShkCGa93atMyHJXjhMby6
	jQwLDX9rVMgM6ytfMsK4jcpm+j4ZpA26RZd1igeoJGiwhRfuXuW5F3qohW4ItjZSDdNyM7
	lHND/061G3VNRDgFxTXAvgFh9ilbReA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
Date: Tue, 12 Aug 2025 15:26:20 +0200
Message-ID: <20250812132621.119641-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated and its behavior is undefined when the source and
destination buffers overlap. Use memmove() instead to avoid any
undefined behavior.

Adjust comments for clarity.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use memmove() because of strcpy()'s undefined behavior with
  overlapping buffers as suggested by Doug Anderson
- Compile-tested only
- Link to v1: https://lore.kernel.org/lkml/20250811170351.68985-1-thorsten.blum@linux.dev/
---
 kernel/debug/kdb/kdb_io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120c..b12b9db75c1d 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -714,8 +714,8 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 		 * it, depending on the results of the search.
 		 */
 		cp++;	 	     /* to byte after the newline */
-		replaced_byte = *cp; /* remember what/where it was */
-		cphold = cp;
+		replaced_byte = *cp; /* remember what it was */
+		cphold = cp;	     /* remember where it was */
 		*cp = '\0';	     /* end the string for our search */
 
 		/*
@@ -732,8 +732,9 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			 * Shift the buffer left.
 			 */
 			*cphold = replaced_byte;
-			strcpy(kdb_buffer, cphold);
-			len = strlen(kdb_buffer);
+			len = strlen(cphold);
+			/* Use memmove() because the buffers overlap */
+			memmove(kdb_buffer, cphold, len + 1);
 			next_avail = kdb_buffer + len;
 			size_avail = sizeof(kdb_buffer) - len;
 			goto kdb_print_out;
@@ -872,8 +873,9 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 	 */
 	if (kdb_grepping_flag && !suspend_grep) {
 		*cphold = replaced_byte;
-		strcpy(kdb_buffer, cphold);
-		len = strlen(kdb_buffer);
+		len = strlen(cphold);
+		/* Use memmove() because the buffers overlap */
+		memmove(kdb_buffer, cphold, len + 1);
 		next_avail = kdb_buffer + len;
 		size_avail = sizeof(kdb_buffer) - len;
 	}
-- 
2.50.1


