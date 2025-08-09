Return-Path: <linux-kernel+bounces-761027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67376B1F35D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5F7A8F3F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAF27FB2A;
	Sat,  9 Aug 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AD3yxyqu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A12265CDD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728445; cv=none; b=JZkFlybw0D+1Ytctu1DNgvz9uTvgpS4AsajwTgeV3TROmn27SopCDiIsRABgYcJuiuHXSE7wqEivtcyIXYL8osxXusOpU+kIDYZt2LQ5rsPgvOF+iZfSWa4Gwwiys1idGhsRdrjl/SNpKlGZpZB5cPgeEF0MhTpFToEuCLtzJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728445; c=relaxed/simple;
	bh=cH9mFD81gjvWgXR9gnN/Va1aF7qgFbqJRVc2CfvcnWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQhghaNtc/l1L7WyFF0UefkExl9ySZgTDIUzigI0zJ+N6pFqY/rpNzxsX9wDo9bn+tE3szFpkKB77NZbHTXEgipKx5rUqO1hP7uQHh0+nNk6JkETdEeufxish2Bj8JSd5B4K4FGOMCSf12PFi5PlnzXMY1pau/Ge+TYGOKeTDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AD3yxyqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793ZC6c013381
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cxfuy14u1nD4xI/i3c1nKgU2lIEUsDht3WPVHTU7Mno=; b=AD3yxyquwP1uFabh
	TGxA2LNS+njOoqMl35MUrGXiZ2pCWfcFTjiPji3yNVoOB8E0R5g4CdWYHgT3duWr
	KCkWnTe7dpj21WcFPS4WTK+iSs6cZNCNeSaU4xSwsdcyw3WTITeJjaY32JNQEFlX
	Z/oO3XJMsFCTR0QVwaEo83Itkfbs6UrAaQrY82OVIuivGdBXVy0I85cJh2wtRSaE
	KZDitMxICUKFAjj7Nvs6yAExrVxSy0ndi5P56+vv/VMhsg2bNxuTvs5PaU1KJ48Q
	FPDXFA7t+ziJi8gX5nd4kgwQE2UVbwI2qDR1z3eY0MzITbsjHrfLczKZFcfU7obW
	s5Uuwg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj40b3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:34:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e686308729so701364585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728442; x=1755333242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxfuy14u1nD4xI/i3c1nKgU2lIEUsDht3WPVHTU7Mno=;
        b=Udmbd6o/wjKlqP5IlWpBYIMvTQWq8etfyX0CJxFa+6POAgyF8nYe7gcHrMHXaw82Cu
         lxLv5CR/LoEsAmNasH5rlEj54WEKPWRGDwyDAtPTRxFsfsuROP/KtvXDgxazLuvZp/DR
         YF7t7buEJGpFVSwZ0GBzAKC86gmS0+jEvoUah4DSvtjkpF+kk4P7es+PwzS7hGuEkivx
         zP0hNHDBCPpWdDcFRc1mJANIXbD/P+OiQ6izi6t0p9qCNJXL6FO3wcqsopkNLm7a/51D
         qLShil2QQaakVB5h7q3j+iYTcFA2oorxCnFdd13X6goizWQnxWX6qYJo44+0N0LvVz5Q
         ka3g==
X-Forwarded-Encrypted: i=1; AJvYcCXUimdj1txHjD34nshgHfv+9SfvnCoi0tFO8XgxKBkkXtgHUUzXvERsXPJSp3fTKbG6lksuhGw5+XGa55A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyajLfZRjtQEfGJbpPDEfk9eN/BcR7M2wwrxjv1AmGpM5uxews1
	l7EltYK11LEOIaGGw/b7qBHEpECpWVyziYXOnLt7tPA31Fb5dS9RRqx4SPi+918bmc9LO/LpUaF
	qbhrND3oLGi1eL6PXw1D2CDlx12lsG86Rin7kEymWOlTuQACltqBRofTA8zlEk6u6Az4=
X-Gm-Gg: ASbGncu+EJUxbm9z0RQHVAoFtbxW38T3Zx/eMpXe8WREG7zfUuKZc4UvJOf9aLh180V
	MrxMloOWuB1Bh0dd5QRJXcx7ER/VacJBzNKEO8UJYARIuGHycQrxPYFly7TemZ8y6YJYxof/xfY
	pOHKnod4zM5S4G/WdTrFjsaePIJL3qgoN6G1H4ZWIxQQjwtt9ONb3hLvTTdfglY0i1jmIZrNLHw
	p+MidePQcKBNsCGdKBnOmgWI4JDAoTH8jDP5QcwsDTEJ+8qf6L2GCGfNT1s/rvcvhFAoZZ43O9u
	oV5oAsFPLuRDQCdHzJejQuGspJ2Oun8SYuhYQY2Z8J1+iyFBvEgMaxbdfpFOgdV3LL0dysLHKtx
	ZmJX0IhkKIlMJxAoMK4djxUwYFpt0XbLYLGGY0225J6yf/lRXs9CB
