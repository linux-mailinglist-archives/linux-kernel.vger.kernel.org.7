Return-Path: <linux-kernel+bounces-766190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A9B24384
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B64217AC67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDB2EE29B;
	Wed, 13 Aug 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guteimpn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415532EE5E8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071780; cv=none; b=dyisXi9m4rLk2GLizVt17PTHZ+V7+IgEqk4h24sl8W2db5mcP9nsmv7Jb8T9nCjqpf7HFfkkyKrsWpVdmLfsgDhWa9VQfTjjAtmCZBuN9qKHlb8NvW4Enq42hxab6WUiF3llvH5qOgOtSsG6hmEURTS4EGMseokyl1J4MYRUyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071780; c=relaxed/simple;
	bh=h6RXWbyefgEVEM0BmVWVfZH0vo7yywZji3SwzXVLnjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFqIHQ3068vpXqFxAtOUsn6uPzBCPOXqvTaTW5SAiort7zEBBJBuVVXzLawEzb0wKmGNa6evqGDnDbIwMIe69eDZpopHSWNUcGM5UyuCJw4284QwEQc11yp1OX70rLBgXG+SXBCxCmFhKZLRs2AIB/z8KN33CLPVgUadl17aP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guteimpn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mT9n019573
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+lDsdc1O7kmdJsF/Ws/KKiaWnUoZYb60kkTYRbBrGPo=; b=guteimpnE/+mJBL4
	JCjnU3O93BWI6jGTgA206EUC7kouXacxGQI5K/b3B3av0nH8/XXl3Omndl3LYyzf
	5Yq3Ob7wq8AGJEtXd7u6nIAn78FCuSvpE1PWiDXjczUuU+IP+fmiWGIU4dITeHqb
	CjY6DkRb6X/HDrURAYCZ0+AOlpAbni4azSXjjoI/JUqvh+WOf5Xsso0+Id//7EYZ
	gHIaISg/nRtFIDN1USFxu1+jL2jNU5VnJUTCOxjA61MH2m5QcwEssOKM5XFf4KeT
	cW8QaA4m3+DxszwE2zJqffX7sXP3dzJBXe68A1mwyOlhDoIw3M3Q1Wg/GtUtJ/RK
	ztoaCA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6pv5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e26746008so164324b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071778; x=1755676578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lDsdc1O7kmdJsF/Ws/KKiaWnUoZYb60kkTYRbBrGPo=;
        b=AzZPtqdjnNw8uJdnUv2ccT49h2zY+sGzccNmYeGXAI9Ebg4m9ShwLDTGQTaIjjCA43
         bIw9t+mSVD1XdLJ5kBQXW9/Lx7Rsh4LHFl8dtgmWV9M2UFmo4/xa8KznzQtyKe2H1aeX
         raO/WFlhno0WNuksg19BufwL0Oeyxrr7XT12AuZXPMOg72/Q18sAsuqeP99U51uo6EsI
         ALyxUNz5JIkmRaNyZQVL98iqgXIzDdwvy+QEv0dT4jRpp+nMOtx0KbjnwnLPRvU2FC5B
         aJgXzhEArZDgBjV9lMaKzUBdJJLFTA/f8EvMXwCUzngOO+GVTv39ds7dXUIQ2D2nHD3D
         Zy2g==
X-Forwarded-Encrypted: i=1; AJvYcCWKLe6o2HvtOsff/gVrCl+/0SDKHh6xZr145BuASpRf+BrbV38/NXgmS10fBBNqUYS5YdqsZkGaLf5u89c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pHMyRLNHFlsK6PEkOzjrOIzMTitJlIL0SplB+MF94aS4RxMY
	YuRZMsMAage2dgc7WGjSoxhvzfLb9HhdO/xIh8CeVup9nAGSZJtNtlNw/JffZr92D6rG21maSzE
	Yh8SDNbxrQ8cw2Vs3unwzwd/sCuqpn3dQ8VNcnJKEIZdifRJgK+TpcyXfhxpB5xgzLGA=
X-Gm-Gg: ASbGnctfqpY1xjLtH6nCfMwM6JiPIedTBg/XKQ4kYptDKVC4tZNt2KUhrz0rKji+OXA
	umInR6DNusdVDSNBV9p7fFWr+X/tiN0VjtuY8HpzkTeeJ51EqfL89lm3V3voOtNF1w7aDK0bVci
	KU4lfOoPMb1exbxgpUpaRuOFulptG4CxpgmhlJIuaE4VEbor7+6UI4DYvmA1wnh/lajfQr67Nf0
	RIp4fVzbcE2/0M5Rag5spHCCjnybcDuBqIQckz8rq1CeAFki1Ln984Fe7PFNBG0eiXaWsLFQe2O
	P90sH6ckMLbUb8IWet3nW/14cQZY1Pyw5btE+c27bkW51B/uqUrTFeYyozUj/k/g
