Return-Path: <linux-kernel+bounces-766189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BCB2437E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8AA175E39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2B2ECEAC;
	Wed, 13 Aug 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAx/xH4z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EA2EBBAC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071776; cv=none; b=m8EtCKixalOG7KepH045NecwQ0dy3rIOJ+7O6doXrN3wrV8NZD2zJReUv1tcTntMBE0beWzj0fGfCCaLXNwXPab1kK/6iMSu0pnbpBNu3wTcAnYgDZn8hUL7ysg+Ru++xa3FNphBGNhlvlwqvSlmwQrkVbr/qwBFkPZ9KaDn7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071776; c=relaxed/simple;
	bh=FDFmyZKa0pkTnpfh3lvXqBBbnpYAA44Z0esOGRce9KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLb2NaJqZL8WzdqEl1HhOq/7QBPoietmFPpd/EaN4MMITSEGv6fmOZJIcCBiyEEHIiW2KUZCyLzevmA5ENbL/GdUBO231vxsdgqvYjb/fVzvDbiYwNzBzSI7ZqSRgH8ag9AnoJbiWB62dsTrbOf+YT0um5XsyMgtsCBTGf00kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAx/xH4z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mSDM015791
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2OtLDA8szClKkPLVd5ZN5FGUomTT3SHfStBqaqleHUg=; b=UAx/xH4zlUaVAkpj
	uc4HuoEYPhSSgjb4Am7xYWuHmf9Z3WejXC3wmBLWK6utZRBnsGzYTlmk3Ih5/MV7
	QlDDlSRYzyGVsFQXJFD7j3zFuhu4u6l/kij4bbb80OEMtBZxqMGR7bH5Lz7BFRIB
	ITsQaZAR/Gs4cudlhEueggAPHwgb8r/686uWTeSlunweQxZHRqIw9587du5JPzOL
	6PzoGF4+Kgw42+XNEaZpgGspOGSHzR0UDWO0SgrR1t+rJV9Ow59ej6j8zOHmpi6u
	PlbKaqhLSG3P+sI1s/zO59lqOrpmVziiJKFzLh2GokXwhFRnyTOR1vHL+T4DTOlL
	YO57kw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbe5gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so6147749b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071773; x=1755676573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OtLDA8szClKkPLVd5ZN5FGUomTT3SHfStBqaqleHUg=;
        b=jqVFLafRf0urSoSwvq/T3alPgAI79JMIU70PQdHDtayH0T6DBbxGB0g/XYBISVweBf
         J3PNibnucLmV5GJ+mdSf61RTKLX0c//JCWb6TVdAbYLnfpxpNtK4j9eJRYDDot1uY0MK
         hjKk2fZeYxV2GQKmh57WL3JVuW9l25AhGXvdnP5hjwsFhJEaDXXKI2TIGGskRSrwVTC0
         bNlA4HoKlgM+oeyGgoUoPd7gOw3i9mjcJ63vwT8/BG4CuTa1HsPQHltk888plcybWcV6
         7cAq5sI/cHRvs9N1pH7c++owH25IGncT8BOku7lhViEw57wrMsZqtGdLYp5w4y/KFcfv
         Gjlw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRnkgMyuAch5pVN6AfGjdcQALeiYahVSn7KasC8MqQy+UIRiCEO2uf95y81swJU78yPaueblLQvL5bVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTXtJuXvPMg8hiOJ5xV/x2aAKo40sP0+73XEk/lwrHkUdeRkc
	Uy1IzLx9H9M7HVJ+DE97cvKcUdSJcncP5W3NoblXDkmf3u+9hrdQ6oLXYyFkW9YEUNunLId+fWZ
	U+Jj0BtRwtDRzwXPizpZb7erB+n/MOO69nRH2/V2vJWdFt8Gocc7xh3Xf+g5KMvxXcjM=
