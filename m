Return-Path: <linux-kernel+bounces-780478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082CB30272
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351B41CC578F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF3343D9B;
	Thu, 21 Aug 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzjfZb4n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D81F7569
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802576; cv=none; b=d4DnKLUDKAH1QWRxbqzNsrbss+8iHhvQ9OYyz60JB233mHKMxd/lItYmIvpEZVinhfoq5ZcEQfFX8EQd50C97tVj6/H34FKlcYGvzJPOZQxXArUOO2WcvTAak5xr2Ntx8N07GJq/QsurbNMZ+L6+s3Zh7gE/nMVtR8uQKv5Avio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802576; c=relaxed/simple;
	bh=FcgwT2lr8YlNaT7Bm2l6BjGqNuK65onJ/o5ee9+8krY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IEH9EjFecHBqUWJUnOGbhwqGtevm8rEFW0aiAZyisza9wCOACvAkQ3iR2j/lS7qfKixFcnqDYRnQq6yltlXc5zB+IIfhxzQOFlK1qM4M7NcFk/hda6PJymBtiyBXKWnEQ58yLMeVvPtJmo39xwM28erWodzcXZM64hLHxLo6ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gzjfZb4n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9Kxt003186
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oTXJBQ026YeZhaceP99mQt
	yN1CpO9CuuOPT3Jjwbyrg=; b=gzjfZb4n54GfRVRZb7C90Y8QI5lzj5FxCCt1E9
	5zcPJKlVQlfL8xluQatUm9dI+ZDNmH/dZ6AM1M1/JD0SIOrNao4w+DcETioVUn/h
	fMX0Cep5plIkiE9PiJAq4WtzyP6yIqSgwn3wmVdo0p0tGOjrs97dyxO62otK7HwT
	b8s3dxnuKmfGf1DHPXpHQClZS3wcr4xJN0EAZbtmY7iIg7idmct8JyfOeIr/bAO9
	E5EJxEPjYn+XnjwDrHnnG4cBP4oRr57sikO38XK3oOKh5IaAf84FBHP8Bgzfcp5m
	eUVe8iPl0w6GHWMaXfNxGTgJYWKrUb6ARU/RDF9SKF/69/0A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5296j4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e614e73so1289937b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802572; x=1756407372;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTXJBQ026YeZhaceP99mQtyN1CpO9CuuOPT3Jjwbyrg=;
        b=szyNid1UM9FS4WKHyXjN620BxTXpDRBnGkd0BizHB7sHFIrL6cYah8RyhvpjaRfwqR
         UQdS86ob4xR2ACIffvrasGdAQAVHYmVDNdoRwY/2Xab11j+32Epp6JsGZX6bGWsfhRVs
         NL6sIM8ywTqGZrktZttCK3x3SMimBI11yFTp3o9RkPMD6+apHzVf2E8ifjxkQvsXfHLm
         rZj3dF/hfFm09T3A5Yz3p9KrBFUMO+PXwP+wjaVEDDI6r/dxNbOOgK2kIAJYmZqkVRdB
         +IC2Q4P0gIlB6PpHrd6WYnsjqzQ6yLMiYHdri+6eW8KCq3VJsb6gvuiGF6etLrz4X6qP
         LC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUG6vhBNEzZlakJbMOITnPQdpEOpSknD/PxidOJjNbi9Jh2m0lNJt6CledGM9ZdM/wl1moiK8U89FubMkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/BulTKHIfAYxPBqxHrWyhMgLNhTyJP86dztj5VSv4/hD1Xea
	Sr9v6snPggFhK6djdkla8KxlG15T4CLl2fz607qUW6R40LbMHxXT78HO9Hb5rtJXAzGgNcc74bP
	y7poRI8Ghp0vjQQTD6VHKKJ/PFa5w69XcRP1vhvH24ixhF/oIVdPr2VoRALZU7oJLX4Q=
