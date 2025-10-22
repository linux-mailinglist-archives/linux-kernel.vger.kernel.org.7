Return-Path: <linux-kernel+bounces-864041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D8BF9C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2C218C78F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC5D224893;
	Wed, 22 Oct 2025 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1ILQ9Gy"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABEEBA3F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102362; cv=none; b=UL8P5nfL0NSi4+q2xHzucMyX1ePYtKhsRyaRiyKR+IhE6n+c36gCyf8nZu7vuumK/RYCj/9pa+MeqIiYChClLo25O8W9sPaRWMRiDjKmzzx6gfh7h+JxncGUQU6VJuuiGjd5r66TSSR0wHf1qz4oJhKaIQpSBA1+t2t3MbAHLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102362; c=relaxed/simple;
	bh=hDKcO+6tpTx+vDwFCsnE/KqKIMKRHk43B2xmWcILIeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkLscbm8FkEHWGdWErME5xUUwhYQtPGipYkMXL2WLFqAoFOSGxp1NUoc+6mfYM4dHVpGS1giwM0MgSXgX9yjSHYBX/d4rq/Hua6WAwWzh1V3zqopdqFVcvTfzJX1UAIqXSpk2XTUsFgmx4tWUhbWeQr4GiS4LuAhItdlXpj8zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1ILQ9Gy; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-940e06b4184so257353739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761102360; x=1761707160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISiPvSTNn3o9NNdr1WqejjfJYooOZ4Dr+K+ubbeMFdo=;
        b=N1ILQ9GyoYWu78c+23T3lRiFF3AuRglExibXz+8nVLA4fxWBCxM01aaZGlO8fYecla
         h6UEyXfjNKUtxdBdgOSPnFTtoWxJgx4/lCbiKmy5BvhgliviBW+76NTKXvMz0hW7eG59
         RrbXHFrJdbbvuWUF1e7KJRIJbNANoTugQapJmSWir+Rzr0q8qVIkMSNJjx+3sUk0XSri
         CIPY8WvYcMnC8RFzIyaYDw0GjQWD1XgkUVzoWvepSSldoJa7bqqQEnN7lIIQfA4/oOvU
         gQb3BVIDqTQp//jVVbTplSz2IcqOiYBT7N5UlBBo63wjJDn3ize+mQvMFlJQd7dQSuh3
         YBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102360; x=1761707160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISiPvSTNn3o9NNdr1WqejjfJYooOZ4Dr+K+ubbeMFdo=;
        b=e93tf7ARqQyTMjS81zegqjbKboaQmxpgTRC60qBGGvSLfWxPZ4+3DxUpNyXOAjNQzT
         5tsngHd+5VpMgn2pTZj/CGQJPT8IGzV8h7aL8AQMOdrSeyr/q1osQK4yyGSsE8G9i364
         8fdjn8AJ+fQ2XaE3ZrvE2BfUg2ZmvQL2mxeJ0nZmChaqRsrPCHMH0JWm7OSggqkUsjvg
         J+pLZ7tAvKcOAgCBODE1xJZuzoqM1wZR6TA5wV4BBCp4oCLNjGeVdGSbDnIyq8vJ8QCf
         w+zEoUIhmMLRoNNzUWMm8pZ4/cm/ngYuwerH+jdVA58qUdsIZY+u4CL4QSrHA8kgzAUP
         oYpg==
X-Forwarded-Encrypted: i=1; AJvYcCXQp7ggfTaWG01SmklqV0TkZcnLuvRB1iCo2oII6Fo+kmC0t2GnLsXySSTYbkUaOt9TbEeZSpsNLLZIiDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpH8Un1/oI8BRvhaE5u7RiagpgxK/Nk8MQLqqYk2EmYkT0Ztp
	lVi5QPkJTA9cqAtYa0Omf/9iLY2l7x9Xh93Y37X65lJezvHQOyKsRfz/
X-Gm-Gg: ASbGncshMzmb5i6PEUsdUZMZSAUI7x37h45Zu3b8wq5FMM5bHfDHnKIn0sylE3IpFYG
	gXWvzMVEfD1mvkcoCsI5nNFtJ/tMprqzglmeZIoJgollR/j4splE8IPx8bIexIWQn0wWXM7khoe
	6CHe6CBre7MiSnup1Cyn7cV1LNtMEceFjnA7TY/PcTafhuZJnnBcEc7F59iCXp/Fp4kQGvzPWGh
	nGrzzrHBUwjWLdOpNSF/X3EahQrVGI0OMzLCAoJX/oW3LwpVLNkU/5O3QmcT64YERn1W/fSTJVM
	bzW15aQLWntmnhf3y2j8UxMVGWxSs1z5XH25GeBxpKLnWZd0F3JwtxVnE/9wKceOHCxUI2503PZ
	g8tcbWhxNZKiiyz/e5r6sYGdlRRWDTr16tzKx8icatG9IZ1WLkWMIsVWwC5G0ck4HCa5YfK4Bgu
	hk/zwJ76lM9QhqtOTjgB/1kIFMyiK6PdBtBsRjO/4V9kV/MaxpgTca8Y5rvpWZOVhoHJ007f0Nq
	GHiSD82WmhiYkM=
