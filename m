Return-Path: <linux-kernel+bounces-783953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20EAB334B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1141B24818
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8223C8CD;
	Mon, 25 Aug 2025 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cS6uwGiS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0022E004
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092938; cv=none; b=u4Z56PHgl00897IO64kSJ5JqezWTqxTpSjMdX0xbZDsdyKTFrTY9EkBmq9l/x+/EBYYtsymjr3HIidPc1r8vo4e3EEZRPiB4aROxfpcYU2O/zKDJXXHVBSjMK6YkJWesJxc+qSgBkFXRd9NpPHl2cGRRul4lDpd6224Ez2P/8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092938; c=relaxed/simple;
	bh=qZ9NL3rZTf4mXJQ9YET8ly6Im8x6i53yxwCgWen8p3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RLCd2TkCH4QEL4Ua2vWQhbbsaWElYDWNCKdfKjVGmI7maac0v3xoXGFEDpRrOHu0gVaIMKJ2XdOH/I6b7YMHlukc65MOtf4KAQQV5TIEBBWTPdY+KYd4dZyXP4phpiVi77lsbKHusajourzhAgyAOhu+jMwL0Hqjq9yp2uRdtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cS6uwGiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OMKZhx026626
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ryd2ucdQoY9f5gPBD78Vpn
	Qsr3dtA1iQPjb2w1Brn8U=; b=cS6uwGiSg0BcoDVpitcdcYWfx2TY8M713N7zgr
	dTx4/kfqoy4vWXVl4uDH6TLlmJSkU6eXGVpooLINm3vYOz9F7VA9Z9Xme8LcV3xG
	adGoKApUBUhqYpliVVYmNKZYft2eiqWqeeL1//KVc35wN7uEfZtRMGA/Ygh4kOe8
	jbUEa5jgqAxzAXDVHP3mlLra6gs17A9Qo2Jrx7bLDiEczislrOxKn9U0020LdemV
	8OkbywtdFkwPo/cvCKUUNLJnlhccJXDe+kfnVQ89Xyi5K10wYI/toYHk7Jd2eKmE
	t3tZGsZb1Xv3kUrcTTkwy4EzTPcFv5bc/frHOYAJvtag5y2g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um3kdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246072fe091so54956305ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092935; x=1756697735;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryd2ucdQoY9f5gPBD78VpnQsr3dtA1iQPjb2w1Brn8U=;
        b=kzJxD56t1zfknyrGHU89M9svprS93SS3vgzNLpBF/AM8wcdXx4dcK5EPgjTxWiUDRC
         VLDyZwmmEP2PZ9JO5kcJTdYZzaGc/4k6UaKxpGO6AFwRT+lEPc/+HjF4y6sPTBnfhXG+
         ozhSOJMnBVGwxyyw68g0r6k8Jo4IV7hjBAJ5WEWex40LzdvHBjK8v1EbIZGoabbBYpSp
         04gtaZYK2fwl3JaIS5hLuO+KTWAOGPMrW9o0arx//TOKGNMo50ICUd9oZwWesLSdy33g
         zWRipP2YpR91sMJI9ymv6g/hvoECOxaIWhuqqUN3fmU8Dps4zw7GLxgAQUw9rMjLYNW1
         VeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxoVtcOzNZcmtQpPzJKfuU/fu5ObuwDJlko6Woulh+KT5cDSZ8C4sdjxyRgJ+4xR/aSSdbW5h12OhzyrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWW4NC1EOboIi3xnTkGpWHtDcmN5Y/ImS6Yy1UDAeZgNK+oNvd
	FBDQGcku5vbpPW53wLtqhtDV7gbMp5Xt9twskvHYv/humxTmf1j7zkxhZhz78scIsPQVJhjSk88
	Rct7e+9yILUn9m064o1k0FhZ1dTm/T2OySw4LKv/BcJJQBe8kasI+AwiXkd4iljKbqp4=
X-Gm-Gg: ASbGncuNURTlHqAgtObjxxCkKEgwMha9V15VPYlsELCu/N8NKK0XHLNbyUnfayn+o9Y
	3hpUNsZHiDozHJnfQRQeVdxf+MJGJX8JJw1m8Y9+9vEetWKLoNZCMG3hoAwmCEnh6m+D238OC/6
	91w5WZCNNEbcSbE7l5PETsdD95hzKmyjrEYtj90GggCp135/7gmmp1EYqTBl49D24UvIwt+5K1G
	9/yJmH2U8zxn6k5kyo6Ap0OdmoKdEq9P8t4CxtjpxRQ/6S+VNoJAJeaZLaceerP7hV1UzYJh4su
	w80DlwK8YSJD7zv3ruWtB9dlHI7Yj2KEP0upT2u9gq2TYSKQie7trR2P0rHz368x2/0t3eU=
