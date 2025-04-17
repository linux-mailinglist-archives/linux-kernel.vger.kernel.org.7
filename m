Return-Path: <linux-kernel+bounces-608122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A4A90F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 01:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB891905F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B124C092;
	Wed, 16 Apr 2025 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ypmt7D8H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70B24BD00
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845405; cv=none; b=lj1fnCIP5BJBlftUWCIUmxDwAtor2nfU/n/T8Zb4ndrhnFtdGfsqt2MD1IW07I4xLZwdjuOIhWHXUXWNXojnIlEkI4vS6P9KZyK6Gbc+0vcn6rqniojPFs19Zy8FIw7RYmaZxM0iufZF/zzVmGaOtnj5warrTKrulq1o0fWUS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845405; c=relaxed/simple;
	bh=RGg6LqJQHNLz/YdyIPSyHxFlnkDpez0kLY/KCeMZs7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWkVsIpmB6XyFmWN/a5V7OC5acNb9FaLxSdOoZ2NkY0bb3mk/3lFuO30TDMCZSqVPvDvoMBIlRmDxl4QM0XHPEIoJWHk8qCtdNCsLpKRU5jNXV528Puj7ditUQjqHAc3iGNeEUArlRHWqeVxZ9qi70yr0ffrW9U4w/ap8Yx0FdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ypmt7D8H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLC6M2025277
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 23:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/QbvJSKxnfDapkwl00/Ate2tQHcvUoOl5cDQeaEM+xs=; b=Ypmt7D8HkfGahof3
	uLHNUAbjnYGzyfK9/AP5egc4Ntryyv4nlUMLwZtyigudYw1x6Zdd2kxp/l37TNUS
	cwmKftw5nfrpm4qTs3LK+JTz6DgfZVwRQlkDLNOG6H1mz/AGBs0arbLvfTTebJrp
	SsGI6LlKzUmZOTrW4dlxUfMfD+oMobw5UEKhmkgcXZ+3EDHwTLCBXiBujVfmKhbu
	K+lGBO7Ir5bjF025AydkFLtm1d192V5fHdHsOgpT3jQAeYT2UxGaM4GE4f5GxRwy
	no7sXaeNErQxjSBycevi0oNqEjpSDttSK4YPsxe8l95pURHF8ek8uzsbUysjDQ8J
	iJDtkQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjd7xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 23:16:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f2af3128b0so4131856d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744845401; x=1745450201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QbvJSKxnfDapkwl00/Ate2tQHcvUoOl5cDQeaEM+xs=;
        b=MmQ5zqG8bm396hZoyiAOMNzRtLRd/5cB/vuIJJ4y7UiO5UrypJtC6cwV6gJ77opl7j
         E21rSCC1QhgGjb+z2A2+c2maTEeAP+eRxcSddW7fvu9nyfNn3r2yhzGscAy7EjHMZft9
         x4W38wwtoSfCn97yb5UVs1ObUL1J0+M2PIUKw3xxfglbtA1mPqFaPoPDli95e9d6iXlt
         A0kppsfBdYY4+0NXjMBlHGsV3nauQLyKG//eAH3DAH81htBb06gBFayEBMkvd8GJ9ydY
         vPQEZaO9Hf632SKb98dgdAYqg8sOD/A3BDYmBGesxuKTo2eO7e0aSl3I4Ydm55FqFFpX
         f0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZRItaz+ZgJ8S3E386Pmtj3e88oN12RtJujRESpreTC1beK7RZcj5X80g6lP+lyCxjaB2RoovxJZbmjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZ2L0Xy55UIiK2n8A64b3oSh/EdGIVcyYJhjWnUWwKNZnrI9f
	o4Ui8m6cHfAWTVyJhEocgM3DLlh09s+VhwAGKQFln3Yrk4F5lgLR6CJSA4FzJ+sdsHoM1N9kyEE
	WB/J8FTR8fGgiAgwl54qgluH23ftLuDEEpk77qqUgece45Xu+X8MnW0+lHR/UVG8=
