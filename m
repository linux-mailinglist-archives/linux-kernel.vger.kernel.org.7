Return-Path: <linux-kernel+bounces-868681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEDC05D72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739A23B7772
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7513491D4;
	Fri, 24 Oct 2025 10:56:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AED3126B2;
	Fri, 24 Oct 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303372; cv=none; b=EjUYKoLlu2i+XfDleW+tYt5fMrHgnx/J3KXmDTDVIzbbpGt8Z1nKtt68l6/KU1+quPjPqJQuKXcQ/2NIZA+oUscBCcIPokeQZDkzSPK4Q1DEbxOSKsZFhKbR4yn9EuEs1AcK2m34wTrCqfz6qCVdttrc6DPy+Z0rl2U2Gyv0NMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303372; c=relaxed/simple;
	bh=9LSUD9mlp3ZKoOJkp19aXhl2bXRhn03jc6C8NN2B68Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMzMH7wPADQ8lK7UqV/TEgFVv+VMUP8auJ0lPbzXlzcvG5gOStYIc8n1VTgXQCP/coycXeUXBdXbmtfAjeqrelCg9CwuqeJfHDAwI6H9GPgTgHrkYNNUMYBBwG+WGICmMASwKKgX9vgR7ktzFefNcxPNtPVWOhU9Si4TEKMoAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 05df495cb0c811f0a38c85956e01ac42-20251024
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ecb4b176-9ff2-4c44-8ffa-1ee54176c31d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:838cdb255162ddaaedc9cee606f2bb2d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:1|19,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 05df495cb0c811f0a38c85956e01ac42-20251024
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 358380326; Fri, 24 Oct 2025 18:55:58 +0800
From: tanze <tanze@kylinos.cn>
To: phasta@mailbox.org,
	perex@perex.cz,
	phasta@kernel.org,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH v2] ALSA: maestro3: using vmalloc_array() to handle the code
Date: Fri, 24 Oct 2025 18:55:49 +0800
Message-Id: <20251024105549.210654-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change array_size() to vmalloc_array(), due to vmalloc_array()
being optimized better, using fewer instructions, and handles
overflow more concisely.

Signed-off-by: tanze <tanze@kylinos.cn>
---
Hi, Philipp Stanner,

Thank you for your suggestions.
I have made revisions according to your requirements.

Regarding the issue of my full name, thank you for your 
attention to detail. Since I am in China, I use the name 
"tanze" on many occasions, and the code I previously submitted 
to the upstream community was also under this name.
---
Changes in v2:
 - Fix some issues in the commit message.

v1:
 - patch: https://lore.kernel.org/all/20251022092339.551438-1-tanze@kylinos.cn/

Best regards,
Ze Tan 
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


