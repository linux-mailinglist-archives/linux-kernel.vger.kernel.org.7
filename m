Return-Path: <linux-kernel+bounces-891555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41428C42EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5E188D5A9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB641E47B7;
	Sat,  8 Nov 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hk+y3vZg"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4E1FC8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762613857; cv=none; b=luVT4iCoxqioUYrIJ9X5cswFUd8l1IRb7LHzD//25EMP32BYe1T1p6CDSATb5Kya/wzaE4+nWc1UjfErobJEL+2EhVEPb7UffeiJyBS0FyVrBSxUMceH1oAnE18m4Vh1+2lEbMDf2vYiOd51fYTpMnUjhinVkeWPNrOn8Guo4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762613857; c=relaxed/simple;
	bh=9xG33c5hbKQopH0CAV0Bn0I3IvIDemsAuYVKtmP6i7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPxlrNUj8cn3UgFISBaj26W6kCpZCZ8KL9fdUpFdpS1u16B/dsTcI2xKNT2vqWXdD0k6R8IMDUEJARAhT4ayyGOCtCHNtF2uilB2D2YParFnlJN/ZPHtg+L1JzPzrTm0aZQhlhepY4/WRrvMzbDWfJUlquZA7EJZfIQ65r5xgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hk+y3vZg; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762613852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eF83UrrqufcAO5fdD9HeFwWyXs7e6m4eqdJQzQl2LxA=;
	b=hk+y3vZgpvqCd9e5Wbs/aQ0g7Bm+r8iEYQfWVKuM1o+aY+FSCp+YXoRnuUOZaEb8PrWBBF
	mIQ9EGTQ8rmebv8zAT3RxsW8qR/xSccYIM9A4qN/hMMmg5auO2p4ab6w9zvhusMkSG9ZcR
	eBJJxJpi0W1ugbzE4EvbW2C1u1XMSus=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: zstd - Remove unnecessary size_t cast
Date: Sat,  8 Nov 2025 15:57:07 +0100
Message-ID: <20251108145707.258538-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() instead of max_t() since zstd_cstream_workspace_bound() and
zstd_dstream_workspace_bound() already return size_t and casting the
values is unnecessary.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/zstd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index ac318d333b68..ff21cab382ba 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -38,9 +38,8 @@ static void *zstd_alloc_stream(void)
 
 	params = zstd_get_params(ZSTD_DEF_LEVEL, ZSTD_MAX_SIZE);
 
-	wksp_size = max_t(size_t,
-			  zstd_cstream_workspace_bound(&params.cParams),
-			  zstd_dstream_workspace_bound(ZSTD_MAX_SIZE));
+	wksp_size = max(zstd_cstream_workspace_bound(&params.cParams),
+			zstd_dstream_workspace_bound(ZSTD_MAX_SIZE));
 	if (!wksp_size)
 		return ERR_PTR(-EINVAL);
 
-- 
2.51.1


