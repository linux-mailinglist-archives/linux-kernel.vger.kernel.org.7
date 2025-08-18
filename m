Return-Path: <linux-kernel+bounces-772852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B614B29887
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284D51B20033
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BF265CC0;
	Mon, 18 Aug 2025 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hjeiw8dq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F971262FE4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755491998; cv=none; b=FjuR/ulENardVWV9pltvwdlqrkCN9G9v6Qwcpj6qEQ6JuTjOLeLPIp0UbZRZslAFH3+5xSepde318Yr1JG3c1qKBC8h0S8YL4mIcPGVhc0c9TGh4kllxcO0cupq3bePue0r35Vj5lk+X2TKYG8yzd7UHOy++siw8VcwYMm62Ouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755491998; c=relaxed/simple;
	bh=KSLLj8Cg35yeXiOQ2rIw/G+j6qXlbNUMDJjZ9jdWyOE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hvN6nzuCuliOsTrgmhrc9txqOfAEbh6gHNf8l4SuzEmEr3Nj81fVzWzd8WAyBop6WU0F4PCXaFbZdOTMf5l4EghzYWiGfCATDmiGYLDlq602aurJ6sxKmIJMpBFzrQKZ9/ePtR+F77SchznkogeTjY5bqT7jNl0wvwW3hDimZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hjeiw8dq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HLPMQK001078
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1NR64GHFeask4qb8/xUkJ8
	EbUFcX0eF5pSEmHVElsFQ=; b=Hjeiw8dqZa0FvZQwmaaC35g2sbhv9opVUhjI2e
	xQ0vV+u1gv/C74OOIrA8HwnIC60kZpoCWFooXA++w+gH4/CHxqUD6kbSTYz6Tz7h
	LLq43uDDsCaroWUYJeMMaiu7XtObzSVjdoeAza5L5XVPWG/+j5iL1Y0ICSmsHl2b
	JdThMstTYZ+IZPTQ28hJITIMmBKs4vQRefDp7jRm5jpaWBMfBBdNRaB4LauSj3sc
	tdyhNoB29iCB5t+deHnojp+xIxwmXmK4J/5IjRyb63/E0EDukYVm7VH+DdAwZg7c
	uToOaUup/OC2RgsM5JSgsq5KWqbpMTKB8l1k6s9twRMkX0Kw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7u7t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:39:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2445803f0cfso37740135ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755491993; x=1756096793;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NR64GHFeask4qb8/xUkJ8EbUFcX0eF5pSEmHVElsFQ=;
        b=BPDJBmfm4qKJAklckVXLR10X0YaSDfqVDHoXR/k4/Iv7ofRHoYKHc4MOI8exWtXVtQ
         PS5+NYEu9Fj46hpgEfpsdekFD3tn28WwpfvMq3LFTsXVdZqrLtbMtFitbksdATzsmxu1
         +tCUUl3/UaGaX244Jf1oeQcO+9C8rxwM89Kw0e5kLArmxhDyUW4Z3MbEe2IEW8nVIa7+
         05DKcz3XPMVHaoqBD7wkL6Y6+Tf9M87QtLjHRRsU35FJN+QC4NTij6z9u9/MPzyRZTmd
         zq9nBB+FXAKtmzkuSjuTPElDtrbdTq5cH5AAoyZiI0kpXwgjJIxOfS+bqM4AksF7YqlJ
         WxTg==
X-Forwarded-Encrypted: i=1; AJvYcCWRoHJTs08S1FmwYwLcyoGd+uPha7NjkB0zVItmzxPl/5E9b1gQ0OsKCQN1mQbCa1g0LbH2PrcEEwRLzAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRBhgDpETS1UgEwMgBVoXFG+LB0a1sR0xdY7VsixAj7oWldeC
	xER9ER1NLZQqQ3wOHWXPM0NLVIjfl29g0MFZVbyj8c2lMcjUNhx/PnBVz6/MRc42/KkkFGJWR01
	Zh67AZpwuyagyHQF0XsBcx5+BE4WFY6FIxKgI94WJ/jUQ5TygJdJ21+JTkSTlN/mF8KA=
X-Gm-Gg: ASbGncs11BfxkXSSUZNiStYJXRUk854GTksMQkH3zrgCq6KgaYcBUrE5jk6iBaj89NQ
	LYPzrbkDkRvVGckQVHFtpQs8G670zcBVQJOq8FkmJD+w1aPGZnD7RJMgTHh/8hxDuQ40b9Ubuxp
	CPubyT8jZZvUOzpIy2/+rfg4y7LdgxeHAsgLu1P7prQyD+XjwZmxdhoEz3xoMREAz62e1GrvgO9
	u2YC5Y2OHUdVZ081V1xqZ+iBSMNRr4PnrJPmqkReLsClaT/kI2iX9t/qs37gG8LHDYrZtWaccAg
	qEB9TIyJ/KWKxwO31cd71Dta4gfnGZaqTv1gAWIcKcusWcW3BNrsroVTqO+f3TueIeLU1UraTq7
	K+1xJsC0gRrb72yrJLqbFowOdaqbPQMW3PDOwwkOlUFWIbNpQO4nSNa2l
