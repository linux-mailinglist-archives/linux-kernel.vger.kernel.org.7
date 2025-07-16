Return-Path: <linux-kernel+bounces-733829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D04B0798D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481137BBB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA928CF40;
	Wed, 16 Jul 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBSIobQf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DC245006
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679247; cv=none; b=px7PGcncAW8zixPkH/RQAustToIT/72Pvt7EJmXhTin310Wa45SRWS4SquByguxyGulAJ4BOKskxxBRNbQj+7xKfeWHN9RrnUu8poKH8ykJs+9SJdv/+sVxJxo4XgTw6yazhCktzNv7mEOBVj/W2liRn30wR6RxNq7AhEkvJ8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679247; c=relaxed/simple;
	bh=iSXFZ/rxSfqiYe032EgSZdLxuNhPgtOw+DCydKf66Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgcNMfHMMnHxwWvJUU1AYogMdomm3TUl86wCYY5+VJxEWg5iDE8GlIzJh7a3PhuJLgSMpA/ldxRmu3nHjff+I+b1hdqRzNNSuaH03z5lde9kwVHlCXRXQXlXKbrawp8FA78SIHRlLzUY4o7XpN4Sr9q9m7s6xCsLncm1mG1y7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBSIobQf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDgHtw018086
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KeWo6NhvYfL
	SpZC4i2L+Ou9NoRlmlKN1CvQ6KpYQ+j4=; b=mBSIobQf3aVJSci4MgOtVXV+25K
	RmvnH6s8JyyRBOKoao8r31UDEb5uq5oV3KJMtc/1mGHCJb+ziDvOB8fr20FWAe42
	GZpMVO4a0kMAuG6gjF5Ll7DyiA/TsN6cZJytLp/uRD35jrySa+vhZlK06tFfKDCo
	aj7/bPoX4eoSLwl1ruuecLyauCEG6CTyJ2r0JvCDChNC2rIMDnBfKvL3H65+vlLS
	mITlnRFq0J7jWt7O0YrPhDYn/2goL4vdI5b+EH3nL1F9wiuZ7XoPpGW9B3iDKVGI
	vC9yvIURrdUT3T36yzMuzg7B0CU++ASc6wajVsfAM0HXQd5M58r5MABKniA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug384kgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31ff607527so5394293a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679243; x=1753284043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeWo6NhvYfLSpZC4i2L+Ou9NoRlmlKN1CvQ6KpYQ+j4=;
        b=EqI1p9T0oPVMv7Xy8LKcs7TAgox2siJhjrh/TxJzk0XlLAcBO2ZjM1hTO3M2eEhAOO
         tjS0imsH+7gts/0j7tsOjwbX2XKgACJY6b0PoWEc7FWwFD4gzdr7NstnKVrFACtd/gu7
         DOFds+Yfud6t81Zx+LjZJgb9nwWuTrKV5V+Hr0tHrE42GTiA6RAARevtTY3L22Lk5bwt
         KC7L3xOIr40y958e0KITS+75h44r/wgidN0dQ+RLGjKc2TJcCraYspKSpCS+i16EIA9e
         Y/W05tKO67JxXAW3bY2MgXk/kgJ+gLhImlOL6wH7wUj0bAQgHxcOH8pW2IOyp2itUeYn
         GETg==
X-Forwarded-Encrypted: i=1; AJvYcCVjHfiMXeEzONzfMGQWrEh6Um6R5M5SBjE4Lv/+R7HYAfWYIXqStAjSCi5vmK0qNNF2+xgCPBwqU8pvK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Vw6AB3wotyL4xAFk1eCGu+hAptUycHmkmoDC7hy0y2ELPJRT
	JDHoZqaH6inn3a3bTvDntYtpltHkxDhU5HQ5JxfjBqIAZTsECAOPKe/IZ7E6IV+hvj9M8910I5u
	v9tgeLMUsb9hRjEDqAk68Z//ayxECLT3VhL5fioM6hft0IiAb6HG4tbKF1Ke17/PlaJQ=
