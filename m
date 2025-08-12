Return-Path: <linux-kernel+bounces-764076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13753B21DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACA21882F97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BF2DECD6;
	Tue, 12 Aug 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2fpHsKr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA32C21F5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978156; cv=none; b=QG3GjLB/D6Ehs+KwkGoBc6lE3F9R4R9I8EfG75uXezl/zOutldWUR9iH0h3IZz2CDhruF53doMoa5GMS3l+DGIcmqf05TU+y4wj4oweAkXjnDtrPAwp7hTF2GSzxvE3VXBUhhKra0ABaoDXqLDKOZSfy57cJHHUjj4U5H2QwetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978156; c=relaxed/simple;
	bh=dsi/nrKzVZMuL/4lw3VF7AO57QYerZ2w9zZyzFIubrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhhmEQYza/DBGP6+112ysUobIbiV2VVfVO+kHtruYXMfLbJmAE5MibYb1jGn2+RG8NviyPH4STUw90Umi0N7Rrlaavz81r6s+nhqq9GE4GpqE8Zy0ZCwSKgoJgZZ2N5n8qRVkdCbFv9nF3Zw7X6OjhU50p64LdhBvrLNl0cg6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2fpHsKr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5P1RM022882
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RDhofFk1RaL
	aCMXm/5C2/6Ncd5FVwO78HtMV84strHE=; b=F2fpHsKrZ+SpHFIvcehGFUDBw/8
	rO1OjG6DNB6SSEPJilxu8KIhEo7Vx4idZxs1Y3brj0m+p05PayVajvT5+bo2NhOw
	lKEpTyqUdo/IbA4jOoH2szaJ4w7lU3evZOYGiiYF2jx0nmsOIfYJgjAGymGMvPzM
	6jAlNmC8P6eEeWwdVJ6FhUEVtKxg2dqC7zbmg3GqL+OMl9ljRyF/Xd2BlJa1nI2W
	jrUdDtjG0HTf4vHu3iRDYeo9rWaOc1MdaqIu3LpzLgYk7vbezzkI2NTvEfjO5WI+
	O17vkyPANCTfe+DIwBA/8wYE164Hz5K4l+LsGEfX2IDlrl1gEnoExQbgj4A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj46yr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2407248a180so43588085ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978153; x=1755582953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDhofFk1RaLaCMXm/5C2/6Ncd5FVwO78HtMV84strHE=;
        b=Qxf3REpU79GU/ypm/baimkfqyR1ANkoAgu6g/dRzYC5yW/L6f6Aoq6eyRHZWtiHvTE
         qVzqWW4s5hZNgN2wMZ5bz0OrRmTBfpzTHKjbRlpoXZ3/qj0sZfNqIGtDEhkWd4YqbQRH
         ZySxSDuh2MRoQ3KT4c51liSe3GsvDXNbT4GaQxzxSZmmNnrM9Npba2qSQrE6CQTPOs5w
         oOJKXWgF+AJjFE2DTwNCh/7r76ggb/dCe8P8hX2nllCReSGriKBzMwlp6PcTuKhPgNSb
         iN1hvgwdnTBS9+9RzP+yT3/G4XU9BaQLrmxplnyLPPY9WkauuFtC7pWwBIXe01JS5LzX
         i6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX54DQIJA6bMnAKsZbpvpk/no0/xjgd86f8maDLePgNXC3oQAw46mdd3Lr614qEls1wjIfcRGjZ8kLyXs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZ1OF4ojGKsRxKekLW5jd5Oq8jwUyAk5n6UocLfCAHxCrd4L1
	kIucHDsiMu06Hs7RpyVdx17E0zoEbtOlDB5odL0oWERfxt2oE+2teGPCsQopXB9isyDo2lInbWS
	CuqPl/fY2u7pPvz0MBJOHr6KDn/iZ8czW99gy9X3d4CPVHRBsfkc8xJkR1nUxPNWbCOA=
X-Gm-Gg: ASbGncuJoX0p3mLr2tA2Avq2z0+Mv1jdLBeSlsUPIAiuilQ1UUZbVlH71YqkF/3sLt+
	0qfJpo5vZlxMlJ7DZCWqy6fYVl8cNYzsNcnfwt3F4cSaK1fea738OpAmz+51iq/z9jKclguWwXX
	ciPVUvei+JdAOoQsykoMLT0pTI5T1F64x15EksU4NvmKMO8XbVb7EqPJj07U/vPoM/qawKMITV8
	4tJ2Y0KT1I+cplYXAQ2ckc9juYHFaPKNA7d07CxGXepe+SAhFvO7n5cWGFDPat+sgZJ6ASVc3Wp
	fEdcEikf+19wyo25RxznyW8IIf939EJRM2yzvJ4JQv0eRab+qsQmUoT4bhn5AEIo9iCFvNL2sdK
	icg==
X-Received: by 2002:a17:903:2310:b0:234:c549:da0e with SMTP id d9443c01a7336-242fc38b17emr38062105ad.47.1754978153388;
        Mon, 11 Aug 2025 22:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXSV4SfnNvn0a+id64qRvfkMtF5ROaM/1BIWLKAuVMiWM8QLsNDekNJyRX6dJDVpUjZY89w==
