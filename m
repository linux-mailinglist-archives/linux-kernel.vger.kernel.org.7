Return-Path: <linux-kernel+bounces-761802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD0B1FE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76B516A238
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153926CE36;
	Mon, 11 Aug 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVgafQ9d"
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E007216E26
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890442; cv=none; b=ocO5asK+YgXsaImwau9mMewrbvqEahITKmEErKyvnku1/iHKmRmPXj+KvBZV+SeqHYfLu45JlxVCjfF5IY8zuOJX8Pe8blSPOuyv8LC9dbVAxUVGYBWqasG+4qqOJxdrVkYIShZ2/7x5JDzJtSkhU2zKWK3njVMElG3Zmq+V0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890442; c=relaxed/simple;
	bh=5sIIX3QUuzaegHNd+6NUT4Vvb6PsIrXVllYiGJIz/tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCKLDjrg4qQ/62vtVUidLuP/hr1Ifc6k54Mh/1xNt3Spj055XTqK3JUa9EFWUnTIVmuJV5arXBzCXsh/13oBi8ls3gvIGFYWy3UyHYNEpZF3UmseUh2kZYEF7Wn323/zMLR4oCkMZiOQxNMdpibrLiAZuazJn+Xs2gIsDjlSbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YVgafQ9d; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e8e0c6f1707so3121216276.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890440; x=1755495240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHnkr22dY5CgwiPLBWthXGPdFU+dhhWu46oxcV2g8cY=;
        b=LbN1jYAfKsDHuYMAIGJMSNaQMG9QvKuUI7DQgJJbYM+QLMZS2J9GVBMM8Ee9f46Oxs
         xL19GCZoaSSrJca7vaKgOaSTndsJGPjME4/yQwc6HQu4YndS9ERFqLJKOYb5g+q9GsLo
         C0GJ/S8ujbIYtWfklj0XrrvcvDS4JFmxdTJEgJq8j5B2dZ/XObwdZcUPlxk1BZttbuXv
         3MIeZo9BSf8vOkUIgWWbmZyWSs2XRrsn/B2JKiuVcTNOCoCYDYvqtHDHvNhBprFf34vt
         lYiEHKB3NS1uEhCELaWJUSWFUke08q2P9MzPkkojajm2ZgiPGk5z79RlfFmdroMB6inB
         sWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUFmPi8Qx5zrLnHLWnUgUuv4yM5IY/BO3aW7u4VtiqfuXP+smqNx2YiNlDAy/PMgUzmuEUnEfAciqRmSx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c0qsoUe+z4EjkMOqRpEXvz9YUNYc+y87fTJhki4cHBvtra07
	OOI88l4U7v20NRqxPphnEh2he7SkIIzNTEFgi/Ugy6IKbY3lsti5PWexcTDbCAdhVN50TSiPHkb
	dC1R391aalbsB4Ssx27+j1iU2mOnEf1R0O6cHT74Wdi8e05aBjy0tqAAeXCQkaq4MA3tN39vxhd
	qXdi/46v9IzTNb/RkSKmsQabHLjBjr2I0mBUtKI5mMQSbEiDh/lyivMEFhoEiCs7FkzV873SsED
	n0nvx1I5hOFRgHc36sVKqiYfw==
X-Gm-Gg: ASbGncucQjh5pxFtYjWZY+coOf3fOyno5xdPDxMmW+vL9y2OYvEgX11gCMat2MjlnJz
	YUEOTAd6f8am2a8H43SoZvO9/LKYb1y2l+ucqQusrnwyGqMTDHxPmOSSN+C1sZc3ZPtLs5BL5AG
	R0t+G3WPn1qnypOqEV+7pa0Vcvi5dy+EubZbz2GZWDhbzWwcBoIK5444kVRF11JLFPhnNF3QWHH
	+BPjc/VFmRkQcPg/J7w+33+2NtDCVLgh0tDTpkfKj0DG68GMweMlaN40V/2Ez4h8Bt/AA4Xv7X0
	/SShPdzOd16nYs7o4z3UbiDb4sgG+V02SosjCGgKGjiaX1I00gGwVB83nVQhks7BNnHNRLOxKwV
	Pu5pEk/m9L51OVbxVDnfzgPAWbW/j+vVmGIpRfb5ryoRWtBNBxydWGbh/dOexWjBSW2qEjbLUI0
	U+
