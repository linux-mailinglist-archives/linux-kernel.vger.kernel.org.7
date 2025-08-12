Return-Path: <linux-kernel+bounces-763908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526AB21B75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D411A248DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC62E5411;
	Tue, 12 Aug 2025 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMbJitXU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194ED2D9EE1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968314; cv=none; b=Ma8pQusRZsFXxTNANlx4GPWA5jHbKCYEvmBQN+FANZM+S0umgUeh3vJYL7jJd8wGKDOdd2H6KoG64DHw7IW2MCssWQ+3NoqYJEXvBacsUEdJOIm3DLEu1U0aYIIv34cK2BuuQqF7AML9tbxr+GjIwQszKkuTJxf1CGNJ5nIONKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968314; c=relaxed/simple;
	bh=8khlXtaflpZlnDLhiEfY7BGqjnGu+2kL/Rh6j0ZMjrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKKNn2s52Bu0eoitHH4eK/F7mdGnkn0PESrhkD5iPUODtGkpJwv1WqkoSEmuCmmlnA9v44BAgPaAloNX2DpQY/dn1429aQSYzdhvHbigai27jfBvIC29B5y9xc8r/WnbyW9MV0rgYDc/4Br8xtHUVut/fVX/UFeiaNBVQ9WO9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMbJitXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGW3bd022560
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M6vIPQkq2rJdlBAm8nyeGplItg2V3tbO5nIx+nlKXA4=; b=pMbJitXUOAb7STVT
	756M5gJ4kweSQHHT3y7h5J6ErUp9FoxwYqu9fAPYNq+1KrKV13BYs8PuG8Sdk1zm
	iPehzuG8kaGSfcw2JDeds3NQtD2j6HKV73HD3r/6M6TRigm1V2iu0uORZY7GHgyK
	/8oI3D7ZwE1ihwFQRiLFreQUVbmcjT3F7bKIFCUAFQj8FF1EOGVQNJpD9ay4N+2N
	juEjNmeofyCRXy+8LjoqwfXVOc2PlYG6nByPoxP+E84Jov30Rexk44jWGHR+fDEs
	9sWTL5W2lKGQqunSIqHjO1tpUriIrBsZcqq+P3glVIRCJK5ofuRzl11j+wgWmYua
	9huXUw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vhfah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:51 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30307350af2so9284089fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968311; x=1755573111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6vIPQkq2rJdlBAm8nyeGplItg2V3tbO5nIx+nlKXA4=;
        b=CbVAn4CvR+O21S/iEBoQ3kHmzdnY1GAcfKbbPPX+s+mNEKglWvbj5ujl67WyzXgQX8
         MQYJebRsLI26wMzFu1zymOX6F+2mbJ2DKoIKRX3cnin42lT84ZKEnLA0XUU80Kw3nJkv
         x+9McJYIXWNOsOOCiYW6lm08ZCrN/JZChbwSdxzqr3tKgAX+Byf30n6XlpnDuAUyHrFk
         ADZbUXIepdwZTtiYkbKfTZ3eYQEXeedgYE1hW8LrSgSb1PYtdcAUMaRdG8PQRG4P29uI
         rkC2s2DIFGDXKU/BsI06qcn3pK5IQ+keYSRrt/pOVfW0s3YvYzlf2vdMNKqiZFet8vkr
         qLdA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGGZUPTMnV4U1ZeqlBKcp53Hfq9Lt75D/9Q2KTXDrVWgJ23h40ClyGhxfv6+0XuOfZ+ls0ST1gT8QVrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eogw5Vw2tttID+UoBDxj3gBtQWGTEbs3cFibWVTH/rS9AkQe
	eVoAw1fAjIc8GCAg/es+nfU+49Z4YZgTZTP7dD6LfQKAerY7dWKHPmOEQY6IZiUfVHKwn6wPzSG
	gfGeBHJqZtAlU2PCRkvhyJdHIef2ajBr7MagOHn9VlH2K3IVHDWmzdBwiywPl0XtIyRw=
X-Gm-Gg: ASbGncsrhYr+Qg5wTlssZL3Fh4Mmf6OppnjvsCqJr8+dB2/eyPD7gnqjYvwu++xo41h
	0w040KYuJY5Y2B4yTdoonubDZam8soFG80CkNzfZEdC3SeQ4iBTeKNm3cTXJYpu8SKfkem/4u02
	V01ZzjT/Pi1+IGAR2vHvz7yjTLTHsQaqieO390e+kr/xnjNvxC99coiswuY6D8oEg5q81YGn6Y1
	VApKLzUtV++Bc9NJy0BnXMC0Op76Mt1Vp5GRTlwCWiB2/ysob36WQH0s9ttK7Z0+oxEgJMRVwhT
	9e/L9AYQQQ2k+NO5yaPb8bQwEqs5pUCCTl2J6BQNdf4L9Gpk2RX14Rh2seSVvZbid6Ol9SPdYBO
	0TxKPjh1H6sYinaZ9d/690qXGlzfdrQeFLuXtzco=
X-Received: by 2002:a05:6870:ed90:b0:2eb:a8fb:8622 with SMTP id 586e51a60fabf-30c20f1f6b6mr9511989fac.15.1754968310954;
        Mon, 11 Aug 2025 20:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWG949UeJNB/dhYO6IDB8lMza4+9YPIklCm3HhlwRTMD9tvEnXoYd4roOyUgQzD76SyR7tYA==
