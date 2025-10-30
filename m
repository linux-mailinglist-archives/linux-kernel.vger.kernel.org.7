Return-Path: <linux-kernel+bounces-878932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D28C21CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3808B40393C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6191E363B8D;
	Thu, 30 Oct 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy1FACyx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B92765C0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849344; cv=none; b=b41Nqe/nSP7t+lDRhlgCZ+eGXKClwFSPzvS/Rsc5RvWD42f3hfPPuzc0h1js4IlwDxa76rGu4zA6mfdkvXDT4CG6gnxnZ9i2DejHat5REoTCadxJcbM72/ei39bQqse7XUBDkhWngZ+tTmbBYRvnD10yUr2+29yeiBSuPZklRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849344; c=relaxed/simple;
	bh=1qrajjhp13xpL0CoKzAUqraUrYqycPIA/OdWCWoGiJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4StjCQGyfSyY63zektoRLaCAGR9IVEVWAVIBae9MLMBxA49gpm89JUT1s3low185+zgerDZgOzsLFsiAR9teFNRufFtAJ5WRp9km2yoeW1jrvC7rtsukJa5l5FyXkZrDZvSZp8VQjLf99G6vOOy+o2R8Wu6pG3TH98L3/Uaoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy1FACyx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso16340495ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849342; x=1762454142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8xsKuisRukEib8wrs+zMZBJKZQ/YPyJdbnfQcP0zKw=;
        b=Sy1FACyx7IR6XOKvcyUd1xJguKlRdeLYyW1H8lCy7jm32EGIzCitC3kfyT7RZxtI+Z
         H4roGIzbT1hWmCLGr5v+epzE8w6XnKGeWKPhixLH+C3FvrEMfaE+fwf8lFapNE3BRlGo
         zIzFdkT3fGmDfkNV2lXSS+JAIFHHXS3F+Mbs+x7DA36qcA/YcGw2rR6Gynw9mcOitdHX
         FtHBkQtv5CtvOHzpxE8NBaEndPLdKrNScuXOCFEYjXMTwKZtfPNyrRqObONx0KnouWQf
         DEvDYp8u4tuzSO3KVEma9D/djEM4fjj5oyjWkuetYlv0S+26OEpZcYdP/RTuAucVUF0G
         9KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849342; x=1762454142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8xsKuisRukEib8wrs+zMZBJKZQ/YPyJdbnfQcP0zKw=;
        b=XkaQNy6ALQJi2osb1ammwfFQWmqcJnUOtz8cgm5v51r0I1yywe13mpuPC/dbaWKGF7
         Zoq5G3a3kCDF3Ej5Pg2L1OmD+H7khVN/mbINDLL0f1v/NskNNzeGFWvyromTt8q9ZwkP
         ayQq09btaP6ut8uedZOyZOHiGUG/VStm7aDrjPCWL13DyZrFZNLXqSzxgKBqk4wBvqf9
         SsIJiQzjazZYrzmf30liziDAmai1aN7Fu+gX8yqD7CxiWbrQO4yQ86NoCcW0nfPDdPSr
         bYI6iHkTCLEpdv02SC3YYZgAFSzaro/WTDAK0HX9CxX7FwKv1uOi/WCz8+mO4nPm4wzh
         LrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgk4sqv9JLN84csmZViL4kAbzj8lpgZr3pGAiBD4074DLswtU7Gs07MOJIOiugzQO0BRnUwiBymmSkf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2M3gIMtpzvngNc42thIw+U+akHusLiG13njeZxl8LOqgq7Yh
	Fm2R+DdjpZDaLGMUXTYdjLzlpq6zYJtkVTh2qjiyWYRhVuivGBFhVS5u
