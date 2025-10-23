Return-Path: <linux-kernel+bounces-866821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D50C00BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3850191C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699630E0E2;
	Thu, 23 Oct 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXtv2thD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C62FB99A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218977; cv=none; b=Ib8ihsbOSeV1jJLbFgaBNgTxerGQ9xihfnhHIhtkNrHvUSsov7TB4H0UTDLtru9qwqCKxIYGFfPzAboZBGVN9KSXZqSJKi6v3txeZ65+lxEb4n/Vvoz83yfURcIO2OU6E5yPnsUz/KAgTuyOt3FjhfgphIHw3O+RAmRVDen+unc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218977; c=relaxed/simple;
	bh=1jDd8Jo+Lv7AsUUim4V1DT0S98q8LzCRKW9vJCyfXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4a/HwzT3eRTnzhPdGeOEKKrxJZTZp3RsKbxYqRHPLJo1tBAaaa5KPDDPlQFk0sp89/8pgbS5hPxr3b4TqOcjPs8h180SXpordKQy5XpY2u4f1Vtowg6O2sMtD6qpI0I0tOvKtrpsHD3fVAtcorvfw5cVPbUnHy6rhWD7xES+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXtv2thD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6xYF2005790
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uIRW+tJ1sHh9tj17uy8X8x7Zj3ryD5FfPGl
	NlKORe+c=; b=iXtv2thDlKf4FPos8+PsKBw1o7i9eT8tarlGQYJLZPDDpLSJt2O
	67pJReCvMkC3KCMNvCwlJUVRgfPywQ4vgGqVdo+YVn7wxd49hj8ZTEx4IEpsIkjE
	hfITtfBCfsDdQHfwv/7kQhJZmTWK6ajcz5bAu6Kvq8FCuuWbjyUQ417YOqTVsSmp
	J58Ff7UiOP37sw8UmD4EBciw+X+ATRE2+fB9o/UAOHb3i5u+UuJzP6TXPeVjpP+W
	+H/G3fccBZPoqa5AQnKV20szz66LBkmbpnYxs/JIemnhy6O+NcSHc2RNSV72PbSh
	vC8M7r294omwJ7osqcR0LVhU0ITcf7BIXGg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j84ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-293063da120so1900495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218973; x=1761823773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIRW+tJ1sHh9tj17uy8X8x7Zj3ryD5FfPGlNlKORe+c=;
        b=oLQXa3bZJ0fOl+WYXeb2BTw5Y+jaLCBRJwEsIQfLp9lNxvsTbPuNd+azGLs3/CNCVY
         DbEbs5QHT8FBgLJ5xSbqNq/MqYBaG2c6XfhBUDp4A/INmoELQqrK8n59T/c9CIt9mr3S
         BKybNzYmDaR3CqKfSzeQoakSiX2Sdgbz5v3MpAoNdJl858uY+FPF2EWCnkFp6lAs05nE
         E2tA2Q1Kti6BZNcbHQBxpGCtjN1nKNlp0yuY+4CKag/iG/2Bry4Sc8/2dWfsX1BLEG9Z
         CeRoEl09qPBDaNuOHVUPCYLq2mqtbn/Bk7OLcj6Ve3pqAHA+yXYvG9owylm+nydOYJIJ
         elOw==
X-Forwarded-Encrypted: i=1; AJvYcCVUEfWO86LXKgh2dLBdosKj6qAYWtThF5j8NG7bNx9ODOE/DxyelRl7U6TUapF40kLC8SLC8N9Hd+q6vfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzxgu3Vfl3oAM3f2ITmV+KVRJaxp54YQBYGRyAQ99LV4Ucq1L
	30eLimPe1jiFGH3P0UuXupPkZvI4BR9ca1ieBjz6h6+b9Wo+tYEBlh/IYq8ADAtX+s4aZUhJrol
	Wj0ToW861uJduVClliKU9Z+t549akrzrFnyyt8MskotlL5+8iej3mbWSpoDHc027zog==
X-Gm-Gg: ASbGncsJEO9U72ohEygnqghFta4sFJcxMHQVZ9oWHCAwmFxELv8TVTmudosbn9sRBcL
	twWLIhtswU3z0oeaxXArIQWNsptV1GrnqujwzrKQbuHURMa7ZOf83tbZhvHJWzmKs5faJSgBZ7r
	fkP/ZkxMTLTteuLO9Vn8xab3HyYhJo1zKKvNoJnEO3P6LD6jaKBfLvzlpOm36eX3uqjX3ivFIXl
	aHEChUMN3ViHyDm+2gsFmTbY+Y8RX2tv/lMxs9IYAx/YEB7orZOGD3o/xD21Jlit2l97Ukcu0UZ
	KiVRdisPLdNDBfbi3iaISOw9o7n7bb9cmpW+JrES8kFAr/PQrc3+ruQ63rDbek5RkNXMPeXFnf3
	oWC8kI0rYIFqzN6Yjw6xIMS/yww/ZjQ==
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id d9443c01a7336-292d3fbbf0cmr66007995ad.7.1761218973060;
        Thu, 23 Oct 2025 04:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHL+TU70n2qTyvfs8ktt+I8r3/ZZAeRdKHl1cuECS6O6kimjZqydFi1762GpAmBkKwHt5XsA==
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id d9443c01a7336-292d3fbbf0cmr66007835ad.7.1761218972688;
        Thu, 23 Oct 2025 04:29:32 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:31 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 0/4] Add SD Card support for sm8750 SoC and boards
Date: Thu, 23 Oct 2025 16:59:20 +0530
Message-Id: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXxhn666XL0UqE
 X6Vu/zTPc8vW9VpZnaBlFIO764K7zVB4iudUxGxj801lXrq4+uZmm3ym+RNeCRAVrCi3TuE6xE2
 kLm3mKzhwtILS/hUigUfNk5fGNB+gnlZTpmijiY4/O4kE9N0CvhzNwbbVDl1WLvp1DumFpuEKeR
 4xcSrPrvY9hAn/NyySSBliai3E1LySJSLht6RdPLVk4GC+eeOp3PjOaWqROqAuXGM/0lIo6fade
 aFr4Q2S0B5fFzya65OP69QRdcHP+7U/ur6VL5veIKDjbmxTH7riR0Q+btWndun2Og10vNE0i929
 eUQxSOB5//6KF6zJ2x4m7hFljQ+s4Er1hhopDEfAfw1c31P1UntMz3nr0vq3abfKcv/MrwrddGR
 8zT94l1c13us/UexQDLx9R9QIs84Mg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa119e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3Kx62KuiyRAImmK_TA0A:9
 a=zgiPjhLxNE0A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: uHzG9kp7eUaAL_QAEbewsM0NknPUdtwk
X-Proofpoint-ORIG-GUID: uHzG9kp7eUaAL_QAEbewsM0NknPUdtwk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

- Changed from v1
    - As suggested by Konrad Dybcio the patch into separate commits per
      board and did formatting improvements (e.g. aligning < symbols,
      placing each item on a new line).
    - Addressed Konrad Dybcio comment to use SVS_L1 for opp-202000000.

Sarthak Garg (4):
  dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
  arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 68 +++++++++++++++++++
 4 files changed, 101 insertions(+)

-- 
2.34.1


