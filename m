Return-Path: <linux-kernel+bounces-729466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17989B0371C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8117AB80B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575DF226D03;
	Mon, 14 Jul 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EydcAQoW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252A226D11
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474687; cv=none; b=kVqgqKiVdIvJ+kgB/WxIpaU5XLFIeVtLEkwmL/lM3F383dnnMy5yIuhmeReAschPEpTxAgLsZdBisyxzCfGITHze5obN/zce6QJFtugHJwDRPHeNSMJK1bGRW650CDmmEvQUnIf424harseZkmISCKvcvP5wi/5VYNVo7bWHRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474687; c=relaxed/simple;
	bh=WgNB8JtNu/qnxzLII17QZyIYVM1aQeVHuPJM2eBUR+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tje9ait+xNxau2SZZVVkpLCOjoLsRf287joUk6raibd77xA4kD4wLGfZDr103ZLfrd6K6O7fGC91BfLNVZqmtEmFIQhMFAONLbjIJMPsvdK1C234nrLytwEdsHR/24kRx5Rfui2Ev+sh6g50+eYEdez/YenwnZlf8FgBfE33DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EydcAQoW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DL0280000703
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TlagnvE3DvQ
	Djl8NoW2g4NISDOA+5IeFliGdXmFMGmQ=; b=EydcAQoWsQEBxP6FdYgKjseL38I
	fxMHjTEaQ2QfOtVpm/IyxhqDcIc7M3kfeWf3o63w4PQMqOo01PDV4WgOjdkk4MZa
	wRHQCP7o+opE9Cb+C5F2N8huhmJ7Hr64aNO2aucATCjbFp5Ir2GyYlV2SSchm56w
	vgy/cC9NYtp+F3rvX2NY4AtzDGpLmxHkt//IQvlLDtB3x4bJ4v9pHnPJorQvMndr
	f5gVfftXQzhtZN6FhoUtyBKPmVlyXsop+Dlh/7b+gS0QusBlfnqH/I3wli+Exk6P
	Iofqsy74fdXKTl1HkeP0TzZoZaRjTjV5mVDc8pfCEuvThvgntr33iRhAkow==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbbf7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3bc9d9590cso3833706a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474682; x=1753079482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlagnvE3DvQDjl8NoW2g4NISDOA+5IeFliGdXmFMGmQ=;
        b=aPsy2QIXOsK7he1DnllVVksUHVo2sJde0aen4z71DOn6Y09jCeoJtShNrQSKuA1SaD
         YidBCK9cnObAictJO2xFedOfRAH4w0lvYzzOcZ2iTVtp+zz637QCbeemG3tY3lqjNhLm
         ZA1hSdPTT62oRnV59a55nQ1GO6lsKLIbfM4YH6OLzfE/exYf1bryeAGnjkyk8RYnQex7
         8Z9NMykWTDIDvX6yMJYdCcd1EBmh0n58/3GH/Irx3LnRgTfZ2B++sLdXFSJcBN2myVdP
         5CaoUOQqKOkM3F+gl9XaqyJ2h5oW5YAk52+i+Yqd1BPcBrLmAdzvQLjxgt2jNMr8J/E3
         Lt9g==
X-Forwarded-Encrypted: i=1; AJvYcCXOKdosjqUU9nLNmD6ar4VnEW8sfcIVGSHDZOkEQRaBKuOLVsdzxG4g+fNTDVvBVO8G28lqjA2PijoG+ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTwlqoe+DGFTcD7nhF2r1I1tZTUfZ1gRxFDzXL/Dl4wW26+DI
	8Hu4gl277Wjc3H/Hxk8Rp0DaGkGxs0nF4g9B8zANmbmPnzre0rkBkUM1HcQ3/3g0QqISFe+VI35
	EPsSw8OptYZ0Qj96maNBv7xx62YoKaKojfgpu6fiDBQFonk5dFwLeWtPUihcMXq/NljE=
X-Gm-Gg: ASbGnct77eQSVNArXQiMJBwDfPXrHm5Crf3R0rkedUj6A5vasLnP/xW4HMas9aZGwXX
	DFCM5exNGkKdsaWg4+uxILjR1Qh4cYdTkaQ+pextUAvmD5R20ovC5RSc9wxx4qTD5eAGHzeIpzh
	xyS+1oNOuVfP0XAC7HgQvUl0NHZvc3rY5F4Fay4O/b19v/cZnjYxc41ZIgg6Z5Cf1DfRDKInV1A
	DXEzjKo1ZofgMl9Cw4EOOQDEwYqbaR3/o9njqt1yxKUNBZIfAk3kUUvQ+8jAA1Bt5T8ctC99Nzk
	gE6WApcRDmRyxMq5ZAMd3+e8UxRhAmKt7B1aEYWEz5ChpMyM69BgLtYjc5psil0MbB8p+otiAIB
	Zigy453hL8uRSFrRX3F54
