Return-Path: <linux-kernel+bounces-880042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F46C24BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DC444F4635
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F063446AB;
	Fri, 31 Oct 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST58v/25";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvBqTS1J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3E3446CA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909153; cv=none; b=c2XB72PPdQNpDAGrvbw0QC2UQvfFNjb/0zbDcE//L2caYuqMXv9DnRpgRnnzSpN142frPCGXJ4Xp7qBxuMaTcigfFaEnlOoob2mISYKdbmutIkBghgxw3yEf10uuroWBZ6hbmEj2tmPVaWSLIx2TZhg1KJKc0/D/uBDBpvUlbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909153; c=relaxed/simple;
	bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0nZOYa/BGTzV/9qMADcSAxmNukYFYr0lmp2JyvDqIPwnKDBAO/M/jvpS5CfViXQh/5qs+wmPCAEnh8PJCdHWMCIN2rv6VHAxODpcST33Ozm5GCVc6F9rQDxboyiX9ppho4ZMunPfPGm08eCf1RRD0T1fZOXsiICUi7AL7UZH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ST58v/25; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvBqTS1J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VA3pul2558862
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=; b=ST58v/25oX5eH+Mn
	tUypL1GZUOsYAKlZu0fVev3CwND6mMnDYOJ9tCeH0Y/Y5DB36PPgobmAPQ7ZRC00
	LqLQK9EWsowwhPmFP+4mUuCxCq1l05rWavuhbK2WVPW5edLM07iqibISllyVbg+P
	HM6hnjqjdx9qX4uktkBvgwH261Sxeiv3q/mOJOf6bRiLNoWTN6lPrhW+8Z7fpdvD
	I6MSRYTLbfio6X0ZtddinQYpZDrxwjgYFIgMLKddnNYQGlcVrCLt/tv8v7aJml68
	14ciKwC6W+Abwx+B8MqmCgUEg8KAOskIdah4aGF83iU0NisBKI282tuSn7IIFDCO
	9G7k4g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4u1gr5v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-792722e4ebeso2241915b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909150; x=1762513950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=SvBqTS1JLYcuAkLr5/K9Jix9PDSHHmfKUKDwgxUs7OycpAzKZK63XdBcYY3XG74U6F
         UqEzpC+Xlz6wqMS6ksqD7vEAO/LvAnDeGIRAVfzK8U4TvWEmag/7yGIUGCKPqXlSDN3p
         Ju6Ay6wK+01f3Bi1oSqJqoGmtp4Y9WERz1PuQk+D8fYxLhg8rVSqu/HYwvo6GSuynadj
         q2u/0zpvyQUu5Nphbux5b2/ukHcc0i2ErddMszPBO0Ur227l4TZqjvEYMviWSANy4cNZ
         F+ax9o4HR5CJ6xGI/0jWga3DPNgxLFj6DQkkc/W3VzjOh6B+YofUIn00+MaDc4ZtaCbo
         rBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909150; x=1762513950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=qyrc+LBDIz4qiB41GXDK/LPQa3/Jdh1OqrSd3k1fxR8iGcJgRuFQXcnze6vSSu+s2T
         QFd0tZ9/iWJ6emYzHofltwmPuOOjofa43mfx2ksJ3b6sU1TU1IO9/xfbDMBrs2Kcf811
         Sl8vfFah9uAsnECJuLxUJjmVu9ahA2DSz/fjLPK3PVXnzEXtrkohrFg+g7Uq2StVl4Kp
         GsKMw4PBYH+CSBu76uwoGH8VbhvCjCLz+S884+5uXxM0qmIYu9/F+tlqnzY025bMmoQ7
         iiu82QUEKNl576MoToY1CRYKIgsiFHgJLr97GR4dzHvjpYbAIbvPmeikJD4i8GPyE2WK
         DdNg==
