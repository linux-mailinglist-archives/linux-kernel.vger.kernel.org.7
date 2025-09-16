Return-Path: <linux-kernel+bounces-818733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D024B595CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31F87AF2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BC30BBB6;
	Tue, 16 Sep 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUyLFPT1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B9101F2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024692; cv=none; b=DVLVj/vev+i3HdAV3VXk4DpsAZJiaSvYy3aDqtiCpr2q8eYxiu129197pJ+1EYjo4Y//aqJ5sVou8xXuldAMqy2xwEuY+efsSvWGnBHrGcoNXslz0Dwugw/1b/RTbef6fZxF5GJaeSKC1Ur6EFeBcUxvbpPv/jrQfGdrYla7cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024692; c=relaxed/simple;
	bh=gN1Yn0VpAUn7s61raHRdCxjlHvOYYRG1fBqsrSDL2Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iN63uyz6CPNjzbwi0cf/HQdyq33UZ9+Gbrch+c2ar6h/6ltNDobeJj6ad3fOM3CFzHpKiGhl3stIp4xBKV7NIZ1IDDCRuyyf5UwFvc0tqZP/3FKDkSZdBVcsZI1fADcgtP5Whp3VcymwInlkzYYOKFm/EH/fhqEzB137Ebr6Gck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUyLFPT1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABuPq020444
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I/1QUiWOzVEO3VoHMdH+VY
	/0cv7c//ZqTTeZogz3nHQ=; b=bUyLFPT12tjtAzwgTMPn3I3T2WZ7iNGjVHJMMQ
	SrYwZskuxRslLu+y1pngDjZdKlTX5tne9cQhgc742xk47DJpMFScSmcpJysro6W2
	v8UIV7/cJ4vn+Hz3t6QPhONHmUHWiPDYtAcsCDXUvqE2oBzLi3jEUg+Qimhsy6jx
	nscsgl93QZAvYqedv8Ixxcl0ep/xWYtbqGj1zUYoAGnA7svkiiIGbVoEs9Cy6zhd
	1sbHM+t4cZhoNEkO+o6CdQELMcuzrzNEHcuTuoEpRq0rBOgdd9/dzcjtC6I85DDg
	Oj5AOPaQqavJDb3sCIbBQCp1wHxZxGMrkyxPt7del/a/7gaw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sm9ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:11:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2645223059dso2619225ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024688; x=1758629488;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/1QUiWOzVEO3VoHMdH+VY/0cv7c//ZqTTeZogz3nHQ=;
        b=r1hwpM3qQWrMzXu0/RaqP+WieUiOgmZENNDHw8qCS/XZTMjwD8NsdsKTFqUY8n74rZ
         jM1hK+jAVT+7OjXA4oFiOh3idj0lGQQnFMTwFveFD0nYO8q1pGVdrgPugRuaVySpWoGm
         kn4YIefdjuntmbPUCSYox6Nkk0XiL2J2ZnTUQ/zC0jpxoDzLZARaKkX4x0d0FrLcA9Aj
         SMjcMg1aLNgEzz7JoEm6Yc5/h4VNTB939zS9HriWNBWEjJfTdf55eCIrBORamaFqN2+w
         e6HVrPDVafel1575YozmNNazN87Sr4M1YzKquSvifD3cBnbzchr4wNAYNTy2hN9rpTN+
         F52Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF3i0iQfYWLvP+z1wI6ppSmQrzNSA8VJIy7zHd7xhHzwqJaT1Qo6wKtu8ad9SY5LR8sUnv9Tc/nMxs3mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVD42ozX2fmvPIG/Rdg9Kb9TODoYz2RqEl+VQlZ1Ww1yH5RFO
	zqQmNDftDUcRPa7IsTBacT1iYM/xnmU7bh2lkjVTB7m3da+PRYNWHB+wwDgAPoSwdwoMNbJ0RT7
	lDZsr+gA2o0ZBDsPHEJSWyPr+9Rf54b1BWfav6vn4v8fgfKQ3np1ZkvS3CZSBIE4E1xM=
X-Gm-Gg: ASbGncsL3FMn+I4lt5gUcxlguWxGmPaeHCyJCEtysJ+vfVn6RbhxqnMqo7jHVPs5AMz
	kb7f4gBwhmxM5XZH5HsUu0jfbO4SbnFnAZI5mY/3Fg/VEhpQ3V6TV6QKE0p+l342bvFj8S1qnK/
	rIAZLaghPeGZsDx0y1sXbc7KBTwRJTIk1BsPakGtlcoTI9mx24HzpsLSMobsXxPmRZFHyAIv6eH
	uiUpeZOWgGQfS8eZPF1xmGI4VBlyaThSdC2JTS3OWvc7OAwUBZpoWLj46ig7syzk/WVNUmR2Tgj
	wWhociCB648kgNqOZ5qQ/vYPPVCcaVwdhbf+XX5PtPDoWjUNmxGz0sVBQc7CR9Kjarsx8BvhGs0
	ft3R3aCHzKsTp7Q==
