Return-Path: <linux-kernel+bounces-744620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1CB10F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C8D587179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2E2EA723;
	Thu, 24 Jul 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mea3kXsu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632F2D63F1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372622; cv=none; b=nzQdOohwlqt1XqrqCLhQw8DxQy7xcMtvfBFTvHrIm+PaEmsawbRCD288yEaU1Yd5B/hFKGiaaSf6cSM7/y+rC7i5B9qI2wHNGl5zlGonw8d6DNTRw6d10cGxLlVxsuq9ZRbjDflhshQIHWWsa4Y1/FDAqA3GngkzBESFYsnRf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372622; c=relaxed/simple;
	bh=QUF20TEbvg5FnS+B3mFsBfe9lLi8WAEgPd7pDJJeuP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkHxF1KMU1OfLegTbmeDaq18qMmibBnZRFgt+L61l53quuX+xphFSFBYbcVLJ8O5+7b9f0UF4pROKStTORqFZPAYZJmmK3jRygOkuOXyHH5NRnXBTY2wa+Qpjha+vrNWCeSI7zWKs/DcpSNVVGIdFtEZ3s3Ju1yWNZBDq/BMoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mea3kXsu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ncqk005783
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Qr7A9PQNxrHiZR7GDwUr0PvXzP9qInDp+hj
	8sDBe6cw=; b=mea3kXsuOJ/v1eN4aiSwNqkB7cNhLX/i9iN2M6UtAq0Gs0xvxKb
	znb/FZoX3dSW7EIBmhM0E/EOC8iPJRSnod33hKj1mR6qX1Vp9ShTXqqxn1Xn54F0
	Kv/24q8WGoDEDZZoCeSWkaj4ZuJua+8VoxKuIdazkjJJSus5uBQrOcNvG5MD7Bry
	QQeyI1Mp+r0uVRgVAlK4Gy5MkIgZeMqTvOroJCDJTOO8D7XKOtXc8kX2pRxhUL1l
	v+KSxWT2OdUbGrV5dVXU9vawXM0pqExu8xj0kJPP4XXRqe5KuqtUqeCzaLQLx6Xv
	A1kQZpyi+LtJUH3cOQCGSnCr1OlWv2jJhlg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qhawv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:56:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so1633602a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372619; x=1753977419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qr7A9PQNxrHiZR7GDwUr0PvXzP9qInDp+hj8sDBe6cw=;
        b=Qx0pPpC29/b5bLvCg8co+OLsPyIHs/QwvZ+vcHHFXJ4ba+JV2jucPkBxJbVlbxHv0V
         ulvwymwu22Xd0SS4vybkBAyKOpQiJBeGek6jNZg6mTrJzJpcwtrNaP6ts0s6cTUq4mUB
         3TNbnbtnZ7TYp8vt153780ieniwIbCwiBph/k4gHupmoUD4goCIDK+BHwA6fHU23SaQU
         JI7vT26XF4JurAohAAJzXuzzuO+jd9TWr/5nrtEWMnKqK8z2k84mYDhiBU4LavfMBHGz
         VCr0UX5M9KuzVCnReMNSE9j8AK5YM9KD2dtbNvhUVHIf8XbDb+3kcRCkSnnPpZVgtiNT
         L4jA==
X-Forwarded-Encrypted: i=1; AJvYcCWuJyGKv78zCVEtZFPV3CbmrsNHS7fL0333hfEOMUgk0EAYxpsyfZwgaWy18B7wptTZ7QxA3dEoUuFNnk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BU98kXN7haynIUji8PXByvn3P6Y8mX48fsb1I53XREsmgCoD
	ao+t+ZtQ/rIwYGq/qL78GqHu+8BP4gWlvpQL9s93CPIhwJBSXnR74lFDF1se00AmSx/dUzB9qvM
	hcuqIRNTEkPKSLSpQ3Y30hCocuk+wFhxBwqX3swrzOqeNSTRZu8ey5TzMHWJjK1DCYGY=
X-Gm-Gg: ASbGncvaEC0yRVT9eR0/nkLwxxmQsuU6KpUU2ftvw9BWPu3a8YrhXm/6ofEMUxAVQyI
	WlWT6i0X5WLJYQr9KsGBbmF3xRLgYiug8kn+470GoFDkr6M6u8QSUBraVuetZVE5dgGM/ZzyvLQ
	MbBKZLXBPTFezlAtNBKRWQ/ef0MkYIdld73uNRW4ShR6XzcMURqWpBCIxqgWZIjVJkggxl9Jlyp
	WsDNp0oAazQursV60TsdIp4IJT9bKZ7tHqF0a679BduuKpvLEBgVUXzOxZinFzm56a6xvuS3qfU
	c6l2u2rLUVazX0PjS+Lx29nkAbetSegNtwbty4CiI+IVfJWUA0qgE/ACgJWLTmrHX7v9nr4wJCD
	r
