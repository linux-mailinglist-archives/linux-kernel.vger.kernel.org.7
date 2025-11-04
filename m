Return-Path: <linux-kernel+bounces-884116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CEC2F646
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD074E9EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0132D46DB;
	Tue,  4 Nov 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RaLZOUIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="egl8Nlzl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146152DC798
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234767; cv=none; b=Ekug+QnxQQUdz78Gv99SJrdIQqpOF6oyaLfo1tBBqFCS2TXFqaqjIoMkjR/3mKgBvPawYAU1GYEnwgSUqWLM6x2PoBPzY4V3x/sr1MTJK6bealwGCilt1cKbw3VsdGq/L4TRg+Mz31EE8WAhlwsaoktb2ApoXnzSidlvg7yzths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234767; c=relaxed/simple;
	bh=55g5w1v7atZqC7FlHEyUgZm2ivpUlSG09PoKfW0YLDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiBovLUih8pBY9XkLjSkqsIsq+uDI6XZbq06X4jJNNqOyFr1T1eOetm6Cd8Yk/y5vgbvziQu0N4+MRA2kHgebCqXFoY0+KiJOgEWReMwg6UZnC7qAsAP4/DYpDZ8fqIIjF2+IE67xRwdSwymOrwbEI88pgl/mz8ScwIZzoAEaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RaLZOUIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=egl8Nlzl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42ChbV3682841
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 05:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrNsyrAAQeANKLO/A4qgRpf2x7znZFLyg4LxquGbdIQ=; b=RaLZOUIYSddSVbNp
	4IZjq9WCHxJua71F3TYJnNnOWayOkPZ5p6dG4rTbTUYfRt/nKLHQAEyUeXn9Ov2K
	QN/wqqDZAef2s7cqtjZSYv/dLNFJiUJSB1tWIMeO8yYOVs/Et89WGMKm4+kdPyzA
	R5t6/spZpnarsXkGMegfPSSCFJt7KhmgZA45PN4+ES76bJA0J5H2c78D6G8i0Xjj
	6vCD4VXfMjUGJh5YgT4GIfLp9FcohpDtVe8kUssbFuVMDJJ+yjbKTMDsCYFvfsdr
	0npAlvUWkAA21drOS84ZQmTvHC4lrCjPXjXX3BOvmiUAEtRoCfJYXinBoGsRSluI
	fX1zOQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqt7jw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:39:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781171fe1c5so5118910b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762234764; x=1762839564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrNsyrAAQeANKLO/A4qgRpf2x7znZFLyg4LxquGbdIQ=;
        b=egl8Nlzlx3ojvrjB8vSsKwsvgW4xSJqeymqJJlTKDMC4+r47eflLlj68NabHBKx0pp
         VwGSJg0vZWFDVxKU5VUaGX32sSNSy5SjSR1iB3IE62Darfks9SSM/rglV2Z4yAxAzGfu
         CcfbHGreQzz4bbaVIG6wTYRPC/hDlEPT35oqWGdg6S1k5u11hdxnWs0Cy5j5m9EU1/nD
         FUHxWYZrJHh1Meq63fMi6Lp3+yYtbMrkye6B5mB5PnzaSZQfqk+mOwrE0beD1k4hH3HD
         CQu4IhlNNpSuIhJNvnwmQWnCXkkOJMlT1j22FY6Wll0bGukcA1eChXGkkPJqy6jjGOo3
         EBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234764; x=1762839564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrNsyrAAQeANKLO/A4qgRpf2x7znZFLyg4LxquGbdIQ=;
        b=HFae0U39hfVcqlSb4BadDyd+QbPQBMTcDnubDFlKRAL2ef7o5ZGy44AtJWLUUDC/wd
         4ov6+96zjjxWKrmzCe4GDgm2UJCqMd3Wn2Do38irvMWYfmOHuSoXMLnMIFQaJsZdBWdJ
         2SxG99W+xMNgi48T06C+WN44QAbCMuoEKgmFqZxrT6s3XNnKm0AraoRY8GRu1p+BSmks
         5qGY9dnBnRrfhauQs11APqRPyNOwMwefKoBVeKTsQtXKCFH+STscmVYjrQ1HKiifCWJ7
         WcAGurxiIgRm/AXEeHLnHN/GBDBgr2DFlcyJYjSer3KfNy7/IgAcRIIWXB7hOgzCd/tH
         A8eg==
