Return-Path: <linux-kernel+bounces-794263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F75B3DF2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C279189D6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8D30DEB5;
	Mon,  1 Sep 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3WlcOr/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CC30DD25
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720682; cv=none; b=hM4NZeEC5RiFQ6UurfM/hWV4PrIK6AtzTcXhMRfV8ijq9pwabn+lxbd+bnTpjLJ96FoxGAqLoBwUQrL+XV0rhoXbwXqz1y4kK3J7ghohLNKLGlEOm49FXOg3uebiPLJ6NKdHixenhMcb53E2BKWsiaQ9alBc6ZIp3bRiLNiUyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720682; c=relaxed/simple;
	bh=qN2/IFOfht395EO4Y9/aMRsuWHCG2LTUU/RF3qc58/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pAjs4Kex8bIEkLt5uCxmND2IVORoqxUJw6q5STNz7OoW5xKSuPnX0Vg93KUiUTRmOJmcg8+w+pcQZg6PwYLkDNo9t7cX8q6VbixJW22s0r4FWcamuv3QbztH6SwC7qm1QHDXCIVq7lQXyO8wjGdzeJRAMZAZRKdfUbKPwZt6mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3WlcOr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5819eW2f009211
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 09:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Z+L0KAjOJd2cpGdjtFQNUn
	QtI6k4BIvmJPXasaID/eQ=; b=B3WlcOr/LX3xw+qvZIDjrMrxN9siD2TKRu7WMI
	G4OrXM5wmM240ny+a+JjIS8ycXOkTEA/Rc3NuoKEZqYWKD7x0WkY2BDpslaCRbgG
	5hUFUOVsaZJi5VUUtSyJMRvb7hCrmnl/AzLNWFcyrGviS5Co3ic4gzXATSpai2DR
	SGG0xrYvNZtS4DUk5pu9rh2d8Iadm36+o6BN7P3CXxqUnFfK6IQ6H2Fjnd/a/2XC
	WXqUZxxPJyL8loUP04vj7Botr4z5IDfH+ykf3s7iq4uHdHlPHH1rCkbhN4842pB9
	+Ay4m3brBnKhdMTMjacs8LzGFLTHXj0P6kvz7AnrzfaG2uEg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjc9js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:57:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7725b77b795so836726b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720677; x=1757325477;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+L0KAjOJd2cpGdjtFQNUnQtI6k4BIvmJPXasaID/eQ=;
        b=HPM47XeUNJipsw86nQ+GKsq3y4WqFxtMiC292R4BSyyXlbzJJSP7x9vVQ9UFqJWTk7
         kmWA2I17rOu8w8a2t/HryaP97CzN0Ww2Aiaa85t54EifvP2Y4zY0VNV7MrPiUX2ltkvy
         8QCXeuytqvHl5+pfhENdfTVgFAoaTwkY7rKVFYI3TIObeHlm+2/uExlyuLQnMvVu+qjt
         ENiZPmvrVC9YfP4Ubbi+9aJzm15//0mUBegpAWNYhK5pCd1Tbmvups4pwFIwZ3H3L0cb
         9i5Y+BXynS3gOJFcYXvZRFLLNxbo8YDZ+VT/L7Fd2mi3Ba4SY7mxDyaRDdHkBYM6KZEe
         NiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSwsxirlQ0wjk0kVWWOJ68dloGTAc8TCYWIocCePmEs+r9himS8FFhmVvixbweTmz0cptgIBuUgJTgh6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1w05fh2TC2GNui18yr05q4XnG9/7QAFCvIZcqWigdo3Z0hwn
	+/GLM/ZxVz1h0l3orOgzdiy81POTcn1XhxPgSLyscGwwA+nu/6Pe5w7TojzsL7PLcWN+qEUPBfo
	GugJs4cYzclYFlEpGxqVkaCixgOcIbBnMM5q0w6AcPbU/tL6JLrT15BQfnakmNWMoyz0=
X-Gm-Gg: ASbGncthtpc5yZn4j96wHsjocbcVZj/lMSoHhyScgx8H6xv40trTRmUAkUU1ItjGFy7
	pG1xw8aEEyQ0vXEsYrq8Q/+yZzO6R45/BqZsLTNXGMRRmt5lfsZr4n+bhfU4uWtEL4pQd1HNrgo
	/NRcNRj/C/5sH/IjspbTu2t2EYs7LWA/K7masy1mxm0twtpNlPAOxArImyVPaLF6jHAQxLFBOvr
	LKQoFr5Bh5hPiWfI11tmrhqJR5VJPXRsnY1SHsP966QcH8wOxaa4Q+xI/cnnzBBTgWT2nkzQ2O0
	Uo2hX8rB1i0NCiOQdQSWXNYlGL5XNfKmQDUk+aH5M1m6WN3ycumCnjTqS+WtQAgDuU7OdlM=
