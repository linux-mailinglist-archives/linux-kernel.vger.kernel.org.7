Return-Path: <linux-kernel+bounces-836985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88889BAB088
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92DB1924338
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C918859B;
	Tue, 30 Sep 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaUREYG6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD9186E2E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199901; cv=none; b=OSPnBlrkcNEiPMY4d4Q0Ud0x4VHVM7YEWRJT37MsNjRr8qWEm7oY6Rnlu6ZVU7JqC/2xK6sxcofba9gvUEWI2PapYGCkYcuQ0wRvynT+bfXQo7lIHKuLBNgqPAmvGlZzfMX8l/ybVvUR/U+6ebjz/LMCUpEjEtwQlZTbS2rV3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199901; c=relaxed/simple;
	bh=ehjgd49ctoBMPKXxoGCYDdif6tDZ783PLrpd2+SWkC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEXeP0319Q1e6382GOxamXlPHRyHlj+7P71t+DMfFOpasiEzN8Xdk3TCEJJLadpC0x4RFhq5sAtmFbm5LtoNeIZi5tL8oZ56ztz/ZrEKxpqWLpJX5eSPB8kzXut3w3533avfhAkzluqUeLQcP8lZ0wJUujPzGUKB5QIzl4LchfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaUREYG6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2897522a1dfso17678965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759199899; x=1759804699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idpmqO+/M5+T+9HgrvHz/cjNgYorjEMLx91cVALuleo=;
        b=BaUREYG6HCBp8nBJHxFTXjGTDEypd/dLXh7pLd4jicLgqr3tzibGju6deE586V3Qze
         4utw8xGN02tlXxT2TDUpCtSKoIEb3vWoxbqYPs/PU/WY90HH8vBoOFd6CBsYCQQNxD34
         YZV/EQddaLYqInIkf3MkRGBylCLa87E/7gt1XEFP7qtTuJ/glRLRadBHW2CCi/JmCIgL
         Q5FIt6pNh8dMrJQWsSSrxOq8xWpIfSuGsGrn3d4FPcyXP3WdLq1TBR8t1D4j05fKuMUv
         W+RfIHawD1Ie1pgOwKLQ1jS+TOIi0f+WVf9dsLMtkiYjLhRJTTFBXh8DGWjolNOI4BYX
         Edpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199899; x=1759804699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idpmqO+/M5+T+9HgrvHz/cjNgYorjEMLx91cVALuleo=;
        b=VhFBkGXrzY3WgIrVXx68ilW052mDAX5eFAYSxMaUv7pEDskl4l8XfYqxxWEmLNyl6D
         +NzRVCrZ91IuHA1iSGMw16Y0yxpJnUKCvq9pXV/XjNVMsC3NAw7eAFSXf+gOsd+SWF/I
         e7FzrfWjTwhVYFQzTpeHGMyRpoVRjkoqjy/oejxC5ncyI8fc+wNwRxcvY9mwbyBkQwh2
         BV7datChMSJZ8oK1S8hhp4CnqzXRQF8WGFnNFXHrO6axZciQOXLSvoTBUrMfroai11XL
         JNHpIwdz4LFnVG4yC+aSA8MfA728Cy2wZb/+o6hx00QIp22EUIcOtcwFPMiAkdTvgNb6
         K+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF6iqgXx/s8j0vHuyztM7JTKSVJmwtd/mgzBynDtAjidUefaUzJA7R3hR2PJGfLdIQQSuGni2q6wmuQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKAHcOSsTqjV0MIcDOzTVEnDvGbp4dQtNizY8nO+Km5S3LCkm
	74r7qgfp4VBTMhEKGZO+6WGcAjgKpxV0lsMZaU2E/53AQtaVwMxiFUN2
