Return-Path: <linux-kernel+bounces-762123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6EB20266
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77220188FE83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333B1991DD;
	Mon, 11 Aug 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDwTlVXu"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61B2DAFA5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902499; cv=none; b=Qt4wPZf/nkMOMKszg4/NZm3e6P25nA0kwRWpjqytShPc7j8CN7mAdCBjA3eXSZIjxODRaxKArc3qRIxwm/Doq4e4I0pDSNX2/oZPommReZPg4yAyWrrLebdHzc1NsU2G6pobUxcGBYHAOk67lD9vdCWkbaM9WdELsMJ6yY+4PdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902499; c=relaxed/simple;
	bh=vOb/HCCt2WUEqQ/efVXEzqAG7wvFxG4DONZYmff06TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfQwR9z+0NK7RtW/BHBI90joVW9MVjyJiC30HtpqPjLraWfMdzUefr7Jj/PHUcCiZTcilpd64wSt4PPEcXwL1TkCJEllwQFQ9lQQZTTkBEDzpH/CugWJZEsEXu4DcIS41b7JSz0ZtQlv7qgIbDZjEskJ1ZDwxSYKphuAXhgr6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDwTlVXu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so6547079a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902496; x=1755507296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FYwnamL8Yi1pORoPawSuyn3NJhs89bPw4JEe6661wE=;
        b=cDwTlVXuRxxkgPjd+oTlG0k8/cCzXiNVSv+1JRKztEbwF9AhAv3oikg5/swp6C80oA
         NS85VHRhN1f9JtD5pjlon2SKqERh6gRMz7EiH7fdrYWR3I9EvkEWWSO4ea3PyjGmWoV2
         mLyIthn8pbmMIpJLdUFc4wNYXrYySprNeYiQAaQ5qeJ2z50r0zcBiD06HBmXCwtSMdys
         j4QV5RWwRlNfEcmYzEvAHAKPxYDkq1ab6V6D+FQPgZbycPATfc2U1tn7sbXKjdbJucEl
         5Y+oUzFZGMVmyXfdjKE+Fxm+7/vdjWhEif3WagD8TpEip+pHrizVn+JkDIU676ZvUdSK
         rMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902496; x=1755507296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FYwnamL8Yi1pORoPawSuyn3NJhs89bPw4JEe6661wE=;
        b=M1D7lmBiQjAKkLNtY5kpZXTStDQlnF8t0odP13iIOcA6KJsxx5XegAUtStyFdzyI9P
         esszOh/bMMP3UjufnBC8++qDz+TAN7XjORsre0jn1Q41c1afBNRItQ7UM7nTvqEv3XTx
         zMm6IWluw4e+d+8IP1s0BWfvyYWxqkS5oBuWaixUYp/JDRf73q+PuD0OP/n7Y6SIrgo0
         yn0jrOyLs9v2Yf6UaDU2sMAkf+dHIWLsvUmEkrRDuc7CCNHDFi4m/dTJzQzsR0Q4CmUm
         WDzHOIgo8MJvmCkt4HRw0cXBWzvx7Hg9ymQw1CSY1PIzIqEYbOv9PYr+XyxCvBaVTvKO
         FWXg==
X-Forwarded-Encrypted: i=1; AJvYcCUCmVBszJSeo/q+WCdlQ9e7fFFivRygnHXm3vPBPmq9LrqAoo0MQCwmZClzbXuMSae43NHPOnyA5WjAseM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFVefkKf3fjdi0b1KUlkZ5bbeyBx6pthll4XCWpqV13gkZtBQ
	Y+buWxAH+HhP7aSsz+/4Ll3I3NB8DqH0p4RkkVkLE8nGFU/XBFyliNtn
X-Gm-Gg: ASbGncsBvMFxqqRCG0DRRzsO93BaYsjBbCEnp810lv3RA2fHlMziE8bLsbx4PmkKU1J
	phl7GgBQxsYHWNY4d1NJCtQWKRMWhI+HCDJ80lyWgR9X+2uXGnLihUjSxIg699y5+93p36Fgq0f
	zo9lkLATrWU6XBkbE59JXFRxy+7U6WpdqAQwO9vZT0/TLcd1TpcXJMLMTDo05OdpZciB8e22HSi
	U6+msBkNDFzxEicO8+6U7Ne3Ie2bs8E0pRkkY6FIDIZSvEAlT2e1Vzwg0ZrLvgBtjQ2K3ajx3eM
	j7XJZPv4OdfSVXbAhuJtcX6Dmw6Y+OJ5IGH9hHenBvPuH1msHM4AeMNLETR9Xm19pjl8HyVeteH
	x7CKQdptR5+CwXM/qzVf1caCf4RjHOXQuPA==
X-Google-Smtp-Source: AGHT+IFfwIOX9C5Hvq08+iGyCAzDppPVBHIfVhRFt64g6Selhj/kEDegSu31eKdTL1n8aDAHgkZshw==
X-Received: by 2002:a17:907:7215:b0:af9:3116:e0f6 with SMTP id a640c23a62f3a-af9c658c444mr1197031566b.53.1754902495710;
        Mon, 11 Aug 2025 01:54:55 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91ee3c1f7sm1924687166b.68.2025.08.11.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:54:55 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH v2 1/2] staging: axis-fifo: remove unnecessary dev_set_drvdata() calls
Date: Mon, 11 Aug 2025 11:54:16 +0300
Message-ID: <20250811085417.2641674-1-ovidiu.panait.oss@gmail.com>
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


