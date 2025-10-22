Return-Path: <linux-kernel+bounces-864264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DDBFA53E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B5D3A96C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C62F3618;
	Wed, 22 Oct 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1ELDRyR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3E2F2618
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115836; cv=none; b=AXaPWX4PZ787pFny4i6W2TByEjprGtZ4VgjGsWfJSPZJwte0Fa1AChES9spR23bW3iEdiYS9AYYtF2JSqo70Jk22F53HHfi7eGICyCGhcmk7IeGucGGq7hA/GW9VYWDpKeLMfk1R4DQ+VYngZ4UTZP6aTIB01wNjEqN+7DHYZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115836; c=relaxed/simple;
	bh=dHwbnnIKcEmXux6j+twsIaUTpCe2SsqCuU8ezT71GME=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PVcLjEAclMZiF1rVOQQhEeXzL2teM/Ka4JxnW48UTAAVBl9eDU3sRylqM3YCsyvxuJaLYhAY9oW4DV+opysbDto+rF8I7NGABoxqdoJVcJUF+3SruZKI2U4mBYbojZz8Drkvsco0kaZZNtJ7yV5OHRugZ46xq/g+FoeUihZhdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1ELDRyR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3TQmk026973
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TpWvVvMsWw/TXnHm2inwaH
	jVIdOxicoQL0Vl8v2SQis=; b=D1ELDRyRMGAJ+JBQZ9Dul0hWmoNjtIQDeIfDF2
	re9bY6S5FiISlRsmn06lP8QgEIsehNrtA6rMHac/DZIYF6sm5x2qtXqDNyzCHoEQ
	mBHRwDD+CJsHSFJji/FM0il+1bfxsW3lrI5LeHYuBxQqXetLrgIl5rd/6FxFr5IQ
	IZKR4v+cBm7PSY7Pa8t7bVVfgf5Dh7I0AJKzIQZuKjhbwVeupeuF0t8aq3yStqHz
	pQRacyPjdATe30qkdxweswV85vZOKeJziBFhdfTHzU/8zEX6sCFU+pNUXnniZKRX
	uaj93mkrExt744BA9Yli7QbYHzYXLCfZkQ0U8TOX1fy2n9Yw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pksst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b631ba3d31eso4128533a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115831; x=1761720631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpWvVvMsWw/TXnHm2inwaHjVIdOxicoQL0Vl8v2SQis=;
        b=EvhijobDehVPBa8gtDbXTw47/j0E/jvytS08xiuJfc18t28ABftpkdVV4QGI3KOODG
         OS1U0L1XM7e5oLJEsLp4DiPnMSz6J25MFSPRBq3g57x3pHtZX8/Kr3Hnq7UldBN+BxkD
         Y5SmvCBzs8esL/SrJTeGahO05fwNdtUUiHKc7gXYEwzFvddzzjrSmfczRrvMPQDRrJ2s
         Rc4wdFcoF0vo1DWQN4RC0dGq9tBphgbM0/d5RMTjH0mF5tQhLLVWL4m489T2b08EFmZ5
         KfOAr9GZmS3FY4VXCa8BOHzLIHCaKyPjQvWIkW4ecnUKAeHq5bUZVJv/FAvUnP/X3zNh
         Mxmg==
X-Forwarded-Encrypted: i=1; AJvYcCWtGDF9Riu7xVNNnO61WCWsujZhYQZNXiF03MJbk0OnzPbcrMYitWo6TgI/RJzmQTtSmw98EE8SMIUlQFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt4AeMGJkm0BxUjgByLCzKKkyUT8Db2pu3KV5k9FLy+y1PHpp
	cGhjk9+yZb3m3nGWplBTgggSQHwxtXx8AHNwzEnsko9NifTU8gVku7cMutWfM41JENvIzgPw46k
	t4K7kIPVzOS1RDTmpUUki+a5MzWjjdUUansT/khzqKTH1m+wpywGqFhP2wEkTaSiqn1U=
X-Gm-Gg: ASbGnct1OHPCHRjHP3tBMQDZkFoEylvDf9H2dYXbhmPQA/md6achJjLabfExcQu+mIl
	acFjwQttUL9hKt0sjJrYKQlxiWuvsjCUYDNpNaecXRK+qCZYntG2wmL2Vb0yY/wsNsicxzBPpBD
	xMejJ/eca+ZleYdTDQyrpxsHkvw2bFrmehX8EIYaJNwdhUKL2YmowsqeEEC1AyCiToNSLBocGj0
	klhO2ba2PvzdUl7qFebJ77gO3o0T5Nrce9sqn8m2iTEwbdn1igYqlSDBozBT7nL69KTnMzJCmzp
	1Qq5F00xUgcGX5rJbGCIf9Ubl0qHv8ablnEQIHSDpm+Wgf9N+hHg2zUAFhO8r8Yeyl0RcSpukku
	7/ofRcO2bUYUFACH3fLjFYDQFQqcXRgnt3M8l0ON4QoWE094hPQ==