X-Gm-Gg: ASbGncv8vjJr+/6Iq2kIXmE4OQQ/ypUxDVI/N38q87RqNsUrq/+Ea6nhd3FIXFPQN8v
	/D+nBOifIIiiiXfykzoguWdPmFbVRk6tb5eSl4zRuC7IJLUvT1tOyHNbRiCw/udQSFfgyD+04Ry
	P9KowEYigLgu9QrzBXmzEN5niRMLEx85GbW8GYQofYfaSk8UrV9JkEI4JTV0AMbc9uGFkZxRBoh
	SzH/eTh4YCV9GA1GeOdiqNq6r1nl9eNT8IxWStT+dQgeSzDbHOjijavj+HlyiXP/QTFVUVJjC4a
	sGIGNNfYeEPoZdcB4uIRpWWr24Yv38CZisBaDTJaEFfAUJiVTK86rdvwhp2G+2jU
X-Received: by 2002:a05:6a20:7d9f:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-24340b27e92mr321663637.20.1755802572001;
        Thu, 21 Aug 2025 11:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBoneDdyEkq/OWMq0DJwi1kXkYbQV7m0+Zv7a3wMlxUxX6D8Lk2EftueK+duyryCOsS0BpIA==
X-Received: by 2002:a05:6a20:7d9f:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-24340b27e92mr321633637.20.1755802571569;
        Thu, 21 Aug 2025 11:56:11 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:11 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v4 0/6] DRM/MSM: Support for Adreno 663 GPU
Date: Fri, 22 Aug 2025 00:25:25 +0530
Message-Id: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1rp2gC/23Qy27DIBAF0F+xWBeLAYyxFVX5j6oLjHEyUv0IY
 7uPKP9enKhVq2Q5gzhXc8+MQsRArM7OLIYVCcchDfopY/7ohkPg2KaZSSG1qKDkzhjFD9PCaZm
 mMc68AV0W3kprhGHp2xRDhx9X8uU1zUekeYyf14QVtu0PZu+xFbjgsuiCU51qjW73pwU9Dj73Y
 882bpW/BAgpHxAyEcq2TlmptKnKe0L9IZR4QKhENG0HbeWDERL+E5fblTGkLeF8O5U1jgJP7z3
 OdbaaPHUVPWyN9IHIXZuss11KLYQVCkAAqFwLqGTJgb87wj4f3BfG/UiUnxb3tmlb5HPKvHwDr
 KCaNqsBAAA=
X-Change-ID: 20240917-a663-gpu-support-b1475c828606
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=4106;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=FcgwT2lr8YlNaT7Bm2l6BjGqNuK65onJ/o5ee9+8krY=;
 b=hGbkLj+kugLo2CD8trct5i7IGa9gMltoVrO97Iyosa4m+2/a/FiKOyUlipfATGIkpunMI33/6
 LQviyj58eyHBgoCPPZ/cy5NlkbdgB9PURdpbn06oQdM07lYQQ4j4lWa
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: FrWoFfYMtG3h2YSaECWFq3NW_FPmKAcr
X-Proofpoint-ORIG-GUID: FrWoFfYMtG3h2YSaECWFq3NW_FPmKAcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX01RAKJ6dTXWT
 7Hv44sa/nXAW7Tl7LCDZwRZ+cAIGfIJFSoH4eCm2QHWvcsjG81N0mZ92buW+XJxvTvPd5dXvJKW
 z3/GjiAYDGm2v1XbnIOgQP7deqe3i2GiOGEFrvGM/36KHyssWSAFnkVSF4hrM+nRb0RO4arc6rF
 VcOdctakHYCyE7wRFZUoxcoGAL6hFpDG2EAxrlLUty0F0Am0Qbaqj4z3j5fWFkOR8qUDnsDzQlq
 YG7y/+Tm0hfHuTnvg3lSsMwdPVm8/5dVLkeX2oYzIxoXkYjTmmoJTjuIzTtdvRyx50OpWmuaIwN
 S9hO0s0doYwsZuQARQLqNOr7vjBUchPFyPRt6UtvPjOVYhLHkErNxEPqbnEthBvtXvwO12GioHL
 E5Ev8tc+B8s5ipsB7lmKRTUV3PwotQ==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a76bce cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=tVI0ZWmoAAAA:8
 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=jTv6lf4Jh5MpNzVl0_IA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

