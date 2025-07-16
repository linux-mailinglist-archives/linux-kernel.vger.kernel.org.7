Return-Path: <linux-kernel+bounces-733825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2147EB0797A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA17BADBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16228A1C8;
	Wed, 16 Jul 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTPZGPzJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8423496F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679232; cv=none; b=i71C/CrIHepI9NWzWGmfyu7Pu7x9s0sqWIhMme76Trzk/uoYZS7U88Plfs0aoeJ0JAUKxjI/fNzPejQHPf4EpnnjtzR79a01iMb+4nhDmPf3APJIO46AO245eHQlckgWHBHHc5h051z3H7SYKM0VQAssJvmVFBMuC8+05Y3vt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679232; c=relaxed/simple;
	bh=BI6qVlMF3xOeCX9WCFqLZh1Xpl2v5uGPz6zfIO0mzlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nM+LJia87mDcm8InK7zjERp4PLoQfTe557L0dfxHutudmUWsU6twmpoeNA94+WIZaoo8B1v0tdPPgTL142Z18xnb+I6dRC3X8MWRV2B0NyrfRGLIJvMTAjR+UACvKBDoBuL/X5+BKrgwTOOqMnLXSaOaW/BC5fU0G3+5KXpT8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTPZGPzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDUBFT018016
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+zNBS1PmSdDbKE+Ml6xSeir27yoPaFDEr7o
	sJk1m7ps=; b=TTPZGPzJ2Uql7GDggLh+Hp9ps+qhB1w07cCZiRPLWhO+rZIU9pR
	20Gy7YRexSpfaRnr21+qKkjYcdQTJm3FdQJKUJmGPw+LiUgT9qeRP4ATg8zXrHVH
	62nP8BpRijb1m7YDaDLzWrHwYMiC+iKegA1bk0eNMwbkElM6NkoZdthWNIBqDLkP
	ufzu+nDyscZp4IsC9o7wtlIhNvqAm904l6TtRi5bHWM4Gl6KgKU8Ws8mdXLXnwb6
	6N/FGx1mD3ngoqgipXN8iSbntUmEcC95UDN1CVpxsDhpSMuoqO0F++YHrDa2g3gL
	jCDS0Y6Tehe0xEyQm5yb0lWJ5tfixY2ihlw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug384keq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74ad608d60aso32513b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679229; x=1753284029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zNBS1PmSdDbKE+Ml6xSeir27yoPaFDEr7osJk1m7ps=;
        b=M6noxvDigd1a/01IaPNX/0GTFr6whLU8PfywrGI86H9b6bxTZBOxup3q4emTVdyuV/
         zGoPQzQ7BfUtiQPmkl8zztzWqcDF3MInCqMkWvrabmuU3sPYIivVYzif8niF4eioWp2Y
         KAFJkQwQPArOTwdtV4rMoHmFXexYQTQBL57T22Qd1z2TMVVv6f2bBMkrCl83qXreI0ue
         Ji1PkRMdsfzwc23T6EOeNChmXXDFlnBHIMz4+s+OfkCiRylQ3vwI15lu5gqHioSOf/qR
         Gq77boyYT4uOSxH0Wp25MYI5QWEuUIbtRftee3z90T+00fqz7dkd0ps0w4PEDfl11q/k
         6nKw==
X-Forwarded-Encrypted: i=1; AJvYcCVD9++MpYh5fOcNOe4uJhFrZwov3dKiV0SWlziEn8yCW1i77jtyKDmwdswjFpl8o3gNzv5ixoc8u7yYR/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduzznWnnVnxm7E5sP1zWY7fnnVV/VOZJSpUELdrevN71q+TXz
	PPpI/UQWFt8PsOSB79CnivlSuodSLK05pf/8l7O56fqz0xMrQ1bbEtrBbi/yn65OrMNC3sHYzLZ
	jZzD4kKRHP586vzrNCXHD4qMWCwIyu/ytVhqraQS7cF3Ujs+EwbstvuTQ/STz6ehvDOs=
