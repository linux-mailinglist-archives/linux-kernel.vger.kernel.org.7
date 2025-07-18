Return-Path: <linux-kernel+bounces-736116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA81B09902
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E00564AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4629405;
	Fri, 18 Jul 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffav9r9d"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51823191
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752800162; cv=none; b=WgdhqE/8rLpMNnEaoCR5qikVsGq5W2fBYC2sD4ArZ6KjkYNxOJP0aCaQzbAXGIkdS13LPMehvU+3+VjUDaeyeHIAD640ijx+61lWWzrUr5n0BdHVx4mCFO5KdEVzVUcLU4RqCWHuhyrSTW0i8vF26/m07w9xMRI6xjDf0d03q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752800162; c=relaxed/simple;
	bh=8sEFwIfaLas9h20Ro7TWFWnsgpYwuPC1TpV16qGyanU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=poQLVpRcKDa+4jFirMWotqI6iMxI9cYGkvPDtON4HOqFatSYaX4pfUaGybUQJXUP6lOjyppS05CXvdVzU7TIcgRse3srQaV4rITZGx+aoBXohnmIbh7+NClh+jRL9nLDJGSBQm6f0b+kRUywsDoohy52gVTf4fMmkVG1kr3mDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffav9r9d; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab82eb33f9so25945631cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752800160; x=1753404960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5y7rYvuoQbC5fB9jD5hc2/oRm7S44nHPBSjuUalivDQ=;
        b=Ffav9r9dDUH9Ol/gHfvFIbCDdidSUS6BFso0/m/livGd5WvNyW5Kies9xshvFsjM/x
         fAzV8NWZZzRBU8xrVJUwAs91d06Up6Pd2PxWsbMFiyJnIc3RwTosE42TDvzfR+BplZV+
         Yqy9W9EpA6Gx4MjeZTqiR5OLAPMGWSEXwWUgaZIftu+FaKHTU6XeCCtPBFiqbaa9VlpX
         S2Rsc+CyUfWZjT6wbfCEQx08fRmR++uVRGYoSrLGLlNoarRq7v34Hqr8aOLvHUMXJ/ja
         mPPAJHi1O37gP7MCsnB1AM7m4dK5qzUImvUqjSScKDgAxm+cFhCqMK2AsecwCC9Qp0eD
         lL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752800160; x=1753404960;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y7rYvuoQbC5fB9jD5hc2/oRm7S44nHPBSjuUalivDQ=;
        b=Jk0pwHKxzLLFQdu4kGqC3kj12xrlpPNKbuX8jAXnyzSt4F6OJOFEweuLPTDxhhu8cG
         w6j0vs86VCWHFkyXTXWpQMbUGJn5VnIoPBMVB6rXxVATX6MKYxj6TKIijeedOkpIm2CK
         AzWDZ6L+gNOIysnbzBLKDeY8hgoVk8lnD2fshncNPs6MejEiJJs6osAy/A0/LReoRJGI
         3akTOVOLvPUy5EGTjjXCM30RJMlUFM8QVBrjwsQqzib8Jd1IwkbwDyA+Y2HIhzPPAhlk
         00+P9jbsZJ5BV77drY+sqVrbcpnT4jRvBN0ojKC+jNxIh9/ok9p88VSFuvAJvLHEpsAL
         CJag==
X-Forwarded-Encrypted: i=1; AJvYcCXfav9D9pDvGtEN49Ej7Kvrdi/S2YD1eTedb6EGpPlFZR5NuqCB37q8rmrJeP2bl5bLRIj4lQ9IFXL8gsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7s/1pvhst/91VsK5OCMPfyhZy5MP82FdENORiYt3qcRIXqPx
	sltfGnoyxnA+x7NaZ8Qz9Y6qT8aXUhHwS0cS9OVTpfnndAwv90aqCqdFRcBMBg==
X-Gm-Gg: ASbGnctBcczcXwEiiFjQV/WMu0CitpGkPGsCqnnyFFTHZh5AtDr6HZsTWu2fcwZ1Hf+
	DBSfD76CH2OFArW0FrPCX92Cr2RROc9neP75f3bpG+5DV31NebBH5uQzBgGm8SNXrrCVZwP0U1D
	Qen+4E7qf7iMOeBK40rYtz6NCGexDnsQp3B79+SRUZ3+uCfQ2aD91qMkMKDU2w8lLdkTZGXEb5O
	0PK+G1kzbiW6VsTspBm6tZY3EDG5Ej7LoGb+P6DTrec/ieAFmmSaUAK2YQnDr3qLr22rHctGyz8
	6vIxSNLuZdwUxO0eDA46OTnsPYEDYhEvcHY65l7euGhnJ/EjrrmrK/znB4XiKyLHqul1erWBckA
	UE6Mngs8Pau8=
X-Google-Smtp-Source: AGHT+IFXZDliFQ2bb16oj9g66fwylVoMivg8Sj7LGmOA/tKGoFMCG7aCUcuLYBfhbXqSaz95bIBV/A==
X-Received: by 2002:a05:622a:1e14:b0:4a3:398d:825c with SMTP id d75a77b69052e-4ab93dca61amr136098231cf.48.1752800160112;
        Thu, 17 Jul 2025 17:56:00 -0700 (PDT)
Received: from pc ([165.51.18.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b4caf5sm1455011cf.71.2025.07.17.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:55:59 -0700 (PDT)
Date: Fri, 18 Jul 2025 01:55:56 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v3] char: xillybus: Replace deprecated MSI API
Message-ID: <aHmbnFJXWMWgS5Lk@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkkU-BHX2Zn0SWY@pc>

Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors(). And
add devm action to free irq vectors.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v3:
    - Some checkpatch cleanups

Changes in v2:
    - Replace PCI_IRQ_ALL_TYPES with PCI_IRQ_MSI
    - Delete pci_free_irq_vectors(pdev) in remove function
    - Add devm action that calls pci_free_irq_vectors(pdev)

 drivers/char/xillybus/xillybus_pcie.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 9858711e3e79..373b3ccd2e8f 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -32,6 +32,11 @@ static const struct pci_device_id xillyids[] = {
 	{ /* End: all zeroes */ }
 };
 
+static void xilly_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
 static int xilly_probe(struct pci_dev *pdev,
 		       const struct pci_device_id *ent)
 {
@@ -76,11 +81,21 @@ static int xilly_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	/* Set up a single MSI interrupt */
-	if (pci_enable_msi(pdev)) {
+	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (rc < 0) {
 		dev_err(endpoint->dev,
 			"Failed to enable MSI interrupts. Aborting.\n");
 		return -ENODEV;
 	}
+
+	rc = devm_add_action(&pdev->dev, xilly_pci_free_irq_vectors, pdev);
+	if (rc) {
+		dev_err(endpoint->dev,
+			"Failed to add devm action. Aborting.\n");
+		pci_free_irq_vectors(pdev);
+		return -ENODEV;
+	}
+
 	rc = devm_request_irq(&pdev->dev, pdev->irq, xillybus_isr, 0,
 			      xillyname, endpoint);
 	if (rc) {
-- 
2.43.0