X-Received: by 2002:a05:6870:ed90:b0:2eb:a8fb:8622 with SMTP id 586e51a60fabf-30c20f1f6b6mr9511971fac.15.1754968310656;
        Mon, 11 Aug 2025 20:11:50 -0700 (PDT)
Received: from [192.168.86.68] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307a717f0c9sm8174531fac.13.2025.08.11.20.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:11:50 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 22:11:34 -0500
Subject: [PATCH 2/3] clk: qcom: dispcc-sc7280: Add dispcc resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-sc7280-mdss-reset-v1-2-83ceff1d48de@oss.qualcomm.com>
References: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=8khlXtaflpZlnDLhiEfY7BGqjnGu+2kL/Rh6j0ZMjrU=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBomrDzSqU/NM8jmSnSjzTdqUtn5wqfjecU3n6mO
 h7DlhCi5sGJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaJqw8xUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXcaA//cYeSoAPeEiSTb34yx3JFUugrCvYZV+1g0hsCCMa
 DXdQ0+v7+S5VVLcAPkgUB30wWDqz3lblMwxoJAuU9cQ4fsEA41/G38mqrzlGOuwtJsbFsxu5OII
 8O4wop8UjHGoQquHIdnRPNYse4leEhzOd4/KEwebrFL+eja1zPEnbBm4twTRrPu3X0tDF0uhYv9
 mg/HHFImT4cMSll0kwQD9wsfBcSCVR8iA1GihmqJYB7CjOyEtZBogoMbR1MZxBW9dGrpcrH3qqo
 5tLphSEx0WLMEG9+/lJL5pkkPy+C2l3lk7jROehc8bTzjxwfr/b873Wf2C6233sUg3Rwh6Gxnrv
 E++NojgPXnh35RMtnouvto3/cNrp0eTUzTBSN1dZOp2HjJ/3kV5JlATXXxB0wIShho9M2+j3DYV
 AwtXolgw7NgT2UgIZQnwNFzK1mHof7yEu+05+eCGTa/0AJrHZ03v9lVWO1WzPMCF3zxgDYMy/6b
 sQfeb6Dfn7S3zsRCSNCbzkmzGu6UcdU4ogq5JxrEbGAwcXJb/jLZTgZe/q/IBVZM62k+MQEsZ+0
 opvFyU9VWMxAY5GPZoHFGXF1ls2mGT38S2L/odx1XWEaN9zrHqoOJxB/QVuVExvEKHUAJR65bTD
 q1TyiBh/bUbKrOdegRTp7MzbUDdLkT/fHVGu9/r1XxUw=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXzNoNcODULSrO
 HJr49O1z9E/HHUNbr4cc+nJIUBqk58nw6mPVuewEIuzSr+8iQBCcvWlBvOlnhi1jJZ7fpAlxQ/W
 jC+usm0rS+mHNAP7cyp/ITCgsb/m7Mo4gZoYfU6ubw3nkwcWTO/VCR5w4Pwt+oCf7fa86RQu1WM
 BrPs050QX8nbJFZiZiEkaZLHGq/mzydu96+R311+vG7/H8rKFclp+z86j8axRrDSC9/ZoIjX5NI
 DzLRWWi1Su1QaNVxv0enRrfShi1bmM++0/FdOLsMy8xqY6E3LA/OKlzyTUmwZbHtgY93CC/zzwZ
 9mHAfvKwjsh8DvJ5JaaY0uEZnJvzsaEKI+/4INFP71FUd/un/YZ/t7UKiz+HkUheEeG9vRzER5v
 apx3ij8f
X-Proofpoint-GUID: 1uAEke_FFqO-dsYk_AF4ks6dHkXEIjcu
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689ab0f7 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=12A6hGN33XcstJ_aBzoA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: 1uAEke_FFqO-dsYk_AF4ks6dHkXEIjcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

Like many other platforms the sc7280 display clock controller provides
a couple of resets for the display subsystem. In particular the
MDSS_CORE_BCR is useful to reset the display subsystem to a known state
during boot, so add these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/clk/qcom/dispcc-sc7280.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index 8bdf57734a3d47fdf8bd2053640d8ef462677556..465dc06c87128182348a4e0ea384af779647bd84 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -17,6 +17,7 @@
 #include "clk-regmap-divider.h"
 #include "common.h"
 #include "gdsc.h"
+#include "reset.h"
 
 enum {
 	P_BI_TCXO,
@@ -847,6 +848,11 @@ static struct gdsc *disp_cc_sc7280_gdscs[] = {
 	[DISP_CC_MDSS_CORE_GDSC] = &disp_cc_mdss_core_gdsc,
 };
 
+static const struct qcom_reset_map disp_cc_sc7280_resets[] = {
+	[DISP_CC_MDSS_CORE_BCR] = { 0x1000 },
+	[DISP_CC_MDSS_RSCC_BCR] = { 0x2000 },
+};
+
 static const struct regmap_config disp_cc_sc7280_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -861,6 +867,8 @@ static const struct qcom_cc_desc disp_cc_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(disp_cc_sc7280_clocks),
 	.gdscs = disp_cc_sc7280_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sc7280_gdscs),
+	.resets = disp_cc_sc7280_resets,
+	.num_resets = ARRAY_SIZE(disp_cc_sc7280_resets),
 };
 
 static const struct of_device_id disp_cc_sc7280_match_table[] = {

-- 
2.49.0


