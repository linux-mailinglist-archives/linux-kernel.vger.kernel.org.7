Return-Path: <linux-kernel+bounces-761028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A890CB1F360
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3349F18C6613
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC423505F;
	Sat,  9 Aug 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9GwGara"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956B27FD45
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728448; cv=none; b=Hz44ZJvImm5VPGNzGi1prPYmBajttGYKbvjs9khku8cXbI8U1IXZJk56IYyJQw+EuYFLm2NlBDvlLWeDgJwygVWWwL399OKy2eihm2YOAe0Mqb+vKs966+GxITANaNpsRFrunbEFPI6BKlHw/5cG9qB9dL99qamJihleEX+dpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728448; c=relaxed/simple;
	bh=1Y7zY65rJYgQ8sY2gOOTnCadfQm7t9KbDktMxzdbFjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhUrMP4/oWVqpi6d2vGUwzViXLidlTUlmsuVvq1Y7IZ/pIFTCs9ofibLa3ZxY4ipb4DEQqj2oAkEdVNtEenIjzGHk9R1nXAGOfL4oKPZ6cO8szAc4lovvXHQLZvERHzZSAH7JOCeU1RJS3YGjgN85HTR5z1YF9qUenwZPUMqbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9GwGara; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794dlIh009287
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wukwq66wPKvNOpEVoTlqCM/dX5GluHetZv+gB4FYahg=; b=G9GwGaraZ/Op0nXw
	0zh7xI5yozxuNGwywTecJ/riIn228egTIbjUCc/RD/zp8tZSD04p9PsEXzzOCmjT
	+RY3OYjDYELTx8GIdvM8OKLgB4Wsul5l4XxLUuvSZurneQjXG8jqFiKQv7aPO3Fy
	fT8VatYlMmom6IVuJf2wKyWKaHsMqUuO6R1sZLd+ZJaD7ByNEd9nnAdmTkdHYOYM
	wABPMoTGl1DCcTsGbK9cVoJ5pA6biRKdMmkmFNkQAyAY+OIwoWDyF+ok4Mqy5631
	b4kH5rPzmq+jshKeSsCGbb/Z7xDJ1PhqarMSzeylQICQYxdzWGqjXqQ30HLPGmI/
	c2jxDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm88th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:34:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b096d8fc3bso65082531cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728445; x=1755333245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wukwq66wPKvNOpEVoTlqCM/dX5GluHetZv+gB4FYahg=;
        b=NOoczipirs7yr4Ggz19+WzgL+/cni7R+uq6J0wE0kvEV/+mFT6v55g6OSIGYPAGxuf
         NbT70/htq14pg7hQ4TPVPQwbpyeuzz835i3VsuH8Rp7yEGFtBs6Bay1Eg+evU7Y4QEFW
         veYSeqPuCF6Q/Uxm+ONRsxogg6do0DBM/vVHGFHr4alxlbrts5dInvZpe/xgOyV7HIgC
         MON/yn66IN/xJxS7kGybl8qt0GjJgF3Qcb0TjenQ3js1zgWlMdisI4qyGIZ84nSkl+MS
         F5osqVIcWAQ2K2Y3NKSRN5TOQumX/Tze/3zdpVIDDql9g4Rodx+4LQ7YDm/JPfuxTWOe
         PP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgmMsh9DW8JVl2EGLhXdpd1WWMy1jukc4zbnUGI1IxXIuoMyXKWQg2tWDArXEb+JORe+bl4G63DPqhSws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7ZcffEetTqvd6jD4wWEJHygrxIqjMbsh2tW1XTIy9kJxHh0P
	3KFrMoc+N8IZtE2qNyABAd16+ZPliTDaQkH4aFKtLsGlGYje3bToKzRrIPaqZi9C6dbKl2MUrBR
	ib1otZTY0xktztMcyh028Z2lvjI+zbAkgw80Qh7/gJcCSGDb8HlXfBr/eG7OOr4wI8hw=
