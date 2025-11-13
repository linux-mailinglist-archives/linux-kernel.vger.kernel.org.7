Return-Path: <linux-kernel+bounces-899398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D37ADC579C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 386EC344150
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0426351FC5;
	Thu, 13 Nov 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcQzanlO"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E386352
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039931; cv=none; b=GwsMSU7rAbyl9gLUwRorz8HxBJ4+ooNskOb66/6vvU5ZvOBz8LkA6tS0UGTEg/se+ZpSckO/jtSA9g5fW31bPh/fhS2kIhe6dc3p203d2NB42tc8T/LkN4Etk08Skgda7K5V1uoeS9l9cveJFE7ISpT8Lat9Fx4DSgnkAS5CaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039931; c=relaxed/simple;
	bh=BBpsJqxEP7v2OZJUgVFcvfvGE7g14MC4OgCuCg6mXEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkduDX8dUibLB/TGbeB99KJm5qPY6sDITjL6ptEOoUAPGaFdCp+rHpDAHS2IwnTCJDbwexhMv59E/fJ7bEIkvpSiqE9lMWOVlRw06Dn+QVZ4/v3f0Js4wftrUaJxekPCn53kUHGG0BYH26J+z3tgxra/j3iYNrembAVRa0ENSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcQzanlO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763039925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tLLBDb3sXKAaGvQ1VyRAnDZc4+anqcIji71QoAU2NI=;
	b=dcQzanlO/lJIJYmPY+xye8IcI/QJizffTHZpygExQyRaOVROhPs+qXfck5LxaOGqCcHkc6
	+EJ12GmNF9e+ILnPWcK+VgdFY/c1lBUMu+Hhqdnry00mcx5lCNAwAh1kjt2G+quPkWK/b4
	3/0D2uGO3Ib7Qdm2XIOAg9/gQ+2q7aQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace deprecated strcpy in devt_from_devname
Date: Thu, 13 Nov 2025 14:18:33 +0100
Message-ID: <20251113131834.45852-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strnlen() and sizeof(s) instead of hard-coding 31 bytes.

strcpy() is deprecated and uses an additional strlen() internally; use
memcpy() directly since we already know the length of 'name' and that it
is guaranteed to be NUL-terminated.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/early-lookup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3fb57f7d2b12..5c30a0cc85a0 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -155,10 +155,11 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	int part;
 	char s[32];
 	char *p;
+	size_t name_len = strnlen(name, sizeof(s));
 
-	if (strlen(name) > 31)
+	if (name_len == sizeof(s))
 		return -EINVAL;
-	strcpy(s, name);
+	memcpy(s, name, name_len + 1);
 	for (p = s; *p; p++) {
 		if (*p == '/')
 			*p = '!';
-- 
2.51.1


