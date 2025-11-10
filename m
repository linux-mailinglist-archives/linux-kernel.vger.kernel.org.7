Return-Path: <linux-kernel+bounces-892467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1472C45273
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E321346C45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0842EBDD0;
	Mon, 10 Nov 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgXZU2aD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2IdDCaR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD02EAB61
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757991; cv=none; b=FaiVy2b4s31yh10xfCSya/Mv4QJ4WK8SUknGP3AaBZWJW/XelMzugRfYwrDqa6VXJL38tu3xGwTkHutnN+UMyFALBPwMpieo2xcFn3j9GEBE5x069tX/ajAP+WLkrt6DBlOTdcpI7jyR86BRAvA6uRqy+OdloiHvIp5jskCz6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757991; c=relaxed/simple;
	bh=MlBpvBCbPlpavQdjhzK0i1W4DYTe41ZJ3xa89pUGCSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDmecOrcN24CVzdKKpM/v+V9qaeQHMEDfJdJLL6eXos4rMg8gntSAW9Yw7vZmXjGafLIJkVfhER3cZXvdM1NwFbi9xLNU/LiYAWJdehZTgzZo0zyCzjcUp6MeagbBStLAscngRTVHUZmhBLH3U5w9i5kcHDbtbHtPcOkjN/Kmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgXZU2aD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J2IdDCaR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9Jt2Ig1500488
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=; b=MgXZU2aDCE2abuJU
	xVL88LI0Sc+ly50PvKHIDHlQkdcvfir1LlDjcfnUc278LIvyqPv2+RdTPVyhrXMe
	yftpS4S8rWs51S9ZELUHRIbcWHfS40kUVybADAIiB4J45tQB3ZxhaMO2znkN/Zo1
	ZeH2GifS40bEjB62Xw8/OtgFjpVRLUevl1FSlvo1fXmRuqo/Wbb00OieIJEusduX
	XeYQbwWR/dZwzSJmTVmtd+1K0dfZXKxdZu3aMZ8vaubc6tHAE9qV3CbYOfvR73S4
	86twAX3tZFyMQ4NQ8vlM+4aRSd0uEe0/TOHi1G5EjjHmT6O5UH9TJOzt1RykFXxn
	cTBwJQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xueknm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78105c10afdso3086226b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757988; x=1763362788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=;
        b=J2IdDCaRHvGNE9r7kW3qdq49Uo2tOnQ/ZnJV4T8NLImRhLqhR/q8xsjqp2RNrQ4sqM
         xfnWKwH/YvdfMkixxvhj+74dRnjkB+OKNHWAUpjCoBEhwmE2e/mRGBA8o5FKu2W6xVEV
         c28Hz1FniPtrOqNmFy7rnkZ7wZFdnfKqCnQFUTDXGmCK9qRHWAQp5Qcri+LAdrcMJBZo
         TuX6R9FjahyHiyMhlc+E9EnyJJiHQdES+QFSuqGJkOEbv9S8I317tL2IwTDuJKoySxmV
         G8f4GIZEseoqTbapNxQUK9OJRHrwRy7IbloSj5gEemXL3aA1GUPxzwUgRVmBX3oqCw0j
         k7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757988; x=1763362788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=;
        b=RwSB9XEwDccmWOeibaE9xw/CXiGw1DYS3njDkO+Y+wnIsVGo/4pDeKssvvtb/QSZBr
         /N+szOXN1douhK6ILjeR1z15lCsas4ZWHVVXe75k9F+OdLkW4/BCqEi22hA9U///XqVK
         HQsyCTxxUABtXXABeQZhmnAW7QfKBDPEZyFt/+DtUzsrOD9UT7HEGfEDlqPRMW8lIkuW
         nLgvXo1dHEuZejNdXxt1Vfcnv/6UCXFoXmtN7uHAXqP8mUIu3oOe19+RbKnd7MJrX95J
         VwvwtkQ9irb4le1g+TOD+kuf5a9zTduxnWkWt2R4E0yXY5KowAqE2kGR0+rbtBxd9gVZ
         JSoA==
