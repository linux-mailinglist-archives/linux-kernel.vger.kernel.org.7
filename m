Return-Path: <linux-kernel+bounces-853983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECABDD3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D351921B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E617314B82;
	Wed, 15 Oct 2025 07:55:44 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40298311C13;
	Wed, 15 Oct 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514944; cv=none; b=OU/H73/jvPbEJZFlMQPvTch3YRt3zUUtvVL4PRzNQ6JBsCtwcgRo+H5Plgf9YXa5zZQy+0OJk2L/5qfg8e99aP1hVk2z1QTg2nOFVNAekcLxB/7FYRSWllEqsKF9mNB1idRZdRRS1r0t+e4du2bkRpKI2XeiY7EgwQIXDKj2R+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514944; c=relaxed/simple;
	bh=iE2Psiwzs2QGqdwASawlzs7KvkkzA/n/ldRp4cGHpBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8pwK2ZR7YDtYkasGpq5O2y9N8Y405xMMjmxwZ5dodBpGpZcXsuPIG2qyK2sNfbhMt2Scom7UA84qjAA07NnosQaoC4HTmQ3ZpnNf5TT5bN27QRO05wKzhngOLm3eOpmQYvGD/YjFGSup2secCjBUETLOkvcbl+SNuBpZqKaF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 542e6d6ea99c11f0a38c85956e01ac42-20251015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5d625116-8dbb-405c-942b-f37ae7a91dad,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:0d0adf757c6bb67376f84ff0386faaea,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 542e6d6ea99c11f0a38c85956e01ac42-20251015
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1442507899; Wed, 15 Oct 2025 15:55:34 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails
Date: Wed, 15 Oct 2025 15:55:30 +0800
Message-Id: <20251015075530.146851-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() may return NULL on memory allocation failure,
but the debug message prints cpus->dai_name before checking it.
Move the dev_dbg() call after the NULL check to prevent potential
NULL pointer dereference.

Fixes: cb8ea62e64020 ("ASoC: amd/sdw_utils: add sof based soundwire generic machine driver")
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 91d72d4bb9a2..d055582a3bf1 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -176,9 +176,9 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 			cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
 							"SDW%d Pin%d",
 							link_num, cpu_pin_id);
-			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 			if (!cpus->dai_name)
 				return -ENOMEM;
+			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 
 			codec_maps[j].cpu = 0;
 			codec_maps[j].codec = j;
-- 
2.25.1


