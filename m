Return-Path: <linux-kernel+bounces-859050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C1BEC8F0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F019A4083
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E552857EA;
	Sat, 18 Oct 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1gSFXXM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66224E571
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770948; cv=none; b=H8A+Hzjw723ydbIK1VokHAU80T0WatBtN2Ei/Npim8xhaxU6TiPOPc9XKFQINovIOaSNqbbhu2MB+mVyKtY6CXwZ0O+mK0vukr64zGNUlP4JpWSe5suI/nlVgwKpm+xPv6aAq01+qYJYHLPNlP6gl/R+JnFz/9pgXdfbn6f2Jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770948; c=relaxed/simple;
	bh=adsfjwfge00OgO5pYEgu3ctiyYWEhEAosl3dDNxgFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxeyXu5nYQnWVnNfIY6W1XCJfpUuxxVTe5163aMLyJkijOyIdt0aktL4OQcJ/ywS5qugOzNlV3/DFNY1wK3oXXmzWPJZpMYLLh52rwiWDeasiKl3JdbIQQVB9JT7pDVhr+wLNEGthkmhzG09y3hi+AMdm+g6PTnfann9dy/gC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1gSFXXM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so2519303a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760770947; x=1761375747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LZqO2zxUNbyHA1CZzbuw1ZMVz75gsE69oTnbFGskfI=;
        b=m1gSFXXMa2ZO+qmbPYGSN+XNKoWO7WR8S6b16NbWrMrXy8hjb+Aw9uI02Z/y5EhZfd
         HU14q4ElySq/N2YkpZgvKBQPO1tAcXHNgocv84BJO6nN5Nlh22fIoHielhiHmOXQCCOY
         y5RwX/L9C7kMp8+kJY+etxvbcEQ9re4zKs4Hgyx7l1HtT6gvxewy1TsZluwzE0Nl+8SJ
         vBsRNzYDkQ+ZsmdP8d6k7v0G0ctA4Gt4NxrpHvjIz8xuMI70XWceQHjy1Kk+vcUrn3cS
         zQOEcrk8k+pA+zEhi8zgXKO9DraBgrrwVAmZv0HRIFHDnRf08/4BtNbtFhI2cWWc36wo
         oFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760770947; x=1761375747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LZqO2zxUNbyHA1CZzbuw1ZMVz75gsE69oTnbFGskfI=;
        b=e0k0VSI71lg6V1XTYFccKU6eDs0uFaCk10VuBj0IPnlbKS3769UsKbyimCCCpBBPsV
         GTf8PmOliquKkutuTUtVgz3jNKh2sIOKuiv3uwQaaCijvURDdl4uQgzjdAchWpQYsJw/
         Y6PQjs4OEfqoxEAjiQLYVf9xx3uOUOzkFhp9BWvsTmNbgQ6lhff2Tnw7uV7ces7/c2rT
         fofhcTgh0Q5qlhOzaGP7kiV5WoJXFaqSKmoa0i4u8IBYyI7dP6W7wM0PP3fza0sbW9wY
         soAlRxGU7M5EsPITB7bCa+x38VmP4CHE9yMb6lRSH1BRSYufXHdYusUIPn4cuflR4n+J
         EzBg==
X-Forwarded-Encrypted: i=1; AJvYcCU32UKsp/FB978Ki5LwElMRQ5NlT2njHZ7KW9z8MFGEiCbAoVLiEQMiKS+Wj+vcvPNqGAOyE96OrXE7QRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2q/WRhnX7dKkngJ1hXgcGgOGsdpvkufdLDuIDeGbHpgzsINvs
	X5aWR82rPuf1WpgN+U0/+aUSmRUnESwlE2yknBgZyMaaG4xO/EQ6gSyD
X-Gm-Gg: ASbGncthvjAw77OqSjNMMl0+Ux3ucxQDIztiau44y412ORhOIrtM6p+1knmXkkpu8+O
	jZ0kJ6Oz9Lq7flszjKmHkRpbvg+I9aMZYEez+x4lE2WhaxmSySEUJ9K57DHBx2uFY4uG3nCylAN
	zQDgaY7IXxM3LhAIIEMYQVzlPdSBq+GTz2qNMBUCmjdmfkDhbEqHXZlwZHVwZYF5yRP3K3Sqq67
	Wfbsdk4tzHSwXR2gTZX7bHsErjBqQsXfZMV2bryXxKV4zlGe+4NsZ8oZiOze+cNrJPLDwhi+ZT8
	7z66PkhWz/9inqTf9kvHsxRq/odF3/1FuYfXnzIn8ADJZU6gWAD3Uuwn4LY3tgaxsV5+tub8dTX
	xxHP7t9AMmMAebSgguNs4Y5/lvWPA7VZ6jK+C88zLA8OIraG3JmTksXhUpDqCBjsMgAsOXEwJpg
	==
X-Google-Smtp-Source: AGHT+IFwixJTBiwvERMXNptxWD/m5Ky/B2d3/2ezqQWItjp9Qrm8XCx+MEnhwBI6yvzKsYHMdLBI3Q==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr7248569a91.32.1760770946587;
        Sat, 18 Oct 2025 00:02:26 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc12f82sm2186633a91.12.2025.10.18.00.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 00:02:25 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI POWER CONTROL),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI/pwrctrl: Propagate dev_err_probe return value
Date: Sat, 18 Oct 2025 12:32:18 +0530
Message-ID: <20251018070221.7872-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within pci_pwrctrl_slot_probe()
function. This ensures the original error code are propagation for
debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/pwrctrl/slot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d89..36a6282fd222d 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -41,14 +41,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
 	}
 
 	slot->num_supplies = ret;
 	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
+		ret = dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
 		regulator_bulk_free(slot->num_supplies, slot->supplies);
 		return ret;
 	}

base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
-- 
2.50.1


