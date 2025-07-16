Return-Path: <linux-kernel+bounces-733830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A3B07991
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED153B6AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885DE2F2341;
	Wed, 16 Jul 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lStun/B9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E812F237B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679250; cv=none; b=F9ZgEBLAsIUfCUkrqAymDcrSY/l5e3QfMr7J2ZQw7qf83RznCvIzra8/I/tGaWtszrjeT4pcN1m++u9abhrnLRwqozNwZ7HoECEAz7j/zV+4Qq26Utlu7qr2lpOvKDH9qvQQiyAXJ+05IdNXvuyOGw97Z2X4qP7jT4fJ9IEr4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679250; c=relaxed/simple;
	bh=6JQf4O8NMe/CubAcA+bvLEOkTG1XpMAvA3q5EVQGE+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b67R+Pt7y5nam+rrH8ZaXNigSJL5ghgIkLVWJzeD00Yn+SWjQuOgekfmWl8KZMP76r+p7DMXGuhP1j94zry5es5KwjegC1XRIvVPqWT88hse2swCjL8RMeeN0wwqczbQs+4myecmpd7akyjufA1yDG8/t/yARlC/LUO7Bj878tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lStun/B9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD1dLf011674
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i/UzvBI9fx7
	W4AtWjhd/P7aklE++DS1Rd0idD9jTzhc=; b=lStun/B9UnbPZcXc8vZVg0cFYh6
	bseqFKGgZJ2vt8SpuVcL3cbx2BZ7f9hDpYRd+++a7fWwwNxkVjuCN/i5ViazOzE/
	eqFszgXfrOK8yill0nmrbz3YFVPILOgNo7T4SPRVjYPoucqts4m0oxn9jK7HGXvk
	+FceQ+SNuzxRsrtC83riYIlAQCGBqA4XLl3fnRyItFaIhnOKN7LX6HoBhRW4E82M
	T6XFx8B9O0PNuqPBS117+Elxb/P3N81CEMGl50oHJ9LEG0dOYx7/2S4lDc0kpaHx
	uXO1yNSOwyYV//E/3TJQiK70U9Cat9HfAzPlpiriN1wHOThk7oiqpG3cYJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb4gt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so22102b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679247; x=1753284047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/UzvBI9fx7W4AtWjhd/P7aklE++DS1Rd0idD9jTzhc=;
        b=voZu56NpfoeQAHzDJAXPB6ddIZYK3FYWlrcDUSD158DIQMiw+hHK/LYizGt+TOpu75
         c3M47O6yKx0A/Ru/MTCfLgBnnTM8nMIuacsMUS6zs8oojMp3SkIMwdilMePxIyr7OyB7
         wzPqSgFitXkWsF+zz2MWkk7Qe4VANpswylvQ4S0GYWbT8ofWhkS2NmNxbDXsiX216yxJ
         RMJhJgKfACPsXUrLSGgtJhyhu2ajKO3G6NhySwbPeDejvouKYXL306+nJ/xjDlpGB/ry
         pJtZO3VXbqXlvo/YwFkuTFCAKKC6Jsr8yovXjOJRpXu/1pmZoYRjoj24vLpGBQxjcKoW
         RukQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAX6XJ6eQgm/x1396ZeJCPyMCJuNTc0pTejY9mP5h421uLyQ+oq4kg2k8Ead/zD4CquACQNlJ6QwgK04Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFVxYWy01PEW91JVeH0qyRsQmS2/Tu82iOSU3jrKXk71vV4xC
	vVUbx7W5/H6JfXKEICVM3iTDZz70PeeQkdUHHzScl1sWGlbGcuWSZuVqxFA0NDhEfojWTHkS/lF
	Qc6RY7AEdkTQQloJxG8hM95sWJL3On07tD91xCLz+JcdB6AmNT8085ELrO3sgAgLI0vo=
X-Gm-Gg: ASbGncu1eDNOxhEaRRMAmQVYYdKbNGKYbgPUIKalBlD0Prk2Rqp0u73DPxXJhzXgMzC
	zh1/UWK5evccMBfVCz/CFDbm9/ycAzlfxEwmBS82wDEFUA60621k3ZgUQUW/0jqJn9Njs3vZ6qJ
	gqVT/pChhb2hnDRqDIHAYbdb3geGrdsnImb/ewQmw9bl+z3DUd4FZT0XpEFsk9zT7bWzZyejNX3
	YlIgwWR+ugKqHXBAaH9/5fvW2JXzp1TWTAFlDNuZdMLesSccm5XHg0moYyoaWDlXX/nEvyJG6+h
	jLlKLM3cwRgP2Bf3+fGE9niFzolEqxAGDw5TgqaoLTmoMja8pX3x4Hw54EQhFDpadtTUwIRvR1z
	NRXr8r8qtq2BJlM1lNT0aMKvZegJ3kcwdQD6hzPAhu1y9ZUCeCoONY8GP4jgG
X-Received: by 2002:a05:6a21:648a:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-23810666ffbmr4906026637.9.1752679246751;
        Wed, 16 Jul 2025 08:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKLc+0bFiDHzoomsqf9Ui03eq/1TMOrYjYRIlLvU0csjZfUBwRKUHtvMxEGuec0rVMcA4QtA==
X-Received: by 2002:a05:6a21:648a:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-23810666ffbmr4905980637.9.1752679246306;
        Wed, 16 Jul 2025 08:20:46 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd8f8sm13912054a12.38.2025.07.16.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:20:46 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] clk: qcom: clk-alpha-pll: Add support for Taycan EKO_T PLL
Date: Wed, 16 Jul 2025 20:50:15 +0530
Message-Id: <20250716152017.4070029-6-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IhGNZW2B63d_-2C-ICXftMflMh_ghqYa
X-Proofpoint-ORIG-GUID: IhGNZW2B63d_-2C-ICXftMflMh_ghqYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX43u0ePJ1a/6D
 nWSkIjvEa4t+aMRuphc/5B/1Nmc0CdySGZDzdbA0PiibmfVltgESYBOUsUJZXVExoeXMaY4E3wS
 vLvJSFRW5PL0LapPctZuW+BQfF1L3XnT8lRHhkUtdEgMbjgd2ZhPiKnChkmBNxU2jET3chpwign
 /LbhIYsfh6VXgrjB2dTJpdgQAwqVSNfARJjrroasFBH1T2DDd+eFEE6tL/c0JxubWqqVTDT52Wx
 JgYzQ7PM8j6x/C+0f8HJt7Q6VVDuvNkBfjp7fZ+FxVHfP/1zHm8L2TBDQW4kKlb7EP75ROJDyRy
 eUZUndAa2Lt5DD8qa0acE2Jy8M/eLpz5e2ODnaucX4u1AUSRAx09ZzEmlRcmsnppQXfi9e/Menw
 K1OH/ZthxWWX9aRItlRHg/tS84ZBeiCYzoRq7/6tzgRiImwtoTXrgiFJMeb06aLzjcr1RDQu
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6877c350 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9yNAuCQw4ehsCnPPvT8A:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160138

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add clock operations and register offsets to enable control of the Taycan
EKO_T PLL, allowing for proper configuration and management of the PLL.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 7f35aaa7a35d..2294ae99cff3 100644
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


