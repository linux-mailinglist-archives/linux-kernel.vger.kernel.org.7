Return-Path: <linux-kernel+bounces-777194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C0B2D68E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72851C25C33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469662DD60E;
	Wed, 20 Aug 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxaebifl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E52DCF70
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678579; cv=none; b=lLPEw4gg9AUoxXnQdTMMWQBw5RSmzXkeTIuutiOkSf0tLBe9iFrGKYN6vtJWAb3rpibV75xDjfgdpm6r8cZ/hNqs07bSn219sLsSQxT+O6YpJqpiE+QBRIyewWWSyBgznrnk8hh8ju4U2Wr3ReoAlu8LKOBOkWAKY1nZZtN/f54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678579; c=relaxed/simple;
	bh=IkmE1jjMC4FixOnI6iCdgleDL30HMdQDrPw6ul1iKuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMZyJ/m6l87jclxIxUU4DpRYaknm6O5nK6IJghtcOdckj2P2j0rVbMt3NTlaPYoocz8vnXKcJYF2X1S/KJU+wujtVLsdYeTrM/eEhGG8413+oAMOobrkAQNdySDuvqPfYL3CiuyFQjEH7+cqykK+QrET3qYEZaktI6T+tSod7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxaebifl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1okcM009202
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MgVazd42Ob3b+2OxT+ub/6AIeoHG7frufUrQpGpavx4=; b=gxaebiflv6+piB6O
	nkxi3Q6Eexb0QFYJ74iLHt5YdaS4ARA2WGcxRbkB4sylH456wAE89PKce3IfhcBl
	n9cufA/t1MaRyCY9XFLRdTOFwVWShj0hdHSKhJdh+m/2751mhFtREF420dH1md8F
	Suwnh2oxMLKUcKrEYYqkDkZGCAi2Bxy4aB++18oEgvPh9Jmfb3eNsRCm0bKrfoCO
	SBKNbXqvsCytP6nOqThYxI70XfIV7DzjNPjA+2+BLN27sLGxYq5pj3SSEefvlQA0
	EcCanLWY6mV0lU2iM8/0u99Z9Bw9V5ufEekSixKSLHjPg1W4rICcZ6b8Uhg9t4Co
	3PvK5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a1089-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso11835096a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678576; x=1756283376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgVazd42Ob3b+2OxT+ub/6AIeoHG7frufUrQpGpavx4=;
        b=kZVxrAGU2aAdJOY/+jOTPSWJZhTN8y6OPtutBZM4Gh9NP9uAspgAVkNnHISOlRShl1
         E38enuRRaja3+YGWAYJGBnNQIS/JSk/87TG595xgz3QR8oKCsIDxMtM63MdFlGWgmtf6
         HY9OuEeSIPBsqS6FbJAogf7BBYXQTL6Zb9Lex/OBsjI1tMLCBNcX+JSgHMEC1wkcMTMl
         Ipf1SA0LrraNYNqZ62UcraoN1Q6Uq7gc7RvVEM+k/mowsq6UqLBO3AJR9zlmDZEwHy0v
         d/9d8sTRP7kmxFWwK62uJDB+mJbKD5oAQLJD7kagFmkLeK2mn6WnENLhQts5km8yYbHH
         batg==
X-Forwarded-Encrypted: i=1; AJvYcCVGM0ddbOmJqb3mc3Z3CWLFd8VcLhChuUU8bH1rKJw+k59pqnBcR2CNSwJ2jr1sQJuotaUGaUR1vT+730Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVcg2SVklvEyKvG0qb853bkr6031LuLkDmaWabOHgftzKHXFR
	1vpg0lOQ4Wpy/EFsV+8K+9eGEoWgPkQyXnqhDcWSKBjz8cNlfkEZi+mxiyqG3nGiV+eAY7Za7bj
	b+oHqCvT0apJaxJSPPkGnt7xHqiWeey6f/q2JS1D15eybhrUwH6VzQ83GHYaxGMvvZTc=
