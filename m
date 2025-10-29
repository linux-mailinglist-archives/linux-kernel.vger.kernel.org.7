Return-Path: <linux-kernel+bounces-875397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35303C18D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BF3544B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EC3168E1;
	Wed, 29 Oct 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckxiUUMo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMTQS6LB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16643148C1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725155; cv=none; b=baFj4euAGyHQyG7zF1dPrVTB3dj7nWVG4dnkIKm7kxnNc5FAh0hl1Opf047jBuIlgKyOJIiR4/ePSeNyY4BgLjLi5NDCCkx9wcrCL2a1cK5F5IPT3OGqij1/EHnK52q29dYasJJWFltWkvXapR2DkAYwUeBoDCBR37HH48WgtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725155; c=relaxed/simple;
	bh=1sXb3vQHiwjZYekJJiXVfBuTTVhw+mrGhs/ehzoJIV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h08AL/1+H+k/o9F0YebqMYMfT2HCJ9Nd+eY9jeBkadzQqhcZx1j/q1HyOrcZbB68OPybTsWxYJIsWoqP7pLexgwMU2/D5DlIWjOkz8if8Iv1vLiaGKLvvKbNMxZzX0XL3M8fytgoLHu+Vw78K8xrbDzyiCdqh0eXlsk+49d3FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckxiUUMo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMTQS6LB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uspR3757545
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XEgla+U/xa/majtIDImyoCO5Hj6TQNLmn2xUytVMi9g=; b=ckxiUUMoHxDu4hSh
	ePGHT2u8mo4Fk/6DIt81rld1ddMyIAYBMSJbIom9V2U9DK5vNvrANGK7PMBqa7Nj
	6WdQ/Q7R/8HKegIxcpVe+ktIo2lDnfDQNg5c7VqJ5BgeBE1fBz3tDXQRrNYA6Nko
	ZJTS2w4J0H7frvSIqz2e39xaLljyfzkEp8L4A5AYTjx6KCatbemY/y0GuYIsG/Lt
	CubHi+/SdglBLAHisL2YwCHEumLg3ciHjM9lpZ0zqPmIEXIQ47CO7tHo9hNVuRUs
	BV4K2JMpcqEAtM2hEXU614FMcdpAl/vXuNLVqDM/oWPIaxHExcIIw4ohigXRmVi/
	mF7V0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y1qdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2924b3b9d47so62115425ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725151; x=1762329951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEgla+U/xa/majtIDImyoCO5Hj6TQNLmn2xUytVMi9g=;
        b=JMTQS6LBG6BUazVNd+816dxgJhXRCVVMRFsqV3UAxZhRRWubkE9IV67y0vQ3Qw5Ixq
         0HRfGUjpQJ0Wc16GL40nP6I53urfZX6EmHQJjUInBU7dWMAapwYPO3FIETeJVa1YGxxf
         Xv68/QbUt/2Qoklgezoi/DCh0XJ4o3UWz8fcWWSDLt3IcY6RwZsCj7dXgC39wo7J8vjv
         vjxm5tt475lT2q89ecoRVu8QM/Cwaka92WxSNVFDZ/18DGiJxKCdtJeiAHFgM6qzMXom
         1UME0iBgSU9+xxIaIaN/AkgG0mBXm3nEVSU0PPlOaqoGE/USc0Nqqa610H0+PDcnTbRM
         GlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725151; x=1762329951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEgla+U/xa/majtIDImyoCO5Hj6TQNLmn2xUytVMi9g=;
        b=S/cHHTGsbIpiJnjwBFUR6paGZEfvzmoYk3a32mz8VSDxsG430UvzQj0xi+WvCzx35j
         3ULNQabJ0DFKxldiLhb5YinHekiU7ox4Wx8H7g3FBggm+Oj/RsvxZjfe6bYc65ZPdhcU
         GXSx56+0EInNFijFRZVOMQfzYhFQw9bry+ndFIL0Gpivc+NN7XX0m39VWQfnfbDrHx/n
         FlreCWC4JH10wDaTgTXQ856MtB8XPhoQz+oKrpsPLe3hDwr4qhAL++wvbInjCq/e67K0
         xK5leQgkJkJDOqG6691BsYw/Or8RRknRxNXgvLsDdbnkgaaoi1OxDm8U353q6zP7Rjay
         ysqw==
