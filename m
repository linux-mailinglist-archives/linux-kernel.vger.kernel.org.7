Return-Path: <linux-kernel+bounces-728389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D9B027CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDC1C865FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6822F74B;
	Fri, 11 Jul 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDN3r2zU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058422E004
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277409; cv=none; b=Wutn5Vleb/ppz7DwYN0tYKm8w79Q+syS2MPXLYENM59VUCxLC2KC00XRT8XMKpLVf22AqnvopB0IiTI6wWeFYpRcc9/QLM44RzUsutXTyTHYfDBmrLrea4HzIEchxQpQLl0WRLnrlaTMCFhDjCq5+KzZ5i5CtXTeA8CKDKwHsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277409; c=relaxed/simple;
	bh=NBnIXgXK6Trlsnr6CsojwAon1qRSKMZl8uFGRJ7oMJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyfbDJL7bKzO/+YJ7CQXrUOXPZSOXiFopR3l0gHHYtiFmcE6ajm0+pwS/IKTpi3BDRQNjqqaYxI3YsQBnvmdAEyfjwt3HryDy1B6k3LGnPbm2uRq0liEvAdfd+IdOiKCW24fl01MNkicdhLx1nS6odZzzWe95av9J7j0vbQJZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDN3r2zU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKBmEK016773
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w5OXNXJSNeQPojGoozGDIex2yCVHfTQL7ulled+ZDo4=; b=mDN3r2zUac4ld6tt
	aUahx2g83rdC3HLqRpYCAhxbxC1/syr6NWrnvI9H7IxB681q8Ld7+Locdl0sNyrl
	+hgUh9MFAEDrRmZnnG8Ez4EN+GXjdkfI1tbUI1/V1E+/jPThkWzHbhe72jp19nA3
	NptliXHzS53b5mr0eCLto3eJ3HV/qC4kvS3CSJbXXdsC6r/9PduieN/o+5LAwPtR
	beSeG/f63HIzNLKuz9D3UQdkxHWlOlYY4YnriZyLZBm09mtThK3N5d3oIpSDfDtS
	AlWji5RDEUsMJXo7pXb++haDt3O/eLL+Ub3dM3N4pdyeutlYV7XshFvRMhRhTYqV
	DW77+Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u1a2htd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:43:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748cf01de06so3909952b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277405; x=1752882205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5OXNXJSNeQPojGoozGDIex2yCVHfTQL7ulled+ZDo4=;
        b=JOJyohK5b+Pt7wKgCvZ0Ky3eNqVt8uomzlFa0jHgGHADZH5RZaYiC4Q5hZ2RmEVXnA
         30yOe8pNY0pWOuKxQYddSCqjPygf6UttHAum3lwvfPUGlzOoF+pN+GnKs/T7gxWEiFmv
         sSvhGk0RN3k+IRyPs3h29pFhUIpX5ucjaTnOYBj2TF7Db4qGU76FjR8pums/XBRh/jd8
         VMHeUnJrOxU3K7WoRbZ62XGCOO9h6VMxvXhjXVIM7xHbLxfHTIWy2s1pkJeefI7hNLM7
         Vp/VvdFiEKSCEy1/JrelYDe5kntyMzOeZTObemJeF5ekVbI4VzR12N2NzoM8wePRBT2F
         MFdg==
X-Forwarded-Encrypted: i=1; AJvYcCXIylUwgNPFGc5DvPozIp+K7LeUskfn8uIVuWe/6a8rZRW0vvS5xFsIEDrG6S3rSNsjxAPLE1Rx/F9dhro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRNQpwTOJ4HFi2wUvHtW3pDCFtFPm0AJoY3ntsjtgS0d8n3Cs
	CahzYkoEU9R8sYmxcRRr+eWJZE6DwqCll0z8FYHTO1h+q6+4lVELO8U5durENMK7D3x1BRDsY92
	p1geGkzSsBw+nI6CKotI1PXsdQDeFhzp7tzWgrwxoTq3t7UlgdIcDSo9M93gvzh1+xyY=