X-Gm-Gg: ASbGncsKJj6gl8vnQw46RJ4rOr/dOpelEN74UGNuje49kE7l2YBOYoL3quWdOEuGX1g
	VRtquE6UwGaQ7O9AMhzrJAAti7uVT+uS2lZzdgsHaUvM3kwzspuAoQq1bsGS2xlGBumaASnTJtd
	sY9GYZbLmjgyzNFjmpPt45CaP/zcYPlULsu5TF+CKTXrTriPlEv1BIC9r9+9B9+afz+iQKVYL/x
	j6V516I6Bgjg8XEt1jiBSCJcrmLGEMV59BG321VbqsMm6AQDn1rTKuoVL1bdVGRWmnypxKShfw0
	sdf53mpwdr9g+RWqMVmO8s+4P0u0/wvWgdHpbCkTnTLeGLbff9XdHzMDeB53aYS+Vi7v2irYeWI
	XujWM/88+rOH2tgpD6JHWeT8aoPjFYFZDTImRZr8xFpnUy+EureeG
X-Received: by 2002:a05:622a:1a26:b0:4b0:871a:1d29 with SMTP id d75a77b69052e-4b0aed40874mr94915701cf.23.1754728444753;
        Sat, 09 Aug 2025 01:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFig4RLdVa+ZKtVVWlKq4qwy4Mdk+4soSl8FgCqEL8l9Uc8hKFCmYGvSZPG/3ishEDqASv9uw==
X-Received: by 2002:a05:622a:1a26:b0:4b0:871a:1d29 with SMTP id d75a77b69052e-4b0aed40874mr94915251cf.23.1754728444291;
        Sat, 09 Aug 2025 01:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm3268166e87.102.2025.08.09.01.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:34:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 11:33:54 +0300
Subject: [PATCH v4 3/6] dt-bindings: display/msm: dp-controller: add
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v4-3-bb316e638284@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1DHFOJ/5Vedl1A10IE8+ZyGBBk+aXq5TcrqsRnBV7aw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolwf0KySR7b5nEafzqIH/w6XFWN5nSrXlVFTPu
 zpV2R/SmsmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcH9AAKCRCLPIo+Aiko
 1d74B/wLBzPtd5TN16CKun8cN+yKqM7XKe3lvESHvQ8ynyfNoHn2CFWTXxVgsxf6kOzCuuYZEwk
 U4siRD+S3q1ax07b8niuiEcC1bFAuvZ+x2e2UGJnkcip/ABE+g346Cq4711K8seCP4WT/47F0Ih
 eo/YMwLkL5YN7FTwCpai0BCighJaX7h1r1Krn6ZoBIUL0MlgPOqeMvbZ2q9WdTUpHnH0YKAosQh
 O7NB/nEzNgTA8sWUC24e6EMISlwAtmCCPWiHzhItkxdnAmi/lK+34OQSOhdIciDWozHs4I5ieHY
 A6hnaS2SU7P3o3tzqurhlD5EuBeq6qP/P7sFd+2QE4otzehv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX4QzsdK5bn1rV
 x4XdiiceVVbiLS8HH19utb1aliIiWFqxq1aUp9er0T08Fu+A8baHzgdx7RoXWKdCBRbW5FQsOMf
 yFiQX57bV5SBmdzxSLYXtXCPZLHtyvx32354ockA9+7k+ZaURQ7XK1ih7S61+pDazQ3oeGlRTlV
 bsdrDkAxndTsLvdaR+Cimd/s4/bUA282gVPNMfc+y44YCuRJ1cridy/iMzUe3zb8kHHafbSAxmV
 PZC542TjDVGHyXDwAu9I3lkoJx85JRd7uRhb9mjmybxtkq5/Ga49x2DYViz2n+TBi3CXChnimx+
 v9hezXG281CDQ/u5ZMu0uAuUk+iuwioTfsVbER0+GTAB8A4G8xVv0S3l2w/l/3wgeUQLJUtQNTX
 6AtJGPIV
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689707fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LXTjkAqqvG_e-hvHT3MA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5C_lSrnsSinhX6a5sA2bBbF-p8udMYvZ
X-Proofpoint-ORIG-GUID: 5C_lSrnsSinhX6a5sA2bBbF-p8udMYvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add X1E80100 to the dp-controller bindings, it has DisplayPort
controller similar to other platforms, but it uses its own compatible
string.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
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
2.39.5


