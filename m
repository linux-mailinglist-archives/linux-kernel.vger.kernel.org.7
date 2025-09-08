Return-Path: <linux-kernel+bounces-806266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F14B49466
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2388F3B34FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF930F7E9;
	Mon,  8 Sep 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5iErCSB"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9A30E0EB;
	Mon,  8 Sep 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346915; cv=none; b=IJmHw284I+uF01a/DIm74VoG86t7glvmC5ViWxQalrPmaGINmYmE8q0luBlyjl2/VCLHDCx/avQNrCjCxVLOQCgxdsZSmvPgpiWWNB1ySrwrQU3N1qVGscb8aoSF0fcfGakwVevM4p41QbjnJNVaixKOCn939V9CQP4kTkjZOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346915; c=relaxed/simple;
	bh=Ultn1LADtPH8Lln5wBQc0s/woZYsJlh8Lpo2VgUgnro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=em4FO7hmMi+4C0dCkSu/wTlrnLMGKSTbR1ZWF44udM4rLMu+c2VVNp8Sy1iyps8XC9b2FtsSvTpmnYv2JSWJ3CTtunP4l+2ZQ1tATNnhJPoaLDOKD+vO9JsM3qgqMEgi+OesacSYeaBaszX/bkqJ2i3JP6gZ/aHz+9SLUdE0sLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5iErCSB; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-51d14932f27so1873725137.2;
        Mon, 08 Sep 2025 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346913; x=1757951713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQQHGK2BoZkJAPdNQnoOnARag/2hsLhbyR05iTMp+y0=;
        b=j5iErCSB3WY3XbFiwKafGEnSLxg3597v1rxapIrfHAVxhm1rJsyG9ffKcx1aiYuq03
         ZdpwPNBBwsltXGUL+RRRXa8OC3GAOSsS4SvteyxKkXLCqFosQVrjexFP+lTP8nUUmcAJ
         eKo4QjAcjL3iwsGh2weUFgGW74P5udFo98hiGjMWnJbsUjQ1VFXBCL+uetQrcKZNEa+a
         4Y9/qK68n6kGNMwG9BKp6LDGH7MUdQl+OQsqMTlVzh5FZ8TFwwlZlmPtn0i7xUm6/V/R
         mNuacCrpXzHPXVMDhXvDkCYhiD760sdWxOvny5ThfQLGW+Ymj5B+L8/XaL9XZFtOXAhL
         pQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346913; x=1757951713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQQHGK2BoZkJAPdNQnoOnARag/2hsLhbyR05iTMp+y0=;
        b=gYQJeJkId9Be1VLZ1xWDLr90Uxy4mE8+vPssCmDkRE2/Z63yZZ8Ph8kauPSThET9q2
         +TZiFJBmdfPybIJL7W2m5NvBGxJdYotFBkHLx/FXjhrxAcw7y/dVC0ss4NaZphuNXSs9
         PnzE4wKNvzUtx5ZLIxhVezAnXSPeI0yqFyh4NfY5BU80Qf4d24yfYSYe3fAwfgecsJgb
         P1tgIoyT+30uSTn8jxMcuwFMVVAqW1CSuii8mTUGr1dYXXqVwBVohlxqFZZAXZROsn6G
         mr8kuapWsWYZvhTGL6ebHwGGlsgom44fg4bkIiMCImeJ7Lf2/iDRhwJwwsjcqdIuvbFM
         g5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU7Vdx7/+EzCxymR2MCzG07KUYrg7abeGNq2P1nvZGXmAnudhKEibNWzQqXF7gyqPbnQlwD507Lm/yq@vger.kernel.org, AJvYcCUtJsPJMJo/1tCMGpQuKBTg+dQXX2xbrD7xa+aeGIaxGInjMRmxO9/0rqfo+Q3lmK/W/L3RbaArphVP@vger.kernel.org, AJvYcCXUM93R/Q62LRRuIeSSVQsVRsJssOPbt5Owzcn89D5lCcYjRkW5lP0hZL8ziHnaaBC0IjHR4rs8QWw7W1yi@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcnYaRxlx37Bk/S+5Y3ezWjX31z8igOYNU9/MzsLOALL25Gy4
	O4m6NVBSoxaaXsulPWZDQ5+QiOhh3qhOX7rWH0wZQbZWBdgquVkKRybMth2jUA==