X-Forwarded-Encrypted: i=1; AJvYcCUxOmO1KNaPFdKQVAPu6t+uDu80FQvRuvFIzCYKJT4/XrvacVQI3ZQROFxff1HHa9RGPzTFpiKo4KHaSVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgSWT+jeDjWEt7e/82adjW62sVDnJgfPqu753MHK73YcU2RtU
	zU7yMVGcTa6AHWUSm7vRFvP/PQ6oClNnvBvTeK/+ohjTRYkBs7mYvFkIBes+S7auaStmmiQhlhs
	SVEsaTAkkmOpTL98WzU5E6VbAAJ1ZGDKusvvoKOexeSTJgcY9jr8Fh7B+GdkTK0M6CCw=
X-Gm-Gg: ASbGncvgsdsxDB8qJxcjWEZFH0KsMgmmVnXCiVrZvJQx3hw4Cy+0btUeP5cx7nRC6xz
	3WjDhkQffGSdimAkDa1Q6DbP+K3pEilBe8+mypjW3ySMCrgtS2hTpE4mRlARTTmlVPuj3TOQnqz
	1MDaQQUejuqIpuEuyTVgBvlPZmh+/618smcXynVFsfo8VBqXIOMjW7+oQIJyfB3IfKJMT5ldZ+Y
	yVekaC3+leDWcrXYgQBiRZ7GYbtfjqRLnTf7mFmznJrQ6QZn3Nn5+DaUBDCkB8T59cesRadKui+
	aW/L1B8augM60w+VzrTlqCtaHN4Zc1WrtE7up+iN/c3fcnkbzxz+r0sunXL2ddDlt8GGfdcEUPr
	W3MFOPiIhVz1PWO6RHgAi1T66YTKzrz/nbq1TzLKwCQ/eM1Kp5g==
X-Received: by 2002:a17:903:234c:b0:28e:7841:d437 with SMTP id d9443c01a7336-294deea30e2mr21878975ad.38.1761725151026;
        Wed, 29 Oct 2025 01:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpPEi4WlbwcyplBboH3lz1aUsMT6TGZWISfoeX9piVsY9uVeXbcb7vee1wbh8/wgkwQpHavA==
X-Received: by 2002:a17:903:234c:b0:28e:7841:d437 with SMTP id d9443c01a7336-294deea30e2mr21878595ad.38.1761725150343;
        Wed, 29 Oct 2025 01:05:50 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:49 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:05:42 -0700
Subject: [PATCH v2 4/7] remoteproc: qcom: pas: Add late attach support for
 subsystems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-remoteproc-v2-4-6c81993b52ea@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=11300;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=jxg1ubpFLul+9Myh+/9LSiuIQlv2PwyeKqAQEjPjUR8=;
 b=mhWyExVi8eo/QDElZ1PIiMwwZ9xz7hDcVyRK7cVziN6I7VRSIwhyM2lZ8awVkXIRm3ms6UfsW
 8YdvVkYBTdxAPyKnBSIqWcsfp0mtKx5aOv/6aj5FDhYqmn3wkBr3VOs
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901cae0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pkFH-dftJZDyodMaESMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: dxjxGTj7tw8vexX__R4gE6O-rLHRoHd2
X-Proofpoint-ORIG-GUID: dxjxGTj7tw8vexX__R4gE6O-rLHRoHd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OCBTYWx0ZWRfX/DP3dMgVQFph
 7OvVoSiwKKXSh8WydzkPkXNgixSr9QZciBne6bR8ajiZpD9F+LEq3eR0bzwfmHtIu81oxpKe8TJ
 NB+Bvq9YaP5Z8bb4gONlhtJ4jzM6bA8OTR+c8wcdJr0p0YMa4D/lPrshzpyrbhWOYEmB6vi5cLs
 /sPjIxK0zQ63SDW2XbvUfBzeHe6FWhVB5bBZI4ADSXyfsYDU/8x7Kw7DzNL57QjoskrMmwKvN35
 uftbZJPmO2EalXOr1voHcpbDfAReF8YbmDXK97T75suLqyJd9Hdx4xJPDTSVsQAZ4678P68IzAk
 nS9KbP/WIwwXowuxaXuHnIkNxdhv/hnQAM3O4EMv4RHm/AJMsuuqLVKPkNkaoczQ+ktEvRx10vB
 Gv7W1nXHx2wLlg4WvhO85ykdztW7VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290058

