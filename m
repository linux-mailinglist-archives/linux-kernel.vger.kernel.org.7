Return-Path: <linux-kernel+bounces-784609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3CB33E64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A0D7A4D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5D26C399;
	Mon, 25 Aug 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJb0ntd1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EB26A0F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122734; cv=none; b=dOeZomiZPkUnujl3A2foQ7tK53v7VgwFVI/GZxw9Z4CoG8e2h+do8NKxgclOzxFNSHd4mqChnfll0o3hDf5gu9lRexR3ilh4KjlRkbC6qXsMvNudHf4Xq19dDKup+v7ic0Hft6v7zTJOr6f7CzzCMqiYEdfP9YIifeCsvY4Lm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122734; c=relaxed/simple;
	bh=dHzgTV5EgsoXBfE9yCqjfg3o/8E0k/K/0/cMTieZHrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RFuf/TATPsWNmGR1zvX72dt01VsNLzGv6ioS2XEHdWc+E79ud1s2uvXDzoU9OLN/i6syhhmdFy03AYaNnZwS+V+rCCyk2V2c3QYjtastkG24tUSQRJYCgNqVoAZSWrWoTQmV3B7JPqzFA4imd9+wAFJP/wU0TM4G4loElaAHanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJb0ntd1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8ZdlA018085
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/Y526DyN1p59PkdBwvGxDS
	FDOnzDRguJWKI/2yK0OeE=; b=NJb0ntd10hSm0hzqU8vfKNexLd+sbEWn2h22Hl
	618M03HMzt3Fe8qgPH+7v9VYUICjrt6bN8+BQQ5iT/E+Qg+VSxEAiIljpE8utIRR
	KFrIhaCeZQX7FSXVYznNdLLYNmi+Qtj1x0zgcJszUGL4qn8Qs2LphxC2pj+UGxm6
	fb4wK1e+wCRfiwoV4X9O1hxuO/ZYev1I/sUVAipnNZhuaoHLFwoV94lFievqxFq/
	Hd/2eCydsywwmXfmay5NCLmD8dXbmqGROFGE2cjBbesPytGPG3B2mBlMOFz8mf4E
	x41oXfFgKm7nqbKMdDH5G8lfySSZky1+a6gUulI9m/qj7xXg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unmvy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458264c5aso47415425ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122731; x=1756727531;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y526DyN1p59PkdBwvGxDSFDOnzDRguJWKI/2yK0OeE=;
        b=TIAYMufpJVfOs4C1oVKqkeH7ZkBGDLWllQt7myW+XT23dMyA3VS6ISOzDox4A0BrUB
         WwTOK+IdsNKeniHKY0UP/tznzw9YvLTySS3b1HOVXG0SAGYqXRZafHqXVEBN1NingEFv
         Z8EReMHqH+z5pZJ0SUjk2C7c9RhtDZERdKqx1W/bU8gls1g4Jr64YnRf3upxztS+mDl9
         N7MOrak0wE5uVsOO/B7MWd9KHHqHHjp0FwjSIaAWukXw7XG9Nu3dh4vxvTWvGvM13Klb
         Y7+TBXc4EAfuZLLpTvMQrmDYKsm6BTocIkeM9ZT8PB/YeQUBEgNprXuOX2pN50wg+clt
         m/xA==
X-Forwarded-Encrypted: i=1; AJvYcCV5fV/+6nLzExMrNR67q3/OmeOMT1q/R0UzSKLfLRn1o/Kp9b6vY+HZAj1ANxZFmVj+ZPKNA/RnnunYJUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8K5a4mn66hzYaM9C+pCL6KVKH3Baa2lc0TZ0sgqNdBlJNqfih
	0sofKZ1Yn3pa5g0sIKVaZtXxfVBPdQIOQgZ8/Z+KIH9VvtMXGD6a3+3eAl10NdUy4Vbqei9gOk3
	Jof8mJRSJU5f+yA46jAV4D57+gBvRBlXZhLeEme3aQbWWGv/L/TVpvimDlpLljAnv9QI=
