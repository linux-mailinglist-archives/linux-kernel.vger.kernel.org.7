Return-Path: <linux-kernel+bounces-804766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B896B47CC1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A5F1899FC7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294729B79A;
	Sun,  7 Sep 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQqyvQc0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E129A32D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757268866; cv=none; b=Ah4uAlgDFOy+UBgwpzGxPATfIlfQ6XeJx5H9yRs5/VVFgIhfNTmzmkjojyOjhc/rORaFdZL/aLbJhrpfNx47EopElsiNWR938bt8fa8ZIo+FVBnlYBDLetH/OUjn8vvo9G38OgBk1TpGmJqbcvlwAfKEI/4q7seZd4C7EuLVvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757268866; c=relaxed/simple;
	bh=FWBE8TbnpDoILTgny5SLZBpQh7y0VgQZiXP6ZqS4dy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOORcfHdaA8zJIb4w8oue78sIywbS1eaPDCchPbBZBx4y7thXmB9fl1OJjooPLZo1XHbgBA8H9YWyEyu136isct4/UfATuo0yT1oAOApRv2qp2nataIvx+v+LaWsJWrOBl5v1oUXSkDR4qQSUAPhyAAFQqNY7F0LKP2zk+6xw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQqyvQc0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Eb6jw011809
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 18:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zXbvHhAHt3e
	XLIh4fGNwnDZCLikwnim4WFNUvEbF34I=; b=aQqyvQc0HXfZCig0yNWtZPUzqtV
	XRX51ydJPaziJ4FujVFMTVQ7z7X+ZOEZhyKz1Rflhul7xtyzBNBPxoeIvfpLVij/
	/ktL6/Ey6vFSljnVqj+uAOhHa/BK+L2D1ddSLw2GrWq5oXd+C5/D7i96E/Tz/8Ck
	4MIUsq3ifXW1DWM2AWHvepeSV4oeWF3c8ZxnVw8CBZ8wVwsxvQdUo9yuRibLDtGk
	9Ks+bDko+jCpJDJQsKO8Iqpm1s44brak2bSY6pNKYaO3voDOQWTKc5SK053Tg3Nq
	kRftvkvhRcX4pyiOFRGuTQY6KzIuYCLx47HbGXPoMbPslFHG4sFlFs2ewMA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqftc4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:14:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24d4ab50385so35376725ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757268863; x=1757873663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXbvHhAHt3eXLIh4fGNwnDZCLikwnim4WFNUvEbF34I=;
        b=t5pCMXH2k01h7NHjLIgQ3j/WvFFifUvza7xKdjxlk1mlISz8TGPvYhGnDtTXf5zndu
         ZVowVqtcLA6lJab/ChUa6qW169u87TlSetFkjXmbmVA38MLWDmtT5QVraW9ExmA70Y6j
         TV9tOrRq6y3qqFZGDmQfPEgHMEx+knn3mG7r+qbbs+RoQiVoiLc07tdrI+jg5Q7YidV4
         /vGo8VhdSxmLvdfTVz+6lwgm02Da1lIUJidOOmPf3LXjBXpwnLMKhJC4DoWUGMrjg0Na
         eT3Z9QHYH+xLEPmAwqui1Jw0WK5A3ByxtMWK/9WQnTq2VZJEDwE9a2gmqDhC3m/7zujm
         5Bcw==
X-Forwarded-Encrypted: i=1; AJvYcCUXPm5/oEo6euu94Claxz3slNrLVp/VYsUJ8Ra+z7rEj9qBzgoYDMSdcASzBTMsV0JW209BZFhjaIHo9C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhXIqW38zCdcef1NKWX6fM8PseDGOPacZR5cIZgnLB673q07V
	4ucJpYlkHfTjaGSx6HMYiwnxJRHZW5C4rKYW+Die2xDvBOMDtu4cMOLSXcsFLBZUswc1PvejVwF
	+qZgBD2HcXFXb2aQy0kzRmoJK8GNVhfonjol6wNsfX1GPBQ7zVmYDdjvypodXLxXmNgc=