X-Received: by 2002:a05:620a:ac06:b0:7e3:460a:a90 with SMTP id af79cd13be357-7e82c6a7bd0mr923016185a.28.1754728442122;
        Sat, 09 Aug 2025 01:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/n9eSGH3YW6fEMmHip0Qcvr9RZrfIXk0CDWrNNpteBC2vjmKnlIyVvB4nA9KO5IfYmcr80w==
X-Received: by 2002:a05:620a:ac06:b0:7e3:460a:a90 with SMTP id af79cd13be357-7e82c6a7bd0mr923012385a.28.1754728441654;
        Sat, 09 Aug 2025 01:34:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm3268166e87.102.2025.08.09.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:34:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 11:33:53 +0300
Subject: [PATCH v4 2/6] dt-bindings: display/msm: qcom,x1e80100-mdss:
 correct DP addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v4-2-bb316e638284@oss.qualcomm.com>
References: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
In-Reply-To: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NXtQ3bomvI5JzHf8G2204y7/eJt5cmkeL6NKDMpr9gg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolwf0hkKuweP/CdMP6B7vrf+thq0QX9XqRhZKZ
 NkMwSEJ0uKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcH9AAKCRCLPIo+Aiko
 1TPCB/972cV7KvtYTwIYjb8O6Xz+V9IwlaAu7GBJzOX0It0UuUU5jAb3vX17nSDCrJ8xsClvk7U
 lOcaS9r5jm8C3s3LTR2oAjlxxqwE4chNHCAFsZzoNTBNWHJQZItpJSHDOWp+OYzaeNTeNBLLyZg
 4IuGu96fiAoZZTweZF/+sYIhnTgzeDDtHPYusw+eNHxB/LR9mqpFokeGbZSG9gBIJnm+Dvp7uDM
 mNRVSo2wxC3VCLmhkySaogOqgYJFBEs2Hibgp1UxQkZURLndrDB1oPVYduguZZSVB4pGXId0rT5
 ObCu6d8pjRKXmX6qfQe3pX+negO9CjCPIl5OhTuzrL17uSOv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfXwAUVhWzTWkbA
 5a42uZ55w/5E3IxQ7hSB43GZ920vaMDyU+wspylzEgERoEC77bLznbTpzQxmASTKKbVnYiPTDLH
 cuF5ta65fkkyjVQlcvpOiwrkv/QFBm13dVYTOomII6frqOIrjDvjsD8iC1Euez5ByNXHGBJViIi
 SRrZkkXhKs3cGdcthLqgyfSihU5/QMhl3lzxNGlDqCRKBnNdB0MsEnznVpr7P+U8QDFOJ3LhEtn
 feeR7mEQ6mPz4rAThfopasigCraW8vkc9YDOwgsW5JiE4d08XjItzM+v5UUDHVCpaiaAYuAlT4Z
 TRyfXwJDczhzTY5Ctpy0Eopu2bQ/nyttv3GOvv8LLq36Tec1necg8xdK57bfBxWthejDueL3MIG
 rr6nT0dF
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689707fb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fvGZ3mk3BhhUN7shqj8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iFYoMcWhkIVFBM48jRdx2v4VEN26CRLs
X-Proofpoint-GUID: iFYoMcWhkIVFBM48jRdx2v4VEN26CRLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Fix c&p error and correct example to use 32-bit addressing (as the rest
of the example DT does) instead of 64-bit (as the platform does).  It
got unnoticed before since DP controller node wasn't validated against
DT schema because of the missing compatible.

Fixes: 81de267367d4 ("dt-bindings: display/msm: Document MDSS on X1E80100")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index 3b01a0e473332c331be36f7983fb8012652a8412..e35230a864379c195600ff67820d6a39b6f73ef4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -170,11 +170,11 @@ examples:
 
         displayport-controller@ae90000 {
             compatible = "qcom,x1e80100-dp";
-            reg = <0 0xae90000 0 0x200>,
-                  <0 0xae90200 0 0x200>,
-                  <0 0xae90400 0 0x600>,
-                  <0 0xae91000 0 0x400>,
-                  <0 0xae91400 0 0x400>;
+            reg = <0xae90000 0x200>,
+                  <0xae90200 0x200>,
+                  <0xae90400 0x600>,
+                  <0xae91000 0x400>,
+                  <0xae91400 0x400>;
 
             interrupt-parent = <&mdss>;
             interrupts = <12>;

-- 
2.39.5


