Return-Path: <linux-kernel+bounces-778855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF2B2EC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6880A207EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DA2D0607;
	Thu, 21 Aug 2025 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcvfX1Rf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73622214204
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747417; cv=none; b=XvrcejV/9uvsU0aSYHvtyJyZMcki923O/ezF0gACrhyV6dShqV9fyPCYb9MvoA8JhUUppBcFtHoLvCR7ALUJo8j9W0mCUBrz+FbSh4KbSfgeu1s037Oo2ZX7NGbKoDOPfUb7NVGHIN+LV/9hKdvlyYuYyHZjyduSHQrsFKpLHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747417; c=relaxed/simple;
	bh=KF0lz4o5vhdfNAZwWNlZxcAVY4PyQ9aWCCff5ydFXjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MvHkaKn6QXVPLl/HbRnNlXB7lU83UD9b3qe8xp+ulB4+35ughXok9P4ZSaWxb+btwUzyXvl3g/QCfLl7KE4Y9CyzYO5VUe+fOOXKFa0J2/DtdnO7POaWDJwM6Vxiz0nmwAgY5tmkQih7WAv6LwW6MuXZdZY083NEbB/k7xa7xwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TcvfX1Rf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIJYKh020040
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Qf833gjQhWavJUAzppbeVb
	5nYVbUC2/sxQG72A/aibA=; b=TcvfX1RfvvLREJoNfu5xlzMmHV9+dtDbXjpPck
	RDUGquNU387GF+C9qrSbjNU43mQ93EiIIlNEjDaBsE4tyKB9mc/FZDvVIH1Gze3X
	i6gVmiWiETiV7eLIv0nM/rN8Q0gNDIWTvxyuKgfmqfq7FH9RI9ZVgUdkGfxOflCE
	QYbQSjtlZT2AVdePgIsW8HbI+5mSs+iwVaHnF2ew/fobyvps9E0DqNvdWhC3GWo4
	QdqwY4S/S2rSMUlZlbqSL0kzgva7qgHB5j41N5CsFlC/i/l/ghHJjIs9RhE1s0AP
	nxZJYHllgvsjmVE8l4PM05nJyDOV6fDq5YL9j79lUjpOn3nA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293uuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:36:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4761f281a8so419217a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747412; x=1756352212;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf833gjQhWavJUAzppbeVb5nYVbUC2/sxQG72A/aibA=;
        b=L4Il4mYgGT7jCDI0+eiDvVfkQSB9Yyliy+B4NJ/4LKLLTi9IijAUkKR/eXc1tpDDF7
         9UqOLGsZM7h+ntHudkz0gMKoWZoJnjrtc5PJg/AHbjCaHcOX2y7Yd8AEcOVsMP1yNIrz
         Me99+Z3pNvdTi2HivxSF2gh9Laywban7ueTHLqpR8nFV9HkvX9Z6gcgarCQwKq7x6G47
         NmiwgZM/vC/pva9WFe8eTxqiVaP0yD1uWPr+iP3tUwY+o4M1S+EsoV3SJ3/zwD5EruNF
         EdeiniCmEoAeKni8EP8ROKWngUTlIYwpAQ5bo6EE11TgzQTwASFmcaw0um3mWqIj+89/
         CiaA==
X-Forwarded-Encrypted: i=1; AJvYcCUSd7OzardlW4fZB62bg7GEnD7ati1UGcogow+PoEPkiX2/XPOiO1huD5yOZKBhjh+S/90+qMaYRjQAYf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmFH5S6nXlUyOh5LZDRM4Oqt1sjDAB8uhP6MMOhjZF7ALqDDP
	2GOXj8tw1k0W4CALej9r/FByisNRUsWRNFUBlOzQbQJRSn0hYj+b9dwngFMexN8id9iGdgbk+/p
	6ZZNhgkDHg3qnLNKIE0IziquKFnwOCsQoGbnv1O/ZyTg6j+2P7fhiQGO3gZaZI6eGjNQ=
