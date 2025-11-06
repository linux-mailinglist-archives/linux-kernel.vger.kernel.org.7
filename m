Return-Path: <linux-kernel+bounces-889099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C266C3CB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7948351AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57D34D900;
	Thu,  6 Nov 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rj4lV++l"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA82777EA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448707; cv=none; b=HSfyhcfxLCD0K3pMtKdeYpacWgcp2qrxpDI4XMh23A5/zZGRLdcjNtVP0znJskZ7HWT8dTF4RY748+7KX+PRrAGCP+qRJd0QgU82v/hnBNaC2fD/4RLDVV3BVYMuzWE6nXmPCtI+uqJA4MQ/E8XUiHPdIkYPSxxvGaxwIOzCsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448707; c=relaxed/simple;
	bh=c/e+BEt62rsqqJeOnddbJJHv4RYDmie9Q5r92l6S9SI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NS2ePnKVGaT4gXN1dtSoytjY98rGvRTjuAZytzvmbZnoHC8/94o4SlIhNe5oz2vSthyolf887jL8nyv9TbpiUTuaAr7O48creIboSyf0uHY9sJFmlSw6mRMAhQKwTG8ij4uaj72aX3fsg1oWtTMRv1psW+Cq7p6u6eontlzSibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rj4lV++l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4298b49f103so510418f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762448704; x=1763053504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmfITIeUR9zgNyqEDGMxgw+mqlzR44/20xSo7lqFBRg=;
        b=Rj4lV++lN3z/uPp6iQiHLwrWIGsFypT/isZk/2okao+prN57Xw/gP0WmrXDGThezKn
         UzkywYy/vajFlK67vfABMHKEOYLSndnwugQ1wXvV94BigEgyiqTUrTcITKrc4TOb2e1A
         xWw+CMJPGFtfTwKfxv10V97qHblonMOXR4AwOgpYRg8iCbXNZBnN7rkYSgOkG4LHqm6P
         TATYKabgK9YiBF7Lqnikec7kCxZ42siZMhnt3H57D0BamU0Oi9lcCpkvTG6KfNdgi1lH
         hmqyzadurRzmPMHRy8MW6jkz1v7JnrttwJeU+ewdu6/Q5pk+pyTCYqRLZPzqAaPKGcpY
         u4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448704; x=1763053504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmfITIeUR9zgNyqEDGMxgw+mqlzR44/20xSo7lqFBRg=;
        b=ho6l4paPHYJT+RIp+g2K6h0R0VXIKFYD0c8yl8q3V6ItELltPPlws/gkqnYn0qu6BJ
         mZUgT74kUEyay/s98aZZDDI8c0kq0KVWic2Ng3ZXE85WmkMC650wxIpsDXUEIBekgIK8
         SyPd/DqMx0QA0cSR78SFCTc4z+i0waTQ1Gjw/qPAauNL8ImKnHT8yKKwRcIABGGzPr+T
         OejHXTAmqHX5iDpecn4XELATZ4rPzwKvKPxhlbsY2MVqko2K0YarzBXnytkITUh5hGnF
         YhbVcw6MfwAGyz5kC8ZRqxn8B0KdJwi1Ai3y1lQ9FzCIgcoYitaWbG/Oe39LLvEnG7zX
         jXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgCvKGC2i346/bdFixj4onFzmfbXDXVA6lUMuWFB7syZfGf3RZu6+AZ39r4rQD75Mf8igjuJwJ/5F9yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13C/RTtLBvxSFrmjO+Uuxg+2k2KaoENs444bKpA43fE8xV+4w
	QJ1Nz4946Za/PcfJ3PQkaKSyGW2JZi/IS7iUEjCQp7q5wH/twQzVIj9Sk+CNIHWH5FY=