X-Gm-Gg: ASbGncs2cTCDWqE8bFZLY+Hpd1ja5Y90DxCUlq4jmlAgpS8BU/3J+dGtzfEAYgeDWx7
	mRvBideGcVFFG9J5CwSJoFl0ee+Pv621dRb6TNfLn+5/EnIqP5rzQnwr0tBocRKvek3B6j8f0Su
	/XazwtCSkAOKRTLiibVWxfRlE3/ByMSCKchYIcQwvnB6cSy2z/M3vsLIxxPUQkhfZH5B5/CmbxT
	vJHgC9lPRrVzWdYFLVBTjqRITWPe5fBxHhIVMAVhv3RXwvbMyTWCQgYYzX+2dLxLNquSz6szmQH
	1nBcPjowUf+Iqf8ye/+JROe6MypWpJjEK8l5VUveNxlvh95f6GYG9OOkL6BECWSh2+8ohwsb+Ya
	2UdIgltawce7lgL+wiOWwmxYovfygP+by3vzGJG80cQOJmcMCdbiV6SyLYkw3Y4tb2ViWrmwjHr
	Y=
X-Received: by 2002:a17:903:4b03:b0:246:cfc4:9a27 with SMTP id d9443c01a7336-246cfc49fefmr37821405ad.13.1756122731129;
        Mon, 25 Aug 2025 04:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0nXT2JRvirqDOleS8kFaVnHFiCoQc5HWIvFsBFs6zeOhIu5PAQX22b01eAoG3tmxg7dDKAg==
X-Received: by 2002:a17:903:4b03:b0:246:cfc4:9a27 with SMTP id d9443c01a7336-246cfc49fefmr37821145ad.13.1756122730680;
        Mon, 25 Aug 2025 04:52:10 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/3] Fix the NULL pointer deference issue in QMP USB
 drivers
Date: Mon, 25 Aug 2025 17:22:01 +0530
Message-Id: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFOrGgC/x2MQQqAIBAAvyJ7biEFsfpKdChda6HMlCKI/p50H
 IaZBzIlpgydeCDRxZn3UEBWAuwyhpmQXWFQtdJ1ozQeW8Rwris6SuRxDxg39K5txlZaY/QEJY1
 F8f1v++F9PxDlQo5mAAAA
X-Change-ID: 20250825-qmp-null-deref-on-pm-fd98a91c775b
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=1268;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=dHzgTV5EgsoXBfE9yCqjfg3o/8E0k/K/0/cMTieZHrY=;
 b=bq8Y3fUJzfMQT1ir+8ZpNme7SH/5rFoC8X+nVHsTL4XrSAbtetJEoIRxutdNqbYkdSBxVKOo6
 cQ+0ejVApFeDS7bz+rcwSTU4RUbttRQyGQAJthKmpRVm91keB91ALka
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: x-U_WwiV51f1MfRRJrXTxeJapLyP3etO
X-Proofpoint-ORIG-GUID: x-U_WwiV51f1MfRRJrXTxeJapLyP3etO
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac4e6c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7tgEStx-2YtQAc9oN5kA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX8+1X9VijndcP
 9o4qCju2xGJhAvFG69Ner7MnVwmxJySsmsfcrUcZDFTbN0K3xPT/v83cEEXRfTcnUombLgKY7Jy
 VF2EyLU2imnTULrd/203aQznJSZreaKMMsA8zTtil//b2HDZzE7poEJoIpMF43mojZxv0XzFZjT
 gFpZkUHJo+Ud1wt0iKP5r6kGHwptYYUd/f4D/UVY86xqLFyz4e7V55RPOGThcSLIOJxYBMEDk68
 1yMBtDyHChf3E8DQwv8KmOUMj8kM5eVEGB1Dh7+Md0clwG3O+27GClP51bwrzjJ2aMTzZOeSe1d
 hSaaYXVIxSN0gaewsr8O6cx3asLj1RWLYB9sdPU2pue5SVW8D3g/M86e1e/rhz7O7nPqvzXZqlQ
 2qOQnK0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

In the suspend / resume callbacks, qmp->phy could be NULL because PHY is
created after the PM ops are enabled, which lead to the NULL pointer
deference.

Internally issue is reported on qcom-qmp-usb driver. Since the fix is
applicable to legacy and usbc drivers, incoporated the fixes for those
driver as well.

qcom-qmp-usb-legacy and qcom-qmp-usbc drivers are splitted out from
qcom-qmp-usb driver in v6.6 and v6.9 respectively. So splitted the
changes into 3, for ease of backporting.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Poovendhan Selvaraj (3):
      phy: qcom-qmp-usb: fix NULL pointer dereference in PM callbacks
      phy: qcom-qmp-usb-legacy: fix NULL pointer dereference in PM callbacks
      phy: qcom-qmp-usbc: fix NULL pointer dereference in PM callbacks

 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250825-qmp-null-deref-on-pm-fd98a91c775b

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