X-Received: by 2002:a05:6a20:12c6:b0:238:e4d8:2bba with SMTP id adf61e73a8af0-23d4913b9d8mr13041360637.35.1753372618770;
        Thu, 24 Jul 2025 08:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD1FmFQQ9CRMiZyxPjL9yZQTW9Zc1Ud29qAqsHHY5goVdN+TXdgLfi+rYDIe45NT/+izd+vA==
X-Received: by 2002:a05:6a20:12c6:b0:238:e4d8:2bba with SMTP id adf61e73a8af0-23d4913b9d8mr13041318637.35.1753372618328;
        Thu, 24 Jul 2025 08:56:58 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b05e8498sm1988516b3a.98.2025.07.24.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:56:58 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
Subject: [PATCH v3 0/2] Enable audio on qcs9075-evk board
Date: Thu, 24 Jul 2025 21:26:30 +0530
Message-Id: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMSBTYWx0ZWRfX1r0HHeYoRiSf
 m2shuiEYhmZ/ClqD2KLPfgdt9JAmseW2eKmAj+goXasUoCWOhSmpHltpOQ3mtcBOp0SCGKpiXeG
 q0udT9SCkiZeYpDOI9yw3eShM9q644LVCfFATXoOVj7zi1ZRHjQWhObXIYFGBCzyugFoCY4H4uJ
 SvmwcbQhys1/78SSlck/LYqFihu4I5+E7GpCPj6a2xXF3yZkgAJSDxb0+nEPa9b2x2tkihJuMoq
 7STEsrg7bJ+72OY74Ag7M/WGSnWPVXDvF3VFITFoxxlQ5FVW74L0OGQLfv1P/bdXqlsH0mNY4nI
 Cv0HWFdb9Q7VpHEbzfbcOYjS4tmSqWUt8RxOxq52jJuZgNJPvg8ujYrF5WQKhP6m6Qlsi2QqiJl
 GOa861ZJeIT6nqlK725YsS6Talkte2xdAVsGSd0qMpRP8gytwxonupB+DJQL4XRIcoB+dquy
X-Proofpoint-ORIG-GUID: Hm7Nx8g58Y2s-D303RzNVy3F37XWFXwa
X-Proofpoint-GUID: Hm7Nx8g58Y2s-D303RzNVy3F37XWFXwa
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688257cc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=YkB-U3mbqUf8DnNMcaUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=942 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240121

Enable audio support on qcs9075-evk board.

Introduce HS (High-Speed) MI2S pin control support.
The I2S max98357a speaker amplifier is connected via HS0 and I2S
microphones utilize the HS2 interface.

DT-Binding link for sound compatible:
https://lore.kernel.org/linux-sound/20250519083244.4070689-3-mohammad.rafi.shaik@oss.qualcomm.com/

---
This patch series depends on patch series:
https://lore.kernel.org/linux-arm-msm/20250530092850.631831-1-quic_wasimn@quicinc.com/
---

changes in [v3]:
	- Updated link-name from HS0 MI2S to HS1 MI2S and sorted nodes in order.
	- Link to V2 : https://lore.kernel.org/linux-arm-msm/20250616070405.4113564-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Updated commit message as suggested by Dmitry Baryshkov.
	- Link to V1 : https://lore.kernel.org/linux-arm-msm/20250525155356.2081362-1-mohammad.rafi.shaik@oss.qualcomm.com/

Mohammad Rafi Shaik (2):
  arm64: dts: qcom: sa8775p: Add gpr node
  arm64: dts: qcom: qcs9075-evk: Add sound card

 .../boot/dts/qcom/qcs9075-iq-9075-evk.dts     | 52 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 54 +++++++++++++++++++
 2 files changed, 106 insertions(+)


base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
prerequisite-patch-id: 853eaf437b81f6fa9bd6d36e6ed5350acaf73017
prerequisite-patch-id: 6d9fd3e0257f120cff342c287774454aad2be2e8
prerequisite-patch-id: 736cbcd47d5e7cfcc53fcaa7da920eac757ce487
prerequisite-patch-id: 4eddce6daeaa125f14380586c759f8cb8997c601
prerequisite-patch-id: baac180e8715b5cf2922f79346440d92569704f6
prerequisite-patch-id: 65730290d31f18e66e2ba0dfdeb1844d7442c272
-- 
2.34.1


