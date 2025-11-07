Return-Path: <linux-kernel+bounces-889768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1FC3E789
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70113AC9B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F72749C9;
	Fri,  7 Nov 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="By8qjXKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oy7aNMof"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499F21256C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490639; cv=none; b=YzPmnmj6KLfuCgDk31CILTNV/7lC0iBfZj0mpwP/vUUu3n612x325fQpIyN8TUXWrZE31cHfsNuaZblN7g0eeZ9+9WtfbHHTaA6K5EQuePvOYT9pITa5iMNzANrXFx50CSzSWzWvBtditIKjTokbyTVoX83nu+wRHkqKdO3a0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490639; c=relaxed/simple;
	bh=OCNG+lbnLrsMtQQi6jU70Anj+n9Dyq3TJC8OWSxY/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZM1kgEkbVOMzfjG30T4r64fX41VYngp7Y3AybR5yWBD07UAYcQ9ohVV8oEbOtVPjEDiVmGxgZRaEno8Nutexhi2qI7cTqb3rdAYM0mYkiV3b1FF006CdY6T/jy7oeF4kXvjk8BoxUo5YRaTH/oPVl1+fr+Dsn/1177z3ucBsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=By8qjXKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oy7aNMof; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A749sJ8583970
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=n/8ug7G71RF
	kHVlfRkLQOJyF+IERANZoPr4euRh/cgY=; b=By8qjXKey7Za9FflSh6zoa/qaPK
	CRVzvqNYI7hRb8+QXh26hFf7rCI1cWNwS5WYrfC+5Y6UY8lkENmyXIS6dmNpCRKl
	Iq5eeyHRh8WrE37EkqHkie6Rn6mnHahnAA91vDz75FhzAxQCsbXmNNqh9cS4vHT3
	rTo9D0zKJ9n3IezHf6gHYY2bFYN5/LAKE9gk0ae+FBcysgtqFNDvC9Ccjh7B+8Ti
	iiw1fY0UgQUY21xF7ob2rlwzMXJrw3uzwkM7ib/NDgvBfRXxAVuCRfRWGTKdN5dc
	hAdMzZp9b6Qdv4ECOO3GOEpRTrnciVJFALSVabx2Ebl117FhF6jG7cE1q9A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8ykths83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:43:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so418751a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762490635; x=1763095435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/8ug7G71RFkHVlfRkLQOJyF+IERANZoPr4euRh/cgY=;
        b=Oy7aNMofDRtIUnlgMtUUh0RRBVl00B0P8gnTwpCwzPrF+xvI38yd7SmZwida6GzxdE
         5wfOb/g4lj+PSRcX3f0KkrPBKPheCprJzWpgSNIxXmF1i/pIGgFxhnGnUViR5gXYS5CS
         42dcLWMUTt+u/Vq/idjgPNLYuekm4pyoy92HOjF61n6/+Rtq9N9CzEY93zazzUNqGtGD
         qCflXPpRpl0gaUIjd5xkNWjxEpmRZIBePIh/ZIfte1Nq2/c6kY9kcHpLJuAWr7dWxDZs
         JyoM1PanRfTICduyxxOvuiZlg59GnDLBXc3gtORgorukQn9JjUzMVTn/fYYNGWWmTNUZ
         wdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490635; x=1763095435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/8ug7G71RFkHVlfRkLQOJyF+IERANZoPr4euRh/cgY=;
        b=nieMQMBMS5+TBHFuaqypkd2+pyHiSvfpKAjetnjYD3cf6Nz9CxXsi7QalZmquN73NJ
         G75zZe+3PT8EyRZ7bmTfOaOJXrdc86Ge6BtuQDgXxMHBd2XOdtf5N+ifvLZMBBRh4oSy
         0bi9+4BdVy0gQ+2u14GDTg6bvTMSOTNmQPsk1eNGRCwyYt68RkwhB3Jl/WtKvh73KOC+
         TI6ccHe6+cPciuVb+3jUK1WXUeMHYFbKTz4vXPNayVWRanIiOl4tIMbF1ci3SgnxwSjV
         fI4m0lQhBXDg0GrXoJWVFbVBTYQ98CmXRGkwqSgSx3wLpNtzAZPGeJN5+/isuIesxM6d
         uQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9GfJELadfv1mnD8Lu3rcm5zNK1EieBgeP7j6VItKRfwKsKvUX7kkSBU4ncEKXNADQ2u56sd0gKD9mzCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aZo7FvjpFVEmzANwIMwiWPsVoj17GAMBr1CYca4GGvj7j7CF
	D6sz9uy38uK5klIoH0C6TEH80VWYktNPilnQjVNcgIE9jyrkOmicLkyMwVsE4hk08/2uwvjquP/
	/sJM5z1xLg9DWfIERFkoUt4cQHP/2hXJ8K0NyGha4NjbwUbnXTG4yJzIXX2qpmca/AR0=