X-Gm-Gg: ASbGnctS5HopwKHo+dBJ+h1eFKQXCN8IzwjBchnbdCBD0v3wglx2ouMJQFW59tXKt3w
	D6K2coSUpajimpQIiBk0hNDTttqJGrxczEQzLtvcKB3raLssqWlFrWPhNIV3Ak9pYD4EloGerVQ
	uLktPfrocUXB4vPn7qLIJsWMDC1izUqZuvhhtEFaVZTpQ7IOrwXAZtY9F2TH5dtDXxJoWxeh/uC
	tBni1G7vv4ZqSJTbt9bzkFKya7NN02madHkWtCH8FS7LOoHee8ju5Q1g503Eri5HSFtP7wh0uFT
	4Sd3iMLG4oP/+ivionncbik3mQnl/gNE5xY5CnPVviUF5Vv6pwjXsJNmnn1qwmktnGRRlMJlgpc
	=
X-Received: by 2002:a05:6a00:391e:b0:748:311a:8aef with SMTP id d2e1a72fcca58-74ee284c6f9mr6864763b3a.12.1752277405415;
        Fri, 11 Jul 2025 16:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESWwcWYL5Go6OZu92auIZBwE0qGU4Adi+hbhTx59gkI6Or2b0dENFe4wyqlSvOE5PeIEBeYA==
X-Received: by 2002:a05:6a00:391e:b0:748:311a:8aef with SMTP id d2e1a72fcca58-74ee284c6f9mr6864718b3a.12.1752277404948;
        Fri, 11 Jul 2025 16:43:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1a851sm5869781b3a.82.2025.07.11.16.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:43:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 05:12:39 +0530
Subject: [PATCH v6 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-ecam_v4-v6-3-d820f912e354@qti.qualcomm.com>
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752277383; l=1933;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=NBnIXgXK6Trlsnr6CsojwAon1qRSKMZl8uFGRJ7oMJc=;
 b=0z1CvtLP6c2xTt2ueNc3NFR+LEvWRjutC4Thlotpk3pqH6sc+7hGFtvdR+4JssLP6eMuU2RYA
 GrA51P6OGgIA/llFPOVZ5xRs4Uw6TyBf+CHn66E22ENiDpBb8nz6eWY
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=MKJgmNZl c=1 sm=1 tr=0 ts=6871a19e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE4MCBTYWx0ZWRfXxts3On/93J/g
 OUHAEVKy+G7tLiFxLbZ91rk+harrBeKy1hmxdt/GNcM2w+gbGJgUaoHrd7raUYVTV9y4cyAlB1N
 s6ckqyygSGLIj80hcEXvaEy1B9BumG6NBWVyC66P9FgRQP97GbRurBJ99YdUHnhKyD6QmXtRKvW
 jg5knlgBP4LY2Lco5O22rKEDqxcDPyaFpJIxlCe8+EHrQL3cq/Sg22v9MgqDj6QFG1mA/xcKSN9
 mYHd+e4pHx278QohJOX4LrZTKuUDmJVtVJJ5qMU1UaKkfQlWGF2YXqepgwmlgrA3uLbMt65Vmdf
 eAVLh3TAcn1pUSWyMJZg5qbKJgj6EPGZEUBeT7oKFw+zM1uI690Iq4937oa/ebGjBRUUnZw5xVp
 0C3FILpF6nOp5WX3Rn1MuD+kzKPg6tyAvmx6D5D8j2T8KkCRaZ2hS4AkOIWd3CRLqAHl7oE+
X-Proofpoint-ORIG-GUID: eESm50Ik9iREzRQugSVTkeUPfI-0rkFG
X-Proofpoint-GUID: eESm50Ik9iREzRQugSVTkeUPfI-0rkFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110180

Instead of using qcom ELBI resources mapping let the DWC core map it
ELBI is DWC specific.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..6acbf17caf90b0582b31bc4ee3a99601d078a45a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -265,7 +265,6 @@ struct qcom_pcie_cfg {
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
-	void __iomem *elbi;			/* DT elbi */
 	void __iomem *mhi;
 	union qcom_pcie_resources res;
 	struct phy *phy;
@@ -390,12 +389,17 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
 
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
 	u32 val;
 
+	if (!pci->elbi_base) {
+		dev_err(pci->dev, "ELBI is not present\n");
+		return;
+	}
 	/* enable link training */
-	val = readl(pcie->elbi + ELBI_SYS_CTRL);
+	val = readl(pci->elbi_base + ELBI_SYS_CTRL);
 	val |= ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + ELBI_SYS_CTRL);
+	writel(val, pci->elbi_base + ELBI_SYS_CTRL);
 }
 
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
@@ -1631,12 +1635,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
-	}
-
 	/* MHI region is optional */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
 	if (res) {

-- 
2.34.1