X-Gm-Gg: ASbGncsP0AHK2ZABBcIcXX+qLP6eIh6WZirJ5uH4I4XUrzZFv4+278ooEpY6fQsde6h
	O7AsaeX1qmk3zOz5OQIVpPGO/eX/oTRf7Q/cmdcj/3YxgH7VbU13/K0sTf+yI54D9nM0Qj7l46O
	hb5NqcA65b/v8QnxYGc32wJInuFIX6NQab1ZY1r7vCVV5fWUNLvwuaa4Q448pUyp0K0N8lNzBjW
	WUAJLGdpxAv3zuTGRVvKmZFxucOQ+4z4aJtJdn3MUd/yrQCI51e7dcN7ryeuJwtWLVVo4QKsZ7A
	heIBKi3phnzRgQIwM4B2oNYvCZ21ozvy8IqLOMhanphlTIlD3mQ3P3jGleuv6c6Y0XEqjQowyVb
	F/ND2kx/ePihIFL5L4cgpUd3GbF9+HD6vJHee2Qf82+cwqFZBXFbR43DQvHncQuglIq4g9PM7sA
	8XwfdLLz3xgJQzIZSp7aS0Oog=
X-Google-Smtp-Source: AGHT+IGW4Tyk7D3F3D6JGBtTqkPio7zAXmHomclEQkI2qiHCT3Q0ZPi73lO3+xGLPY1C7uPSyGKKGg==
X-Received: by 2002:a17:902:cecc:b0:264:befb:829c with SMTP id d9443c01a7336-2951a423385mr9385915ad.9.1761849342414;
        Thu, 30 Oct 2025 11:35:42 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:68ad:2e67:289c:5dac:46fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-294fc9feb21sm30201135ad.73.2025.10.30.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:35:42 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: koby.elbaz@intel.com
Cc: konstantin.sinyuk@intel.com,
	ogabbay@kernel.org,
	i.shihao.999@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel: goya: replace sprintf() with sysfs_emit()
Date: Fri, 31 Oct 2025 00:05:29 +0530
Message-ID: <20251030183529.93665-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated sprintf() with sysfs_emit() in various sysfs show
functions to avoid buffer overflows.

The sysfs_emit() function is specifically designed for sysfs show handlers
and provides built-in bounds checking by limiting output to PAGE_SIZE,
unlike sprintf() which has no bounds checking. This prevents buffer
overflows that could result in kernel crashes or potential security
vulnerabilities.

Convert sprintf() to sysfs_emit() as per kernel code practices and
guidelines.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/accel/habanalabs/goya/goya_hwmgr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/habanalabs/goya/goya_hwmgr.c b/drivers/accel/habanalabs/goya/goya_hwmgr.c
index b595721751c1..3ef18f42c393 100644
--- a/drivers/accel/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/accel/habanalabs/goya/goya_hwmgr.c
@@ -49,7 +49,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
@@ -98,7 +98,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
@@ -147,7 +147,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
@@ -196,7 +196,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t tpc_clk_curr_show(struct device *dev,
@@ -213,7 +213,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t ic_clk_curr_show(struct device *dev,
@@ -230,7 +230,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	if (value < 0)
 		return value;

-	return sprintf(buf, "%lu\n", value);
+	return sysfs_emit(buf, "%lu\n", value);
 }

 static ssize_t pm_mng_profile_show(struct device *dev,
@@ -242,7 +242,7 @@ static ssize_t pm_mng_profile_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;

-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			(goya->pm_mng_profile == PM_AUTO) ? "auto" :
 			(goya->pm_mng_profile == PM_MANUAL) ? "manual" :
 			"unknown");
@@ -313,7 +313,7 @@ static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;

-	return sprintf(buf, "%u\n", hdev->high_pll);
+	return sysfs_emit(buf, "%u\n", hdev->high_pll);
 }

 static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
@@ -369,7 +369,7 @@ static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *at

 	cpucp_info = &hdev->asic_prop.cpucp_info;

-	return sprintf(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
+	return sysfs_emit(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
 }

 static DEVICE_ATTR_RO(infineon_ver);
--
2.51.0


