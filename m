Return-Path: <linux-kernel+bounces-759943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB2B1E4BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED837B3137
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B2266B72;
	Fri,  8 Aug 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQ6xq7VP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7C26AAAA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642980; cv=none; b=An40Wd/WiIlEz1cwKsXIb6RsPbVk0nUc4WWmHCVIQzQx3LtlyVB0URcdvy6uQcrle8tARSy/PhdylTRaQmRSz31N/QvNLd9CNWhXcf9GJUB30KYnns/Dg+oU+ogCb9wNcKHMYXUgTwd3IxPqmQIO3SMQXX6DQ/V71GGaCkLu1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642980; c=relaxed/simple;
	bh=n+vg5ydQ7X4wyVt0+s72ttQVBKiwA0hDbAZIqS23E6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Gw6Wf6/1nlVpIB01PocqgsjRi+40w/ovY+nKG+ChAuxEEnTrB27E65XD29NW2osEmiqvr5lanMQqNEapL56o9JgRi79s5coumHY5trELrT7nkhl1/b6Rdb2JOZKl7w/nCKtsPHDV/Q5dCDpdeQcQdxgBHkumukPTIGJ876iGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQ6xq7VP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57878ASq007665
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MPC6xd2VF/s
	mOBIHZ6B9pOI38D2n59UvsoeVG2Ya7rA=; b=MQ6xq7VP0qVp8a3aHVrsXHpeSC2
	n/ONq5QtvuUvgXqL/uQZDui2TuybsWCTaWNRN1WGIrWD3otA6w1Qmhjfolm+C+w1
	S9hnR4bVbA7addlaRPVoDxv50xnGUGQ1GxF4sYBvaa1ZzpGQH+9nUWhKy1+y6Zjl
	pCTJL+QuCpywIgzI17m43qB/A62565S2Shh0ECWr/8AulK1u2LLfLxbeNRCmKiJD
	ver+eak2caDg8ln/6EUENJpRUGYfbGO3gth14hkFfjVpABzsMtk1WQD2+UisrdrH
	6ddDK4ihbVUEFB1u2yarCL0XFreFmgMsKtxdCgXm4018g1eEuqpoMWU3QZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u26csr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:49:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aedcff08fdso36036941cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642976; x=1755247776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPC6xd2VF/smOBIHZ6B9pOI38D2n59UvsoeVG2Ya7rA=;
        b=WNfJd+Pkd6w8xMPV10PQkB8hq1dp4DzZXfj0PDginmjzPAZVwOGy+DKO0T4DhsDOd1
         S2s4X06dCPeSvJft43YKRZbEiQHLALeI7VKeAqBpqe/LLntwhzRoDIb1NsmhlzXrz6rm
         z5wX6m2RERwuJqKut30Wt+jrPdO91C++e//gsKT4d0po0AfXkxr5xRdeyFrqpJZuNgYk
         lAgfWCdfOhFdRhsCyCWN0tJbxj3C1iK7MdqGEVphg/WzDRcscztbsQhGFFDy0NY5Gac8
         BFqNGXnX6dI8ThRlZ4RDRz+452EYvsIBH569kaH/Y+Q8FPv80bM9mctYs9z6yiuF08vJ
         7B/w==
X-Forwarded-Encrypted: i=1; AJvYcCV2If0z+F7t+R9/txlyAqEQwV8mVglv3+36Ww0FCWO2YM6/wkf7MWSagCqlaIOlwealxLZmjaaOKNS9RFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+uqDfQmpYR9Cm/jJ/qTwTY4BGglX/ZD1+A8LdumUt1mmW0PW
	vT6YZKOMJ3wzsEr3kTGY7fGBZ+umIq/+BYVBr+o/kUuGoQyhJc69tTu921dlDPkeyKCxxaEL7LL
	96aUqrKixUOy372GOOjbkvlID4PWrnX/X3WAqHbTWaxweeiCb86gdwpK5G9AA0dPVstU=
X-Gm-Gg: ASbGncuRjorU2qDdJU3WXZHlXmYYzxFhnqWxcN/oQEv1Xv+mGe5gLZUF1mNtGrR2JcU
	vDCM1bPy/Iwb5vCnLezb0SMV6gyG+5HY7kOZafkptg+gOXmvN6HOM3ZDVQB9WHoH6qk13656O0t
	p8aJYSASMgc00se+nfrWr/xHtaZqUZm2NJtljZfCAMx2phnoVHCAn7o+iDm3X7zGV04mdFQWYLS
	BofE3GHmyjbmJPvYufC+VivnSocyWcdVts4Ncct3NoNh3kwRpOf6jesaSmNuvIfw7XLLsbviBDW
	R9olQVOHrnKTzBV+Vd8RaondjgyvSs+K/Q2JTCPgPMOckpQhY11mcq7/h/GfKdPYIFZyMj3aPFu
	VL6rLV2I8wlVv
X-Received: by 2002:ac8:7dc2:0:b0:4af:575c:cc39 with SMTP id d75a77b69052e-4b0aed0ccc6mr26657461cf.1.1754642976218;
        Fri, 08 Aug 2025 01:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPT5L9K1ndC4Lc0SocEjGMvLrP4Jtf9+LLMfgbO89C12Q1EWLhMTp/PQ5tpPfbopMSvLhQeg==
X-Received: by 2002:ac8:7dc2:0:b0:4af:575c:cc39 with SMTP id d75a77b69052e-4b0aed0ccc6mr26657281cf.1.1754642975732;
        Fri, 08 Aug 2025 01:49:35 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm122904295e9.2.2025.08.08.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:49:35 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/8] media: venus: core: Sort dt_match alphabetically.
Date: Fri,  8 Aug 2025 10:49:20 +0200
Message-Id: <20250808084923.1402617-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o4iur1vKGSbdGz9WTyrQ3nred9M2nJYD
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6895ba21 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=tkZEzfabOtbtaFzRxSIA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: o4iur1vKGSbdGz9WTyrQ3nred9M2nJYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX0T9XJ096ozy8
 1hslwACGAXGhcJPdcJubmQEHjEIUNqUz1QToyw6o4Wo9fV+KM/8vsXBRzn45HBgmnREjdibzVnu
 uRdQt5crFADATeztt4ELO0DTwpTWG1rXiIvw9RCNcyyqO02O66uT9lAjU+Szr9RMECxwI1TvTod
 nPbtJPHcNObfFe1+WoiRYV9qt5TltxKkAnR1lSp3AUvdPxO60QtiYNZpVN05Z0ncSebEHH9bolU
 fEUVuODlkjegpJC26h9hWt1dItXJ5VMlJ6tC27Ro0nSRnInWoWib4c2VmyzPtwAIPTTGpop9Yr1
 us/Vxt/q6ussTwbJIOhPnyzNRKWBkGVglrbDk/XsKeBgFwTtoA+Yb7d+P6uGK2nwQdfbG2cUP3w
 Lt3YlFZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

From: Jorge Ramirez-Ortiz <jorge@foundries.io>

Correctly sort the array of venus_dt_match entries.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/media/platform/qcom/venus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index adc38fbc9d79..9604a7eed49d 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1074,11 +1074,11 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
 	{ .compatible = "qcom,msm8998-venus", .data = &msm8998_res, },
+	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
+	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res, },
 	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
 	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2, },
-	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
-	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
 	{ }
 };
-- 
2.34.1


