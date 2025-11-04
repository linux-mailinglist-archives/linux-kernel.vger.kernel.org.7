Return-Path: <linux-kernel+bounces-884727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74EC30F14
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751173BFF47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E22EF64F;
	Tue,  4 Nov 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCbGBDtY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DcSDq30p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE123F424
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258437; cv=none; b=ux6AcCJVL6RslTEN8m3AbLqtCpjORsqUbD6KIIJOXi0zy5BlGbqxD9v4ai4hrlrwreEEvTYQ3E3qonZejprCjHnFjQAJaGINqT2f9zpb5czLeO2xSFHzKW2p9L1KronUslkcoBLGRi2mFg2oQ1u5lVQ3kx8GWGusB4L7f68IVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258437; c=relaxed/simple;
	bh=+DzoErrmclrx+fyVr7vdFN6fgo2UUZGE/vT4uUlDgdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FAHoFeiJmzHhL04kZ1W429AX2/9ZU37Ts891+Tkf25lsXOqUlnJg1mVpK49TnIgwZt8smkE72O4GVjMZe6uXUwP69RMVF3TZ+jT8r/lTT5YMlpxK0pfm3c8je9PnXdjIst7MpJiJGZYupcGIwU1FUZs+VBCegB6rcPC2A8Q5GOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCbGBDtY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DcSDq30p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A49VYIv1653876
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9l2F5WQjsOuWEb21RSgF9g
	1FD2s6A5B664vjj5RTNLs=; b=RCbGBDtYIP76PgacdYhWDofUHNA+esoKzS8VqH
	ImYKekPMjMQyfJZ+EAJhYJriORNBWcqo66vQDwfqH/QO878czWhem9G7Vkv5IoTV
	USoco2S5nrl0xhs8p5EkSfWejqc+Moc/US62WRGFmQBjbP9DZc17ddNwUPQ1pvdr
	VPOGSuul3aULeXCdxHxqXmQtUPOdT+Jm4JHD4obFqFcy2F1NRBMXicynV8KucXnu
	iCwUb71DkjtNrq7OocCfF5KNkr6uA/6msOcRkoPy3uvKZCCvp3cR2+q2I/TO4FQS
	ZdegRoVvLbCUhPl39TzbFqE61zEUYKIFMzF2CTmKD/JWQsqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ex7rd6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:13:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b63038a6350so4608918a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762258433; x=1762863233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9l2F5WQjsOuWEb21RSgF9g1FD2s6A5B664vjj5RTNLs=;
        b=DcSDq30pz/7X5oVJ5PxP84YuLLKFdr5hCFWR++sY2iECcz4QBEAuDEFY3uGDBvcXn3
         m4gmjq4mMqtCgROwpX+j6Pnb75VBCnISiIlXDcZfl+J+fBzY5eEWReJd0l+fmGxJCrAV
         T4qnJcuzYlG0pn3vDkUzUbN5j/8tvPY4ThsngnYQjxOwQ6oD8K9lFuIttN5jp5vDmoUG
         nrdMaF/Nk8n6ZUwBb5Ibin0Nb0ACyX91sHZEJ2pKUBwwtaPB0ai/X21P271W3F86cuYk
         szGOakQ2CQpzuh8lvAlYXiWXXFkOVHef/pZCgobKsn4CZbZ29XnDMTVev+YVDgkT7JaQ
         xlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258433; x=1762863233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l2F5WQjsOuWEb21RSgF9g1FD2s6A5B664vjj5RTNLs=;
        b=Ko4FVhKITZc+f90CfzgLXq1GBX3XyyzBkxSqDP0fyKnORvtFp1YFMcm9xHAd0VtLME
         joHeXDRujzyXmbUMKRvZi2vwfeixRTGBnAlluvKSXM2ABUW3yMmSOERaLEZPKz3yUKS3
         Bg3W+PZe6MFAql1JHg3xYRD8XuhZ7iSVnpiOh+yMpTOz97ncNkSeuHwI5vMPknQNlF+L
         6/6QzDHgozyNp/nQGjujh9O+voiYhsjRsnTGW9Uu2wImh1FEnhOCT00a9KosYBc+nybz
         CIffUzRVpySqErlPCTf24Sl3n1qsNkexjiyYlBZnRq9OYx2CeYvpOXlK0kOJKMU/AgBg
         UNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshulABE1fRFGdrSclaPDxgH0+wkIDzE9T3dvGKmLGMBLvoNVk4iwnkXRXH66LSNywymRqW3q3T2fUbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jCn2eZxW9rsqQG60XnzMrfh1XOyAPmMBeM3RrHGgxRIZsJqf
	Y4+lnbTMlB/77cK3jr3FsM5W9Wdbjor087flVPBgeccHfxzQ/P7tSo7Z9hKzbu64F5w/JTUuFSb
	Aa/nz3GsUAMOXTqwYtLl6uKKDKPdTubA7Y9XATWjhdldRQZWZ5BZ7S/cIJLEQGq3xi0A=
