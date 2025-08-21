Return-Path: <linux-kernel+bounces-778857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC06B2EC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880253BD829
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D52E03F1;
	Thu, 21 Aug 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g40H/CvO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42132236FA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747429; cv=none; b=aPKOD9qwhTQ+C3no/m7TAuQx+1NCqxKpozaz1PET1Ap2+0k4ugyxpRFEPUvTgrTjNmmNQWULmlLCb/AAAxe9Hedkb/MDrGAEMMKbiQOjARCue5Bl2xL+jNHJJTCZtFz3zXA2e+R8Ivloa7ztXOswl0Q6vItlAV8QKb+NUvnkmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747429; c=relaxed/simple;
	bh=6f9cmGYtufnRAs378RwA99paFx3sFDMfAVWoP1M7ZBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GErJ6KF7iY985+oJDgZe1QJVjc3YwTGecMNI92UgTafZYEdrKU2GLgib+ui8isRxCdMN22ynAlGKiTkw0Zid6uvkLXKfOeOQkhbPF57CEioNTqroL7t/cMJF0ffDZNG9EDdieP7EJj9b8+vJvC7uuD/BqBmvhejFufqwAovShhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g40H/CvO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KI1d1d024847
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	omxJk/QLsF/URL1wqzZF1tJVGEmzz/NZQDpAN9aE9UI=; b=g40H/CvOOCILTvzW
	r34h3dH2d4Nat9Ooj/MarxfAu1lXA1k+u/LSObm63lEoXZa392SrJpeXn1trGBTF
	sWgIrqu1CFen3h0rQAQ/VGf7I3iKdWohDlDq2+cN2lYy/ZPpazaerH0RO6HwCsHm
	iniPnoiyQLP6cK5b6U+qQ17L5Bdh2OesPJKG7Vlai/1pcC8HRKIDsZJlJiy04tJB
	zgprs5zCFV0WfUhUWwV7jamrmDJTxNXFM968Ybegz44JV613ncjXhPMk5U3FzJsr
	nqK5r9BVMyA4yE/nfBsYbxOx7h/iP4OurXA0fMXAXVuEOKfi/o8CS5E0gmVMdPDe
	wRD9Dw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293vaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326bd712cso570727a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747426; x=1756352226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omxJk/QLsF/URL1wqzZF1tJVGEmzz/NZQDpAN9aE9UI=;
        b=vKaHKRCUdtCs2ivHntqfpEh5De+1H2RrgTgVc0h8PiJ9IXtbS3TKMIdLl0d5TbX9dj
         RMztVYhZvwExMegUyCmNT0aPrgkh5gjluYcpkcMOX/6g6nLH9xQf1oza9tdsZ1qmIoBQ
         BV06pQa5s/bNbuqL0tD/QDc4zlDrusSsdpz5EQh2lbbrGF6JrzjdbFUtRA321nO0/lMh
         p0IVbxN1CPihg3SIFfxRxSjj9PlYC1P+Hp5O0QdEItwnwEQ7oMC3W7X7TqBV0i/quHJt
         30/Xa48rOGOr3EMUP5Q+P7dnMBXOiUKe/60oX7PC6smpLQvyjLXeUQcwZZNi+sq1lMGU
         SpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgBa4Anc5dyGy0QPvgbzdyOKq9MNHnf2KLkF4Tnt/Jk9p+4GySybrhRbYsMylWaYHvK5UaVedHvQg/2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQ2lPTzmYSe5RsvZbIkIB7MKI+MZd5KLM4MnqZdgHM7Th8twR
	x6pyO5CpF0d9uO8KRieHVprgSoSHF59b4I2+RIh3kFJHjR3yjAJ/NznZyIzqyJo4QqjvQhW5SYp
	sLyNP+Wd6yi5MCwQZskBmbuYRH4AOa5Rv/MMaS/bUwfxCV4YdV6OSIIlXewPan8QxQoc=
