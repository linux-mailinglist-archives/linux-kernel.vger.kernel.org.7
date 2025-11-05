Return-Path: <linux-kernel+bounces-886662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFAC363E1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422BD567B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD3313294;
	Wed,  5 Nov 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5G1bz+n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kpohm3lf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6932D0C2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354696; cv=none; b=b/S2vadLPUMrP5JNy2wqrm4SOK+VSG3P3mTbUCGODHwBlHgHKUfXmQybByNqfu2uamG1tZxAVhXAEtb/EPNV+qRFPQDSBQf5c0wT8PFMM6DrM5kztziUeCqOVQYC03YH6ndET3thhuaBq5cvFFG4/DQJhMBix/QRcLQI1fIL48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354696; c=relaxed/simple;
	bh=XMoXUW7zzd5Z7UEbf39vy8nXx/nklNb3eCayzNF5D3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnH+yweJfEClOFwA+cmF8FYLpEbKoXPyNMMhKk00eujchwbMKG2yvM5QOPH0BrSWdzR2rjsxPyV67FtzUM5ET29s/IjcfU2HtB7ScKZIaFnxa39ubBXjPn2s4u/bcRdQc0NJhjdVjBumYShFYfZ4kf3G+7o8PFUr5aFoy+RSgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5G1bz+n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kpohm3lf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5E8CVm876632
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 14:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aukiftqrMwSvLnxP7hNxU4zZyCqOc+G3XCw
	54ES4fTI=; b=b5G1bz+nqwnHKAOlRRw8y864cuFVh+FGCYxpJFP1byDlTQ1rog8
	tHf8yzbIrQ/Q4O6DOlQjwmNe2GVY6Mcxem5/cGTx8yTs2TMjs2Jw9jRg0EWGv//c
	XZoeK7TDI0ohpt+27r1g2h3JGNkS0st7knfzWV9cSr7mqnTXvQmWrnY/GVBnJcmx
	hp+p2uz4QFXJSDInWX1UQgkqABksaASnvmd5B/zhkLYZrBYqNjvvys7fjBPqvCXh
	C6wlQQyViVwvTnddHrL1XSYSIY9NEifLxmfYEjnq8odInuKXXZW73iF+IXmU2Khu
	FBxbwRFtsmn4YUE6zv4AjiYWnmU/FRyIuVA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a883184ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:58:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290e4fade70so88018415ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762354694; x=1762959494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aukiftqrMwSvLnxP7hNxU4zZyCqOc+G3XCw54ES4fTI=;
        b=Kpohm3lfbelPbynZk6Wuf6DUrV1+TUHUhnI0cFIF+ARrm7N9LjcTlQcNe7VgZx0Mxd
         FCOkc58fu1O5/hYzd2WwbkQpRJxgP2Vjwg6tcPtdEpsxfFd4yXMlCzIjcPAk6YGXZYu7
         R2Vz1fV3hr4Ww9mLQvkXdIOgX5NQrOEviNN0DMN+423nxxg840PWa5xHZS161j9hqIie
         D0vkbTXi6IA7wbiERBZa1xil8Z07eIzZoVTERcmXV4v5th+W13fi1V5JQpkkedPMmuAP
         N4/dVIBkNpcciaZheU82dVABTYlgECPXNI0QbdmSmNlSdFTYmV/mMW0TBPgFp/TdY5Ek
         h36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354694; x=1762959494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aukiftqrMwSvLnxP7hNxU4zZyCqOc+G3XCw54ES4fTI=;
        b=hJp6RIc0dw6jOvS5D2iSKWZjo3IVsihhXHqjGaQ55XkMKYJDlrS1NaUXNa2mzn1zYw
         zkL/wsgOY/z8TuLFKskwAoX/WaW02N1/YZbGluSkzJ4BqnKlSXLlVfrWMfuuFFk52Rwz
         eTidle0StMCN3r4W3nk7PkbJlt7nmX/O03skvj8c5JQffJGuUoFTX2nDxVwtCKTywMcz
         /Pk9acUmPatKHrtZwHgTjhw8Qs1qfWA6nkwPqX0VvNtpiCiUiTjRu0rjXOVLFQ95LH9G
         0nPU3nqgV87n8rzyqc3dVttSYBR+x6Eio9SE8WnT0cDQyFeoBnQm7xjnht1YhobMrMZf
         etnw==
