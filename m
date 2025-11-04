Return-Path: <linux-kernel+bounces-884985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB24C31A49
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4D21883A64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA76330B3B;
	Tue,  4 Nov 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix74fq6U"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306732F75C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268084; cv=none; b=BNSPro4IOPEcl6fOelYaV0hdbFOW6/lkT5WiurWrSnic5B3T6ace+JJODdD07D5gpiSNUAT25yBm+nQJXqtRlKggXtskh1bGHcv7rM9cIzpUGMFdnGbP1tChfCYG+Q8RcBDIt7BtgoGQV3S8AYhHiGmfcU5rhsk//EjRUtR6/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268084; c=relaxed/simple;
	bh=WXJgANZ+e9h8MzCDzeaAESu7lB6O6+zjBXrW56L/8IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyQoS2QOBShCSgK67jseg8wjcJ9/C/ZUPDyvaiwNqzS+njUHmIMiSsrAixgbQH1RjnIV7c8hrXChIulsaJo4qQ2ymBzoxCcKhp3+tlTNuv4JqWOAP34rikajsI85AXTYUv7hwmAGu4foLAep75dVcAONWwxJye3b1bci8mHJFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix74fq6U; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-641018845beso90398a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268081; x=1762872881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Eoyutw2xWn5tZ7X64KI/elnJZ6bDgfQd3mhxBVUbfo=;
        b=Ix74fq6UDHhm2Gfgs0Ecv2/CMIr2PSZYO3cfVs0C/uOvECHY9K2XOI+gKjUxiPzTB9
         o3myGmXM0bf6k9aM2TeBCxtJLH4x5YUI6HKJTtTXoNxj/U+KV9vC06Iar+KUVfGNMbhL
         BQHJyjubllGoONnDkkJDejqZmiVv7XXKJ7xeSEoOxBwIQ7mJM4Xl+c/3wxllLxCdkenW
         8tYJpZHNdHAH4L1xDHM5uqhWXBK4pwO9A3W2W57c5bvHpE+KXs+D6lFSvU4ZkcqakJaa
         xde/iEhTegaan9eQ05ne2xIi7CRCUkdi2sutNFgAmSgi5RsSGCCDCsFkBKd1C9R/XDUx
         Zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268081; x=1762872881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eoyutw2xWn5tZ7X64KI/elnJZ6bDgfQd3mhxBVUbfo=;
        b=rJ7q4QiMhnQkHV2Z704ftYW4Z5GJ7A+DY7Neh5yUz4Hfd+9zsOiww3HEUX9UhgtsNY
         7v2cZP1c3nl/R/9Shi81V/ML10wJwsx3ULmggBlqAWSrPhV1WqG4ZsHV1kZQqp4ozVtR
         Wu0j0rubDC0pxVZsdX0FLNmyYno751pSWtG9rayXqW/zrRWR97LpVDYO4n7rjLYIuHSj
         0qJQzs2sCINmj5d95e+wfUg+cYfuKU8c5/8JhJaQysbfP07XQZTAXczJR3O2GhJI5guV
         A4BRn6LEkVU7aef71fQ/eWSwRk7G1BGpH1VnUxl19GzREdkhdCO06CTY/SEIY7ZgTbXv
         NB3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTSNWKvagllUMzeYF5w1WCEthtJFtw/1WvY2AD9LIbgj9aTyOBUBt/JHM9JzfXPMzXrYx4YSs+bdt4/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwSkz4ZN3f53McbeJdMgtKaJCTbHqXsI/UhWJ2BoKcwSeRBGx
	RlIOfCie86g8TYG4hPFKV2IyzGFMrb5DazM8MlHiQbD9pDWPkokexA96
X-Gm-Gg: ASbGncsgjenwHDUwNxp6vxDSrHtISDWS+QDuy+LlcbjjZtn4FFSEvqXyhx/QeuyCyQb
	7pV6evv8aM5fOZS27vcfare1V+1a2DUDtUnYUkwa8XNTUCsx27X16GvIR6zMnBe2FAG8uh7ewdu
	t1aKhVYlPRrrCZ/m5EKsznKufgCGOjW2I/S+7MZzReys9/NbwxNUkpOVrXha63z1K7kxEbABL6U
	hNraFgxRZXnO0HrcDqqT9lmVbygcaIHI8rZYaPB/oIs0FWBDqdL6OJ27uR77FL+cnWsKS03NekP
	8NYyxDF32Y6geeol/dxGWNaWJxzdobgFBANF2D967ypZ3UsX9F600vjb7BRnqq7bS/PyVBUSPFt
	MVXq10s9TKxNSV7BDClmyJzWNfURe094/PZSwmWalx7nSPBAiLaTg4DgzxMMHvnzDDpwtdeGuYL
	E8lrtDt4JVpM8=
X-Google-Smtp-Source: AGHT+IEYcV6g8pSrWp9gJnopoqBVCsEt0pmu0JfN5263UUfCpD9RJnczJUaoNY/BYUSo+GB2s8qE/g==
X-Received: by 2002:a05:6402:51ca:b0:640:eb29:fc7e with SMTP id 4fb4d7f45d1cf-640eb29fdc4mr2223377a12.20.1762268081332;
        Tue, 04 Nov 2025 06:54:41 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:40 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250_dw: fix runtime PM initialization sequence
Date: Tue,  4 Nov 2025 17:54:26 +0300
Message-ID: <20251104145433.2316165-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
References: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pm_runtime_set_active() call earlier in probe to simplify error
handling and add proper error checking to ensure the device is marked
as active before any runtime PM operations can occur.

Additionally, replace the const struct dev_pm_ops declaration with
_DEFINE_DEV_PM_OPS macro for better consistency with modern kernel PM
patterns.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0ff500965c10..0c0a9fc97fe3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -643,6 +643,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set the runtime suspend as active\n");
+
 	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
 
 	data->pdata = device_get_match_data(p->dev);
@@ -685,7 +689,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -757,10 +760,9 @@ static int dw8250_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops dw8250_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
-};
+static _DEFINE_DEV_PM_OPS(dw8250_pm_ops, dw8250_suspend, dw8250_resume,
+			  dw8250_runtime_suspend, dw8250_runtime_resume,
+			  NULL);
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
-- 
2.43.0


