Return-Path: <linux-kernel+bounces-833776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F18BA30C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21D44A0374
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D50272E41;
	Fri, 26 Sep 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tw5Xfq8o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0318B0A;
	Fri, 26 Sep 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877248; cv=none; b=Grd4M0HQkChoxnCly55/cw5T1LMMppIlizTuXg6yJ711PxJDrAqTu8sEHO3H6RW5xe3cZgbMA1I6MAvNHgy6/LO4rSU/JI5Qfxd83hWHA1DRtp48BiQtvDMIaSVp3DqoiyPTDsTEJVnf3/xWrm43ZxA2zuL0+Q6W3tXEEtPkPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877248; c=relaxed/simple;
	bh=WWDpNvPiqmwGwe/v/zOLky7nQ2KjXJlvRx5rMxJnc/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GINwwMJmyJofWO8s+oQuPmGdbwdzUXWKy2mqhFgw7Idiur2UOt5IR2kbe9eAsYIvqSaGwSRz6Hzxx4YHiSwE/ZIvd3hnGiTbQKdcLyxlcvEYUyewmRiKBxtIkMLvoZ2zUV9+w1dSYBzSkYdI0Nf5tw0Lt3wiCVe8pHRZNAYGquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tw5Xfq8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vf68014653;
	Fri, 26 Sep 2025 09:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UCoMwItGIyl
	GWwlKsEn7FzcN5hFQicL4AUyg+IBkyIE=; b=Tw5Xfq8onbozBoceq42aulLZLFE
	UGYozTwaGkmg0TD+WTgISNTRXCLZy9FfIkRY9hXC+4O4HW1QQjivaLWoq+aDMJBG
	I9e0MhQ6HfToT4d4A5cMLmswt0ijOPQGP3UKV1GbDqg3d9rCCd+FyE/1g2qOnhuw
	pkrdySWpBGzMk5y1rIrSwsKDmRgq3QEDRX0ZJ66rX07bx3rirrHh9XBoLfkKuIfP
	E6nPh94+ywRbCz/DZ5r1pUdL+6hIqIquIiyFYvVx7u3olN0xrumvWoFz4tn6Eurz
	YESY3LHIety1IXRv/HBNyzx8MEMUdsYW5bIM9HoY5tZ4c9Iy2OgHkoNjXRA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34j642-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:00:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q90AAo008598;
	Fri, 26 Sep 2025 09:00:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 499nbmgtnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:00:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58Q90A09008576;
	Fri, 26 Sep 2025 09:00:10 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mkuntuma-hyd.qualcomm.com [10.213.97.145])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 58Q90AVG008572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:00:10 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4582077)
	id 946FF588; Fri, 26 Sep 2025 14:30:09 +0530 (+0530)
From: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
To: dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
        swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
        sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
        alex.vinarskis@gmail.com
Cc: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
Subject: [PATCH 3/4] arm64: dts: qcom: lemans-ride: Enable dispcc1
Date: Fri, 26 Sep 2025 14:29:55 +0530
Message-Id: <20250926085956.2346179-4-quic_mkuntuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX5QtksjJfS2dc
 CJpSXCAGrAkuEkyzdYaIy3zvAPDcTcH3R00jZUdsVZZlX2TkRosGEXxizukV/ESV6J34m6SZ/sL
 c8/5qigHL5IHlP9OAXYO6Dxrxl042lVtBlaa5VX9P0UjWPG9Aw2ARMOflvGPP6TFjcOFE1alo9t
 QSSHKRb2Oll3EE1wmVhOwWk3tgl1ajUCH9VqF1RCjGi7VG3DJhur+67c5FZ6WLglgUfQSqt15Ab
 DAu78i2W/qI5ShrUJAJG/3WnbWuXeewuVP8B7HFV1mLzXurdV2dnsFms4unnRxYn8YTivkmqdYc
 JOdwTgBOHt8t74DHUz025fftQ4z35YRvvgfXM0TLCawTj18TuQfer2itPDAxd+pUSk1GcVCcpNE
 Hz+iMbGBsZo2kRoiRomHlLOLQ71rvg==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d6561f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=SSmSCUx-GXNnXgCnb98A:9
 a=TjNXssC_j7lpFel5tvFf:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: iOZubqZOJaGjGu0keub6oo1tIV4FZbi8
X-Proofpoint-GUID: iOZubqZOJaGjGu0keub6oo1tIV4FZbi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

This change enables display1 clock controller.

Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
---
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index c69aa2f41ce2..d4436bc473ba 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -436,6 +436,10 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&dispcc1 {
+	status = "okay";
+};
+
 &i2c11 {
 	clock-frequency = <400000>;
 	status = "okay";
-- 
2.34.1