X-Received: by 2002:a17:903:41d2:b0:240:4d19:8797 with SMTP id d9443c01a7336-2446d75becdmr173584895ad.22.1755491992993;
        Sun, 17 Aug 2025 21:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6rIbGtm3cTNiMPouKeyhqMRXZb1S/1TN9Ws1mkPz3xtO2PINyibUiytPLz3RdpGICT6Go9g==
X-Received: by 2002:a17:903:41d2:b0:240:4d19:8797 with SMTP id d9443c01a7336-2446d75becdmr173584665ad.22.1755491992595;
        Sun, 17 Aug 2025 21:39:52 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9cffdsm67505765ad.5.2025.08.17.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:39:52 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Subject: [PATCH v6 0/2] Add display support for QCS615 platform
Date: Mon, 18 Aug 2025 12:39:19 +0800
Message-Id: <20250818-add-display-support-for-qcs615-platform-v6-0-62aad5138a78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHiuomgC/5XRwW7DIAyA4VepOA8JGwx0rzJVEQlkRdqaFDK0q
 sq7jzSZumN2tA/fb8Gd5ZBiyOz1cGcplJjjcKmDfjmw7uwu74FHX2eGAklYsNx5z33M44e78fw
 1jkOaeD8kfu2yBuJ1P9Xxk1Mr0CnsiMixqo0p9PH7UXo71fkc8zSk2yNcYNkuDQUC1NJotkazN
 ZqKNlujABdchd7BEXzrvWILWPCJAMjdhxasGlojQ6v71urjqsk/GuJ+TVZNEhIG6Qj6sGrqqSG
 I/ZpabvPWkNNGC/SrRr8aCfOPLylUNUvmaKwN9fGIneZ5/gHiCq+DAwIAAA==
X-Change-ID: 20250818-add-display-support-for-qcs615-platform-5b02a42c555a
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Liu <quic_lliu6@quicinc.com>,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755491988; l=4970;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=KSLLj8Cg35yeXiOQ2rIw/G+j6qXlbNUMDJjZ9jdWyOE=;
 b=apX3K8Hq30/LjAiJzwF4nwd40nWbeRYJeeyIp+MlYZuxEcpwhq8xxf9nfOJINyRiXSBAvtxLp
 aUVO5f7z0BuDBbIcnedKRLcOxe+USvW43thtIuuw4uhykjV+gGAQUVq
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX2UUxhvBBUxqs
 D6+gST4KGhQDLQJatoGJssGVykYnCy93zIGbyS1q8Y876tEpDqzl2/sY0IjKPaGrQJsRtNuCjOH
 5fGpBoVQTTD9qnmJBVxdmmPPjeF25lA2Dv5Ru0xbidikGeV34uprHcorr/E2C5jxlhOsGZr5p5L
 33UdYl7ct8l0i/2d2tniD0mx3qRGbun3LYxpNcrE/7/vHHN9O0YyEbzk80Yco+jL79InBCYlGn+
 dQAKOqmsgNWSYBj6Thj/KJuu7EQjDyxVm2MMqgwD+1gtmsE7jQN2Xux8pg71haDlefOTEKSbekF
 ioGtUIkCiuTmG1WT/hf/zTQivr0ygojI2hqGMS+3aG20EjX2omE7OlrNKP248EqhF5fxi5lPypr
 DWl5nDv/
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2ae9a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=nxEaKfvGoP9ROcwm2F4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BhXuNCiO-wpvUeBMb9a1fhoSKOqf8wbO
X-Proofpoint-ORIG-GUID: BhXuNCiO-wpvUeBMb9a1fhoSKOqf8wbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

1.Add MDSS & DPU support for QCS615
2.Add DSI support for QCS615

QCS615 platform supports DisplayPort, and this feature will be added in a future patch
Dropped patches 1–7, which have already been merged upstream

The dependency has already been reviewed
- dispcc dts
https://lore.kernel.org/all/20250814-qcs615-mm-cpu-dt-v6-v6-0-a06f69928ab5@oss.qualcomm.com/

Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
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

 arch/arm64/boot/dts/qcom/qcs615-ride.dts |  90 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi     | 182 ++++++++++++++++++++++++++++++-
 2 files changed, 270 insertions(+), 2 deletions(-)
---
base-commit: 7ef84751db83e45a12d69cba309f2af0ac9150c3
change-id: 20250818-add-display-support-for-qcs615-platform-5b02a42c555a

Best regards,
-- 
Fange Zhang <fange.zhang@oss.qualcomm.com>


