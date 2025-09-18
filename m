Return-Path: <linux-kernel+bounces-821309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F90B80F06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226DF62609E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682182F7AB9;
	Wed, 17 Sep 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jENkJ1Wo"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAA2F60D6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125911; cv=none; b=V22DMEL/8H9qCusq8C2BK9Cn3Gh0pcFGAnwuUTmKpRkTd1M4HHcaFa4PAauK/POKLh+2qpjI4FlgEDs6MBnaMUjR2L7jiX+M3sSTVScMwVWnj7DUuN77iaCJ6rx+ypG7oUCU+60jbSVFa9knQ01x+QVKT55uqDOlnTFIEQDhAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125911; c=relaxed/simple;
	bh=bJOnHFF6nZRk0dWJ508IJjqcXP+PPBjH32g7z6c98X4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdCpg4ZEBWzB7oSMhkLxUtwJWR2USO1A2tOdNfERvo1IHgTBotPSDjBfx6tck1TdLvmza3txKl2vSGfIVx4qTV5NCpklCIMhNWj/BOaBM+978Sg7hHE31h3kyEhT0kQNQkkdhXTvcZWV+TbSs06GrAwdn3bSeXk0z3Au3sAgZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jENkJ1Wo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25caef29325so61333645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758125909; x=1758730709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd82b0DJsnoTN910/ro7p5KKbAhv/mwBDCIqGg5wmLk=;
        b=jENkJ1WomaOPOuIJqSqsIkWc3vjLqDcxYhHQs85Mmus9YwCskah3bOGkLNCOBJO0Wq
         oC2i7WqWslBzeubNDwAhssVNDR7liLMHbFuEqIQKtwf77WMGlK7J2HZgW6ABxEtcnjB5
         XIGXPQ+De+uePl021JzAvbGM2ms4WG8DS0IROet4srIuyrB1Fdrf+R7NlTjqvnfHWwxM
         5Kii/lo6enG3rqfKw6lG28M4aF8XHRkPuU6bfU0TbH7cF9A/EYwWqm+jhQhbkSxAUrb9
         3UTQadC3clXK4U4qY7lr+fxsS2r8tMzsFafP5pYaIJauN9J2Y4Kdtsn88qOZF4W9MB52
         5ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125909; x=1758730709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd82b0DJsnoTN910/ro7p5KKbAhv/mwBDCIqGg5wmLk=;
        b=ovH84joomu4HbuuEuD7iL12a3rsEGZT0mBDwJ6GnUXDpDzzFUWSHdrJ3C5O1SP9pZI
         MQQO8176qXcNEqaUOM1tFg9et67nPcJrf7a/ASGMzpav+xeqk3aJOhH3sZH4gMp3GS0L
         LAi1VrELUh2Aac29Io4lSTwcP8NVEnHL+5Pvb1f83SdFJjj47FDDRbnmdznzbXssxaz/
         AERPwYXZEW1HQmYE9dEjDchS1UsXSuOaPZjvD8aVkOi+17HSi8HGjZtAd3N8Sv7tDbf+
         soKA4vJWeU8+mjn+n8LXIjouUDIiLoIVAuN1mw42tEkBWRrqagOS2aernMnwfYIJ0zxj
         rQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXWeHBb7UhANpbfbqumceyuL6EKy+YAI51ICiY0kte+n3uhd5euL86QXoD3wBndHZ+D3+zQr8mM8PLnUjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmbwrdf1t2Gr8+y4Q9CYroSDX6M2PevR3di4oewY0uOTheB8t
	8lIUavEo+Z8Abm+ouMhRYXuIbLMU2uTLSqcn6klo9sKUWhUqI9Q0Stlg
X-Gm-Gg: ASbGncukPstNtq21m1l26T2yQFbrNIBvEiy8FoOwDTSyZkd2OgWjam4Ihxx3/e2GSCS
	DcS8BfY06zy6v9Izkn11wdMdTxDOz4MrZ7mJ1YNdMqZkkupyiWH/UM36aJ4ZStV0fBwKIO4pgAh
	xEuaZBYen73GD6KgO/+SNOMYZxUkZFmzWYFhPlXuYMLNcucbBAdDqjhNqj49wBNyzHOSKJE2X01
	+ey3FFMD7X+VPCRpgV3EuCNCfJe86slnoSdTnSQsxl27a2DKIA8ThbCAQt9oMIHEmUaA/WVMV4h
	oa5wMs99wXGx+FAFEQciQQDaOJPACwRvmn8O5X/tqWAJrp02mGTeZQmOYleeLPmq7Puoj7cOaGj
	OCvndMPKAqjSpDJFWbnURdMqR623+P0tt