X-Gm-Gg: ASbGncs0rNxFORYP1QUSChbDIHyjSWyKLN8fM1gL2X7RCmI171i7GBgy2DkNbzoqDlb
	sWbg0i/swJqKPVa1mkz4mzFTog75V+0cHcLIhYXcnRvQ/9xJmRnfmyH3uLNtCsHn8dB+qerfAMV
	0AyX9//JjV94QKlMzZeh3m4OqBofmBK55EL+cCYJSVXKQMLmbdKdh7kZsH0U3mL0FTySbfvGN4b
	u4QQKB8iu/Mj5rCvr9uCasHBvuBM/I0KtPkKd7e+vDO7DvqRjjFmJMw9BLi5lRuYP1UuIHRKJKC
	VouLmmhM5q+PA9Wg8t1vpMuie3aw79xHDJ8uYnNKmi7HN5uoLrFrfmQ2Ed/iy5828C82MSrhdLd
	rLqHiENqoBT4DQ7jnq4a1D/lHk1NnM4QyvVakcfWVSuM1THuvFcamElVze4bz
X-Received: by 2002:a05:6300:6d0b:b0:238:cded:d32d with SMTP id adf61e73a8af0-238cdedd407mr1274380637.23.1752679243316;
        Wed, 16 Jul 2025 08:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGalH6XH9sbSz8Z1EVkarL4o21D07/XcWEc3VRsCi3TM9BgHq254ZLszBRAS/A60P5dNPeUGA==
X-Received: by 2002:a05:6300:6d0b:b0:238:cded:d32d with SMTP id adf61e73a8af0-238cdedd407mr1274334637.23.1752679242755;
        Wed, 16 Jul 2025 08:20:42 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd8f8sm13912054a12.38.2025.07.16.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:20:42 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] clk: qcom: rpmh: Add support for Glymur rpmh clocks
Date: Wed, 16 Jul 2025 20:50:14 +0530
Message-Id: <20250716152017.4070029-5-pankaj.patil@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfXzTB/J7bmCgNk
 q7LdgT5rvBC5ejbm+cY8kCJic5luCIW5DR6IBle1JgQNi+4QpKHMWkoAwgPKBj87pXE9Ynwxufw
 IJuSp8bNw9+hXqA9l67aP+H1/n1OCo+TI3Ga1Ncjct3g9A+laStV2kj1zEkfqAQmTxLDCLdDoi+
 hJqt88opK4D3HuZ55llAHjtEQnYF70Z2XGUZQQ4SU3hRkF5XplUX06MSO/q3hUYFve4K1kPClFY
 MuMq0v248SUP7HeCIK4jeBr+bioPGXSYVLRoRHZGUP6gq5OJQzENRPP5DeEEFCLHSpXLmJYsbuk
 cWTfyMzjeBAHRHhkUIDak5O8ZWpgfLZzUBMOR5S0zqKpL00gcx+M6acoidW6qiviZsBDaplWSgE
 8IkfWlKMYFvBgq5ajonopSTXJZMzNljvBgNBI5ky20oR8IBR5ZbAdyLEXAXxWq3fQJPDg5ej
X-Proofpoint-GUID: LCAFQLgwEYM79Jea6BKkYaYTUQgCRfj_
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6877c34c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RRvC4NyyfoRIYhV0TvUA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: LCAFQLgwEYM79Jea6BKkYaYTUQgCRfj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add RPMH clock support for the Glymur SoC to enable proper clock
management.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 00fb3e53a388..1bc1333087b4 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -388,6 +388,11 @@ DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
 
 DEFINE_CLK_RPMH_VRM(div_clk1, _div2, "divclka1", 2);
 
+DEFINE_CLK_RPMH_VRM(clk3, _a, "C3A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
+
 DEFINE_CLK_RPMH_BCM(ce, "CE0");
 DEFINE_CLK_RPMH_BCM(hwkm, "HK0");
 DEFINE_CLK_RPMH_BCM(ipa, "IP0");
@@ -854,6 +859,22 @@ static const struct clk_rpmh_desc clk_rpmh_sm8750 = {
 	.clka_optional = true,
 };
 
+static struct clk_hw *glymur_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a.hw,
+	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a_ao.hw,
+	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a_ao.hw,
+	[RPMH_RF_CLK5]		= &clk_rpmh_clk5_a.hw,
+	[RPMH_RF_CLK5_A]	= &clk_rpmh_clk5_a_ao.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_glymur = {
+	.clks = glymur_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
+};
+
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -943,6 +964,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
 	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
 	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
 	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = &clk_rpmh_sa8775p},
-- 
2.34.1


