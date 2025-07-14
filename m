Return-Path: <linux-kernel+bounces-730618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E9B04704
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4FE1A67E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0E26A0FF;
	Mon, 14 Jul 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljfRAkrH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415424EF8B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516085; cv=none; b=E+KX4o1dVD+Hm5AUWrcN0SdQ1j3CRvqZoYFWqXtIecezhpNOqi3EiW0ozVK8FVqvPXObVPlzNGl2Np+ZZsGUdBZeeLSnedit/iJdYtEdMdGY70tMLqLlK/DC7hCZ+4AICnPwP9alaBBANqGKzxUXg2AzS4t2NbxE2Tiw1GdE/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516085; c=relaxed/simple;
	bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I+1kASmvKYmLl5P5pxqhini/PTMuh7mbjepp1MDV/U/pyxpgTjFTngmjfFgy/idzb9eFqxfPWF/t8Pdc3XTkdu8Zhf9//CpmzAyxNA+FCTIoUFaKNEL1r7vTdoxKZFVNUBPeXzuaawcllHS9LbHeyrSoXE1aYjLFN1Tv8X3hQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljfRAkrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGIl3P008660
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ohJyu1geVqwV23Bgi/9wQX
	zmFnqB141Eg+tm/AJaoKM=; b=ljfRAkrHLsROSFC/Yo8QSj9RRtS86W0e1oaMaj
	tMgPIgF+B+N1urCMmNg7Wr64UbCoSJpRvMClL6T01nFA3ZDv8qvUiXbTIZ76489J
	YkEB28r1ppgyH4ohQ2o0ak1utKDGZgj/qf3qO0Fy58FRmXLVpTO7vIDfUOlCOBaT
	U/Zsi4JZ1j/CMWfGzGthfGiU6wTnpZEJJeNXw9NTk+ICMGrYlMWQKGFdRYOj56Kn
	JFi43RBtAFG4NGIA95hoNOLW0uLgOk0ehCwXJUo9/PbtODaZt5Kh1G6Eo/zBJAKA
	iJSmGj+xysYZbx6AtO814Uz7KP1/a37HXgwU44Q3VPAGQdEw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yga11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab758aaaf3so27359911cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516081; x=1753120881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohJyu1geVqwV23Bgi/9wQXzmFnqB141Eg+tm/AJaoKM=;
        b=E3xRq4q8uxDg1+LzX3m/rmGqppLRj8fiqOdX8ezxwxEwiO0SOKswNwiAtNJXvENupd
         /wPqAX+uAtAahFbMTg7+C6V2b+3IYtdGH6+QGSF0X01hVGjBHkcf9afv9i5woHVz1PiJ
         TQR+qP+I3Bx3OvQlhB+dgtfgsvVEWlYqkS02L+2k1I2AiY8dM058PmPd13g45WxCevMY
         sw4wEnSOpCVp8WxtCy4N1XMBd/AFhVALSLmU2pTkI2VU3bT+0lDO2/f4TtJ8CggRZjnO
         Sn+8grJUa4H0YF7f9FTKs5M5uIba26vKiI/5ECnG3Rs2466ReHvLQXDvXS87I/lcc7ey
         BG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkoq38glGAIeNEDvevtpUAS8CcdNHyj/rUif4WRBzBgaQIcdNnNX1r0h4f2u9MmB75/at62WwGYxR8Ux8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoOOFMI/LvCizt+3gMSEBGTnk5k2CgSgLyQPjV5QXLFK5UnXm
	XK3lQaGAaqoGO/am4fMiM6f1UnIAaAQAEo0SrMJvqYZaOTavE6sgcu2T/4KnpCAaB7XubFgmH8C
	F7dpRB2qMQuw+UiA/ve2Q1V8s8L8/Jvq5jyS8ZE9NssSovGTsOx9v6FPUn3i1MEoiscs=