X-Gm-Gg: ASbGncvPU99+0Ch4sf4Ee4eRdrAVPy5tyN79XFF+U1LRZU9jzcqdFtpYvQZ1kPQH52S
	y0QqvKsvz+lBCZgECHaCaG3Nj0eGZiFWgCXSjvW0JodlUdKJf6baXyQSqVsRAwEoyqZrDriZQ5V
	UH1CH+rVwz9Gy0TJye45lrbRt+tOvtWbY67XumH2GKJrwCAUXj8BKR2/ZC4BauQEkl1P/hgD0yy
	kU8hvHhUcyfoa6LQ+oYVMvJzwVKyw9j2Q/4cM/ERiuLw/DfJYMYJjkQs9EYhoXyBrZFBCB8eAf/
	D+6RrElgT3Ys9RHQnwkUqtngKSUJqf6bOjyxBW7w0uefAEXUA+NaVhvEk04LeGv3+nN8v0XR8br
	JuZiEYm94KC5G8H8zcOY5a3XTSPVO3ay1wsqUx3qZ8Qtpq16Le1aw3yxaga7hnNR0hgGXJ1M6fS
	jhBWstQBLGfh0Rm/nLdrGL
X-Google-Smtp-Source: AGHT+IG+tNEJhvC6KbONBG5CcwIIiSbeUCckEf11aDbSSGtQFaHXDj3dSNyzsdKDHvbHhywmREudkg==
X-Received: by 2002:a17:902:e882:b0:269:874c:4e48 with SMTP id d9443c01a7336-27ed4a4bb09mr223205055ad.47.1759199898837;
        Mon, 29 Sep 2025 19:38:18 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.103.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bc295sm144810785ad.123.2025.09.29.19.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:38:18 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	dlemoal@kernel.org,
	bhanuseshukumar@gmail.com,
	christian.bruel@foss.st.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context
Date: Tue, 30 Sep 2025 08:08:09 +0530
Message-Id: <20250930023809.7931-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.

[  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
[  474.710934] Call trace:
[  474.710995]  __might_resched+0x130/0x158
[  474.711011]  __might_sleep+0x70/0x88
[  474.711023]  mutex_lock+0x2c/0x80
[  474.711036]  pci_epc_get_msi+0x78/0xd8
[  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
[  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50

The BUG arises because the EP's pci_epf_test_doorbell_handler is making an
indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.

To fix the issue convert hard irq handler to a threaded irq handler to allow it
to call functions that can sleep during bottom half execution. Register threaded
irq handler with IRQF_ONESHOT to keep interrupt line disabled until the threaded
irq handler completes execution.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note : It is compiled and tested on TI am642 board.

 Change log. V1->V2: 
  Trimmed Call trace to include only essential calls.
  Used 12 digit commit ID in fixes tag.
  Steps to reproduce the bug are removed from commit log.
  Link to V1: https://lore.kernel.org/all/20250917161817.15776-1-bhanuseshukumar@gmail.com/
 	
 Warnings can be reproduced by following steps below.
 *On EP side:
 1. Configure the pci-epf-test function using steps given below
   mount -t configfs none /sys/kernel/config
   cd /sys/kernel/config/pci_ep/
   mkdir functions/pci_epf_test/func1
   echo 0x104c > functions/pci_epf_test/func1/vendorid
   echo 0xb010 > functions/pci_epf_test/func1/deviceid
   echo 32 > functions/pci_epf_test/func1/msi_interrupts
   echo 2048 > functions/pci_epf_test/func1/msix_interrupts
   ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
   echo 1 > controllers/f102000.pcie-ep/start

 *On RC side:
 1. Once EP side configuration is done do pci rescan.
   echo 1 > /sys/bus/pci/rescan
 2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
  ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST
  Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.

 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8..c9e2eb930ad3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -725,8 +725,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
-	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
-			  "pci-ep-test-doorbell", epf_test);
+	ret = request_threaded_irq(epf->db_msg[0].virq, NULL, pci_epf_test_doorbell_handler,
+				   IRQF_ONESHOT, "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
 			"Failed to request doorbell IRQ: %d\n",
-- 
2.34.1


