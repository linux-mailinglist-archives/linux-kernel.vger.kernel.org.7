Return-Path: <linux-kernel+bounces-798437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F0B41E00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C1B560146
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3962FDC54;
	Wed,  3 Sep 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JyskRiBb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C342FDC27
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900711; cv=none; b=pBrk69mecbSbW7c0ZI/i0cQf+pj4vkOMq4M8nhPC/pElugvf6vEdtRdkO3dUBXjtx+lu3MUJnrPNBXFWBY7XU0UXRWPf8bYtsl1RdKSAiaDDTYUO9iTbwerDPbUgIlsUfDwWKBXaO6YFBFd+abbgewnnnGcI6ftimtcMhLAAkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900711; c=relaxed/simple;
	bh=7SN93yAhsVlIHhAjv83yfgqh9HpWqOytsXh6bquwkv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEO1QXw6dRBl1M1j0aK7DSO6CSc3391im+CUiMzrDVWZIaQ4G0DelebAYMV2Hyc50PO0Vg3gmmGRhwQiETpS3LReerQ7h3855siOjmNpFptneTj2meM7Nsn0n4h+gsWoBJgnwA45rnwd/HjZKQhpPZ8bwJBHhLjx6EjqyR8BUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JyskRiBb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEwtB000792
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	atpsxElvXgCLWEtnfNMUFNLYSDL18dufzTm3oOR6c98=; b=JyskRiBbpjmESb46
	EDPO31Z1EZ6yvegcHcH5dnSFNCxtWKQweEDJiHgII5QuNkgrqz+jiyEukqN5+ZZg
	ODBPnlNl0Q9itxQvhstV5cVyfsurT9JDf+Ql5+L2VmbrSLjCQRY9ILs3m052p5y0
	xcOe31KxSvXy9T8oQfx9f3XlR0Ikc5H8uzUqNw8gBlJllJOjRsumjxgW+AphYR0g
	3hl/KaGrvk8E9kf9WO5BCX3lRE6HRMSsYctWj7E1+FMr0IzH6sQKouRhBytHkF7c
	4SrhuCfWG3+EHxuM18Xux1+Vm2tzcymxAditpe76q7TWDLXW2giX0PYqSY/H+SZV
	mxys4w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33d4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:58:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3349c2c38so76168121cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900707; x=1757505507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atpsxElvXgCLWEtnfNMUFNLYSDL18dufzTm3oOR6c98=;
        b=qOOKx8mGQXALRyyGKKYjrzMceY8VRybqcWq3hjcAqm65qy2cAzPEN3RAZYoF8DlL/g
         sdCL8DENLGGS+/eCFimfhpguIQFSR+1W5YGQAY+QnfDtRZF9OVDnMFzlxmjYi1f7cf/0
         WTvT1SJSYozJ0ohyW/WYN1uyQ83C1Ky3p6hwUGJpRCl9bEiXaLSGCCMhmiUTg72hko/N
         VBFKaJpiRMgbCzeLKfi9/OGWTU34lgwVSbd8O1lmfGB0oJgP8fpwc2E/eyrNjlw3ooAg
         shYmbh44dZe9HkhFsVdozqkBMBw9r140pTNwS4m4GOcr7w4KVDj0a6ZUxOnunA9N7Rpi
         z1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWBq4FvkBd4d2U7a0Oc+Qs4INS0v5oP3WgIR7hvs8DVhaX7hvR12o7sSru75rTfVpNp+scxIati9+Pejcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJwEyDcfCzQUJ21UXZxvXNJw6VSZPohqaGZCbYpakqGJ6iQ7O
	0v0R03BG6EsPNAciuJrrVjj35G6MSoWHOtHmRuWCswO2Uc1CpD96I7K/33ouZjy0ulGJCnWrX3R
	UxRFTQLhJY4rmuxKHEQxFAi7lyd2gwcMSQ654GqneS+qKGf3WIaDW+muuXU07LOF3FBA=
X-Gm-Gg: ASbGncud3XRyE4Cr3GRAMWCVH/Sd9LVFd2P+mV8T8wRB3sdMYN5umjXmydTFz17roS3
	KTmyAsHRc62FLVCmq4deuAXh4sli0uE+rJOK0lgSGk6Sk4LgHYumyQiu+AFyS+EAyCIEieSktlY
	Zyla4SvZ6ZCXbSvAG1bUPj1TIHblaFZ9zkOjaisicKDOU0CEzjiw3n7MzCdGXvoJNHr6xg35hEa
	3Cq2IOxFZoCH+hpjcJY/EL2mEMUJw9rcfCU3zpnmDaJvyfKCYv/jaugwXFJYmo0CRT005qkM849
	ZGXV6+pRM/HvdiUI9AKlu5uX7rezE4JPwh8bhpflh3YxCbv16oJcVW/cdj1His4rrRdLvKY83fX
	Q86W3G9CX2heKe53sQDp9ZfyxlY4pVQEMQMRY2Ej33EWMp4pXqCaS