X-Received: by 2002:a17:902:d4c4:b0:265:faaf:6786 with SMTP id d9443c01a7336-265faaf6aacmr57817605ad.9.1758024688211;
        Tue, 16 Sep 2025 05:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1RFXVSoXe2CpCJjQa/I6g0IBtRjuRx1HyyBA7zcwcg518iVOozlceyedzv3YXnIBdF0x/fQ==
X-Received: by 2002:a17:902:d4c4:b0:265:faaf:6786 with SMTP id d9443c01a7336-265faaf6aacmr57817355ad.9.1758024687596;
        Tue, 16 Sep 2025 05:11:27 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293edasm154917085ad.37.2025.09.16.05.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:11:27 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:11:03 +0800
Subject: [PATCH v3] dt-bindings: display/msm: dp-controller: Add SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANdTyWgC/42OSw6CMBBAr0K6dkhboIgr72Fc9Ic0AVpbaDSEu
 1tITFy4YDOZN4v3ZkFBe6MDumQL8jqaYOyYoDhlSHZ8fGgwKjGimFa4IQy4UqAcSDtO3va99hB
 m56yfoLVpHxipMFS04pJqdZZnhpLKed2a15653RN3JkzWv/dqJNv1G6DHApEABkxFUYpa1KRRV
 xtC/px5L+0w5GmgrRPpr/vg85ECAV0ypngjRF3/c6/r+gE47R2zOwEAAA==
X-Change-ID: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758024680; l=2207;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=gN1Yn0VpAUn7s61raHRdCxjlHvOYYRG1fBqsrSDL2Pw=;
 b=dnWAH94x2hSw2DgxOZu5/hAEMxbWiPfFDHoqjvA9O6N5tyLlk8u82ECscoUEsii7po37OjmpQ
 2qAE0CjTfxMDn/tNwhtFcML/kBMWivwzwELwrpA0amJOZPXyLg+1r8Q
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: _-howUiZ_t2A33NdqoUUmx8p_FZLm662
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c953f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6qpd5Zjz4k7RSA1uLzYA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: _-howUiZ_t2A33NdqoUUmx8p_FZLm662
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX7iwk5buzaxW+
 GuVpm9jAuvw1rWAUwcGifSbnH3v/oddtJylq6xhN00NxrWmjulHQyba79qk94adRNkQ4Zi+2IAZ
 xQ9SePqeG29GxfTJu9pgVp9Yi5hT4DVvIU/c5hqZ+8+LYfxeYQaGRfQ8MrQXhWpl9yxPW6rC45x
 ARnYhKJMfx8WS6d9ZcXRK6IEhPVG1UVSKrXEOT3+ym0x960NQKL857q5+alrtJ12q68uKfUux+j
 IqADCWQd4pE1utNXrNkZzDzuSG9tvk1lAZfqEXnRCTuoKpGryiX+g3Fq1TPePMq1eYNX+GyX42o
 dSMiBr5E/0nB1KgEr52zcIMnp1AH7LgycM7naAcmOj1tB+97HcCsupcguV0QZ74Zr/W2kEAF4wV
 cQz5SMXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

Add DisplayPort controller binding for Qualcomm SM6150 SoC.
SM6150 uses the same controller IP as SM8150.
Declare 'qcom,sm6150-dp' as a fallback compatible to
'qcom,sm8150-dp' and 'qcom,sm8350-dp' for consistency with existing
bindings and to ensure correct matching and future clarity.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
This series splits the SM6150 dp-controller definition from the
'[v3] Add DisplayPort support for QCS615 platform' series and rebases
'dt-bindings: msm/dp: Add support for 4 pixel streams'.

The devicetree modification for DisplayPort on SM6150 will be provided
in a future patch.
---
Changes in v3:
- Update binding fallback chain to "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom,sm8350-dp". [Dmitry]
- Link to v2: https://lore.kernel.org/r/20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com

Changes in v2:
- Update commit message and binding with fallback configuration. [Dmitry]
- Drop driver patch since SM6150 is declared as a fallback to 'qcom-sm8350-dp'.
- Link to v1: https://lore.kernel.org/r/20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044a0ff1e78ad47b867e232b21df509..34d5b2984b163ef80501ae403db9c2d7c1c4ac59 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -53,6 +53,12 @@ properties:
               - qcom,sm8550-dp
           - const: qcom,sm8350-dp
 
+      - items:
+          - enum:
+              - qcom,sm6150-dp
+          - const: qcom,sm8150-dp
+          - const: qcom,sm8350-dp
+
       - items:
           - enum:
               - qcom,sm8750-dp

---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


