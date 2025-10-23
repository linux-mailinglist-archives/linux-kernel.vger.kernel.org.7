Return-Path: <linux-kernel+bounces-866422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37DBFFB97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F483A3798
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F872DCF5D;
	Thu, 23 Oct 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUTK7RzH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861B2DC776
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206099; cv=none; b=L7h6y5eknuahJPeKZtZ4zbSc0vka3rZS0MXJNukP+4tWNwWHn+jOd+1zTaSEitR3tsEdizD9WkuFXYqi09uQmryV1f6qnO+DJsOTmAawz9Q16hhGCnq5MJCjVQxzvldM0Zd8TqbXK15iSetHwH9T15Hyo5b0dW4kyMnP0W3QEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206099; c=relaxed/simple;
	bh=N24F1NK7PNN8ECfenA8Rzk1H8h7iqNd0DAPdy3ifLuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjgVqR0q4uGiBezaSZX3nCSBpEY9OcqaAt3fBkAgrEys+5Dqt3fVhZMcef+6A1lIfZDaae0jv+0KErA6mfITKh8W68Fj9T9SiItCSWjzFIm+jOdYn/N2DHyiozKe54inv+27SnwP6xs019y8rSvyLamAwHd1N1H3ELTOOnt3FxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUTK7RzH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6rGfk010394
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6Lbr2daX8xkF/1kS4qxmCLzZgVGCm7zt4oN
	vPQplLYA=; b=CUTK7RzHp3zeSX64hdZf5pRkit27f6Fg3hvjQ6pwjahf5nJU0Q3
	866HSTqEP/KN7IfKDfzodGaeuNyi38HOGKfYqQ4ecalAgRy47PeSI/PkFcTHMUA0
	7TXNc+Mng4TqQuvTTx2xM7+CJf4d0JgPI60MrQJEeTFYjqTCxYI78Yq8op3tUkVG
	/dDtySRATizJW21IpdsxmE+/GuVGGyLkwXuD254m4RR4RaGU8OFc5V15iorQ7EkK
	fTFWis5TCqSgLoSvuxidR+mtX2iAaC22V2hH5bBo+YrL4N5gO0bYYX8O6bwJ/H+C
	YuQo8M4xeo6275K29vqyip7fSC0twyy0aug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3447k2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:54:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290bcced220so5634625ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206096; x=1761810896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lbr2daX8xkF/1kS4qxmCLzZgVGCm7zt4oNvPQplLYA=;
        b=VSStQJ+WHqniE4BUT05ctCrSUxqjw8Tn1frSERaGTNhGthi+SlieOKhTqsuh1QLPTr
         2nySzrjE8Z8dDU+0br2KSOsRTMvZOn+ct4ZVjgoK5PxgBcgtpt8FRO0FCQ6HUo2CMfUa
         27ElqA+EF6SIlhE3/opDPiah6MyTEDqWqfhVj4lb49IbzkfpQLATgvylh6ZL0s5SJa9G
         p5kkvPApoDB/hrrtPVC1+mBmpxTzr2YuLND3Bf4dTsewmCh8SHqj2CHZVQ46o6cUj96r
         bdmFfO5AXwNg8Yg0bEm9OBnzbIOb0BDapelQswsO6jXHh4qMS06EBtLt9HHY0m6Ef1NH
         0HFA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1ySykgP6rsdVomhGfOFyp8QS5RvSkU9rHn93FjY7JjZXPL8CiV/IY3PJlhGXQVNXxJKxjIXilNHf7yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnmLlkJS2E7Hg/yuCmFf6/Lk7Szb+OBMkuR+f4U5fA05U/qJW
	WtnqdqMM5YImgDNu6KBXgGXEvMQSHJK5xaZgmcviVeShL2nk7nAus9uljfnOhx8iKZmsOYywCiB
	cbGFwR8cYBbfc0tPxg0cL89uuyKmwO5FzRSFl2kP4NQHeMSJLX7cYAYhj4GWPgwz7ZTs=
X-Gm-Gg: ASbGncuM1cX5ML3rbDD2uNQZ7Nh6mqJMglST2YW6JR2foFDOtww664sdTvmMWz4xY8l
	UQx8WTIgPuCR1HXIDylgsYiPraZ6KW5aH34Lrf7itPAPIyNOplGUz7ieo9XFH9uEmgDtTiBTgmw
	NqSizezpxq9Zku2Y2JWYHkaClYQGmCXToWZ6VJlxZWs5naeJAIZ3kO6DiwS+PgbO/6xlEZrBCUz
	FagTYDnkOM1RSay9aMmuG8WiXtOBMY/iK7dixpBSJ6Ld6O48Li8JV0m1z+z5dbU/lAGTBNPyodJ
	bGyv5otjh1SHyva/vkbLeXKqi5nMce6GYsStWdzB4OpERONX2VRo2hMKxgJl6+B6TTTYo5EGTsF
	Cu/k54JphmsMrhVUjf5vSZjV9GeJC7sqd+ZfNBNvz4WQfrnEHBA==
