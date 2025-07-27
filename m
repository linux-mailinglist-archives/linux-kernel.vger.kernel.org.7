Return-Path: <linux-kernel+bounces-746951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AEB12D95
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DD717DF1A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91B15E5C2;
	Sun, 27 Jul 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZkUrOTj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04718E20
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583427; cv=none; b=QbJrmLGUcWQvq80cQvVH+1CTsGJi7qpj0JozkzYAouIaAkM+sYZTWQnJTf+Kg8F/b0LnJYMRr4uTm5ItGy39DQkOPC/Oos9Uga85E6AJvRM0mGsNDOIpexj6ubRI8RHhHzXPetL58Xj7wlm2HkyjnckI7Rw3hkeKvxRb+0zA12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583427; c=relaxed/simple;
	bh=xyYHJnPYZi7qQmwbNjurNT53s0whjnW2/o/OHGbkq1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGm9Yt7B4AweL7Ax/G0e9KxkjR8H7vv7o3f0J9EvZBoVDB122pRsNHUDcp5KknLPyPEpsUstPMpAYFLA3d8OwGAZGvZTHA8t5lgC0BJUjTB6xh6ARR19CoF+jAUmydFXIQrn/Nh+bVW6YIaEBgcl/1U4LEhhI/moZZ8B9YmNl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZkUrOTj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so23127735ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583424; x=1754188224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ+hpH9hPQGwkZYBpJGlkdnOAxD2Uu785fX/CLQgkPM=;
        b=hZkUrOTjt+1SJesxOe82RDeJ3nw9C4aUtbkeAbC3Sn3irCE8JA/IQ55Fg06vbVEOlx
         +ZNWASMNxaCuyMSmu2repx+0Hrfpj2G5ol4moFH7NwDw/STrZT4CVwtJdk+S6zVGy8Qf
         Eh0EPX3dLJCLXuMK4WPyykBbQleKlvISJMiQJWLcLttRls9VgnhzHy+Ym5GONHASM/o3
         rCx7z654TbXbeTWQBfvVa5T2bIJ7EdbO9YsKUa4aIeaKAdNk3/erGUcN/+wv7TtQfJmM
         GonWSM2AkmnDcEUu7r+FuGs2E2/td4Z6EPORmDAsyyx8WZxD5JtyP4kMadK6C3CLkQkK
         zJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583424; x=1754188224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQ+hpH9hPQGwkZYBpJGlkdnOAxD2Uu785fX/CLQgkPM=;
        b=Ob6c466ZC21HnW+9WcAVDpxaW8B39MCvFYQX/Z8sstbkOSGpoR2Cu/vw70c6gz30Jn
         g4JBv9BXH7JtWaprduIQgqyS3NGEitxE928f7Nc/DqGQV5Brq78mez4KRNlH6S8RgJUq
         TKeBx0lQg5r4IhoVrPhAlvi8bl3RHTr1f73CH+pKTMSKxoqb+7YZ5PA1V9XCzsmWYUTl
         v5aIJ6e8qgh2dFakckefDOsHJKDK8NYbJ+ZpHmAw+SYaJPtO2T+MPpeW3UR3GD2yQQ9m
         oeQLdk4E19Ag3bUAsFbsFq9APN3c0AstDIl9zwbItueVZaNlqXlSsS0aU+lh+B+aHId6
         Ox7g==
X-Gm-Message-State: AOJu0YyusTEy0Xvpy9zbatwCjMT19Ds5Cd+p89ts0+hslQWtLkgBgcoe
	MeNyrUylVh75z6OeiHu65DNd4fL5N9UgWcwLIB3/eUiUC4iZddw9C6SGC0Y4QWKt
X-Gm-Gg: ASbGncu4GfQc455lyZIZ+G3hQCduUzHpMUM4ZOotz1cOQ+d2nNAjBsGHwgR9Dve73W5
	lpvmGUBREiAZyoyNO5Z3DqhhCUobOn9pGSC0UZxqUH8zwAVV+kESQiG1RvRGEpxSu0S+nBi/2ym
	1yIBmsjRD9Za3TTpJ+EMfFVLOw4k0LJH5BSSLWUqUmjY4esnONoBLY9+cVaSY80LFVOjN5R5Oiq
	1wqjb3nbQDElZL9uNtjOm6PKyn9jM+o+to4mD6pUL5Pxq1XFUGJCZKeZ5GRkGbPgs+8bEnriFnv
	bKo6m0z6jSvIrg/Qfhayzh19ANArfGorKFCfcF2DMWOJL/lcGoRnOJrxhjM3fN6tWVxYRRuL6Nh
	UFVOInlnhL1Ow6PHjvSp1mm2YTd6NG96FSj5VxdDC7w7x22eerXqnA7qS
X-Google-Smtp-Source: AGHT+IFuO7ZGqU1Foc4DDrHhCEqNJFDc5V0opwkKxHeWT2iWx461jV6r1Ns4pBPJj83O2Yqwmx/mZQ==
X-Received: by 2002:a17:903:1b10:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-23fb3100edcmr131330855ad.45.1753583424555;
        Sat, 26 Jul 2025 19:30:24 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240087fc42bsm3163555ad.153.2025.07.26.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:30:24 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/crypto/cavium: Fix typo 'interupt' -> 'interrupt'
Date: Sat, 26 Jul 2025 22:30:29 -0400
Message-ID: <20250727023029.82282-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 54de869e5..4ebdb4488 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -90,19 +90,19 @@ static void cpt_configure_group(struct cpt_device *cpt, u8 grp,
 
 static void cpt_disable_mbox_interrupts(struct cpt_device *cpt)
 {
-	/* Clear mbox(0) interupts for all vfs */
+	/* Clear mbox(0) interrupts for all vfs */
 	cpt_write_csr64(cpt->reg_base, CPTX_PF_MBOX_ENA_W1CX(0, 0), ~0ull);
 }
 
 static void cpt_disable_ecc_interrupts(struct cpt_device *cpt)
 {
-	/* Clear ecc(0) interupts for all vfs */
+	/* Clear ecc(0) interrupts for all vfs */
 	cpt_write_csr64(cpt->reg_base, CPTX_PF_ECC0_ENA_W1C(0), ~0ull);
 }
 
 static void cpt_disable_exec_interrupts(struct cpt_device *cpt)
 {
-	/* Clear exec interupts for all vfs */
+	/* Clear exec interrupts for all vfs */
 	cpt_write_csr64(cpt->reg_base, CPTX_PF_EXEC_ENA_W1C(0), ~0ull);
 }
 
@@ -115,7 +115,7 @@ static void cpt_disable_all_interrupts(struct cpt_device *cpt)
 
 static void cpt_enable_mbox_interrupts(struct cpt_device *cpt)
 {
-	/* Set mbox(0) interupts for all vfs */
+	/* Set mbox(0) interrupts for all vfs */
 	cpt_write_csr64(cpt->reg_base, CPTX_PF_MBOX_ENA_W1SX(0, 0), ~0ull);
 }
 
-- 
2.50.1


