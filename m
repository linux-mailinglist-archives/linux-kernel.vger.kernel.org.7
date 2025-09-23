Return-Path: <linux-kernel+bounces-828423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC6DB9495C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98FA18A7DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682E30F954;
	Tue, 23 Sep 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2JwHXt2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43830FF00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609478; cv=none; b=hhOyvz/K8XqCeeazfK3Nr0xUyGEexpk2KKDkUb17mFzn13Uy0A4a6iy3AutL1cC4nn29EEZT0Ex9tNxCM+Qt4LLetiYeFJvRWxSwg88KSKaoIUkeOuSV3B0VkkmU7NDyR1jocsbA87RkskGWkqtlo4u5+3QCafIfAbb7kU2nHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609478; c=relaxed/simple;
	bh=/XZjxMDsdlsb2hd1V1q563apP/LGTaw7IP8VKfFQNnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaE+ajnlGFsi/fk9l3tyot8K71Dd1j41iwU9R1AMUgOREIGDD6YoDPX9RsQkWbPzh/4rUaoBXUV6PeXXGZVCmGOZeiditoGAje6qttT76siUvvwLMJIGs4351aHPK+GnICmSpVYUQTpqRCH93D6tGvHmR814MH+4HcgYHiCRCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2JwHXt2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6ZhLN026426
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/2i5gCewt8z3E3EoPGc+LEWHh1OOCMfCgomgDxGz2IM=; b=b2JwHXt2hQ1DXyan
	h1uTZL0FqtBJiQTpA/mZv2s8MtvjISRn3gXI8oeK9shy9r+2yiKiIOY+Z1QKGU5c
	QdRe+gNUZDJtQTubzho4XUP0ArR0dq12H3xJ6YYuj0KiEB7z/TXTXSpcHUSxrZMC
	lTWqnrRBouwA8kwzkwoGbnJ1cvlC1CC6SNtZja22IDVs6ivl221IjmUoeandSJmS
	ByftprOWqB6asnCHkQXdTXSUHsJmviBgQUbwGFcHEaMH+Jy77drSfz0YV4bjhq4M
	rO3zbK2CnacrnA4g+l9cRg/z8dW1abi+4hz+gB/whYBFmgaXtIaJsWBHvziWcFwV
	PjFuDA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnqrff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:37:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f2eff831dso3178824b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758609474; x=1759214274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2i5gCewt8z3E3EoPGc+LEWHh1OOCMfCgomgDxGz2IM=;
        b=DBP1lbF4f/CCcBbVCC/zI97oFRGltqvEOsViDt+qC7JPXKDooaSo7gsPA7EKollhWl
         roYPVRn6Ig3thJ0t63/9ibCfQicnTbhA2wa4jqGsvrBQiZeHpOPBqkxIOYwdvmWKnCmh
         3i4Kytu8Eu/5I8tUjbY2NzlUfjP3G0kxgVoXBcBcSQIIOflyiBOS70kxENbvU6DaqRNl
         xr6rfUPT9pDs0aoAOA37YX/9GCvex9p+JMXVBrIq0LQGqx2VRYiDeZnoTQ93kadsA+Pk
         ri4oOGiqRaPGDLH/wEgYbFKktwGpn8gGBYP1Zkl7ayIKTnvXnOBmUm60xG7S0bxcMU7C
         w2xw==
X-Forwarded-Encrypted: i=1; AJvYcCW7KdIjhyhn53LaNeeiTfBYhcBX3Shb+FO13NFJq+bs9u8F5n9YRMT03Q3qe348q2Gq2B3GTwL3Yos8Bz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpCY/P3EGFpeaT9cA8YWnR/cRcGhLNX+XsRjA7H8acfgk07qy
	ramR3uZDxMObm0XVOlCCp/qtA9oCnYgTHOIsfBk3m/vZ28/Au8W34m1RRLD217qv4kJQ5/tpjAU
	yKRkPdDBVkga2eIwwcxTIgzMfviSLYp9Ir92YPL6xaDzLd4dmb7/35ZUbLHdsvSdXUkc=
X-Gm-Gg: ASbGncvV8tR+5R1/3zvPhPgMVZZ0ON4HTFlZMDakdlYrhF5Oo83rt7OMFIPp1WaoH2K
	ZuoHnfsv219AhPJrfSeTCPtZWupUBw4+BWNyGw2fi+AoNQm9nQUpQabFkZRfJwT5GylZ3xBwrTz
	TaAS484dMlap0cs3Uaa++cdT54LH1ZhAE96Pt8YxWLWp0cTE40C41P52C7jHa/nh9Wjzyxah8Ix
	4kbf3cAsFjZEo6kPqK16AJRJr5bbz4Ca+CXDZ19lChXKYRGK2CPL6vjwfPAgHndfgn/3dJ4H4QG
	mW5OjZcIZWvZPz3/gUpWvb9WbIxp+0HmYqZk8zy0dP3K2ciWQCc50sAgCC+Rli4oug==
