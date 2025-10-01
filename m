Return-Path: <linux-kernel+bounces-839294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F929BB144D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177F54A2167
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F18287254;
	Wed,  1 Oct 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="dn2qdvHS"
Received: from mail-108-mta73.mxroute.com (mail-108-mta73.mxroute.com [136.175.108.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390627AC54
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336900; cv=none; b=N9ZrlrYj9l6KYqJQR4ecQsyGKQNmJZQFumXw5Q7fy3ghqlHH4WY1GRzhHVryyas7Q/cfMu4RpnSEzOO1Er4fP5/KasP6egkhhGUNvc1TnZkhXREuV/Vt/L/tOIyOmhoDtKystj97dmzBgCeLJ9IEqejF45syVaLQqsV6rTv18ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336900; c=relaxed/simple;
	bh=swqdbT4jab/ALeaUUe5hxevREAFBu9sSDetdj/EqHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIh3pOuJzMqHLYF9El+hSvnQok59OdZCdHHGnG4rnfOBr3KFu8QnDx0DTctxY+24Mq2kb2uT+W7RQDib5Ps+mEry1tGOJjxk/SDZy83NrAO72Uoqnfp2H+yu1vZmESbcBfrqaaRpK+EP7XqLYyDwCOdNaCgl8tmQlRL0rtCgLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=dn2qdvHS; arc=none smtp.client-ip=136.175.108.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta73.mxroute.com (ZoneMTA) with ESMTPSA id 199a0a1dbec000c244.007
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 16:36:26 +0000
X-Zone-Loop: 0ef523989c7ad31b36a423ff8c5562b72ed5a8b45b4f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=SmRueyWLp08d1J7X5zA7xIae/GZpHWZua3Wla6Pf5CU=; b=dn2qdvHSMctm
	SRjpStl6TdBIzwPfAE8IkSwQ5DXHRzSzuDBvA2N/2VUPdlnL38keEvli9YzJaIulKTSFf3/EfJTLJ
	lu3pfFAS7upFRbFjD1JlTMQUSw/El//bORea5cA1uKm314sjtJZngO2BZnvbquzPft9UXZjmkgYOS
	MDxglMInHIgYLGZMUhUhoob+Ro8bndzWbU1eS3kvEq1NcD7oIvXhbMMKWEP3b9x7CT+D4XhO9svdD
	a4IGguQe5HoRElRKWqY8Fxc73ppJnuvjGBt7aIuRcWX1LSamMCZRH7BgqruT5hYcNz2+X0PogNAhX
	/3E7MxXxP+9zMyTLyAtmQQ==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/cmm: Replace sprintf with scnprintf for buffer safety
Date: Wed,  1 Oct 2025 18:36:22 +0200
Message-ID: <20251001163622.164143-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace sprintf() with scnprintf() in cmm_timeout_handler() to prevent
potential buffer overflow. The scnprintf() function ensures we don't
write beyond the buffer size and provides safer string formatting.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/cmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index e2a6eb92420f..eb7ef63fab1e 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -321,8 +321,8 @@ static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
 		cmm_set_timeout(nr, seconds);
 		*ppos += *lenp;
 	} else {
-		len = sprintf(buf, "%ld %ld\n",
-			      cmm_timeout_pages, cmm_timeout_seconds);
+		len = scnprintf(buf, sizeof(buf), "%ld %ld\n",
+				cmm_timeout_pages, cmm_timeout_seconds);
 		if (len > *lenp)
 			len = *lenp;
 		memcpy(buffer, buf, len);
-- 
2.51.0


