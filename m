Return-Path: <linux-kernel+bounces-828422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A932B94956
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30278483808
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413E33112DD;
	Tue, 23 Sep 2025 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BcISzfLG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931330FC20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609475; cv=none; b=l14F8WUrN3rsgI1yMfN8DeLDYHv/lkbDQ72bkLDJc35+5e8Jr6w1iTtXUjNCZK8uVuNHleRRzc8JJRe52wkuKDCCwMVaiVr37VG/Ve8K78xavHQ/+qKGjVzh1UaY/IM6wKYk5LlgsAf8UsYuEfa1ElqKGT7srnj6rSW+9i3jieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609475; c=relaxed/simple;
	bh=GyDV1zAPt6M4BAQbQYZppmlVchSBpKNe8e6ZOu3WccQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSyDjeY53ZOYNd5YvOWU5hyuRdOCLeJZ+NsNOaWg/tPvLacZTJlU9qVHomC7mxJSxpu7U/q1axHnqvVHNA+mJUUd/U/xpJCpxxI1MSJHOtsoTZAIYeQNQHC3m0sSnwV+kXraG7vcFRlImYjjCaEhE3X7Rsoqrp+9JG//QtUzGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BcISzfLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6Zl2O015787
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o115QF7cjdxwuELjPwNmUZnyAWH+5MdK8KNQcAv/DcM=; b=BcISzfLGDbLKwBU6
	hH6AKDD02d5wIND0Wztt88Y8lO5R/n/JcQQsT/OiEMMRlDctejeMhL1vAX/rwsuP
	OlRLBopezym+btV/HSQCGTa427/wm5pZt7CxfS+ZxW+nY1JNIl+TYVzw+o3loToG
	bZeaK8qJfU3jijG6FqbT9HVwuHqWJLwpTeg3ltMxYV9uTR4gp4x0+JPfIjDjgckx
	2T3zdQ9IvmpQx+RNc96k7lwTnF8dG9ubJ1FisR2EXNxywT99tCDmBHSGxGAww4HP
	CbCgBxK0O9ABZvmPPhQ9pKhbAQ+HEQLBow1My/h0vloeZ6jwyr9RBGIIyBqfkoOF
	jnIJjw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajesw28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so8848147a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758609472; x=1759214272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o115QF7cjdxwuELjPwNmUZnyAWH+5MdK8KNQcAv/DcM=;
        b=UZpY6uhL/GeZuAxR7Fhr/xnpSNGPslH7U9wgFxrYjRo80fhebg6a4mZY+b1KNuJVDG
         5Orjfm3mrF4QA7iKT7YRwJt0WBX+Lzmt/aXN9yvXOAN7uVIuRKayqBnC+LA2xIyFHvbD
         lCWf6z1/fpFPExI4Z/DdMe5qNM4YYrtTn1hk0n9NMk+1HK9+wmfsak2iAbYV0HVAf2ED
         e3STovJ86c/uk94tve0dbA53BLdvwO5LcDnfHB9rln0FmKefOuzEQN0Om9FBRNLUDpsx
         o3gS72uj+GpPOPpk1EwSDys5WLKfV2TJrpAcUi4iBdacJkvA2Bl9hOPorivATmnuPExV
         oxOg==
X-Forwarded-Encrypted: i=1; AJvYcCUanVfnqeZRgLpK2rUWf8IT2L/7P+6GXflaXrhIAwoO2iH3oPaUL7wPxnFvBUIR5ksfgDGSEQXK4u6ZwDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIh8Pta3kZEol4rs/v9BWIl9iNQs/5CgJ7f1B/5T6FTf7X3VR
	Ed/FQkZQSIkdhvWDw2htRHGfwTJg0Dmi6H/pJ+k6o62/y2l25BMByLT/qHZLKg3p70900sXu/8B
	DlVgGuYv4v6Yt7pNbn4sKz61oC43RI6mLD10JYVvcnI9E4v/MZbDDxNJqhc+wnc4EhvA=
