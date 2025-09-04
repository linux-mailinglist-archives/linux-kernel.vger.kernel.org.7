Return-Path: <linux-kernel+bounces-800692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A5B43A99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA0A54E5784
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF102FC869;
	Thu,  4 Sep 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wweGs0AU"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15732F49E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986286; cv=none; b=SKRgHDSfjPi469Q5FDONBxHxjsdticcg/5UvvgSW+1H/9svxoGP7hO2g5zBr9CY1slNYkCtXmbHa6mckYHZLUctfJTs+yCiRaj+ZC/7CwJmxnSNJc6Wq96mG4IXkcmss+8JRrM99PzSlAi9Zny2h2znTvvfRm+rLjhWN1mBu0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986286; c=relaxed/simple;
	bh=0SvCWsO/EmvjlGbOFiORpjpydwP4uAT2dCEsnnP9ucs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWf1eC0VgUY0cz5AR7novuDopErBl1dnLU2QuyrkomkVP/diUy9gUF30hNiHYtbTgUaBSgRk/C1E61EBnYuwK9hABqmtHNFhdwly0tmjb0prOKCk2hDUWCwIlSx/Hm4tdrhPavnRL6hSZUqF2a3cSKIQA17dS17h4280SG6mEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wweGs0AU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756986282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q/KBYixzTNLwvMvXGKgDgIGZ5IDJw9DNQGrVTgunH3k=;
	b=wweGs0AUebeqWDuIXbrUfaztEzaBXqwZKgzvD9tEzukR4rG7iVduRG/rZI3pCt9cBMc7I7
	VuxCO7tImsH6ZaAthWrWGjRZaXIv4LLBmzetxsZSucLPBKkRzMz7S5rtfYl40UYZY+RTsv
	6eKfxX36SUZhHK+1R5QKpRASX3YVN/k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	"Bill O'Donnell" <bodonnel@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Joel Granados <joel.granados@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Wei Liu <wei.liu@kernel.org>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/debug: Replace kmalloc() + copy_from_user() with memdup_user_nul()
Date: Thu,  4 Sep 2025 13:40:29 +0200
Message-ID: <20250904114031.353365-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
improve and simplify debug_get_user_string(). Remove the manual
NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c62100dc62c8..6a26f202441d 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1416,18 +1416,12 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
-	buffer = kmalloc(user_len + 1, GFP_KERNEL);
-	if (!buffer)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(buffer, user_buf, user_len) != 0) {
-		kfree(buffer);
-		return ERR_PTR(-EFAULT);
-	}
+	buffer = memdup_user_nul(user_buf, user_len);
+	if (IS_ERR(buffer))
+		return buffer;
 	/* got the string, now strip linefeed. */
 	if (buffer[user_len - 1] == '\n')
 		buffer[user_len - 1] = 0;
-	else
-		buffer[user_len] = 0;
 	return buffer;
 }
 
-- 
2.51.0


