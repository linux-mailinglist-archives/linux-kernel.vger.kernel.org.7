Return-Path: <linux-kernel+bounces-831347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C39B9C6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EE7B68D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C8298CD7;
	Wed, 24 Sep 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXdBWdL/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40462C11E1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754756; cv=none; b=JxYo/pIEV17NR52fvNQzVPhNT5ttNFGNuRKzS67VcJXXlLY4BxLhQc+NRfupFaVdfsFabV/YTzIkWYlQy3wMLdjRUlmfDbyPHX2UfCUiL20SmXsUm/ZHKf1rIDyJLe8zOzl09okw/2W8q7JhpZyrvWB4osNZsr0o5hUZGesmaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754756; c=relaxed/simple;
	bh=h3aXo8gGx1W7ssER20ULEPl8JN+Bc4212thlS2Y7qbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaNYlZSgQwzhYQ2NkCsxbOH8oIVwcJ6KufJ4Jgf8fVd9Xw1RDziQh9WgG143sxTWqYN0gKaqoLR9hsWry0V2ejSgN4WobtJLV1Ohpvuol0m1oNIqcO0UVerqWcXQPKQoNcoOUCsF1ku4LF3jMwd/kF1Qd4Qrk2kSef96kaI+uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXdBWdL/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD3t43018716
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ByfRBJ3QzPSQA4bVlLf4TGWf7Fa4oINCyeRkBasNj78=; b=WXdBWdL//DfAsIg/
	8fLd3Ycr6NKyVx+VZAsk8DhlXPKanxfr2QLPwxRY/7000Y25nQLS047aDaB2bYR8
	jZgYWFlOHBlq89rrr/OHEvVTsi/hCkqV+XFTEinSmBwwiGK4cB1kgx+fp+fe/1iN
	uWlMfC0OrQPOyKtukcH8g0e5ABaEmrBlbT7wYjYYtF9klwMfh8k4zA4ks+3Y8Xp3
	9mGoCx9sLjxxCrI7k0nPWoksCRpikrVpkCnT4vkXnjZx30IIsu/usnUk6yCAIqsx
	WtFiQPAUhvYxoLg29HMRWF5K7FScRLBCn7vaLa1hjqIGrldjGVtqTKjIi2QsMfrm
	jEyqbg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjya10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f7238196so237132b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754753; x=1759359553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByfRBJ3QzPSQA4bVlLf4TGWf7Fa4oINCyeRkBasNj78=;
        b=VcsBiSogaFgyx0eFZLQ9MbUJJCR9Ja3gIBJ5HGfJMDy4Uv8vhp9rF1DgGBhYxSR1k3
         QXmDoV4uvoYMqDCc1z81Q+IM1b2uYZlF5N3BO4tJLlxmjQtgM93nkoqIkfpbGxV5kERO
         7fHtAiGTSXI3MahWAzCIMFjMYV8b2LcCQR9miqxEAoR/Bxe05vC2NYZAeFFn05ZXomVC
         q/iSF87zFags44349kGOsApdxECRndNC4QEHB1b8mgBHRtCl57+rkl4Bk7Gj+Afx4t4j
         yr7M5Yu9//HV+AJhGOXshFiqNSxcppju5T18A5IE0GYikiV6sqtfUdnE7/QpiAXWxCRA
         DoTg==
X-Forwarded-Encrypted: i=1; AJvYcCUNRzYs4dT7SmRYZGSFvlhc9aFZhI+heFaSauIsSEX/jCn9hl0QqRaZG2W0hQFRkVlwKkf1Y5sSiTIVDJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/g3xnfMYV5XgmflMEfPgC4P5oiQd87eTz2etz+tJNbZ4kEXpS
	8Xy+zC8SzmTlUEZxoyXB07ZJDcalfYofo1nSHVWRf4jluatKtGLqesWN7nZd9CvHirs8Y9umL7N
	a1zx5DpqXrVBYUHuKiR6QgJzHkbmVtj/lSdKkVWDavq/uK8dWmMacHeJlzMHy/zHfmag=