From: Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>

Subsystems can be brought out of reset by entities such as
bootloaders. Before attaching such subsystems, it is important to
check the state of the subsystem. This patch adds support to attach
to a subsystem by ensuring that the subsystem is in a sane state by
reading SMP2P bits and pinging the subsystem.

Signed-off-by: Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5.c      | 89 ++++++++++++++++++++++++++++++++++++-
 drivers/remoteproc/qcom_q6v5.h      | 14 +++++-
 drivers/remoteproc/qcom_q6v5_adsp.c |  2 +-
 drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
 drivers/remoteproc/qcom_q6v5_pas.c  | 63 +++++++++++++++++++++++++-
 5 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 58d5b85e58cd..4ce9e43fc5c7 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -94,6 +94,9 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	size_t len;
 	char *msg;
 
+	if (q6v5->early_boot)
+		complete(&q6v5->subsys_booted);
+
 	/* Sometimes the stop triggers a watchdog rather than a stop-ack */
 	if (!q6v5->running) {
 		complete(&q6v5->stop_done);
@@ -118,6 +121,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	size_t len;
 	char *msg;
 
+	if (q6v5->early_boot)
+		complete(&q6v5->subsys_booted);
+
 	if (!q6v5->running)
 		return IRQ_HANDLED;
 
@@ -139,6 +145,9 @@ static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 
 	complete(&q6v5->start_done);
 
+	if (q6v5->early_boot)
+		complete(&q6v5->subsys_booted);
+
 	return IRQ_HANDLED;
 }
 
@@ -172,6 +181,9 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
 	if (q6v5->handover)
 		q6v5->handover(q6v5);
 
+	if (q6v5->early_boot)
+		complete(&q6v5->subsys_booted);
+
 	icc_set_bw(q6v5->path, 0, 0);
 
 	q6v5->handover_issued = true;
@@ -234,6 +246,77 @@ unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5)
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
 
+static irqreturn_t q6v5_pong_interrupt(int irq, void *data)
+{
+	struct qcom_q6v5 *q6v5 = data;
+
+	complete(&q6v5->ping_done);
+
+	return IRQ_HANDLED;
+}
+
+int qcom_q6v5_ping_subsystem(struct qcom_q6v5 *q6v5)
+{
+	int ret;
+	int ping_failed = 0;
+
+	reinit_completion(&q6v5->ping_done);
+
+	/* Set master kernel Ping bit */
+	ret = qcom_smem_state_update_bits(q6v5->ping_state,
+					  BIT(q6v5->ping_bit), BIT(q6v5->ping_bit));
+	if (ret) {
+		dev_err(q6v5->dev, "Failed to update ping bits\n");
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&q6v5->ping_done, msecs_to_jiffies(PING_TIMEOUT));
+	if (!ret) {
+		ping_failed = -ETIMEDOUT;
+		dev_err(q6v5->dev, "Failed to get back pong\n");
+	}
+
+	/* Clear ping bit master kernel */
+	ret = qcom_smem_state_update_bits(q6v5->ping_state, BIT(q6v5->ping_bit), 0);
+	if (ret) {
+		pr_err("Failed to clear master kernel bits\n");
+		return ret;
+	}
+
+	if (ping_failed)
+		return ping_failed;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem);
+
+int qcom_q6v5_ping_subsystem_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev)
+{
+	int ret = -ENODEV;
+
+	q6v5->ping_state = devm_qcom_smem_state_get(&pdev->dev, "ping", &q6v5->ping_bit);
+	if (IS_ERR(q6v5->ping_state)) {
+		dev_err(&pdev->dev, "failed to acquire smem state %ld\n",
+			PTR_ERR(q6v5->ping_state));
+		return ret;
+	}
+
+	q6v5->pong_irq = platform_get_irq_byname(pdev, "pong");
+	if (q6v5->pong_irq < 0)
+		return q6v5->pong_irq;
+
+	ret = devm_request_threaded_irq(&pdev->dev, q6v5->pong_irq, NULL,
+					q6v5_pong_interrupt, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"q6v5 pong", q6v5);
+	if (ret)
+		dev_err(&pdev->dev, "failed to acquire pong IRQ\n");
+
+	init_completion(&q6v5->ping_done);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem_init);
+
 /**
  * qcom_q6v5_init() - initializer of the q6v5 common struct
  * @q6v5:	handle to be initialized
@@ -247,7 +330,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
  */
 int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 		   struct rproc *rproc, int crash_reason, const char *load_state,
