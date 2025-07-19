Return-Path: <linux-kernel+bounces-737802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E92EB0B0B9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15144AA553B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607582877EC;
	Sat, 19 Jul 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg28jRdw"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3A2874E5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939776; cv=none; b=B1cJ00rns/hTJcIcHlwXSjnLE9vxcM5bb9gzCwTEqyAFo83Me/7l5EvGu7KVY6u9w0SM5yOtZfZFlIxxP1BsL0f78+pmMtqq81yneJu/JkoQt3eFIHOdYzHX9im7+lX6S8PvnCIaEEYpZOnETP0aZB/zJ8gOi37VIkIKJo0ugrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939776; c=relaxed/simple;
	bh=7oW/uGXeumXPmuE6IvoNbsoaG2+6sR3g7+zwNGvSGDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LMkq31i1+j9JZtZJztxnF0OYzCKSH3VtQBlHWYLBBkjErM9UXCfkWsPqSOTYN5A1P13glgVWkuqiZFeFZU6110g4G54hy2/i6BBiamA8wk1u38PAY2/Xox2ywM6nyuTDoXh/sVfLuDEJux6hn1LF3QH1uMJX9CU0NLtX18MTpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg28jRdw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab3802455eso39672561cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752939774; x=1753544574; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i70Cq3jInB7A+TUnxu0zhx8V0F8LIFkNP4K1IW/l0D8=;
        b=Cg28jRdwoMYzxEXQO0MOzi0cJNa170oeOFSVrU/kFLSUQEoyvpr5gMV8+auFQQME5q
         eKs3SQmnVxuVugVfixOmRSzFH6bvkxHSXiqk90QHqw+hPWYXKXj1cgDa8H8pmE4YfToz
         XlKSntssPv2Up6vzeVROXcp6EdMRXCXNUlOUhrew5gBps/0DPlDM1lhWFaxpI/Nilzsl
         f2dcCtJ+V1sLZXXeZQIUOP97vYIONlnofcglPrNLk3/kxp8FaKWst2+iYrmds1evinS/
         v0ChAKo60Vvy8md9oPNn/FO5u0qU7c/UG0oMkoCDF/ZLDgg9UejYI5VCIRMkoKmTHcLR
         mP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939774; x=1753544574;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i70Cq3jInB7A+TUnxu0zhx8V0F8LIFkNP4K1IW/l0D8=;
        b=OctfJbpgBI1M6dzHv7zt+wZT+0Dqa1cT0hpRVHeEgEb/s2CtY/a9pcqbpieHISz8wd
         qscmA/zmxL1Fmq/skV+XBf31TLx3ARCHNwJiIN7FtWVv6pPC03JZqxihJh488/G4Wzk7
         FxZo+zGWUl/l/jetDoqOg4P0fTV8nqoq/BjIJdxWOk4pD1+atwU/hS/+IOGQOpp5+b8V
         dKsjlBL58VXFpzsbAndlVpdOpAYgERMeFYjbC8MKVc2tRh6Ihdrpxb7fAhfX6ucoZlkH
         ZllulgvYG6jWwTW3cWZRaxVC4C7QsaWcJIG8DKLkFC3HdD169Fe1wvnw5mmLddTrsjgA
         pT8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfHCrKtFIeUT6O+fxHjxJY4qx8AzLjSp1ufl9o/FmsihH8X8bNpahv8zuOpE7DxEakVN0u3sqUS2RtMMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmHaMbFpD6Cyg6ODuIp2EIDbIXYwcdrrByBG16Tow54/9INaN
	P0Xp4/qKRY2MJqkkztpnLKkD6glLluZC0xy41cXmGJ/rNqrmbqEVMXsA
X-Gm-Gg: ASbGncu2lvWQhAQaEr3M4QCvThRRK8pTWEZVV8cJeH3Tm3QHjABlODXGUsycejtEJ1n
	L2/pPotRGmH+GGgH1QQnBja8UH6nDCTgc7gHuJlg+y8WDlD1lQ0kQ+QaODE2DNuDobXd5CUSNYB
	hAnWpQEo4vrBuSMzDPOEKrK8sseICfAQd24xVeDcCqO+z1af1vlBj1HfxN76zXl5ScodovV4Ni6
	4QGi1EgWDGej8JDNConIDqAcVJBZoSQmcCwftxYkSr1sxkcYDujRm7PUr2Z1ftMOxMik86iaVvd
	TtxGOYtHyxsbuKkMVNIp2GsP1qL5JJk9rPkSAJzVPi2JOFTFoFAd3UfwuGrmxHuLMK4SZSchYwk
	Kx433FTd8K5Ip
X-Google-Smtp-Source: AGHT+IGHl3jqTfRcFScUmV+lh0F1JBf0SoymBJEWd4yHMqrjzXfIKjadi0H3DWMqrjE9OVGQ16bLRQ==
X-Received: by 2002:a05:622a:1b86:b0:4ab:42a5:7f1b with SMTP id d75a77b69052e-4aba3e1e339mr198057961cf.47.1752939774118;
        Sat, 19 Jul 2025 08:42:54 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b456acsm20468591cf.63.2025.07.19.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 08:42:53 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:42:50 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] comedi: Use managed APIs
Message-ID: <aHu8-m5g9D-HvASk@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace pci_enable_device() and pci_request_regions() with their
corresponding managed versions to simplify the code.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/comedi/comedi_pci.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/comedi_pci.c b/drivers/comedi/comedi_pci.c
index cc2581902195..b8215320e1aa 100644
--- a/drivers/comedi/comedi_pci.c
+++ b/drivers/comedi/comedi_pci.c
@@ -53,14 +53,12 @@ int comedi_pci_enable(struct comedi_device *dev)
 	if (!pcidev)
 		return -ENODEV;
 
-	rc = pci_enable_device(pcidev);
+	rc = pcim_enable_device(pcidev);
 	if (rc < 0)
 		return rc;
 
-	rc = pci_request_regions(pcidev, dev->board_name);
-	if (rc < 0)
-		pci_disable_device(pcidev);
-	else
+	rc = pcim_request_all_regions(pcidev, dev->board_name);
+	if (!rc)
 		dev->ioenabled = true;
 
 	return rc;
@@ -78,12 +76,6 @@ EXPORT_SYMBOL_GPL(comedi_pci_enable);
  */
 void comedi_pci_disable(struct comedi_device *dev)
 {
-	struct pci_dev *pcidev = comedi_to_pci_dev(dev);
-
-	if (pcidev && dev->ioenabled) {
-		pci_release_regions(pcidev);
-		pci_disable_device(pcidev);
-	}
 	dev->ioenabled = false;
 }
 EXPORT_SYMBOL_GPL(comedi_pci_disable);
-- 
2.43.0


