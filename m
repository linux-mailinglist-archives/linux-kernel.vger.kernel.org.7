Return-Path: <linux-kernel+bounces-811928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0001B53039
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6615E3A0308
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B731C582;
	Thu, 11 Sep 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/3/0a2g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CB31AF0E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589859; cv=none; b=qEo2KdOXS3pL56XWpi8BeIFLWVWd8R/2KqkLSmRb6mFkz65S9TVLtFkr5lIvwC8T0qM5J5jh3hikCcazFCeE8QImLbcVsoQRHpfYDO9RyJlkVywLBS7NxWUT//jyFKpiMuXa9HVLVq9rXElFGWvUalRPze7HmuWXzGYPqPlmSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589859; c=relaxed/simple;
	bh=s/1T+D31g0bBfRYavOqwENc/3522k0AsmdZ12ZRSWZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kAiadNxCaiJoHI9y7Qt1tCATXNMPg7it5z2Ojhjf4aGHlqUk56KQU1uFY3vll/a2c3b2Hbs80IFJmEp92K+V4NQi85h8nkJJPhDzbF/Iai8KocrtQ8kyoP7/He2G6AWx5yMczc8Kf93HCoImTzFgvtbMsKA58+de1YXZhTSWrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/3/0a2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB3QLf006005
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FDS423Gjn6+znX8tqCMjzT
	ud1+whZkmRe0whIAVRLPE=; b=W/3/0a2gR+Ps/e3URteG2ximy8KQzAk8FnuPf+
	iWE9rtDZnLlrQFP8kCQszJWYPfi+ZCcPvKnLZRjTUQrfd8lJ22aBHZbTF0V2nGF3
	1E5bib4U6HYO1fc+Nm+wavSqmpodxxGlonGHIGjKoR0QJ1+TUAhAUHeXFDS94FI9
	B+3IR4l5MfbCRpO9kx6HOi3T5E0PJ5VnJxmHVkYbkwm3MXQfcHBMIhcU/fpjxoh7
	cSENXlo8MS+581Cv+iPbPhuxM6d02QMEuu1TvpdvIfEDhDRi45qifixEgl4eoHc4
	Yc+lMHBz98sT/B+KK4GYEXW8HxrNo6KEOlaHG4qo+gTpIQZQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8afcaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25177b75e38so8017595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589854; x=1758194654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDS423Gjn6+znX8tqCMjzTud1+whZkmRe0whIAVRLPE=;
        b=kxdE95B00j43UGZ47xpGt5054FMcdwro/6YjR5Qu8r0JPaeaY0dgri7lCUk7Tb7sHQ
         reHBYexnl8/jnC68AGIIgoiAQP0hew0bXgEhoT+T3mOtl66gSK7zmBcHyW73+Ja4lunk
         TaM/5BzOy9fs4Ie0VEk6gIQaOqtyPe1ccb/JfNR+PcCLsSwGwf7/giefEZuy33M/e88L
         2jxPDRAhgQZAhP2rmdJfRuigQ1zDQ7Gnf9/8KC2OPGKYM8Xnc+FkrSg0I9AFEqDJLpBH
         Qip2o2q1xXTrsGHPcR5bXLPGpMRJ8hRzL2xuZ9IbGOVE6Bo4aKVyMSs9+AvL+c163viu
         KlOw==
X-Forwarded-Encrypted: i=1; AJvYcCU++sqSR92wz2ylrizkiTtIB4Eu53nxnf0EF0oDpOveZt7ItGBiUYKUew+4Y3Hebw0ylmGF/sG3PYBL+cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhUqi7bcDP8T1Z1wGVtbNagDT3M0E8zo0yYss8PRFHVPhXPlS
	x85G5hmNerORTC3MamiFXn2e1pc98llh1uBRpZ2OUdmi9jsKb5liMyTbEbT+8Xw+571ItSpgAdH
	XtKfNGuAmNICpXSEwXBviOZQ5MbCKiranFCcFaDJWbCKZgzUL7+vYuAUEM6GOr/dL/FU=
X-Gm-Gg: ASbGncu40u2tUpnkZsEIqQQM4h0X4+B59Lisoszs3r580j/2d0Pvduu2NKf07Twvwwr
	DvtIe119WvuaGpi8AbKxbKme0q2qjsmUrULRfTYS0gRxlNaQ295+C/YLekQkydzaE5P7on5tASu
	hvjLYC9XQFJzWpb/QEl7dht97skZjvZ93doqzDBNkEWdPvNE0lY2UYIanEabumHNenDlde9KGzJ
	rtocK1tD/3avq9GEGL4oqQrKpuZZL2g0yF7EVmJ4ApchgEr2Q5UF5wlY6oJ18j6PvrEMYteSMcm
	HV2pC95iYGWWj93A9RNA2CPwOxhBhG3V+li97h8SGNTw3BqmBAZ9MHsVw/anBuGiuXuGTop9j2k
	4wDhic1nPFSKyvMKXsChQlgV4DpL7UyeF