X-Received: by 2002:ac8:7d03:0:b0:4b3:963:b3c7 with SMTP id d75a77b69052e-4b31dcddb9emr153033991cf.80.1756900707148;
        Wed, 03 Sep 2025 04:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb+EMS2bgzjF+wonzL9M5BRn88S64ov/ovDLLFNBNiMqEsjMGSjj9Gp5N1zKTttlgvTkbhnQ==
X-Received: by 2002:ac8:7d03:0:b0:4b3:963:b3c7 with SMTP id d75a77b69052e-4b31dcddb9emr153033731cf.80.1756900706608;
        Wed, 03 Sep 2025 04:58:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d30b0sm9891421fa.67.2025.09.03.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:58:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 14:58:14 +0300
Subject: [PATCH v8 3/9] dt-bindings: display/msm: dp-controller: document
 DP on SM7150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dp_mst_bindings-v8-3-7526f0311eaa@oss.qualcomm.com>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
In-Reply-To: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7SN93yAhsVlIHhAjv83yfgqh9HpWqOytsXh6bquwkv4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouC1XzNKs3KOvrfNw9T9A5PinobRn6+BUmHYpZ
 AbXYmzlA/2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgtVwAKCRCLPIo+Aiko
 1fDkB/0cdD4STyN4uofga6hg4Afg4alqCVv877OF09D2pr1z2nA5rdLzvmgnUcMuCfflk0wXjHJ
 bXsEEaz14lZtPp4J7G85o7G9VjPzwXeS+sUHRbWrm9NXR+wD2RcdMefCPMdcbueKkVTkQYgbgLf
 1FJVNEdeUy3cTxX6eCsIthEtfOSBCKGU6DvSa8D3UYbrbIpb3au9HwSzcrQ136I4QrjjRc4qZlv
 0hS9T6hv06o7YlXVEKtOOtgPd/PmvrYjHbiN1jnXrHriCAdu7gl5s564TQ8jmumSQFQB4GC74Go
 dV3x6hMYJ103JuT1RIOZFoae1XywiZB+ZJLIyFcu8cy2FZ/J
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+se+vkQJBqIR
 ZWDAuotjtH4pVLbDZ2SaSc31GaV4zeOznB5Mng9UbaMzXriaNIQY3//K2lfmsDVtbkNx2jN8DEo
 vQGgMbBNCY8fxp0nDBh5hfjm85lTpwL3bPYlaEOE+CfVSzGH5PiHyR0MH7fiQmZ3FK2tLLxQ3MM
 ktPaccypGoAihg9FtM4YH2xCVWgRRoo8bAeYvHHJZRzhhFuZxZ5HVAYM0yw37y/bmcO/gZGEphd
 kTpLcvWvflWy530Zm4sxMpdjiZAV7//d42QktI/WiST+oEJH7rgC6NpzHFvOvM/UwE9lgPAbaeM
 9QkNQH720ughCKBbTUruzlvUhJUEZyDU2PrpstoaHwOX4IkQJAUKO6dBIEcv8TYIiysFI+S6hK6
 hitq+85X
X-Proofpoint-ORIG-GUID: vMdwAto6eeoXTbhLuOkpz2g9WTmUdaNs
X-Proofpoint-GUID: vMdwAto6eeoXTbhLuOkpz2g9WTmUdaNs
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b82d64 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QYKTPsKsHukT_2dPOMMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

The qcom,sm7150-dp compatible is documented in schema. Mark DisplayPort
controller as compatible with SM8350.

Fixes: 726eded12dd7 ("dt-bindings: display/msm: Add SM7150 MDSS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml    | 1 +
 Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 0f814aa6f51406fdbdd7386027f88dfbacb24392..a18183f7ec21ac0d09fecb86e8e77e3e4fffec12 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -44,6 +44,7 @@ properties:
       - items:
           - enum:
               - qcom,sar2130p-dp
+              - qcom,sm7150-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp
               - qcom,sm8450-dp
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
index 13c5d5ffabde9b0fc5af11aad1fcee860939c66f..c5d209019124da3127285f61bf5a27d346a3d8a1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
@@ -61,7 +61,8 @@ patternProperties:
     additionalProperties: true
     properties:
       compatible:
-        const: qcom,sm7150-dp
+        contains:
+          const: qcom,sm7150-dp
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -378,7 +379,8 @@ examples:
         };
 
         displayport-controller@ae90000 {
-            compatible = "qcom,sm7150-dp";
+            compatible = "qcom,sm7150-dp",
+                         "qcom,sm8350-dp";
             reg = <0xae90000 0x200>,
                   <0xae90200 0x200>,
                   <0xae90400 0xc00>,

-- 
2.47.2


