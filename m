Return-Path: <linux-kernel+bounces-834846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DFCBA5A28
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894537B3421
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFAB2DF68;
	Sat, 27 Sep 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="f+hAjOKQ"
Received: from mail-108-mta80.mxroute.com (mail-108-mta80.mxroute.com [136.175.108.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79872BE7B4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957675; cv=none; b=gEzYzHbE/5mBR18cMY5qLn/KjTMfUxcfcbFsN5Uk3e4e21f9MaORyC4Vu5kA6jqh6v1WcUlo+QlwN4gYpyY6N+raOO3Gremh3FQzRiMXPwsJfi69rtMEDN1X49Jrg6+7kVKXClSGfQfFlsOGPZigQ7vCQNwArRN1UKacHzxI59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957675; c=relaxed/simple;
	bh=xpWw1fr15ZnUBWMm4pgU2OOFI7SC2s3fG8d2luLclh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILXHHynVI9o9vtRwFMsVSITQI9ACYYd043rJ6X1jQBOMPMIwHoL5riAR5AjZsKxI7YjJSSEnXzzGaQPXnomZ6oXQWBgzP1y7Lk6oOifQMDITrJrHOjtmshJS/ynf7or4QkzJpta7/SnryA8eI0miXcWsE08WVscLZH7wLO4fY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=f+hAjOKQ; arc=none smtp.client-ip=136.175.108.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta80.mxroute.com (ZoneMTA) with ESMTPSA id 1998a07472a000c244.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 27 Sep 2025 07:15:56 +0000
X-Zone-Loop: 033b8e6251effb78e9e745735f0f78cab2b48e180300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YPcuyd+/b8J7SuKFiIcya8aL9pWVP/wXtGAqhHA1mJw=; b=f+hAjOKQvWcpIlSSjO/K5rg4qm
	41GHz8iloUtmbCJJhKT/it5R+4ySWzkFIBH9TV71seEmlaezmmCIfhx6vvEkI66W7wNrOBBYkTfwi
	3AoOhCpQpwYQHswYuh1tHc2k8hdnXsjmJeBonvCEFs16AOYN2VLoZg6h5H7Wiu7/zqpvT9zBX+pyS
	oFWTi8axoQEYydhEkXHdbV5jUzNyeZqDrU4OiQirbT41fUo+RickjElxSrJ+br8xJDwU/0s52stvE
	mMg2QZsf6I6GTxrLYWI/UobLz7oUftWpD7Gs8Od3vQ9mQQ+oGZI8SLDOmeY5CyUUxCGrod7S5lq/o
	+6UtU01A==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] octeontx2-vf: fix bitmap leak
Date: Sat, 27 Sep 2025 15:15:04 +0800
Message-Id: <20250927071505.915905-2-bo@mboxify.com>
In-Reply-To: <20250927071505.915905-1-bo@mboxify.com>
References: <20250927071505.915905-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

The bitmap allocated with bitmap_zalloc() in otx2vf_probe() was not
released in otx2vf_remove(). Unbinding and rebinding the driver therefore
triggers a kmemleak warning:

    unreferenced object (size 8):
      backtrace:
        bitmap_zalloc
        otx2vf_probe

Call bitmap_free() in the remove path to fix the leak.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 7ebb6e656884..25381f079b97 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -854,6 +854,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
 		qmem_free(vf->dev, vf->dync_lmt);
 	otx2vf_vfaf_mbox_destroy(vf);
 	pci_free_irq_vectors(vf->pdev);
+	bitmap_free(vf->af_xdp_zc_qidx);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
 }