X-Google-Smtp-Source: AGHT+IFpvoNVvIuGVZW7pKGl+iuAsqMxWnZwpLG8jZoAPt99z8wOXTWWP+d/25uNt9wvltkWSFCgDw==
X-Received: by 2002:a05:6e02:1945:b0:430:ae8a:40ae with SMTP id e9e14a558f8ab-430c5293567mr299326415ab.15.1761102360195;
        Tue, 21 Oct 2025 20:06:00 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9629c16sm4660189173.27.2025.10.21.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:05:59 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: aacraid: Fix DMA mapping leak in aac_send_raw_srb error paths
Date: Tue, 21 Oct 2025 22:05:37 -0500
Message-Id: <20251022030537.1298395-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aac_send_raw_srb function creates DMA mappings for scatter-gather
buffers but fails to unmap them in most error paths, leading to DMA
mapping resource leaks.

This patch fixes all error paths except -ERESTARTSYS. The -ERESTARTSYS
case is a known design issue where resources cannot be safely freed
(hardware may still be accessing them) but also cannot be properly
tracked for later cleanup (they are local variables).

Fixed paths:
- copy_from_user failures during SG buffer setup
- aac_hba_send/aac_fib_send errors after DMA mapping
- copy_to_user failures after successful command execution

Fixes: 423400e64d377 ("scsi: aacraid: Include HBA direct interface")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/scsi/aacraid/commctrl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 68240d6f27ab..e0495f278e2e 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -493,6 +493,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 	void __user *sg_user[HBA_MAX_SG_EMBEDDED];
 	void *sg_list[HBA_MAX_SG_EMBEDDED];
 	u32 sg_count[HBA_MAX_SG_EMBEDDED];
+	dma_addr_t sg_dma_addr[HBA_MAX_SG_EMBEDDED];
+	int sg_dma_last_mapped = -1;
 	u32 sg_indx = 0;
 	u32 byte_count = 0;
 	u32 actual_fibsize64, actual_fibsize = 0;
@@ -690,6 +692,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 			}
 			addr = dma_map_single(&dev->pdev->dev, p, sg_count[i],
 					      data_dir);
+			sg_dma_addr[i] = addr;
+			sg_dma_last_mapped = i;
 			hbacmd->sge[i].addr_hi = cpu_to_le32((u32)(addr>>32));
 			hbacmd->sge[i].addr_lo = cpu_to_le32(
 						(u32)(addr & 0xffffffff));
@@ -752,6 +756,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 				}
 				addr = dma_map_single(&dev->pdev->dev, p,
 						      sg_count[i], data_dir);
+				sg_dma_addr[i] = addr;
+				sg_dma_last_mapped = i;
 
 				psg->sg[i].addr[0] = cpu_to_le32(addr & 0xffffffff);
 				psg->sg[i].addr[1] = cpu_to_le32(addr>>32);
@@ -808,6 +814,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 				}
 				addr = dma_map_single(&dev->pdev->dev, p,
 						      sg_count[i], data_dir);
+				sg_dma_addr[i] = addr;
+				sg_dma_last_mapped = i;
 
 				psg->sg[i].addr[0] = cpu_to_le32(addr & 0xffffffff);
 				psg->sg[i].addr[1] = cpu_to_le32(addr>>32);
@@ -865,6 +873,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 				addr = dma_map_single(&dev->pdev->dev, p,
 						      usg->sg[i].count,
 						      data_dir);
+				sg_dma_addr[i] = addr;
+				sg_dma_last_mapped = i;
 
 				psg->sg[i].addr = cpu_to_le32(addr & 0xffffffff);
 				byte_count += usg->sg[i].count;
@@ -905,6 +915,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 				}
 				addr = dma_map_single(&dev->pdev->dev, p,
 						      sg_count[i], data_dir);
+				sg_dma_addr[i] = addr;
+				sg_dma_last_mapped = i;
 
 				psg->sg[i].addr = cpu_to_le32(addr);
 				byte_count += sg_count[i];
@@ -986,6 +998,10 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 cleanup:
 	kfree(user_srbcmd);
 	if (rcode != -ERESTARTSYS) {
+		for (i = 0; i <= sg_dma_last_mapped; i++) {
+			dma_unmap_single(&dev->pdev->dev, sg_dma_addr[i],
+					 sg_count[i], data_dir);
+		}
 		for (i = 0; i <= sg_indx; i++)
 			kfree(sg_list[i]);
 		aac_fib_complete(srbfib);
-- 
2.34.1


