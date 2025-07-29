Return-Path: <linux-kernel+bounces-748938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF19B147CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF32F3AD869
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA224A043;
	Tue, 29 Jul 2025 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W6Br+ww4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385924A061
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767789; cv=none; b=hnOprC0j7wMcEWCm7eOT6qEOedbz+ZT11RYpMt+totmoqfy3pUCinXVatkuJ2BPPjJrRXyIMrdWHlLQ6ss7dbkkm1SjuwU3XvbSY4aAASAM/qXTqJXWLjnzkxmkPdjBiNHYyi+t5PNez1fPS4kpv8jmRXTeNFI7QUv6iEpNXBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767789; c=relaxed/simple;
	bh=OVzfN9tJRZeAyNzaEdIDWsZzTKb6T58kkVqG+1MZGb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uI4rOT5uZOGT05vXonc/QNQAgpbX8LoVyQqS1RrcVRPqjzElIQ7aQWa/F3+gwH3WSIDVr3MYo/CFaAQzfUN0nyUbauGYrls1o2MCjJCl1jOPRNukq4vsOUXloyjsdhrF3BONQyrNQvNpbnJ0qGAyjBiT2IeTXcpdqIapTya9Gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W6Br+ww4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLLSkI014586
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C9v0FM3TOSssawkz7WpmBOyhmNGfMtoTBWUwe0aU6A=; b=W6Br+ww4Za2nRGeO
	IhXMIeYu2y8us06J/PRc2keNsVRAui3G2VwwC7jWBSSvrpHqpdKwEqL62sN6q8qe
	NPorCNMEMwJJ8LNQwbXXR9LM9cKRsTEnLBVodP9ZDcm4zk2G8/eut+W3fuk7OzT9
	uh+KXNu8DBNGJqxzUcycgpaXHAEZ2Sk/DxME92X01k7zE5iICQ3BSDesBM+4jyEf
	qdWT3umx6DuKUBx3uiCS7GDVqZGSbAIJPXO+L94fR1q5fXbTNC52+1jQnkrG0yj8
	3EnoXI5orCNxrUXZ0bjVDi8NId3NWphujhsWasWbxeyuYfdReC3F4PJJSw9qim3d
	V8CzAA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xpvk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400cbd4241so21961885ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767786; x=1754372586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C9v0FM3TOSssawkz7WpmBOyhmNGfMtoTBWUwe0aU6A=;
        b=TYyx0Obszrpw/S/pruW0tMdmblAIZDHzUhAZilqijaxXmL3fEsQoVRbgoDqGeBg4n1
         PJDXrBO/7KLBDtao75MbzkjwkesaoQMsgvVZcWp6PKrN3T9nBoVcrOi1SRieKvmYUmb0
         2JoG6lstWxT/7LyuFRxsAbm/D2RL6JPwctfck6OCmlBUISa+uhxlvLqkdreAzGGSyNBz
         e9sUvkipggtN6Xdgj4mg1LiNGAuS+dJ459oB3oR+A8fNO36oWv1hQNrPFPM4A/qin0o6
         qPc2SGr/nhWz127FIej3qcAY7f74qpuKGMbFiOrldZVNKSqOf8wWKkcwenTifczAUXyl
         SVRA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8Wx/PPu6wuH1h3dsQlH0YgdSl262X6EOC/uRE/PmAOoulyg3TqexX9mi595wiKI0Bahl1yYqyF3qbGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuUPZtdJQfNsCp8YhnhgQxlOTM8DMDTtNpFs/o0DaFIIT64IG
	f2oq6LMMDGZcB2OsSBlXdBWMlLjso0wMmLXqhB0GbvH7sYNU+7JE/VGBoqCk80q2QS0WlyrFxCI
	DpCMpwRoGRTS5I2rw2UkAXvrwV0wKD64JhljedRJoPYwaiQ+/7+2aeUaMxaI90GlktTQ=