X-Gm-Gg: ASbGnctIZ7EbEiFpNFqmYu7I7FQxI5hWwiZ9nRMov+XFRmOUJPlPb0JTkyQqxwEnSAP
	98AHrOGsE6yS78XJyT+BZ9UIjXcJd4blpY2/sFaav4FUkcoYdNqNW9ga1y5VoEWCRuieaJ4V26E
	QTL/GSPKef+84V8Dx0nHk+pzG0Q5VyFrkNwmZ1WVHmvU26yIlgiGKfZ62k2M3yGs1h1V0ByAzCH
	mup0oEcq513FT3pmuJhZ3OOsh6hCVMEsKMeSJ1Hs1XQh9R6d2F5n+pTIrj0BKdv2lewbsbkekUc
	PKG5rDM6oZyGGG3OMJCVDWcm9JaPo7ymGupYs45u9GW2LG+OgwTzHufuKWuIoaHbCBE=
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215365721cf.35.1752516080601;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/6Pul50lfnYF7kucBGxB7MrwD9ARcmggCN/hiK8dl/0nzcXDqTO0GXrPd5FCOVdGXTFlOow==
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215364991cf.35.1752516080005;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: qcom: Switch to bus notifier for enabling ASPM of
 PCI devices
Date: Mon, 14 Jul 2025 23:31:03 +0530
Message-Id: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBFdWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MT3cTigtz4tMwK3dTUFGNLIzNjw2SLNCWg8oKiVKAw2Kjo2NpaAAZ
 JW2ZaAAAA
X-Change-ID: 20250714-aspm_fix-eed392631c8f
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXqUyWYINFENbIxjWYt3rEs1gx0E/tbUSEcz
 SpppJ9KEpGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6gAKCRBVnxHm/pHO
 9Up/B/9t5OmC953NndUYPqjfz4q/od5S20svRDDr+kRniUGMD7d6tqsfC62t8OXVGb5yRdFwyTc
 it9owf5qfbPyvKAk2EldZ1pPQaypwqUGbN2Cz3wQIEOBOT2obnIeJNv3nOVtUzMxVZXsKEhjbRk
 gsV2l/OF5CJQtgxEdfx4Dp/0hM7BwA/DQV6D2NsVjxIEmUAggQOl5zK/ICCIYrQUzdAiDFeA17A
 40cPcZSwZhLbLMrmSckpCLRt/tq6mqKut2pjIcq7vs3eG6xMOnS7L56Tfp6yw8gUpscOHIIW4Xe
 oIuTKql+lue3GRVMHIdgvfJEycpEJoWWi+amwwj52tH/5DGK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfXx1tjNEDb64B9
 Hag3J+S1RHXqaaxbLaumznwmigzZUsBg+yXVCf4n2k9CT2t0c1hCES2ZwQ6Nw2QO6nO32Jriw4r
 EGQjfnxHZFIIwBLeewb1VCEqoxttwZSJTsFjwfA7XLdDhAAdfAWVf0vXsXQBtwZjcIrOGtTln1a
 589VCxu9VN9EdKiWArLCUk5vDWgOJulfljrAPzWRa3Pd7w+Szk4SwEESAa+URwgh0h7cOS43Xqr
 OQ9X3SN0xHQIJsD6z9KNUc8pynaO3VciKJ/06uEDVeINmV+dWM3c2ucSi/IcMfNaXY4p7oJM6Iy
 nImO9oIUtXjhPJCyqtzHMlIZta2EaqG5Ze7q6ZSgGBf1IKgCpf/jc43W7/vel4HNf09zt7Bf924
 KLDCO0a0GE+PdtelwPJtF8paz17Tja6uktPL8wOD0wlFY+z23zX5XRwDidmY3IvLuuqxZ91G
X-Proofpoint-GUID: bXzRORmMhQsvzsKU9NmkLJO-GZsiXVtY
X-Proofpoint-ORIG-GUID: bXzRORmMhQsvzsKU9NmkLJO-GZsiXVtY
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=687545f1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=djgaaEycexjLLnWtpDoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=912 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140114

Hi,

This series switches the Qcom PCIe controller driver to bus notifier for
enabling ASPM (and updating OPP) for PCI devices. This series is intented
to fix the ASPM regression reported (offlist) on the Qcom compute platforms
running Linux. It turned out that the ASPM enablement logic in the Qcom
controller driver had a flaw that got triggered by the recent changes to the
pwrctrl framework (more details in patch 1/1).

Testing
-------

I've tested this series on Thinkpad T14s laptop and able to observe ASPM state
changes (through controller debugfs entry and lspci) for the WLAN device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI: qcom: Switch to bus notifier for enabling ASPM of PCI devices
      PCI: qcom: Move qcom_pcie_icc_opp_update() to notifier callback

 drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 35 deletions(-)
---
base-commit: 00f0defc332be94b7f1fdc56ce7dcb6528cdf002
change-id: 20250714-aspm_fix-eed392631c8f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