X-Gm-Gg: ASbGncvKO3o1duEIjcikX0FBwstOEEm3hvjA51giFcU9mYbJABc3i7o3mYFCx327d2R
	niOqhIa6ft4ADJ1G/WdbEDA0nE/gmMILYm5rEDvfHZ1ryCjLOc8ZAd7jXjXHFMk+q1Cnj7fe7y3
	DsCYjfqSLkWbQbkh1gqiSxDt3q9gJZ8KTAlkpujgHy02/z+GWb/KA/MdY6BIAHnIXjhnGXSlbLI
	MOqAnW1OYakP57xMh49cRIOe1NfqpgM1Aa6VrNlDvZZyJgbWE0i4uoDEYh5//9bMGspQOvululj
	ZAwrSgCMk8D7Vt6ClmCZOB3WHMQhb3UND5htcid6m1UU6motIcZV7yufH/E4HOBxhA==
X-Received: by 2002:a05:6a20:2447:b0:249:fd42:fa33 with SMTP id adf61e73a8af0-2cfd9803d79mr2198747637.4.1758609471613;
        Mon, 22 Sep 2025 23:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw9XUQ4o8BOkYVVVyLpzHXazWVe5TjkOk1T+RiSdOU2wEdtMpEJimpIfmsSeMMzuoB5pI0FA==
X-Received: by 2002:a05:6a20:2447:b0:249:fd42:fa33 with SMTP id adf61e73a8af0-2cfd9803d79mr2198698637.4.1758609470707;
        Mon, 22 Sep 2025 23:37:50 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551905bb4csm10792840a12.29.2025.09.22.23.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:37:50 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 12:07:41 +0530
Subject: [PATCH 1/2] bus: mhi: host: Add loopback driver with sysfs
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-loopback_mhi-v1-1-8618f31f44aa@oss.qualcomm.com>
References: <20250923-loopback_mhi-v1-0-8618f31f44aa@oss.qualcomm.com>
In-Reply-To: <20250923-loopback_mhi-v1-0-8618f31f44aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, quic_vpernami@quicinc.com,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758609464; l=12147;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=GyDV1zAPt6M4BAQbQYZppmlVchSBpKNe8e6ZOu3WccQ=;
 b=4/nsQ00EhRFdsoJ712JR7/BOa4SEw2anAhNVxVeJZznxpGkpuXW1SEbiHCqiaExA1paAlfSzO
 VRsCEwmEGhZCYF23AgcpKCNUc2Gl4GmMTwtKfeR+YoOch7gFGgbxVtK
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-GUID: SDbOOEb4VBzjfBuZnPDQY6-B2S2y3mnT
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d24040 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bacY0d_NKaLyk7ydmrwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX/zSWnkx1DUFL
 gRnnDgobU00FNNunKuar3hVuL7eOYBm7Fv+FyvKLDRQvLVc/iMRE2fa2z6PcsTfTZIz9dXz7bUc
 glApQzMmgsnTbRD+mrvSC2UtYdblyAeQKnYKGiYAyf9riq8BAkH+2GPqs0TTpJdOn2rj7tIWUNY
 1+MnYejCbVMsS8YmtXwywEDUEMxx+mIZmzFLsiX/mUZS5XC/guZCjiI7mRaIKl5rZztDwK/so5P
 va0DEDwUGC7Tye5+oObvOIqL31Kvsv31PolDaLGLyxwz9wT8FGWArwQVOarsTSlaPBu0e/iPXkD
 yllJTUaxwNyjIokj085k/siCdszbw7S4pF0mO/lqAJZOPLPBLTSNjurr5lpL4EZLTVzR5J1Ej6B
 5sgVyNLe
X-Proofpoint-ORIG-GUID: SDbOOEb4VBzjfBuZnPDQY6-B2S2y3mnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Add loopback driver for MHI host controllers that provides sysfs based
testing interface for data path validation. The driver supports the
"LOOPBACK" channel and offers configurable test parameters.

Sysfs interface provides:
- size: Configure TRE size
- num_tre: Set number of TREs for chained transfers
- start: Initiate loopback test
- status: Read test results

The driver is useful for testing TRE chaining functionality, and
verifying data integrity.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/bus/mhi/host/Kconfig        |   7 +
 drivers/bus/mhi/host/Makefile       |   1 +
 drivers/bus/mhi/host/mhi_loopback.c | 348 ++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)

diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
index da5cd0c9fc620ab595e742c422f1a22a2a84c7b9..08a39ecb47f585bf39721c101ed5e2ff44bdd5f8 100644
--- a/drivers/bus/mhi/host/Kconfig
+++ b/drivers/bus/mhi/host/Kconfig
@@ -29,3 +29,10 @@ config MHI_BUS_PCI_GENERIC
 	  This driver provides MHI PCI controller driver for devices such as
 	  Qualcomm SDX55 based PCIe modems.
 
+config MHI_BUS_LOOPBACK
+	tristate "MHI loopback driver"
+	depends on MHI_BUS
+	help
+	  MHI loopback driver for data path testing. This driver
+	  provides a mechanism to test MHI data transfer functionality
+	  by implementing an echo service between host and endpoint.
diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
index 859c2f38451c669b3d3014c374b2b957c99a1cfe..e5d6dccf5a976eaeb827c47924ad0614c9958f8b 100644
--- a/drivers/bus/mhi/host/Makefile
+++ b/drivers/bus/mhi/host/Makefile
@@ -4,3 +4,4 @@ mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
 
 obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
 mhi_pci_generic-y += pci_generic.o
+obj-$(CONFIG_MHI_BUS_LOOPBACK) += mhi_loopback.o
diff --git a/drivers/bus/mhi/host/mhi_loopback.c b/drivers/bus/mhi/host/mhi_loopback.c
new file mode 100644
index 0000000000000000000000000000000000000000..2936fc67e6ff1788263690e2649f2a55398f46d8
--- /dev/null
+++ b/drivers/bus/mhi/host/mhi_loopback.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/mhi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/string.h>
+#include <linux/random.h>
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/atomic.h>
+#include <linux/cleanup.h>
+
+#define MHI_LOOPBACK_DEFAULT_TRE_SIZE   32
+#define MHI_LOOPBACK_DEFAULT_NUM_TRE    1
+#define MHI_LOOPBACK_TIMEOUT_MS         5000
+#define MHI_LOOPBACK_MAX_TRE_SIZE       65536
+
+struct mhi_loopback {
+	struct completion comp;
+	struct mhi_device *mdev;
+	struct mutex lb_mutex;
+	char result[32];
+	u32 size;
+	u32 num_tre;
+	bool loopback_in_progress;
+	atomic_t num_completions_received;
+};
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", mhi_lb->size);
+}
+
+static ssize_t size_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+	u32 val;
+
+	if (kstrtou32(buf, 0, &val)) {
+		dev_err(dev, "Invalid size value\n");
+		return -EINVAL;
+	}
+
+	if (val == 0 || val > MHI_LOOPBACK_MAX_TRE_SIZE) {
+		dev_err(dev, "Size must be between 1 and %u bytes\n",
+			MHI_LOOPBACK_MAX_TRE_SIZE);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&mhi_lb->lb_mutex);
+	if (mhi_lb->loopback_in_progress)
+		return -EBUSY;
+
+	mhi_lb->size = val;
+	return count;
+}
+static DEVICE_ATTR_RW(size);
+
+static ssize_t num_tre_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", mhi_lb->num_tre);
+}
+
+static ssize_t num_tre_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+	u32 val;
+	int el_num;
+
+	guard(mutex)(&mhi_lb->lb_mutex);
+	if (mhi_lb->loopback_in_progress)
+		return -EBUSY;
+
+	if (kstrtou32(buf, 0, &val)) {
+		dev_err(dev, "Invalid num_tre value\n");
+		return -EINVAL;
+	}
+
+	if (val == 0) {
+		dev_err(dev, "Number of TREs cannot be zero\n");
+		return -EINVAL;
+	}
+
+	el_num = mhi_get_free_desc_count(mhi_lb->mdev, DMA_TO_DEVICE);
+	if (val > el_num) {
+		dev_err(dev, "num_tre (%u) exceeds ring capacity (%d)\n", val, el_num);
+		return -EINVAL;
+	}
+
+	mhi_lb->num_tre = val;
+	return count;
+}
+static DEVICE_ATTR_RW(num_tre);
+
+static ssize_t start_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+	void *send_buf, *recv_buf;
+	u32 total_size, tre_count, tre_size;
+	int ret, i;
+
+	atomic_set(&mhi_lb->num_completions_received, 0);
+	guard(mutex)(&mhi_lb->lb_mutex);
+
+	if (mhi_lb->loopback_in_progress)
+		return -EBUSY;
+
+	mhi_lb->loopback_in_progress = true;
+
+	tre_size = mhi_lb->size;
+	tre_count = mhi_lb->num_tre;
+
+	strscpy(mhi_lb->result, "Loopback started", sizeof(mhi_lb->result));
+
+	total_size = tre_count * tre_size;
+
+	recv_buf = kzalloc(total_size, GFP_KERNEL);
+	if (!recv_buf) {
+		strscpy(mhi_lb->result, "Memory allocation failed", sizeof(mhi_lb->result));
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	send_buf = kzalloc(total_size, GFP_KERNEL);
+	if (!send_buf) {
+		strscpy(mhi_lb->result, "Memory allocation failed", sizeof(mhi_lb->result));
+		ret = -ENOMEM;
+		goto free_recv_buf;
+	}
+
+	for (i = 0; i < tre_count; i++) {
+		ret = mhi_queue_buf(mhi_lb->mdev, DMA_FROM_DEVICE, recv_buf + (i * tre_size),
+				    tre_size, MHI_EOT);
+		if (ret) {
+			dev_err(dev, "Unable to queue read TRE %d: %d\n", i, ret);
+			strscpy(mhi_lb->result, "Queue tre failed", sizeof(mhi_lb->result));
+			goto free_buf;
+		}
+	}
+
+	get_random_bytes(send_buf, total_size);
+
+	reinit_completion(&mhi_lb->comp);
+
+	for (i = 0; i < tre_count - 1; i++) {
+		ret = mhi_queue_buf(mhi_lb->mdev, DMA_TO_DEVICE, send_buf + (i * tre_size),
+				    tre_size, MHI_CHAIN);
+		if (ret) {
+			dev_err(dev, "Unable to queue send TRE %d (chained): %d\n", i, ret);
+			strscpy(mhi_lb->result, "Queue send failed", sizeof(mhi_lb->result));
+			goto free_buf;
+		}
+	}
+
+	ret = mhi_queue_buf(mhi_lb->mdev, DMA_TO_DEVICE, send_buf + (i * tre_size),
+			    tre_size, MHI_EOT);
+	if (ret) {
+		dev_err(dev, "Unable to queue final TRE: %d\n", ret);
+		strscpy(mhi_lb->result, "Queue final tre failed", sizeof(mhi_lb->result));
+		goto free_buf;
+	}
+
+	if (!wait_for_completion_timeout(&mhi_lb->comp,
+					 msecs_to_jiffies(MHI_LOOPBACK_TIMEOUT_MS))) {
+		strscpy(mhi_lb->result, "Loopback timeout", sizeof(mhi_lb->result));
+		dev_err(dev, "Loopback test timed out\n");
+		ret = -ETIMEDOUT;
+		goto free_buf;
+	}
+
+	ret = memcmp(send_buf, recv_buf, total_size);
+	if (!ret) {
+		strscpy(mhi_lb->result, "Loopback successful", sizeof(mhi_lb->result));
+		dev_info(dev, "Loopback test passed\n");
+		ret = count;
+	} else {
+		strscpy(mhi_lb->result, "Loopback data mismatch", sizeof(mhi_lb->result));
+		dev_err(dev, "Loopback test failed\n");
+		ret = -EIO;
+	}
+
+free_buf:
+	kfree(send_buf);
+free_recv_buf:
+	kfree(recv_buf);
+unlock:
+	mhi_lb->loopback_in_progress = false;
+	return ret;
+}
+
+static DEVICE_ATTR_WO(start);
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", mhi_lb->result);
+}
+static DEVICE_ATTR_RO(status);
+
+static void mhi_loopback_dl_callback(struct mhi_device *mhi_dev,
+				     struct mhi_result *mhi_res)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(&mhi_dev->dev);
+
+	if (!mhi_res->transaction_status) {
+		if (atomic_inc_return(&mhi_lb->num_completions_received) >= mhi_lb->num_tre) {
+			atomic_set(&mhi_lb->num_completions_received, 0);
+			complete(&mhi_lb->comp);
+		}
+	} else {
+		dev_err(&mhi_dev->dev, "DL callback error: status %d\n",
+			mhi_res->transaction_status);
+		atomic_set(&mhi_lb->num_completions_received, 0);
+		complete(&mhi_lb->comp);
+	}
+}
+
+static void mhi_loopback_ul_callback(struct mhi_device *mhi_dev,
+				     struct mhi_result *mhi_res)
+{
+}
+
+static int mhi_loopback_probe(struct mhi_device *mhi_dev,
+			      const struct mhi_device_id *id)
+{
+	struct mhi_loopback *mhi_lb;
+	int rc;
+
+	mhi_lb = devm_kzalloc(&mhi_dev->dev, sizeof(*mhi_lb), GFP_KERNEL);
+	if (!mhi_lb)
+		return -ENOMEM;
+
+	mhi_lb->mdev = mhi_dev;
+
+	dev_set_drvdata(&mhi_dev->dev, mhi_lb);
+
+	mhi_lb->size = MHI_LOOPBACK_DEFAULT_TRE_SIZE;
+	mhi_lb->num_tre = MHI_LOOPBACK_DEFAULT_NUM_TRE;
+	mhi_lb->loopback_in_progress = false;
+
+	mutex_init(&mhi_lb->lb_mutex);
+	strscpy(mhi_lb->result, "Loopback not started", sizeof(mhi_lb->result));
+
+	rc = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_size.attr);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "failed to create size sysfs file\n");
+		goto out;
+	}
+
+	rc = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_num_tre.attr);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "failed to create num_tre sysfs file\n");
+		goto del_size_sysfs;
+	}
+
+	rc = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_start.attr);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "failed to create start sysfs file\n");
+		goto del_num_tre_sysfs;
+	}
+
+	rc = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_status.attr);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "failed to create status sysfs file\n");
+		goto del_start_sysfs;
+	}
+
+	rc = mhi_prepare_for_transfer(mhi_lb->mdev);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "failed to prepare for transfers\n");
+		goto del_status_sysfs;
+	}
+
+	init_completion(&mhi_lb->comp);
+
+	return 0;
+
+del_status_sysfs:
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_status.attr);
+del_start_sysfs:
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_start.attr);
+del_num_tre_sysfs:
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_num_tre.attr);
+del_size_sysfs:
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_size.attr);
+out:
+	return rc;
+}
+
+static void mhi_loopback_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_loopback *mhi_lb = dev_get_drvdata(&mhi_dev->dev);
+
+	if (mhi_lb)
+		complete(&mhi_lb->comp);
+
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_status.attr);
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_start.attr);
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_num_tre.attr);
+	sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_size.attr);
+	mhi_unprepare_from_transfer(mhi_dev);
+	dev_set_drvdata(&mhi_dev->dev, NULL);
+}
+
+static const struct mhi_device_id mhi_loopback_id_table[] = {
+	{ .chan = "LOOPBACK"},
+	{}
+};
+MODULE_DEVICE_TABLE(mhi, mhi_loopback_id_table);
+
+static struct mhi_driver mhi_loopback_driver = {
+	.probe = mhi_loopback_probe,
+	.remove = mhi_loopback_remove,
+	.dl_xfer_cb = mhi_loopback_dl_callback,
+	.ul_xfer_cb = mhi_loopback_ul_callback,
+	.id_table = mhi_loopback_id_table,
+	.driver = {
+		.name = "mhi_loopback",
+	},
+};
+
+module_mhi_driver(mhi_loopback_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <krishna.chundru@oss.qualcomm.com>");
+MODULE_AUTHOR("Sumit Kumar <sumit.kumar@oss.qualcomm.com>");
+MODULE_DESCRIPTION("MHI Host Loopback Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