-		   void (*handover)(struct qcom_q6v5 *q6v5))
+		   bool early_boot, void (*handover)(struct qcom_q6v5 *q6v5))
 {
 	int ret;
 
@@ -255,10 +338,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	q6v5->dev = &pdev->dev;
 	q6v5->crash_reason = crash_reason;
 	q6v5->handover = handover;
+	q6v5->early_boot = early_boot;
 
 	init_completion(&q6v5->start_done);
 	init_completion(&q6v5->stop_done);
 
+	if (early_boot)
+		init_completion(&q6v5->subsys_booted);
+
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
 	if (q6v5->wdog_irq < 0)
 		return q6v5->wdog_irq;
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 5a859c41896e..8a227bf70d7e 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -12,27 +12,35 @@ struct rproc;
 struct qcom_smem_state;
 struct qcom_sysmon;
 
+#define PING_TIMEOUT 500 /* in milliseconds */
+#define PING_TEST_WAIT 500 /* in milliseconds */
+
 struct qcom_q6v5 {
 	struct device *dev;
 	struct rproc *rproc;
 
 	struct qcom_smem_state *state;
+	struct qcom_smem_state *ping_state;
 	struct qmp *qmp;
 
 	struct icc_path *path;
 
 	unsigned stop_bit;
+	unsigned int ping_bit;
 
 	int wdog_irq;
 	int fatal_irq;
 	int ready_irq;
 	int handover_irq;
 	int stop_irq;
+	int pong_irq;
 
 	bool handover_issued;
 
 	struct completion start_done;
 	struct completion stop_done;
+	struct completion subsys_booted;
+	struct completion ping_done;
 
 	int crash_reason;
 
@@ -40,11 +48,13 @@ struct qcom_q6v5 {
 
 	const char *load_state;
 	void (*handover)(struct qcom_q6v5 *q6v5);
+
+	bool early_boot;
 };
 
 int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 		   struct rproc *rproc, int crash_reason, const char *load_state,
-		   void (*handover)(struct qcom_q6v5 *q6v5));
+		   bool early_boot, void (*handover)(struct qcom_q6v5 *q6v5));
 void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
 
 int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
@@ -52,5 +62,7 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon);
 int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
 unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
+int qcom_q6v5_ping_subsystem(struct qcom_q6v5 *q6v5);
+int qcom_q6v5_ping_subsystem_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev);
 
 #endif
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index e98b7e03162c..1576b435b921 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -717,7 +717,7 @@ static int adsp_probe(struct platform_device *pdev)
 		goto disable_pm;
 
 	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
-			     desc->load_state, qcom_adsp_pil_handover);
+			     desc->load_state, false, qcom_adsp_pil_handover);
 	if (ret)
 		goto disable_pm;
 
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 3087d895b87f..ee9bf048820a 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2165,7 +2165,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->has_mba_logs = desc->has_mba_logs;
 
 	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