X-Gm-Gg: ASbGncsv9voqX+Udi+e0ke2WwW6ceEwtpDJuT8zhmNS3DH/IB+9r8vw0IchaV/XXTLk
	ywwokDlx1bgf/emTNhhL0mlro9SJt7gdl+ry5nNx+r9DewAUAKex6XwgQAEcit1wwXVr7Fb0jkv
	Wl07C1emuvFLJNtzGAK1Hj6WE1Fh7eX7p8yK2/iW6bSVOufwQsOp7hKOGiJudiZMRX26PLbsTEI
	ThACxxfr9mI+05q6Nzn0R5VuZYTM/oS3r4QZ/gvRPMdtwkUvMJJBQGpzwmJCjtcbKpy1/CuezGx
	09BOpETHJu3/1ks7qHU2qnK/jF860xZ8/Ly7xZFSdQq9c60dLZT6P4fM/QVIsYVF6MgkDaysiDS
	/+NIVTfcDpEHSHHQ=
X-Received: by 2002:a05:6a00:10c5:b0:772:63ba:127 with SMTP id d2e1a72fcca58-780fcecaca4mr1698967b3a.24.1758754753354;
        Wed, 24 Sep 2025 15:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7ky+fClkXFH/Kaxiv70QhLi13A/NgHtdlkjNuoUcOpx7OOMcYuTiwTYaHMjyx0W3NFt2SA==
X-Received: by 2002:a05:6a00:10c5:b0:772:63ba:127 with SMTP id d2e1a72fcca58-780fcecaca4mr1698946b3a.24.1758754752940;
        Wed, 24 Sep 2025 15:59:12 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:12 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:59:00 -0700
Subject: [PATCH 8/9] clk: qcom: clk-alpha-pll: Add support for controlling
 Pongo EKO_T PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-8-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=1266;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=wAwwSNhqWv9UMGVgT4Q7NntYft+jx5vU5Cz4yXJ7tzw=;
 b=Qztnxq9oO4fOqtbsXDxFI7CjJjEDUJtBNKxFjbPB259uGiulSpFuBBAg/v1S6ON9gLTFyJRuF
 pCPeL23gVWuAhf4li0B4p7hA4ssDdYgF45xj3BQ8TQEIawZh42UB1sj
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: wVOCXvMFA484UoELsCMoHHNm_iG6UCif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX/IcUAUo79AkJ
 tWGrzlEesyWvIGkewgN4s4hSbpPe7Nz5dzj8ePNmh0zkoBNfqEso6qgMR6tvpesRPA8j/1I1534
 d1Uj4bWMXsjnB5qOgH468UiSqy9KGKgE2fjnUdc0nYnPL32gW43Cl9EKfhtibrmt8uxaPqP9Tj/
 lpP7hKn1BFpDPBdz2VyV8fQmXoA+CFSC86DclZR+s7qQMRGUnFSCblosSp/VjwGodReNPePWBBW
 qsW8QxjrNKpExhMkhel3/ytXInJsQIoFV8e5ayjIJxK4CbCsE0YaXv0TNiWJiDFYQzPFAjfUFLn
 qn7UYH+uOmKasC4wPF0ccM6+R2+JVZ/JMEROaZYt+NVDx37KwsMimHVyTp2SHKME4bd8Ma7VS+L
 1Or2/MsC
X-Proofpoint-GUID: wVOCXvMFA484UoELsCMoHHNm_iG6UCif
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d477c2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=rVs2PR1jS8wsPJa1_kIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add clock ops for Pongo EKO_T PLL, add the pll ops for supporting
the PLL.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index ec5b4e481030..fc55a42fac2f 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -28,6 +28,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
 	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
 	CLK_ALPHA_PLL_TYPE_PONGO_ELU,
+	CLK_ALPHA_PLL_TYPE_PONGO_EKO_T = CLK_ALPHA_PLL_TYPE_PONGO_ELU,
 	CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
 	CLK_ALPHA_PLL_TYPE_TAYCAN_EKO_T = CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
 	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
@@ -207,6 +208,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
 #define clk_alpha_pll_postdiv_taycan_eko_t_ops clk_alpha_pll_postdiv_lucid_evo_ops
 
 extern const struct clk_ops clk_alpha_pll_pongo_elu_ops;
+#define clk_alpha_pll_pongo_eko_t_ops clk_alpha_pll_pongo_elu_ops
 extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
 #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
 

-- 
2.25.1