X-Gm-Gg: ASbGncvvevH97JsKdN+s3h8HjauhAKa0dzWCBfyJ7iWRq7EKvALPQxzLat9BaddDUC1
	7rH5FUWK8ZXibF9g5tbsnk0u3sGDCnrfNAcq1oB/ATY4ODs9Ps/+Mjldw9w008wbdpDDiYHozuF
	HuNOT6HICbV5LZUvC+RR2b+RaciLQ+pKOrE/07b0zoD1FLGvo163hJX0t8G8b5PSqZwwAMuHFbO
	1Y3vOtfGjGO0z01riYFNB0M6VgQZ/a6p+1R+Bj1jNilWfdb+nHFAgTpc4JPL01tyQ/JVxsfoaK3
	6dEmxR/n0JiyW67j0SKImQJcgQ1tdtEtlPQzYhyZMfWR8bF0GHaSrBeo+TAr25OwEw4PvZfnEQ+
	ppFS5NexK7hY1nCjH5axpGU/f
X-Google-Smtp-Source: AGHT+IE1Yl8yl12sXwCRzluuI/TFpQbI/5gdqdFemwiK0ij6Lwfe1aXM9EVtt3AZ6yPchqn3TZ8RLA==
X-Received: by 2002:a05:6102:2ace:b0:525:53c5:e43f with SMTP id ada2fe7eead31-53d21cbf2acmr2701326137.17.1757346913000;
        Mon, 08 Sep 2025 08:55:13 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89601b67070sm8689299241.20.2025.09.08.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:55:12 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 08 Sep 2025 10:54:50 -0500
Subject: [PATCH v4 2/4] hwmon: (sht21) Add support for SHT20, SHT25 chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-sht2x-v4-2-bc15f68af7de@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Ultn1LADtPH8Lln5wBQc0s/woZYsJlh8Lpo2VgUgnro=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7/kTf1N7xMrJh0/Y7xoqtKzL/6gnlL5AQmdvXYWTIO
 dW2w7eqo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACbC08bwT9v0e/m8N4nTtk5K
 bIlurJ2+2oCBkXP/Kx3b3Y3s7tvWejIy3ODbeq0r6qeoX24Cg945hgKtBA6bu2xai1MP9i3jWLO
 UFwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

All sht2x chips share the same communication protocol so add support for
them.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 10 ++++++++++
 drivers/hwmon/Kconfig         |  4 ++--
 drivers/hwmon/sht21.c         |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 9f66cd51b45dc4b89ce757d2209445478de046cd..d20e8a460ba6c7c8452bcdce68a1fce963413640 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -3,6 +3,16 @@ Kernel driver sht21
 
 Supported chips:
 
+  * Sensirion SHT20
+
+    Prefix: 'sht20'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the Sensirion website
+
+    https://www.sensirion.com/file/datasheet_sht20
+
   * Sensirion SHT21
 
     Prefix: 'sht21'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46..90dc8051418689e7a92293df15ce35cd822c77ff 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1930,8 +1930,8 @@ config SENSORS_SHT21
 	tristate "Sensiron humidity and temperature sensors. SHT21 and compat."
 	depends on I2C
 	help
-	  If you say yes here you get support for the Sensiron SHT21, SHT25
-	  humidity and temperature sensors.
+	  If you say yes here you get support for the Sensiron SHT20, SHT21,
+	  SHT25 humidity and temperature sensors.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called sht21.
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97327313529b467ed89d8f6b06c2d78efd54efbf..97d71e3361e9d7f0512880149ba6479601b2fc0c 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -275,7 +275,9 @@ static int sht21_probe(struct i2c_client *client)
 
 /* Device ID table */
 static const struct i2c_device_id sht21_id[] = {
+	{ "sht20" },
 	{ "sht21" },
+	{ "sht25" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);

-- 
2.51.0


