Return-Path: <linux-kernel+bounces-887308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CAC37D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8853B47E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E934CFB4;
	Wed,  5 Nov 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHvEmO8F"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3852D6E5C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376618; cv=none; b=jvgKv37GMOnlTH7K2rbwHIX2On84lWj8aMto1sb4cncAtgxmqbZnWCyw1ylQ/BLfR7Q+ISOsT3X/DKtGL9WvVoEkkcDH1QI2WmBEOCmbQugU0J+HRdAkJiGfmmRo67EL6+FP4oF4NvizT47ned/w0IFP+jPVQFfM2gRJAhr3IWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376618; c=relaxed/simple;
	bh=dZxbC32mzy/JF02DKZ2snFfIWQ/TTrnP2h3YmTHbL8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/NOebW4rt+tJBWklzLZPys9s4nDcGKJMC4HdgrFZb1iNBo9O+NJsYrSkqUg06rqnNR/m5RaEoIcBEdl/rfwTIz68EF6cGmhHCKRPtqDCfFfS0Eg9E6tvyHAZVf6njoG6+wYA7TDPI4ZNENbDv58c+cJoySYl7OAqRLRrPwdnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHvEmO8F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-341988c720aso258410a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376616; x=1762981416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvK6qvFSDKA15whyYqvYMfPkmiZehgHvoYJ0yEG/DmU=;
        b=UHvEmO8FDqslTM//zGwzpVTHnVnIzwxC8pLjsFNJOzG1VNAiDeY2i1v3/wuLwj5Ku6
         s1pckZZIMwLJDpoCWYIiHl1OXgI33stdCpx455K5AaYyuyE2Q59gBJQ3Y0EVzeXVirGt
         llQI/Q/ZFGNNhHFY1TuDBgnrIEPSVssWEaZ+H5NacwaEH9Cv9eRzq/lsPzK7uXt/rye9
         NZjCRgg4D8AKpCHVBm74SQDY1T8t2k7GE6DwzKTDSSvINYJPKTBZc75OFReHXubHW/fm
         jaqo1PYk8qIYhuahbxDhnSMPT3DABDQEMbV3H2qZyd3Onw6B3i31+IHnLIlYFfRPtYqa
         2opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376616; x=1762981416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvK6qvFSDKA15whyYqvYMfPkmiZehgHvoYJ0yEG/DmU=;
        b=rdmeixzualGurc1JGftJ0vIg09p9/RNzrJF0enmuNSl7WTNHovWTQB7X/xQr3dbjaw
         BiuPx+ISMYsVLAJfssJQcKM7HiWhVs1Xq9LC9mH5c1XI902kBJo1CQq3glSVOJ8cwHpZ
         NwpiCq/Dd0pqK/0CeB8aMyGiEtp8Nuwqu2kW+e2fMWh0dfMxdkdFfAESV2MveEu9uqx2
         rKskt9kcDT8NIP7RR6Ucw5HqjqNu3NR4Qa/+LbXCMJJC3lEqj4QpdOstCbI/Y9Oc6l3/
         KalGsSD/jY3TvmOMrFASrz+Khdg6//D23SmcHfhBs/k+Sma9uV7TqTp1Adms/pii0MNz
         2Z3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSoq1FX2iHJIHmfxsy5UZGsdEqJJY1p0EI6apbrjWqi8iaGd5R3KZcMKMT1Paddoec2DNtYfzA8Hhtex4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0ngllitdK0ZNL8Yew5mIqIokrkS//SJlhroSQtegd6BrikDt
	gOGscS0W85gJ/d21iTyBzwMEUvK1KuRKzhvm9KdS2jlEd8WDQqNjrwSr
X-Gm-Gg: ASbGncvHoF/U5UdNuiKuHbhCdP3i5dqm5xqCjiGAghk98gGayV3bXgzzjYzRsACj7U8
	usMs+oYg9v7CEXZuiQzr1VV4/QbX4/iB0R6Ro5i+Ux+unreW8kdpPOxkhPic/UCtOBSB7XaJoaQ
	uezfw16Vmj+OgNt3P0dZifQpR0euDhHTIoZGXnHLbGzrRuAjjz2pmmR0dW8lY16piYVBsFQrZoA
	Jni6nDujWtLMA7kjiUtG+wRoZFoRu2kQV6gJKP4pLyKWhTsSUEGLvkTDx8ywTcwclTERLguYbo2
	8PYrWhmOehLO9tNgzchD8g970UH8tO87koilEtTzPmBcpf7/Ggv4dUSZ79UmAk2UnaqWbcav1vS
	XI5XPmUriG/MiQNk1mCuRDRqpHdOK/FJZYEng9Y3WWK5Zt3s+11gYXw/dzQ==
X-Google-Smtp-Source: AGHT+IHOziVsZSS5XJszgFIOI3dDfa90KKWH3MYFTR2nMejbJeWj2BTL5+TWVQ9T3SiGEY66XetT7g==
X-Received: by 2002:a17:90b:5847:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-341a6dcc6admr4852945a91.23.1762376616023;
        Wed, 05 Nov 2025 13:03:36 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d125c93fsm13626a91.14.2025.11.05.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:03:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 dmaengine 1/2] dmaengine: mv_xor: use devm_platform_ioremap_resource
Date: Wed,  5 Nov 2025 13:03:16 -0800
Message-ID: <20251105210317.18215-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105210317.18215-1-rosenp@gmail.com>
References: <20251105210317.18215-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly by removing explicit struct resource pointers
and platform_get_resource calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 5e8386296046..3597ad8d1220 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1309,7 +1309,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	unsigned int max_engines, max_channels;
 	int i, ret;
 
@@ -1319,23 +1318,13 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!xordev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	xordev->xor_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xordev->xor_base))
+		return PTR_ERR(xordev->xor_base);
 
-	xordev->xor_base = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!xordev->xor_base)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
-
-	xordev->xor_high_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!xordev->xor_high_base)
-		return -EBUSY;
+	xordev->xor_high_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(xordev->xor_high_base))
+		return PTR_ERR(xordev->xor_high_base);
 
 	platform_set_drvdata(pdev, xordev);
 
-- 
2.51.2