X-Received: by 2002:a17:903:283:b0:240:7f7d:2b57 with SMTP id d9443c01a7336-2462eeb705dmr137572195ad.28.1756092934561;
        Sun, 24 Aug 2025 20:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZlz+BrNXjKPCdx/qQt5dPlmZ8NTU+F+CBmNtLbnlpD6QJ+Eu4LuSzS//e9Ck4QkG1ZLKxHw==
X-Received: by 2002:a17:903:283:b0:240:7f7d:2b57 with SMTP id d9443c01a7336-2462eeb705dmr137571795ad.28.1756092934071;
        Sun, 24 Aug 2025 20:35:34 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm54859565ad.22.2025.08.24.20.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:35:33 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v9 0/6] Display enablement changes for Qualcomm QCS8300
 platform
Date: Mon, 25 Aug 2025 11:34:19 +0800
Message-Id: <20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/Zq2gC/22Q7WrDIBSGbyX4exY/o5Yxeh9jBI3HTliSNicNK
 6X3PpOWsa3zh/AKPuc874UgjBmQbKsLGWHOmIe+BPdUkfbd93ugOZZMBBOaWW7psUUrGWu6iEi
 9rGVikQXPAilfDiOk/LniXt9ueYTjqVCn2yPpANGv1G31fIdqGg9Nh1MTch9zv0c615RRMFyHc
 rS09W5A3BxP/qMdum5Trpdl3CPMlNWMMEJvuJJS1oxyWua3zXno991w2i0h9+03IngEukDztK2
 YUMAcKKVCFIHVHsBFnmQCEySXrfEiJh4CWdzeM07DeF6bm80qd/dxv0uaTZFRzhgNiUuV1IPMy
 pvtD4bgfxh2KcQFsFo6aZP7h3G9Xr8AndwC588BAAA=
X-Change-ID: 20250818-qcs8300_mdss-a363f0d0ba0b
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756092925; l=5505;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=qZ9NL3rZTf4mXJQ9YET8ly6Im8x6i53yxwCgWen8p3Q=;
 b=wOyNd7e+GbOdi8G9BSuiD2ELPPHF1GGnTt/CoLuynz6f24q1qlD4nk+WsZystwKyZmkM17oOD
 ahNiNakwKMHAiuoPKrV9eUXG+v7P8RQ/W9txntcmuAWmcbhBwBTCZkd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68abda07 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=A9Q8OG8lNi9f-aPTaEwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX00S9PQ7GBwEI
 n2PwU3bBDpkfBQZmrOiYtrgRhd3it429qc6RxKsDVr3JI/cgm7OsyL8/XMKNx5MOw7SvAIXa5ph
 G2Ys8fu5xc7jaxWAm/8Fx9E1Kt8bS6rt7UeLkBMZzwHPv+JjsJDDuzysYnQaFxoXyPnZmCkgrrq
 g4KGeE3I/5UooIv6uapNP7/nfRpQRyk/gK0eoEvNhkUJBFb5STeQ7T+7I29h2z8WZAVsO/YfXAa
 xwj7fOwCSLL1HvAMKdp+aCjM438wdHvBWFnA+zvqV77f5eH+PJJZReJnd+x2zlLtmGxZfkQTZGw
 I0HJnVODhXzdLK1hWNZd2Zbjd4Vpbel+2RNhPg5fbv7WGhtS2IhqBOOfHAowLvr9cwDmPXy/wat
 lTFLGiQX
X-Proofpoint-GUID: Dxmap3lwt2dsyJ9HL086uJbBZHJLniIK
X-Proofpoint-ORIG-GUID: Dxmap3lwt2dsyJ9HL086uJbBZHJLniIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

This series introduces support to enable the Mobile Display Subsystem (MDSS)
, Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
QCS8300 target. It includes the addition of the hardware catalog, compatible
string, and their YAML bindings.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v9: Fixed review comments from Dmitry.
- Updated the description of dp-controller DT binding.
- Add new clause only work for QCS8300(one DP controller with 4 streams).
- Link to v8: https://lore.kernel.org/r/20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com

