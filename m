Return-Path: <linux-kernel+bounces-861139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D2BF1E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DF618A4224
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA521B9C5;
	Mon, 20 Oct 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="C4bSwODM"
Received: from mail-108-mta229.mxroute.com (mail-108-mta229.mxroute.com [136.175.108.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53D21420B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971007; cv=none; b=HSpzKg7YU7BvsSmOdN7uhP0ml+leg04c9/3645ti+V4nM4PKMlOVjQ/wAnTnblgYKA3ps/+St/90WzEi/avg2ElMnz0AH+jv3iSXpPy5fhu+q6TwKLUZIDBRbI7SJk8xuLKxh1oZEURt2/+/Qcd5N0TeWl2DFrQfmCWIa+j9Mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971007; c=relaxed/simple;
	bh=8zv4is5Fd4+KAHQmb2DilHjkxMsZEVyRbpIqbuM1MlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMqHJLd8vsIyJ+ab0GVpqvAYZTQc+1D/JOLoPdqTXK5INKIS5m0h0EiqNqsZzaGz3BXFIcSpD2I2ezieWTSFn3Gpuq2pMq8HiD+dE2ru4b3C86uZAqFqE+SbaVDfcj8DYf+owh9y5oLTZSCEGFeiroCXsdRmR0fPMTbyyLvgTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=C4bSwODM; arc=none smtp.client-ip=136.175.108.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta229.mxroute.com (ZoneMTA) with ESMTPSA id 19a020858f7000c217.00c
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 20 Oct 2025 14:31:32 +0000
X-Zone-Loop: 807deff1285f2ede84d3415cfb735ada2595df648fc7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=kQRhYW1ob+5xxQnD5lkOkGhyx3jWDh5o2cQL6UsjPjQ=; b=C4bSwO
	DMu+6OLvya7WOw0zKupVdvpHtFxMG+MPxM3eAY4FB8jR8IjQCj83QqWGDRrugi27tNTuCb01T0ovB
	WWhpJwJCYF4A2ew0lSIbtmkY4jYcjVagvGdYKxB5KfEhyzsy5OCLq3lkd3UwACchw9yfSTNW6/NDW
	W4GXsxaz8OSkexKHPCCZd6/hYBMo8KUTF+Vwr2sapu4uOyhbckvlya2rvP/wDNTIGukldAN+OkMqu
	NxkSI08O3qIVEIA2BYLlUhxAqZndi5686+hDXt0t/HRvC5eQJdtTkUyw0cuf0misrqTNRJiNljN+0
	R0ZM6E420fw0XPPgIe9uk0la8OxA==;
From: Bo Sun <bo@mboxify.com>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
Date: Mon, 20 Oct 2025 22:31:12 +0800
Message-Id: <20251020143112.357819-2-bo@mboxify.com>
In-Reply-To: <20251020143112.357819-1-bo@mboxify.com>
References: <20251020143112.357819-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
Unbinding and rebinding the driver therefore triggers kmemleak:

    unreferenced object (size 16):
        backtrace:
          rvu_alloc_bitmap
          cgx_probe

Free both bitmaps during teardown.

Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index ec0e11c77cbf..f56e6782c4de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
 		kfree(lmac->mac_to_index_bmap.bmap);
+		kfree(lmac->rx_fc_pfvf_bmap.bmap);
+		kfree(lmac->tx_fc_pfvf_bmap.bmap);
 		kfree(lmac->name);
 		kfree(lmac);
 	}

