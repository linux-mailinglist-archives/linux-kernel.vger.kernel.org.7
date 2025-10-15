Return-Path: <linux-kernel+bounces-853854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EFBDCC52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE04F8846
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD7313263;
	Wed, 15 Oct 2025 06:40:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A43126CD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510437; cv=none; b=MYbsTyUhKvwmj9jbfLXgSKwQYISDjC6Mkc0kBSgyeH7WApKQksyP+EPjWep8keK7LmCZPFuuC2M7aIQwK71rrFpxejqy6iyEqzXUVPYpHtyii1kd5moMPa7FGHsTEr1qNcoLBNrtNxtgiktRS4VqCQKpbASNqMrV2/gsvyxbmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510437; c=relaxed/simple;
	bh=nqbBFYyoua6QP/k++/sTCrpKYegYQuTv0a1H3Mwpvvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n1OoZoaJ5ccYg2JRipyzxG0PmLxTMKSIHnQKy05n2KHy26dTtmQ4K5GZsuFt+T/GgumDKS9jjdI72K2hyPYXZ/hd5YWqoUiGSdlp5XpSulAEngQl7vSffOLiX2okRj5GfOdETWJHdhGpX7nY0vapqyDK8sbfrnXyeuoo8kKTrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d4568ae0a99111f0a38c85956e01ac42-20251015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f43cc7cb-a7a8-4980-ba2c-f84f2c05d0f7,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:9b716fb79b65c36bdeeb36f4e6d72f51,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4568ae0a99111f0a38c85956e01ac42-20251015
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1568284983; Wed, 15 Oct 2025 14:40:24 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: gregkh@linuxfoundation.org,
	alexandru.ardelean@analog.com
Cc: linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] uio: uio_fsl_elbc_gpcm:: Add null pointer check to uio_fsl_elbc_gpcm_probe
Date: Wed, 15 Oct 2025 14:40:20 +0800
Message-Id: <20251015064020.56589-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: d57801c45f53e ("uio: uio_fsl_elbc_gpcm: use device-managed allocators")

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 81454c3e2484..338dd2aaabc8 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -384,6 +384,11 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 
 	/* set all UIO data */
 	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
+	if (!info->mem[0].name) {
+		ret = -ENODEV;
+		goto out_err3;
+	}
+
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
@@ -423,6 +428,8 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 out_err2:
 	if (priv->shutdown)
 		priv->shutdown(info, true);
+
+out_err3:
 	iounmap(info->mem[0].internal_addr);
 	return ret;
 }
-- 
2.25.1


