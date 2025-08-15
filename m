Return-Path: <linux-kernel+bounces-771029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2853B281D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94821BA20A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7E28030E;
	Fri, 15 Aug 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkuVGHKi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD2277CA2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268248; cv=none; b=FilZ5XLARoE0KdG93flupZOTLEh6LH7MJcmffBkSfzKMICa8zzxRFwWH370jNynMDBkb/euW4lamjKDCp728DGsyyC0z24T2bPG0VHhYpzFOkFOSAP2wOWFMzgsX34ONn6a3qty3WIIa0Pb/BycLqTHweCjJ4Oq+L30uI5Ep5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268248; c=relaxed/simple;
	bh=hyEdJsmw3+fD6TBt6iVEMz+fGqwSjLU+mgD1J/nj/Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5/afV3ZQyajtPV7X1YHKI5X2xL+cBbebPGZCq+3EkWOj7eB1GXT+/UslAYdFvXWv1xIuZqdKHtMpjVHG6hTNHBYUbd7d/SvIfCa2ZGUP9FzakF1Mkl9BT71RBaqRXiKvYbPjPQqLVP1RjmmJqdMYKcgRMsUvuM7dd+hgB2zYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkuVGHKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIkKZ019986
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p0Dga2ququ/iz0C7Gew/O16VrwuI8lG9clwmw5naUV8=; b=CkuVGHKijQzWfx5R
	OhtRYg8n8j7M+YBvnJkBGk/dA9m1ZY8m0wTtl3B4Y2uWCdo5QE8uhwLa4y6sZ5ZS
	B6Idoi7x0KRLt0FNqhKPsyozkAbv2qmkF1XWXUH1Eg3y8hTe7wzvJt9Uo/zpBfNd
	OmWE3tnewWd5nvxZREv1OPM9MPggCxCaG8kr+i9n2C/6ki9Y6hLa0j5297GTsVlz
	jDZSXCQPb4v9nCAtwiCT4FB9MeS7PEFFRzFKr1LMFeLnkU4uDVe52J9z2zNsuByV
	KM4vjkoMxtS/UrzPOP685W0Yf4qQOeB1gGFDn1KGnsiGvXkH/n4rDbQuRHSI2jDU
	rUQO1Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gk64w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88de16c0so41431206d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268242; x=1755873042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0Dga2ququ/iz0C7Gew/O16VrwuI8lG9clwmw5naUV8=;
        b=qjUYBJgG4zASg8IwiRdYmJI4jVzxm3I8vDt5yL0wJLDZdp+Zo2dIXI+WM+uddZ1zdX
         Pmf8Ez+dFt0YpShzzdEaJ1B/9pIZ1f1Jme1OM4yJoF7WONbSJkKYjq0oVwyNZgGolg6d
         /0EIEDaghle7CpkGr+bj4Qt3dKJZH93wiRr+Ma6LT7OY6O2amqxZ1HU5vFzru2WwNmFg
         EENeOEO/LS7w3PIHifUOrmCqKqo7G7mtXCcDO8aoj7P9DJ1PtNXhOVtlIXzx7oP/FYLB
         dYNCgEm6t0pLKs+IEIssPhbsvmJVzKlPyK2hkn3BBiIW+BookYtWntt3hAfsSMx8PD4V
         0OnA==
X-Forwarded-Encrypted: i=1; AJvYcCWKHshFQ7aab7rxhfZM/UM/EuscJvbCXO5BurnexzewqjXje5rfTtKA9qCX0hkWyl99UUeAXOrVMRQ7cwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwSZy5t9xGOwV9EPLaULdCyZPsc6N6XX9tTPoCI6DhPb3h3rv
	QucOpBFCZp6iPkWKApLBzc9gDo2DRynHuqRDQw1WKm4Hin8jjenD6lXfhHyBb3v+xfAa1g09ajl
	Xrep8Bs2prxAXa+DWdC92hvTER39iFesM4F2cbeDty16CukAJgJIdL4dyqZqCDlVilCk=
X-Gm-Gg: ASbGnctgrSgOsBD7Q/syhLZws8qsrvaXjnSZ6sAjPkqPw2cph+tcsleLi2b/Wu9BQbL
	7YyyiYAtur8E76Dx4fMeGkFwPs8isMjdZPWCp9PtVxw20KLeWnoVRSvsqi/AVmBIDT+p2WjoyOY
	km+cWoaeEP3bg+v54a54mZlTx+u6tVC9xU8UEBfB/tvaKUGd4fOQy7yc3Q3nyuNvEtETcwtOLFA
	6ngmTu17rfh53OPAD5zCO4/JII1tp0maI98AF5dG0Ysf2lF6zyVNWX79wOAbnKVxW95AEonYUbY
	EqLyLMoYq+qRY4nq7jlMAO0ORltoCpu1SA0mzD1VhtpJvhTVo2YgstXC/UBCoIclNH6G/RleT54
	VxV8bnYwmHvVDEhVxG4cjxE+4yCF2kUugy5B7xfZMWUqvYVa+QzJj