X-Forwarded-Encrypted: i=1; AJvYcCUEUSmJMWLmBKuSnzkwq/ngk4A/mwDWy4mMCdLpm0SJNrVs+WGNeKGW9HRrm8FW0xMmvRr/D+kBWfBhsfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugKHm3W5nRGzLEjmkmUm78qKC6pp7bGt9zU7jyXlH1U7sseUz
	VvRlOr1D2FKDp+coOfO+HpDfvvUWFE6h0ygmcv3UfzV5WmNnItcoI8SITQN+QY+kofksIkHYzC7
	82/K0rC1Nxni9e5Q6nso/FSsA9VhLGUpzW3E3czZV978uJYQg9+f9uwCm5We19H2qRB8=
X-Gm-Gg: ASbGnctCR802G28CRSkmqx3Yz2+E3OX7MKODuojIu/WVzvT4nw3nqaUoCY0mMX40+fV
	XGj9PRMkC8gNaQald6Ju7R0SfQ2lVXLm9+BkHf2J11RO/rqIZCCMKRzUJZkfXMUjx0JoL9WdoDR
	sLHixxOPTOXYjexb4kzbwZStcdEh+r85psJao2vYpaC7DqiC8ZcVj0Jye5dffFTQ0KQ4rrFp3mL
	d0ecJ7gWFirt+TedlVMrUHKgKF5wlzBwhvw/oGY5S0RH67eq9P7DLk7fKgyJGcbeKlO2b5pQPGi
	m1D5xcTIuYVdLctqGhtdnBVRFtJaiAr2flKZfGGs2YC7pFXUEuiL9PQgYmFwXV9HR6FxLqmN870
	V32jdzMv3r7seHA1EBvrK/7ovYBE7zcOmAg==
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr4485375637.23.1761909150035;
        Fri, 31 Oct 2025 04:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTcz2eZ3B0V8wEazc5KEbLKkxIWKgiiOEp0tZ7ZxRptwHbThKDQlcx3aEinQTqWNiwdcZvrg==
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr4485327637.23.1761909149547;
        Fri, 31 Oct 2025 04:12:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:02 +0530
Subject: [PATCH v8 5/7] PCI: qcom: Add support for assert_perst()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-5-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1479;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
 b=IVF5DRupFn6r14/z9fGTp84BhyIy1Hl9FJ3EWg7OBJZnfOL0e8jWTHPMb+mBCov5dy8UuYoz/
 l2lTVLFzBEjBM+jJWXeLRG5+esykCOJwy6N82STTktTPOEz8boJ2HC6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6904999f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j2XxTBISUlk66HYKGUMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: XSVgLuCKTOxNGmmVNPVcQUdivVWpuAGf
X-Proofpoint-GUID: XSVgLuCKTOxNGmmVNPVcQUdivVWpuAGf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX30r49ZoRgst5
 lGfY1BczIQOnjya/awTSK/ilu053e8s5uqcAWzx6CrMNHO8JCKq4vhoxxh6gSBNOUU+WRNSIuSm
 R0vjJTqHILU/6mOvG2vCTWK57AVJEHoRraxcuKq5LCdYai/HxV09ql/D+xNOnBIdckbEAwkftHm
 qFJUc9y2ki7oYvAAmn5aJh+6jJBgndfJxS8n8l5ZV48FdwwzsmoRXRrULXp4v6l1C2rnqDe2E2f
 O8VLLBTMJb7k8bvofmN/iQT8/YVV9GKR/KcW3BKxo/+v31y7I1rage/n+UuWw3hyXkozp4Riamr
 3UQDBcgB7Et5wrQJ48A062wxXxX0Rb72D3U8gDtvCAJ9bP+j7Ton5C17ORVOA8M/jjc4a/FgLJ9
 ZH680alKeZEs5+tQecseybwzmHajhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Add support for assert_perst() for switches like TC9563, which require
configuration before the PCIe link is established. Such devices use
this function op to assert the PERST# before configuring the device
and once the configuration is done they de-assert the PERST#.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..cdc605b44e19e17319c39933f22d0b7710c5e9ef 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -696,6 +696,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie);
+	else
+		qcom_ep_reset_deassert(pcie);
+
+	return 0;
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1516,6 +1528,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.assert_perst = qcom_pcie_assert_perst,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