X-Gm-Gg: ASbGncsXL82sMnCKkLTklZyIsROsoGuBEoEJ0fT9Nejt7h/YUU2mc9K7Zwk/S5pE0PM
	3ltvbsA6epQH4PcHxdDjPcvtkN9PQVM9IODAz2SwiTWJQgiKwiDKKVH61s+zz2unZ4UpYjfzgY2
	x1VAzMy3UYyNCvHjQ4sXVXtV2n6HxdSwZrWAQsRTzk9ENDfuIUfTXWPFPO5t7DHXRVlUueWT02c
	k8HZkMtDmERUihKnpp9dE4J27whXefj9H1cIyUQBrBQ2dWU4YoKz0lI2jQE/Jh0cIdo1RSpoIWl
	7y07lH7av0fEM9u1Rktk1W1+IfYRQo5KPzMTiJxuDG1YOLUm6qKQfP9tmu5QwchLAPtdRNo+VIA
	fDw==
X-Received: by 2002:a17:903:1905:b0:24b:1585:6350 with SMTP id d9443c01a7336-25175f6e65emr79397075ad.11.1757268863157;
        Sun, 07 Sep 2025 11:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfb9X7Y0iEuBI2GhrDyKdeAQMyHma5HcIN4lLPMF+QE9VYRSDXVNdwO2//mXVcLKZed3gAiw==
X-Received: by 2002:a17:903:1905:b0:24b:1585:6350 with SMTP id d9443c01a7336-25175f6e65emr79396855ad.11.1757268862650;
        Sun, 07 Sep 2025 11:14:22 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cde5b6484sm84074765ad.19.2025.09.07.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:14:22 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5 1/2] usb: dwc3: core: Introduce glue callbacks for flattened implementations
Date: Sun,  7 Sep 2025 23:44:11 +0530
Message-Id: <20250907181412.2174616-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com>
References: <20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sFxZif2BpfgF35Eiy_JwckA9KpA0JieO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXxv0+PXoNY2t8
 sHHwIfrw9BdjW7Wp6JU4ZiN/bNtQ+rDlNiFYfyZHbr1RGUzzFmqi7aLthnDXqsMCbOLf9ksAK9+
 gBvooXvYkGLqIpPKD6HOBpmPwzTO7OO9nR4o2C/hBlgMc+Xhf4rsKYkULb7YxzWMkd146Tc3IPU
 qqkWxGc3BFGD8XE4Tl9FrJU1Go1J6cA0bcQms3UfBFwNAaHzAwo9svmnOWA5brCGm4AJ+w0QJVO
 65cGticCtLvBWNK91umwEXtR+3dmIYK5exYAemwwG5u/sNupVACxoGJufPHwJGjDlnd3lbREMQC
 VtL/AgWYITYLyqYu74M6B1RqTbnkG4VDHwyYMlZXOJqEn60bv5piRDjLlGDUuQzYSyRyeRYlws0
 ba8VCZ2q
X-Proofpoint-GUID: sFxZif2BpfgF35Eiy_JwckA9KpA0JieO
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bdcb80 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8 a=9UFxAfr_hboBSpCGZXUA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

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

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c   |  1 +
 drivers/usb/dwc3/core.h   | 26 ++++++++++++++++++++++++++
 drivers/usb/dwc3/drd.c    |  1 +
 drivers/usb/dwc3/gadget.c |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 370fc524a468..ae140c356295 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2352,6 +2352,7 @@ static int dwc3_probe(struct platform_device *pdev)
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
index 554f997eb8c4..6f18b4840a25 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2662,6 +2662,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		dwc->pullups_connected = false;
 	}
 
+	dwc3_pre_run_stop(dwc, is_on);
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
-- 
2.34.1


