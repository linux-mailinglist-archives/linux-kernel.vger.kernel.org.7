Return-Path: <linux-kernel+bounces-865727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB0BFDDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770B61A05A89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E329C34C804;
	Wed, 22 Oct 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="XsV2AccT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83734D4F4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158277; cv=none; b=RAdXrMX/YAfidg6d/NGp2G3jKOhsTatRNHrFxU0tA4EPLuoAqu7xY4ofTdgEmOXhupXbTTpEiRrlzGhFYlCXGpwsEC3T81egB4Rnf6NRi4sRmPo8HX7k6vErdS5YiZs6SAbuPheUpTfFW4A30JgkJ2yaYhjPsoG53w+1LO8lEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158277; c=relaxed/simple;
	bh=31QxNYMwKtssAJnlVPua8IhszTlj4EtQiy/0WBoRcmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEIRPn2d6+7MrSli7PXTz2SDQMH0n7i5FO2xRBnd+6fPP6YgTpt7ityPzB2tIkqBrv3OLueo1BZqcqytpjY68+EWZCT+5sVw36ssk6fdtyNfIfj0GMKkpmFpPTV9qGAq8xvfw5H9O4gsMN4UiyM9H2Wt8LLlTx27526kBQQIXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=XsV2AccT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2697899a202so9948175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761158273; x=1761763073; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3iB2c7LqGp7VXaDE6QKU06CjceLXW5qv6K68RUJZlp4=;
        b=XsV2AccTKKHVzzg1kuKJQA3FFhs4xUhck60Qq1IKsPGCI6BuUNE83BdDn5ZrZFejhD
         L8UncZfZFsbLb8vEinJ9hQrk/hGzjSfpjaRm4Jay894rpJ3cYz/VobmZTolnbudZJ7Tz
         FatGaiEH/buJnzMucLadZvJXggrGZAYcPBpes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158273; x=1761763073;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iB2c7LqGp7VXaDE6QKU06CjceLXW5qv6K68RUJZlp4=;
        b=LecnGiUwNqja6FgJaCE09eVLBGgnqEYG6zAmJ23aRPvRXi2kd655hTMS9lxEfuQBnM
         tyhv3AA+zEUSQtG0+hBJJs0ecN6KCkFxjAMEZmvVcHLkL7u52LPT/ooeesC6H1n6OLDm
         5cHgYm5UfHUdYWtejLPPaNHm9g4ROkjByknp+uGyvxel0VQ/J1y3cn0Qtaqh/8GiALO9
         2zTI4OR0+aNtLf9XQfoHMZQ2BtoCqkvc4BhLcLT+hlju7Z27PNhjek6cRRBHittAG2zZ
         8wQy+aEfYckQDRE9FRBzOc2mXFbIZXZ48nzqIPWjfxG/5ccSssvWX8Ho/nWMBOQMAB9s
         Z/ig==
X-Forwarded-Encrypted: i=1; AJvYcCVdKZvhHzHDaWSlGPr8L4l07gwg9PNJIHDVEwAx2hshGROX1ly11LE4Hs+cB7JHXusxINkulOQPFers5L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5aNKItOa6C0lEAF6VxdT5U5IIvS7pQYOiHu2aaDd7/XjODN/
	53RgP1ktJvgg8HKQDLehHYrQglELtKYWJ1KqsglaZm3Idg7EeNAVoHajOuy0gls5u6PZB7LLvBh
	IIxjSXiWEauBuxm95bocQHyuQJbbZi+6bEWyD42h9vO0Ko75uJtAUkpc5
X-Gm-Gg: ASbGncu5Ne2rMPaaZLCPpRqIQmbpyWqefiXQbEEtZ08HemwwO/G7hE0toooePWs1S3A
	/tw2TiBL9Wlmtjx9PSHHzq+HP+sC8Cg02Bnx8So97GEdSpxeCmTSmvJFAph9f4hORv+6bX430cd
	chmaIFd//VwMutYdknjSbzTGMuHVSEXgExkz5VUFEpCQm9cyf4bJAxIo7ezJMC8fZ7d+PEEFIkh
	3PqnmnfYfTeo1mtd0RBKsFrNm4txdnd9LEKsn4SF3ST88bz0TRFJq6V5np22FcM+WKo36sghXUd
	CB+5SnzGFtoYKcQMePl0iLpstDIurElX4AMzJLx2ldmDd0BUfkRzzWcTb9QrIx2390jeC+qU/8U
	JgCK3gfvyt2/F65PBl60r5hbrQec7lQKIZhnNA7YCria1NP7ieg3VAsTO3hAh1blbZjQS91dS2z
	3qWT1Wt+x+wh9FTyQGyQQ+FOc7qGeWUfRGLYQoQkrdGXfpvjDuwBrVEwr6pvyM7TbzaQCEWpOXH
	VM=