X-Gm-Gg: ASbGnctKZoRLyPxzgOJi7QUV1DlP7hH4w4GryofTWpeTUroseILbrqNfdYi7O77WMNE
	qHcM0LS659I9C/8R8aiYuCTI1+Q0BViH0+lbXqxbSl0kRRnKr5dbUZ150N2WTtbBT6t2qj4A2Bw
	5Ln2Hnv8bGwR2SWB/XN0wYFnzcNSkmsPrxuesS2tx3fG9OCzS6FDPAoXNmw35RBuZuNnaFhsWga
	UCHrXeY9Qnl7h7wf55xPt2LkyRr69GgAySeREAo7TMBpYovzPzpf9g3EXfr9W4xbsLgdGXF2tOu
	I/9X/QGgtSH02sm2YFmsc3cX05ayk07Vkphx+pMmbz5vmJc85SrlpnUIPksT7Scj
X-Received: by 2002:a05:6a00:1492:b0:76b:d93a:69e2 with SMTP id d2e1a72fcca58-76e20f818acmr3372636b3a.19.1755071773174;
        Wed, 13 Aug 2025 00:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgKQmjdlT8hx0GkhErVH+MkRlpaJID1vtl2bTLhbL/jf7nb5EbDTpqOzaW/6jMYUTl2/rtmA==
X-Received: by 2002:a05:6a00:1492:b0:76b:d93a:69e2 with SMTP id d2e1a72fcca58-76e20f818acmr3372599b3a.19.1755071772697;
        Wed, 13 Aug 2025 00:56:12 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm31395754b3a.65.2025.08.13.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:56:12 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:25:20 +0530
Subject: [PATCH v4 4/7] clk: qcom: rpmh: Add support for Glymur rpmh clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-glymur-clock-controller-v4-v4-4-a408b390b22c@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689c451e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=RRvC4NyyfoRIYhV0TvUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX/xabFEY+meCC
 Sku/Lt5vE+Tawaz94cgEM8SZ0c+GCWciq6UYnlTKQyJdRUgHankAqrc/NXuTbrm5lIEEvATFHdx
 RmWoPVVaIc7trvA59VciF0FfuLAhDw5km/9+iIw5N9/VDQmHW1NjotSHPPOzyRhd9S/EIo8kgdd
 MsDEAlTvsz7tnp740Iigp2NEjafH5Cr6DreUyJ9rJDcUspc/jHrRIvY/0NiJDGfy0QG/Sjq785N
 Sikt0quSFlAjBhyL+bnsbpqiveeYrgUVCvp67s2O/ka3lWUUziPdn+J7icve+OVIvTcFQrKucdt
 cBGEriZdfRk6RMTj+oODTb90qJKA00UUQPzZ6e4iKuSQ36hgu6+imjumig81ITUKpFfn/X09ZnT
 PrEcbPVi
X-Proofpoint-ORIG-GUID: VPzUCYv4j6JhQ0d5aabLsu99e8qvAP-Y
X-Proofpoint-GUID: VPzUCYv4j6JhQ0d5aabLsu99e8qvAP-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Add RPMH clock support for the Glymur SoC to allow enable/disable of the
clocks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 1496fb3de4be8db0cae13e6358745660f286267a..d31b1ea963e3a54ecfa25e6c5cb0806e562525e4 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -390,6 +390,11 @@ DEFINE_CLK_RPMH_VRM(clk7, _a4, "clka7", 4);
 
 DEFINE_CLK_RPMH_VRM(div_clk1, _div2, "divclka1", 2);
 
+DEFINE_CLK_RPMH_VRM(clk3, _a, "C3A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
+DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
+
 DEFINE_CLK_RPMH_BCM(ce, "CE0");
 DEFINE_CLK_RPMH_BCM(hwkm, "HK0");
 DEFINE_CLK_RPMH_BCM(ipa, "IP0");
@@ -879,6 +884,22 @@ static const struct clk_rpmh_desc clk_rpmh_sm8750 = {
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
@@ -968,6 +989,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
 	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
 	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
 	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},

-- 
2.34.1


