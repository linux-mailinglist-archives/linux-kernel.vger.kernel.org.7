Return-Path: <linux-kernel+bounces-610342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0FA933C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793894668B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8A26A084;
	Fri, 18 Apr 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDDR8yN6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4A26A0FD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962609; cv=none; b=bscjG5y+xR8oaOPw9SgzUfOEWFZtM02RYgjb50uhd9Y0Sso9dlR0fxtsNSE4wPmqh5uU0s1xM3lMznVchwjy+P0Ij9I9JCigBwdBcDBeXLvwFQj1RFN4oC5aVJzJlR3jqqhcCEKdRZD/JoNCm6Ow2CDSVBkKY1FCHPKagikcJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962609; c=relaxed/simple;
	bh=BXoa02LSLqszw1KFDNTyhiysJ9vnQES6ubpi95G3uTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jz6dLCzCFLuMdfGKw7wj2AI4xESOtlRD6MpBDdWA5adq/unyu2SDIz0lel1QLf/oMoG0GqJodbYyrvWUXeedDGIn3cwSVyHkkIdgeLq8cblE46USVRdI1hCTfsgt8lV9DJpIJp3L6glttlIbgPyvDbHyXxVvH/R/ZpTufEarmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDDR8yN6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1tv3H013293
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e+7zJBm63Lgp886dxKyB6dmrzG0t1u6zSCJPTB4/5Dw=; b=WDDR8yN6Peu0rUGT
	C8gHwyauFw5GAqefI4hipAekd8SAMgvqgi2OLAgNEuHU4zfuvBJ1PVPGIfLyQ5Vk
	y05elYKL03WXvM3+z4dCkHUc/TffYeUs1TuvtS9Rq96qxkw1CFeFna0vs8e2a5Xd
	cks4zzUN+gfP8/rS+QAq5aKkb2r4T25drw89ojBqNzk887pX/kIYDfn7lQawvTc7
	AKDsKaVV0g+y5lFqPt539dKXzhDcJ9G77sVD8V/ESPD0U1Rre/lnqn1pkAbavoy5
	ugOm2C/tv6pzhvtSBTEzxaD7PFMTgacZ+pMApTAmVmJfJl6RDk3Duf+eBZGxXeSs
	Av99xA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvepe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91d8a7165so28017996d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 00:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962606; x=1745567406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+7zJBm63Lgp886dxKyB6dmrzG0t1u6zSCJPTB4/5Dw=;
        b=ZFbU5kgRYyEw5WOrFrS7DBJbrOVDwQbI7FJ9SjglUlxwi731YBSURG0/2A1DqQKWgB
         ja81ZfmKuVdsPThKpyFv400wYC39/dn97p5XMQI8ledgQAPjC6mUAfm7PVMoguOPsTUy
         Iu41mY2uePkSuIII3H/+TUYgu+80YzkQ9wEy6dQ3KoKDWHCvqf5wUARuvGpyE6iFy0j4
         wgi7ZBykqqle+rRBCSQ5Nl98DWPqW/+k1KnEwyw/paaarBtz2/j5mogufzTL1F5R2Utc
         gND27+ylkuZbdwj4jniGBrwO4EaAT3qvfdLGYVjK2yJStGkQmnm6HBTRq1livXit6v+U
         1A7A==
X-Forwarded-Encrypted: i=1; AJvYcCVHdp5I2ocfEGX/wBTd6p8cURPHBaSES9Qml+qb9x/udTPuhu6vMdnBDbc2/Vg/GKgyb7P4ZHGkeICTMko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mXWMnPnmwZ1qeuD7XccTiXsKAcGyulqveh0aLvorUXsVmdg+
	Gi6rCDLuuF9st43vtwQOOII3AKIrl+PtdYRfltJgXDSdx1c56lSBNP0czOPYVBB0OXUEixq6YyL
	K2qRNUCUf0ZiB3wT3K1HJNRCPrL2i8EqiVbFbqfAis5bFe3lkM+BDnVStAQOxfGc=
X-Gm-Gg: ASbGncvlDLRM9/5qavyYuFWfwvQOV1V6kvk6D7KwNTAzGtKCNfZgyV/BL2IrvvIzgtN
	SGR3rcdimEL7g3j5xTo8hhomGAULLcaR5rhnbNc35drKewGZhbCGgTwlp93J3Xvh8WLFBxEqONh
	P3mtQ4gpLKk0eJqR45Dgtzo4QNtaGV1Lxy06TsqO+KDPxW/3iJ5aQiDKEgbHYrXni0PDqjt30jA
	Gygje0W+WxN58DiD8llbConRbcllVT4I0OzHnkRWkZFo6Lz7mrvHlv3Q6Y+xF++QCFvQUb37s7i
	DRVNGvYKZzYCl0esOLyuhQflm+DEA9W27yXmGV9hoEeBJcym5X7qxygFbInhcrHE4CYfEa38Iid
	unsoMUlhf7LjtFD9yQVAHZJOZ
X-Received: by 2002:a05:6214:2349:b0:6e8:9866:7398 with SMTP id 6a1803df08f44-6f2c456c668mr26534426d6.22.1744962605918;
        Fri, 18 Apr 2025 00:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmdqbp1uisYZt9+CQb8AviILd0JfMaSMgZGRgsUVuNr4Q8za1X0NlrSkYGGp8cQsS875MEng==
X-Received: by 2002:a05:6214:2349:b0:6e8:9866:7398 with SMTP id 6a1803df08f44-6f2c456c668mr26534236d6.22.1744962605598;
        Fri, 18 Apr 2025 00:50:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-31090863bd0sm1649061fa.113.2025.04.18.00.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:50:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 10:49:56 +0300
Subject: [PATCH v5 01/10] dt-bindings: display/msm: dp-controller: describe
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-sar2130p-display-v5-1-442c905cb3a4@oss.qualcomm.com>
References: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
In-Reply-To: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=t96ussCqWyIQAdmFD81iVPY1jwLXVD8SP3JFMa/Qjfw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoAgQonsp75XK20kcf2pu5n0LjwPVYXkdyYuxQf
 a85/76z7hiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAIEKAAKCRCLPIo+Aiko
 1cq8B/kB+M00kXMMuhUmVSsKacPCdyAy3OMaCOCs8MJ5vQI6oROm0o7QZosSTt9M/TAPovpvLKQ
 YCocSsQ5JV4E8l8sAALjIOjHHNMpl3RvlOyPigbaKaN52tPNdrweOuFmzhDWnav3Vaxe04xIpYR
 HU8j/0sOj3j4ALvvsUXLXATE746j6PyP/7Z653sBsEr0UpmSkU/b2hHDIS1wclGa3coJqUqGh2G
 Kvk6NEnYnLOkex9SduAZJfoWdzCN5dyYrHvRLaJdiLzc4CoQFj3e9+oltrhHEOyT6LapegH4tb6
 3sGJLOoj5qOi3zj1xM1+geoLFaCWpdOq2Fp6Eb1OVPqkL712
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: zMBYI0WvCU54MxB4pPJ_h_ZtDkE2AKiX
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=6802042f cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=qy0Ph95xh7xgto4wCWoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zMBYI0WvCU54MxB4pPJ_h_ZtDkE2AKiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=931
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180056

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe DisplayPort controller present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e00b88332f2fed2fc33f6d72c5cc3d827cd7594e..246bbb509bea18bed32e3a442d0926a24498c960 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,sm8650-dp
       - items:
           - enum:
+              - qcom,sar2130p-dp
               - qcom,sm6350-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp

-- 
2.39.5