This series adds support for Adreno 663 gpu found in SA8775P (Lemans)
chipsets. The closest gpu which is currently supported in drm-msm is A660.
Following are the major differences with that:
	1. gmu/zap firmwares
	2. Recommended to disable Level2 swizzling

Verified kmscube/weston/glmark2-es2. This series is rebased on top of
v6.17-rc1.

Due to the renaming of the Leman's devicetree files [1], this v4
revision had to wait for quite sometime.

Patch#1 is for Rob Clark, Patch#2 for Srinivas and the rest are for Bjorn to pick up.

[1] https://lore.kernel.org/all/20250803110113.401927-1-wasim.nazir@oss.qualcomm.com/

To: Rob Clark <robdclark@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Connor Abbott <cwabbott0@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

-Akhil

---
Changes in v4:
- Rebased on top of another series which renames DT files
- Enabled GPU on IoT boards as per the latest definition
- Picked up SKU detection support
- Added GPU passive cooling support
- Link to v3: https://lore.kernel.org/r/20241030-a663-gpu-support-v3-0-bdf1d9ce6021@quicinc.com

Changes in v3:
- Rebased on the latest msm-next tip
- Added R-b tags from Dmitry
- Dropped patch #1 and #2 from v2 revision since they are already
picked up in msm-next
- Link to v2: https://lore.kernel.org/r/20241022-a663-gpu-support-v2-0-38da38234697@quicinc.com

Changes in v2:
- Fixed ubwc configuration (dimtry)
- Split out platform dt patch (dimtry)
- Fix formatting in the dt patch (dimtry)
- Updated Opp table to include all levels
- Updated bw IB votes to match downstream
- Rebased on top of msm-next tip
- Link to v1: https://lore.kernel.org/r/20240918-a663-gpu-support-v1-0-25fea3f3d64d@quicinc.com

---
Akhil P Oommen (4):
      drm/msm/adreno: Add speedbins for A663 GPU
      dt-bindings: nvmem: qfprom: Add sa8775p compatible
      arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
      arm64: dts: qcom: qcs9100-ride: Enable Adreno 663 GPU

Gaurav Kohli (1):
      arm64: dts: qcom: lemans: Add GPU cooling

Puranam V G Tejaswi (1):
      arm64: dts: qcom: sa8775p: Add gpu and gmu nodes

 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   1 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            |   8 +
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi   |   8 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 183 +++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   5 +
 5 files changed, 193 insertions(+), 12 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20240917-a663-gpu-support-b1475c828606
prerequisite-message-id: <20250803110113.401927-1-wasim.nazir@oss.qualcomm.com>
prerequisite-patch-id: 765475c5f1418d986e661a213cfb33ee6ffb9548
prerequisite-patch-id: 03c6d1a5b0ae9095845828fc5cbb701b00f41131
prerequisite-patch-id: f7b8a288cf4ef309b4027f0b617b7435c17d6b1f
prerequisite-patch-id: aacfb31f99b75b2f5bf2f44bbd9abf8db0f66b1d
prerequisite-patch-id: dc442a0932abeb5139daa547a1b1f4282fa9a6fa
prerequisite-patch-id: e8a728d629b4bdd22bc1ef21f3d593e17a8d3b44
prerequisite-patch-id: 067fe8f5151b3fea9cbc37192e559a123abcdb71
prerequisite-patch-id: 62150f33bd304fc34b8fbb4aab953c6c4bb8a566

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>


