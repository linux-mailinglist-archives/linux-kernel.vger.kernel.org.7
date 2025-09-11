Return-Path: <linux-kernel+bounces-811746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F958B52D66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13566567E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F32EA735;
	Thu, 11 Sep 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cx5gELQa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE12EA46C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583449; cv=none; b=DxCpxkh57jgPponvygpwi2Ibir3unFYyGmx7iH84a8Vvkpfw5yQZfkQ8TxYaXcOcbbkdOGxZ8MLxT8RFBg09/RFD5OzcirvOrl+KGM5NhaZU7wSlfvgDqzDgi7pyfeqoWMWXDHhDi50mdauNrVyvpt/VnAlooYiwlkBj8JJFeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583449; c=relaxed/simple;
	bh=1KctSP7tT4hdSPnIjjOWWclG2Dc6KV/r5m/+90egGy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TBS1Bm6O1pLfTVKDM1C6sm1QgrBpUGVIZijuFAqg9Vm/14bcuSayfjC+NH2y23DzKxrFzjEx6UVcJHaxj9ku2s6Hlv4jRWMZRTja+Pzvy++OE2jthvCT4qSlNU8KFJsr3UBDw8+rmNHLUbgVugIvL10TnrRvilHI1isoTq8JQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cx5gELQa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4kHs6019116
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WTsuPr0C1+tfJ00SepcUle
	p/Wkf9W5RYeWTkYV6Ftlg=; b=cx5gELQaK/mRvLGVN/wca+lSeaEGbg9kIcxqlM
	eRgIDd2b9Aj45goaTK+OyB/pUnfM4FR/M/hhlBYCzdri8T+hQJbWoTrqCyyKeosH
	vvt+lKppo3os/vmZgekYjI1BjU/dS3+i7T6aUr1DQDHdBG8JXjgy5V+BvqAk0r7B
	Yqq3/CCy/WycPEzRwnxDsSQxLk20QI8xzLnjg2I/pqrU9yeVwEhoQC+fxJhzWuuD
	sM2CDM9eInTlJnEEbFhNPbEc1nvrtkfyHL1ASHPpILc8ddxXF26gZtZ+hAAujEZt
	RBMgMcnVZ61MICz66AIZlWdS2OpsqBJS1Ufu1ksfWG9KcE9w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphrueq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7742e89771eso549449b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583445; x=1758188245;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTsuPr0C1+tfJ00SepcUlep/Wkf9W5RYeWTkYV6Ftlg=;
        b=NGnEjuyaOJST2y377FZjTI74w6v7i0fl7HRJcH4vi1ZckdDtbeDksZDlnz1NOrTIRQ
         jsOq/2s6lwAO6CelHP/GxEn1OfAdeyF1TjH0MLTxSWoG0Nw1Hra6s6xfDleubzOPXrI1
         o5ZP/eRFcaYufyJ/LCy3D+AK5Js9y7eB3tjrrQxrrJZ7jvMj0Xu5hVTN3cB8oTNpUWIt
         p/SaBJ7U6QkFrh//06eY6BeKQhqa8nbqYgbMxuuTMXTgeWhHpVZhHaNGknmSvLwX7AOQ
         6hrpQ7eB/SP2z4qvd9QnPOTuZ9ddqGqAPCcFfL/ZKgADql6HCaHV7DphvQvKcZf43yjo
         YHOA==
X-Forwarded-Encrypted: i=1; AJvYcCXMVbp1wcljRI1jQPtgfc/m7v2NJS1WYnZy2iiioTEOTLhiZIEkOXFzZa24f27/jPkiuyEU/vxmFFS3JqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7b1zxI0uPG0ZktKTw0j5atDMb1EX16vpfPFx39Mgk0lLS4Zz
	WHrJaD6UYa84ZU2PSsPlEoSYk3sFywNm6PY/MOrPivEteOy0oTwgr0N1Unhsk2slMT1tfwYkF1q
	Zzr79h00JQTTFMb1WsZUzbE6SmFQCRHs9+qbZMeGgQMBsNftdAGlJFzUhfGODWhMzcJM=
X-Gm-Gg: ASbGnctb75W6pmX1qkTxw/7ylVj6ofa+Z/QDiia7WLm8Ryo6rkbh8PC6FiZJkn2OKJo
	G1srPMnlnD8v0euauOtK3rruQjReFnZu1zAdqB/BprimxzxF3DaV5Ssqxh94xNgplDZObQy07mE
	09/L1K+XdJLpYKhiSPAka3Q79h69VNaZJL1EjHPqZG/SgEu5rZP1Vu3FjS44BiQp+2Lce1J2lzq
	Lncvv/n7DwkYzEA/zgmbGr/yfgXxFbggR9OpNKGEWwqFbBtlGoHrLQUq2YY1aywPMulfvF8YCzg
	7Xlt3OTyp/5a+9WptgvUE8zX57i1zLYgaH06FbFK2tyi+lAvJ2jVMeXgWHwjSNgBXv2DUIAjUSk
	a5ysqRVQi1SULGDL0M2uta2pobnU=