X-Received: by 2002:a05:6a21:6d97:b0:2b5:769f:2542 with SMTP id adf61e73a8af0-2cfe8990c69mr2570923637.36.1758609474173;
        Mon, 22 Sep 2025 23:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcdgMOz1PL6eB9rEDeqp235HhjD28WXRHTyz1Aw/HjM+cmU/CEZqbyYKplL/kpmh4rWvdwEQ==
X-Received: by 2002:a05:6a21:6d97:b0:2b5:769f:2542 with SMTP id adf61e73a8af0-2cfe8990c69mr2570886637.36.1758609473642;
        Mon, 22 Sep 2025 23:37:53 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551905bb4csm10792840a12.29.2025.09.22.23.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:37:53 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 12:07:42 +0530
Subject: [PATCH 2/2] bus: mhi: ep: Add loopback driver for data path
 testing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-loopback_mhi-v1-2-8618f31f44aa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758609464; l=5830;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=/XZjxMDsdlsb2hd1V1q563apP/LGTaw7IP8VKfFQNnM=;
 b=WD/6L5VbKB2D38KzJB8gQHdyMsWs2SrkdKIoQaD+MAq6ui8rTHJuvnjhuIKISlRT070gQF1N3
 pruOysrtJ/wAkO1k8tjM0ZDaLdRVlVYLCVovKtsMY741Oxd/fHtv4u/
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d24043 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RyQsIt2LcgCPV6mEHuQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: rrMIOtvOJEiL7y6GenUcAo6jkqbDEo7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXzxhN2wJa/DEA
 fKYRDbTOvTRmIPFFli6ZMFHcIzUoqIVYquu0kVmN8DuJKs+teppSsbbkCKsFVSCSrIAkk8K98v6
 Ujqcfo+wmuhTM6K4vU+ID2+aNkasz1Aq+3hKtVzdExsAGaenmAyrGuwm4RoUOmuDdits32nEKRz
 X3Ga26BqKTRac+YjQTYiiQ9qihYeTRtWwend60B0Z30GfxqyGmXjxl/5vHmQ28xil5utlZ24aPu
 IltyTCJKi73AbNl8m/EgYXycasfQQXnUBeGyhmBhPAOoY6zoZ/oFpzprjRLHbPhnO+8/Kp0p3W1
 Jx+B809GECJ7tnHe3ORldlWK3GnjBlLOiNoOd+ySx4nw5Q9oQgXfwKb4X8lz0BXxsTIMe1GUif3
 JeUbLuB0
X-Proofpoint-GUID: rrMIOtvOJEiL7y6GenUcAo6jkqbDEo7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

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
 drivers/bus/mhi/ep/mhi_ep_loopback.c | 132 +++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

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
index 0000000000000000000000000000000000000000..89244aca684ffc959a38f8a0c3ad577b2d127c48
--- /dev/null
+++ b/drivers/bus/mhi/ep/mhi_ep_loopback.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/mhi_ep.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+
+struct mhi_ep_loopback {
+	struct workqueue_struct *loopback_wq;
+	struct mhi_ep_device *mdev;
+};
+
+struct mhi_ep_loopback_work {
+	struct mhi_ep_device *mdev;
+	struct work_struct work;
+	struct sk_buff *skb;
+};
+
+static void mhi_ep_loopback_work_handler(struct work_struct *work)
+{
+	int ret;
+	struct mhi_ep_loopback_work *mhi_ep_lb_work = container_of(work,
+								struct mhi_ep_loopback_work, work);
+
+	ret = mhi_ep_queue_skb(mhi_ep_lb_work->mdev, mhi_ep_lb_work->skb);
+	if (ret) {
+		dev_err(&mhi_ep_lb_work->mdev->dev, "Failed to send the packet\n");
+		kfree_skb(mhi_ep_lb_work->skb);
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
+	struct sk_buff *skb;
+
+	if (!(mhi_res->transaction_status)) {
+		skb = alloc_skb(mhi_res->bytes_xferd, GFP_KERNEL);
+		if (!skb) {
+			dev_err(&mhi_dev->dev, "Failed to allocate skb\n");
+			return;
+		}
+
+		skb_put_data(skb, mhi_res->buf_addr, mhi_res->bytes_xferd);
+
+		mhi_ep_lb_work = kmalloc(sizeof(*mhi_ep_lb_work), GFP_KERNEL);
+		if (!mhi_ep_lb_work) {
+			dev_err(&mhi_dev->dev, "Unable to allocate the work structure\n");
+			kfree_skb(skb);
+			return;
+		}
+
+		INIT_WORK(&mhi_ep_lb_work->work, mhi_ep_loopback_work_handler);
+		mhi_ep_lb_work->mdev = mhi_dev;
+		mhi_ep_lb_work->skb = skb;
+
+		queue_work(mhi_ep_lb->loopback_wq, &mhi_ep_lb_work->work);
+	}
+}
+
+static void mhi_ep_loopback_dl_callback(struct mhi_ep_device *mhi_dev,
+					struct mhi_result *mhi_res)
+{
+	struct sk_buff *skb;
+
+	if (mhi_res->transaction_status)
+		return;
+
+	skb = mhi_res->buf_addr;
+	if (skb)
+		kfree_skb(skb);
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