X-Gm-Gg: ASbGnctqhOWMWfboi46yH4dG4r7NJTzltVXQJ7eGfwtbNz2bxAUhcpbE4RRooQSL9P2
	3udISrkAFYkVGu+QLbIrGnQr1SAtjg25IaSTusk1TB0Eq2zlv7x3c5ku/Sd1wlIHAqK/65Lk+EY
	BJV6vMVuBYNJ1YPvCwVZspN7ZwUhUCMmdmvFQu3TjZIJzbKRnc81zXkJyg60sSLVk1dddjFpMF2
	iroU6vq+hCGzEqwjiNspDzBOu3G++mitZLRPdy5wswg30BdvvvyTq1cPse8pSfBd8O0ieMzeHJc
	aoKV/g5KSSTLHtYHJcKAYVmT+eiwjKHrST9Lop+Mb1dpZ6jQJqtRxaQsTTxG/DNe
X-Received: by 2002:a17:903:2f0d:b0:23c:863d:2989 with SMTP id d9443c01a7336-23fb3065e41mr207263065ad.3.1753767785766;
        Mon, 28 Jul 2025 22:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuKC49VBkZiHECTi9KBlMSNGzNAEaEP1WPkKqf/bdqrLtemg0XBkfBmt7Og8liW4pqUPQvvw==
X-Received: by 2002:a17:903:2f0d:b0:23c:863d:2989 with SMTP id d9443c01a7336-23fb3065e41mr207262815ad.3.1753767785306;
        Mon, 28 Jul 2025 22:43:05 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe9b67485sm54505235ad.47.2025.07.28.22.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:43:04 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 11:12:39 +0530
Subject: [PATCH v3 5/7] clk: qcom: clk-alpha-pll: Add support for Taycan
 EKO_T PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-5-227cfe5c8ef4@oss.qualcomm.com>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=68885f6b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9yNAuCQw4ehsCnPPvT8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: VXtGcKIHd83a-xzZ3lvxRVcKkJhDKDgJ
X-Proofpoint-GUID: VXtGcKIHd83a-xzZ3lvxRVcKkJhDKDgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA0MSBTYWx0ZWRfX1Q7IQuC1JnEG
 VYJYtMculi+KLG6j66RmejXtRoO2k3BJNe3HY9duemJ0kGeh7PVPZdoJ7S1wyxQbJpxD+0Qii2g
 LN62yV6PlN85uXpIepNyFdsSlYWdxc8JQkyqsEGdsjxrAm5vrC0+r6E5v4E9qpMxE26vNcY+IBU
 Ey+L9DXyPOJtElIb6SO0lXO6X71e0blKx3legBs/ZMG7FJtppjRKDK5uzH1Yf/e1RNGJYA6CFz4
 fEuSr8DQJKwCS/4jNZ4xsFAmK5mrUDndUgIQQJvTGpLmbc50gmQh3RVG18s9DISO6HfqogeGm9E
 nuplOZ+qeOrc1OFBOzor0EdS8a1CE2GMjjg587WwHsjNrF633JV8boLCyBL3FuQrHOp9jiUTFIR
 sjnSN8tDaRfjBxASXVqLcEpFGWoId+kZWmUjDTcwL73wOzNypUaoap+I7rR4FC65Vm4FnlBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290041

Add clock operations and register offsets to enable control of the Taycan
EKO_T PLL, allowing for proper configuration and management of the PLL.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 7f35aaa7a35d88411beb11fd2be5d5dd5bfbe066..2294ae99cff3253ac54d916ad0bd1d7e4146f2a8 100644
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
@@ -232,6 +236,8 @@ void clk_pongo_elu_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
 				 const struct alpha_pll_config *config);
 #define clk_taycan_elu_pll_configure(pll, regmap, config) \
 	clk_lucid_evo_pll_configure(pll, regmap, config)
+#define clk_taycan_eko_t_pll_configure(pll, regmap, config) \
+	clk_lucid_evo_pll_configure(pll, regmap, config)
 
 void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				  const struct alpha_pll_config *config);

-- 
2.34.1


