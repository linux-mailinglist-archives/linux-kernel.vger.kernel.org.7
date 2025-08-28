Return-Path: <linux-kernel+bounces-789913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94819B39C88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540041C817D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAD313E15;
	Thu, 28 Aug 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lt9sX4dG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C03128C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383041; cv=none; b=bRZ7n5bVN0X7UNnd1rYODFUqNWa3skNOANtcW99FN5Zz9LFdl9tRW9ICoxYIHxi1fiQs4p68wfhVAx1tZVDPIbRL0Sjpuyn5B1PyY8eJtEm1TO5+5v+/Y+bJY6JxWIjvhDRjUq24kuaWvSBEVS2w9tVb3knjetTsa+6EucHxLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383041; c=relaxed/simple;
	bh=pMaklKWqapFpWdv+7J9AHF7Bw2YdzTcWihkps7qIAps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD02efVYp0pf/VcdKhPIgnOLO9nZqh910QEHJbhc2PTFenBjMmwhzIIRsD+zdawc/tHpAJZN//x23PYwiDhbv02eJdxC8sE/hDuocl5mRg4Q68CWIWh+n5QbEcoYpQse8xJ5pTqNjoOeBiJMxQiMM1x/CkWDOsEoab9pPbHvKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lt9sX4dG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5OAtO016167
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYoFfKuu5GFLrCOXiIOOxFQX14nlPMmQHH5fe4JzCMU=; b=lt9sX4dGkNtDFFDt
	bAT2gpDdQNq6TYuLT1r45kOPejvUIoSVzMg7QHW3xNAXnYaww37MCIAWVtehpAjp
	sTRe3JjCwDyRmK5UWLQqmBTRqIdg7/fsYpr3BrKklghJGXWnnYhOFarWW5V63F2/
	hZiPzoYfeS8gZ9e4HYAqyRTh+cG6zfvU5jcFDk7gEFJOt9KqluC+DFxKIMMfvYXB
	jgfUqVX43GlHoFRF99H7ZsBA9o7v6Mn4w2FvAzJwSbgX2wcUAWVfP1zyJ47EIRJ1
	toXt9JaMHM+8Pa1vArSvZhCNPFtOJ1HeurTzNhBesRMg1BHv28mrwtSYuzTEDUuO
	uC6zcQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2dsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-327594fd627so889607a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383037; x=1756987837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYoFfKuu5GFLrCOXiIOOxFQX14nlPMmQHH5fe4JzCMU=;
        b=YjUPUQ444wekUGPWLEWyGsGvH0GFr/m2qoDcBOHye6lWDdHDx570jOjp493tOvBO+V
         Zx2KAHHsDUBf7F+V2NYL8evUq3YVhLhvTHJMeF8h3aDKUTs7CYliZUTTye7boxhcmGd6
         OFZnYHNpyC29YoaMj2JIdNdktY/GWFRxrUc+QWq5cuVOVWl7zEHj9EaoMpaxss93LowH
         0uFW96XMEDwLWTrUhCf2GSIDW1eXBHzkxjBCrQ7rtfiuS2xZ+Lkf05E81YFqjlb45Wf8
         GEVk+YCIduInYamlWHheNxF1ljphQKnQdpCKxdN5fJhOnl9kXAS4j3fy7q6uOqMiDe8u
         r90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwLehHLILQhs83nzj2RA8Ug63xyxulvUmIdOqKLqYCtuLwxYECdpjiG0cpwEFG0Vdj1cyfHvbK8A66DAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIvQwd032WPA+sMUiqrOUwjvPxMglYuK94iZKokIkUA8m8Wzv
	z9nZIzBHNHcB74uYnMmQYopyRA4BTco4E+tZQzJiAUJCJOn3D0Pyx+cMvPtmQKEqko+G4Dx19M6
	AznzQUv+U1eDDCiMVo7ITJGSAi1JbMEl450SJyQEuG3X4TFLws36pPwauT94V6nvdYKo=
X-Gm-Gg: ASbGnct6LxA8L8CrS4iiqYmQt96HPSbPOcz5ToJwOjMpw0j9qsJ5sufLEm9Ymyq3PK4
	5E1fWlG9J/mEduV9icJ5VKAvX//5qxWIdb4V4M26kXMZ+6TSpX8CdujLBfIjbaFDncIarnxTfSs
	MxmCaOUkeftYL6tXc2p3uT9IZ/1B5OXkI+Q6h2qrP/foJZcEVmeked3yDY/7pRzDCSFxDC5O+dU
	O0fzywXj3zdrfW3yNslljzJlZbwkJhFR5+wHKT096mPtlU5r9q9EP7d1OTBKkYdU9kqt0p5Fwav
	csNDD7Gp8QY+K3ag1TC2idz5wlOxVAbbDf/s9eHPcboCg3rxj3+f/b9/dyBb/pPURU4DyOaFFhI
	=
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id 98e67ed59e1d1-327734aafacmr7013822a91.10.1756383037329;
        Thu, 28 Aug 2025 05:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvAJvJ+Agf+PXn5CDP3LOj/cLF51Uz0w7Smptbs5rUVIF/mhglzzjjGvG7lqCA625p35ue/w==
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id 98e67ed59e1d1-327734aafacmr7013775a91.10.1756383036835;
        Thu, 28 Aug 2025 05:10:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:02 +0530
Subject: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-5-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=1453;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pMaklKWqapFpWdv+7J9AHF7Bw2YdzTcWihkps7qIAps=;
 b=6REL8f9VVvl4nfDJ8zLlXrHgnb2S/Rf6iqrVR2o5YAG8A93MtB3RAwJqcuaLM93mtbPWR3N0x
 i71jT6xKGP/Dnp9bpetEtz+EkkFCrvEOUi3Mq3IW8O1v/t1TpZjF+OI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: hcc-tBnDj1DD5rR2g3CfAIgbeUC038ib
X-Proofpoint-ORIG-GUID: hcc-tBnDj1DD5rR2g3CfAIgbeUC038ib
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b0473e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4bBsNf6MAaYI6lVPmewA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfXx1Dt8VRCDBrU
 xQDWy0F/z+Ukjo4L4F6D5ihXC0NH3ouiH693TeSKYQ39CORRkoP/H2WauHIIb3P4VY3eiPi5nwt
 EkRkqhLfSqhJKHxmesivJlTQhU8d/uy42Ych1lNBnfCSEC9gM85YCJ3eNM2GmZjh9mwroIfGdib
 Ls1mvsfVz5ctKiYzeVGH7FIEKoX18oeeta1yrJmFTVbBGNnmqPc4e2s1a6HWxlAeU8gxIV7y/2p
 paNDpWrjRQ80T3kJoxHNeam8R3AeOua+xvWSx9s5yxWuXfzOxkaWYdpwF9Xzpt/FCRQfFogYK4y
 /do1fsNB0SIJPXAAmRQ2Z0SxSUExmNI7xUCLboACDpaZJLQeev1sVL68eFwGMCeZ85heAbB17gn
 WSpwSH5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

Implement stop_link() and  start_link() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_start_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_host_start_link(pci);
+}
+
+static void dw_pcie_op_stop_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_host_stop_link(pci);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.start_link = dw_pcie_op_start_link,
+	.stop_link = dw_pcie_op_stop_link,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


