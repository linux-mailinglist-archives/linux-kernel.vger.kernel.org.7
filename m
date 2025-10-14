Return-Path: <linux-kernel+bounces-851710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC80BD71DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E586406FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F763043C7;
	Tue, 14 Oct 2025 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjvD61bz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF0306B2D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409692; cv=none; b=p2ZLM9iwGnf/795Vl69FceOM/jnJQwF0vC9bQMeA5ZXNYkL1ZBOZIyLmTPpztoggUd/wmj1g6hDo4f9r10uWvGLBeiivrf6ujaiO5p1kRnj+09K+VWcz8NQX2NJZjT6c/P7qfKPGdDFRsVs0LY1r7auHzrhpvcNW17S86KVOpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409692; c=relaxed/simple;
	bh=jM4VfDDT9o/5KEiX8vxhJ4DNOc3U9+2v7a2kcqEcNmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nxvm9NaCSaqxPeRI6b6yzFNFl3paKnL7cG1E8HVKqEP9qF4gn6r1p+b9C+zdV4FRQxp4+VxaAx/qkqya6vYPkFi8jf++PmuhDHknPa6JWTzCMY7ELz03pwQhCwYpP9WIPBokY/YSjyeiB27586RzFfq+fU+IRHqDNBCRPGgTDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjvD61bz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so4634028a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760409688; x=1761014488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1AsgWZdoSmBmACCUATUp5pGfSqbvQlK72tCjitQTC8=;
        b=ZjvD61bzxEaoi+o26vwh5BJL7cBib/mJk1POWV5237PTJfRJHwIBZ21fAgxNgQSohb
         OdXCENRN9VWvMzOvCriGWsS3g+0mc3O/1u+ou1mnf1rBbH3Bk40MzsTsgCyDSbNT2Cuk
         +s254IPgwbtrf5vh0UvqfnZolEsrfe7ZKBvAfO+dcN2uh5Uya2y8yKbEfi4MO+/mWDG8
         VNhTIh+ZiF5IoxJUQJjuQ6vXzAp76+2YaEEjxLo5XslXqYBbmGr+YoOX8JgSI3QymZqJ
         PRa/wYiPRBjCEmI/mIGGaceDgrCchOXDevvZKqnUPDehZJYk9jhO1rreMdlCrB685GLT
         TGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409688; x=1761014488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1AsgWZdoSmBmACCUATUp5pGfSqbvQlK72tCjitQTC8=;
        b=e6wqCwjBSTPmW/as7IZzFlXtTDImN8cU2kCBrn/k7SPMt4kmSSJiS0at2yz69QUOUG
         0u9suQgqAJ7ibms0jaVArzFdsZbWj8wY+MpOqKq0lxD4jdgzp7M26OAHI6zla3U/vih4
         CJ95cInRDwK88PFhaHqbxcHEPvk+jBJubpd0xqPqq2DDPOsUJ5dk+y/52R3jTxC8hYUd
         vGht62QG8EGOzcsZ08qeaQjwt80u/+r1t/WS3sMu47KmL8vUpa8wgHhVrSEWZV+vnLOQ
         GzvnwCHhpC/LiM2YrAvF5at2RI9P3hVyMVvkc+j0Kh4A3mi1kJJ5ALaktyS39PY8yOEq
         LLbA==
X-Forwarded-Encrypted: i=1; AJvYcCXSXvLqU/THvejsq7S8LTlPZ8M+3s+JIPmYG4MJIid2EQeZvoHvSl0e2aHKmQzGF/Exag2nBY54Bu9Dh5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtlrv4+CdHblJUcONnB3ETAFFtxsRyqqxLj+eGzyeQ3sENjVf
	VD0xmYaHAIOk7y9jjaCgmunhF/gWjALCTxGY2/tsWSoYtBT+dy/fxl+o