X-Forwarded-Encrypted: i=1; AJvYcCUwLQgAvFj16IMUSA1ibCrMhUB2NLsM4edGqpm4GWY9L4iNWOaXThkcV/Qv5HSAy6lwNS4nwS1Sgfow+K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75gb02CtMMZHgH1/RBSorZl4OOQFF2S0wLuOQ9rWvzYQBOKNm
	rgHCI/oxMjFBLrl+dIWsU/m+bQqm90RrQKuDYa+RKZHKHk+k3ick3689pD+lmsYuFBz8wLVrWl9
	VjD/N5Db9WCaUvapaM0Q+s0+L5Ei6WgIVmOzuTme8BVv1oo2ZyeWDLY/WU4HFR6+E+KU=
X-Gm-Gg: ASbGncs+LDTEPMvKDQIcISjAAjimX/zskd1kmMYBOavMg2Jz6u+QiEzhpRZKmq93IGM
	oWUKEVxLQRRRxH67GQ0CvPtHHfY4Rxo25QfyfhT3ThmkcwabyLoXdesK/EeDmTfSVZxCFhk1E7D
	Z/IKSv5g8CyfosgrGo9Q/I4UhK9BPLeJweQuch//RkU4SvTp+8Noqt1bz6DJR9DSg+7TdupNTBF
	oOEWZLP2Zy8Xq4XlDnRRTcT7f56ShYN2w8pFZ32CMKQc+0JNkcqAAr3/IZcBXE6v6pB9SzhGuqp
	z0OZucvjrOboXIjnDwcyRlZhjTn5Kmvj3XZMvsGkfBlRifebkErgo11Ru6rtrBAS0X1pVeOChB6
	y3cPMWb7c29uA+TgPLCVjVrwU30z5ctwBZWADHja+JWeexw==
X-Received: by 2002:a05:6a00:1813:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-7b22727b3d2mr11405639b3a.28.1762757987774;
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Wr9f0r66H9rwqF4Xlv+qtiT8NKkKIWr4Cwcpsbko/RHQUMUohydItYXQB7fQ8tTRs9obwQ==
X-Received: by 2002:a05:6a00:1813:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-7b22727b3d2mr11405611b3a.28.1762757987302;
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:43 -0800
Subject: [PATCH 4/5] PCI: qcom: Remove MSI-X Capability for Root Ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-4-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=1155;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=MlBpvBCbPlpavQdjhzK0i1W4DYTe41ZJ3xa89pUGCSU=;
 b=EQepD2Vcqy5GPW9ijLmu/zs6vxi8fDQ2Lv8SRbKkFFEU3o66oiKVRykJBWQ+i0qwcWUdPqAcM
 yebt2JJpPhCC8vUudQ10Eaqu2Ro3ZvX9B8wuhT9JfMf+Y0nFJFsoVb3
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX1SLOrSx96JOr
 P0/4Qnaa/5wFYTqQpgE0luMeyb5kydbbTJx/vX5U1dq9s0ZRCoTLeosoLOGlqdicONdQsoEsxuL
 1MeKjarQHlTFLX1/BsKWcHuWINaQCTuUFrJ+fAk4mCAtaXRjqQsy3C9vzISUw7caruHllpjkefa
 2QpQKlZYPL9C+5LCmJ8ZcMv4NcpGgHHns+0MziJnYP2KCtwnk+RxhiFXgIZLDJAlycLEm6FDPCe
 iwCxdcy39zQ9gu8QUVpeHqHYiA4pucI9DGrOTBKmfC8kPc//gOwcieyRVxIVldS7NR6++2xfRwh
 lhCsout7F+6H0RdY82AFKNfo0c48/as4v4GALk6ZARe4qGN8/cscT70Hw3OH7HDa1nfvNl0bFj9
 5BXB4j09ALSLrIQYlAzpCQYYnla1Xw==
X-Proofpoint-GUID: 4WNiw8XRc4cd1fqTHMAnPEs425bnwtDU
X-Proofpoint-ORIG-GUID: 4WNiw8XRc4cd1fqTHMAnPEs425bnwtDU
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69118d64 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=m0zduzYP25AcjJBpPoEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

On some platforms like Glymur, the hardware does not support MSI-X in RC
mode, yet still exposes the MSI-X capability. However, it omits the
required MSI-X Table and PBA structures.

This mismatch can lead to issues where the PCIe port driver requests MSI-X
instead of MSI, causing the Root Port to trigger interrupts by writing to
an uninitialized address, resulting in SMMU faults.

To address this, remove MSI-X capability unconditionally for Root Ports.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..09443ffbb150e9c91bfd3b2adf15286ef2f00a2a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1350,6 +1350,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
+	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
+
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {

-- 
2.34.1


