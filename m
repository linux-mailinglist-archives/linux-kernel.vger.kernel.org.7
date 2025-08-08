Return-Path: <linux-kernel+bounces-759946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051EB1E4C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D29116CC05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E226FD87;
	Fri,  8 Aug 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRt7yuXw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4026F45D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642985; cv=none; b=TyKLYoPQTewoMYfnFmY/DseRZUBcX5CMLI/KtUJio2KNrMsrCkc9/rXTlIMv3uju5rczhBcU3i+Tjzsfjm8P3UhIC24cGHvzmP2E2g9dq+5uWK3mbrMVVrhECkOsUaVfEYuC1tPqYhFt4lToDE+AxODlAzFpub7E+pWaWXpY8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642985; c=relaxed/simple;
	bh=xLcisQUmX1kKWJaAAGMAi99CaZ3yNW/4jd6IUN4d/Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1nZ1P4FaXLTUibLY2n08ibDFxUrFwlyjHbnaiPFq7P210jQVFAAwRopQI/xHL6PCzrOpkj3NnS/XGspa+sQnOcN/lR6xXuD4xt7BYjpyjwUlll+QPiCva31iH3CA9fwwc0A/gCkR3hKs22NEAYDk5msdOVauXYLSqxJwQOnKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRt7yuXw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787X2rg008443
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XAMShpBw6gl
	5ZzER3GWo8lF+QTIMlJwqOkE02a/mRys=; b=YRt7yuXw82QzPl4IJvpIKdkofL7
	z3CM42yL42QspFG0Kgrp8nKnudsAJtAsxSVMhkKaJogyZPt0fGqb0RPNeUbKGBL2
	Tvqavjv7WQRWn7CXOOZeBx1Cd+twKEjVkzh0ULcj+AkLjZECCJYEZes3XketblQl
	BjgcwBJqdMzsDWtrm6rINxFEb7MdpMjtw6/dcZfEYDYSfYm1BO1sOyEg2RKzxokw
	8nqWGyDrpywoqw+D0nG6RHrUwLCPixu6paX9ubQr3HTSld+TuGcV8Q5Ukknzt7Lw
	W760uqySBQ/KyH/STYnBBEovvM6C2aQdaQP8fyRQzwn1/Lw6gSmg7ObpiJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u26ct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:49:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08b271095so51638751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642980; x=1755247780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAMShpBw6gl5ZzER3GWo8lF+QTIMlJwqOkE02a/mRys=;
        b=uy1DsXWhSD20il4fdlgun75z6+ga1w3S/XRDC98kA31Wu2TCFCWE5NqUU6e/qnR/yi
         G7d9yLfNwyZaCGmX3cjxQhFn2qkZqMyKdhyGWzQ07EnqZY7LHKcKDvjcZrJYkzKlMTp/
         gaaCnWnemdbDhmdnWulYXZ7fFOrOSiW/uDq+N/vC56uk2AdLw/xu6i8YdXZC7cawlcaL
         gGyG9NSVUtsJItlPTKB/Ks+b7gU1SFfW41jfF+L0tlToWhy0aBoAGZFX3WnvASTGIOJo
         r71JFwbbg85Yen5wGgXv1IgdwnkySSJ+HN4C5fdgdT1AYDm7cL+WOVKVBQftUfKyJDVf
         4Q1w==
X-Forwarded-Encrypted: i=1; AJvYcCXIV1gbOlHGB3NfAJBHBb0HR3Z6pfo1mP3as6zzhmrnbaJ/2EyUiG+lwKgJBJvzernl/IGbkNI/xtuEtDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK18sJ25Pi8eKM/KtMbmNH7HYRYpKy7SnoMKTXf65Ql+gH5l7i
	uDvti9tKStO5Uje9auBREm7N8V/+YALkBFsg0mc78YyODhsv8/ez3arWSRTZ7ia1VD8dxYHwL7p
	AGE04ovaS6y9yU6b6hNQY06MQgQNG7T2JeWWPJuuvZwepuos4TBfqlLuEHSKEirUbuzw=
X-Gm-Gg: ASbGnct4ZUyLblEj/OQSKKmLtQecmnUUqJh5pBC0xGglyqUSqDbihWdEeBixkMrunF6
	BYlz6ESAqnoAVyWh1cC/2Mm2l9U+37KWb1czEdKiQsB3LCyN3u8PpqAupEwTkGWI3YyayB1WxF1
	u6LNfPG2OOVuw8rCaRcKgBbibbujQiyF92VeFdFr/p0MzVqrFcj7Dtt5g1Z/QffB3ZZnxuMxklI
	vQd1MtomXcKlryhYQ8sa8LlUY+rzNaQm+7nbpI5jUrlaEnqUFfbVIMJafZ1AblVPSafYDfzoR9A
	63/s3YZIrRMFVi+YDjcYvOjW/UdKk2t4UUpAdcKNhLcUhPodPCLmD/QxCRuCax2Jont4N1Lm9LK
	JmF13NFzaHgxn
X-Received: by 2002:ac8:5f09:0:b0:4b0:8ac3:a38b with SMTP id d75a77b69052e-4b0aedd84d1mr38143521cf.29.1754642980395;
        Fri, 08 Aug 2025 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1yvscZAyrj30Um8VSEKm9PRcWAu6Pq/VWK93bOJfUynOJWNM5xox1ieq0bSmcUwi4Zfucg==
X-Received: by 2002:ac8:5f09:0:b0:4b0:8ac3:a38b with SMTP id d75a77b69052e-4b0aedd84d1mr38143201cf.29.1754642979951;
        Fri, 08 Aug 2025 01:49:39 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm122904295e9.2.2025.08.08.01.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:49:39 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 8/8] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Fri,  8 Aug 2025 10:49:23 +0200
Message-Id: <20250808084923.1402617-9-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-GUID: MJ0z3mE0KB4EFb17FFLGwTOL7yzdZs9K
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6895ba25 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Qms5JgQ9tnEuTiNUcoUA:9
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MJ0z3mE0KB4EFb17FFLGwTOL7yzdZs9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX/3TzqwIT3kg9
 U4fq5GnBQhlq8Ybmp32m6L7VYxKA+kiri/QKy+2/BpJ13C/AZwl5PAoHCN9KnttMV+ub+Fkd3uL
 aphNKxi6m8qVWyiwcNrs7AadhoLhi6iQO3EyY7gTwheVYzHyFw4XPNFZtOHiyU15aOxSwEDxBj3
 Q5MqhQv/JiZsPBMTCdr3i4wv5/h6vBSDvuNHxFSoFDWgxsn1HD6yR+biJk0Tj4DpQX/L+VQHfcS
 0dzGwTn8JD+Zz3OTrHUisGITzdLT5CrnM9vzulcCVoK1netj5LvF8lPKFtt6TAJcrZN8E0njT/g
 2ULENCKXJkGA2qUuTzFrC+qwQEK+jSfm1BLFHOEcnqd3mdymWFTv4PJMXVlMBmUF+kZH85R+wJq
 QcC68xc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

Enable Venus on the QRB2210 RB1 development board.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..e92d0d6ad1b8 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -698,6 +698,10 @@ &usb_qmpphy_out {
 	remote-endpoint = <&pm4125_ss_in>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wifi {
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
 	vdd-1.8-xo-supply = <&pm4125_l13>;
-- 
2.34.1