X-Received: by 2002:a17:903:2310:b0:234:c549:da0e with SMTP id d9443c01a7336-242fc38b17emr38061715ad.47.1754978152977;
        Mon, 11 Aug 2025 22:55:52 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm288585985ad.40.2025.08.11.22.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 22:55:52 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 1/3] usb: dwc3: core: Introduce glue callbacks for flattened implementations
Date: Tue, 12 Aug 2025 11:25:40 +0530
Message-Id: <20250812055542.1588528-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX7rkWuFS62j7V
 7aYR7syCdya/MiByV+XHlTNOx92EQuxk/cxbbLZBVj81Z6GaPc3cDUB9fezV/s49GKOO3HLh7j3
 AZzHS1EKbU6x7IHaEIAN9AthCRv2XduCQ3omklE059y+yfYX2VJiCuwfhkewyoSYUQjSjtC7hs7
 IMT4TjaARQpUxPyD0zV08EqtJ006yYrY+NH0cZLMwJ1tQ3Ra1KXKZ29e6FvvcSLT7gV7bWjFoMx
 RDNiQ9Nqx88DtpSN5G+xotE4/DKQjDjaZBjScE7d4wOPsi9YR+36xTf5pwVWZA66PBJxcgY87m+
 jTH5ouc0vMDAf3+T/pWaAG2vUfBx2gOOVq3rT52FVP/tDkirIPHPJaztBBtq4oyq3Gcv2Fjq++7
 Y9OXE/gi
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689ad76a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9UFxAfr_hboBSpCGZXUA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: HwTj356N0ffYSzOsEAUCePZBV17Ajvkl
X-Proofpoint-GUID: HwTj356N0ffYSzOsEAUCePZBV17Ajvkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

In certain situations like role switching, the glue layers need to be
informed of these events, so that they can take any necessary action.
But in non-flattened implementations, the glue drivers have no data on
when the core driver probe was successful post invoking of_platform_
populate. Now that the core driver supports flattened implementations
as well, introduce vendor callbacks that can be passed on from glue to
core before invoking dwc3_core_probe.

Introduce callbacks to notify glue layer of role_switch and run_stop
changes. These can be used by flattened implementation of Qualcomm
glue layer to generate connect/disconnect events in controller during
cable connect and run stop modifications by udc in device mode.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c   |  1 +
 drivers/usb/dwc3/core.h   | 26 ++++++++++++++++++++++++++
 drivers/usb/dwc3/drd.c    |  1 +
 drivers/usb/dwc3/gadget.c |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..392ba86c69f5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2351,6 +2351,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dwc->dev = &pdev->dev;
+	dwc->glue_ops = NULL;
 
 	probe_data.dwc = dwc;
 	probe_data.res = res;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4..a5fc92c4ffa3 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -992,6 +992,17 @@ struct dwc3_scratchpad_array {
 	__le64	dma_adr[DWC3_MAX_HIBER_SCRATCHBUFS];
 };
 
+/**
+ * struct dwc3_glue_ops - The ops indicate the notifications that
+ *				need to be passed on to glue layer
+ * @pre_set_role: Notify glue of role switch notifications
+ * @pre_run_stop: Notify run stop enable/disable information to glue
+ */
+struct dwc3_glue_ops {
+	void	(*pre_set_role)(struct dwc3 *dwc, enum usb_role role);
+	void	(*pre_run_stop)(struct dwc3 *dwc, bool is_on);
+};
+
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
@@ -1012,6 +1023,7 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @glue_ops: Vendor callbacks for flattened device implementations.
  * @bus_clk: clock for accessing the registers
  * @ref_clk: reference clock
  * @susp_clk: clock used when the SS phy is in low power (S3) state
@@ -1197,6 +1209,8 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	const struct dwc3_glue_ops	*glue_ops;
+
 	struct clk		*bus_clk;
 	struct clk		*ref_clk;
 	struct clk		*susp_clk;
@@ -1614,6 +1628,18 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 int dwc3_core_soft_reset(struct dwc3 *dwc);
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
 
+static inline void dwc3_pre_set_role(struct dwc3 *dwc, enum usb_role role)
+{
+	if (dwc->glue_ops && dwc->glue_ops->pre_set_role)
+		dwc->glue_ops->pre_set_role(dwc, role);
+}
+
+static inline void dwc3_pre_run_stop(struct dwc3 *dwc, bool is_on)
+{
+	if (dwc->glue_ops && dwc->glue_ops->pre_run_stop)
+		dwc->glue_ops->pre_run_stop(dwc, is_on);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 7977860932b1..4c91240eb429 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -464,6 +464,7 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	dwc3_pre_set_role(dwc, role);
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 25db36c63951..999b2e436622 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2658,6 +2658,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		dwc->pullups_connected = false;
 	}
 
+	dwc3_pre_run_stop(dwc, is_on);
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
-- 
2.34.1


