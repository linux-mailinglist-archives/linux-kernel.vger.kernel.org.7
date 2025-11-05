Return-Path: <linux-kernel+bounces-886131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF7C34CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14E85649AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC332313273;
	Wed,  5 Nov 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwHPk0wt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVO3QXq0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D02312821
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334217; cv=none; b=o9Tsk80eNxmzC/zhmS5Gwr2pmT6DAuYNVMvmytHg0WKi8eCRH1MGw2vl1n/3eSFB+mrHKUNAf5JB2DLwaa1N7yrYR1gAZs8o5AQeZg6OqQ159qoFFLBVjOiLrw3/e+3aPxHfk/cnqwbbE8n3sZKsAcsM9FOyj/MZbha0V5id8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334217; c=relaxed/simple;
	bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Op36enKriA+KL/a79EHBxiePanN9/jNaywFQxCiTA3sQ1z8ZbUd+SbdXbJsLaOUf4PYflV59UrGqhDKnBGyySy9/WGiboHiZ3M5Pq07dZAAzT6Nul45mZb+kRyhEnfRqp/a76pX1Um4zj0bsYhpfS4KWQMEv1myU5iAEVXQ3/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwHPk0wt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVO3QXq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57mstU3091498
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=; b=GwHPk0wtFLVg35Nl
	3QajAS0KVrJXOPgdKKRi1a692MlD331M4JlACtCZUdrh2cuhyLPF4c6M3nECZcqI
	BOmo8ry5/wNlzPTehGxyMFpBjlxEGjwTfQ491YcuUxZsasCQwg2r9TPkxyA50xkf
	lzMXFruxivumaDrOo27Vv/iq/QMo+aTGBTY+hT4g57Qg9fPcKLw99vnQM5DIG9D+
	hkpXUXY/8bwTxTvmyCo8dHt6ycnxNFqio6WKvjhJFNO/XPfoP6x7d2I+ByN73PVS
	q/Co8jAtZS8yLt43x3qiGNC/AOAcPq2aQRMlZzC+d+QjA3J1xcPRQoaaLasd/fcY
	QgWAMg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5e9tf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:16:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso1218652a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334212; x=1762939012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=WVO3QXq0aHxZ9dzBM3IXtxPbC+XszyIOwf+Zs4pjZ5ya2A3qThNAa0H24atHrdqXSx
         ejJAyMTxTF+SL8HV1xKGIrL0ehGXigSUxzKKUWHKp0bx4mBuhScDFizu2HeBWknqJSJ4
         9LKvsv6qynyAaJKtPB+Vy7VUBfslk+mnVMI8wUjfSfK+3VXhUsKmNk+dYSoCyq0UfNNw
         5spPE83NQHsnzFRUtqp1GtNWCuZIvxciY60QQWxUlzdCoKbxNFDeWVLIZYaxL+9dcRZ8
         5QQUpBdR5Uye4f7T1Vc2ROKR+1M/a6xZ3jdv10j4L3BheK2PCPyYMmxuEhGZEbGC2tRu
         gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334212; x=1762939012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=K5KJRLKEA19KTGL5h1mCgHf6Qd265Jb5kAlmTrLixNDq90mXvM92vzLjzNRhsUy9mq
         ZqFTwv4R0gB+epfba8pfI40iDNuyjP4FcNMA8SSpMZIaRjUHCPNEihJ9QO5APST8fWRt
         TgP5YFSOksVacMoagB8MIabyoZ9t30hil/v67zNy3bDp/SpBhbBB3G4cV2IiPtx2v/qA
         230viLuP3cK69pseWG8p8uCjaJ6v/Vbh8G8ipAO9IlviIF7SSUyDVQe3fE9gbc018Wc7
         WTamDhdYgKeWIAKd8I/MB58U9bboA5kVfL1jrcnXY0vE16lvliDtSyN6us1eSa10SxvY
         zM7w==
X-Gm-Message-State: AOJu0YzaZkAr1QbQ0YeHrN4DLTZAUoT/bprwEgKCSh++l/pngXqbsKOI
	UZfXP2CdtQuUqpXxDi4mfosxgmWyNz0nygPU3viCPPQFhtxLum4We7HgbT88vFzh7Wyaj9c2rjJ
	z2Wrm0PEnKl6/wUeYHufHI3ZRxzUZGuN3UHu5GoiWdUFd1T4l/lLK+Hb9rzh6X1jvEzg=