X-Forwarded-Encrypted: i=1; AJvYcCWEdB+iFT7W+FK+94m54sobg61V5cNCPo+L34BmiNQ8UD20CEuR2Oa3X+EYCmRACX8SDZM5kewprEZcp10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujNTZ7yCxrGLVQ7DcEm+mfGDxjMXgDwovRYSohHr7MTJ7lADF
	+z/DhmgpE8GWQxscwSD5shaPrSq7c7aS0jEjf5vNtCK7FQZf3+x+Vc26epgYTzKZdXThYS/NnIn
	Z3cJC8lMlaSTcjhbZbCjIyRl1J7tLXnvsiSjEA5D3uilKhxwLozAdVl3pKmBcbjvfvZKNoqJPit
	A0EQ==
X-Gm-Gg: ASbGncvqPOF4zhASdj4BU3CYnJpb+SJWWdxEsLMhUzdeSr4E704zhpvpBf4d4tt5ccu
	+sC5xYXtRTkWsWarw1k2kM8VQaQcZhsPZJ9Q8r6prrJwCTgg7YX0W23qnPKnlCjVeCZP9/WTAAB
	6MVgonxuJa9Ba8kdmOgfoqRtHdS2aflWsZZOqjZ2dqiS5NNAQBasOsk1LaMzLXw6oeivegwEAlU
	l5MsUfE9RiPAni1f+cggolG+7WDfoItf20xzlWEGFQsgeIy1p+0hGQ2dEhzFuWELjFpQKdoHLAY
	4phD5hkwukRc5JjGB1egKqqsfljugBMusYOgmv5mbgDHifiYIkEagV7oksLpgRDG6diksuoutME
	ykBV+Daeu36URnsNkAFViDlLECGu3sQTBiGpkfhDWYv8d69xf+e53
X-Received: by 2002:a17:902:f68b:b0:250:1c22:e78 with SMTP id d9443c01a7336-2962acf9e0bmr55375985ad.1.1762354693503;
        Wed, 05 Nov 2025 06:58:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErtl9BhRd5yJMT1l/GDDCgenYNFc8+diIC0fk7i14lP3JL4ksDWV66JK/xo5QFTCfoRlinaw==
X-Received: by 2002:a17:902:f68b:b0:250:1c22:e78 with SMTP id d9443c01a7336-2962acf9e0bmr55375335ad.1.1762354692840;
        Wed, 05 Nov 2025 06:58:12 -0800 (PST)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60761sm63467705ad.90.2025.11.05.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:58:12 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: fabioaiuto83@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jamie Iles <jamie.iles@oss.qualcomm.com>,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] drivers/usb/dwc3: fix PCI parent check
Date: Wed,  5 Nov 2025 14:58:01 +0000
Message-Id: <20251105145801.485371-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: prWguLHhCTQUaklWXRUcV_GwTosRUIb5
X-Proofpoint-GUID: prWguLHhCTQUaklWXRUcV_GwTosRUIb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDExMyBTYWx0ZWRfX93noz9dxqHQa
 KEJqkeP3VTdgtFM6aS3a79j06hWzcbhtDs9WB7foRmwLqg/Rk94uKI5L7WVdyXUaZKO56Ale8Ti
 LkJu1DmNQQp9Hdndurz7o4sbiZQ0CoXgwP1hC1jOchWx/VLT7wFvI6gY+AXbfp4MwOM8WqD4J/Y
 HRPVbwLXBA0KrKebJu1fPjkr8m4iAMOcmI1jg6d6fCjK6Izi+RjL99d7l3zYRr8wJLIOyNROBAK
 Y4NiTX5+nCb2iLo1Eld/YEiJeMWtRoTsMIUsKGYzSQR9HRM92cNs6cB3MBfVbBfW9UcM5z57eUV
 oImOyfsozUNf+D8O3CBpGUazTXmgJuf2KanYw23YqETx2QnEzQ9aHbsrpxPPd/zoSi6/M6Z2RHW
 seGXvd0N1ON/K2HzzjDy9sDldIaySg==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690b6606 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jM0-4Wpw8WwY0CpfOG8A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050113

From: Jamie Iles <jamie.iles@oss.qualcomm.com>

The sysdev_is_parent check was being used to infer PCI devices that have
the DMA mask set from the PCI capabilities, but sysdev_is_parent is also
used for non-PCI ACPI devices in which case the DMA mask would be the
bus default or as set by the _DMA method.

Without this fix the DMA mask would default to 32-bits and so allocation
would fail if there was no DRAM below 4GB.

Fixes: 47ce45906ca9 ("usb: dwc3: leave default DMA for PCI devices")
Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ae140c356295..c2ce2f5e60a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
@@ -2241,7 +2242,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
+	if (!dev_is_pci(dwc->sysdev) &&
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
-- 
2.34.1


