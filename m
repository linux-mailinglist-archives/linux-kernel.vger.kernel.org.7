Return-Path: <linux-kernel+bounces-887861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5637C3941F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D04FC122
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA462DEA72;
	Thu,  6 Nov 2025 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ON/A/ePw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AW19Ratd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B2E03E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409647; cv=none; b=HVUYIGYKHwKye49rqxNi5q81Az2DXldH6MMqd9xTscaWt1gyGpIRF5JjE9PNi5V4lRvVeG0ghfT4oydBvV6zRxOTP/eHiE6PPMPkDeXcqPuHBKN416mbyTwxOmFIIolF0pz/wMoXvCjVjIVnUhaAPTAlReEaWANSkXQZDXC9nEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409647; c=relaxed/simple;
	bh=5Eowp/bww9m+te35duy+Gu3+ggKypneeWBbKzwgmR3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0ETWTMhTje26XUlDyLiAOh71+7cbI8EIzXmObWsj/YA4FHV/zGguBR4+g6ZwSNlLkUTShs7bhDhADACvXdtBr72FGkJmM9aPPaFGlB/WpgosCs93P7qzz2D6kMzR+rsRcZcZ+zsnoTICvugC8ePq/vJu2IRB+EhWmiWDJDIwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ON/A/ePw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AW19Ratd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5N5SHT2148094
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 06:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6f0QmtnZfh1
	cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=; b=ON/A/ePwcX2KNW8OyWlf/ctISBF
	8YbVlajt0/DMtybn006v+IF7NLVZP3ErKkw+H7mq4l7LEMWvdik5fxvfup9FtI10
	XOX+KotT/C6PA38QFsK80YMSZgW12Ju8TSswvS85G+K/QnKz9OV7OocPfoYXXXio
	AJeXVP6SysN6D2yKJo8HKIVRxBWml6K5bDat/QCyRmgiU+yX5uLlxnDQ+9JfAPsw
	zOMvs3qXIyJo3YhU5yDuu209dsevq15S0sNpLjLE2tDzI35hMnJhe0c2OXdJQ/uc
	Q+aozpDUpMQzb6LruJAZcT6/nF5/HKlF4SvyV81U9smK8R5Xbd32tfVUwZQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8fxvs0pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:14:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956cdcdc17so7154725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409644; x=1763014444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f0QmtnZfh1cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=;
        b=AW19RatdpEPIl2ezyoxWragYwSpoMicIjrzocXMInaZN3By0bhs7OTVCLNiWiYY3KW
         QEQk6bdHjIOiLaS4yQy5y91OHVQPwfkO/K/9K1mZfwTB0YndTi62qkas3rLSOLnVPIWi
         SlPh400VKr5pNg5OG7oOTMz2+E//cwX6cnYhD4yvWfUdCbUw5Kt9k6uH1QaAaDliDRs1
         1NxE1cun3B1VzT09ocfY8GW0Egr3sT/CRhZPXvvsOBS0/2e/lBwRwt2iyz1Z4Ff5XoiC
         65NqnNK0DnE0lp1RePrWTwadS4kUfF+U6mWSelfc/byLsQaowgKpbiKWxhJmYODsXs7b
         h1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409644; x=1763014444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f0QmtnZfh1cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=;
        b=hSzmnBfF0o3qdh4swJNsH6eR69+tfUjmR9zIaoGZ6C7vYHfSSRQ7RO/Vj1u7PY2NX1
         +edEf8F2gOHYH4fQC7ar5NvnSnw6z7PFhTauzg40tF8Cl9/j+PLXPrgXH3HW68pcBQVR
         Fzj0LuFeRPPPXcjjvmpUFKP1qf1RG0mXDTlnp+Hq4ZUFXWALm1KdlDuACEjY+Bg2ZMcD
         QHygCqnd+ly+9WwdkwsqBqUYfNDX22K4GaF/ObRqnDozyC7BHwgYOUMDX438t7Zy1PQF
         xJA+3RRt0H2WhVrTUuzn+bzx+hi4dOBTBy/hIs8KuBDP8ylmMxp7gkD+Ne+lsGY90Uv/
         oW2w==