X-Forwarded-Encrypted: i=1; AJvYcCUxwNGb/2Y++cRHK+4RtzNvAdTYMrZDLjrnwyzTQW9MDHYo5xWhXs211pt2EnfV55PX0NtX7wLJwB+hMd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YychMspW2lluIDka0PWkIbAjJcppgt7MXDoPU/nkX7ZgYBmLE8v
	p1qw1QW10v3eAlv8kpdRBDVDcoFSRHAXtJJ2eKp4HbHByjjs2KvvhZZyzkFOLT5YlaSOQSwlRX0
	X/N1QLgAxWiB0/Y0ofiSerKu9pP2IQfFr5NjQVsyssq9QWAVE4hHbVWJLKO7SHckHQMNuHzeNb7
	4=
X-Gm-Gg: ASbGncvRVncvIDu8mM0IqlIN4iEihKi8TkLdJW0gy6555uCT7m0pdSbicfclsCJXdHH
	Xz//h4zb7OWdLitbfPo1EER3+fB/YKMeTVWi5HHAc1D9Lf7CMzkKYP98PGksim8G+KiaR8ScaON
	KEAur02AZvYtd3CfAGaolT4lJ4foZW070rbO5tFay6kiCeoL89Ne0NOsxCcCF2N1MljEKq4+Ajn
	SuJAz3PT+pmMbhvSp3O6X8M2TGgx4PN2/dC1V7msNR6XFXsF131FHBXdOE+dx/mEAFeQa8+hfvK
	klg2tasePTrTvam/4raReZH9KYaRhN2tWaS0uyopGefKPv+93qwRA4Lx6Z+PgcyY28kevT5eEhl
	6KrbCwK+3ThtDvtoyjphyqwCZ
X-Received: by 2002:a05:6a00:14d0:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7a7791d1095mr18877078b3a.21.1762234763681;
        Mon, 03 Nov 2025 21:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEijn/jz8S7gAQ+A+SBLqSusKhoWImqfxlcp7ot10qdXI/K3YzGqGQaeNZiSmxENWVhzlFBfg==
X-Received: by 2002:a05:6a00:14d0:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7a7791d1095mr18877054b3a.21.1762234763045;
        Mon, 03 Nov 2025 21:39:23 -0800 (PST)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3150f0asm1462402b3a.2.2025.11.03.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 21:39:22 -0800 (PST)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 11:09:07 +0530
Subject: [PATCH v2 3/3] bus: mhi: ep: Add loopback driver for data path
 testing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-loopback_mhi-v2-3-727a3fd9aa74@oss.qualcomm.com>
References: <20251104-loopback_mhi-v2-0-727a3fd9aa74@oss.qualcomm.com>
In-Reply-To: <20251104-loopback_mhi-v2-0-727a3fd9aa74@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, quic_vpernami@quicinc.com,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762234749; l=5851;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=55g5w1v7atZqC7FlHEyUgZm2ivpUlSG09PoKfW0YLDs=;
 b=kjeVsgjb69vvWgdU7yVyZm+TBKSCTxucL+1PNaZwhP8PV4sxUhL0IANRu+uLhhqkvUiF0Kow1
 hMFrvzyAYHfDzZ1st8Di7Jb8jSOJ0s+JEQ8YVv8z/4+OQa0QEJcHoAA
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-GUID: 1ROqaupctxdm2MNcrwRFtTd4waIsOxLg
X-Proofpoint-ORIG-GUID: 1ROqaupctxdm2MNcrwRFtTd4waIsOxLg
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909918c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RyQsIt2LcgCPV6mEHuQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA0NCBTYWx0ZWRfX7ueIsNAFGs1e
 N5GzSLLYUFcIekv0i94SVhltXAkFSiGzOCXFA2h3bre0L7LGE5ufX57wUhXeXwmdP6mNsvJDNKS
 t9B4cII2uo8J67pUEXKd/0/3VIDSZK4Qmv7T6YXsyHSKGaM4hjoMVVlbLxpNlIG+S9Xf3R+plCZ
 YF1EoPb7JxHtZIuVEQxQr+LmFSQWdZWZNYf3OuSQuMWI1jUa0pu2S8E7FKw5jU4QZLF71IoiBsW
 zxRkseC+l/Efjycmbo9wgcWic8VU3O14y/p9b41aklJNt0HnkVhekWHq7NPqrveQfp+CaQPitLI
 dqTlOGtmUhaKyMv5P2ch1cXWR1soBNd0UR0IS0+R32gfYIAtwtxAVSClVYii++FVyaEiUcPyda0
 tjJvD0C1vroU8gRfibjMEaPM7IZVdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040044

