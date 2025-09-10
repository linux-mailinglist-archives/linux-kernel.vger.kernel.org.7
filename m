Return-Path: <linux-kernel+bounces-810076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B08B51586
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F3563C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35130C35B;
	Wed, 10 Sep 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="apieVwrZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83C23A994
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503568; cv=none; b=Q5yWXGW+ewaXSwsiHEmx06SHCJtQ3J3NQQUOHWPgCGj6RkivC+eqjcgu50ClebZ0Xc3qAL1TFgi8C+aVU2xcPGAmV5ezb5R0727E29whwSzLDN9IubaNTq3q3YiHLJ18WJXVI99Wpkqny8IhrzO8rb4MQ9pmypoyrrS4Gu+Fd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503568; c=relaxed/simple;
	bh=5yZF6bmqwbJzi/kgFmyA3BkJ0IqhI9QGlG1cdUqtMgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eae3Y/NFFT1fkEMmrkawmG11WG2M4yAmdZdN+b8RhhAWUkyg2nEK/0VcGOlLlV7P99Ab4fEcxM5XhpeqUu25AOzhcaoxTq+SQeVxFvLPaGzMjCAM++d4psby80h2RQEvbVGHXN51yfauxA8M5890jsJeBbvJTy1uzYPwkTUk9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=apieVwrZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAF5ow021036
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FHhzcXvmnJzlLpLtrDG2iU
	oRE1MaY8/8WafeWyBwNuE=; b=apieVwrZnDaUOpWKUW5PEVxN3kp/le/2rjWcsh
	yGLx2EDmuRvRStEN367zPcEDWalE7AgGsQryHYRYcd0/ihXpd5qDMM5Yb/w2L9v2
	ekpOuBWtKx+ngBYm69NRcxU787SzTc+jEsdTO5AFTsJLdeWm+ZFNprnJ/Q7ZNLX6
	+W19Ofnu/rEPtivb4fS+D2xjpLg0IK8obKRmeS/uM0efGug8mlDoLqEjIF4APXwP
	nC5d3bNJIsxoVlahSndo6xFxmq/8W+OE5Cm8HQXpNJZVuAe6Qx2fUcrDuUFOXF0t
	P5G5+g/Z/TOeEQwdUBaTECT/IjYkEF0uskxmXPpxX654Hsjw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8abjdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso9093979a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503564; x=1758108364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHhzcXvmnJzlLpLtrDG2iUoRE1MaY8/8WafeWyBwNuE=;
        b=NlbGuTK/Jm7/gF9Qa+0P841KKLLk4UUCQV04zQXku37TYCU2sgLVFNmuCcl7Q/pEa0
         qdx/9Ks0q+83M3JW4eNv8rp464xPRmwUofZQKtAJ0CZRyWpH4jz4rV3FpA60toB+hoiE
         UcejdljLLdAVEWvYGciYKblRu6xAZyh4FcnwaqXCHmqdg4un0AWfJndS6oVb0k9tjMgf
         w6uLmACOaNqpTbnGo6ZGCiK0tpSCnRry4+hBF8js1/loYe4uRqGZhpcJFV2kT4VPmbxd
         +yE6d2pZkxgouAb1GMvhotCoe5Ro173HgpIND1MBOM+SOy3U7OWNEM5CVi1NIbWQtw9t
         tU9g==
X-Forwarded-Encrypted: i=1; AJvYcCX7/v7fq+eP7V38r6MKtgcnK00eZRxA5pVERW8Nwij7EJSvImmbmCfacL9NZo7PZ43uHRu+SGSZZvYGn6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho67p0vreJpJUdYUu0/mfRsybeJlXma0/pSW6xame1Hh/GYp+
	qMqKpgebDbgAy6aMzZSe4BUX300z8NRmlJvVtXnxGqu5fX8ylVLFeGu/r3ZhoadJ+GibwHLUuhm
	uuHhkopJRKsPd6WGAdigdyfBsaM0iy4nXfpUtDGMFleUUxxI3AWvuIzdnhMxLg+I6lU4=
X-Gm-Gg: ASbGncsFQO7Y1TCq1pZS1PiRf0DMhRHqFtlPm1ywjRaqWakTgDTrg07LkXhHJYzcBJC
	jgng6RFj+cSsghSDlFYTmU7wGSAQGgex/in/iGRExUx34JjGqh6LqX3kTOAoU2MhqQ6Ep07lJfO
	TrwJ7IFi1PGV7rDKlx/td18t3Gydsu0X5j9Iqm5gveQiwS9550Ltk7jXOmE2U1vNWA1YMOpgZvP
	TIGJVyqWzj7EXZMmCEf9WEQjg8dOdu61u0lAhqP6pjwUr0q1t0zSwAvSDp2Li4qtBCJM4p58Cjm
	pFp8YGR9NOCG9C+8AW4IvAvQcMWTf9C/l/lu+8Kj/KCl3QhGLl1OivKmnrrjZQHB
