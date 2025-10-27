Return-Path: <linux-kernel+bounces-872176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E5C0F77C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EB4F69B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C6313E0B;
	Mon, 27 Oct 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q95Ns8BC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AB2BCF4C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583869; cv=none; b=kXM3pcOv+RxGWcmgBamG9sXgyvfozHK3YaJ9DfXNViiTW+HRDvKoHJO7u8YQjS87H/NVm7ueqSxGzpITAxa0CUBwt/C6ajZHoe6pRwtY2rC8ExdBYmabwRMCVloOuM2Vjs6TvQ8muqNZn9k2fiLk36ZXVEc/8pQGleZQ97yUdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583869; c=relaxed/simple;
	bh=EqepgGC/l3BkBwlCg2C9JuMnjeSRmoKoLRq7E9G076I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEHIungCSy3hHizzk97d6flyaJI8TjnTOjkMJDR5xSCgf90maR3XdyriYepaFTT/CHVoeuDdAPv3mlRlQPPbh65HS463FEPlaPJcsZJNY1rRSzO50qt34IqOk9TFm+gwbNKB34aj6jrUjNtFa6aRdSi198sz+l8PHcy4j+RoA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q95Ns8BC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290ac2ef203so45494185ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761583864; x=1762188664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=Q95Ns8BC1mIDmzv0mpGrKifIFnoZUW/vak+MzT2rfniEFPd8JOxHe4RMPBCeu18BaV
         09l25kmvgFVNBZr+2ODYGcnze1cTYftMXUa0pStPocmM6uNWxqIjdmCKA+/hC3B0Cf/d
         xZVOkncz5jUyyoFbn0Iu+tjlEzhYXJanRvOZrpUPJjdWg5qGu0FqyzcyxF5OJ6/Ke7NG
         HlzwnVgEt07cgI5GvQToxb7cJ/XUCbbgIrM1XhEexiDKSWM9H2riqYZfDiBjkAqLZOYx
         ZxCY1FMqUQ1ly8AnueK522+6CGCp0F7bvOmvgrBJYWBx97tEne4Anl9emrT8xoUqKr7k
         SMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583864; x=1762188664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=Frp9jzquE3Z4Y8Yx6e4F0iXICRm0LiGCJComtYiyLU5JMEjop2KUGrQgetcZENvYzY
         ZvSvV8qWviMddOFe928oBNWDThWghdoCE5YrikmoHPbZIhiwoAXMBNTDQC1IqHrBWHLE
         zQjQqGZ94JuUV2t2m88SROv3jANEUyYbOETcY5t+aYOTlv0Dn6M/kRBE5jRXhQTJ8RFw
         MDvU9n6PwbAZ3ZpxJ8reORk99yvVmpWBK01JVZVbCthW3uDBu7ciPcIArizKQNX4vZqC
         QhroWvskfQNzqbTEwej33hypX7OQY4CZvF7fKgWIFWe16ykfLP2WcPOvu3+lTzJxSSW7
         T+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXFrxh2dFD3HcINxeiKbSrKZRSjHYGASacj66wLyQ+ohImzJjnhWDgl7xeWeyfJrGK+MG39b6cjoibOwKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cW/IHc0J9W1L0mgGMl1IWG0XujSlhshXTNeZvP86koDS5/4/
	7xyF5O7KzGuCx3EZhe7zcBCLmMqtZfzF8cCh+BgiJ08EsMJOSiHIMVTxvMMeKxjh/aI=
X-Gm-Gg: ASbGncupqKVTLL/7TVeHLNtHnY+4r8oqCYRKSI/LAX06oR2T7GRl/kb3yF+AvJO2mDN
	VxQ74MCbOUl2ysziOfEUoGhvLNAGu3qNdHcF40hIXHzGWXvkbaH9+VSV54b8l4MyQbzpt4iWJCq
	uF1moQost7g9r9zTv9t2120dNX9RI8Gs5VIESi55wmGYuy9ab8VX0wsJFBXHqkyi6n/z+jBcDpF
	h62ciUS6MheJvWuxjenDmBroKMTBQray7YwUA+QMNW1SAmFtDc4FGCiCQ8oHd+w1F106od04HEo
	+AjrORmIS2mNB+NYRF29FB3ySvVp6QqF/76rtbY3gPooEOSEW0HkDEi7jatTlC5O4/GROaljitN
	eZKp2p2hvcx/dQnru8/1garzvttKYSSvguCIK0RYLGey32ov9C4DYPkggS2ax6HZ6kKT0iGGpiV
	vEK5S3jYpfA/6wU6/C5XoVcf3TkBw+nD40m8fVmEtC6C4t
X-Google-Smtp-Source: AGHT+IGjTdmlbc2UYCLdzv9SaAZWrdWKW4UkBxQqwzd5S6LRB2MyeaD63PJEhKAkXPLm5tJfWml8NA==
X-Received: by 2002:a17:902:b281:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-294cb67176dmr3769265ad.53.1761583863479;
        Mon, 27 Oct 2025 09:51:03 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70b5sm9075326a91.10.2025.10.27.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:51:02 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND PATCH] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Tue, 28 Oct 2025 00:50:17 +0800
Message-Id: <20251027165017.4189-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
References: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

Just a friendly ping—resending the unchanged patch in case it got
buried. If there is anything I can do to ease review, please let me
know.

Thanks,
Jinhui

 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..77afd5884984 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1608,13 +1608,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.20.1