X-Received: by 2002:ad4:596b:0:b0:70b:9a85:2cad with SMTP id 6a1803df08f44-70ba7c18289mr25048526d6.24.1755268241330;
        Fri, 15 Aug 2025 07:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbsP3wUZjJKRwWIURXbOZAQ20XVRCrWirWqOKB0kfzOToUE9mXBEuKx41mGrXm/2dIDmhmNQ==
X-Received: by 2002:ad4:596b:0:b0:70b:9a85:2cad with SMTP id 6a1803df08f44-70ba7c18289mr25047686d6.24.1755268240622;
        Fri, 15 Aug 2025 07:30:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f358bsm305661e87.110.2025.08.15.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:30:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 17:30:30 +0300
Subject: [PATCH v6 3/6] dt-bindings: display/msm: dp-controller: add
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-dp_mst_bindings-v6-3-e715bbbb5386@oss.qualcomm.com>
References: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
In-Reply-To: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kzfz4h3GQy4csg0TV4VQd6f6s6q0jIGQMAOr/+KricQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBon0SHNIR9djh0MjZ1tAnVRLTcBlTqr7v2pS+fV
 i55+ZtmNFiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ9EhwAKCRCLPIo+Aiko
 1Yz2B/90KDCp05bcxoSE/R5Ptv0P1HM2cMyhnRTNSqf61aZa+Zg0T41QAwIA/s2ruhs1y/91atp
 SSJdoRo4oKpt0xbspUUvsUhu/Bi5d9Y2GtFcY01iOda3UGCVagrzaTyrl9qgw+KMqQYmAX6/QyY
 FWzB2oEllczxtuqa7SF96SqhD7MRUZ4IHXgZpMJsHql5d67w4idjtto0Q/x74OFAu/SaF+EZhiN
 1D/Pma4X/LHFqFde2Aubk7T00ovQH4hbOlwyNa1XQA2SQ/aFlUWtax6F6Wa4R9X1gO5kFOaWuU/
 e4Hm496V3GKBtyX6Ha6kelAiIIfycSCxXblTDJ/gVwLixQGZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689f4496 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=LXTjkAqqvG_e-hvHT3MA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX8vSTJstnW4Vv
 fSOeM7hKZ5SEyBn44Fr6w/WTkKiboVZes67skJpI58bGpmFMSBwCORJOWZyVRp7fF/cyO5n9ZLe
 tzhN6FpzcQb5BHwxQjf9slEhfhaRl5SNwi3Mh2RLj934FwNvEa1v40BZO8HsyRRrst//lm+DxZB
 uXXfO/YQM+OBEj72Y1dT/32u6cXZzE6Hby6of1RL6Zb3H8EBQDI3kwgDx0trdfcC1R8lxqmeJXZ
 KMVg0Bdvo1JusbITBLwMcjnl/CrehorF/OgSIWWhhtOgMozqbGOx5nKKo3dRxpOqUTLYPmuJ5Wd
 Y4p+3o1uFzt0ZAwRr//Mk7fmoTLNgPpgJEHe9Uwi02+y6leD5IvaBXI9VDg87/znMrI/623ddGB
 RLvDC1Km
X-Proofpoint-GUID: dJeQD8jNiTH_6vdBAKLrjDC0S-jbs99N
X-Proofpoint-ORIG-GUID: dJeQD8jNiTH_6vdBAKLrjDC0S-jbs99N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add X1E80100 to the dp-controller bindings, it has DisplayPort
controller similar to other platforms, but it uses its own compatible
string.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aed3bafa67e3c24d2a876acd29660378b367603a..55e37ec74591af0a1329598f6059475926fdd64e 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -29,6 +29,8 @@ properties:
           - qcom,sdm845-dp
           - qcom,sm8350-dp
           - qcom,sm8650-dp
+          - qcom,x1e80100-dp
+
       - items:
           - enum:
               - qcom,sar2130p-dp
@@ -180,6 +182,7 @@ allOf:
             contains:
               enum:
                 - qcom,sa8775p-dp
+                - qcom,x1e80100-dp
       then:
         oneOf:
           - required:

-- 
2.47.2