X-Gm-Gg: ASbGnctY7K4iJWoSOYHPy7s9kXJP3atw+wTD69P4XzaC/Xii0jcjmiwaur1ILAsda0s
	VcZrYJRDil2xjQV6cUznHTrFjILXXEfhFD5Hw1/QR65HhEi7aY8cA4QKWeIsGU51xIr8UpCsabO
	5QZ/t5RiU0GH+dCMfswovr0HeZXptDzGKAJEhcxcFKr4JPNQpO5HucYje60VPIXrMoRn2OnKmJ1
	buPFt2eTk4SwGpzo5dXmgUY3dXeG3eF8jmBGhZmErX16fRED4gebsSMedIzG5i8Cn+NFMWJX114
	T+3c9Jp17gK0JKmoBl5tmA+zWMsMUT3aGgsPPhsrL56vNXbC3HKBIp7n9gTqsyl1FPcZsmiv5Q2
	VuScvEpsQgbw96NQ5oswyYEVlliMjWxHf+8pHTSd5L/vp8qwEZoH8c7o5kvVpsBccg0Llqsa6Wp
	eBvi/5fJQ/hrotvrsHPTRUiu6fQXGolDr0yp4F7s+vAtXpiq2Diz/ZAqcDFXJHC1bY/dZU
X-Google-Smtp-Source: AGHT+IG6+Y8/xO+RlybIvSJ8UToflUonXatZYaEe3GrS+kZrJwAjzGUthljg2YYqVXNYggrOwWqgxg==
X-Received: by 2002:a05:6000:60f:b0:425:7329:e1d2 with SMTP id ffacd0b85a97d-429e32e452bmr7320490f8f.16.1762448704063;
        Thu, 06 Nov 2025 09:05:04 -0800 (PST)
Received: from linaro.org ([217.38.114.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d54fsm104227f8f.45.2025.11.06.09.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:05:03 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: tmc: Prevent sysfs parameter changes if sink in use
Date: Thu,  6 Nov 2025 17:04:59 +0000
Message-Id: <20251106170459.2348-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs files that change the operational parameters for TMC buffer_size,
stop_on_flush and trigger_cntr are writable when the TMC is in use.

The new values will have no effect and be silently ignored.

Alter the sysfs functions to return -EBUSY if the TMC is currently
in use, and also protect the write values using the spinlock.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 36599c431be6..a1216a1f9681 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -489,15 +489,24 @@ static ssize_t trigger_cntr_store(struct device *dev,
 			     const char *buf, size_t size)
 {
 	int ret;
-	unsigned long val;
+	unsigned long val, flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
+	/* do not permit write if the sink is currently in use */
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (coresight_get_mode(drvdata->csdev) != CS_MODE_DISABLED) {
+		ret = -EBUSY;
+		goto out;
+	}
 	drvdata->trigger_cntr = val;
-	return size;
+	ret = size;
+out:
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
 }
 static DEVICE_ATTR_RW(trigger_cntr);
 
@@ -514,7 +523,7 @@ static ssize_t buffer_size_store(struct device *dev,
 				 const char *buf, size_t size)
 {
 	int ret;
-	unsigned long val;
+	unsigned long val, flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	/* Only permitted for TMC-ETRs */
@@ -527,8 +536,18 @@ static ssize_t buffer_size_store(struct device *dev,
 	/* The buffer size should be page aligned */
 	if (val & (PAGE_SIZE - 1))
 		return -EINVAL;
+
+	/* do not permit write if the sink is currently in use */
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (coresight_get_mode(drvdata->csdev) != CS_MODE_DISABLED) {
+		ret = -EBUSY;
+		goto out;
+	}
 	drvdata->size = val;
-	return size;
+	ret = size;
+out:
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
 }
 
 static DEVICE_ATTR_RW(buffer_size);
@@ -547,17 +566,27 @@ static ssize_t stop_on_flush_store(struct device *dev,
 {
 	int ret;
 	u8 val;
+	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	ret = kstrtou8(buf, 0, &val);
 	if (ret)
 		return ret;
+
+	/* do not permit write if the sink is currently in use */
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (coresight_get_mode(drvdata->csdev) != CS_MODE_DISABLED) {
+		ret = -EBUSY;
+		goto out;
+	}
 	if (val)
 		drvdata->stop_on_flush = true;
 	else
 		drvdata->stop_on_flush = false;
-
-	return size;
+	ret = size;
+out:
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
 }
 
 static DEVICE_ATTR_RW(stop_on_flush);
-- 
2.32.0


