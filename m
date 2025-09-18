Return-Path: <linux-kernel+bounces-774217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31930B2B003
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3BD564C69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894132BF53;
	Mon, 18 Aug 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dpr3Q1uw"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9132BF3E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540830; cv=none; b=tE2XblvjcMvnmiWON3gGgpq04PVTHyVYIACk42eP8WZ1QmkQIrNbKh6wDcUbAea5Q13OotB45B2YeTdGJFus9O4BLPROBLGjq2YY1X3TtPmty/dGfVQ9smWJxMbblT59qwR3hbNU5kzDYkQkLn77ospQzqXkUnUYy1TQTBUkxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540830; c=relaxed/simple;
	bh=bqXFZLZv8TYeMB0kUtgvPvy1BXOCfoE0cc6WZwtPcZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDkt0diJ/yOgOaTxOJzGjCesvE6iFL0m81EaDPWFaGn6Kdo6bEJgeJLej/lgaavEDk+GYWcs0hI2+F/7hJJa88miKy092rMffc53JinJE32hJiGwAhwpJPQqnOtyOGwBBsEPYIwMqEmY0DrfREfOMs2b0hBnZ/+dQD9UqtZe2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dpr3Q1uw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755540825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPBPoszorfQb+WmqrsH8eN2n08yL5TCak5Kl/DltLUE=;
	b=dpr3Q1uwoHrV+wiO/81jSVX/FMK0s8vdYZ4qMJur+mwzlOUp+cAeXou4s99wONs8/60d/W
	8WyIQFTyWVEIdlwz99Xi4Y5IOUbL9c0b1HtijbKI0DqlfYnzpNj608HAmGAxLVZd9YCkmN
	KmCyRV/OhaIZRmu8cGW+PKKiImOROcM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Justin Stitt <justinstitt@google.com>,
	Martin Hicks <mort@sgi.com>
Cc: linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
Date: Mon, 18 Aug 2025 20:11:42 +0200
Message-ID: <20250818181153.661431-2-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-1-thorsten.blum@linux.dev>
References: <20250818181153.661431-1-thorsten.blum@linux.dev>
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
Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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


