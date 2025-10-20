Return-Path: <linux-kernel+bounces-860930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79701BF15B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBDA18A5D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDB2F6160;
	Mon, 20 Oct 2025 12:53:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053D26657D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964826; cv=none; b=a04vH7Ia1zMRXVO8IET+mJQ/s1IlbF/T0z9mSncbbPna+Sf38sTEQi4W4RPUdy5ma6+bGCtiJyAn4+udhFqJUHB+uuHYYnvLJSWEhcpRlsbgH1tBmtR/9nA+J6hB8yq7JCayiB5y+1ByGulCUK/aqxEtbC0lXXa6XbCsxpaxSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964826; c=relaxed/simple;
	bh=nraJQwwD6dqcMnmFpGbRn2OoudlMBMQTV+lXSL2dNnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXFyHnQyEN9waYXgOrYED/UFnWnB247S+csCXTPzMOcItUmC/d4gu9Ad7QZMk3zOzJO66HnIk4NSjg0+mklEfe2aGLnxTa31ecfLnNiNNMcbXGEzXsT40vjo0kEY5Um8wLtO3/kZifRMiUSkThAZVOFrzD6eJxBC8RPMsytU1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb4c0f12adb311f0a38c85956e01ac42-20251020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f910d0c3-7f34-48e6-b4ec-4a4fdabd0173,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:54cfd040c6b2de2905d497e7cb8a6c40,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cb4c0f12adb311f0a38c85956e01ac42-20251020
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 813802747; Mon, 20 Oct 2025 20:53:36 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] mtd: rawnand: realtek: Make rtl_ecc_engine_ops const
Date: Mon, 20 Oct 2025 20:53:33 +0800
Message-Id: <20251020125333.3400488-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtl_ecc_engine_ops structure is only used to provide a set of
callback functions and is never modified after initialization.
Mark it as const so it can be placed in the read-only section, which
improves safety and allows better compiler optimization.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/mtd/nand/ecc-realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/ecc-realtek.c b/drivers/mtd/nand/ecc-realtek.c
index 7d718934c909..32da4c15fbe9 100644
--- a/drivers/mtd/nand/ecc-realtek.c
+++ b/drivers/mtd/nand/ecc-realtek.c
@@ -380,7 +380,7 @@ static void rtl_ecc_cleanup_ctx(struct nand_device *nand)
 		nand_ecc_cleanup_req_tweaking(&ctx->req_ctx);
 }
 
-static struct nand_ecc_engine_ops rtl_ecc_engine_ops = {
+static const struct nand_ecc_engine_ops rtl_ecc_engine_ops = {
 	.init_ctx = rtl_ecc_init_ctx,
 	.cleanup_ctx = rtl_ecc_cleanup_ctx,
 	.prepare_io_req = rtl_ecc_prepare_io_req,
-- 
2.25.1