X-Google-Smtp-Source: AGHT+IEumcJAF/cXNHip3PFSAZnsvm4uQ9vyeEYv48TfaWGzIQktzfrrj5KrGphpb4CjNEfE204fuA==
X-Received: by 2002:a17:902:d2ca:b0:267:9c2f:4655 with SMTP id d9443c01a7336-268139030e8mr28234235ad.41.1758125909089;
        Wed, 17 Sep 2025 09:18:29 -0700 (PDT)
Received: from ti-am64x-sdk.. ([2409:40f2:4e:f163:e60:9da5:868d:e8bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800530c2sm399635ad.3.2025.09.17.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:18:28 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context
Date: Wed, 17 Sep 2025 21:48:17 +0530
Message-Id: <20250917161817.15776-1-bhanuseshukumar@gmail.com>
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
[  474.694656] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
[  474.702473] preempt_count: 10001, expected: 0
[  474.706819] RCU nest depth: 0, expected: 0
[  474.710913] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc5-g7aac71907bde #12 PREEMPT
[  474.710926] Hardware name: Texas Instruments AM642 EVM (DT)
[  474.710934] Call trace:
[  474.710940]  show_stack+0x20/0x38 (C)
[  474.710969]  dump_stack_lvl+0x70/0x88
[  474.710984]  dump_stack+0x18/0x28
[  474.710995]  __might_resched+0x130/0x158
[  474.711011]  __might_sleep+0x70/0x88
[  474.711023]  mutex_lock+0x2c/0x80
[  474.711036]  pci_epc_get_msi+0x78/0xd8
[  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
[  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
[  474.711072]  __handle_irq_event_percpu+0xac/0x1f0
[  474.711086]  handle_irq_event+0x54/0xb8
[  474.711096]  handle_fasteoi_irq+0x150/0x220
[  474.711110]  handle_irq_desc+0x48/0x68
[  474.711121]  generic_handle_domain_irq+0x24/0x38
[  474.711131]  gic_handle_irq+0x4c/0xc8
[  474.711141]  call_on_irq_stack+0x30/0x70
[  474.711151]  do_interrupt_handler+0x70/0x98
[  474.711163]  el1_interrupt+0x34/0x68
[  474.711176]  el1h_64_irq_handler+0x18/0x28
[  474.711189]  el1h_64_irq+0x6c/0x70
[  474.711198]  default_idle_call+0x10c/0x120 (P)
[  474.711208]  do_idle+0x128/0x268
[  474.711220]  cpu_startup_entry+0x3c/0x48
[  474.711231]  rest_init+0xe0/0xe8
[  474.711240]  start_kernel+0x6d4/0x760
[  474.711255]  __primary_switched+0x88/0x98

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

The BUG arises because the EP's Doorbell MSI hard interrupt handler is making an
indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.

This patch converts hard irq handler to a threaded irq handler to allow it
to call functions that can sleep during bottom half execution. The threaded
irq handler is registered with IRQF_ONESHOT and keeps interrupt line disabled
until the threaded irq handler completes execution.

Fixes: eff0c286aa916221a69126 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note : It is compiled and tested on TI am642 board.

 drivers/pci/endpoint/functions/pci-epf-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd..b9c1ad931 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -680,7 +680,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
-static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+static irqreturn_t pci_epf_test_doorbell_irq_thread(int irq, void *data)
 {
 	struct pci_epf_test *epf_test = data;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -725,8 +725,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
-	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
-			  "pci-ep-test-doorbell", epf_test);
+	ret = request_threaded_irq(epf->db_msg[0].virq, NULL, pci_epf_test_doorbell_irq_thread,
+				   IRQF_ONESHOT, "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
 			"Failed to request doorbell IRQ: %d\n",
-- 
2.34.1


