Return-Path: <linux-kernel+bounces-864596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C20BFB24A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ED81889AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181131283B;
	Wed, 22 Oct 2025 09:23:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107172FAC0C;
	Wed, 22 Oct 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125035; cv=none; b=gLinRPYwKBIn86a3aa2xh7mM/Sb4tnHj4UXn/rOp4xbLmG02460MQxC3JZMGewueef7CXeekprztkilJggmUqqFcvnYhnqwHLmYUcQ34ub2T82BOswBCjmnHaBHqnvaR/hMTITxj4FaZ4WuGgr5bd2+oJtjW+nRYPvIyUSW6w0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125035; c=relaxed/simple;
	bh=FS/89PN8qDAUhNvRrmv/cZIPZfOKC45KSNnfXsGhzag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7tgpde93zC4BlLC9TkNlojXwa+yWt3f9JhR33OoEBwi9VB04v2f1qcMR/ygLppyrsiOjY3fauWedgyXLNjkd5bOaeqeMhg3A3fY/N9Gx841xpdRYVZfElx1D9O9OwbCI8Dq18SsjmqT/GTCz7tJSnz+UooaGMB/TfqGwvMYbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cdcd0a5eaf2811f0a38c85956e01ac42-20251022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a6a34b9b-a3c7-425c-9117-c34af9cac9f4,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:5f6b7654d728f41e1e322f698f121a6e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:1|19,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cdcd0a5eaf2811f0a38c85956e01ac42-20251022
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 897223618; Wed, 22 Oct 2025 17:23:43 +0800
From: tanze <tanze@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	phasta@kernel.org,
	linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH] ALSA: maestro3: using vmalloc_array() to handle the code
Date: Wed, 22 Oct 2025 17:23:39 +0800
Message-Id: <20251022092339.551438-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change array_size() to vmalloc_array(), Due to vmalloc_array()
is optimized better,uses fewer instructions, and handles
overflow more concisely

Signed-off-by: tanze <tanze@kylinos.cn>
---
 sound/pci/maestro3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index bddf47a1f263..3353980d5cd8 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2571,9 +2571,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		chip->suspend_mem =
-			vmalloc(array_size(sizeof(u16),
-					   REV_B_CODE_MEMORY_LENGTH +
-					   REV_B_DATA_MEMORY_LENGTH));
+			vmalloc_array(REV_B_CODE_MEMORY_LENGTH +
+				      REV_B_DATA_MEMORY_LENGTH,
+				      sizeof(u16));
 		if (!chip->suspend_mem)
 			dev_warn(card->dev, "can't allocate apm buffer\n");
 	}
-- 
2.25.1