X-Received: by 2002:a17:902:f78f:b0:290:af0e:1183 with SMTP id d9443c01a7336-290cb65c5e7mr246510445ad.51.1761206096462;
        Thu, 23 Oct 2025 00:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXkPk3uNLjCPJhL0E9s0WI1/sscyOiEu7tjyhLUec8kdLXEBCR1sYQQ35k5N1MZj1grhg5pg==
X-Received: by 2002:a17:902:f78f:b0:290:af0e:1183 with SMTP id d9443c01a7336-290cb65c5e7mr246510135ad.51.1761206096039;
        Thu, 23 Oct 2025 00:54:56 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm14371265ad.97.2025.10.23.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:54:55 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 00/12] drm/msm: Add support for Kaanapali
Date: Thu, 23 Oct 2025 15:53:49 +0800
Message-Id: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fuOX_zjA85o4JewhSse3a1xjCgoYw-H2
X-Proofpoint-ORIG-GUID: fuOX_zjA85o4JewhSse3a1xjCgoYw-H2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXwrkcgICj3VJi
 SdULjDG2eUhjqEQ95/QRyw69jwxJTS0dIPqFCVlHJMk5h/I66yjWFF5lDKcafmX18fXlq4oEjni
 E+j40bPgglB1aaoS7Oxs32eenOZPM4uGoXA+CcP5O6+uSHU6sDT1iX36UBLzgoReSOm0eYB5AiS
 omfVn6LQdUHelVdAL8bHw+QDMX2cP11PZ+GIPYVpvGyXgNjt/tW1Hop9hDoryQ5vRV7FwMyr792
 x+NN2ODvW5DG1bcSo0QYvm+7GZYvcTIGTqGyI4x1KVhaxMSIcamohoOH4RDNlZLKTRRGZrLyWzR
 Cik/gtZUnRrjJAoJYOUqVmYyeK/jUgkmBp4sD7/MKlg7mc3wfgElaRHD7n5OT1wjT9+ajDUKNl5
 H9CvPvGgI5MINil4Ed6QYrcoFu+2DQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9df51 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8
 a=6eNNNA5uUPZGPwET1o8A:9 a=uG9DUKGECoFWVXl0Dc02:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

The Kaanapali MDSS has some differences compared to the SM8750 MDSS:
- DSI PHY/DSI base address have some changes.
- DPU 13.0:
  - SSPP layout has a great change.
  - interrupt INTF layout has some changes.

This patchset contains DSI PHY, DSI Controller, DPU & MDSS bindings
in addition to the driver changes.

We have already tested the display functionality using the Kaanapali-mtp
device on the Kaanapali branch of kernel-qcom repository.
Test command: "modetest -r -v"
kernel-qcom repository: https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/kaanapali

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
Yuanjie Yang (12):
  drm/msm/dsi/phy: Add support for Kaanapali
  drm/msm/dpu: Add support for Kaanapali DPU
  drm/msm/dpu: Compatible with Kaanapali interrupt register
  drm/msm/mdss: Add support for Kaanapali
  drm/msm/dsi: Add support for Kaanapali
  drm/msm/dpu: Add Kaanapali SSPP sub-block support
  drm/panel: Set sufficient voltage for panel nt37801
  arm64: defconfig: Enable NT37801 DSI panel driver
  dt-bindings: display/msm: qcom,kaanapali-dpu: Add Kaanapali
  dt-bindings: display/msm: dsi-phy-7nm: Add Kaanapali DSi PHY
  dt-bindings: display/msm: dsi-controller-main: Add Kaanapali
  dt-bindings: display/msm: qcom,kaanapali-mdss: Add Kaanapali

 .../display/msm/dsi-controller-main.yaml      |   2 +
 .../bindings/display/msm/dsi-phy-7nm.yaml     |   1 +
 .../display/msm/qcom,kaanapali-mdss.yaml      | 298 +++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml |   1 +
 arch/arm64/configs/defconfig                  |   1 +
 .../disp/dpu1/catalog/dpu_13_0_kaanapali.h    | 492 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  44 ++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  29 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  89 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   | 474 ++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c   |  23 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h   |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c             |  13 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h             |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     |  23 +
 drivers/gpu/drm/msm/msm_mdss.c                |  22 +
 drivers/gpu/drm/panel/panel-novatek-nt37801.c |   5 +
 include/linux/soc/qcom/ubwc.h                 |   1 +
 21 files changed, 1507 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h

-- 
2.34.1