X-Received: by 2002:a05:6a20:a108:b0:24e:2cee:9589 with SMTP id adf61e73a8af0-2533e573184mr18642227637.9.1757503564264;
        Wed, 10 Sep 2025 04:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6WV6LQF7N+NPQIu+V/b5WKR8adK4HEz5XjZBgfNC0CaTeuZn/CfRi9iBd/M7owUtZ1xU2hw==
X-Received: by 2002:a05:6a20:a108:b0:24e:2cee:9589 with SMTP id adf61e73a8af0-2533e573184mr18642195637.9.1757503563701;
        Wed, 10 Sep 2025 04:26:03 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm4862260b3a.76.2025.09.10.04.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:26:03 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v6 0/6] DRM/MSM: Support for Adreno 663 GPU
Date: Wed, 10 Sep 2025 16:55:20 +0530
Message-Id: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBgwWgC/23RyW7DIBAG4FexOBeLAcwSRVXeo+oBA06Q6iVgu
 0uUdy9OlKaSfRwE3wzzX1DyMfiEdsUFRT+HFPouF+KlQPZkuqPHweUaUUI50SCxEYLh4zDhNA1
 DH0dcA5eVVVQJIlB+NkTfhK8b+fae61NIYx+/bx1mWE4fmFpjM2CCadV4wxrmBHeH8xRs6Gxp+
 xYt3Ez/CCCUbhA0E0w5wxRlXGi5Jtg/gpENgmWidg04bb0gFNYEfxAVUZtT8Exo6aioawqc+0O
 fUnmezEcm2qdTPR1N9IZTZUcKaAwxSoq62XCu961Hn6dMYbyvHtUmebxcCuOumEWZs4sWloRan
 5K5Jbsr9vcvEAZAAFjJCWgqMeBPk0JbduYnxFXL19zz+gtpn4EQOwIAAA==
X-Change-ID: 20240917-a663-gpu-support-b1475c828606
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503556; l=4796;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=5yZF6bmqwbJzi/kgFmyA3BkJ0IqhI9QGlG1cdUqtMgc=;
 b=ygJ9G72zwWC6hpjzqRP78NeDdvp7nfiUFCGd9D7qZug+URgI+Awu8NSG9XWSWv3gN7aVg1pzm
 jpah/vxHAcWBP516SRF6Pbp1o+G8wW3g56J4yWFtnEMo+akBpmoXpIw
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c1604d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=tVI0ZWmoAAAA:8
 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=jTv6lf4Jh5MpNzVl0_IA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 5CAZu2MBYBziapMJgeVm99_rdFsmYFHP
X-Proofpoint-ORIG-GUID: 5CAZu2MBYBziapMJgeVm99_rdFsmYFHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX+nU4t56b321d
 L3kEMrMUsmohfSthxz0wMP22+XrP6D7RdOetK+l8xjOBVlnjOmJfiH83vHCD4FODRbTnj4utPHQ
 UxBao7VOuxI4kT0Qn2vKafQi+HEYW5jDm6vW+TTKZSB//4PT5IYi5ik/w2LEs3LqecWiOfnY2Xt
 QLOXpbH23fqCY570Czj11IWSxRTjYNSEcNFMfoGtLxqFMaajSK3Qh5yI03SJaIUqIC6O8P4cMrW
 meeuzYQCt/AqsfIUn11HNMrDS40dF0Rk37ZNANjy9+vDjey9N0szknLFFikPaZwYwuNTP9cQcXf
 1aGcTYIZSUw9GiVyWxS3zsAk3x/ZHdNwGI/fpe6vijxgbxQcXiXO0PVv8ZceE892kk2m/QbS5tp
 eYbKBS/V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

This series adds support for Adreno 663 gpu found in SA8775P (Lemans)
chipsets. The closest gpu which is currently supported in drm-msm is A660.
Following are the major differences with that:
	1. gmu/zap firmwares
	2. Recommended to disable Level2 swizzling

Verified kmscube/weston/glmark2-es2. This series is rebased on top of
v6.17-rc1.

Due to the SKU detection support in this series, the device tree series
technically has a runtime dependency on the driver change in patch#1.
But I think that is okay since we never had GPU support in this
platform and  the gpu support is enabled here. 

Apologies for the back to back rev bump. I am hoping to get this picked
up for v6.18.

Patch#1 is for Rob Clark, Patch#2 for Srinivas and the rest are for Bjorn to pick up.

[1] https://lore.kernel.org/all/20250803110113.401927-1-wasim.nazir@oss.qualcomm.com/

To: Rob Clark <robdclark@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
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
Changes in v6:
- Keep the efuse's reg range 4K aligned (Konrad)
- Update GMU's opp table to bump frequency to 500Mhz (Konrad)
- Link to v5: https://lore.kernel.org/r/20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com

Changes in v5:
- Remove unnecessary labels in the gpu cooling patch (Konrad)
- Update the RPMH corner for 530 Mhz
- Wire up the gpu speedbin node to the gpu
- Link to v4: https://lore.kernel.org/r/20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com

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
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 174 ++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   5 +
 5 files changed, 190 insertions(+), 6 deletions(-)
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