X-Google-Smtp-Source: AGHT+IGFhL7aV9KoCzH825oTs+rQJNM+Rhi/dtoYySW92d50sGigaUB6BIp7c/EJoknDhVETyceC2KidEO36
X-Received: by 2002:a05:6902:c01:b0:e90:58b3:6446 with SMTP id 3f1490d57ef6-e9058b36ec4mr10781147276.23.1754890440188;
        Sun, 10 Aug 2025 22:34:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e90608fba16sm257427276.6.2025.08.10.22.33.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:34:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e69e201c51so953005485a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890438; x=1755495238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHnkr22dY5CgwiPLBWthXGPdFU+dhhWu46oxcV2g8cY=;
        b=YVgafQ9dJy24TVE3kDw0J/6CbufH16fDtt4Wa489IIVtriWxrR1R3FSIok7L6am0HN
         WQ2Zvlb9+MkoIlYY4Th2VJ7HfWIW1Pt9eFQQFE0uJ6HjDkAOiiSFjOhZSQDog7ve84lZ
         bkdqvkULAREXFAN4FuMm3BXpJ5OF0Z4bEEYOU=
X-Forwarded-Encrypted: i=1; AJvYcCXcOQwXe7caNdmV59Xpz5d5dXHh+kedN+74Sbu9nkr9FO/YoP+2pK25x45+eckVwCAcO927CwfMl36gM8w=@vger.kernel.org
X-Received: by 2002:a05:620a:190e:b0:7e6:38ab:fd8d with SMTP id af79cd13be357-7e82c79fc28mr1849181785a.50.1754890438335;
        Sun, 10 Aug 2025 22:33:58 -0700 (PDT)
X-Received: by 2002:a05:620a:190e:b0:7e6:38ab:fd8d with SMTP id af79cd13be357-7e82c79fc28mr1849178685a.50.1754890437784;
        Sun, 10 Aug 2025 22:33:57 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a9a3cdsm769870885a.23.2025.08.10.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:33:57 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	jinpu.wang@cloud.ionos.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	Ajish Koshy <Ajish.Koshy@microchip.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Viswas G <Viswas.G@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] scsi: pm80xx: Fix memory leak during rmmod
Date: Sun, 10 Aug 2025 22:20:35 -0700
Message-Id: <20250811052035.145021-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ajish Koshy <Ajish.Koshy@microchip.com>

[ Upstream commit 51e6ed83bb4ade7c360551fa4ae55c4eacea354b ]

Driver failed to release all memory allocated. This would lead to memory
leak during driver removal.

Properly free memory when the module is removed.

Link: https://lore.kernel.org/r/20210906170404.5682-5-Ajish.Koshy@microchip.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Ajish Koshy <Ajish.Koshy@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 11 +++++++++++
 drivers/scsi/pm8001/pm8001_sas.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index f40db6f40b1d..45bffa49f876 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1166,6 +1166,7 @@ pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
 		goto err_out;
 
 	/* Memory region for ccb_info*/
+	pm8001_ha->ccb_count = ccb_count;
 	pm8001_ha->ccb_info = (struct pm8001_ccb_info *)
 		kcalloc(ccb_count, sizeof(struct pm8001_ccb_info), GFP_KERNEL);
 	if (!pm8001_ha->ccb_info) {
@@ -1226,6 +1227,16 @@ static void pm8001_pci_remove(struct pci_dev *pdev)
 			tasklet_kill(&pm8001_ha->tasklet[j]);
 #endif
 	scsi_host_put(pm8001_ha->shost);
+
+	for (i = 0; i < pm8001_ha->ccb_count; i++) {
+		dma_free_coherent(&pm8001_ha->pdev->dev,
+			sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
+			pm8001_ha->ccb_info[i].buf_prd,
+			pm8001_ha->ccb_info[i].ccb_dma_handle);
+	}
+	kfree(pm8001_ha->ccb_info);
+	kfree(pm8001_ha->devices);
+
 	pm8001_free(pm8001_ha);
 	kfree(sha->sas_phy);
 	kfree(sha->sas_port);
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 5cd6fe6a7d2d..74099d82e436 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -515,6 +515,7 @@ struct pm8001_hba_info {
 	u32			iomb_size; /* SPC and SPCV IOMB size */
 	struct pm8001_device	*devices;
 	struct pm8001_ccb_info	*ccb_info;
+	u32			ccb_count;
 #ifdef PM8001_USE_MSIX
 	int			number_of_intr;/*will be used in remove()*/
 	char			intr_drvname[PM8001_MAX_MSIX_VEC]
-- 
2.40.4