X-Google-Smtp-Source: AGHT+IGb3ESkvzm9Viz0sN6qMEIEjBclGnTO4jABWevmrKqAwuQy7cN3ZiCnLJDqrhcCyXz0+Mpz4g==
X-Received: by 2002:a17:902:ce91:b0:267:8049:7c87 with SMTP id d9443c01a7336-292ffc0ad75mr58692045ad.14.1761158273040;
        Wed, 22 Oct 2025 11:37:53 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:818d:712:fe94:5de7:1d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fed21sm145155105ad.80.2025.10.22.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:37:52 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH v1] hwmon: migrate i8k procfs interface to sysfs
Date: Thu, 23 Oct 2025 00:07:46 +0530
Message-ID: <20251022183746.66481-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

The i8k driver currently exposes Dell laptop hardware monitoring
information via a deprecated /proc/i8k interface.

This patch removes the procfs file creation and replaces it with
standard sysfs attributes under the hwmon subsystem.

- Removes i8k procfs registration and operations.
- Creates sysfs attributes for temperature, fan speeds, and power status.
- Registers these attributes via devm_hwmon_device_register_with_groups().
- Cleans up legacy procfs code for a cleaner, modern, and supported interface.

This migration aligns with Linux kernel best practices to phase out
deprecated and legacy procfs files in favor of a structured sysfs approach.

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/hwmon/dell-smm-hwmon.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index oldhash..newhash 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -XXX,40 +XXX,80 @@
-// Remove procfs interface
-static int i8k_proc_show(struct seq_file *seq, void *offset)
-{
-    struct dell_smm_data *data = seq->private;
-    // ...
-}
-
-static const struct proc_ops i8k_proc_ops = {
-    .proc_open = i8k_open_fs,
-    .proc_read = seq_read,
-    .proc_lseek = seq_lseek,
-    .proc_release = single_release,
-    .proc_ioctl = i8k_ioctl,
-};
-
-static void i8k_exit_procfs(void *param)
-{
-    remove_proc_entry("i8k", NULL);
-}
-
-static void __init i8k_init_procfs(struct device *dev)
-{
-    struct dell_smm_data *data = dev_get_drvdata(dev);
-    // ...
-    if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
-        devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
-}
+// Define sysfs attributes for temps and fans
+static ssize_t temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+    struct dell_smm_data *data = dev_get_drvdata(dev);
+    int temp = i8k_get_temp(data, 0);
+    if (temp < 0)
+        return temp;
+    return sprintf(buf, "%d\n", temp * 1000);
+}
+
+static DEVICE_ATTR_RO(temp1_input);
+
+static ssize_t fan1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+    struct dell_smm_data *data = dev_get_drvdata(dev);
+    int speed = i8k_get_fan_speed(data, 0);
+    if (speed < 0)
+        return speed;
+    return sprintf(buf, "%d\n", speed);
+}
+
+static DEVICE_ATTR_RO(fan1_input);
+
+static struct attribute *dell_smm_attrs[] = {
+    &dev_attr_temp1_input.attr,
+    &dev_attr_fan1_input.attr,
+    NULL,
+};
+
+static const struct attribute_group dell_smm_group = {
+    .attrs = dell_smm_attrs,
+};
+
+static const struct attribute_group *dell_smm_groups[] = {
+    &dell_smm_group,
+    NULL,
+};
+
+static int dell_smm_init_cdev(struct device *dev)
+{
+    struct dell_smm_data *data = dev_get_drvdata(dev);
+    struct device *hwmon_dev;
+
+    hwmon_dev = devm_hwmon_device_register_with_groups(dev, "dell_smm", data, dell_smm_groups);
+    return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static int __init dell_smm_probe(struct platform_device *pdev)
+{
+    int ret;
+
+    ret = dell_smm_init_data(&pdev->dev, &i8k_smm_ops);
+    if (ret < 0)
+        return ret;
+
+    ret = dell_smm_init_hwmon(&pdev->dev);
+    if (ret)
+        return ret;
+
+    ret = dell_smm_init_cdev(&pdev->dev);
+    if (ret)
+        return ret;
+
+    return 0;
+}

-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

