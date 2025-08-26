Return-Path: <linux-kernel+bounces-787153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8BB37215
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4D33667C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221536C095;
	Tue, 26 Aug 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izeZmhB5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79836808C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232487; cv=none; b=juT4IwQGDtVJoGu/vb4XEESEy2kI2CvAIQtR9/i5CUEVHZt6NuMZSN/SQRf9Pz2EVLhf5Rp2hasd1HVbCe2Alj3ui4AE8VWK5iAi97AGij/I717SwcqTv4vuqCgPUDDiQHsrOtjLJZ7H2zM5Jrh5iZakEoItLWK9SRaa5hdcJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232487; c=relaxed/simple;
	bh=qzHczj72h4oQbVLmtthjacKx7xf5SfWEL8+jy/CLgNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b4YMpihDz1nI8BCPvUN7HXfZsehU7b13tkJhuD08xwVYIXOWZKUL0wJHahfLuPK0KnU6NvUYhnD6AtObObloelnyB+b9DD6YMgK/OEx0IjAslX3dedzTZvfxMstNWHRnf7w8MJehHfviTuA3htrqeKl7U8QEkHofQRoAuExd+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izeZmhB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QD8EXK014221
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hPe0HyPY1257DHhbwG0Jod
	JXNJ2pFH3pGUWzM9Lk8eg=; b=izeZmhB5S/2lNjXv9zVR031HQw8TcVAcQoY5nb
	M2TCeDynyI8UGRkrt3pOK5LnFpxXHXymsGXyBjNATsL30XQGd2ysv0pExRbMYdfu
	4ShASPMQxdOaHEGrjgEBdZAfzt9DoPPtpPAMwx4NaTYu4zoeQgE/HSvqFSTDcp45
	o8YG9myaS1Q/Nr4sr12KmpXNIzb02ZmHUADwdkNZIM6Gk5kCKHxXML6pZVuy1Obk
	wPD1PiSLSDvLgEO4FGZYJkhu+WIkmZwd8qPGPxe4fdF8C96kOXTnTIoBaFGzqHlZ
	CBdny7iZn6ERBAsfHpB7OnWzKAUMbGQ2DoxIKWStNHEcvu4w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5htc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-770562b1ed3so4913269b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232484; x=1756837284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPe0HyPY1257DHhbwG0JodJXNJ2pFH3pGUWzM9Lk8eg=;
        b=VAExJey0Iv7cZebiDQFV7XOwKaf+DyP4n3wGoIgF+u91HIQOLh5rtwDWjdjj/tqegY
         DpGBRmaJRR35zOWkHee9kDUuJz16dvzyta9tTXJHdcsk4UzEVc6asISorTzRUgqk/U8x
         mXUktuWRuORoKlzrjci+coux1Vz1XcrEs4OYI1LSlqDex/YURc3dI+y3OFbj9BATl1AJ
         7CoM6DfIk5Ksb0g84WJrMFHCTZJ12cQsG1K+Dbm579CtvvYQfBZ3KXQjaJU3nqv9LOcF
         lxN6ahUQs5Mr5nrUXsJlZPJFLCO4iqsSIvAgoAHNBE+2QlzKEk4k44eywgTPYaGSbE+E
         /fBw==
X-Forwarded-Encrypted: i=1; AJvYcCVSBfd+u5MJ0WIWni/zCUdiIHRI/dvFpB05uHDRLYUK1JBdEc5/XcHrJuhi+Q3o7lj5AXFYaVUoIParSwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYwrY8hOwNcVZmuVLZI553bhXfPsIwi3W5gdL5DdMhKUrT1pm
	ZCFsJSm4y+1GKOo/OPzkvuQAxbFQr7f3QOUgNLK7YOCTcpCUtZsJpdpK7uc0FtFUscphUvqV93j
	+nmo3GUMT2fcy0YAq6jA8xJYhWRZTr/O58EpgShh0MzAnSMD4IQ/7wXqfNMc31rKrknQ=
X-Gm-Gg: ASbGncuuntj3WujYN/qkMReqLY/e87bMox5jdTFzDs4mASEeaGV46l6FVHAl+fcQLCp
	uvGrkU/RZq4ZmkKSf0uzVcugBNWqGKZ4LdNEq3828KMaj7XxJj+kYhCHO1CCis9MUYGMJ+GVF1r
	qoK8m0dRnn6oGBlaT68iXd9Me7S1xNjm2nJonjp9dyOj+1yo2QMjWKOkmSQm7gEbTFh0UA1L9hJ
	bADMVd6IsHvVcl4uSt1tVnSA9aE/SPGVOGppH58ZB2pP0KgewcSLh+Xdxw/BBYJ9IFZkLWXBAFC
	mv8gHKiLJzxcV+4bjH5VB4Luh3dAslLgTiOzeNmi3aKMbXDUZWn/at9sbIdBQjzPWs9i
