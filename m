Return-Path: <linux-kernel+bounces-740319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043FB0D2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5475547611
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712022C3257;
	Tue, 22 Jul 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVzq1frN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560192C15B5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168955; cv=none; b=binYeDfCSVl7RoTsQiQ0CE19H2j/BqjCBgI2IdbhegAuTSeBrKO7LNNtDGnO0/eiRIuYh/bAn4A80szAMaUJKX0cydiZTrXiZBxs3eFvE7+pyVyP38f8X8WV+QCF8MTs3M4FaW7B6OLWNfN+rcieb4cyaJYzUTI16QfuAiixTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168955; c=relaxed/simple;
	bh=flVURwsSNZtWM0+fUgJqZKMxwfIi346lSujUoU8vBq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXqZtjLlLck86tuKKSVDaWzo8h7lMVJPUWwFiBxWiGzaiCYcph1q0kCcwDzJqzEPXeN0hrVdiQ7IVkVzy3PWjy8rC/cwuOom/sb+HJICLw2ukz/Hu0pc5EFlMr1eOxb+6+G+4ANcXOwQ3IWZgz/YiW2Tjnj2CJKtDx90TUmdneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVzq1frN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M40lah001178
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6ZwzV2fRLwP2rYYHbwT2Ikl/JBdsp6+MNb9lNC0zc4=; b=TVzq1frNL/SlSxtN
	WI+DdaVgz6Hgu1dXskmqVouqvahpmof/0OcnvL5kL65WYFsihlhnXTMxd5b7PDpS
	hRONCm69aDPDhuB34dNDT4mgIrOkPtc9h+UN+pqPnt14S1WUNzT5JaEmiR/55vK1
	Cfqa0LfPtFoxvqj3jZ2W1mIEMuUWsI+POp5dUBJqFhp+5tc0cE2Um8qxBCD+XoEI
	9J6i3JkXoR7bqPkdr3XnKIFt8S+n13rMwfomdNVnE7T/fkNftGYKJdkXMUCewhZA
	PdHJeUNUbaDwsulrdYQ4trXIV4URkJg3+94H30MxIXQMSmQvmLyw86MJJPT1p8ns
	3aPo/Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dgcd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23c6ff64067so1614105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168952; x=1753773752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6ZwzV2fRLwP2rYYHbwT2Ikl/JBdsp6+MNb9lNC0zc4=;
        b=O94Zdclglq7Ewm9ojbexSDOVweyDgKja+ZNgrM0ZR+BCa1JmSCdebffD1lJhfAqpyL
         1KEBKkI25D3wOLgStxXTRtirRVChXNHpVx4SOQWLwOQ71TLbIpJ48yfiIoO/FOuVwiMY
         cL7/x821A73ytlLw0td59dsXBQ7129O8D86cM8cdxkc8W31X8tsKlWeAA6I0n6wDKmmH
         lioJnlZOvl4J6j6Ts3ZTcS0/SaOMyWYfqSh6bmh+z/DLk3NerCeFKKV76VFN9V5lEZCA
         LvpMtqIh4CG/TelOO/KLPsPNpkijbrPPp3BnyxC89fhpEpKXR7LtbH/S4f+ex8yZSRyc
         Araw==
X-Forwarded-Encrypted: i=1; AJvYcCUd2UAHt0qQh7jTAFxleftzfmE5/5ZvNc9/SoQJ9PvIu3FkWuhZoJKqPys7KRppb81Bf1/ieVvc64o9BEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozinCTOkmgUB/XRdkKFdRqAEEJpn2mXRDWmd72QCY//JRQ+FL
	rci5QjjIgyVlJKH14ER38d/lu48RLb2aP31oyssQYy5HZgL7JHyMD+S/o3dxtpDtHs44s/kYHuH
	jV8HFwINaO6gIEIMxKUINXGsxAqqZ6shQOCLAvZQn/IpdtCFsTLTaLifhyv+eUswgMtM=
