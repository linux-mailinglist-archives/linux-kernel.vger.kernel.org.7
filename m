Return-Path: <linux-kernel+bounces-864604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DBBFB298
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E99CC50394A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AD3128A4;
	Wed, 22 Oct 2025 09:27:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94E1C5F13;
	Wed, 22 Oct 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125272; cv=none; b=F2EU6f4fMoelt0tAAbAGY/YljN5xcuh4ZLP79NWFWvOU8NbncnjavntacrwOqKuhyjYNhsGUz7reD7B9Ae1XO+rbpuyxVty2GOMqCantO+Gle7VMUh9CLcUPoMynnzr/nHseeMoZPJOEQQmUoKxpfWr8Tt//hHwBySqABmDB1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125272; c=relaxed/simple;
	bh=sIuyb8KEXIaKo3Sb0cL1wkD9VQVKTJYf+YA8py0dayY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdqVyD2TPXzP21a2xK9YkRsVFIxZANDwPAm67yxFXZypDKSkPvyLQY8XUM5vVftRga4Gr1tpf+HEiseMfN+cnxRWgkBD1AtRcx6AtibkzeJaW10b1bFvgqWwbP5GWl4ZpPfnYzaraZUL3rFb+yh/zx9LMBPcklkkKO8ftd2makc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c64c57caf2911f0a38c85956e01ac42-20251022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5b3b2896-62b1-4ce1-9f4c-504d5369b936,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:929f9d4c16aae49b4298164fae7fd094,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c64c57caf2911f0a38c85956e01ac42-20251022
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1847635776; Wed, 22 Oct 2025 17:27:42 +0800
From: tanze <tanze@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	phasta@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH] ALSA: emu10k1: using vmalloc_array() to handle the code
Date: Wed, 22 Oct 2025 17:27:38 +0800
Message-Id: <20251022092738.552700-1-tanze@kylinos.cn>
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
 sound/pci/emu10k1/emu10k1_main.c | 8 ++++----
 sound/pci/emu10k1/emufx.c        | 2 +-
 sound/pci/emu10k1/p16v.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index b2fe2d164ba8..bdbd2dea1c4a 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1574,10 +1574,10 @@ int snd_emu10k1_create(struct snd_card *card,
 		(unsigned long)emu->ptb_pages.addr,
 		(unsigned long)(emu->ptb_pages.addr + emu->ptb_pages.bytes));
 
-	emu->page_ptr_table = vmalloc(array_size(sizeof(void *),
-						 emu->max_cache_pages));
-	emu->page_addr_table = vmalloc(array_size(sizeof(unsigned long),
-						  emu->max_cache_pages));
+	emu->page_ptr_table = vmalloc_array(emu->max_cache_pages,
+					    sizeof(void *));
+	emu->page_addr_table = vmalloc_array(emu->max_cache_pages,
+					     sizeof(unsigned long));
 	if (!emu->page_ptr_table || !emu->page_addr_table)
 		return -ENOMEM;
 
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 37af7bf76347..091f6accfc44 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2629,7 +2629,7 @@ int snd_emu10k1_efx_alloc_pm_buffer(struct snd_emu10k1 *emu)
 	if (! emu->tram_val_saved || ! emu->tram_addr_saved)
 		return -ENOMEM;
 	len = emu->audigy ? 2 * 1024 : 2 * 512;
-	emu->saved_icode = vmalloc(array_size(len, 4));
+	emu->saved_icode = vmalloc_array(len, 4);
 	if (! emu->saved_icode)
 		return -ENOMEM;
 	return 0;
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index b74128e61254..79b097ada22b 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -791,7 +791,7 @@ int snd_p16v_mixer(struct snd_emu10k1 *emu)
 
 int snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
-	emu->p16v_saved = vmalloc(array_size(NUM_CHS * 4, 0x80));
+	emu->p16v_saved = vmalloc_array(NUM_CHS * 4, 0x80);
 	if (! emu->p16v_saved)
 		return -ENOMEM;
 	return 0;
-- 
2.25.1