X-Received: by 2002:a05:6a00:189f:b0:771:f071:28fd with SMTP id d2e1a72fcca58-776032ab5f0mr2570367b3a.14.1757583445425;
        Thu, 11 Sep 2025 02:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgldY20V8+urkr4ak6p4W/xCCAQs/UMUOmo7GZX/3jtAUQrbLaxmJeSauXvSu+LH87TMBpFg==
X-Received: by 2002:a05:6a00:189f:b0:771:f071:28fd with SMTP id d2e1a72fcca58-776032ab5f0mr2570345b3a.14.1757583444893;
        Thu, 11 Sep 2025 02:37:24 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b730sm1512930b3a.15.2025.09.11.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:37:24 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v2 0/3] coresight: add static TPDM support
Date: Thu, 11 Sep 2025 17:36:55 +0800
Message-Id: <20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmYwmgC/x3MwQqDMAyA4VeRnFeogQnzVcYosYkuB2tpOhmI7
 27x+B3+/wCTomIwdgcU2dV0Sw346CB+KS3ilJsBPT79q+8dMQerVDWGmnkN9st5K9VNg0wokZh
 wgFbnIrP+7/P7c54XZWwnvGkAAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757583438; l=1654;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=1KctSP7tT4hdSPnIjjOWWclG2Dc6KV/r5m/+90egGy0=;
 b=hSQm9OeSCW4I7m/wlMm3hqgEn6GP+EQWEMukwgLy9pq1T1ns/FGnhrgKP7d8mj011uKFnkTYE
 hPhMjeqM/96B0FmPC3N14+NdrVJs7IsRLNLBGnQAe6Y2Z7r1dIy+oGf
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c29856 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nhnTKuEOM_5bWBThM9gA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: gSkM_HrDg3PMc0ODPY_D4Lj0mqi7s037
X-Proofpoint-ORIG-GUID: gSkM_HrDg3PMc0ODPY_D4Lj0mqi7s037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX4vp7p035lfbf
 rSHAG7pQGFZoZgHzYbIXRN3Mlo/s+paAtdqySNqZ+hIIM12WkCJ2zkm9m6ikvVwZQdV+Wrl1yAY
 ZXYoTndOzOfxTvtvjQNnYmg0Ikv0VWF8+q1xyyAmTHPst3keN/IIz1dnVRjBt97edjitvuqMJp2
 NWkCUFhIR7k+nwer3J0pHrUYOSnK6nlA33O2rM532LL5x4wGnElcxErFgIEuTWWRwNfVoicm34T
 8PvwgrIJGsyc7ZcViyrsUCJyA6QiooY6ooW3KSkC2F88U41ZJq76VAD4cWln79UQ26oVe4PUDwJ
 PbxQfNsDx534YHO+gnysEVcE3WH8AFnrOADs+94O+B209in/jxAK8Yf05qmmX7Sm3akKhloA7Ck
 H5tLKmAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

The static TPDM function as a dummy source, however, it is essential
to enable the port connected to the TPDA and configure the element size.
Without this, the TPDA cannot correctly receive trace data from the
static TPDM. Since the static TPDM does not require MMIO mapping to
access its registers, a clock controller is not mandatory for its
operation.

Meanwhile, a function has been introduced to determine whether the
current csdev is a static TPDM. This check enables the TPDA device
to correctly read the element size and activate its port accordingly.
Otherwise the TPDA cannot receive the trace data from the TPDM device.

Changes in V2:
1. Remove the dependency.
2. Collect tags from Rob and Konard for patchset 1 and patchset 3.
Link to V1 - https://lore.kernel.org/all/20250822103008.1029-1-jie.gan@oss.qualcomm.com/

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Jie Gan (3):
      dt-bindings: arm: document the static TPDM compatible
      coresight: tpdm: add static tpdm support
      arm64: dts: qcom: lemans: enable static TPDM

 .../bindings/arm/qcom,coresight-tpdm.yaml          |  23 +++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 105 +++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.c       |   9 ++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 148 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tpdm.h       |   8 ++
 5 files changed, 256 insertions(+), 37 deletions(-)
---
base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
change-id: 20250911-add_static_tpdm_support-b6eb2ecada26

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


