Return-Path: <linux-kernel+bounces-829562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C4B97581
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA681B211A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06693054F8;
	Tue, 23 Sep 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgA28qNB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860873043B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655787; cv=none; b=LA3pJV8gm/pZ/8dE/R8CpbeZjPQmiqeVhaUMicMzxK+oXlO7nO4UyNFnPyyfwc9yYRYZjgsUG68a1Y9mAtEKFyBDUXtTd626EDtOga+V/o0nm9lrElD6Vtuweu/GDWQEd1m2X9x+DZFWjGCNHwVvr3CPSlv7LJdtmk52+tIUkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655787; c=relaxed/simple;
	bh=fP3thc+kVifTosgn3z97ZGSIOh9Iu49HneFiVEHzD6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmkf9FqCbptJQNwOV3VVOQCiJCp7uKJ+lO2iGH5whWeSnx03Mwot5GrzpAp367Fi/aSC/3PcwzUNf7AcFGVf606igJUPromma72vIUb/MSViCZz9Q6pXvjEm+GsrZ2mKak+gQ+ksheHXVLvnBKchLj8HrjuP+TC5kxBr2mH4bUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgA28qNB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2e66a2fb63so360108766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655784; x=1759260584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48AS41XIpjVoRU+0wgpEbU66QCbFruFApgvY2hxBZiI=;
        b=AgA28qNBm3mHAQUw75KGYGhZe0eQ6vdW0+tECAWXr+Tf0leXkJKeiNAVryiI8NIamr
         NWeSX3twMNWOfMiUvT8pTLRG2U3awMse+oX1+ts9etCEMalkyx0JDgt9+iSGzjX1fHBJ
         Y3mNgRAyjwAyf73zhcBN0ZUlq7sXKITktKwdGP7sg4usiMW70UOAEL//o6Kqp7poPDbV
         q/qn2RxfRIlBRRwPxleZokLE6x7hV2gycV7UKQTfbbZfjasE7rO3e113uYVGv5UhasnI
         KEqw1G1odywluMM9h/EGgMJuBsFCmyBU8MHJ2czZMytixgXvTfbk33FKfIEOnkS2IUuy
         Mv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655784; x=1759260584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48AS41XIpjVoRU+0wgpEbU66QCbFruFApgvY2hxBZiI=;
        b=gvFEpslaqSlwQuCkHkTdSzXRg7V8l3Xa5fGQsDz7sgc49HQLhYrhlvw+r04a4DLXgR
         bZT+Pp7ST9xN6VWXvfpI6/FQ5yUpgl1ooIQKEdQQMZRMBN/5WGeT3ESFZI+VNavu8IJL
         YhOg6BDPGl5Y3b1IxZD2oy6prw7TyfxtvDZCZ3SiofdRDa7rBGxNYeACoEERRrkUBPMi
         aqV8eXMRb77xdvOCc8NV8Af8Q/JeNmFdoMcUaGUlY3NbX+l6hGsdy7iexbe2IDZIgXRA
         OuOIP85AvYFnZAvr2GZF7w8lo5P5NepjrWj3gKjxx4Fhz0nHYafYnU5BNvmaKfUhjPO9
         OVZg==
X-Forwarded-Encrypted: i=1; AJvYcCUpTBPJnYPQT1d/9yUaG3XAtlGEo01h7dzSiX1Y9dQ2rigCfjm8ydgASzJsxiZpKC0OXtoh30M/kmkU+wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8eGm0oT5i1sM9jxzAGBl2SZr9bYb2keyG/w0qDGz579hexGu
	9cBNY2DId6nsAc0EY3fdsN7g2HBBqFrC7YunxNJuq+B6j6ci6ElTfF1Y
X-Gm-Gg: ASbGncvspvDOs2L/LUwe+JHw4moOqELN6ZRABj12CA74NT2/9bjkvnIk8QCN2oIXn7X
	7BTX9hTiPiQro3vo2Yg0Q036jfSsVOyFLvVjZsUnlmrYaQL5N/pp9FPq4O1xV1y1yIMwERcnFfb
	ZRWSqaWXsdbIn7uA9gdgiZNplQVFDbSpjfZMmHh8AQukK0dQHPUWxV/VmGc8J1ftfaTrTQFfvvI
	NBDhEX+A+FJgG8JTUnv/hNmlh1UFhRw6h4dZVvOZIGAXQp1M1jcwYkiQ5CrM1kE1TAjFJYI5TcY
	oeBPH0pF97qiv2gmaP/4+MxYVw3zu7KLaQ9c7fJLCmLOBPsoUxy6Knc9weMMTDBFcooRAd15lYa
	BP00dIF/X3X4aNetkiXATQNWlsJ4DH520L2p2vR+ySQw=
X-Google-Smtp-Source: AGHT+IEJi5n4B3lRbxv0Dhubtahif4aO7G+ZtrfSFN8eZ2s95Bk6Owhctf2Hc2F2YFNV0l1GWudmIA==
X-Received: by 2002:a17:907:3fa8:b0:b04:563f:e120 with SMTP id a640c23a62f3a-b302bd15aa4mr365987166b.53.1758655783835;
        Tue, 23 Sep 2025 12:29:43 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm1370710466b.97.2025.09.23.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:29:43 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Ben Copeland <ben.copeland@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex
Date: Tue, 23 Sep 2025 21:26:56 +0200
Message-ID: <20250923192935.11339-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923192935.11339-1-eugene.shalygin@gmail.com>
References: <20250923192935.11339-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Copeland <ben.copeland@linaro.org>

Some motherboards require more time to acquire the ACPI mutex,
causing "Failed to acquire mutex" messages to appear in the kernel log.
Increase the timeout from 500ms to 800ms to accommodate these cases.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index ce3ea0333fd9..34a8f6b834c9 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -49,7 +49,7 @@ static char *mutex_path_override;
  */
 #define ASUS_EC_MAX_BANK	3
 
-#define ACPI_LOCK_DELAY_MS	500
+#define ACPI_LOCK_DELAY_MS	800
 
 /* ACPI mutex for locking access to the EC for the firmware */
 #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
-- 
2.51.0


