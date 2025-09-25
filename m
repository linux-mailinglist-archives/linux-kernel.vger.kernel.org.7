Return-Path: <linux-kernel+bounces-831749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A09B9D79D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B7D1BC0962
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A352E8DED;
	Thu, 25 Sep 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kpDwu2fF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC72E88A6;
	Thu, 25 Sep 2025 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778587; cv=none; b=Gy94G6VbfPHUxSewUYIDY/j3i47k57HNSPvI/NJFMwEfl5aL6A9duOGVhUESy77zo9r2mWmyIDb5/xmf07uDW1KQvo9oSd80ElgsFmduP5RI+SzH8YnzscmydDkDtXw9G9Fv+tyhJ5OKwgQAja7wipAh0cAWi0Vdw/phSLLOuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778587; c=relaxed/simple;
	bh=c0V1dQ0V/PxJus1LQibgssi4WjyTxsZDMbNQ6GgQoVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bI7G0jJfSFiYYlMYR9XCa1c51gn5jZ4NpULJ7PyDHOPJXWKNLclTCI0lfwdkLTa9A2s2FOF8UrX3dQzRC5pU0vpDY/J182faO9E6ngmFdT1tjWgNCcnqxxSrZeE4kPMahyPgz5e9P4d9Edop/0c4rQAzcibT9nYvSytHErsBPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kpDwu2fF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONiVpv029044;
	Thu, 25 Sep 2025 05:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SiJomSvigflcijZ8Hjhvzj1Uqeo93IsBHsm
	HqGcw7/A=; b=kpDwu2fFbppkzOsLivAyF5PSWJu5anhbxPOvKLtMCWidQS49/pN
	iVmEiIORrnYIDLi2l2MjpiIAoes9FP0I/0aOwraPXiUIikhKKbLSJgplMDz2FYjz
	JmuWOmVvZlkA3SHlmOkcMhiHb8Bhl2jT/QXwbK87KCk2dPYRQfzSbW80/5vExocv
	NtRTGxBwSm+DA5ZhMPB2GXStZX9o9zPbnrCRLRhns7QVCcw6TcchAbfEeaeQTzQ3
	VNl+sX+LA0JBoXCrNSm0852y5e4Amg2dddQhbaMNlEaYhNhtOiV8DdmhYxdiHWTK
	Y2rnq2Kk4bUs0zh6BYAKq50GjNLnKWE8lVA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmny7xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:36:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P5a8XK000688;
	Thu, 25 Sep 2025 05:36:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 499nbm8bwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:36:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58P5a7cU000660;
	Thu, 25 Sep 2025 05:36:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-amakhija-hyd.qualcomm.com [10.213.99.91])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 58P5a6Hf000658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:36:07 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4090850)
	id 2276B56F; Thu, 25 Sep 2025 11:06:06 +0530 (+0530)
From: Ayushi Makhija <quic_amakhija@quicinc.com>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ayushi Makhija <quic_amakhija@quicinc.com>, robdclark@gmail.com,
        dmitry.baryshkov@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: [PATCH 0/3] Add DSI display support for QCS8300 target
Date: Thu, 25 Sep 2025 11:05:59 +0530
Message-Id: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4d4cb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QF8eukqJN6OF58MEyQAA:9
X-Proofpoint-ORIG-GUID: mao4Vumg_hcFxSHGZ27kkNsPawBNMjdT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX045a6HG9M8oj
 Lm/weq4J7EDhk7rV+dB1C/mYmg4BwaWrMbuxcPtYA7o8vS9HHsvlBpX02shryMBBa2liH2TpeW3
 +27xtjJ2/qfDrUCkuO1sttEBj5fmcwbyr6qTlHDvpkdVAd0FSTXHK6omye+YI6TeAAI9D7olWEJ
 6hDbR/gi5WQC8Wt77X4DTGdYCpxPVIX+ME7Mu3sSx25mZjSLZYG2Mh/NbpGf1OmQz+0np33RfeK
 L7kKZ9eJ0GI6O4ncmKghCFJqzgPJlqbdmw9c+HmMcu2VifcJaLjzIV9Z2Vb6K4opL55sQOdj0jU
 DHhg/KdgMo4KMjFCQ7vlicK5r8+TUXm9zpGhKPs0KiHLDZ7EU1qyJxY9J7E9MEPaFOL4FsD7cOX
 ekCWMCZX
X-Proofpoint-GUID: mao4Vumg_hcFxSHGZ27kkNsPawBNMjdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

This series enables the support for DSI to DP bridge port
(labeled as DSI0) of the Qualcomm's QCS8300 Ride platform.

QCS8300 SoC has DSI controller v2.5.1 and DSI PHY v4.2.
The Ride platform is having ANX7625 DSI to DP bridge chip from Analogix.

---
This patch depends on following series:
https://lore.kernel.org/all/20250916-dp_mst_bindings-v9-0-68c674b39d8e@oss.qualcomm.com/ 
(Add support for 4 pixel streams)
https://lore.kernel.org/all/20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com/
(Display enablement changes for Qualcomm QCS8300 platform)
https://lore.kernel.org/all/20250917-dts_qcs8300-v6-0-5c862aa80f64@oss.qualcomm.com/
(Enable DPU and Display Port for Qualcomm QCS8300-ride platform)

Ayushi Makhija (3):
  dt-bindings: display: msm: document DSI controller and phy on QCS8300
  arm64: dts: qcom: qcs8300: add Display Serial Interface device nodes
  arm64: dts: qcom: qcs8300-ride: add anx7625 DSI to DP bridge node

 .../display/msm/qcom,qcs8300-mdss.yaml        | 100 ++++++++++-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     | 170 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         |  95 +++++++++-
 3 files changed, 363 insertions(+), 2 deletions(-)

base-commit: fba389ea7aa6401d3539456123cbadfa1a87231e ("next-20250922")
-- 
2.34.1