X-Gm-Gg: ASbGncttf2Pte4RlJKTzxpreREZ/XJzITd8o8EgS0wZy9+iIP4U5NsJLMMb0SRvYZhS
	UizzXpk/SJJKQsp+KbAZ9V7nHFVfSJbDPPGYG+oVG7xplyJgZr/M/jyJpZxbhJxCCXhsp1/9R66
	S/qdDkBFyMQ0POYkgdLgzu/GPZReHPMFo7SGVx/4lHTli7FMGVi6jdSKXDazH6p7HkbPC/LYm+Y
	9c5dpBj4Byuh7zr9xQkxasJ25ddWJIPvhW/HZOxiCSioc1px0bgWxWsJ8fJkqeHpLN2VDYTsv6z
	qhShwJsHMZ2bV93nM6MFvvJDEUzG0yolfPHqy1yAmavkmn/ixUevLhXohgsOV+rsfkkJRDTBcNQ
	24VCrc7VVonCnTNOQ1u3fjimx+MFIXk2KDzFGC62Lnfu0ercI78Icw8FeB5T25OWw2lpt/jlbob
	Fo/kCerQ==
X-Google-Smtp-Source: AGHT+IG+wGyTO6i418tFyeF5ZIBvx56+NdDpnWWC78M802A2HC3tEEKBP08Ixtj/5cmGK53IKP9RxA==
X-Received: by 2002:a17:903:4b50:b0:246:a543:199 with SMTP id d9443c01a7336-2902741e471mr303964665ad.54.1760409688398;
        Mon, 13 Oct 2025 19:41:28 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.140.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm147442065ad.121.2025.10.13.19.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 19:41:27 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mohamed Khalfella <khalfella@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH v3] PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context
Date: Tue, 14 Oct 2025 08:11:09 +0530
Message-Id: <20251014024109.42287-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Root Complex (RC) triggers a Doorbell MSI interrupt to Endpoint (EP)
it triggers a warning in the EP. pci_endpoint kselftest target is
compiled and used to run the Doorbell test in RC.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
Call trace:
 __might_resched+0x130/0x158
 __might_sleep+0x70/0x88
 mutex_lock+0x2c/0x80
 pci_epc_get_msi+0x78/0xd8
 pci_epf_test_raise_irq.isra.0+0x74/0x138
 pci_epf_test_doorbell_handler+0x34/0x50

The BUG arises because the EP's pci_epf_test_doorbell_handler() is making
an indirect call to pci_epc_get_msi(), which uses mutex inside, from
interrupt context.

To fix the issue convert hard IRQ handler to a threaded IRQ handler to
allow it to call functions that can sleep during bottom half execution.
Register threaded IRQ handler with IRQF_ONESHOT to keep interrupt line
disabled until the threaded IRQ handler completes execution.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 Note : The patch is compiled and tested on TI am642 board.

 Change log
 V2->V3:
  Addressed Bjorn Helgass review points in v2
  - Rebase to pci/main (v6.18-rc1)
  - Add a space before each "("
  - Remove the timestamps because they're unnecessary distraction
  - Add "()" after function names in commit log
  - s/irq/IRQ/
  - Rewrap the commit log to fit in 75 columns
  - Rewrap the code below to fit in 78 columns because most of the
    rest of the file does
  Link to V2: https://lore.kernel.org/all/20250930023809.7931-1-bhanuseshukumar@gmail.com/

 V1->V2: 
  Trimmed Call trace to include only essential calls.
  Used 12 digit commit ID in fixes tag.
  Steps to reproduce the bug are removed from commit log.
  Link to V1: https://lore.kernel.org/all/20250917161817.15776-1-bhanuseshukumar@gmail.com/

 drivers/pci/endpoint/functions/pci-epf-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 31617772a..b05e8db57 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -730,8 +730,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
-	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
-			  "pci-ep-test-doorbell", epf_test);
+	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
+				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
 			"Failed to request doorbell IRQ: %d\n",
-- 
2.34.1