X-Gm-Gg: ASbGnctLW1yVswoyvjc3uwSqiIGuB6RhGX5PrRJUmveTojoieeV2ZTIwSAdmnH0B3Fw
	kkbNUpYz6nghYWUW1wN3ngt+40wwjbIJWX4hmrKWiE/UGavf88+2aZD+pwIxnpoS5fA4OkZEBbs
	7juU3rbywQC1zporTHblA5alM8pSH2sUUzpg8cHgZ0lKotTYPPz3ckhnCK0FaIdxGWqp8yj3QhJ
	BMfSTkMzgsugmGJ2gsU3vZAhM9YwDgOivFkToLUCoyXfIogj+3TyP4Xmzfr1xUqTs6wpKeZ+B0g
	G9eC3SbJZ7OwOybrWiHjdcgsTMsdBmDvDM/C4IcW5rCw3Xkx027jr90RfLvAoODdQfjSBbI230o
	kiAI3zxKOaizONehjrgVOsnUuma5XtARB46FvjnZevCbUW2McdUF6SAcc
X-Received: by 2002:a17:903:1cd:b0:235:ed02:2866 with SMTP id d9443c01a7336-23e24edf70bmr137444985ad.4.1753168951911;
        Tue, 22 Jul 2025 00:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPbIpYG8v2ydgpk9/Rt6e8nvbsQWG0NcHT8nsJPhxyTxGZd676+Q8C/tNJcrl9ABEm52u2QA==
X-Received: by 2002:a17:903:1cd:b0:235:ed02:2866 with SMTP id d9443c01a7336-23e24edf70bmr137444575ad.4.1753168951408;
        Tue, 22 Jul 2025 00:22:31 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:22:31 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:22:02 +0800
Subject: [PATCH v2 01/13] dt-bindings: display/msm: Document DP on QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-1-42b4037171f8@oss.qualcomm.com>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168937; l=986;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=flVURwsSNZtWM0+fUgJqZKMxwfIi346lSujUoU8vBq4=;
 b=lFF3TC9IzWFZbCphEU+PcIbJicZ2nH4+jooaIfp3H+fpT8Ugr8/Lcb6A7g1w4zevBtfnOQzlG
 sTyaMHC/WnDCxaIyrA03rD90NFGzdqeY660ykfSFBWrYsobnqaFRMrc
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687f3c39 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CFpH1fyJroaNsTO7nwQA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PyPCpRtaDtIihImXMUgcMexdplVoIK8R
X-Proofpoint-ORIG-GUID: PyPCpRtaDtIihImXMUgcMexdplVoIK8R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfX784BEhdDdTOL
 uv5k0fl56txR8xME1++kdozhz7r4vudIMYOnKMQoPLrld1gF0Ha2ArSHVua5l5aPiEQncdPA/dl
 svp2kzHvAvc8lZ2LX8QnyWGxFML7ZNPRj5+eHCH3jeMPArgHxY6gY5h1+yPjnFkonOZ9XfTwUYT
 TJhbm0IaRiBNVuHZoF1+vqNwQNrUoemNhlI3YDKipzrJSG/p0QAiL4JvcfZD0bZQBEmF4PQqdNs
 a+GDurgqPxacxwu+mYtBI0y0nnnb1YwUoOlSCER4vTWMnl7MrRxStgBb3hqucIsuHKANGHApWTJ
 CX4U+Msq9BN1JvYo5wK9rG/+fGnVO9eW07Fv3VBRFB0jAQYWr9ujZjaeaOFXUU0fvk2rAC1GkcJ
 vE6Ctni1iMLuIvv5GWxdEHt884j8U/MKkQ/bGuE6cl3kp0vvDZ3kOtKV30fSrt5rId30O5hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=933 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220059

The QCS615 platform is based on the SM6150 SoC. Since the DP hardware is
shared with SM6150, the compatible string qcom,sm6150-dp is used to
represent the DP controller on QCS615.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,sc8280xp-dp
           - qcom,sc8280xp-edp
           - qcom,sdm845-dp
+          - qcom,sm6150-dp
           - qcom,sm8350-dp
           - qcom,sm8650-dp
       - items:

-- 
2.34.1


