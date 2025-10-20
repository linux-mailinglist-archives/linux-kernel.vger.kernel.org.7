Return-Path: <linux-kernel+bounces-860153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93EBEF702
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4B044EB79E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EC2D6E5C;
	Mon, 20 Oct 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GHUXRNU3"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8532D63E2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940958; cv=none; b=U4lGzTQCO2c+w9z1f/C//7NTdChy5ppLF/r9GGIc5F7rX5CKzObkAtxtEbMkS/O2mo8wsVn7lqi6LMPUGiD4SY/O9lPDDY4xuXQ9US2xt6Sqp04fvrpWnTESFnoPXqQlc0Ih+DF30zy7mBFrZ12d0TrOOd+VJUcsn2b6fPmjCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940958; c=relaxed/simple;
	bh=Rgz3Y5pXJ9n9DrMkvgBo8BWrgR9nt1pIy4jO8BFxqmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KBSnCW5/aEMV1rG8SKBUgIwKmni6a7LCNLTRcPQxjecmpsOW77c8DYoZQQmhGMeAkfxbTlSoVfyRQEncBqlpvVzLXFzVroK8oMOyoV3RT1fiXUzMiiTwBmch39PWwyTpPGdzi7KURAqPq2SHeo1ozQBzvSVPeecf9Vavh2g8t3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GHUXRNU3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251020061548epoutp0406ff8085dd40510135e2e6534c95edfc~wHnaIWQNW2229222292epoutp04g
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:15:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251020061548epoutp0406ff8085dd40510135e2e6534c95edfc~wHnaIWQNW2229222292epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760940948;
	bh=/Q9e3cHwrKgOLlhQHOAGp81EcArCjRSpKLpYqUoUdHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHUXRNU3QTFlaN4RWst6xTLUVtV3t0HNlSPlTJseDZcak04ZP/e0Xn+Lwp0+F9YuE
	 kYv5V+n8sgLRzzYSTCdq4eRc2a7scn9Efq/uYDJ8E4SusUubEG+CNDaCkwOJem+GGu
	 Njj0G7vqOOXxuJjNUglKtM4Vx5BP2FozeabL65Y0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20251020061548epcas1p3c053444b82166bce0a218f1548a79f9e~wHnZyp4b43170431704epcas1p3u;
	Mon, 20 Oct 2025 06:15:48 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.193]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cqlY00wtlz6B9mF; Mon, 20 Oct
	2025 06:15:48 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251020061547epcas1p1e29c99f288c488e6a06d39948aa13062~wHnY-4PAn1379313793epcas1p1c;
	Mon, 20 Oct 2025 06:15:47 +0000 (GMT)
Received: from wkk-400TFA-400SFA.. (unknown [10.253.99.106]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251020061547epsmtip1da76d55b41540e1d07eed71f1fd9c513~wHnY7BHbr0607206072epsmtip1D;
	Mon, 20 Oct 2025 06:15:47 +0000 (GMT)
From: Wonkon Kim <wkon.kim@samsung.com>
To: bvanassche@acm.org, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, peter.wang@mediatek.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wkon.kim@samsung.com
Subject: [PATCH 1/2] ufs: core: Initialize a value of an attribute as
 returned by uic cmd
Date: Mon, 20 Oct 2025 15:15:38 +0900
Message-Id: <20251020061539.28661-2-wkon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020061539.28661-1-wkon.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251020061547epcas1p1e29c99f288c488e6a06d39948aa13062
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251020061547epcas1p1e29c99f288c488e6a06d39948aa13062
References: <20251020061539.28661-1-wkon.kim@samsung.com>
	<CGME20251020061547epcas1p1e29c99f288c488e6a06d39948aa13062@epcas1p1.samsung.com>

From: wkon-kim <wkon.kim@samsung.com>

If ufshcd_send_cmd() fails, *mib_val may have a garbage value.
It can get an unintended value of an attribute.
ufshcd_dme_get_attr() always initializes *mib_val.

Fixes: 12b4fdb4f6bc ("[SCSI] ufs: add dme configuration primitives")
Signed-off-by: Wonkon Kim <wkon.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9a43102b2b21..969f3a23bf92 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4273,8 +4273,8 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			get, UIC_GET_ATTR_ID(attr_sel),
 			UFS_UIC_COMMAND_RETRIES - retries);
 
-	if (mib_val && !ret)
-		*mib_val = uic_cmd.argument3;
+	if (mib_val)
+		*mib_val = ret == 0 ? uic_cmd.argument3 : 0;
 
 	if (peer && (hba->quirks & UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE)
 	    && pwr_mode_change)
-- 
2.34.1