X-Gm-Gg: ASbGncu0UOwRdSMSMTFhlOwXhSMhNSigZZTE+TELAOrzVF9FPo1vYnxUpe2kft4f/gN
	WFHhbC3t5VEtEOVGcND/WPZCYgUWn80oi+F4spvV3Nd4IIIM4t3ovHjO7K7P6sifQ4Jrm9Vtfw/
	pfbm9OkQBm3pPeoM6Dpw3dGjE8m6JwhTtHrar72vd6ue5gb3wHnylIP/hU/0MDbHamU+B3G0phg
	E4Ybpe/g/6tJ9zurOmaspa8h0ojira2crrKRF4DSTIyPzQWZnpzEnuXMYpQ3yaxLlCNzjLZ2sDF
	kYTHYr6dNlxJ5b+3aJoras6Kk0jXz1DhGLtnR6qFuis26eq5Rd6yXk6CJWXPpJlC9ENjZvE=
X-Received: by 2002:a05:6a20:1596:b0:239:a3b:33e5 with SMTP id adf61e73a8af0-24330a38f89mr1261585637.39.1755747412454;
        Wed, 20 Aug 2025 20:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM1lJp8/OPWX4i2nIvSXVu+OEupLSbOEOv7MMYGuns3t0wI6+aIclpA+Z7qkVBfX+1wMi74w==
X-Received: by 2002:a05:6a20:1596:b0:239:a3b:33e5 with SMTP id adf61e73a8af0-24330a38f89mr1261537637.39.1755747411971;
        Wed, 20 Aug 2025 20:36:51 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:36:51 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v8 0/6] Display enablement changes for Qualcomm QCS8300
 platform
Date: Thu, 21 Aug 2025 11:35:55 +0800
Message-Id: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWUpmgC/2WQ3YqDMBBGX0VyvZH8aVSWpe+xFEnMxAaqVkdlS
 /HdN9qysHQuBr5AzsyZB0GYAiCpkgeZYA0Yhj6G4iMhzcX0LdDgYiaCiYwVvKBjg4VkrO4cIjU
 yl545Zg2zJH65TeDDz4H7Pj/zBOMSqfPzkXSAaA5qlXy+oBl1t7rDubahd6Fvka45ZRQ0z2ysT
 Bb5aUBMx8Vcm6Hr0ti+9nHvMB1X00KLLOVKSpkzymmc39T3oW+7YTntIfTNH8IaBLpDw1wlTCh
 gJSilrBOW5QagdNxLD9pKLhtthPPcWrK7XQLOw3Q/LrfqQ+7lU/4/0qqjjCq1zsBzqbx6kyHnb
 dt+AShbpxGLAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747400; l=5222;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=KF0lz4o5vhdfNAZwWNlZxcAVY4PyQ9aWCCff5ydFXjY=;
 b=bhQwT9GO+eqF2VokX1VXI2uPzOvtgeI0MdvrpCBH+Ws25cy2DIVAzo0J8C4gTQ952sPvekQTl
 fg4xirEvPOOAWvLwrcTCPaof04s6jbi/wFK4JOTEU2KwpXdwtbGhlhf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-GUID: HIDw3g1R7969qY4bZ1h2irOJSfw-IR5C
X-Proofpoint-ORIG-GUID: HIDw3g1R7969qY4bZ1h2irOJSfw-IR5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7r6wsJ2oym2G
 t8HY4vgxS+rH9M8KnqY+5rFln2cTFH2oMNXNZns+DFOOqLUV6HaPWCD7UJ1Rp7WpdOBJ5xg1+nm
 xqKh7JilFioZvQCogMvHWim60gjAaZhYwilKWGwYnOvwXG3c3KUFm0OOOk7NvCHR/PHfXvU/ouS
 PPg5fOlrdbRubnIKnf7Gj6iXRiJ2Ogc6p+yuZNpq6YSK3E23YAWwQHZeiSa4QKvKXJmG3BVk8//
 5k97038xMwK33AlqeLMsfgNovWBUgFMaIn+RJ1MSM5W29/gkULX/8Td3k8+poSswFI3BwBiVU4/
 /sIZMpVYse8u5KFSvLu4lVIyfYpMjoljI09sa1PGJjfmyevMr71e01naNa9+YSmVLWldDdnNB7Q
 JkjuDlc0VDJVikfAQfg0hTedfd6iqQ==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a69456 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=A9Q8OG8lNi9f-aPTaEwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

This series introduces support to enable the Mobile Display Subsystem (MDSS)
, Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
QCS8300 target. It includes the addition of the hardware catalog, compatible
string, and their YAML bindings.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
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

 .../bindings/display/msm/dp-controller.yaml        |   5 +-
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 282 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |   1 +
 6 files changed, 299 insertions(+), 6 deletions(-)
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


