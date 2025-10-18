Return-Path: <linux-kernel+bounces-859031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24BBEC84A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23CD4271B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD852773DE;
	Sat, 18 Oct 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="OY5RoZMh"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3522FDEC
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766302; cv=none; b=BmxrzTdh8PvDTInJG1jHOtGaaZ29yXWj8LAXfFTFypAsScapwkpsSUdZ3+g53oihM2OVC+5+bjLPyqAJ60rJe+T8eC032GanO3L/BeRmumqLj85SYL/DfGsYqOPqvuayVOZVmfQK0lDoWdUm4j1u6QNb3AWT7l4H6k/q3gY3rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766302; c=relaxed/simple;
	bh=h7f7ZWtVJI2DIDI9Rl3L83ur3hWLteJgDYDRZ8/rwBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLn9I4RI601r4d8IiyTJ6HjjLTfrAsbFOxpHvpAoGw1Vdsyb7Wgljw1J881igCkf2IePNr23qsCzbcCB097riednbRwSKtRWYieElR2JVdaFHaYDIqpre6D2Ec9S4x3Y6tzn83bqvjGQZxBSWj4LJE8mTDchWAajmm7mm7TsHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=OY5RoZMh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781db5068b8so2170003b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1760766300; x=1761371100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89BI59zwmh1Ubu37m+UzRMVYEbxdBWMilagPFw2Lo2s=;
        b=OY5RoZMhYddl0a+wItiD9LgycamsF1hVf9dljcXLdCSG5vVYmC7sdx/Liid5XodtVG
         7E5HdMp16Arpp74/iqAoB2+f6VmclGTJtJMN1BSY1gsEQE+Fb3YhJh/xW3QikrmOYHsH
         2yuRQ0UKFFYtM/IYIkJDNNHtP0TesOlGaE260=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766300; x=1761371100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89BI59zwmh1Ubu37m+UzRMVYEbxdBWMilagPFw2Lo2s=;
        b=IkYLZ0stsVOJRPZng0WcdZTOZQZnqBWMuBWvVncWRBcvGcZvy2qg5JFlPQ6ey9o2j1
         p4vcuDWhs1iCuDu/g0L6BH3uaRDvM9HkyhHMmoXJfEbWzvRItyXmfCcWKnnql42/1T1I
         Q0wzFxHkQ5qm/ZdAi8bqVI/R2UWByFyZUD1+XPyA8mMTm3pihGIT+DUYFfmNnP70+XaX
         gqSOZ7lWe7rXm6qPBfDiUQ7osxiPKBybYhi5YH9t+Wcq1/zD+jM4+iyV+c0xz8dL1BKL
         2GgifpjfcUSBP+hGUuSraisoK3e2IsEC9Q2LwiPlDsF4oy5Ag3vAl7lzl6YRChcO8WI/
         6PLw==
X-Forwarded-Encrypted: i=1; AJvYcCWZlNk/VFimijzcPG8YYn3W6E7GZqzP8kXKFqfxMYfdHzhTlgbwuTKKWJE9SI8wMGmyb8OsmlYKfEYiHdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2noBDtxy06tMe/kFOANrsa9zNNxO1kBdlw09F4jSV0uC3N69
	kIp4cREwPsp3/N5mlBwHgJ1W83g6Wa/WX7l7PiQ2c9wNYbnEpItghWishGIsa4zsufI=
X-Gm-Gg: ASbGncv6lKjZcG1p276wQmreCPJj3qNuvmZjQG62mRTWOg6BXChHSA4teu6M/kSKJ2a
	eCDSfI0WVO+LzhstTkZU4IIVMwf7hfvDI20umtbpNfqY1VzNd9S+HyClJ8GtivLcfMzrhRcc/NY
	jdTsNoJgLI9PguU2en2919xHis6lxnNq8A6fpDK8M0FYZPQkbNIRUkTEaaB2yqshizFbG9TnCFM
	DEoht5iReawfZy10xZERDTeE/N0PWOboZoaQsVAbAlAYMy2I96Vp2CUAHTE8H3l5DgrOgNt7WsL
	zZBfmxuRjDhGrJpPbihstbamochaG5p15rdf+qmaViSv73HL+fXsUCKTRTc3pZoRoLqskEiZdAs
	ZZeVi4Ox4WUOUmvHy/BO2N5fWSGTtq5OudRBJZLnwHINdQ9hercv6bDk62JXWLVYoBmw8ja65ja
	XDeLyGdErUFPhhU/vhd+Dps6mXbjiEL7a1wRqXBbsjZ5x4THoO2hQ=
X-Google-Smtp-Source: AGHT+IEHbWRy0UQfKYZEKhc6rfju/pKkbqQ6hk4S/GiStG+bKUHgiK4+G/rplbVGaAB9yEUU3M4bFA==
X-Received: by 2002:a05:6a21:6daa:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-334a8625728mr7189585637.43.1760766300265;
        Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] drm/radeon: Clean up pdev->dev instances in probe
Date: Sat, 18 Oct 2025 14:44:49 +0900
Message-ID: <20251018054451.259432-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get a struct device pointer from the start and use it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 88e821d67af7..eb5138da8d5b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -262,6 +262,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	unsigned long flags = 0;
 	struct drm_device *ddev;
 	struct radeon_device *rdev;
+	struct device *dev = &pdev->dev;
 	const struct drm_format_info *format;
 	int ret;
 
@@ -277,7 +278,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			dev_info(dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -289,7 +290,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_HAWAII:
 		case CHIP_KABINI:
 		case CHIP_MULLINS:
-			dev_info(&pdev->dev,
+			dev_info(dev,
 				 "CIK support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -303,11 +304,11 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	rdev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*rdev), ddev);
+	rdev = devm_drm_dev_alloc(dev, &kms_driver, typeof(*rdev), ddev);
 	if (IS_ERR(rdev))
 		return PTR_ERR(rdev);
 
-	rdev->dev = &pdev->dev;
+	rdev->dev = dev;
 	rdev->pdev = pdev;
 	ddev = rdev_to_drm(rdev);
 	ddev->dev_private = rdev;
-- 
2.51.0


