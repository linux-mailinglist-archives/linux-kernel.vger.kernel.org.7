Return-Path: <linux-kernel+bounces-790833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01851B3ADCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA99C583948
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292029BD82;
	Thu, 28 Aug 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="le3Qqzw6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC342DA74A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421312; cv=none; b=QEeUodASn3whGjRIktitaDBzC0ZMA+XsIQKmvY4g9kHY+ROdqfHb/8oMHXhILTkn9FD0XrCCHukc4ebEFS9g4gJ6hOEUY7qGTB26NREgCmLwUWqV85zqOFNrFSlzRCmKz6awnkOUXKubKwHFnVFWFSxzQ3+NlzQxMsfEChPaeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421312; c=relaxed/simple;
	bh=xYiJqMlXkF/RmUEDi8Jx/sYOhGWXsP+4BXARGjRG51Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otPJCatMEOlItNtdSuFO3ExPzVFfuy/G4UceosLlm+XBtCALbSaKNYAXzjQ9rG6TckQRcmVRXdNU8PFyCX3ehwhtamoWTzGvU95S/s23YYYoLL1VbU8B1hg2omYrQSe4o46jJFDWKifUrIpsNbcmR6UuWjq/ZospOB6k3SW8wys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=le3Qqzw6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLWdZR025049
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DvS+pfSkiXK4ob+ewthYnY+XCoXOveBrZR1sStGKsLY=; b=le3Qqzw6Iyxa5OJ7
	5zzXr+FUuD+2gpmpPmYeU57Jyx/emIulnMXElkDcFILTX48wtzjEEAVggMoacYui
	4ZczuQ1A7uNRL/V3ztS5p4Z83BsIXznjHB3PXBqyDuyeR0VW468bvJffl7Bkqy1a
	sYJiG3HvdV/RjoxAHUKcSvXuIMLWje8cQFTtDZlWAS9t8X2rhKTj2k7HgTbMKUDX
	QFuGGdG9JSkNE+Mu8Of+tbkydk+L/lSQj3MJz4+4rrBrovw9kki14zdKKQZdpuxz
	eapPCCua+GAuUhX2bZ5fhLfmnmQ7DS0ISZb2zyQJhg2n4Mu463j4ZaQRzShN0Qim
	wHhSUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615sy9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bc5ecaso34671461cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756421309; x=1757026109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvS+pfSkiXK4ob+ewthYnY+XCoXOveBrZR1sStGKsLY=;
        b=n5+hDtoasvcXRX4nl6dIiuhwFv4yMTUfvUmgWOdQ5p6Zw+DaCg9hBJ7Gmx2gTOzDZd
         PpOVOgkEOEE74U68rvFuO7FR8Mm1ItL9YWJRMGv3VYPJGTNMpUQmil/Rbf89T/aizQes
         RNI9/wniVW6v4SOBuDNp7xf9ueQCBNlFo1862VZ68CISYynNfY6HW4L5Q/cap53S+S6i
         phJWkGO9pQTI9DUxotMN83IqA4bxvkFqAsJIc1h93bP02+yJWsqaRVApodXI0y0knZTA
         10e/LHZbQODw/ZJ4Gw5J6h9YBqOCmJ84IOdGo/XhwVAgRFkl6tDS19C1lVgC2EMnTdjF
         iwUg==
X-Forwarded-Encrypted: i=1; AJvYcCVDyQsHMZ4+CHE/j4aXG1b2u9TUU5yKXAbBhFSnOczTMjr9AO/9QKFD0sh/3uYU2FO3Zf2QrRn6vtdAn5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJJ9jVMr9nQANbDj59b1iP0fZ+mIq/UcN6Jr8Cz5R3WqtEW5G
	NyrysYIJar5wC7el1PXtUbGIoynWbHrC+IUc/8C0TzC07Mc4O6M0wRXx0LFELDIe9sqJqN1UVAD
	OB1QUPZvQfHXVUSSU7XYNdVJ5ahSb0uuqrUlzpYcGPgKf2Zr1q4tTJ5y+lORG3iVr68w=