Changes in v8: Fixed review comments from Krzysztof, Dmitry.
- Fixed incorrect description for dp-controller in driver/dt-binding.[Krzysztof][Dmitry]
- Fixed incorrect description for ubwc change.[Dmitry]
- Link to v7: https://lore.kernel.org/r/20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com

Changes in v7: Fixed review comments from Dmitry.
- Rebase to next-20250818 and 4 pixel stream series V6.
- Add more description for the dp-controller dt-bingding change.[Dmitry]
- Reorder the MDSS change and UBWC change.[Dmitry]
- Switch to the OSS email.
- Link to v6: https://lore.kernel.org/r/20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com

Changes in v6: Fixed review comments from Konrad, Dmitry.
- Rewrite commit msg in dp-controller dt-binding change.[Dmitry]
- Optimize the description in MDSS dt-binding.[Dmitry]
- Pass the sc8280xp_data as fallback in the UBWC change.[Konrad]
- Add the DP controller driver change.
- Link to v5: https://lore.kernel.org/r/20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com

Changes in v5:Fixed review comments from Krzysztof, Dmitry.
- Rebase to next-20250717.
- Change DP compatible to qcs8300-dp due to add 4 streams support.
- Add QCS8300 UBWC config change due to rebase.
- Add 4 streams clk and phy in the mdss yaml.
- Link to v4: https://lore.kernel.org/r/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com

Changes in v4:Fixed review comments from Krzysztof, Dmitry.
- Use the common style for the dt-bindings commits.[Dmitry]
- Update the commits msg for the mdss binding patch, explain why they
  reuse different platform drivers.[Krzysztof]
- Link to v3: https://lore.kernel.org/r/20250113-mdssdt_qcs8300-v3-0-6c8e93459600@quicinc.com

Changes in v3:Fixed review comments from Krzysztof, Dmitry.
- Fix the missing space issue in commit message.[Krzysztof]
- Separate the patch for the phy from this series.[Dmitry]
- Remove unused dependencies and update in the cover letter.[Dmitry][Krzysztof]
- Link to v2: https://lore.kernel.org/r/20241226-mdssdt_qcs8300-v2-0-acba0db533ce@quicinc.com

Changes in v2:Fixed review comments from Krzysztof, Dmitry, Rob.
- Decouple the devicetree changes from this series.[Dmitry][Krzysztof]
- Drop the dpu driver changes and reuse SA8775P DPU driver.[Dmitry]
- Fix compilation issues in MDSS bindings.[Rob][Krzysztof]
- Correct formatting errors and remove unnecessary status in MDSS
  bindings.[Krzysztof]
- Add the the necessary information in MDSS changes commit msg.[Dmitry]
- Rebase MDSS driver changes to https://lore.kernel.org/dri-devel/
  20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/.[Dmitry]
- Package the DisplayPort controller and eDP PHY bindings document to
  this patch series.
- Collecting MDSS changes reviewd-by Dmitry.
- Reuse the sa8775p eDP PHY as a fallback compat.[Dmitry]
- Reuse the sm8650 DP controller as a fallback compat.[Dmitry]
- Link to v1: https://lore.kernel.org/r/20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com
---
This series depend on 4 pixel streams dt-binding series:
https://lore.kernel.org/all/20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com/

and separate eDP PHY binding:
https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/

---
Yongxing Mou (6):
      dt-bindings: display/msm: Document the DPU for QCS8300
      dt-bindings: display/msm: dp-controller: document QCS8300 compatible
      dt-bindings: display/msm: Document MDSS on QCS8300
      soc: qcom: ubwc: Add QCS8300 UBWC cfg
      drm/msm: mdss: Add QCS8300 support
      drm/msm/dp: Add DisplayPort controller for QCS8300

 .../bindings/display/msm/dp-controller.yaml        |  26 +-
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 282 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |   1 +
 6 files changed, 316 insertions(+), 10 deletions(-)
---
base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
change-id: 20250818-qcs8300_mdss-a363f0d0ba0b
prerequisite-message-id: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
prerequisite-patch-id: 9cabb6be69b17e8580a2cffc7aa2709106cc1adf
prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
prerequisite-patch-id: 4f02ab9314f95984ab7dc9b852ba4d6c676746a7
prerequisite-patch-id: 62d643df7c88d8db2279def1e4b63a605e9145c0
prerequisite-message-id: <20250730072725.1433360-1-quic_yongmou@quicinc.com>
prerequisite-patch-id: 2ea89bba3c9c6ba37250ebd947c1d4acedc78a5d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


