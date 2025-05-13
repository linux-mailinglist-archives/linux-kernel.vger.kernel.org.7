Return-Path: <linux-kernel+bounces-645736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61370AB52C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE967B43F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D9272E41;
	Tue, 13 May 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtivdIrq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558421FF43;
	Tue, 13 May 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132002; cv=none; b=KooGsPrE7iN2/Jntp7wr2IhTPCRw4XwFVyoFxTrzxX58etVX55aNciAZPP1on3MQCveC+Y4joPl+Kg9ksnPzWuHjqh6LyJkTBOfjp057tP9Rv17I9ELaSYXHfdb3Yk39wjxY956xjg5kt4GMTOUFJJXh2x/VEVacqhYLLZ6ODOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132002; c=relaxed/simple;
	bh=VBVyGDvcs+M7fz2JuXgpuMEiDtX0Uav/q7KJNW4QDUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lSJB3ELY2L+VVdgfxPxfqI7v3QNdocpx+Q2XUAIp/RPbYczZeO1zzu3xbe8PeQLFFsC8bRDvebITe7HrCN/tJnLGFh7fl68DEoa2RinqcFQYQOjiTk/Q0kbJ2ofWSVNDZFxc/jRxwYCurGgzx9WibBaknbnrNYgKW+K2RRrT1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtivdIrq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6238I008801;
	Tue, 13 May 2025 10:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=f8SdX1Q8rOczkBpgWrlsVsZ+98lTI64fJNQ
	SBzi6MgE=; b=VtivdIrqyw1Luu/+UCu5toNnYqSTw4InoFh+SG0rxu3ixy2B6ld
	2f/cFjU5+LbamfFgMOphn1zrUUbhhvbSUlZSBpNuCRW2bMvN0EUr+E0wiYg/aj5G
	CUBa2wEp+rgFa3k6HqB0QawsmtBiDW8cWKr0vs/RQ+70Z6nTVQcPiqUGiEFzXz/e
	xEZYaVm4SHbGYxlgggmUGYKLYNEaOKO/gBUbKKVtQJOATD8rj1cPZNp4GBh9xQDq
	QAF9L0wpbobauB3nS2mnEr6bQ8OnxDpv4zkwaLVBJFa4NKu+uCSpau8uzT3c/F0p
	zSl1yIYvDL/0Qs6yEqvRDToKxTFseRUwDtw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hyjjqa5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 10:26:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAQJF2032060;
	Tue, 13 May 2025 10:26:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 46hyvm6vx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 10:26:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54DAQJRq032038;
	Tue, 13 May 2025 10:26:19 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-amakhija-hyd.qualcomm.com [10.213.99.91])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 54DAQIWZ032033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 10:26:19 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4090850)
	id C52E456A; Tue, 13 May 2025 15:56:17 +0530 (+0530)
From: Ayushi Makhija <amakhija@qti.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ayushi Makhija <amakhija@qti.qualcomm.com>, robdclark@gmail.com,
        dmitry.baryshkov@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: [PATCH v7 0/2] Add DSI display support for SA8775P target
Date: Tue, 13 May 2025 15:56:09 +0530
Message-Id: <20250513102611.1456868-1-amakhija@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5OCBTYWx0ZWRfX5ecB3fSpsw3D
 kBBLAPxOgzlb3BjSdou8xaiHFI6BaJ0atfbCfnEVlH0TWbEO+SBXK5nvtySh3MJHmvq2UF0KEor
 DbsyIsBNgwvTyTa28/Qsh1gkQpEREXmSvnC+dNykZypP5HpQ5M4e5iPFPWaVVLnuc21cimjRg41
 NQZRrRfY4E4XQe6mNIBjws949Ddvv54aYsFeaA6xi2AAnNmGW6200/DC9IWTB69tyPrJ+8AuRgO
 HxhgZwVpBgeFulyMGmOiaPDt/yfc6S7owWeWKGI3TPkLXHWM3Mn1SDCdQCIo8hzdaXydlorxnTA
 j/Fj9FI0ldL7gpWeIi0kZzzFOm//2WX8L2Jj7eeHwAqZhwb9L1w6JTUQ7ROttZHQ0UWbMJ367t8
 uZPliV1238bWIS4DN9pYbttPN1L+QFUfW0NjlDcRKduLBhN8ZqlwvYr1E7DtwD2L7xQqMlcn
X-Proofpoint-GUID: O6Y0PCs36BQ-857hMehcEvzPEnlMoVWg
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=68231e4f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=QlWjpmH-yOSsLRRY6RUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: O6Y0PCs36BQ-857hMehcEvzPEnlMoVWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130098

This series enables the support for DSI to DP bridge ports
(labled as DSI0 and DSI1) of the Qualcomm's SA8775P Ride platform.

SA8775P SoC has DSI controller v2.5.1 and DSI PHY v4.2.
The Ride platform is having ANX7625 DSI to DP bridge chip from Analogix.

