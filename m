Return-Path: <linux-kernel+bounces-863054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C96BF6E48
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C06C5026D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC783396E9;
	Tue, 21 Oct 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDg8Arzp"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47133396E4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054636; cv=none; b=DR9R6rYqyPV1pFOAtHCiRXLRpnDOb7/DjEocdtBCBUAtYSiB6vVEc2iBve5OWxyiJ1otDmmbT4o0qiDb9LlogY7e29WuKeLXZvrLHR4w0I2zcDD2N7YgqR4cZBwG2hXBKPa3VcqxllDM1t+SjXotwwCr0J9oAUAY4L2Pil3/ROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054636; c=relaxed/simple;
	bh=Sr4Av+iUizAbkAzVgC0+qp07lfSDuC+NomoeUiykcW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9arNKZ4qZU3df7kUZC0Lo1vT5RnIgrKJOzXOU8nF0X8Akhjc2mOq42CkvXZsYj5wnnzqCDuw5qpt2JU5MAaAw0LjpIJgYgc3z9j7rpy802y2xzxJ/mHTzYhwUcAZHdFg5YmKT1ema/90gDeoiieb29A8c1zjqcBYIGJfwL4PAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDg8Arzp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761054633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xNqnht/v7r+E+ltgWbTdV/aRGJGim2ZUKdxu9dFf+lI=;
	b=pDg8Arzpu3AtNFSqHOUAcGfvodbeXkuXnFX6VcvHp47TmBb/4LwlLAYyIl8+JtUBi0ij1B
	JiCiRe57bYeHRRyIn6OUPhK8Gs0UcKKiPclQt6PijkFhHIuCBwwOHVCJ/edPrtDJaJCd6r
	V/EoUPlP0ds6CqUeKvf9WCHFnQlYK3M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/xen/xenbus: Simplify return statement in join()
Date: Tue, 21 Oct 2025 15:49:58 +0200
Message-ID: <20251021135002.1228-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Don't unnecessarily negate 'buffer' and simplify the return statement.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/xen/xenbus/xenbus_xs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 528682bf0c7f..7c6c12925326 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -407,7 +407,7 @@ static char *join(const char *dir, const char *name)
 		buffer = kasprintf(GFP_NOIO | __GFP_HIGH, "%s", dir);
 	else
 		buffer = kasprintf(GFP_NOIO | __GFP_HIGH, "%s/%s", dir, name);
-	return (!buffer) ? ERR_PTR(-ENOMEM) : buffer;
+	return buffer ?: ERR_PTR(-ENOMEM);
 }
 
 static char **split(char *strings, unsigned int len, unsigned int *num)
-- 
2.51.0


