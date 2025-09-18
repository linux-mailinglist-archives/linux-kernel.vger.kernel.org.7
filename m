Return-Path: <linux-kernel+bounces-822076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61202B82FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25221624315
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A0284888;
	Thu, 18 Sep 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U17fY/CR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB128467B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172607; cv=none; b=H0/t4+/huAwlfPZiCs9A9/Rt3DnOASW/XK1mxJaTh6XgV9KOK5oZguD16fLr/gGyXCsnwRhuwGC+lwTHymaBLrkDLI/ikWmtO70sLh+xFg9D3U13NqU29r7N9LeZdnGT81yPhQ2c5uAw3nkyCWwULHrtkLbUCeJ+t/ImpxYXoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172607; c=relaxed/simple;
	bh=YUEZeH1TUt8vhd5nOMxaCkzJVaWiSM7ZZlNxkfxZqDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu5zuX1LSnCgqXoMW7lAZBrzezyltnvNck/FKeSUIr7qW+yDAgUONreUwVwbabZn97jcJEOrVrVZ/MEP7VXEDdUX+Iu3pzw14tdX6GMSaMuMhsK17U/0p+ifrAWCvjgtq41SxmF7JzTlXIXTjBK7SAiDaVPlSNBzL1+G46cKgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U17fY/CR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596921so5715405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172605; x=1758777405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=U17fY/CR7P3v8UpIWB6TpsHwOd2QkrO9apokwotyFL90cAKItoh0d5ehJ0IBTe7Tyd
         Ocwrs21wOSjYKS9PrFp4CL0/78ckc/G1mMSfyNITJevs1ZGXD8BGvg/9keK7mIeHDe8O
         B5l2WmTS/VK2AURnqFpSUbyZ2aOUhuaZKAMx+mVjc/fAhmYmyr2mKbDj5bbBiyrTMdTP
         QQXkjQwkuRUZZYTErISnc61ckY/dzScY7OphbjjCyxWGxKdfuLfkzDaJNlNYxp5mPe4/
         JN/xreaI+32dlD/gRDbpY4gayEgvSKYR8zaQ/b3/TWCfG/lKKKPeqPxvxoBSOhAKbvQk
         53wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172605; x=1758777405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=SXMASRtxObT1cWPY/VO3B7ZMkCOyMVnxEg2NH0vNPvogSf9Grr9KHK3sXddQk0rwJ+
         O/lEDcTqeoTKmeKeocSdty0qdqGWm0MfLHRBmKIj0XdTUcDyw6tbPrfgiTKD7Kr/QACv
         v4+il9v8cD8tRTBtOXedrqIlaUqpu9HDXdq4tzh0t0illX+S5ttWdLekyiEdfzWdbpnl
         YgAVeub2C1S4pREt62qAwnUb15wpGRBxVMRlqK760UFgN87iesGI1OzLEQHyrsQ/Y09X
         XEf02rnj44Gfg456r+hDzTyQeIVt2PLZBBnX5IKSo75faMhdLDuAFzaFgWb23vR6ZnSP
         bAfg==
X-Forwarded-Encrypted: i=1; AJvYcCVIPWcePUr79WFEN22UEx6HcSKk9a8xn6T9xzH+TEsIQgz9nl4HhYZ1lmqZkBilU0WXVUYbuIh/uvg8TPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywar8pSd8TTu/NKrr109sdPtmg6DIf4W78MccH4xHMkRGslB3nR
	5d0rlT+QcuSpQbsPQKGbd2WtdKOFZxZP/4eEMCVtb0k5i/jtNmMeWSBrb+XugQ==
X-Gm-Gg: ASbGncsRzuEDgAIUsfV5GRu2+uRqjPpSmxaplUrmBZDImIPcg6pdr5TMvZRkaQ05O9q
	CVcXmEUly3VypkMCkWSTpa7nFo2BIv0JFTn6jEW5z2buMwX7gSRByULuqo8Ra1gzxKgbu78JZjl
	r2rdOC5W+ONs7AeZDhiorDFaZJ1x6F+gB/JEs/H4i9I2Va8TIYECitO2Aue3FkB0Fp6z377R86D
	hf6L2bMbjKtjnes9mvDOb/oXCwZHL7Ro3USnOniYROaJhUHKBuFB7pr6KwEb8B2nEbiF8IcBv0m
	pcREHNK39dy5Mf5pA972ZAQ3I7zEVuo4zgFrgpa1mMHAV0/43ortpRh6e+33Cq/af44MVTfLB+o
	sjWG9YAAyQiNmpfDhR4cvpk920eZN/rNOu9Q84X/b/nsTSbDMr77ybxrsfBrlSR8UKkgQCcjnIb
	ualLEKpuOUDuc=
X-Google-Smtp-Source: AGHT+IENUWJEnq6oE7Ax3BDTY7kWNNijSyVEXEQa7OevR8qtv4uLVgHLKbgA4U1otQAK7eBXyC8eSg==
X-Received: by 2002:a17:903:298b:b0:263:7b6e:8da0 with SMTP id d9443c01a7336-2681216b6d7mr52232155ad.15.1758172604780;
        Wed, 17 Sep 2025 22:16:44 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980329745sm12581375ad.121.2025.09.17.22.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:44 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DC5101061EF2; Thu, 18 Sep 2025 14:16:43 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 09/14] x86/um/vdso: nommu: vdso memory update
Date: Thu, 18 Sep 2025 14:16:02 +0900
Message-ID: <973b16819b91b5640029311ee8385059e3b41e71.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/vdso/vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index dc8dfb2abd80..1c8c39f87681 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -21,14 +22,24 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		goto oom;
 
 	copy_page(page_address(um_vdso), vdso_start);
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 
 oom:
@@ -39,6 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -63,3 +75,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


