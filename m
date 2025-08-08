Return-Path: <linux-kernel+bounces-760762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13698B1EFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1792D1C807F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFF221540;
	Fri,  8 Aug 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sX0jao"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB178C9C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686138; cv=none; b=BsQQtTPpwBhZU6wvrH2IoEk3T9hZ/0bw+bZRioBtpQKJqTt1GNFlIvFq8gGJ+0v84mi+0YOurt3uuuB4waYhzfZOICxik9HFPxoYh+XXpEDukSYjqpdWjgf+1NAPtAv2AyeMbYU5ng5W+0HyS+srZQpuNH572qmCntvvgV4zmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686138; c=relaxed/simple;
	bh=vOb/HCCt2WUEqQ/efVXEzqAG7wvFxG4DONZYmff06TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMdpqeL3iv2wYaQznaPXM+NM1uRSE+huD0/QSKckY4eZVwKaw5x66aVzYfrdGY6r8cVob6kRO7s5JjAfm2L3CeiBSxjHpf46aM5hdLRtUwW3LA+dAggLXAnGgLs24DqnLlZKR5gEMnNFU0cpdyV7UaPCYuFMcp5KZ2zetx2vWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/sX0jao; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1438818f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754686135; x=1755290935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FYwnamL8Yi1pORoPawSuyn3NJhs89bPw4JEe6661wE=;
        b=C/sX0jaofeUD7drw64wYFAOnvYXl4Xn1ZHs503S9b1nSSwc6JrJPpoU9fXH8vsMkbB
         gfbnizEPCbosAnZoBF3DHPdONRIioZM+6H3XI62UPdmPQb4p+NfBr1my4IDLZ871+fdA
         imh4eX9CwYmv5CsiaXwgT8dEeK/0ccCj2I2kj2UscLHF6mfkf8gvJ+Gxd1f+tlozhya/
         /M18ZJu27AXsXJWMvhc6MpjOzncBeac3gN5qH1VaJgnVDeXb5wvgbRBz+LCxFRkaZbEl
         ag/I/3wr8s7ErOckyq4YMpI0ZtgCLXACpo1FObAWcvMZHC7hi+DsllSA2A5cFglCUmEn
         BE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754686135; x=1755290935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FYwnamL8Yi1pORoPawSuyn3NJhs89bPw4JEe6661wE=;
        b=hZCKpE/YgIPhSTLA2rpI/bxutjN1YBCBbKMC27tqALCUk6rw5A3uVdWM6dDDXKCqau
         F8bSF8iY8YE1IxScAMnvnVXPr4YLJZkM9B5vhkCD5K+HJDOG5Xr78fe7AamsbnABZAux
         a3HD4GkXt9aNxhMrcBN0bBHXqNPsfA/WJqTXH8qRlnSspVs2cgu0Z5CxK4tyxpV2qIE4
         NW414LWLggw5UxynIsgdtS4boEiSSWCP1ztpk7rok7KGfHdHcaJ7eIyRCRfviUTeytc7
         KRogR1TKwfEysCvmxzfv2uIC+QswjAcS6J7pkvtlxda6W8VYa3mf+VIHeqL0by9Miuha
         P4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIpR6F5PkSAktceFAss+7Owd9DPjAEgAKB/bMeBqZALLI24jXzu4kLdPRmxsGDKpgvYXtW06hnwsTbFQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sYkegVW4yJ3fTNPZULJTX5LCC8Zrc2qwg8CZO6/OAAf9AKL9
	F+O78MG9t1VL7MQ3A/BI5oD62SgI4Y22v+hA010KEuYgIXDZtkyD7jk8
X-Gm-Gg: ASbGncuesTr9I/tONnp/N37AhUvEJylTEanO107Qz5KjJD3pacZ0dZaJnokLKTqkYqt
	2VeIlzU+iwhqF6U1LjdJa08iSuKH2cYsox+8zPWDTpuBu+JWf3/fimZYCyLqhngbuDlpSf/iXLN
	wMkfxd+VUJI0Z/WJ0jdUod1X4gTL5UvFROq21fDx46a09mtIRkVqMn7g09VI0PsATWvuMNvhv8Z
	qQ5iQsVPDlKrRWSUs5235hMYnCPNZ6AdcZyXNRmJzMxoRCPaX80gJKkCtNpky6WdNml57sv9FJj
	N4lHrnShFwf1gquUe49yKacFsb0RP6QL3kaayMwfh+NuKHIumr6szydR6Tfc0ML0r5fJ3SRR+RW
	SgFq2CmIO0qQ2jqTclHfxQ1f5jghU6Y0W7w==
X-Google-Smtp-Source: AGHT+IG8z9GqClT2tCxGF0u3p2c+ZwJkUeIGJTBogSttYX4uEJmTv930xgqedDBKerv+dMh46biU5A==
X-Received: by 2002:a05:6000:402a:b0:3b7:96c0:4172 with SMTP id ffacd0b85a97d-3b90092fd6amr3528704f8f.11.1754686135334;
        Fri, 08 Aug 2025 13:48:55 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm31815003f8f.42.2025.08.08.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:48:54 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 1/2] staging: axis-fifo: remove unnecessary dev_set_drvdata() calls
Date: Fri,  8 Aug 2025 23:48:30 +0300
Message-ID: <20250808204831.2618122-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary dev_set_drvdata() calls - driver_data will be set to
NULL in device_unbind_cleanup() at driver exit time.

This allows us to remove the 'err_initial' label, simplifying the probe
function a bit.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 57ed58065eba..06f7cfab4c6a 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -693,10 +693,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 
 	/* get iospace for the device and request physical memory */
 	fifo->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &r_mem);
-	if (IS_ERR(fifo->base_addr)) {
-		rc = PTR_ERR(fifo->base_addr);
-		goto err_initial;
-	}
+	if (IS_ERR(fifo->base_addr))
+		return PTR_ERR(fifo->base_addr);
 
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
@@ -711,7 +709,7 @@ static int axis_fifo_probe(struct platform_device *pdev)
 
 	rc = axis_fifo_parse_dt(fifo);
 	if (rc)
-		goto err_initial;
+		return rc;
 
 	reset_ip_core(fifo);
 
@@ -723,7 +721,7 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	/* get IRQ resource */
 	rc = platform_get_irq(pdev, 0);
 	if (rc < 0)
-		goto err_initial;
+		return rc;
 
 	/* request IRQ */
 	fifo->irq = rc;
@@ -732,7 +730,7 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	if (rc) {
 		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
 			fifo->irq);
-		goto err_initial;
+		return rc;
 	}
 
 	/* ----------------------------
@@ -747,15 +745,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	fifo->miscdev.parent = dev;
 	rc = misc_register(&fifo->miscdev);
 	if (rc < 0)
-		goto err_initial;
+		return rc;
 
 	axis_fifo_debugfs_init(fifo);
 
 	return 0;
-
-err_initial:
-	dev_set_drvdata(dev, NULL);
-	return rc;
 }
 
 static void axis_fifo_remove(struct platform_device *pdev)
@@ -765,7 +759,6 @@ static void axis_fifo_remove(struct platform_device *pdev)
 
 	debugfs_remove(fifo->debugfs_dir);
 	misc_deregister(&fifo->miscdev);
-	dev_set_drvdata(dev, NULL);
 }
 
 static const struct of_device_id axis_fifo_of_match[] = {
-- 
2.50.0


