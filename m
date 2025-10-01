Return-Path: <linux-kernel+bounces-839332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FCBB164E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86527AD7B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DDE246BB0;
	Wed,  1 Oct 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="UCgvachp"
Received: from mail-108-mta150.mxroute.com (mail-108-mta150.mxroute.com [136.175.108.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AD255F5E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340773; cv=none; b=QCDaJunHbI7SiNAiZD50m1sd75MDecXUgnFebOMiIj8R55StwK2SpBfxtQL7EKAt4+NCNv0u888I4jaBw3EWQtMU3rcbiZguo8/PA4GBV9F/RJ/g7faLJbaGXUyOSPHGIF1YevfeEGWIvuU95rgI0+pzAspiULSEOAQmh7acXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340773; c=relaxed/simple;
	bh=V+0RfMc13pU9sXz70TO/SBQVzumbK6+xUlPgaNJGl1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+5dbeW8i91liWiG0/iXBcGGMg/duteD3jBQC05P547P//EPzxnlyQDExgi4cGSKa0BppuOKmCR8r27k8DYFByIGLx/MgLP+VT7LPPhuIIH1JWZhWNfMtsMHZAS2qYi2QLu6JScQvS4qfoPHzM3JVJeywHUzDT1i5hrTMkTpges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=UCgvachp; arc=none smtp.client-ip=136.175.108.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta150.mxroute.com (ZoneMTA) with ESMTPSA id 199a0dcf55a000c244.007
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 17:40:59 +0000
X-Zone-Loop: 4f5e342f4f31c7c4a267a1f4fcd8dec444654862fb58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=hoIW32l8l2CA10UawaxGUDZZ3ryQVt2DmqS2qqsErkQ=; b=UCgvachppewH
	KcuHiUc49Wzeu1JsD8QRVbYuscd180aMM1LU5eEsRx3nIMw1X1dBK7IUn94ZGbGusUU2o+/IY2WTj
	FedTaOPtJ4hsY/SHPSJ5H9HPwRwObtV2PnzkeYZZnQ0kPaKk9WkFa6EV8ygZwCoFpe5wOpHjaT8eB
	WHPjeKOyNnYALwLWm6vSoiBHzxKMTQVdR4ddJSkn/Kp4nArlnIVDU5HDjHbAW0zcdLgn9oiGftNJU
	rpjbB9QmmTbQh3QHJ+0LWWw6OhNx+1DqnwSCxBIN/WhfTMUNMAbRmHU6phr0uFllZ+fLV5AHIbaEV
	VuKc5gACy4ZJj5vuhtFZQQ==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/extmem: Replace sprintf with snprintf for buffer safety
Date: Wed,  1 Oct 2025 19:40:55 +0200
Message-ID: <20251001174055.192401-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace unsafe sprintf() calls with snprintf() in segment_save() to
prevent potential buffer overflows. The function builds command strings
by repeatedly appending to a fixed-size buffer, which could overflow if
segment ranges are numerous or values are large.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/extmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 0bc8746b6192..b6464a322eb1 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -601,6 +601,7 @@ segment_save(char *name)
 	snprintf(cmd1, sizeof(cmd1), "DEFSEG %s", name);
 	for (i=0; i<seg->segcnt; i++) {
 		size_t len = strlen(cmd1);
+
 		snprintf(cmd1 + len, sizeof(cmd1) - len, " %lX-%lX %s",
 			 seg->range[i].start >> PAGE_SHIFT,
 			 seg->range[i].end >> PAGE_SHIFT,
-- 
2.51.0


