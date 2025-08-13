Return-Path: <linux-kernel+bounces-766905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C6B24CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DFF1882D54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30102EF644;
	Wed, 13 Aug 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jIwIRiuH"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2218786A;
	Wed, 13 Aug 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096913; cv=none; b=FL0t/qrnIBFeQm2v7qbV2tROb6/KcB5QmzWAckcK30oUKEvqiM2f2g4gEtjKfP6fR6hG0u1QJi60nfRu85+yksP2OhU08VmcW3mAKGqPiXgsxZFMLt9YjwFjiT6zcvKKXMm5J+EvyqO0cZsxptWhwBP0TBcPUEUCk/+BDJI1ApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096913; c=relaxed/simple;
	bh=M7GZNSUpI9ATPqxGDtbiF1Ozy+rhBjrdP5xZjfVP5lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQRkrzL9MlGNz7P46Boie+Z04kxVghRlSmg/N7q4AXnHA0Q4sTdVdKurBSYoPT3exZUK+y9FXylK4TLYgd6m+8wLvq5FvIytypSuHVMymi9oI6OFAk1lk7IZ+HSO9b/2CyVpuakBgFSoQtS+hCIBwlR/ExdCsLr/DWR5eGWWdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jIwIRiuH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755096907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LvftcL58ct6X0ftT2fa9FbYktve1QOI78gCmcjiX2eg=;
	b=jIwIRiuHdRmRr7Y++eYtolUWNm35sk2k0VwL5lOQMPhOAthrCOFojp2G0NDQabomPnmOP8
	gEKBtK5y2ZC2xA1cDUAAgifuYzi8ZUxiTi4mvpamjoeGSAHqLTuavewaA/Awef0ag6L/88
	DWjlaqaLE019fowMhri0iUaFzzZEozw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	wwang <wei_wang@realsil.com.cn>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: realtek_cr: Use correct byte order for bcs->Residue
Date: Wed, 13 Aug 2025 16:52:49 +0200
Message-ID: <20250813145247.184717-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since 'bcs->Residue' has the data type '__le32', convert it to the
correct byte order of the CPU using this driver when assigning it to
the local variable 'residue'.

Cc: stable@vger.kernel.org
Fixes: 50a6cb932d5c ("USB: usb_storage: add ums-realtek driver")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this as a separate patch for backporting as requested by Greg.
Link to previous patch: https://lore.kernel.org/lkml/20250813101249.158270-6-thorsten.blum@linux.dev/
---
 drivers/usb/storage/realtek_cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 8a4d7c0f2662..758258a569a6 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -253,7 +253,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
-- 
2.50.1


