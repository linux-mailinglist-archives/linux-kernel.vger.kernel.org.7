Return-Path: <linux-kernel+bounces-775357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF3B2BE46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82FB7AF31D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577E31E0F5;
	Tue, 19 Aug 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggGxeLq7"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1E31987E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597592; cv=none; b=VUn7f7jd81O+6V5C2zzSW53wF0/dFtmqBEmnDiFZQeC848X2VsYpONe7vlNJo8Ttm2MkQXEXZgPEP2wHowJUDFwRVZ+K/pnWzvwgGzgZHn07ELEQM4DNaVnIOPm+hJLkRAPIZso9X2nmh6VpW+9B3oNK5ncoZuoMhXq9tuLchME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597592; c=relaxed/simple;
	bh=bqXFZLZv8TYeMB0kUtgvPvy1BXOCfoE0cc6WZwtPcZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJqd1U4Ze5O+ywPlnb0TSjg6/ZWC6f2q7xg67NPO/fFQkJ7FQI7/0iie1y/XSyeAKpZhncuGlvrWxtU4iGj9Nxkc44KMvanrv+62xAXJ5OdRn493X8RMbesZu1TEq3jOD7P2p8NR6f+Bfu/zfhOQfBV8tSF8pRIkcUAejoR5cBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggGxeLq7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755597588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPBPoszorfQb+WmqrsH8eN2n08yL5TCak5Kl/DltLUE=;
	b=ggGxeLq7hUwFNbCu2Pb2WC5kNL2bIPd8NkuemVG4VzzoGDnggLnZlPLGC0qCdubZziCRGx
	SVKV2BcCwL/T03uQ3ulg/MY67sjE/f2TC0rQgzyNvCj1puHHS3iWEB2vlxGuuHXFo3Q9Es
	yK8F7ykf/a290ub6zSlvCt9SNpb0tGo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Martin Hicks <mort@sgi.com>
Cc: linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
Date: Tue, 19 Aug 2025 11:59:04 +0200
Message-ID: <20250819095915.711085-2-thorsten.blum@linux.dev>
In-Reply-To: <20250819095915.711085-1-thorsten.blum@linux.dev>
References: <20250819095915.711085-1-thorsten.blum@linux.dev>
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