Add loopback driver for MHI endpoint devices. The driver receives
data on the uplink channel and echoes it back on the downlink
channel using a workqueue for asynchronous processing.

The driver is useful for testing MHI endpoint data path functionality
and debugging communication issues.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/Kconfig           |   8 +++
 drivers/bus/mhi/ep/Makefile          |   1 +
 drivers/bus/mhi/ep/mhi_ep_loopback.c | 134 +++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/drivers/bus/mhi/ep/Kconfig b/drivers/bus/mhi/ep/Kconfig
index 90ab3b040672e0f04181d4802e3062afcc7cf782..ce7b63c2da82a6ca49528517687f4910552c35bb 100644
--- a/drivers/bus/mhi/ep/Kconfig
+++ b/drivers/bus/mhi/ep/Kconfig
@@ -8,3 +8,11 @@ config MHI_BUS_EP
 
 	  MHI_BUS_EP implements the MHI protocol for the endpoint devices,
 	  such as SDX55 modem connected to the host machine over PCIe.
+
+config MHI_BUS_EP_LOOPBACK
+	tristate "MHI Endpoint loopback driver"
+	depends on MHI_BUS_EP
+	help
+	  MHI endpoint loopback driver for data path testing.
+	  This driver receives data on the uplink channel and echoes
+	  it back on the downlink channel for testing purposes.
diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
index aad85f180b707fb997fcb541837eda9bbbb67437..02e4700e8dc3f860d40290476b0a852286683f8f 100644
--- a/drivers/bus/mhi/ep/Makefile
+++ b/drivers/bus/mhi/ep/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
 mhi_ep-y := main.o mmio.o ring.o sm.o
