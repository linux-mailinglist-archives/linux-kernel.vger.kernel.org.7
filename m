Return-Path: <linux-kernel+bounces-619386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9772A9BC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB321BA4E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12A1863E;
	Fri, 25 Apr 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qrLSJ0wY"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C4A50
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543179; cv=none; b=XMW5ATm8Ij5/g6hBbj/AdVjcz49wpEZZzZMDGKvwJMj77IAHKZSOarIx+DMVzIPOZiApZOY+tbx/ooBOZPQxB8JrFYO9PcXZhr2NjINYdXtagtIl56B+i5FkrY+nfBy/yykyu8K2CzXy+RuOkS/X8iID4ZExDumWUESiIXMg6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543179; c=relaxed/simple;
	bh=OwoSkp3cQViO8bEa4eppnRCl8L2XA21diihzW7HL4XI=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=dGDIUq4+xNc5bARQ23mPtYb20zSfTS/1aSV/6w0UMNBxFSv8jYEK8C4FKAIcIHUEq0GPkHfEJtomoRw53OLDNKHU+Bzue7vKrQHFq96nA5IEXPDFokx0HVx6JhBsFLkk2+UDUL8j1ln2OEgHg6mf2Z0vp19eWkwhGXNK7cjnD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qrLSJ0wY; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250425010607epoutp02bdb49f74befe7d48c255f80c93f88b75~5akM2wagM0248202482epoutp02K
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:06:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250425010607epoutp02bdb49f74befe7d48c255f80c93f88b75~5akM2wagM0248202482epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745543167;
	bh=HFUhzdTXjPIZ5aALh7iKZ0gjHn3kYbyo2kbfpkNH+tE=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=qrLSJ0wYvBAfaqG2G+HAiQ+gKEZREUW3141brLNEj7E07wb8fZVsL7QbU/yj/W0BA
	 6SrOcysLolIM7TayNHkyrBZgky1dBidgywW1PIWh7nDecwpGvg9vQMRam4GRBpPnMJ
	 I4z1qftq8NpQzNIBF0W1gliOxcYD5ucr5VEQRqXM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250425010606epcas2p19bc454ddf344efb0760d1fefd3c4852f~5akML9xY52441524415epcas2p1m;
	Fri, 25 Apr 2025 01:06:06 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZkF5p34Pcz6B9mC; Fri, 25 Apr
	2025 01:06:06 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] ufs: core: Remove redundant query_complete trace
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From: Keoseong Park <keosung.park@samsung.com>
To: ALIM AKHTAR <alim.akhtar@samsung.com>, "avri.altman@wdc.com"
	<avri.altman@wdc.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "peter.wang@mediatek.com"
	<peter.wang@mediatek.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250425010605epcms2p67e89b351398832fe0fd547404d3afc65@epcms2p6>
Date: Fri, 25 Apr 2025 10:06:05 +0900
X-CMS-MailID: 20250425010605epcms2p67e89b351398832fe0fd547404d3afc65
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250425010605epcms2p67e89b351398832fe0fd547404d3afc65
References: <CGME20250425010605epcms2p67e89b351398832fe0fd547404d3afc65@epcms2p6>

The query_complete trace was not removed after ufshcd_issue_dev_cmd()
was called from the bsg path, resulting in duplicate output.

Below is an example of the trace:

 ufs-utils-773     [000] .....   218.176933: ufshcd_upiu: query_send: 0000:00:04.0: HDR:16 00 00 1f 00 01 00 00 00 00 00 00, OSF:03 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ufs-utils-773     [000] .....   218.177145: ufshcd_upiu: query_complete: 0000:00:04.0: HDR:36 00 00 1f 00 01 00 00 00 00 00 00, OSF:03 07 00 00 00 00 00 00 00 00 00 08 00 00 00 00
 ufs-utils-773     [000] .....   218.177146: ufshcd_upiu: query_complete: 0000:00:04.0: HDR:36 00 00 1f 00 01 00 00 00 00 00 00, OSF:03 07 00 00 00 00 00 00 00 00 00 08 00 00 00 00

This commit removes the redundant trace call in the bsg path, preventing
duplication.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index be65fc4b5ccd..c78c7ad4e393 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7271,8 +7271,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 			err = -EINVAL;
 		}
 	}
-	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
-				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 	return err;
 }
-- 
2.25.1


