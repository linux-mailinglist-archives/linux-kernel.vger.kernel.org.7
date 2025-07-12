Return-Path: <linux-kernel+bounces-728722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A65B02C43
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CDF1C212E3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE01289E33;
	Sat, 12 Jul 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XtxDZtsV"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21776F073
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752342357; cv=none; b=L/DgkQrQswDNgtrw39mgPCs6+54creXPapIHZTETUkjdyyiGv1/+brhqk/WnszuVig++twbOPrT0WYgf8MuQFKwB7z6JgQgJBEfgAgL+j4KGxjmdlQCskgTJbM3wa96TME6bwqhdyQ5PcGoFIr98t9gi1vpYIKhZTdydKiBqq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752342357; c=relaxed/simple;
	bh=n8HUZzo1OJLdG4wq6ZqJWTJ/71erpcZChgFuWnLNhKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f81eqvbC3gCiA1lZo7wfIhWitrNnYNUWwXEr8An1Q3SvR1+5iArrJNE5REb88nGsvGV7U0RYu268GQCNagU+iTq9KfeVYcxq2CZ6rcbrSuMtm7cNQkcHYvLSU7iBG59ofQt19uHx1abXl2VKH4BNEQaumXVE2w4llOUq+UW4s/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XtxDZtsV; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752342352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gkr8r0QuwQ/K0o6snVmFv/O7s4jysL7xreXy+VW3z1A=;
	b=XtxDZtsVXnvz5WUP2s/t71iis/PCcaW6DQE+JzdQ6NTnx1y7bJie9RBWd6DAYwYLi488LU
	Ot7+aGJyUKHWtuvspZodYuY9GFyMTB+eZXpOx8wqBoymk7PtiMXAJOAGyaJDoNUU9mUj69
	qX4DnAZBsy6uiGUL4+0UV0Av7v7UkX0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memfd: Replace deprecated strcpy() with memcpy() in alloc_name()
Date: Sat, 12 Jul 2025 19:45:17 +0200
Message-ID: <20250712174516.64243-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

Not copying the NUL terminator is safe because strncpy_from_user() would
overwrite it anyway by appending uname to the destination buffer at
index MFD_NAME_PREFIX_LEN.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index ab367e61553d..6f4db997b955 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -401,7 +401,7 @@ static char *alloc_name(const char __user *uname)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	strcpy(name, MFD_NAME_PREFIX);
+	memcpy(name, MFD_NAME_PREFIX, MFD_NAME_PREFIX_LEN);
 	/* returned length does not include terminating zero */
 	len = strncpy_from_user(&name[MFD_NAME_PREFIX_LEN], uname, MFD_NAME_MAX_LEN + 1);
 	if (len < 0) {
-- 
2.50.0