X-Received: by 2002:a05:6a00:2185:b0:771:e10d:813d with SMTP id d2e1a72fcca58-7723e33850fmr8900419b3a.21.1756720676597;
        Mon, 01 Sep 2025 02:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExoNCfnECxFIByYbxRgwzdBdzCYB6IQvqk/RF2LpCFv85/Uu5dObywl4DIBTePySOLFSP1ew==
X-Received: by 2002:a05:6a00:2185:b0:771:e10d:813d with SMTP id d2e1a72fcca58-7723e33850fmr8900375b3a.21.1756720676069;
        Mon, 01 Sep 2025 02:57:56 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bfe2sm10305656b3a.14.2025.09.01.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:57:55 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v10 0/6] Display enablement changes for Qualcomm QCS8300
 platform
Date: Mon, 01 Sep 2025 17:57:28 +0800
Message-Id: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAxutWgC/3XQ22rDMAwG4FcJvp6LD4kPZYy+xxjBB6U1NEkbp
 WGl9N3npGN07XZjkECf/OtCEIYESNbFhQwwJUx9lwvOXgoSdq7bAk0xN4hgomKGG3oMaCRjdRs
 RqZNKNiwy75gneeQwQJM+F+/941YPcDxldrw1SQuIblHXxesNFZbGQ93iWPvUxdRtkU6aMiq8U
 MaV0nLtNz3i6nhy+9C37So/b/O6Z0znr2mhRbXipZRSMcpp3h/qc99t2/60mYvUhR/COwQ6o2l
 cF9IFo8ogovXeKGYAhFRgrG8qxQ3nikvnmwBkzrZLOPbDeTndpJdw30eyv4+0hCmt1hU0XJZN+
 RRm8SZzZwj+YJhsgPVgKmmlaew/hr03qgfDzoaPjkcwLDj2h3G9Xr8APhrc/RQCAAA=
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756720667; l=5906;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=qN2/IFOfht395EO4Y9/aMRsuWHCG2LTUU/RF3qc58/U=;
 b=CpoHbwzwF+i192gooYnwqcbVs3+0bGhw9HxewYtz5vbza6BkiIQZ4KfQvKpyNgz6DYNtABAfx
 urY6VeCChu/DW9+ffOAtzTSDCsQItnC/BL1cBV0c7gErwbL2N+jq4AP
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b56e27 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=A9Q8OG8lNi9f-aPTaEwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: i9fYM6d7v9TBHSXx0jia8al8v9E_84O2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX78NCHaslyVdB
 ey2NumFJ0Y1rnq/FobH7EoAHPGsXZQuIqH3809VmSIENXoDD5nvYXde4wS8QetwQruc73OdKgRd
 trM1E6x8oYRgJuENiFa8T0C6sRgAqQGJS0ygMJtr7myLyZWspC59+3CWoYoUX+rlNboT/ooCW3V
 LYYGwMvoMFR9kT1vDgxC25VXtUae+v09wPBrRcqYjBCQhvfRHRdJpjYPXVPJ7HJS3XI5GhDBSHp
 6ZEgXUBRQErJFvjtWw6WT1cf8j/ta8+0+6cnbeZHqTMNXeWRnXMu3SP+KsxcyE5pNx6Imagk866
 OqKd/Hr8TF3hqT2QmK3QuIzDr0GtyIXP+GSsXj1H4KGsQOP1Ri1j8ED1Au2/CYSnRdozCdXaH+x
 bEovNNDH
X-Proofpoint-ORIG-GUID: i9fYM6d7v9TBHSXx0jia8al8v9E_84O2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

This series introduces support to enable the Mobile Display Subsystem (MDSS)
, Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
QCS8300 target. It includes the addition of the hardware catalog, compatible
string, and their YAML bindings.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
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
https://lore.kernel.org/all/20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com/

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

 .../bindings/display/msm/dp-controller.yaml        |  19 ++
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |   1 +
 6 files changed, 318 insertions(+), 5 deletions(-)
---
base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
change-id: 20250818-qcs8300_mdss-a363f0d0ba0b
prerequisite-message-id: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
prerequisite-patch-id: cdc3f4515ab23a8b2ce719bbdbcb56043803d03f
prerequisite-patch-id: 048b11765f49af4a728db1525fef1eb8ad48bf88
prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
prerequisite-patch-id: a8185cf3ddd85b9058691500b8dc0c57c8226e97
prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
prerequisite-patch-id: 2bc7c1b5105029c2fd7ce2914c98ede20c78108a
prerequisite-patch-id: f76ab0ae189df14acc851fa52f8f8e8faed9a505
prerequisite-patch-id: 983fc8a7bea459505c5b27db1a1ef7581936555c
prerequisite-message-id: <20250730072725.1433360-1-quic_yongmou@quicinc.com>
prerequisite-patch-id: 2ea89bba3c9c6ba37250ebd947c1d4acedc78a5d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


