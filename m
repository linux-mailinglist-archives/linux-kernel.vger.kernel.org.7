Return-Path: <linux-kernel+bounces-875443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6493C1902E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395C91AA0D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F6318125;
	Wed, 29 Oct 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJdOyt9F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VWD2m9k7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E6317711
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725783; cv=none; b=aYs6qm5dlb5KTFxvdJaY1CHDOcTNrtph5PNo0LC4GXVl+IIzdKIOjtt+8bs+ZqBYpG44Fypjk1cBTlfE/qWkLan0L6ym5DwTBmrBKzT1+1/QHjsEqDHtRD9RUCqx1Rkgclv5rRkQkPg3EbkNMRKVoPgxSbF7gkxge/Kit4pbOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725783; c=relaxed/simple;
	bh=KLTyHWEAcaKr1eRQGtyWJm7kWu7wVUNzKX0WRgsTt1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ddh9oGzuLuzi5XnQhT88HMChXr04DA/8trK2Km79ggLeNxhiM1eOYv8b+F9/dK4gvysRUNsEO3Ld+MaO0n6f2pgXrx7cwvgskGWbCV9eWG/eRAjbUQz6slSECG38Bd5xSIt+KVY5evURcaubmuYDrM6mRgqE/h+72H0mpJrsovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJdOyt9F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VWD2m9k7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4utOY3692109
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QeivkgIAz76HiBHfRH/41C
	LBq7zxQHuMJPrMhMpbui8=; b=IJdOyt9FNkI52GhAL7ksgUSuZ9Y5RyhtC55q8x
	J050JEEMA44qPATGIDdmgc8CL7WWlPjrpibwguqTV/tKb0cQM+H5omnDKGUw0ySV
	+o0wEifCR4yHksAydoOcWT+Qg/KVwgjipZMA7a8EA4qq18BmDKBI4nANkzM+IrOo
	HlWzKLysbJ5kTc2qSIRDZjH+MmofV6R+IIbo12fg/xVnu0kmBGqAf44YYzzTlotI
	K7dWDAjqgYCg2KBWwfynIEUTdxCUQevOZ2gcdbjqnro/Ek320+mgTALEzMA+AF85
	yB+j4vfxqE4g2Lh9CNIQlggrQAp13v3q1NgvWx86vnaSdtZw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2hr9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:16:19 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5db56fb3fbcso9120835137.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725779; x=1762330579; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeivkgIAz76HiBHfRH/41CLBq7zxQHuMJPrMhMpbui8=;
        b=VWD2m9k76ppkhKhqcbj6zoxFJ/O0DD1d46/Khn5MZjGnNlP0pmQ86NN0myBdNv/JUT
         Vjb9ahySgQQrJtU77/QtZP88vy36ltU2O3ddEZN+y+mCTg3PYMBSmuF5PbDUA1kCVKa4
         Ysb/D9hbNZTUY+nxFbAG8sMXP7xYLUIJ9YgXkyVgfoeL2dZ35lpy5YLrnFD8xiyZEC7H
         80TRPlLKXW6i+vmXRTpQJ6MGk9AwrbhmogPgAeOUEIybruHe1dYJG9TmQwmwEUX3UUgo
         lH1dJsfGjZHday+8kUbThQFRxNZ98QzYaLLLOhdtBfJps4UsbPg57mABMZ76wzTQETUn
         oCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725779; x=1762330579;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeivkgIAz76HiBHfRH/41CLBq7zxQHuMJPrMhMpbui8=;
        b=qJlRH4+fFXIc7yreJG+nTD6PgZlxAHKhYT322BvrqA9ohB5lDoi5RQmdoLlRnke6Nk
         4SYT/dy6A9byLpZYaBERIG4Jl0fRNuSECVcPj5T+oZn+poriFHcMERX2ysesTaigB2Gc
         dKkNuL0vP6ASrfyeyyvtlEVtvY/f0nxFdkxYLSekOVK8BUu35dBbmuze1L1TEsQXbBnY
         VEhXZ0mDqfa0bEuX2OMqM/T6/w7mgUijm0X9w2m2iD8xcE0L7OOkpVKtYWX71EoGY7Gz
         AqtS1lB16wBmbfrPwP2xmIE+ZqJiW7Jj6SnN3GZMAQloiSBzPSDCeLc7G8aMACvZivu4
         2nhg==
X-Forwarded-Encrypted: i=1; AJvYcCXZEuMYOdGGR3n6P3FpTM+zMV2M2P0EVd6yugKhDXcvZ83uST4gwf6ECZ7ZIvlGRx3TYgtRP2jwADKkDDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMT15VeCWX6OrtAjWDmVnNNd5lEdgMbHfVlDR9067ZbwbEcaT1
	XZIOVU24sYnyMMgwfY+6pLHBPCpMQlzUn3oEr7JgdnEzAEnsr0QyHprl1AtiRCdRx/ZUxTNA8h0
	LdssRd7lflilNm/5wZV0stpeEP3zhyLRAU+eaNYJw//IxgafSMpsmsFdUgB+STZexc/c=
X-Gm-Gg: ASbGncsfhT9XgLvxqp6a00iFe/UIkfUI4lm24b0OX7BZuFqv2loRz+6PB70zsWK+AMT
	68iJ/cABU4dBERDZ+5XsHsD1DVnBDW72ZoZkKuDc6xxusjU9qkPr6g3/LVikGOjfBNRW/ynnLO6
	u/ERtjVIraE1k8ola4fAWML0n/q6iAbb68C0sdsXIFsC5XvC6N0c86P+o1k25VuskG90X4wESKA
	eSjyMM6geJFXtqIKkgxYYM9F171oGTMGSWGdQ0oDifZA1Yko5dONPSOTIflZ83B21NxRrXY6dBT
	mgcrvvVB42/ramf1VT8WY0FhIHF/0yszGDO8/wJh3BTEPRNVr2fyjMI0PMK7yFoWHbTJYxzF8kM
	FJ6O5bbbQNgqUawhQvvkVms3EDzIA/YZqlItIE8Vt5fjrp8W3aA==