X-Gm-Gg: ASbGncu0Z96pFqvckEPJf4USOOmzXaQ832y9J0LroMkHUhjNSTKusKMyAuNPR95K74A
	byI4inEB9yoeWKxVl0N9BCFxETUtLJUArF31kicjRBYDjXlSo8N8CUaX+w2jJMF4NukSKKg1aD9
	IpABvToJ4yOtirKEybERnI++YKdXkRBa3xHz5PLLco6XFcz0ZdgqvD8Eky4wlprKd3Z5dVt7c51
	rq0OsNorElwobHfSXoJ4JkOJ91bo9PLR3sht5RTgRH1dvgQ7i7MYbUqSI4jJez4T7d7x3RJdgxI
	UVBljcB6eWQyCcDAMhHynd2McqmEAbkrqzI4shjMZhAR2XumtWq+TrFc6i8WhupuxpMv3Nehlk1
	ohfHsT+NZ1cGbgUOUUg==
X-Received: by 2002:a05:6a20:3d1f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-3522896833bmr2548632637.27.1762490635355;
        Thu, 06 Nov 2025 20:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe0zp7BSw04nVAqkDvBmkfmyp4sTb3NsAfpV9LkGL7gKo5CyfozrrQaMq0UZVRtRmeP8Yagw==
X-Received: by 2002:a05:6a20:3d1f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-3522896833bmr2548600637.27.1762490634817;
        Thu, 06 Nov 2025 20:43:54 -0800 (PST)
Received: from work.. ([120.56.196.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm1142624a91.11.2025.11.06.20.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:43:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 3/3] PCI: dwc: Check for the device presence during suspend and resume
Date: Fri,  7 Nov 2025 10:13:19 +0530
Message-ID: <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690d790c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=NqeMpCPRvvPHbudmJ2rC7w==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zg3KtlSndC8MviDn-J8A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: JlNFUum3iR-2VAcSXLuS3CzFzTmCOvEd
X-Proofpoint-GUID: JlNFUum3iR-2VAcSXLuS3CzFzTmCOvEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAzNCBTYWx0ZWRfX7sY4Cjtb7h6T
 /gXTJcmyq0g2R6gaa0fBp9bexGW3UnlsrDYRE5PmkYY+b6+MQ2AFGeg/BB7ABnL9xFPRG+LBH3l
 1Z56RqGli+OGBP3o7Nd2l7n8dKpnRa+aCFiSx/rthL59FZKy4lnPmqJqCNPqHWpFJdgjamfWAEL
 f9HwiN9COWFjLPGtOX+4CP6WaIEJMH+KJjkDi9DYTn40NVQFZ9oQc4FJFLBCoWul6GVYmbVH+cz
 ny/KNd0lcOb9LXexUDZqXQs5Tvz7KV8KssaMN1w1tkDj+2hK2BWtB+gJvhV5JbsTz9RlHBl2OaZ
 Zvwb2VH9w6s7jJ90KJ3uA+fy8+i0iOVQKz0ei+uMv1hOtUwCiWmvDVQE0l2i3QVJlQbm0LQ47fi
 dYBOUaobU4ivF6DLoUZ1ycM9Fry8Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070034

If there is no device available under the Root Ports, there is no point in
sending PME_Turn_Off and waiting for L2/L3 transition during suspend, it
will result in a timeout. Hence, skip those steps if no device is available
during suspend.

During resume, do not wait for the link up if there was no device connected
before suspend. It is very unlikely that a device will get connected while
the host system was suspended.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..5a39e7139ec9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -1129,6 +1130,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
+	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
+		goto stop_link;
+
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
 	 * devices such as NVMe expect low resume latency.
@@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);
 
+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
@@ -1195,6 +1200,14 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	/*
+	 * If there was no device before suspend, skip waiting for link up as
+	 * it is bound to fail. It is very unlikely that a device will get
+	 * connected *during* suspend.
+	 */
+	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
+		return 0;
+
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
 		return ret;
-- 
2.48.1


