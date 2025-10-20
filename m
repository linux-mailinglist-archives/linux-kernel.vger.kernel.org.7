Return-Path: <linux-kernel+bounces-860162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE49BEF775
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D4AF344217
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E42D7803;
	Mon, 20 Oct 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/4kR761"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E272D6E5B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941391; cv=none; b=fl/TtjDVhzp6K6F6OyFETEMHZyRt4GxI7QiMcMxus+Feao1vlMXVuq7hARkuzovGeAzgx5di8UiOfdIM3Uy3WUIyXbvDjbaCNTFxedBuqoSavPVAaOILsF2vSgpMv34pnE9cfVtRGt8VuMVIRnAHCNIX6s4JVaijM10nkhp6SFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941391; c=relaxed/simple;
	bh=uepXkKb6qvK7HJBiysgv37hIpJkktVcO8/vOidz+5O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=q81kkQG8pZfXP+pmQ4/gf33mcw23oFcEjrgMiSIybHY5MgMxmez7Ybre7Cy8BMyX5ZIUBZwn0Bz6N7FAAGp+1bWx7LS/AGmrd/c9+SCcoei9zq+31KgE4QIeTIyssaygI11GRcjSIOCuMf1YdrAYvs4MU+6Qb/RJjRiMlzl0TPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E/4kR761; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251020061550epoutp024a8fd529848985b1a5c25dfbd35738e3~wHnbWoieo1510715107epoutp02j
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251020061550epoutp024a8fd529848985b1a5c25dfbd35738e3~wHnbWoieo1510715107epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760940950;
	bh=hW7qwDGQjpe+PuA7vU505Mlh7QwmDZfm4uTkDtfFvwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/4kR761d9Gai9tnUyzA28Cm7SlKYn42lfGc63youxgv/u/aUdYns7aiGoHylFZm5
	 VZqt2CTYtHmiLIL4TSqeyeg2bZbeJApzV7Q9N61hQu24lDnJBpB0yambXTaVy39saT
	 4JI6hIrypuTARQk4IAZbnsq2ga2DQ3B1wdXzUF9U=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20251020061549epcas1p40d574bc802eb229bb3d2007c67558143~wHna9-rGf0184801848epcas1p4h;
	Mon, 20 Oct 2025 06:15:49 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.116]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cqlY14Cd3z6B9m9; Mon, 20 Oct
	2025 06:15:49 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20251020061549epcas1p4c66e9194e947d624ca7560e68f3f2c53~wHnaeblHi0184801848epcas1p4a;
	Mon, 20 Oct 2025 06:15:49 +0000 (GMT)
Received: from wkk-400TFA-400SFA.. (unknown [10.253.99.106]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251020061549epsmtip148a07f257723c7d8e349f6fbfadaa981~wHnaYdyTQ0607206072epsmtip1F;
	Mon, 20 Oct 2025 06:15:49 +0000 (GMT)
From: Wonkon Kim <wkon.kim@samsung.com>
To: bvanassche@acm.org, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, peter.wang@mediatek.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wkon.kim@samsung.com
Subject: [PATCH 2/2] ufs: core: Declare tx_lanes witout initialization
Date: Mon, 20 Oct 2025 15:15:39 +0900
Message-Id: <20251020061539.28661-3-wkon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020061539.28661-1-wkon.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251020061549epcas1p4c66e9194e947d624ca7560e68f3f2c53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251020061549epcas1p4c66e9194e947d624ca7560e68f3f2c53
References: <20251020061539.28661-1-wkon.kim@samsung.com>
	<CGME20251020061549epcas1p4c66e9194e947d624ca7560e68f3f2c53@epcas1p4.samsung.com>

From: wkon-kim <wkon.kim@samsung.com>

A value of an attribute will be initialized at ufshcd_dme_get_attr().
There is no need to initialize a tx_lanes.

Signed-off-by: Wonkon Kim <wkon.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 969f3a23bf92..6858f005cc8b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4990,7 +4990,7 @@ EXPORT_SYMBOL_GPL(ufshcd_hba_enable);
 
 static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
 {
-	int tx_lanes = 0, i, err = 0;
+	int tx_lanes, i, err = 0;
 
 	if (!peer)
 		ufshcd_dme_get(hba, UIC_ARG_MIB(PA_CONNECTEDTXDATALANES),
-- 
2.34.1