X-Forwarded-Encrypted: i=1; AJvYcCVWGtoTX+dynHUh/no2nfnu3c8lme8PwS+tf7ZL1ZP7u+2ARn8Q1Es2RX2DqYAI65IHCaeuaanGj1A50oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsnnQn4L8CyQ3H462nElyqyJstwPZ6FpRaYcSsdFVhezFiMNZ
	AROrnQfc+hC/I+adbLBLpiMgMP5QoGZ2qIaaedryoixfnjD19iD2biCtDKdJAZxbqt4ya7nsPWy
	TmJkWkqwVyLNYyl2j9uXwRLWMdoSl4W38UgW1v+me6m33UV2t0seeyHrY86fMNqZ4mYo=
X-Gm-Gg: ASbGncvIqZJ5PZJI0BuOKE8nxc5UGseW9BuguESLfHODXW3BWAoFGoAwyB7OkhuDgal
	aQtfnVTKhHuQEMU0hI9T4zL7LPkCC40w/Rn11ZzdmPRKJox4u3V4Jm8UHT85oNAlq1vBGa2Abpz
	//RHPnGNM5V67oBwdvrIqIlxVIqMOu2TyCu1I4ITC++pJU4tzKu9m+KK5pcISBmZu5unCWzPleJ
	UiJLDxTyhUOg798cqq5nhiDh58xDSaXHxRA/WFGre9oefA3h+wz4r/3VBj7GDSjKJPIYE6ftldF
	LjF2j+IXigTvjLAArnE+HaOTVTd7WBx6GqfD21n00lDjlxx4iS0N/OYWHdfhWf0bUtmwZ9tU652
	2hjG+GGxVFAtB+TOq
X-Received: by 2002:a17:902:ea0e:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-2962ad11330mr76435655ad.7.1762409644081;
        Wed, 05 Nov 2025 22:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGau024seW1k+6gAt1RgfaQE2/cFqOhIHoNflQP4yhKsBt34XSgC8/NMQQqGMjUdn+s4cLbug==
X-Received: by 2002:a17:902:ea0e:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-2962ad11330mr76435285ad.7.1762409643591;
        Wed, 05 Nov 2025 22:14:03 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:14:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is available
Date: Thu,  6 Nov 2025 11:43:26 +0530
Message-ID: <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfX0S9c4sRvMMZD
 +CD3eQO9HLmAKrsWloUHns6bozbdh11bsNwwqBo6Yp9KFtYjaeDMrjmPSByLOer1Mrib3lUM45l
 LqCyv55rfQ38zMhd62JSCkXSP/MT/OKYrI2MCYrldHtXq4eesRDXK8W1Ib+Fy9FtfKo/f3/M81i
 QNZI7AwF5ch265GvApLY8gWWJsc46mPps6gnFjMreQe3PGpuycwV31prD1S1QAennLlnbMZ9qYp
 p/o3vyL9Vw4DIBo6wnugtO3En+aew5G+f/+4ImyzlNdr04lHZ48oIdyqmyE/U3K+msrouSipA3N
 HXQ6L8Y1G1vfbmDspLW2DgUBt88L1lxRDK6FmrriXYHFFlF5v3IcZTRLoRoi02FlMwc/2NWCR1H
 etZkIe7CJM0qXqIJs0X8CyCSJ7tZxw==
X-Proofpoint-ORIG-GUID: 5tG48-pZGCSQt1ezTnhrmIOyLF-X2T9_
X-Authority-Analysis: v=2.4 cv=OZSVzxTY c=1 sm=1 tr=0 ts=690c3cad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JlmoTVlqZe2UTokRIjkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5tG48-pZGCSQt1ezTnhrmIOyLF-X2T9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

If there is no device available under the Root Ports, there is no point in
sending PME_Turn_Off and waiting for L2/L3 transition, it will result in a
timeout.

Hence, skip those steps if no device is available during suspend. The
resume flow remains unchanged.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..b6b8139e91e3 100644
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
-- 
2.48.1