X-Gm-Gg: ASbGncvgvRp+ojITpBQQEJAKFWfcv5cTnI4KSpRIYg20ux4RBJ/+OIxSDiUl2Ql+hoF
	XhGJpue43rHCMvyx9ZkUJMnhTqSckwS3pwh5aPjneDPzsRqQQl/k5DysfmyMC4fjXCPcdwMvnmf
	WsUEu2zkjmBkFVXPyCnJjcftnaytl8g2tZm3iY5BG0BHbh3Teeho9AAYgm4JYtpJZYUymMDYBTU
	tyNvhsipgJ56hrviYRDlDBqUQxf+VSC5sobslABhw34Yye/UaELMS7vvOu8dj4uZwYv5cJ+s6wo
	fufzusTtoQHK2bmLGVTQ7dtkqiViOTQbHifIh7eo7SK6JPypD9WOPerX8aqhgiFVin3owOqlzJX
	GK0ZWqVdbNWRYptVNUnn+pGGIgQXWKa3U5w==
X-Received: by 2002:a05:6a20:9188:b0:346:3d90:84dd with SMTP id adf61e73a8af0-34e272e54ccmr3397702637.1.1762258433122;
        Tue, 04 Nov 2025 04:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESpL5vuTatq+nBygYOabD7eaIn2oVMV0YsB98tvlM39eFI7tpfjioEbqRljOYql4yuAMDUrA==
X-Received: by 2002:a05:6a20:9188:b0:346:3d90:84dd with SMTP id adf61e73a8af0-34e272e54ccmr3397665637.1.1762258432574;
        Tue, 04 Nov 2025 04:13:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2254104a12.31.2025.11.04.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:13:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 17:42:45 +0530
Subject: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALztCWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3ZL4gvzy1KL4/Lz4tNIKXXODlGQzC2Nzc0sTQyWgpoKi1LTMCrC
 B0bG1tQDBSo3GYAAAAA==
X-Change-ID: 20251104-t_power_on_fux-70dc68377941
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762258429; l=2473;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=+DzoErrmclrx+fyVr7vdFN6fgo2UUZGE/vT4uUlDgdQ=;
 b=lVDCnFqbZFnTyGYnkfi7e0ol56cwmZaLfYwWZSFMRo+XeSHOhGCNocy6q1IsLr2D0JKQjL+p2
 Fw+sgznAj9rB4j5oylbrg9+Sac01F+R5lYLGmHdxjaQ7LU33PG2nds+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMSBTYWx0ZWRfX+IsonA8Gw/g0
 QgBiwEDKFtRBA6YaVzrkoCkY9HPiV6iAX1fwjZhKJJtMbislk5vx4RCq1PFWq28iOminEAhUuUj
 HH6WWvhWqm6s1pt+ILXqJ0Wsw92GORmk4vWhOwU2ohtTvGCvOleyTgOBUw/7ge5/r6rV/tyFaGl
 aIAoRRr7tnNRvSuWK53U+gWMjCMPoNfU4UkE0RPNAo61Rg8IpB5e9KVNGrDzA/5aFmnUEDXoyW1
 vwvCgF6evHog3PSOi0As2ZUPgwr0ychbtY6FJ8eSm/Uehy6pdh5XZUuU3Qoi4fwJofwA9NKw4W5
 G81ZcOZfkw7wsPTFsxisM8U6S664IciRR+RCWLAK1SqEuE/OX33WEdKrYZSGLObTtY3APPPhQT7
 nFFtm/HHbWsz7r3UiwDkSkfnVa1e8A==
X-Proofpoint-ORIG-GUID: dX_ixnQrjmvkJD7s7CJOGiHbI52S7Sxu
X-Proofpoint-GUID: dX_ixnQrjmvkJD7s7CJOGiHbI52S7Sxu
X-Authority-Analysis: v=2.4 cv=auy/yCZV c=1 sm=1 tr=0 ts=6909ee02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040101

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
This can result in improper L1.2 exit behavior and can trigger AER's.

To address this, program the T_POWER_ON value to 80us (scale = 1,
value = 8) in the PCI_L1SS_CAP register during host initialization. This
ensures that ASPM can take the root port's T_POWER_ON value into account
while calculating the LTR_L1.2_THRESHOLD value.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c48a20602d7fa4c50056ccf6502d3b5bf0a8287f..52a3412bd2584c8bf5d281fa6a0ed22141ad1989 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1252,6 +1252,27 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static void qcom_pcie_program_t_pwr_on(struct dw_pcie *pci)
+{
+	u16 offset;
+	u32 val;
+
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (offset) {
+		dw_pcie_dbi_ro_wr_en(pci);
+
+		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
+		/* Program T power ON value to 80us */
+		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, 1);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, 8);
+
+		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
+
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
@@ -1302,6 +1323,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
+	qcom_pcie_program_t_pwr_on(pci);
+
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251104-t_power_on_fux-70dc68377941

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