-			     qcom_msa_handover);
+			     false, qcom_msa_handover);
 	if (ret)
 		goto detach_proxy_pds;
 
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 158bcd6cc85c..b667c11aadb5 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -35,6 +35,8 @@
 
 #define MAX_ASSIGN_COUNT 3
 
+#define EARLY_BOOT_RETRY_INTERVAL_MS 5000
+
 struct qcom_pas_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -59,6 +61,7 @@ struct qcom_pas_data {
 	int region_assign_count;
 	bool region_assign_shared;
 	int region_assign_vmid;
+	bool early_boot;
 };
 
 struct qcom_pas {
@@ -409,6 +412,8 @@ static int qcom_pas_stop(struct rproc *rproc)
 	if (pas->smem_host_id)
 		ret = qcom_smem_bust_hwspin_lock_by_host(pas->smem_host_id);
 
+	pas->q6v5.early_boot = false;
+
 	return ret;
 }
 
@@ -434,6 +439,51 @@ static unsigned long qcom_pas_panic(struct rproc *rproc)
 	return qcom_q6v5_panic(&pas->q6v5);
 }
 
+static int qcom_pas_attach(struct rproc *rproc)
+{
+	int ret;
+	struct qcom_pas *adsp = rproc->priv;
+	bool ready_state;
+	bool crash_state;
+
+	if (!adsp->q6v5.early_boot)
+		return -EINVAL;
+
+	ret = irq_get_irqchip_state(adsp->q6v5.fatal_irq,
+				    IRQCHIP_STATE_LINE_LEVEL, &crash_state);
+
+	if (crash_state) {
+		dev_err(adsp->dev, "Sub system has crashed before driver probe\n");
+		adsp->rproc->state = RPROC_CRASHED;
+		return -EINVAL;
+	}
+
+	ret = irq_get_irqchip_state(adsp->q6v5.ready_irq,
+				    IRQCHIP_STATE_LINE_LEVEL, &ready_state);
+
+	if (ready_state) {
+		dev_info(adsp->dev, "Sub system has boot-up before driver probe\n");
+		adsp->rproc->state = RPROC_DETACHED;
+	} else {
+		ret = wait_for_completion_timeout(&adsp->q6v5.subsys_booted,
+						  msecs_to_jiffies(EARLY_BOOT_RETRY_INTERVAL_MS));
+		if (!ret) {
+			dev_err(adsp->dev, "Timeout on waiting for subsystem interrupt\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	ret = qcom_q6v5_ping_subsystem(&adsp->q6v5);
+	if (ret) {
+		dev_err(adsp->dev, "Failed to ping subsystem, assuming device crashed\n");
+		rproc->state = RPROC_CRASHED;
+		return ret;
+	}
+
+	adsp->q6v5.running = true;
+	return ret;
+}
+
 static const struct rproc_ops qcom_pas_ops = {
 	.unprepare = qcom_pas_unprepare,
 	.start = qcom_pas_start,
@@ -442,6 +492,7 @@ static const struct rproc_ops qcom_pas_ops = {
 	.parse_fw = qcom_register_dump_segments,
 	.load = qcom_pas_load,
 	.panic = qcom_pas_panic,
+	.attach = qcom_pas_attach,
 };
 
 static const struct rproc_ops qcom_pas_minidump_ops = {
@@ -765,7 +816,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	pas->proxy_pd_count = ret;
 
 	ret = qcom_q6v5_init(&pas->q6v5, pdev, rproc, desc->crash_reason_smem,
-			     desc->load_state, qcom_pas_handover);
+			     desc->load_state, desc->early_boot, qcom_pas_handover);
 	if (ret)
 		goto detach_proxy_pds;
 
@@ -779,6 +830,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	}
 
 	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
+
+	if (pas->q6v5.early_boot) {
+		ret = qcom_q6v5_ping_subsystem_init(&pas->q6v5, pdev);
+		if (ret)
+			dev_err(&pdev->dev,
+				"Unable to find ping/pong bits, falling back to firmware load\n");
+		else
+			pas->rproc->state = RPROC_DETACHED;
+	}
+
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_ssr_sysmon;

-- 
2.25.1


