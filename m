Return-Path: <linux-kernel+bounces-788370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA4B38373
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8194624AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F46350D5D;
	Wed, 27 Aug 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iv5yjl0w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A4352076
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300358; cv=none; b=FKMa1zodvHdlISAEEwgfjqDVz92+8NrBOKq2KptlCYV6h+urLdn7OQgKF1a+ouVy84s7iAPoUWT8z2gSvFTqXgDshGqkP2jZutjPm+zG4MkiEh66cWZUvT2tzcye1EAAvbsVMHM1q1s+EQSmix4vQrQJvny6u/FY9JKilTNw7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300358; c=relaxed/simple;
	bh=wNHOpxoC4zR5W2SsQuOl/a5tugAtZB+G2fBiQKiTkkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJxyUxRkR8qOm7J0FDbwKWkWR/q3ujy+bJ6J5sfvzhC4rbf6yRKKQnuWcLdFKdVNcJwdHFUMVJS/TzlfYDOcRBh+ReZKWRHIxs6xmx0KKC9wQs7KpTVnZJWVk+tgvsgDFNyoRFqUrb5w0BS7+jUryCRYbQs3O0kb6MFcYuLJEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iv5yjl0w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kM1a030523
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R1Dfu+2Q4fLYLmsvsmNFbs
	gROx5bEEByPXCdS9SAaXU=; b=Iv5yjl0wLd3sivMuSluu48AOeB6huGD4BkTzBl
	26ceBWK/wVdy5vZyi7tW1sz7vw9oH2HfJDWZkExiKc2F9xPpdA127grfPqvf4l7j
	86dnnleFH3dwRw0/WHnjbUtmphYgmZRrGs0sbQopBIOAmD4Lzie5szu7nNoOEihD
	XWe544Kg58+by9NIo6+mfiV/6qo9w+UHK2criyu1C+mP2go9cZFuD2CDs7eDU6HF
	TlH8OYV1NbyvIXlgVmI/U8xypIjqGlFem3h/ECMhSye9wNrBAY2tuqeqwF0h6viY
	gZXL47khrvn3tfrU+kapz0yXjWl+YRj9ZHEnEA2i+MROjX7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unvjfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246eb38205fso34059285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300354; x=1756905154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1Dfu+2Q4fLYLmsvsmNFbsgROx5bEEByPXCdS9SAaXU=;
        b=SKPjdIPG4KVDU+lmHSoefFe6uuWA/q/Y+101el2pqNhImvvxzMfE2BvsZqXj9IhkLW
         wDlcwfQSDGTN9sckg1uxACsq4zUdSVcizu3ROMKZiH4d052lPKSw+T5/3Fz15QwE1/TK
         dxDxfMC5sQYLtDGN3e98f3n2tRMWL68mSTh40MDEtH9bvM1Y9cD2oyAnBZoNJzK9k404
         8SkvtW8e6IgLaEftUjqGmCEbjgl67p35o4+sxPA63c3y5zJisvAv419Eh8KGYZbA6y2+
         VJc7PmbypA7Pc5dYAITowMFxbbebQSsnHBq1dv8WP1Gh4nyXb1E91JAPhMnjajZmAoi9
         1RHA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ+oH/K+SmaM8wTLwTVfefnIx67nJgTbJq4AgGSorR6wK3JjK/vttGwqRVkUGfU2kRwhnNI1U52iDVCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RWuixG2MI/N12P5/4UaI0Xk2aKJsH+H/AWjzyrU4lGOtYp1T
	SHMW+AfCVEsbwRiSyW/I8i7kRam6IOhJsStOh2yLn+v/LnsJQwtMKuQMB0d09Z0b1uqINENdcdA
	jbx/mvjbzt4k/azHbg5WW3La8yLGRxxgYW+STTsk/18h4HL0W2PSVGsFaCuH+/+kwRS4=
X-Gm-Gg: ASbGncs0pIAIQ5bRDQwX5duRA7Zg9vDUiuEnLQ9Zr1D+9NQts1zWrg69orfQ2sluF6E
	4PnKR3bXvO+DqOlUfunE5qZ66IrAg4vUHB7dLPDtFxyoT/6uuTUiT7w/o08Vxvz4cWdPO6sOwMW
	cn9FGSLxJpUM7DkLs+fEqxoLLeqPYcIu0+7b/iGrRo5UUhwVcHAhdn4OuQiTl5l67D7uZyNn2wp
	naBFrQPSNwjCnZiD8yczMkkSTMW6SqIM4Psdf1J23cvQj1+EHKyL+9uU5Z6xNbCOGJKXDmUj1/A
	Rs6cvu1+TE/a+OTg4N1kFT8AwzYDGyqY76X/qRARkAi/Mabsx0plK9bnyDs1DIiEOUn5c8KztOD
	I4VJN0R6MGXy8kFWHfm8oyLydNHZ1/7nBT2yLmpifuCyQPBF6wXEsJJ5o
