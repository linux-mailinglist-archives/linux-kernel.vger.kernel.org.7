Return-Path: <linux-kernel+bounces-748937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688CEB147C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263234E402F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAE23A9AD;
	Tue, 29 Jul 2025 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jA2+efW4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE2246776
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767785; cv=none; b=bBbAHF+KpYqc5RjoKwUyl1CmjPnp9sEcEzOCiXVIGzOIl6fR+K8+FbvqhEKaLgHwUWjJutR1AytEs2fmhCbmKWKgbMdrZbuhBLNgQkXhLomhSBngInvA6hMrTW8MqozMsB35TgKc3oIbntxeT4ghY1X81hPgM35MtSwQqLGVBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767785; c=relaxed/simple;
	bh=Ea0XH5QnnMd0RooqHYz8fkr1Sqoxpl6YgOdzQWVRygk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJD0PsOsJMMq15GTZpGOtmnAnUXaSaEi4N0cs43H+OqUK8OdII0mME+ugwokgPCI7ndTuRGHmMXqoTBGli0Z9BGIYyips7E4ToiwcHilww5MDxcWCc6YNVxOZJY+ojOmXFHBMVnOGrm0UOaef5rgyQrswzSyv1dYOA4Rl1cMRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jA2+efW4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SKwJf2016046
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ABiB2EaBL0RQGTqrly8CkIvf54XuMQfSPZGXYHXlM6I=; b=jA2+efW4v5n6fnYL
	HjjKFBO3jkWJErEFAZhRJYeNbgOCcixJwTXFh+s72bqH3JhlR1akjAVujKVcEzxN
	5hmDRRlY90ixZTGhG9TMVM/DN5ET2mUK9XLLHgKITjezkJ0hqurM5YNZ6W9UKGHm
	4taY23Az8stHmNMbXea0Rt6FjFaeEuY7lYBZfnDeFM4NtLs5yAlXrP8CKKls4Nt1
	I25q0M9jHPlcWMDWYHI4seCVbyT+YpBXXzN0VEpHDt86ZGj2QznaCfxMjz9S0L+P
	xJizjgenI9eEEtPaawuWZ+juOO11PC2Ep573nQ0LbbFpIUFpmEZLLzFxMj6E91yS
	znyYwA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aewju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23638e1605dso40670665ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767781; x=1754372581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABiB2EaBL0RQGTqrly8CkIvf54XuMQfSPZGXYHXlM6I=;
        b=kLVJn1tw53+kz7v+wyw5jGlVNGnEvT0E5hJi57mlI+wbShbk96GYtK3twYYRdoqKhM
         tiwIlkkf1BRXVIxPESFoVnCPx1isZ9xcewlmbw0/l9tudQC9LEW88Jh+2WkX7MJNrT9t
         PrERhay1tldlimkS/Ttp2YhGzpSFr5flBr/EudJ851nySCYPrbPAsCHNL5ibcJBz5nyC
         vTkzp6ubPNXzg739PJlxNc8d95zcdzITeZERHrJVEAOH2K+60H29wmyFmFd0z1ySbeOk
         JFqh9lNBHQ2xsO53b6ZwNRwyNGbzvilJL8Pol9msqI4QlYbKBLe8XcO7PCt2dWBn7Xh1
         ihmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/PQDCug9MwODjaFmdV+Rw8S0BZcnU12dI0TdN8jCaQY+vZU60IYxIkRM/Iiw9fkkpZP5Yj4yK8kfyi6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSN+mP0q0tolYLqkzKpIFJa4BVV4vrSdTZAX1A4O303+nR0RV
	MQT7B65PAVjVchJJ6y20EOBEGYhLR8ooCyBVUB3vgsJ9cinayPthb5M+xRhjbBhs0u84XusoEq8
	OOjn9mywR3q6TNo2VKIiA/HqHk+YdV5ZnWwdCJKPKQjV4jfFQlqta6fxv5rHehcBkQek=
X-Gm-Gg: ASbGncvGD+J05Q95fr9dHBD7Ed8tcxz2AU/9kyotdoifsFGp10OsVMrzLgYyM3sHe18
	fng6sAPdBfZMeKnG1mMn8iQsVnQ2gXYJ2DA4CJn6vMD6HSVCpWrHbVfAX1NiJeQI4gRA6OK8q9k
	s6HdkW34vzPCpCb949Op1OqMuCY9kmoC7R/Vkz+ewXXF69Zxr7kANN58RX+ILYGKNgiFpSue+DL
	ifSeeHCODjYq0E9SoolEt1Gm5Gy54nFl/R05OkhnIK0sAZH9rJhm1h5A1aevAWn9TkpOEw/XUd7
	1IdpyLkHgYg8p7Sjgg/0WpvRTaaMQHxNkJzJdF81/uzzEJejrg9Bix8J33rPp/mu
X-Received: by 2002:a17:902:dacd:b0:234:a734:4ab1 with SMTP id d9443c01a7336-23fb307cde0mr217608465ad.3.1753767781206;
        Mon, 28 Jul 2025 22:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK2HfQt/aXVHTNGav8XxlNFH6DIHxFwfWkOfqcuf7P72UZ3A45H1KrBdKTpa7wMe4454xOjg==
X-Received: by 2002:a17:902:dacd:b0:234:a734:4ab1 with SMTP id d9443c01a7336-23fb307cde0mr217608075ad.3.1753767780731;
        Mon, 28 Jul 2025 22:43:00 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe9b67485sm54505235ad.47.2025.07.28.22.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:43:00 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 11:12:38 +0530
Subject: [PATCH v3 4/7] clk: qcom: rpmh: Add support for Glymur rpmh clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-4-227cfe5c8ef4@oss.qualcomm.com>
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
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: h8zrO145kbtf36RH4xALyDf5o_6XXvvB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOSBTYWx0ZWRfX9h5tdXmHcx8Z
 ckrqgTlkfxYxyovjNs4ota23HFcHjzLBbJyfh4H6KQNNmeof586Eaumnschr5l9BflaStfCNcDk
 2u5GkiSAvNE5/aoLPEMYkUf3IiC6UP/vfz+WVUFWk0Eo4B0/lHEjPKIYfcCeOrU/1j83uRrOs+V
 Gy+kv4uI/OavAHzmhG7wjazJAAztOZtVOXg1K3hdJ8fjEhZLjnA9+RGH0XxVtbjI+q04vVxSPe5
 QZ29akoV0tq0oQiQFMiKH0Yg/FISaUXcnauExXMJ1Um/sjJRO2mgkBxJY0Fd+5Bp5UMJz64cZXg
 jeTMZTLQeSHzn5SE2xRzZZZM9T9vtGM/5VsS+LwZjItrzb0Gw0yc7szL/52EKa5tuyTBge/RVR8
 8nDya3JUjJ84D6ZAgMjt1G/JN3Kz3/ZpdFOKhjmcRknPD8hzhUSW1NPE4BlaXn3K+HKxzPVM
X-Proofpoint-GUID: h8zrO145kbtf36RH4xALyDf5o_6XXvvB
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=68885f66 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=HMeQyL50y89bOeNLT1wA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290039

Add RPMH clock support for the Glymur SoC to allow enable/disable of the
clocks.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 00fb3e53a388ed24ed76622983eb5bd81a6b7002..1bc1333087b4cacfe39793dd19d6bef3d17790ab 100644
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