X-Received: by 2002:aa7:88ce:0:b0:74d:3a57:81d9 with SMTP id d2e1a72fcca58-76e20ccfc49mr3549426b3a.8.1755071777726;
        Wed, 13 Aug 2025 00:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFKkn8Vd5JoUCGsjs14v7+Q6viwxTdxYiK2Y6KCGicQDC35oxh/Uki/eSQtb5LsQIxkyRZdg==
X-Received: by 2002:aa7:88ce:0:b0:74d:3a57:81d9 with SMTP id d2e1a72fcca58-76e20ccfc49mr3549399b3a.8.1755071777282;
        Wed, 13 Aug 2025 00:56:17 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm31395754b3a.65.2025.08.13.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:56:17 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:25:21 +0530
Subject: [PATCH v4 5/7] clk: qcom: clk-alpha-pll: Add support for Taycan
 EKO_T PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-glymur-clock-controller-v4-v4-5-a408b390b22c@oss.qualcomm.com>
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
In-Reply-To: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX8LFDjs1mkc4G
 /32xHoaBZOh4lxHi8dyrzR6JGW3vkPOV7Mn+PXuvsjprv6FxCJDhKd4T5JwuIwxTwguTPGQgxkW
 85hUZZtB9x7qP719Kp2sPS2iKqh0DhYvQw5RS3dK+l1AOIsHlAhZxcztuxbNIf8Y4FJYqNDgW+j
 /qftGBQ64f3LGTKwHNlvrBkPNerX9OlJxHW7swTkdzVtPMDCQxnD88Kb02mR5H+K8zka+hj+e22
 9tOewQNfcSsl3GRchpZRYbgLc7KeVsxlYG4YUc8jMB9yBBCYPHmFu04HcLVztQvd4TcRhnL3m/F
 CaXrxftcfflkG6m4lemnY6iFKcx8D7pS24iP7nw7qF1flf2tghyWsyrMYf0VSb38yCMjWp8WyIv
 5X5rGYK8
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689c4522 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9yNAuCQw4ehsCnPPvT8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: C3xalBC9Qn6lG9Mi07mYOifuv_qkBGmH
X-Proofpoint-ORIG-GUID: C3xalBC9Qn6lG9Mi07mYOifuv_qkBGmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

Add clock operations and register offsets to enable control of the Taycan
EKO_T PLL, allowing for proper configuration and management of the PLL.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index ff41aeab0ab9844cd4e43c9b8e1ba0b50205e48e..0903a05b18ccc68c9f8de5c7405bb197bf8d3d1d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -29,6 +29,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
 	CLK_ALPHA_PLL_TYPE_PONGO_ELU,
 	CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
+	CLK_ALPHA_PLL_TYPE_TAYCAN_EKO_T = CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
 	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
 	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
 	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
@@ -192,14 +193,17 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
 
 extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
 #define clk_alpha_pll_taycan_elu_ops clk_alpha_pll_lucid_evo_ops
+#define clk_alpha_pll_taycan_eko_t_ops clk_alpha_pll_lucid_evo_ops
 extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
 #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
 extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
 #define clk_alpha_pll_fixed_lucid_ole_ops clk_alpha_pll_fixed_lucid_evo_ops
 #define clk_alpha_pll_fixed_taycan_elu_ops clk_alpha_pll_fixed_lucid_evo_ops
+#define clk_alpha_pll_fixed_taycan_eko_t_ops clk_alpha_pll_fixed_lucid_evo_ops
 extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
 #define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
 #define clk_alpha_pll_postdiv_taycan_elu_ops clk_alpha_pll_postdiv_lucid_evo_ops
+#define clk_alpha_pll_postdiv_taycan_eko_t_ops clk_alpha_pll_postdiv_lucid_evo_ops
 
 extern const struct clk_ops clk_alpha_pll_pongo_elu_ops;
 extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
@@ -233,6 +237,8 @@ void clk_pongo_elu_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
 				 const struct alpha_pll_config *config);
 #define clk_taycan_elu_pll_configure(pll, regmap, config) \
 	clk_lucid_evo_pll_configure(pll, regmap, config)
+#define clk_taycan_eko_t_pll_configure(pll, regmap, config) \
+	clk_lucid_evo_pll_configure(pll, regmap, config)
 
 void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				  const struct alpha_pll_config *config);

-- 
2.34.1


