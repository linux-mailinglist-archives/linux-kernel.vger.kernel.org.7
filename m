Return-Path: <linux-kernel+bounces-827875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74EB93531
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0FE1907103
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD362F548E;
	Mon, 22 Sep 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F89G2gDk"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79B27F011
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575141; cv=none; b=tApLMywTgpiACn9y+s+d1HkCwiJ3LXiTIjHzYU7kGn8CDkzZZoCQ9wYNVaXWnBSzOBPxvd5EE+BsEwC+pO7KaT0OMqcs+q+X3sr8GMJ+zysCeeyMS2kRafkHbxQ1JTKyZgZzb0Q6/15K+usgAZnsPBe6kVFr4MJla9eHpWo9hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575141; c=relaxed/simple;
	bh=rwLqPxmOBruycRjBQ9i1fCOtBWlJI0v0bWB3fUOU5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1QGTL+Q5nJqJKJCQxyHiULi7BLv0BvTxq2yv4R65Y/a+GKeLv0qRHDFjTdHAc1ynRZCBuoG1HRuaJ8NQTAJQr2uJUey0Pm86DksjmKXKBaVxjL1SgZ2JD4hhWIgDxja/SadQh9aJiwrG1fQjv2da65vA0YFoTpzqFXxPJho35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F89G2gDk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XwWsws5dYIHiCnlZKvcgGQqxLqmlp0j+/eNhlPV+68=;
	b=F89G2gDkkFU+nV0Zb/z9LBP+wBy7w8chM8MC0DhNZWs7ejAoG5MV9VN4MOE9QYtYMBYYZN
	9rh8DcBomKbE69EGDnKISTIWDy/la1/IJQ4OtuoMwZx1IU0o5wLsxPLSfOad69XuT1mKXy
	8thCQADhukI0YK6S5lDwB8VP6S4iO3M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sparc: Replace deprecated strcpy with strscpy in prom_nextprop
Date: Mon, 22 Sep 2025 23:03:53 +0200
Message-ID: <20250922210408.1723452-4-thorsten.blum@linux.dev>
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
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 88793e5b0ab5..7388339bbd7e 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -272,7 +272,7 @@ char *prom_nextprop(phandle node, const char *oprop, char *buffer)
 		return buffer;
 	}
 	if (oprop == buffer) {
-		strcpy (buf, oprop);
+		strscpy(buf, oprop);
 		oprop = buf;
 	}
 
-- 
2.51.0


