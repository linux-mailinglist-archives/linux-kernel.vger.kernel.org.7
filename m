Return-Path: <linux-kernel+bounces-759964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E3B1E503
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DF33B52F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4E274B38;
	Fri,  8 Aug 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmBYrewt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C0273D90
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643202; cv=none; b=ZzRPMXGLjGzbt6a67iJSC6lW6OdiK3xzWVAQmO4sJE+fEFdlyt+lK0arn0uQO4w2wUWTw/DeGqSceYUyTZ2JA9PuffXpLIdySyQDmOrJH8nPigeg+i2b0JtlYibzDJ2aYoPKOdDvznqrP6x+vXY+hIrS0K3XzGQoNDUdc+CsEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643202; c=relaxed/simple;
	bh=xLcisQUmX1kKWJaAAGMAi99CaZ3yNW/4jd6IUN4d/Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cc7WG8/NBnFA/aDwnl215u+0Q1Kx64P5iLnxqILD3PNTcu9n+c+hsjfIi3taUd6iOeUVCNfDMcWldfZeaGhm9SdDOpLEqHyAKq9v1tKLCxIUNVzzy91TJ5SrcDzy/iYHVZi0QQBYM52DkIeIO4mp6kiV8FsF1KJvsgGTqnUF0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmBYrewt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787AFbx024705
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XAMShpBw6gl
	5ZzER3GWo8lF+QTIMlJwqOkE02a/mRys=; b=SmBYrewto+jNpsi4mCt3DQSMm8s
	yyWJMBkdy7sYhTSI4EFHOId4KZhIezx18DuJfacTiZI76cgvob5NnPVDSOves4Am
	8bF7BfkiJhIB4Ul4yAjnLk8jmCBL/PlU/oN98Zu4HskcRTu7qtZAVeiJrO7crsCj
	Bs5+wJDgbVYVjXyqqgOBN10fIlsT3t7E95FSsykffNmCLwcppshrZTN3fuFj4v9d
	/++nJXyXw1D6GhB1dzt0AB7oq2XKqFTyJP7jdcy4LZQ5io1qI4cpctS5iKhltfGT
	kNdktzesb29biz17JE5DvVPaPgKHBKcRoHjr7Bk/bn+eSmdyLyyls46uxgg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1h8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08431923dso43624371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643197; x=1755247997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAMShpBw6gl5ZzER3GWo8lF+QTIMlJwqOkE02a/mRys=;
        b=w6nEAse5CGHkw6OtxaoML5p0lwjzXT2LE0OpBQ8zmEaJTDT2EhPfdNoBr3Kl1hBFaR
         SXsKaT75puzPDzPe/wjGKHiL2Ujfjp7OuA07JSxhPihaP+cOQY6hKecZJkMMaWep+iHN
         PdOTHkdO9al62qe21DH0a4ko/7lkNcndF5vUZz7O8LpVhLfOhohEr5/5dJShFLiL9z+g
         FVbTw3IsFjqyVZ457Bs4Oq61RGalJPpQSnbyybApqg81AFKoZ2DhCMex9pqLmWFOD0h3
         q32rl/PvTD8zeETcPdBVr1XtsDXhM8oxEgZs131RKnytdGAGpl0/skcTh7hFCnLHLkfx
         F5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVJbKW0L7tA/kpTYNgLk5Uz9sKx2oURQLhX1Cab7UVpRNH3SXgcjsSM37R5WKKrgcOC/wpwhMHgou0I8hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASbTeGAFd4WrmeIa5NlWUyqccOcfU0bgi3C2Z6lSG6mBl5kdw
	bhONw5o8ZyytNxlvu9VqJn7P9wAeHir69vNNdRoT5M9tC15fDXK8MfwHORxEblkrL4Be7wy7R7h
	iVdJ8fn8ICjKnyx3Dyw15bEuJKOOot/9tzScYMK2+tF10fYQhYEIjMN8/QduRMK/nDcE=
X-Gm-Gg: ASbGncsbTKUCydX77QEb6n12nJ+jXhktvuP70IlqqR4qnmrjkiL0R2hgfW7hb0Czq6p
	PbTrIqOO80lp//xm8QdCGkISQ+B/LxBV9uVeJKRzh7eylsOASHXbtXiyp9IdZ5z8JyhHB74z++I
	D2gJPnVlhJr8d8FYeAvSoy94zQqxAeEepJ1N5J9f4W4PxSjcgmdUJi2+ORt7H9pAFZdBap06FNX
	+u7P8QROg/R5uBFIhVJYQRv7ReOriBH4eRu1dNcB0u4G9oC29/fOucE84urgpJpKIOF4xoEDioe
	p6DonJGBvvzF6HYBdVqUorWFG5FVrq01olwUxFTTvBKjc0IjQ512sl6pGIMRnlEQiwRNSIinzx0
	JUoRQZiIxBjmz
X-Received: by 2002:a05:622a:248:b0:4ab:41a7:847 with SMTP id d75a77b69052e-4b0aedc95c1mr30198091cf.31.1754643197262;
        Fri, 08 Aug 2025 01:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJP2aWj+S7AivPnjl0T9O7ur4HP90mdxQ0hwDryC5Qx7SHbXMaFhvERCN4XIMhJujoabrZNQ==
X-Received: by 2002:a05:622a:248:b0:4ab:41a7:847 with SMTP id d75a77b69052e-4b0aedc95c1mr30197871cf.31.1754643196868;
        Fri, 08 Aug 2025 01:53:16 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:16 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 8/8] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Fri,  8 Aug 2025 10:53:00 +0200
Message-Id: <20250808085300.1403570-9-jorge.ramirez@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0Yu8ClIS3o9r
 RjbqwHXJo607t/ypYlbaMQhIDKYjK6S7HgQMBo1BjQAbCbZsJQakVhpQL0M9vQIIlgdPsknQccK
 xElqGsS+EMKwT1rKE11drodg3RhsgBJQlz9rPKWgdv63mni17eWvlqVLhutsECq2kDjtyy3B5b7
 oMgHNNSMJUoy7vmF2JPxi3HHmT17ZVh/k99W1Cid9BO1LsY5agb6WSjOV8pAJb/jYgQ44vDH21r
 A8vbICSwDmL/D29lMYuX0FWTj+zWgb7nRVqNzryEtkAsEVDnntHvzZ/J+R4Ojxj8epopkCr/eG2
 OgQwyUQVocr3B70xqqZ6QVHpo0vCKyvInPIb5j1ntRJnNmd0wvGbSq7gbVwT2LYpPRpDBHM5DOD
 z35CqLaz
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6895bafe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Qms5JgQ9tnEuTiNUcoUA:9
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: on3JbZhm8Cen6baoGqoBXn0ZGXj46z2B
X-Proofpoint-GUID: on3JbZhm8Cen6baoGqoBXn0ZGXj46z2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

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