X-Received: by 2002:a17:90b:2e46:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-33bcf953e72mr26873458a91.9.1761115830927;
        Tue, 21 Oct 2025 23:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCqxMzgEngcnVzPVoHm05YTCFCOmPRtrDaj8ggmV4o9Pc8i12sCZU1TJJyWgcLhxekgKAJrQ==
X-Received: by 2002:a17:90b:2e46:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-33bcf953e72mr26873421a91.9.1761115830493;
        Tue, 21 Oct 2025 23:50:30 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e334fsm1560285a91.8.2025.10.21.23.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:50:30 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v2 0/4] phy: qcom: Introduce USB support for Kaanapali
Date: Tue, 21 Oct 2025 23:50:26 -0700
Message-Id: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ++GgC/z2NQQ6CMBBFr0Jm7ZC2AQRX3sOwaMsgjdJiR4iGc
 HcLCzeTvOT9NyswRUcMl2yFSItjF3wCdcrADtrfCV2XGJRQpRRK4sNPOLPBWpKuO9NVZ1lBsqd
 IvfscpVub2GgmNFF7O+z7tFW7Njh+h/g9/i1yl4+0aFTxTy8SBRa16ZveWFsW1TUw569ZP20Yx
 zwdaLdt+wFOEruVvAAAAA==
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761115829; l=1391;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=dHwbnnIKcEmXux6j+twsIaUTpCe2SsqCuU8ezT71GME=;
 b=vgQFFSJm7L85vv9QLTjpskzDXbpxwOizvvDKDTXMdfoGpMol/v2rFFBR5Syqv6LNYy6aDq/Il
 N/8Z6XJJM35B8fghBeh8iC7CqzkQhwKOPPD8seG72VPfwW3GQ+d5We/
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX7qU9hDPuSgAP
 snE0s1fApDpF2MQy0YyjhIau+Eku8ed5zL/1tO5XmlMfTzmdB/U4JmkEwuapH4L5U/gpaNP2rGJ
 AK11JwhOy9jTWrw9lj5WnF4TSSDn28Jg52IxmqrZ+aCEYyJyRMjUMAck8iUZEuPOY3RlEeHT7Ji
 l4CguK2YYSkO4aoVsYJzdFeuD3CZJBGa4C0qN7mBynhHhA2niVvpZRgOcTcqHe41dJB6LDFyKsh
 J7NROEpdfbn9ngyrmuE6MGYn/OIc/LeaJf6Qk71nDkKFejw2ygcsTaWG3Wapq+E0FWx1uU7nN43
 uzX2waocjlxVz01Qq3EOD7Rk6w8gNVLHCbK9KWBMmrgBuz112sMxT35uU90QOqB1AlMo86YqR0/
 bbqU8G96NFqBTVXZG22YcHbfODWolQ==
X-Proofpoint-GUID: 4jjIxqPhwE_QvDEAeHv5Lmo7VZY1OpMS
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f87eb8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=751tZ-0Qz6C-U5i-0qsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 4jjIxqPhwE_QvDEAeHv5Lmo7VZY1OpMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add support for the PHYs and controllers used for USB on Kaanapali SoCs.

The usb function depends on:
https://lore.kernel.org/all/20250920032158.242725-1-wesley.cheng@oss.qualcomm.com/T/#mb2e1260cf266638a56c04bc793f5fe9ed1b3b79d - reviewed
patch 4 was picked from:
https://lore.kernel.org/linux-usb/20250527-sm8750_usb_master-v6-10-d58de3b41d34@oss.qualcomm.com/ - reviewed

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- fix author name typo
- Link to v1: https://lore.kernel.org/r/20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com

---
Melody Olvera (1):
      arm64: defconfig: Add M31 eUSB2 PHY config

Ronak Raheja (3):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Kaanapali QMP PHY
      dt-bindings: phy: qcom,m31-eusb2-phy: Document M31 eUSB2 PHY for Kaanapali
      dt-bindings: usb: qcom,snps-dwc3: Add Kaanapali compatible

 .../bindings/phy/qcom,m31-eusb2-phy.yaml           |  6 ++-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 54 ++++++++++++----------
 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    |  3 ++
 arch/arm64/configs/defconfig                       |  1 +
 4 files changed, 39 insertions(+), 25 deletions(-)
---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251021-knp-usb-81ea8dbd6716

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


