Return-Path: <linux-kernel+bounces-806268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF1B4946A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F4204AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C930BB93;
	Mon,  8 Sep 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msjHfwGZ"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A530F94C;
	Mon,  8 Sep 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346921; cv=none; b=FoIZj1q1SIPYHaeS/fUC2nDdndhn2+u//qDfpSTgm0Z5UYBBZobwv/sdp+GOG4KUK433UshcJo7EIoOCwyV4WwYGhuPbtYaeKmTg0AhQJMgauCbz4vzT31RQ7TN4PiHpoSO5Yc8uMrGDQK5Dpgh1o8ECOMNS6OvnKU7YVCs+uJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346921; c=relaxed/simple;
	bh=ZhPPiDNO5yQzArrlGfRKDRUaAE3F5GbV4S+WCBjs9gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=da4eZ1bZbwmwuCEGJz2YWEr8SpCvIwDSR37O5kDY6/bBiUKNMgrXRdBvGkogVsviBbHxK75I3nP6/110EoyxghRgAxRkvJL0lVaQHD1rxKfALSA5uniWh0onae8s5FeTwwObnWbdhqwbBlxwikIr8gzXSHYqsE33pm3FTQ4HQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msjHfwGZ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89019079fbeso958754241.2;
        Mon, 08 Sep 2025 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346917; x=1757951717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAT7IP3Aj8lmfsspplaevmXuWbYqJQOd4MHBix2Zpzc=;
        b=msjHfwGZ1Mv4xjAYlMuOeRWli1CH4E02pMaWMkP7E8TLLDF5/kVzHAqPeV+tlm/23/
         td6VwK5822b6cAcU/KAFNa7HATFlY8MM4Q9hetcnsD7c2BTUn8ED4owm6bCjhoc58L85
         q0BThiZSsC9A6/1UQz680mcY5aHwpOABKU3rhfcK4wTlZ3GjImdeDOUyQ0NM3tDHHZDI
         e/qC12MzV6JWBlWZWtVtB/6yzHawQtUKujAkTYoewe9bTeE5onngbklPizVKl3OodPXJ
         KLqvCTnzIpV3Of8PmWDGalRxWtRYDsAsllHnIsoce3yuPKqzDhE286nY3QFq6Eqfn3p6
         RhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346917; x=1757951717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAT7IP3Aj8lmfsspplaevmXuWbYqJQOd4MHBix2Zpzc=;
        b=Hqd47v4toLt6wWKRX3Z4drGn0foIr1ZHS5I+IZSqfLL0t38pqj5/3ZwQh5Y9al1Ou0
         bUWDFVLSmGD6sUz+4oGZxI/lsLhlm3jv8ETE64QKVD0oE6vbLLXtvUYndyokXykdQgtM
         e3AJevGRrXHsw+XtNRwzV8/iK04nZ3T0w4RGuYhH7HAyidVAvda44OMRBy7DL6ouFMEK
         GuPHqiouE0RQNhTb6J8eT00YLybQ/pQ/+Upe2XErdK4+6ROB/gr0xpAITwBazq7qCbSm
         NqaHl8COx8HdLq3olblwfCRwLpw9ekL9C5nxz/e5ewNYSCFwc71wUIOra9hRwPtPQbOP
         c0pg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIMNM5FkqslpHiFHdSxBmLkq6TijG017/EdpV+Rcm0gwTiifO2mAJs+bYXQ2DZXkHh2cdp6HjMgro@vger.kernel.org, AJvYcCVrfKYPWYMaMgwDopPzFlAunGCNilsdfVcZkj0gcPtIWqbPCdWekdpkD7iOYBRw5rg0IZoWmbtCuOuxPcNV@vger.kernel.org, AJvYcCWpiQVEj+nJRnYZWMFfQT8ZfQiFTsI7TQPtZnyWcOUWEaUwH5WwwyNXayUDcNhzLg822/8x7G3IrDGX@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTV1mlMhtsDZriw2A9rPEW8DBfJSoiIk5XZ97skpRuiWc5lIM
	q2NgS57nTMJWRcbWY4+9YXapIU2Jmrg6sSQxDYWB+jv/XScpNSAZozaEhd1cig==
X-Gm-Gg: ASbGnctNw3P2uq0Z3ZlflOmWbp3u03D7rg+7zuNrnRLNs12keq7kp98HoKtzgcA7YC8
	mZ5e9mqwl1FOjEjNIgwgF/OOGPKxiodnjWZ37NWWPQlExFT8TcdP5MEsDQKWPK0CiW3kFcUHTQC
	0jDTzEfL/G5LDEAlF2945OIVc/OLDS8h7x10VMqY14BzDwM5hLVBZjJKYTvZTjp5lsV06MyQSpE
	nXjxbiMYb8jhuAlfVWdmzoCF5a8YCfOkm1znltnUs5UPNTPAA1e2NCYWWtpf+fNTPk5fJZSSJzW
	q7fYhQuCe0tWXWvEkvquOYWrN+eHI0TnDYLJoeQLTSClT5c2dD7brKBdNFhrOf2vNJ31Njhsuef
	H7RFkzILRHfzse2AGzkFoWEDB
X-Google-Smtp-Source: AGHT+IEU6/2ktGSN3/hiJSBaiBQfW5iQc95a6us4J8frgTvsq+kCw1hGeGVonnCNT/tQOw+ETZ3BeA==
X-Received: by 2002:a05:6102:3709:b0:524:51e6:4bf2 with SMTP id ada2fe7eead31-53d0e48f315mr2188733137.15.1757346916767;
        Mon, 08 Sep 2025 08:55:16 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89601b67070sm8689299241.20.2025.09.08.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:55:16 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 08 Sep 2025 10:54:52 -0500
Subject: [PATCH v4 4/4] hwmon: (sht21) Add devicetree support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-sht2x-v4-4-bc15f68af7de@gmail.com>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
In-Reply-To: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ZhPPiDNO5yQzArrlGfRKDRUaAE3F5GbV4S+WCBjs9gw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7/kQnTxEpOr/28cJIzx/Wi1Mq+5U+BZ6rurJsrsb2j
 EO30k62dZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBErt9lZGg44nzDuorRWaUz
 6jmPmb/2ufuPG3//eubcMlXmTbhhwBaG/wFcwluKPe1W133UvGMQ9YPV7++60yHBRmx7p0lvv9P
 5lBUA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add DT support for sht2x chips.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/hwmon/sht21.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97d71e3361e9d7f0512880149ba6479601b2fc0c..627d35070a420ab9e51634bdc5cf5e3de3853326 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -282,8 +282,19 @@ static const struct i2c_device_id sht21_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);
 
+static const struct of_device_id sht21_of_match[] = {
+	{ .compatible = "sensirion,sht20" },
+	{ .compatible = "sensirion,sht21" },
+	{ .compatible = "sensirion,sht25" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sht21_of_match);
+
 static struct i2c_driver sht21_driver = {
-	.driver.name = "sht21",
+	.driver = {
+		.name = "sht21",
+		.of_match_table = sht21_of_match,
+	},
 	.probe       = sht21_probe,
 	.id_table    = sht21_id,
 };

-- 
2.51.0