X-Received: by 2002:a05:6a21:339a:b0:240:7ed:402d with SMTP id adf61e73a8af0-24340e1c3b3mr23574491637.31.1756232483792;
        Tue, 26 Aug 2025 11:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCUTgs+xlc+QQ+t40ZnsGhICVfnXPMX4kzaNskevdgCEI9w2BTmLMj8s+bCulNJADhimXIyA==
X-Received: by 2002:a05:6a21:339a:b0:240:7ed:402d with SMTP id adf61e73a8af0-24340e1c3b3mr23574443637.31.1756232483259;
        Tue, 26 Aug 2025 11:21:23 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:22 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Subject: [PATCH 0/5] arm64: dts: qcom: lemans-evk: Extend board support for
 additional peripherals
Date: Tue, 26 Aug 2025 23:50:59 +0530
Message-Id: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAv7rWgC/x3MwQpAQBRG4VfRXbt1R6PkVWTB+HHD0Eyk5N1Nl
 t/inIcigiJSnT0UcGnU3SeYPCM3d34C65BMhRSlVMbyiq3zkXEt3J8MJ6Z0sFIJKDVHwKj3/2v
 a9/0AhZSuDV8AAAA=
X-Change-ID: 20250814-lemans-evk-bu-ec015ce4080e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=2170;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=qzHczj72h4oQbVLmtthjacKx7xf5SfWEL8+jy/CLgNs=;
 b=4ggj8MHSr1SwbKvJXc1FvZJaW3gg4AdmaisjjsdsQJeAJ5meP6HPjvSkkegHG04U0Ef9SHmRk
 Zpnr/9l7/v1B4IPhxeVXCNxvwgMo0ERudBzuwcJ0s6NCzdT/FN0Vzq8
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX5kdKXqKNj00A
 la7Ci9y9H34d2CdEKV0ZpqE7ifqH6m3kwVyf1oYjSPJxxyx1d/GlZ8BHIoVRM8VypDZFL//kPUG
 jl/iT3EpunLY3MA3k07oxkgoUBA832Qh/Qp4N9MYpiumdBquMCW95VSLEJGjidWgKoE1tbz4EJB
 sWzPsFov8ji2u70cmfihB22Bt1crZqNSAKGaqf5jdKJYPVksohFb58BtmLJ9Mfttk6VFZLNt9cS
 25q9tcyFgwtDs1UWa+o53wrRRwWdGfCZcgWDDn9pChEqw7Lu04N8snTVmdthy59XGhn4LcA9HK9
 wpYPbtXIlcuKVWm9y2Hj7GlXGTRCeCX5rfUcm2nnXtXngIwF1AKGzrAgKMTpnSQO3zJuBzbhY7R
 cjnMIOAo
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68adfb25 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TdWL2oi4fdni6beYElwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: saNNt5nUabwHFEcdEANDoqCGohI-vHly
X-Proofpoint-ORIG-GUID: saNNt5nUabwHFEcdEANDoqCGohI-vHly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

This series extend support for additional peripherals on the Qualcomm
Lemans EVK board to enhance overall hardware functionality.

It includes:
  - New peripherals like:
    - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
      for peripheral communication.
    - PCIe HW with required regulators and PHYs.
    - I2C based devices like GPIO I/O expander and EEPROM.
    - USB0 controller in device mode.
    - Remoteproc subsystems for supported DSPs.
    - Qca8081 2.5G Ethernet PHY.
    - Iris video decoder.
    - SD card support on SDHC v5.
  - Audio change [1] to support capture and playback on I2S.

Dependency:
  - Revert commit b5323835f050 ("OPP: Reorganize _opp_table_find_key()") to
    avoid regression introduced in linux-next (20250825).
  - This series depends on the removal of partial changes from patch [2],
    which are now part of the above commit and are causing boot failures as
    described in [3].
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.

[1] https://lore.kernel.org/linux-arm-msm/20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com/
[3] https://lore.kernel.org/all/aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com/

---
Mohammad Rafi Shaik (2):
      arm64: dts: qcom: lemans: Add gpr node
      arm64: dts: qcom: lemans-evk: Add sound card

Monish Chunara (2):
      dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
      arm64: dts: qcom: lemans: Add SDHC controller and SDC pin configuration

Wasim Nazir (1):
      arm64: dts: qcom: lemans-evk: Extend peripheral and subsystem support

 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   1 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            | 439 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 124 ++++++
 3 files changed, 564 insertions(+)
---
base-commit: d0630b758e593506126e8eda6c3d56097d1847c5
change-id: 20250814-lemans-evk-bu-ec015ce4080e

Best regards,
--  
Wasim Nazir <wasim.nazir@oss.qualcomm.com>