---
Changes in v7: Rebased and fixed the review comments from Dmitry
    - Below four patches of v6 are merged. Removed them from this version.
        - [08/11] drm/bridge: anx7625: enable HPD interrupts
        - [09/11] drm/bridge: anx7625: fix drm_bridge ops flags to
          support hot-plugging
        - [10/11] drm/bridge: anx7625: fix anx7625_sink_detect() to
          return correct hpd status
        - [11/11] drm/bridge: anx7625: change the gpiod_set_value API
    - Rebased the remaining two patches of the series. 
    - Added anx7625 bridge supplies as fixed reulators, according to the power grid. [Dmitry]
    - Link to v6 : https://lore.kernel.org/all/20250505094245.2660750-1-quic_amakhija@quicinc.com/

Changes in v6: Fixed the review comments from konard.
    - Added the reference voltage in patch 7 for vph-pwr. [Konard]
    - Patches from 1 to 5 of version 5 of the series are accepted.
      So removed from here.
    - Link to v5 : https://lore.kernel.org/all/20250424062431.2040692-1-quic_amakhija@quicinc.com/ 

Changes in v5: Fixed review comments from Dmitry
    - Added reset gpio for io_expander(tca9539) in patch 7. [Dmitry]
    - Updated the commit text of patch 10 for eDP configuration. [Dmitry]
    - Link to v4 : https://lore.kernel.org/all/20250417053909.1051416-1-amakhija@qti.qualcomm.com/

Changes in v4: Fixed review comments from Dmirty, Krzysztof and konard
    - Add only single compatible string in dsi ctrl pattern properties
      in patch 3. [Krzysztof/Dmitry]
    - Move the io_expander RESET and INTR pinctrls from i2c18 node to
      io_expander node in patch 7. [Dmitry]
    - Remove the gpio-hogs from io_expander node, as we are already
      configuring them under anx7625 bridge nodes. [Dmitry/Konard]
    - Updated the commit message based on hpd_enable() and
      hpd_disabled() recommendation in patch 8. [Dmitry]
    - Split the patch 9 of vesrion 3 into two separate patches. [Dmirty]
    - Updated the commit message and commit text in patch 9 and 
      patch 10.
    - Link to v3 : https://lore.kernel.org/all/20250404115539.1151201-1-quic_amakhija@quicinc.com/

Changes in v3: Fixed review comments from Dmitry and Krzysztof
    - Added qcom,sa8775p-dsi-ctrl compatible based on the set of clocks
      which are associated with it in patch 2. [Krzysztof]
    - Drop the blank line and add contains instead of items in pattern
      properties of dsi ctrl and phy in patch 3. [Krzysztof]
    - Updated the node name from anx7625@58 to bridge@58 for anx7625
      dsi-dp bridge in patch 7. [Dmitry/Krzysztof]
    - Updated endpoint label name for input output ports of analogix bridge chip in patch 7. 
    - Check the DP or eDP confiuration based on the aux node in patch 9. [Dmitry]
    - Link to v2 : https://lore.kernel.org/all/20250311122445.3597100-1-quic_amakhija@quicinc.com/

Changes in v2: Fixed review comments from Rob, konard, Dmitry and Krzysztof
    - Added additionalProperities in dsi and phy patternProperties in patch 3. [Rob's bot]
    - Updated example in qcom,sa8775p-mdss.yaml of patch 3:
        - Added port1 and port2 inside mdss0 ports.
        - Renamed dsi ports from mdss_dsi0_in to mdss0_dsi0_in and mdss_dsi1_in to mdss0_dsi1_in.
    - Updated the init load value for vdds supply of DSI PHY from
      150000uA to 48000uA as per chipset power grid in patch 4. [Dmitry]
    - Updated the init load value for vdda supply for DSI ctrl
      from 30100uA to 8300uA as per chipset power grid in patch 5.[Dmitry]
    - Rebase the series to use the header with DSI phy clock IDs to make code more
      readable in patch 6. [konard]
    - Added the interrupts-extended in patch 7. [konard]
    - Fixed the warning from DT checker against DT binding in patch 7. [Krzysztof]
    - Changed the connector node name from dsi0-connector to dp-dsi0-connector and dsi1-connector to dp-dsi1-connector
      respectively in patch 7. [Dmitry]
    - Added the vph_pwr for anx7625 vdda10, vdds18 and vdda33 supply to fix the warnings from DT checker in
      patch 7. [Rob's bot]
    - Addressed device tree comments in patch 7. [Konard]
    - Squash the DT patch 8 into DT patch 7. [Dmitry]
    - Added hpd_enable() and hpd_disable() bridge funcs in patch 9. [Dmitry]
    - Update hpd detection bridge op flags logic based on eDP connector in patch 10. [Dmitry]
    - Link to v1 : https://lore.kernel.org/linux-arm-msm/20250225121824.3869719-1-quic_amakhija@quicinc.com/

Ayushi Makhija (2):
  arm64: dts: qcom: sa8775p: add Display Serial Interface device nodes
  arm64: dts: qcom: sa8775p-ride: add anx7625 DSI to DP bridge nodes

 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 232 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 186 ++++++++++++++++-
 2 files changed, 417 insertions(+), 1 deletion(-)

-- 
2.34.1


