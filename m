Return-Path: <linux-kernel+bounces-735626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12CB091AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274561C42019
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDE2FCE02;
	Thu, 17 Jul 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN1jZygh"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF42F9487
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769625; cv=none; b=rHAJeINPdkmh09qWsNPGWRdvIN6yINt8D8JPgz699IGMRSv+6NuBTYdEE+O40o79qXwC3O9+mB7jQL4ySsRnT0ENPDEtMpIfpQy1Dh4OBEeuuY0D+jHSMzRup+UOwfu9YFCEn0IL27LYlV6eQ7BsHm2OtMfD+uOEXtBaFmw0GYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769625; c=relaxed/simple;
	bh=hfXMXUKEWFwJgC4K/6+tGXth94IWkRRTGIeiIx/SN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cYMGv17xDgAX1sRRw5AAcDTnszH/bHqVDcVnrIwcBt+plOXG7shv++fX1oRoMlZ5HRqZwi6tnGfq7j/N8quCt5ENii8d+CZyHXIyxXpcSrSQFqgCnIMxdMe8pqZO6amZ5WnGedNJf5X7C91AUV01zDywe6dbL6PFY5hCtSWNXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN1jZygh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3f192a64eso112478885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769623; x=1753374423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAT5fXFHSpJYGBHtSFRK2w1oMePzqL3McbArpEULE/U=;
        b=AN1jZyghKGQMat9YKS1OrOAkYGdhwyjDd04jFTJMlf5f0QIMfCtlysfXUp3DHehiFz
         q0nJNgsjNeST1TlO40Kub62TBzq1WagIZujLqsNsm+aj7BrXXcqUPPZ1mNw8IJ1Ei4PH
         QGJkmBNzMt9Tl9kc5RT83LAhXco978Ad3/EWcT/oL5l7fTFfNtiu8C4Ai4DtUETkpT92
         jyavHm8jePJcdrxuM/aD0dhe2ntfWzYbRyaaoioDiDoZD26RbU0Bu5eG4fOLtgETDma8
         yiizeCvLB7IpOayV/7kncRJsfb7quYzb5NcpW87KF/WOYcqyrZWF0FNBkzlyojDKEMaY
         M5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769623; x=1753374423;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAT5fXFHSpJYGBHtSFRK2w1oMePzqL3McbArpEULE/U=;
        b=nCL1B6NDEtnqMuHGZ8qU5BDUoWVrCNAuN62h7fS2Q/MWWG6FvdFxFhd2i0UHz61iQ4
         49eB6PnqJpPkfQ0t655JirlrOpa/hI1FlIE4dOovGDw/kg273LYNSwlnasPTX9frxmwB
         daJkOjOf5kuTPZXrv5rvcTRu/gDQT5QqkqRgRc5n7VlXz8GFn20pJBN2/ENoD+Td6sYD
         MEecoKZZ2BYtOP+yiW0F/+RNkvo99918lBdpAAfekK47XD5PVwhzDrZH8V2PP4xgbKTJ
         CL9OqnFAnYCXwvTrq8dn1WwD4Aq6IjdXuPWwS9+JtPDX7GylYEVgRLxVxehWD5jZmzsW
         XorA==
X-Forwarded-Encrypted: i=1; AJvYcCUl13pRkybwMjXz/vVx6fgxDEtkTajWx7GAQ9tMfvbyAk412z806oOBOii0/SdCss877kKY5zWeWf4zMeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqej5xHBPKUEZD0KQCbBdBQDSwjNPrW6vsxMsqocuefLATlkg
	fyhdd5FXrpboc7R+J7ybv+j5cfDt/MAYSA7gBFFxVe7OXuHn6Y5BXspe
X-Gm-Gg: ASbGncuFgroVx3S+urJtMIGqdZMWdSnXkUtLkLolzDz/IiejZ//84s6OOZLWzSaN1zA
	qZdZbCNqnzmVBwFNGkAVO3qVlf88Fuu4hyBNaihRzEI1jZcocM+Rgd2LKl8wlZPgukWzaElUbC1
	RQ7bPo1mJWVzk0OP7PFNZMvFbcIyYXN2+lZUrnc6VRiEPvLlXNot9f0zFrbt41TOh11rlqIXb4e
	I73xmzErLhjJD1GLj0EB6sJ55WnLEhJ4MEkk4A08QePDLhUHx5YF+Qqr0qqs6djmXIaoj6selug
	F6FAw3y4R0mngRpSdGjVY566xBaeP+B5YmEuzTqaZ8ID99THCfxb/BA98sEOm8jF2aUJe+8/OVO
	lkMVMs4NNYlQ=
X-Google-Smtp-Source: AGHT+IHZ54/6K5i0E1+VM+AOUW/T7zxHmWh3bY4spHR+PWVYg/BV0boW9T2fTA+uI+fHgXN30+58Jw==
X-Received: by 2002:a05:620a:8d6:b0:7e3:3288:8ec3 with SMTP id af79cd13be357-7e34d9ac33dmr380657085a.32.1752769623044;
        Thu, 17 Jul 2025 09:27:03 -0700 (PDT)
Received: from pc ([165.51.18.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2e20a098bsm523067485a.109.2025.07.17.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:27:02 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:26:59 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] char: xillybus: Replace deprecated MSI API
Message-ID: <aHkkU-BHX2Zn0SWY@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed95641-4c95-5fbb-f359-885a3e2144f7@outbound.gmail.com>

Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors(). And
add devm action to free irq vectors.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
    - Replace PCI_IRQ_ALL_TYPES with PCI_IRQ_MSI
    - Delete pci_free_irq_vectors(pdev) in remove function
    - Add devm action that calls pci_free_irq_vectors(pdev)

 drivers/char/xillybus/xillybus_pcie.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 9858711e3e79..ed3b77cb8127 100644
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
+       	if (rc) {
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