X-Gm-Gg: ASbGncvfkXgXiOHLpZKL71lJhbNGlH1wZeMCQbNrnrJlbmbxM8BHr39BY6kg75xzjQ4
	8pC04olLFcauxx/KwcIuJ5oP/9fEkLNopI4y9jmb0cSY1G3UAgxAkqYwm45Xb8D51v77Ek3kExf
	OaBsecSp/jR9A4NvhvaMxtQVjiWNWo80+1Mgp6yw9IVJRp05hgHqKFiZKXaa7paQVX+cgH+GWXo
	3y0Ww3A27gAmrD76v0Y4rsDZiO4h2h3gE6vLlRD1QDjAcfhyWQEYxX/NHDowM3FTMrm6ybtz/KA
	yh5F0MVN67kIKJ06X8g7A+LVhO2P8pTB0ziVCXcEVWltjANGmLysTXH97gq0ipRwsGdAYe6Q0fA
	=
X-Received: by 2002:a17:902:e811:b0:243:fd16:181f with SMTP id d9443c01a7336-245ef215fd2mr29489615ad.36.1755678576404;
        Wed, 20 Aug 2025 01:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiPY8BfkmagQpheekyURX0cr9AaqhseFsDNA26TuaYix4uLgKtUJ/U/jV9HEf4oUZFV9rQ3w==
X-Received: by 2002:a17:902:e811:b0:243:fd16:181f with SMTP id d9443c01a7336-245ef215fd2mr29488865ad.36.1755678575396;
        Wed, 20 Aug 2025 01:29:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:53 +0530
Subject: [PATCH v4 7/7] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=1526;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IkmE1jjMC4FixOnI6iCdgleDL30HMdQDrPw6ul1iKuE=;
 b=PKpGH+CYVvuGgKtCdEXtU++jgYZEJaPAHeVES7cN24c3hTKUpEzzt3/Th7iOTfRMFmIRRo1fa
 ENdpSsix4ALBFuePX3rfVUMY46z3LUq6gF4FLOehT7YuZ4EmlT5/79O
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a58771 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: jyedRJbnGCyUJxAZeDp8VX24eU7VHx0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5bLUqn1UD7QO
 iotGSPQSISbvrfs+UUsyBxZbYFKwD4vhu6DYZ2AFUe4ZPhS2BGx+zXFe/j+4C+6NB9dQegaMziy
 LxEQYMKWWq8cQ918JzjrsTcoP0f8TZehf6J7SBXQlTa84/6/gLM7vKn20ktg7a2lNY9lD1t+5ax
 kL1BMR9YH4g8Sxmj7/CTskVtQ4SW/jTC7YwjzK6LmnVHXwZGepEcfDBuQlermIuGh9CZ1tVnJEI
 fjdistPkmrvvaSAFaK9tlWiqVcyM/UH8kT1yGtzDwIx6VuZN44C+8n6nu0F0W8flrOYRAO0NMIm
 SHI/iowhjWs62Sb+qV7Td2SIYDlcKBDfAUiFme/ZOJ2jjyuP6nWPmqPJ35zEFarhDmb3vQsuLki
 ATD25OC7hoaBZx3QPj6vpRdN6aUDyg==
X-Proofpoint-GUID: jyedRJbnGCyUJxAZeDp8VX24eU7VHx0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

PCIe supports multiple data rates that may operate at the same clock
frequency by varying the link width. In such cases, frequency alone
is insufficient to identify the correct OPP. Use the newly introduced
dev_pm_opp_find_key_exact() API to match both frequency and
level when selecting an OPP, here level indicates PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..4f40fc7b828483419b87057c53e2f754811bdda0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1555,6 +1555,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp_key key;
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
@@ -1582,8 +1583,10 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		key.freq = freq_kbps * width;
+		key.level = speed;
+		key.bw = 0;
+		opp = dev_pm_opp_find_key_exact(pci->dev, key, true);
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