X-Received: by 2002:a17:903:1b4c:b0:240:11cd:8502 with SMTP id d9443c01a7336-2462ee1a94emr193466385ad.13.1756300354120;
        Wed, 27 Aug 2025 06:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0BOvfFOszlFiQMTxGkS5f+OO55UHdx3mlSlCGxWi4n3Rh/1h+LrN8IN2mobtyVQzlxeLA1g==
X-Received: by 2002:a17:903:1b4c:b0:240:11cd:8502 with SMTP id d9443c01a7336-2462ee1a94emr193465925ad.13.1756300353605;
        Wed, 27 Aug 2025 06:12:33 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbba615csm11432972a12.44.2025.08.27.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:12:33 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Subject: [PATCH v7 0/2] Add display support for QCS615 platform
Date: Wed, 27 Aug 2025 21:08:37 +0800
Message-Id: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYDr2gC/5XQwW7CMAyA4VdBOS8oduok7LT3mFCVNumIBLQ0p
 RpCffe5lIkdu0sk+/D9Vu4ixz7FLN43d9HHMeXUnnmwbxtRH/z5K8oUeBaokJRDK30IMqTcHf1
 N5mvXtf0gm7aXlzobIMn7gceTRNAAUBNY6wRrXR+b9P0ofe55PqQ8tP3tER5h3s6NAhQUc6N8N
 spno2S0fDZGkEoWsfGwg1CFUIgZHPGFAOjVh47IGjqrY2Waypndouk/GuJ6TbOmCQmj9gRNXLT
 ipSGo9Vox3xacJW+sURgWjX41Uhbceo1Yc2R31rnIn0eLZl6a+49mWDPofSDQzlv30ea8vVz9s
 W5Ppy0/Yj9N0w+g1UFDYgIAAA==
X-Change-ID: 20250827-add-display-support-for-qcs615-platform-213111c51778
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiangxu.yin@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Li Liu <li.liu@oss.qualcomm.com>,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756300349; l=5349;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=wNHOpxoC4zR5W2SsQuOl/a5tugAtZB+G2fBiQKiTkkU=;
 b=d3OFDg31jJU9s9OFAD/l5HgWqOjvUaDhYPsABrX3zT+uEWtNRuKKgaNPfwxop8Vmkxp36FP5d
 HO8XnCscH02DuhJg1ZD8p4NRUvJndh7dyYTKnvOaVk4/HXIZgBrJUjI
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-GUID: kKBVCFapqRLe2uY7PQY9ranLJHsGhaR2
X-Proofpoint-ORIG-GUID: kKBVCFapqRLe2uY7PQY9ranLJHsGhaR2
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68af0443 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Gt9LB8JhNHHWnpI1MRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX6Arfjbmci+2Q
 RJJx4DCRBXNmFC1jRqrIbXLPJJKSO/97C1NqEexsQeas7j9BV5dCDIYb08MTSzejRFj5W691KLO
 KLDGaJJAcuwi7O/10VcaUPNyz2Jtwx9fZjcmcROUboBC4NJOafxVuSOUteM7uW/xH+CO3Fh1EA/
 2mMf9dCAs8qInqnSWlz4mSXxpP1cTrVjX1x2NIQoMViGkLiAb0/qf17b0nkQt+ZLBUX/lt6gSu2
 TgBkJNzYiTpIBa/ENoDxsT55KgIyo2VtIyOEphyjfpDb40mymv3lxamk+PkBuScOHPMTvYYianR
 BBSrueYzad+qtrO4eRsVEja9n563RMuY15dbH5dmnPk1DIfR4RzFwbzWFUD6iMUVZFiTUtOtLvb
 8Pr2tNIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

1.Add MDSS & DPU support for QCS615
2.Add DSI support for QCS615

QCS615 platform supports DisplayPort, and this feature will be added in a future patch
Dropped patches 1–7, which have already been merged upstream

The dependency has already been reviewed
- dispcc dts
https://lore.kernel.org/all/20250814-qcs615-mm-cpu-dt-v6-v6-0-a06f69928ab5@oss.qualcomm.com/

Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
Changes in v7:
- Added anx7625 bridge supplies as fixed reulators [Bjorn]
- Change gpio to pinctrl for io_expander [Bjorn]
- Change vdds-supply to vcca-supply for mdss_dsi0_phy [Bjorn]
- Remove "wakeup-source" for bridge@58 [Bjorn]
- Link to v6: https://lore.kernel.org/all/20250818-add-display-support-for-qcs615-platform-v6-0-62aad5138a78@oss.qualcomm.com

Changes in v6:
- Add qcom,dsi-phy-28nm.h header and update dispcc DSI clocks [Konrad]
- Change mdss_dsi0_phy reg size from 0x188 to 0x124 [Konrad]
- Remove assigned-clocks and assigned-clocks-rates from display-controller [Konrad]
- Remove gpio header [Krzysztof]
- Replace legacy `interrupt-parent` + `interrupts` with `interrupts-extended` for display-controller [Konrad]
- Update mdp_opp_table clk [Konrad]
- Link to v5: https://lore.kernel.org/r/20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com