X-Received: by 2002:a17:902:cf41:b0:23d:f986:6472 with SMTP id d9443c01a7336-2516e69b45fmr251381565ad.25.1757589854207;
        Thu, 11 Sep 2025 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoBDLirfMfhmGKvavAai/ZI5dn47yVg9pTNdTv7KZc8akLZUz9rWyiQlLajY4JSGJBKzIqWg==
X-Received: by 2002:a17:902:cf41:b0:23d:f986:6472 with SMTP id d9443c01a7336-2516e69b45fmr251381105ad.25.1757589853668;
        Thu, 11 Sep 2025 04:24:13 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:13 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v12 0/5] Display enablement changes for Qualcomm QCS8300
 platform
Date: Thu, 11 Sep 2025 19:24:00 +0800
Message-Id: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCxwmgC/3XQ22rDMAwG4FcJvp6LbCexXcboe4wRfJA7w5K0c
 RpWSt99Tjq2rl1vDBL4k/SfSMIhYiLr4kQGnGKKfZcLxp8K4t5Nt0UafW4QDrwCxRTdu6QEQNP
 6lKgRtQjgwRqwJH/ZDRji5+K9vl3qAfeHzI6XJmkxJbOo6+J5QTUI6ndNm8bGxs7HbpvopChQW
 fE6gGAMjdn0Ka32B/Ph+rZd5edlHnePybya5JJXK1YKIWqgjOb5rjn23bbtD5u5iJ37IaxJSGc
 0jutCGKfq0nGvrVU1KEQualTahqpmirGaCWODQzLf9h7T2A/HJbpJLsd9h6T/hjTJfEyppawwM
 FGG8u6YxZvUlcHZjTEHgtqiqoQWKugHhr42qhtDz4b1hnlU4Aw8MBj8IhpuF2GQFSWdsRJLVcr
 /Njmfz18gpM/8WgIAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=5558;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=s/1T+D31g0bBfRYavOqwENc/3522k0AsmdZ12ZRSWZI=;
 b=4V9nK82alAe+CFeWPPLI9h1X/7x+HJXL74IAe4kqLJYxSFTawMC5SkG4spPySUgesQh2Jhn2O
 eXcv04ReFQyD+/kBaZ3KEOfd568o1GxAq87zM2S3lY/XRSg5rrPY6B+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c2b15f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=A9Q8OG8lNi9f-aPTaEwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RhgFTN8nGGYAoRCkcjp2Sz24poY3VsZ3
X-Proofpoint-ORIG-GUID: RhgFTN8nGGYAoRCkcjp2Sz24poY3VsZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX671hAHXuM5hw
 xBv9ZaLkmEJYiw+ITTOk4z6o+w9k+/o6LoOqxOeTBBZikas2zV5ICS0Rr/QRWdiJOJ2A4ac6OB+
 mVTiu2++Oaz/XYtTsnUAhOoReiG/ScwUQTz5/bI3fBpToqTP3LEGssL/esG1R9JTFwWN80+elsO
 KoLAKngjIxcKyqBB2fB/dE3QTZ6SufG8E1levZ1Kt9chUEUnJFHssz4Qqm72DhxJIwWq8/XS3sp
 6g0c8XyNOqnoxF7SvU9d6XTwii5wh9qQHt5TWMO9UaLto6HdhLHAFbMYUshKNQLQW5JvmmZ1Afm
 XLQ44aCCiVRZO8NYRnZowZEclfyBlOc+rWzdPNrj+AL+7VwEs7sfl8sx2i/4CAFy/NAIDNGv3Ol
 lk2Ffbp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

This series introduces support to enable the Mobile Display Subsystem (MDSS)
, Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
QCS8300 target. It includes the addition of the hardware catalog, compatible
string, and their YAML bindings.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v12: Fixed review comments from Dmitry.
- Use SA8775P DP controller as fallback.
- Remove QCS8300 DP driver changes from this series.
- Update the corresponding modifications for the QCS8300 MDSS binding and remove Reviewed-by.
- Link to v11: https://lore.kernel.org/all/20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com/

Changes in v11: Fixed review comments from Dmitry.
- Rebase to MST bindings V8.
- Update the clocks-name for QCS8300 in dp-controller.
- Link to v10: https://lore.kernel.org/r/20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com

Changes in v10:
- Rebase to MST bindings V7.
- Update the P2/P3/MST2LINK/MST3LINK regions in MDSS yaml.
- Link to v9: https://lore.kernel.org/r/20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com

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
https://lore.kernel.org/all/20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com/

and separate eDP PHY binding:
https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/

---
Yongxing Mou (5):
      dt-bindings: display/msm: Document the DPU for QCS8300
      dt-bindings: display/msm: dp-controller: document QCS8300 compatible
      dt-bindings: display/msm: Document MDSS on QCS8300
      soc: qcom: ubwc: Add QCS8300 UBWC cfg
      drm/msm: mdss: Add QCS8300 support

 .../bindings/display/msm/dp-controller.yaml        |   5 +
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |   1 +
 5 files changed, 303 insertions(+), 5 deletions(-)
---
base-commit: aece0ae517b9bdb725113dbdbd8f409a236bf5fc
change-id: 20250818-qcs8300_mdss-a363f0d0ba0b

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


