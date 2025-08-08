Return-Path: <linux-kernel+bounces-759961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF56B1E4F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685DC1886647
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BB273806;
	Fri,  8 Aug 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuJZ4YkC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65E2701C8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643196; cv=none; b=gTbeB+nAlANbAPl1IWDRgSTMhve6A5ZHRKWrD/1j8YfJVfOa785rgAGsbDBNCiJDKGLTDZHIngTCKdxTqFbfPrDKo9Vun+NNY+aGb74dPPvgKqikJlaDwef7f4ejQflM80ZklZc1+/Hg0gFaXNExRYDnfaCd+nf+TolgzPTy80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643196; c=relaxed/simple;
	bh=n+vg5ydQ7X4wyVt0+s72ttQVBKiwA0hDbAZIqS23E6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOXzHB7dLa0vmdojK9oX+CLpiDYM+LVVB7g79PANDmxzGPdGSXLC6AgepVhLOeo2UqHxF90wzYc/vT//aTGYrgEphw+/DgXv5QsNZRPCyh2FDOWeleTJqRtW2A49+FeadMrEKSrPW2nmuer5Dx1/gmcnrWNxq6LlJC52deSszu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuJZ4YkC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787LZ6V001951
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MPC6xd2VF/s
	mOBIHZ6B9pOI38D2n59UvsoeVG2Ya7rA=; b=IuJZ4YkC4SMY/uswBnY9zq3PDT6
	zjNeleX82/5fqyCYuzZR0DHvdzhY2Gi29t50ceeb8CPg3lt/HoU6+Vc7IYKmGVps
	a0M4gd2YpU0e3jstTzgZGOps5NN0D07z1daFLVKVdw0J+0lOxHXdCnqe5F+guSOb
	HcKXK3FCKo66QL3JmNja0Z1tVByB/cRkK/lkGom91jarnrRuKwS9eA6DSmtKFOra
	M0yhOUNwS+XTyy+a2JiLhyn4goTYNtYJHaPtX5SGTiVHVLz8VJRi/WXT0jhrDBA1
	yS/HOA6iX0wF6RnxKHtN74Mlia6yUvxeqPYQ1BAFDTUjxW7KaR1Hbicnr0w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw39a9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b081d742d9so70055571cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643193; x=1755247993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPC6xd2VF/smOBIHZ6B9pOI38D2n59UvsoeVG2Ya7rA=;
        b=XIY/GudX4ELPp+XPaTTR5N8nsOofU44px8kcJ2B6257UoxnIDSqJ0sJbXc9Hvofma/
         ep/HVNgbheJ9AbD8d72aAHJ/6C1BRXiahWnpFtshCi7iICIV5plwsZPJ4lvJzgBeThtz
         6RTIqfbwLk5hch+eYd+J9g+yxk0tSpmxAQzRTlaFe12ixcFXG/YceUgujEkWWJFmjsKy
         ic+kFaZSBEluI/74ukjktT9gLHSYXw8cW31wtWPtLriWb6umvEvZXJneXUPCCEJDg7Cy
         YLr8wkxJ2U0UxOHluVSadXVqm/x+A2TdSKaVf9hT2HIaPryzvW0GJpu+v+LGUW9X+Q6l
         31zw==
X-Forwarded-Encrypted: i=1; AJvYcCUBQHp0gCHFQ/qyoVXA0RBhL00WHl1skZOyXXw6mcYT+E55mbRdpVr8ePVrQGP5aY2eMxZh6uRYRLHCMuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMexSk4vpgFEcYtjfbPWPlaosX3Jf6F5PDMDtp4HKcFcALl+jS
	3C9acDeT9C8URcjd8NamGoei8dE1KiErNPfoDedw788X4Sd5OM0xn90zjmjeClB/Kg+fVg/jzno
	IPWUKrJJ/pJA80MgcwmrpuEqt4bGPK160SsVMusnoMpAp6QOuUYrOxicR+qjicaV1S5U=
X-Gm-Gg: ASbGncuazES6CHDYS/ePVGzD5X5cO7r7c/G/vIQoaTJeQGR2NlWDSYX6GLVVmWD0RHA
	V6Rpy9Quex3xuzGMmPJofFLNpPHnG23wu5zC/0zlk6SDW8QVSL8EfiNpOv1SI8YpVDPpmDBA3S4
	5G+a+n95Mx+gAFfHm1q2Yvr9LBJigdw0BpXjlcWz+u8Lj4aTlptcMwz9G9JQw2UcBd8sHz4wx9m
	ZgRiH6QskXdkMCQoMsAG25zfIf+YLzNLovUdTp9w68g46ALW4AmfjR9OuzR8LP5bmO8Z8MIPVYi
	ExUxHwjHwK2db2fYElPb686n5VCtNwCWbPr/oK8P2qT9HG8pA8w00QIlEYvvfiG/pJbzDjHUw8S
	FWJWIz6GtI8Rb
X-Received: by 2002:ac8:5ac6:0:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4b0aedd7c91mr33072681cf.31.1754643192737;
        Fri, 08 Aug 2025 01:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENcrcraDY6LBXO1gjbtLVDBfn7FrMDJw6q6bfeHZSZ7FkUb6pMWmIgogO8E4kcuIn9LS8VNg==
X-Received: by 2002:ac8:5ac6:0:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4b0aedd7c91mr33072381cf.31.1754643192309;
        Fri, 08 Aug 2025 01:53:12 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:11 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/8] media: venus: core: Sort dt_match alphabetically.
Date: Fri,  8 Aug 2025 10:52:57 +0200
Message-Id: <20250808085300.1403570-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX0dSU8IySeRe7
 XJqzWNO/T550ArH0YNVj9fHUxec3/yn/m0ZfSrRaSsaHJWpWdftxHrZXMIaSYz4MvfpOWY2kmay
 6B+/PkZBDafZ1s2unayx1+gbEkRGHPWAc2+iaroYzAVowDBC0yTUKDqUoOQfBcp8LNZ3eD72pzu
 g/SDoQ2XNNL09JijvE0S1eeeoh5fWN0fsu9lOCH2irjN/DH4q0OSaj0JZmIVV5NCybFSMEPzKVi
 TgwJF7b8wbkNuXPr+xTkO3dLplbmvOogebfpK1gwG651xG8uDHAbBbFvpE38XULx07Z8aATd6xu
 HokvgQUjFqKtu6Zy2RwGMF06Xn11fWkUArlZ38168WhvPnIRLVAwd8EjaqcXteoqInFUu7lqAwf
 KDyM4ur+
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=6895baf9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=tkZEzfabOtbtaFzRxSIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GmVyXdX29M1pkXWxol_tAvp_KQ3Aldxt
X-Proofpoint-ORIG-GUID: GmVyXdX29M1pkXWxol_tAvp_KQ3Aldxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

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