Changes in v5:
- Drop patches 1–7, which have already been merged upstream
- Rename dp-connector to dp-dsi0-connector
- Rename dp_connector_out to dp_dsi0_connector_in
- Rename label from DP to DSI0 for dp-dsi0-connector
- Rename anx_7625 to bridge
- Rename anx_7625_in to dsi2dp_bridge_in
- Rename anx_7625_out to dsi2dp_bridge_out
- Rename ioexp to io_expander
- Replace legacy `interrupt-parent` + `interrupts` with `interrupts-extended` for bridge [Dmitry]
- Replace legacy `interrupt-parent` + `interrupts` with `interrupts-extended` for io_expander [Dmitry]
- Update interrupt type for bridge [Dmitry]
- Update interrupt type for io_expander [Dmitry]
- Link to v4: https://lore.kernel.org/all/20241210-add-display-support-for-qcs615-platform-v4-0-2d875a67602d@quicinc.com

Changes in v4:
- Add dp-connector node for anx_7625_out [Dmitry]
- Add missing qcom,sm6150-dsi-ctrl for dsi-controller-main.yaml [Krzysztof]
- Change VIG_SDM845_MASK to VIG_SDM845_MASK_SDMA for sm6150_sspp [Abhinav]
- Change DMA_SDM845_MASK to DMA_SDM845_MASK_SDMA for sm6150_sspp [Abhinav]
- Remove redundant annotation from sdm845_dsi_cfg [Dmitry]
- Remove redundant blocks from sm6150_intf [Dmitry]
- Update mdp_opp_table opp clk to correct value
- Link to v3: https://lore.kernel.org/r/20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com

Changes in v3:
- Add reg_bus_bw for sm6150_data [Dmitry]
- Remove patch for SX150X defconfig [Dmitry]
- Remove dsi0_hpd_cfg_pins from ioexp [Dmitry]
- Remove dsi0_cdet_cfg_pins from ioexpa [Dmitry]
- Remove tlmm node for ioexp_intr_active and ioAexp_reset_active [Dmitry]
- Remove qcs615_dsi_regulators and reuse sdm845_dsi_cfg [Dmitry, Konrad]
- Rename qcs615/QCS615 to sm6150/SM6150 for whole patch [Dmitry]
- Rename qcom,dsi-phy-14nm-615 to qcom,sm6150-dsi-phy-14nm [Dmitry]
- Rename qcom,qcs615-dsi-ctrl to qcom,sm6150-dsi-ctrl [Dmitry]
- Rename qcom,qcs615-dpu to qcom,sm6150-dpu [Dmitry]
- Rename qcom,qcs615-mdss to qcom,sm6150-mdss [Dmitry]
- Split drm dsi patch to dsi and dsi phy [Dmitry]
- Update yaml clocks node with ephemeral nodes and remove unsed include [Dmitry, Rob]
- Link to v2: https://lore.kernel.org/r/20241113-add-display-support-for-qcs615-platform-v2-0-2873eb6fb869@quicinc.com

Changes in v2:
- Add QCS615 DP controller comment in commit message [Dmitry]
- Add comments for dsi_dp_hpd_cfg_pins and dsi_dp_cdet_cfg_pins [Dmitry]
- Add missing port@1 for connector for anx7625 [Dmitry]
- Change 0 to QCOM_ICC_TAG_ALWAYS for mdss interconnects [Dmitry]
- Change 0 to GPIO_ACTIVE_HIGH for GPIO flags [Dmitry]
- Move anx_7625 to same node [Dmitry]
- Move status to last in mdss_dsi0 [Dmitry]
- Rename dsi0_hpd_cfg_pins to dsi_dp_hpd_cfg_pins in ioexp [Dmitry]
- Rename dsi0_cdet_cfg_pins to dsi_dp_cdet_cfg_pins in ioexp [Dmitry]
- Rename anx_7625_1 to dsi_anx_7625 in ioexp [Dmitry]
- Remove absent block in qcs615_lm [Dmitry]
- Remove merge_3d value in qcs615_pp [Dmitry]
- Remove redundant annotation in qcs615_sspp [Dmitry]
- Remove unsupported dsi clk from dsi0_opp_table [Dmitry]
- Remove dp_hpd_cfg_pins node from ioexp [Dmitry]
- Splite drm driver patches to mdss, dpu and dsi [Dmitry]
- Link to v1: https://lore.kernel.org/r/20241014-add_display_support_for_qcs615-v1-0-4efa191dbdd4@quicinc.com

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>

---
Li Liu (2):
      arm64: dts: qcom: Add display support for QCS615
      arm64: dts: qcom: Add display support for QCS615 RIDE board

 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi     | 182 ++++++++++++++++++++++++++++++-
 2 files changed, 330 insertions(+), 2 deletions(-)
---
base-commit: d0630b758e593506126e8eda6c3d56097d1847c5
change-id: 20250827-add-display-support-for-qcs615-platform-213111c51778

Best regards,
-- 
Fange Zhang <fange.zhang@oss.qualcomm.com>