X-Received: by 2002:a17:903:1b63:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23dede81dc8mr190362765ad.30.1752474682369;
        Sun, 13 Jul 2025 23:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbnMsrBl15IDIkz0WDEDjeP9KCLJo7QcXtqpG3cv+ngO9fyVjCXyOrc3bIj9AbDNVdOY9SoA==
X-Received: by 2002:a17:903:1b63:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23dede81dc8mr190362215ad.30.1752474681967;
        Sun, 13 Jul 2025 23:31:21 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:21 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 01/10] coresight: core: Refactoring ctcu_get_active_port and make it generic
Date: Mon, 14 Jul 2025 14:31:00 +0800
Message-Id: <20250714063109.591-2-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfX+2N8qWlhrXoe
 tWxx9qAYSyC3Is0LF9bEmeXqQoB8kMk23ggHJuex8DCsGuUExhEA/ws7aoGCtWmJU90eWI6O5n4
 IVy02MmuXSH6YPEMTA/h6s5Myx2kD9A34n+KcS9nMF9Rdf1WcFmXdwqHc6kd+Dh7RIAip+tfD1X
 NQuCyZhhV+1K5LJDLFSyS8DzaUXV8Vl2AHhF1aI9ELu//3mbuYcIXOFgrL2/qkzzNbVvZEmfbb7
 oRXxp6tW68tGCsViSgy1hfYdNBbcT2tPeRwMqhMPvX+snoqWd86xcK9JWN3cDUFLjCQlB+4KHux
 E8aWpmgwnfOHzZGlCNLzbVJurHnRgZ38WJA69cnjDdktLCY93zTwvbUqkFYqEkx79KOM/Ve/93N
 WaDJW3mQ2jsacVgx6qengfQ/c9Rl6x0RSUfz2kkEeREZqiG68PcgwbXu6e1Wx6EME7tFUlIO
X-Proofpoint-GUID: t2uKd4qgogmFhgj_por-6mtXxy_O8cj_
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=6874a43b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UMME_An3wchvczm7DuYA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: t2uKd4qgogmFhgj_por-6mtXxy_O8cj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140037

Remove ctcu_get_active_port from CTCU module and add it to the core
framework.

The port number is crucial for the CTCU device to identify which ETR
it serves. With the port number we can correctly get required parameters
of the CTCU device in TMC module.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 24 +++++++++++++++++++
 .../hwtracing/coresight/coresight-ctcu-core.c | 19 +--------------
 drivers/hwtracing/coresight/coresight-priv.h  |  2 ++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1accd7cbd54b..5297a5ff7921 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -580,6 +580,30 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
 }
 EXPORT_SYMBOL_GPL(coresight_get_sink);
 
+/**
+ * coresight_get_port_helper: get the in-port number of the helper device
+ * that is connected to the csdev.
+ *
+ * @csdev: csdev of the device that is connected to helper.
+ * @helper: csdev of the helper device.
+ *
+ * Return: port number upson success or -EINVAL for fail.
+ */
+int coresight_get_port_helper(struct coresight_device *csdev,
+			      struct coresight_device *helper)
+{
+	struct coresight_platform_data *pdata = helper->pdata;
+	int i;
+
+	for (i = 0; i < pdata->nr_inconns; ++i) {
+		if (pdata->in_conns[i]->src_dev == csdev)
+			return pdata->in_conns[i]->dest_port;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_port_helper);
+
 u32 coresight_get_sink_id(struct coresight_device *csdev)
 {
 	if (!csdev->ea)
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c6bafc96db96..28ea4a216345 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -118,23 +118,6 @@ static int __ctcu_set_etr_traceid(struct coresight_device *csdev, u8 traceid, in
 	return 0;
 }
 
-/*
- * Searching the sink device from helper's view in case there are multiple helper devices
- * connected to the sink device.
- */
-static int ctcu_get_active_port(struct coresight_device *sink, struct coresight_device *helper)
-{
-	struct coresight_platform_data *pdata = helper->pdata;
-	int i;
-
-	for (i = 0; i < pdata->nr_inconns; ++i) {
-		if (pdata->in_conns[i]->src_dev == sink)
-			return pdata->in_conns[i]->dest_port;
-	}
-
-	return -EINVAL;
-}
-
 static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight_path *path,
 				bool enable)
 {
@@ -147,7 +130,7 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
 		return -EINVAL;
 	}
 
-	port_num = ctcu_get_active_port(sink, csdev);
+	port_num = coresight_get_port_helper(sink, csdev);
 	if (port_num < 0)
 		return -EINVAL;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..07a5f03de81d 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -156,6 +156,8 @@ void coresight_remove_links(struct coresight_device *orig,
 u32 coresight_get_sink_id(struct coresight_device *csdev);
 void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
+int coresight_get_port_helper(struct coresight_device *csdev,
+			      struct coresight_device *helper);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 int etm_readl_cp14(u32 off, unsigned int *val);
-- 
2.34.1