X-Gm-Gg: ASbGncvjWX6yGOeXSgeURNB4lzMLNigV2R17ojFnDmElWHZnT8LM9qUW6XisQv4EI9Q
	aysytdxkgxa3fT7Wf6SMjM0bPKOMg+vns5EjsWFRrq9OKW9lPxwY/biTj4x49nsByOvLx4dz4EP
	CS/At9roRq9bKrEMaRLV/5lnj8IWhkwhcWbk68gJu8fZZxARyc6u8t3eJxFjlUAc0dEE34pRgYz
	W74bV4CB0yO3qV3FqzmU2wf5Ad9a4h9RByw/IE7ewm829FEbHixr9PRaAYIHkxVls9wuyrOArsx
	APuu+AFkTdCzMSU9zn0TPCnVU4dcqbaZVcYdit0SsD9w8uEYmcIYRF01NOazcw2nQCRyGAcPyDW
	fmQrUtXEmNfLuXSjidtEZpoxDrmvnLB2CWq6w1NZNsZn1iQrFyRMj
X-Received: by 2002:ac8:5d0b:0:b0:4b3:c70:6b91 with SMTP id d75a77b69052e-4b30c707d9emr9878511cf.1.1756421309417;
        Thu, 28 Aug 2025 15:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVn7LUU1wLuo48uIzVLIpSmBydS8V9QqNajZ72cj6g6Z/G/PcNUWq2BIQBuVAWtOfCSAhapQ==
X-Received: by 2002:ac8:5d0b:0:b0:4b3:c70:6b91 with SMTP id d75a77b69052e-4b30c707d9emr9878291cf.1.1756421308958;
        Thu, 28 Aug 2025 15:48:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678452e1sm143807e87.85.2025.08.28.15.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 01:48:18 +0300
Subject: [PATCH v7 5/9] dt-bindings: display/msm: dp-controller: add
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-dp_mst_bindings-v7-5-2b268a43917b@oss.qualcomm.com>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
In-Reply-To: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UnKbj8oV/I2z2dmxNHPVYZHaNtQSEhlpqnpLKeNGplU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8aGOxsmRflPs+cW9GrS5XbfvoS5da7xw0KR6e0h/jsST
 njGJ8ztZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBFotj/V7yVaur4HN4oPv34
 9P1rrt9L/15X6CkQc35Oetpqvmeln7kYAsz4D187wRr+17/Z+93eLy4np+y4/v3wfPMDZTdivaa
 wHrT2VjJ63Lp5guKUI1UPiq9n96eHfH8snVm065n+Xp5NC5oyzs88qpPLx1EVVxHNX63Dsfjbau
 Gl6rMv5Ya17zhSqSp7/LF1hxwzC+ORoHa5u1vOnY91dnfQfCCyyiPv4P6oJS3Pkxy5X6z+Lv3XL
 /FMea9mXX6N/ZnQ9TqqU/a96JE6pPH617s/1dEGk1f/XHlwgQtzerdRooKGjYzyrKrHp/tP+CTG
 3V7dbHDa0VXmsPrSFu+fz2L2uZ3Yv3hWUQv/stZmN85vAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX5PYV9dmv7ewH
 /2+U7p6X++dY70ONpF/QKFP+m+gGxPohJnGR9YGGSUp6TUw2QpRzuxsk/fEd36zEsmROJ5mGumf
 xRp1QoADKaiC9QDd5oro+liyy/KeF/UW4TpOBHmWxgbAzTfj8hbbJ97PEpc/slXX+f3xhIVFoxZ
 jLLp5uOi1n+dsUJtLXQ4pIzFK4ySLf/HbqSWd4PUYhu/Next4yoXv/K8eX5cYnsxo5hUfbJyIxs
 2LPU+2kgFm9hu6qmRo6fnwMgiKQ8OrEZfSkUx1o62V5IQsduIpm/FaIzKYtZYESIMdjQDfPPXUd
 JvqZhzzqVvYXRz7xXeKJIxKMvV6De9TQYpLphnUTUZoyQa3b98IzcjuhT5Rw+Rt3M9Jd0RD3a+J
 wUaC51Z7
X-Proofpoint-GUID: 4VNfqT7dk3LDQ-U8XQFytn8oRq7HAk19
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b0dcbe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=LXTjkAqqvG_e-hvHT3MA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4VNfqT7dk3LDQ-U8XQFytn8oRq7HAk19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

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
index a18183f7ec21ac0d09fecb86e8e77e3e4fffec12..6316c929fd66588b83d3abaf01d83a6b49b35e80 100644
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
               - qcom,sm6350-dp
@@ -193,6 +195,7 @@ allOf:
             contains:
               enum:
                 - qcom,sa8775p-dp
+                - qcom,x1e80100-dp
       then:
         oneOf:
           - required:

-- 
2.47.2