X-Gm-Gg: ASbGncvhBHtYn0sE19HdUyTds4J+ekmRIZZZFwtbA7QAZ7c6gHgMzj/3XW/JBktsEBx
	g1W0XgWa4r8aj72C/9D43cykIiykmqtQBwkL7QgRMWDkEYmAk+LWhEKuE+SVcCrglHC6He2WG3F
	QamEGwE59GfH08Set19agvaka/bPxTvOOiPazu69Zv3OjnlQw/eIhSn5loJuqUvTUAbIAtkyfQC
	qGqihYiChq1F9SQ/zLq/WcsfMVpF7hDRuOcC3BZ6GnpYwU7DsFJftIdtppLAPxNnYgLMI28Q/0x
	KYMetSbbfMN07IApkSKtuv0h9BnXsvQaZ/nJ9yXysF6vrIdJtfp6va+qYZM5vIlB/TAtepd+hpd
	MJsLeejxmknehvF4+0QSlm1ZD
X-Received: by 2002:a05:6214:21eb:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6f2b304b384mr65723836d6.31.1744845401544;
        Wed, 16 Apr 2025 16:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFodq3zesjzB5AD8ZHwYudSr6HtnwZ1FwskPTmT7ERKcUtRooBLKijOcL1qw2PrbhGDKECqzw==
X-Received: by 2002:a05:6214:21eb:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6f2b304b384mr65723356d6.31.1744845401109;
        Wed, 16 Apr 2025 16:16:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d79esm26062181fa.15.2025.04.16.16.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:16:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 02:16:33 +0300
Subject: [PATCH v4 03/10] dt-bindings: display/msm: dsi-phy-7nm: describe
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-sar2130p-display-v4-3-b91dd8a21b1a@oss.qualcomm.com>
References: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
In-Reply-To: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=azlck2n2u+qrgsVJ0BAEOEuqH2At8nKdcftYTsEljlc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoADpRqFeCbsoSliYom6fgv+FNrJxUdOL9SE2pO
 L35U8RUUXeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAA6UQAKCRCLPIo+Aiko
 1aCzB/90xZfYQtLjQ4Gcp/7a+/k3O6aBnT1+SEVNnkCFB7B2SpWZzM4FKoNNzTmPAdlxNAQ6pV7
 uwyyP6e5IW24Rz0J0GVCzdPCyhdxL3OHl9yko0VdElC4+W2RkCUXDKL94GyolrRmU0GG8WtTNGX
 Zp0jcL+mKLfRDmJk7u3kTpsVYiaWr0iSYhZLOQa0e/yoTMlXZ24HgA4NpbP9k5si6mJeXpxQV5B
 gwkNc8wbu8flZkg93wMvWjvX0kYwPbTZfY/Q2jXkJGFWsk5e9E013W65zVfCRoa2McSCsXmVSL5
 /W1ToGzJRdarfdz17vfvONGPGWfUMZZ92wPwjQkStZYyWLU9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=68003a5a cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=5g6dqdCWcepBQtZB-T0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: L5x1XUwERHGIGKfZwLVRma3YYZOfg6_Y
X-Proofpoint-ORIG-GUID: L5x1XUwERHGIGKfZwLVRma3YYZOfg6_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=926
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160186

From: Dmitry Baryshkov <lumag@kernel.org>

Describe MIPI DSI PHY present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 321470435e654f1d569fc54f6a810e3f70fb168c..f79be422b8892484216b407f7385789764c2de1b 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - qcom,dsi-phy-7nm
       - qcom,dsi-phy-7nm-8150
+      - qcom,sar2130p-dsi-phy-5nm
       - qcom,sc7280-dsi-phy-7nm
       - qcom,sm6375-dsi-phy-7nm
       - qcom,sm8350-dsi-phy-5nm

-- 
2.39.5