X-Gm-Gg: ASbGncu83fCQ4S3qNsTxJY3EOTHdAKoUKmjDvCI3MBSk2xtuYDwDzlyIFhOQPL4mz49
	D1kVtyfmWeY/zRn/OF+77VG09DkJDU6YeVqHSmRxEN3ZLnd2BlsUiDLfLuBFSFktwbGdRbeKp+p
	/+rVBU3s8lnwkC3uC82g7w7BAkFZbtDsY8nHGJHV5Be5yMyonPycWMDtvWxQ4Xqa8u5fvEkpFBh
	q+i2XAShXFOxn15u0UN7PWf9mE5fsQjjpIJYD+rs3ceFB9liigUYAtZu8l6NFu9/ccLBjD4RdrW
	J1Ezb1nBhnWtNQ1Qs2mptYQtXrQJXMy6jE0QNnwIGRYPvANl5athh1aQGCVth60GE0a3qpU=
X-Received: by 2002:a17:90b:56ce:b0:324:dfd8:3426 with SMTP id 98e67ed59e1d1-324ed1ee38dmr1418810a91.35.1755747425984;
        Wed, 20 Aug 2025 20:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx46auU6qYMPp4XzqLucpZxQ1bH+beazXC5BTM1j4dL8s7ED+RKFNuTGpweOJALF5bCoQX4w==
X-Received: by 2002:a17:90b:56ce:b0:324:dfd8:3426 with SMTP id 98e67ed59e1d1-324ed1ee38dmr1418779a91.35.1755747425484;
        Wed, 20 Aug 2025 20:37:05 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:37:05 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:35:57 +0800
Subject: [PATCH v8 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-qcs8300_mdss-v8-2-e9be853938f9@oss.qualcomm.com>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
In-Reply-To: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747401; l=1857;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=6f9cmGYtufnRAs378RwA99paFx3sFDMfAVWoP1M7ZBc=;
 b=NrBvr4xND8skJH2gNVxfDY9yR0QY6Akwxx2oDzy+7X8VxbfC/fSaDpa6GKxdLLGqouLEv5nL6
 kEf/Ot5ZrEsCayuZSFYD+vgSexudxliUd8WDYMh5A5fDG6s7ygdb5dL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a69463 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NNzdlKEZjN14YBeL9RkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: npupmLCX2yNBYAFuSsCEaO5A9Rmxli9i
X-Proofpoint-GUID: npupmLCX2yNBYAFuSsCEaO5A9Rmxli9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXw4B2P8y12HMW
 3I99R88WRCDZyePXFze/ATMUwniE08P2v+IQfA7761eqhTUjSrGyzXHEBWtq06vKlJRv49JpPhH
 hne2+4MkSTWs1OWc6OXh3UBik/4J5L4xm7JtMwDkZ9KTs+Jy9cTMYb174CKWGKfu1LDKERzAS+T
 pFgoeHOUbxtaHthmJ44NQjixK45OdJUlQhgLIg4rZ5CjtRk67CaH0ddFGLA8k0uL8aTzz4pDBFi
 6Ej9D+rt9B1Ev9j7g/VQQjkeiXbR6j5GV3VGKMp8gdxYTzyM2Wigxp6JRL7IK29McF1t394JEO3
 shvwWypZAf5ZzU5803aYYzCYhmqsK0LDBeHd17i7Yu39R35oxXSiDdMvEzWYJXU0LxTKvNL9Htl
 6HQYixvmNYvgjEpGlCRSmTk5eR522g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC.

The Qualcomm QCS8300 platform comes with one DisplayPort controller
with same base offset as SM8650. It requires new compatible string
because QCS8300 controller supports 4 MST streams. And 4 MST streams
support will be enabled as part of MST feature support. Currently, using
SM8650 data structure to enable SST on QCS8300 in the driver.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs8300-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -179,6 +180,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,qcs8300-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -217,8 +219,9 @@ allOf:
           compatible:
             contains:
               enum:
-                # some of SA8775P DP controllers support 4 streams MST,
+                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
                 # others just 2 streams MST
+                - qcom,qcs8300-dp
                 - qcom,sa8775p-dp
       then:
         properties:

-- 
2.34.1


