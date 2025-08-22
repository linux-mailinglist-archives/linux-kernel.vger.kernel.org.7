Return-Path: <linux-kernel+bounces-781682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AACB31587
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155963A6AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C732F530A;
	Fri, 22 Aug 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBVbF8fk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB92F4A12
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858623; cv=none; b=nyZ6XBx4CPepmKJjmvwnQtNWyItJl/tc6Q/K48NL8yBHmit1YeGOsrhOvmBMhHIfluwIOmvUURyjfQ+u3j45fDHcv00Wx4y4/nVVabLZ1ASH5E76ckSEZtB8b7wW4QMaS6k6NaKa0/l25Z4H3wEB2Q5k/lW9YULLp7jybzCKKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858623; c=relaxed/simple;
	bh=IZFswyabIJJi0zH6aBxL35ZR99UVJvCTrpStayRwLFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3snGc6AntLPt6HRzZ2yoJZOPoBTVztckmtcDBhhSa1gHkZ930F+4D0JUIuFasj5PsbEE8uvTHTEcNt500ASb6r1egh2TbZx9ng9qC6VlCkZX4ueWwOsmn9o/pVh/djPV93xWngDQL9valq6cz2P/haV2S+nLQw3klxuDQRKkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBVbF8fk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UKp4005637
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jcKarMudV2b8SNd6x7MSB0qXu7fuZnu4rJt
	xAKfBKPw=; b=VBVbF8fk6V/fMyntvbNNukuLIy+Bx/cQ7Mra2V6vyoOmt+vI9G5
	3lFSfcKZRVFbsEy9dZtXRMxXAWQ7VkHh+yHwBoAxf/gPRg3+5DPyam/3eA1L3EsU
	LltoADFv24tuj5aaKHGkarqvHoqeQqzTUpugsPVz+X/ctxJLb5MJWDwmLhThWl0c
	hmkwe9bgakFbTxdYe18l8SuhOp+eZDfHob2nfWisBbDVmyCbTwxch7JDIFuly3er
	WVArVyy9qa4SWXfpHeB687/FrusdRkkTx0m8caIhxOR/dTh9xNS9OyNvBvX3TVr1
	4M/5dlp1XUf2HBEtmaGDcDNDYvzOO1qF1dw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drsk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c65b0so3705323a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858615; x=1756463415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcKarMudV2b8SNd6x7MSB0qXu7fuZnu4rJtxAKfBKPw=;
        b=Al+QeoK1H7S2zcJErCsG52HEdR1C92X5fnb8+sVcCK5sXHat2lfypSmf7kCcTrryhp
         Ky/0ukvWpD8IXCIeWqnjeGm5uHaO8oD54FzsDr0Rc4TREOnskS5JJF1DLpXAEfHL49pi
         w+6eQ8P8lv0pe8Oc9fQlM97GIPxwvv0u2zjaGcGDIS3tA3lUq0YwPlApdXXs7i/Mcohr
         lCDuAU+oxdM5Y70syxLDFTq4FVBsb4N5Xtw62QROK2Rp1CNkHLOQcPfm2RUy7xclQju6
         MWmWYm2cbx0iftBfyY97iHR220Odo6pzCsVqPBrWpIgtv6LiITjgWH9fo1M0INc5rXAz
         I6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUYIHEJes0ig/MqkrckPiCSXDnINS6dsFRG0wkgtUHdKCNVJipX/71fbpkA/h776zGgB3RlTVpJEib28xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iJ/Pq4EX1H/XOsM9afOVaRSfXvvspQlc5ip006OVv8v/95/0
	rSz3i8gbszXjh8ca9H/5DuLbw49mVua69+z9LM2e4z3rwt4oXfChDkGstJlKQc/9Xv6oT+94IY9
	zFOTU+U7kVEJQFACmq6yQnpYlTrCco/aXnUNcMOWnWch2LsSR9S/Rn/sS9G7Ip1hFu20=
