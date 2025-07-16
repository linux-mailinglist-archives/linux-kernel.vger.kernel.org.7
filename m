Return-Path: <linux-kernel+bounces-734281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56002B07F69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E9CA47436
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FD24293F;
	Wed, 16 Jul 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MywjAst7"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC601FECCD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700699; cv=none; b=UAJ6j+wRb3kTqNxAeY3HYM1yZllRv8lzNOe90hnrbeZ28Wj4f5wMEpE6AGPRJEz31vqPvFLwLEH+ioNG9b7OIunQeDReYcmdBYOFrZYBBY01o2hNdwLitkFJ2PCqigq5/VhhotOQJfmDE1ETNDRu5+uH1JVRxjgegFKVNLRKJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700699; c=relaxed/simple;
	bh=wWqokGDMHBDhwGPIbUEwk+JQC46/td8MKpkyDnKaPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dtqts9z8vOks9lNYIv8rN6aXA54wQSmjYeq2kWGm6zlJN10HbO3/GMwSBaiZneA3yfDjyTEMVUVoMMjtzwzweuqlVtfgDqvvs9d1vAnBpfX2VWJGoF6zSf9U1qWTVae7qXCKaJJ+IYOKDltE17nlmoTWDuvWSoLY84f7UucSx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MywjAst7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752700692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SIYYCveydZN/yS9B5/K7xi00iELlTOe8UHhKrMt4XvI=;
	b=MywjAst7w1SPwR+9c/oPuvPoK7/klNjKu1PzTWQLK1tM5GvbXyD7pQiyNY/GSAioLLwEVU
	9PO/OJbyjboPc5g1Uc6PdsY42S2GFuE6/yXXb15xiAwYNlAQsvEudiNWSGumpLAfkJNt1A
	7xSUBjWxLbZ1LQznJaqBlJgs7cKwQhE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha: smp: Replace deprecated strcpy() with strscpy()
Date: Wed, 16 Jul 2025 23:17:22 +0200
Message-ID: <20250716211724.277212-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..56155b988b9c 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -262,7 +262,7 @@ recv_secondary_console_msg(void)
 
 		cnt = cpu->ipc_buffer[0] >> 32;
 		if (cnt <= 0 || cnt >= 80)
-			strcpy(buf, "<<< BOGUS MSG >>>");
+			strscpy(buf, "<<< BOGUS MSG >>>");
 		else {
 			cp1 = (char *) &cpu->ipc_buffer[1];
 			cp2 = buf;
-- 
2.50.1