+obj-$(CONFIG_MHI_BUS_EP_LOOPBACK) += mhi_ep_loopback.o
diff --git a/drivers/bus/mhi/ep/mhi_ep_loopback.c b/drivers/bus/mhi/ep/mhi_ep_loopback.c
new file mode 100644
index 0000000000000000000000000000000000000000..ba6154dd9b785f051043c10a980ab340012ba986
--- /dev/null
+++ b/drivers/bus/mhi/ep/mhi_ep_loopback.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/mhi_ep.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+struct mhi_ep_loopback {
+	struct workqueue_struct *loopback_wq;
+	struct mhi_ep_device *mdev;
+};
+
+struct mhi_ep_loopback_work {
+	struct mhi_ep_device *mdev;
+	struct work_struct work;
+	void *buf;
+	size_t len;
+};
+
+static void mhi_ep_loopback_work_handler(struct work_struct *work)
+{
+	struct mhi_ep_loopback_work *mhi_ep_lb_work = container_of(work,
+								struct mhi_ep_loopback_work, work);
+	int ret;
+
+	ret = mhi_ep_queue_buf(mhi_ep_lb_work->mdev, mhi_ep_lb_work->buf,
+			       mhi_ep_lb_work->len);
+	if (ret) {
+		dev_err(&mhi_ep_lb_work->mdev->dev, "Failed to send the packet\n");
+		kfree(mhi_ep_lb_work->buf);
+	}
+
+	kfree(mhi_ep_lb_work);
+}
+
+static void mhi_ep_loopback_ul_callback(struct mhi_ep_device *mhi_dev,
+					struct mhi_result *mhi_res)
+{
+	struct mhi_ep_loopback *mhi_ep_lb = dev_get_drvdata(&mhi_dev->dev);
+	struct mhi_ep_loopback_work *mhi_ep_lb_work;
+	void *buf;
+
+	if (!(mhi_res->transaction_status)) {
+		buf = kmalloc(mhi_res->bytes_xferd, GFP_KERNEL);
+		if (!buf) {
+			dev_err(&mhi_dev->dev, "Failed to allocate buffer\n");
+			return;
+		}
+
+		memcpy(buf, mhi_res->buf_addr, mhi_res->bytes_xferd);
+
+		mhi_ep_lb_work = kmalloc(sizeof(*mhi_ep_lb_work), GFP_KERNEL);
+		if (!mhi_ep_lb_work) {
+			dev_err(&mhi_dev->dev, "Unable to allocate the work structure\n");
+			kfree(buf);
+			return;
+		}
+
+		INIT_WORK(&mhi_ep_lb_work->work, mhi_ep_loopback_work_handler);
+		mhi_ep_lb_work->mdev = mhi_dev;
+		mhi_ep_lb_work->buf = buf;
+		mhi_ep_lb_work->len = mhi_res->bytes_xferd;
+
+		queue_work(mhi_ep_lb->loopback_wq, &mhi_ep_lb_work->work);
+	}
+}
+
+static void mhi_ep_loopback_dl_callback(struct mhi_ep_device *mhi_dev,
+					struct mhi_result *mhi_res)
+{
+	void *buf;
+
+	if (mhi_res->transaction_status)
+		return;
+
+	buf = mhi_res->buf_addr;
+	if (buf)
+		kfree(buf);
+}
+
+static int mhi_ep_loopback_probe(struct mhi_ep_device *mhi_dev, const struct mhi_device_id *id)
+{
+	struct mhi_ep_loopback *mhi_ep_lb;
+
+	mhi_ep_lb = devm_kzalloc(&mhi_dev->dev, sizeof(struct mhi_ep_loopback), GFP_KERNEL);
+	if (!mhi_ep_lb)
+		return -ENOMEM;
+
+	mhi_ep_lb->loopback_wq = alloc_ordered_workqueue("mhi_loopback", WQ_MEM_RECLAIM);
+	if (!mhi_ep_lb->loopback_wq) {
+		dev_err(&mhi_dev->dev, "Failed to create workqueue.\n");
+		return -ENOMEM;
+	}
+
+	mhi_ep_lb->mdev = mhi_dev;
+	dev_set_drvdata(&mhi_dev->dev, mhi_ep_lb);
+
+	return 0;
+}
+
+static void mhi_ep_loopback_remove(struct mhi_ep_device *mhi_dev)
+{
+	struct mhi_ep_loopback *mhi_ep_lb = dev_get_drvdata(&mhi_dev->dev);
+
+	destroy_workqueue(mhi_ep_lb->loopback_wq);
+	dev_set_drvdata(&mhi_dev->dev, NULL);
+}
+
+static const struct mhi_device_id mhi_ep_loopback_id_table[] = {
+	{ .chan = "LOOPBACK"},
+	{}
+};
+MODULE_DEVICE_TABLE(mhi, mhi_ep_loopback_id_table);
+
+static struct mhi_ep_driver mhi_ep_loopback_driver = {
+	.probe = mhi_ep_loopback_probe,
+	.remove = mhi_ep_loopback_remove,
+	.dl_xfer_cb = mhi_ep_loopback_dl_callback,
+	.ul_xfer_cb = mhi_ep_loopback_ul_callback,
+	.id_table = mhi_ep_loopback_id_table,
+	.driver = {
+		.name = "mhi_ep_loopback",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_mhi_ep_driver(mhi_ep_loopback_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <krishna.chundru@oss.qualcomm.com>");
+MODULE_AUTHOR("Sumit Kumar <sumit.kumar@oss.qualcomm.com>");
+MODULE_DESCRIPTION("MHI Endpoint Loopback driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