X-Gm-Gg: ASbGnctGQtTtngiXxAE85GN2KNqmL/s67WTJFHpjVD74zDbRbZDYo1BYLY0IkCu9Ka8
	B11C06OXxBRCbAhDGuUw+XyjzrhlV/kybkdgxT0RPV2ylNCDM+fVc39oJa7qI8LQp2vL5szj+mF
	mBIzzHTi7HXinRLh0FFsjMUb9LVbxpO7pcSM2NtEhP/bGCRkH9dsa/oKKjX/BfzXvTcpHOTmJPF
	GyVjg73tpz9uq1h7+9S7dwNeu4lFifShObgz9FR1iiwF6OCPyTwkT1lybjGEAtx5gBS5HY5zjAP
	vxsd1o0ut3TjzJFze3JqVJXGOAgC/DHPljYK8lXlJbmKhAuRyFPKvE5vsjx3qpFgr3gHkT1q9t6
	ghYpQECiwTsLGT0OY1T7U
X-Received: by 2002:a05:6a20:1584:b0:240:cd6:a91e with SMTP id adf61e73a8af0-24340b0ed25mr3975360637.20.1755858615179;
        Fri, 22 Aug 2025 03:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM6/4eD2DcoKaSA3nCo67Yg9ZTNA0p3eVi79EitYPShFXo+QxmspWgagHgSI57FCVpNE+xeg==
X-Received: by 2002:a05:6a20:1584:b0:240:cd6:a91e with SMTP id adf61e73a8af0-24340b0ed25mr3975306637.20.1755858614674;
        Fri, 22 Aug 2025 03:30:14 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fec0e9sm6825196a12.24.2025.08.22.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:30:14 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] coresight: add static TPDM support
Date: Fri, 22 Aug 2025 18:30:05 +0800
Message-Id: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyn6O6uj50o9q
 xx7GApUqV1b3wPihAA253kVAr04O2IvlsUYzzdAbTeDudJf851+uN6DpAY06e1RSksl/VbVAgjt
 h7Uej7nWh4bd6pwiy3l1sz2HhE4PYIxQZR0CrFhLop/+vqzwkA+oB3oRwIG/akq/3ml96kAtk+q
 eF1bvgqIi/eQl9KxRicEXeviD5tFeEJKyE9mic0o1MfZQN1dpgt9Kkqj8zo1Tsj6bYRoXE8wgMr
 Xa+mHWGrGKBL4UN3yS/w/PRol5ZKqkMLoS6ZZeiphUnwoIP8RDPd1+cwRizVrpYtMr62aSARynH
 olaXVEo5woXppSUGUfsPd7BmCsMvtPVEMTRVQkoZLeumpqPffwFY/35yJYpKw3zl1209xkpOUYW
 DRM634Bjhlr50zXcC+aRuFtjbGS/Tg==
X-Proofpoint-ORIG-GUID: GzPfnv35u3zBZjIoM4YMF2bzKxKiBQPT
X-Proofpoint-GUID: GzPfnv35u3zBZjIoM4YMF2bzKxKiBQPT
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a846bc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=miiTG7pHY3C1tMSzQ7sA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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

Dependency:
https://lore.kernel.org/all/20250806080931.14322-1-jie.gan@oss.qualcomm.com/

Jie Gan (3):
  dt-bindings: arm: document the static TPDM compatible
  coresight: tpdm: add static tpdm support
  arm64: dts: qcom: lemans: enable static TPDM

 .../bindings/arm/qcom,coresight-tpdm.yaml     |  23 ++-
 arch/arm64/boot/dts/qcom/lemans.dtsi          | 105 +++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.c  |   9 ++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 148 ++++++++++++++----
 drivers/hwtracing/coresight/coresight-tpdm.h  |   8 +
 5 files changed, 256 insertions(+), 37 deletions(-)

-- 
2.34.1