X-Received: by 2002:a17:902:ecc8:b0:269:8072:5be7 with SMTP id d9443c01a7336-294deef6753mr23722335ad.56.1761725145780;
        Wed, 29 Oct 2025 01:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/y7bkWhIxx0Myxzh6vjq+isdNvogeuTT3oJcV1MrMZQLM6S5Py7etz8cDRf4QLE50KCO0ZQ==
X-Received: by 2002:a17:902:ecc8:b0:269:8072:5be7 with SMTP id d9443c01a7336-294deef6753mr23721835ad.56.1761725145134;
        Wed, 29 Oct 2025 01:05:45 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:44 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v2 0/7] Add initial remoteproc support for Kaanapali and
 Glymur SoCs
Date: Wed, 29 Oct 2025 01:05:38 -0700
Message-Id: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLKAWkC/12NzQ6CMBAGX4X0bEm7ID+efA/DoS2LNEpbu0g0h
 He3cPSyySTfzqyMMFokdslWFnGxZL1LAKeMmVG5O3LbJ2Yg4CwFtPzhAo84+RlD9IaboZFlXRS
 yx4qlpxBxsJ9DeOsSa0XIdVTOjLsmKWCfjZZmH79HdpH7+CiIFsr/wiK54JWUeqg1NgW0V0+Uv
 97qafw05emwbtu2HzgamczKAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=2358;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=KLTyHWEAcaKr1eRQGtyWJm7kWu7wVUNzKX0WRgsTt1s=;
 b=faSqcdKYBrQNp77AXE7+l4Bwfer/H+ghqklHKylwMz6VlE3VL3AsVkgHEKNACI2O7MKpdBu8J
 y5N7wBgwkC3DIFWxw465Pjo7iEC2LV6lBuvQeTCakPPVGfL3DP9y1zH
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: JpUTuH0Cy4T9dBBFLo9jqNS6Z4DKgCnt
X-Proofpoint-ORIG-GUID: JpUTuH0Cy4T9dBBFLo9jqNS6Z4DKgCnt
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901cd53 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kDz7l3ViJ1xZ-f_3I1MA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OSBTYWx0ZWRfX7KBL4r3I/I0M
 CPAFn2O7FbDRonk69aovU5B1glUaaL1+FWDr4ORUCGK8raos7YTqqQAgv+sN2oL29KkeUqNuQAL
 fWK9EbKzMyip/wltmWQ315qrFx6iG70FZOI9y2sx33J4zisoLMQo6Vazle5T2WGrJHoICNq0cdp
 9ckaNhdKGZ0XhJPYslTR5FQq3rD0HzIzeJ/tgjj1c7rYlrWrYOSWImfFDSCJH4jwKMAKZJLKxNT
 DC3t0SGtMjpTdrXmDVeQr0wvx/GAK7eo0j+Ralqdg0mPWcEAQUBXaa0/bui6tkXTSkVJUrf6sLh
 +9ElLdUxGd2rLKfvGSOFGagd3qeBl0xvqRKa2KzerYpokvVgrhPD+aS6bi0KemIUHAxWFwWIuRW
 xDB2KIPb93tcaa46ZrAy5QjrsIrvTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290059

Add initial support for remoteprocs including ADSP and CDSP aon Qualcomm
Kaanapali and Glymur platforms which are compatible with ealier Platforms
with minor difference. And add initial support for SoC Control Processor
(SoCCP) which is loaded by  bootloader. PAS loader will check the state
of the subsystem, and set the status "attached" if ping the subsystem
successfully.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- Drop MPSS change
- pick Glymur changes from https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com
- Drop redundant adsp bindings - Dmitry
- Clarify Kaanapali CDSP compatible in commit msg - Krzysztof
- include pas-common.yaml in soccp yaml and extend the common part - Krzysztof
- Clear early_boot flag in the adsp stop callback - Dmitry
- Use .mbn in soccp driver node - Konrad
- Link to v1: https://lore.kernel.org/r/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com

---
Gokul krishna Krishnakumar (1):
      remoteproc: qcom: pas: Add late attach support for subsystems

Jingyi Wang (4):
      dt-bindings: remoteproc: qcom,sm8550-pas: Add Kaanapali ADSP
      dt-bindings: remoteproc: qcom,sm8550-pas: Add Kaanapali CDSP
      dt-bindings: remoteproc: qcom,pas: Document pas for SoCCP on Kaanapali and Glymur platforms
      remoteproc: qcom_q6v5_pas: Add SoCCP node on Kaanapali

Sibi Sankar (2):
      dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur ADSP
      dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur CDSP

 .../remoteproc/qcom,kaanapali-soccp-pas.yaml       | 134 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,pas-common.yaml       |  83 +++++++++----
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  26 +++-
 drivers/remoteproc/qcom_q6v5.c                     |  89 +++++++++++++-
 drivers/remoteproc/qcom_q6v5.h                     |  14 ++-
 drivers/remoteproc/qcom_q6v5_adsp.c                |   2 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   2 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  81 ++++++++++++-
 8 files changed, 402 insertions(+), 29 deletions(-)
---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251029-knp-remoteproc-cf8147331de6

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