X-Gm-Gg: ASbGncutzYmpYpudJhOz+k3OsKQKrcMbjdm2VhZOw6IoG6Ac4bWeN+U/DpZ/JvT0kFT
	l2Oez1SeB7F1Nui8uvtRcUn6Yerso+gI+yQW1dg/as9nC/g00k/vpxV7/SzSJO3zUT5zDM1df9p
	vt5+cqo9BEFnF5B5DR2SxJSe1prdy+lfmQ0xf38NN1s3yYExXsAgitjvjSUGcv5mvcBDzcZUXDR
	/OJhjQmeuI7yoFJEy1uHtLSvsYHcLpf780DPBnVZ79Myt7ej5FVAci2iHm7LDaQ06IWCJLnzyYe
	RDKo8vHJhZrhFqayBwQnOnFB/H1O5vVyrElowJWOzcKdYHKVZh07zqW9rWOLRPI5K/xjPIztSJ9
	dCjL+accdpYRcUM/XhrdOPvgKveRy
X-Received: by 2002:a17:90b:180b:b0:340:bfcd:6af9 with SMTP id 98e67ed59e1d1-341a2d96eedmr3386115a91.3.1762334212075;
        Wed, 05 Nov 2025 01:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdkfEQO5EwZQcqaHfM2ZxF2RJTEyKeZ92D/5evi1SyRPQKg2y7+uM8gEnkID6U/DFqcBS/pQ==
X-Received: by 2002:a17:90b:180b:b0:340:bfcd:6af9 with SMTP id 98e67ed59e1d1-341a2d96eedmr3386085a91.3.1762334211516;
        Wed, 05 Nov 2025 01:16:51 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 14:45:51 +0530
Subject: [PATCH 3/4] PCI/pwrctrl: Create pwrctrl device if the graph port
 is found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-pci-m2-v1-3-84b5f1f1e5e8@oss.qualcomm.com>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXokpXAS6e+Gz8ICBzFYRedOVBNudMT1HWe+
 Gq3lKrjwE6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9Wb7B/sEZ6BBfOxN6O2UdeREfQI7lxYM4PbKK0OOw/21XuR2RWAFfmH4XUSKvCnIk60/8/6AKdj
 CokyAFjPPeYNKaFciz0y5VuBnMnj+t24gJ9sqFw7q5URzggEKXa/aSaAfYGc2KOeFieiVI3F2Iq
 kXeh9sRFEhhH+Bx6E6gIU22ZKfRYfK3HO9rqHuHSAvTyMlVbpkZZrGsSgu4z7vRzVToPjGBe/1r
 12sArn+8Dc2vQe/G7jqo92ZCQ9WuqhaKWPOYU0gBYbCfZrKsLnj9EKnHsP/SKXiNXoRc9kk0ZKF
 ytYbEq5i1Jl9/F4+tNsdSoh+4DF0+JvLf4t/D6Vuv0R//6JR
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: MKtR9oIQlFRvq8xf4r8LVYFr6HmWLhUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OSBTYWx0ZWRfX1xADct9Vl1Ia
 fe/0RW5K47vB/0TzxgiJwryxK78H+GpaMSxOLvlGQix1DO4yQVvXYphaLvIoiWtwLyro/5PyjOS
 rlRAazqU87CQoo8/oKllm7uRiotj72I27IPYV16IgTXyOYBWG70T0Amg/GFsZ9wpAM5QefifBP0
 LK4CckNm619fRKIUdtFbrXH85uywCS2Elzt9K9AerW8VyFCNwxXrwc8ZNjJDB9uEMi0FbOTNxtz
 VnaA1PdHoHhNypKU5jwsp2pVJQLd2kQR7hN8bsOh4xPWFOIayXrCUT1fN2y2qnefCQyJZ9CDCkt
 0KcwiHhX+sx3BeHi7+eGGkO9zzrimqvCxA2AbJgli3tQnVfCMQtt3AdaS5xqMNNTCsgZbChXS/m
 eAJrmtDzic5OB+mUDnw9CQzIf8Gbzg==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690b1605 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0pvPJS888BSDkZzuOKoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: MKtR9oIQlFRvq8xf4r8LVYFr6HmWLhUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050069

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec1263298aeac7f84bcf5513b003496c..9c8669e2fe72d7edbc2898d60ffdda5fc769d6f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1