X-Gm-Gg: ASbGncuJdn39XJm/S//i1XOmBj+emnitchSXWrl6amx7GOWiRjXnTrncJddpIPnC2JN
	+u+fJvElZwdfVfxDziVXZ2Qce78fvpJQskK+3ODJLZ4T+W7Ayoo9piTuO0sA4Cg97xREfXAJrN+
	uzpFbZDvscYw0qCunK0Vx05J2GQeLrELMDv7U+gclpYTRBeE6QELl8P/VmqWI/+92LgmbDPTUoP
	O7W+k7wvfRZNwcp4PWTLqOl/HRAG5yguwy81CwiioKfjpsB71Itky8U7pE1t0PXBwkTyqMXZrFt
	EPzqPPi34Lv2bZDoW0bB2HmHpfg4mkhBvSgYVcJscTARTdLq3VREJCWtuPO5VWx8I3D8WsqWu4D
	jAjvFL3Ck48b6bl7u0762hGWulNH0RJ9hp1LwiCeKv+TpTGnzCzKRcCej6QS5
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr4639884637.36.1752679228829;
        Wed, 16 Jul 2025 08:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKwU6o+tpWlwEXgv5gzHLfLU5Ajgm6I1bD672WOsYEy26mbRK7YPdMqUcJVLXOeBXYIhuUrg==
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr4639840637.36.1752679228388;
        Wed, 16 Jul 2025 08:20:28 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd8f8sm13912054a12.38.2025.07.16.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:20:28 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Add support for Clock controllers for Glymur
Date: Wed, 16 Jul 2025 20:50:10 +0530
Message-Id: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX+kMHnUW0zOHd
 R+ubAyj+RGgx5rTBjy4mfCMTCqdz4MTh67ORGim4H1ZFvEn4PLZgMhkt/qbCh/54IW3NN7MQRwP
 GY6+YmnW9woHjUjoSrgJ2Ri7fcjz9hjrRA5RP/koW2JBOEYbwE4aATg37yeAwyoY2aaD5Q3DPPf
 f+i/LzCzqZO3ryQVzzuascwW5+xQ98/qo6uwRVOIQX2eyETnGqtJwy4AToD9r9ZaYxxmjguw+n3
 TAT1IBNkoB+Mukbpk2uAF2t3qqfTHSjEWZxwoH7xPeD5k8omjCNNIvl+HyyOxn7EK6A6oDs1dxV
 i/zdAu0mrEs9tcFxOFZgt9g/hMUV38RhF4ipkl4CGzZEiFelf7yHc/Vq9H04xln5R22GfrnfiQP
 Mih5AGaeNlUiMw/sZr3fM2nQS6XGu7/AaUEqL1jP+6VguyjXiRxk0oYZ279zxW134dDzc7t4
X-Proofpoint-GUID: RpDHhhKYo05N3aGKS679q9x3QTN-KAQO
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6877c33e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ur2kyboyjIJ0vDSx390A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: RpDHhhKYo05N3aGKS679q9x3QTN-KAQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=969 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

Add support for Global clock controller(GCC), TCSR and the RPMH clock
controller for the Qualcomm Glymur SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (7):
  dt-bindings: clock: qcom-rpmhcc: Add support for Glymur SoCs
  dt-bindings: clock: qcom: Add bindings documentation for the Glymur
    TCSR
  clk: qcom: Add TCSR clock driver for Glymur
  clk: qcom: rpmh: Add support for Glymur rpmh clocks
  clk: qcom: clk-alpha-pll: Add support for Taycan EKO_T PLL
  dt-bindings: clock: qcom: document the Glymur Global Clock Controller
  clk: qcom: gcc: Add support for Global Clock Controller

 .../bindings/clock/qcom,glymur-gcc.yaml       |  122 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml      |    3 +
 drivers/clk/qcom/Kconfig                      |   18 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/clk-alpha-pll.h              |    6 +
 drivers/clk/qcom/clk-rpmh.c                   |   22 +
 drivers/clk/qcom/gcc-glymur.c                 | 8623 +++++++++++++++++
 drivers/clk/qcom/tcsrcc-glymur.c              |  263 +
 include/dt-bindings/clock/qcom,glymur-gcc.h   |  578 ++
 .../dt-bindings/clock/qcom,glymur-tcsrcc.h    |   24 +
 11 files changed, 9662 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,glymur-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-glymur.c
 create mode 100644 drivers/clk/qcom/tcsrcc-glymur.c
 create mode 100644 include/dt-bindings/clock/qcom,glymur-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,glymur-tcsrcc.h

-- 
2.34.1


