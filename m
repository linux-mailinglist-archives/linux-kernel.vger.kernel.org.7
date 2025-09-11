Return-Path: <linux-kernel+bounces-811436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 121BAB52913
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299C57BD368
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D912698A2;
	Thu, 11 Sep 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cRCHhpB5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4625D202
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572596; cv=none; b=eRSGPecNFdZefizwx3Pmh+sXUZA3aeE1bHX4v7JxTfPvfgLJChblYR8aEkt3+riQWtyb8aBX2P97bHS2X+yFUPsESdbo5RcStdwBYrS1ZZhmAkznG+uDcmaf9g25RiF0MLjFuh2irC3/AjEjP2jZxH+F3RJrFaFwb71p1y7HX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572596; c=relaxed/simple;
	bh=3WQparlDQcdEdl7ZPJ262lJlWoZyN0BU1wz+mBY/Ok8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MP52nFvyICMLfu/MO/7e//FHTYPMve3/LwwTyVfPLZx6ox7cF8cN/iyRhiaID1ccLFJ1Vz3lJfc1/bNWJ2aUjV2mjAfPZbMl9Wzcmr6QWOaJuWUfCsacQnKkoe2oMJkSf9RI9h6PyKiWoHNWPObDQibmsuK+qQpCm88mhchu50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cRCHhpB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2Iuk2002518
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BUtZ+xnLuqe8A3qnoyRxyt10mylwZS9Sqaj
	PHtwNVZ8=; b=cRCHhpB5SIDHyO9d9RSv+z7iEbmbDlG1v89/gR8mgF1qIworOuh
	i4fGKTonTkTcQKj6sDqxV+sHlGsNBEuYSq7BK2eXQ+DhXNYlaOIhQN+6BrbOh+c7
	G3gXWwLW6l6+/bms2Ojy1CYx4NRX/Xt/XJocK/FJf4Bf/02mMzH3wHr5IY8KymTD
	HCnSTecTKlDdVUCm4/5f99c0mBTHH6QrAy3BrXux5eS/ujNsTJUv3zC6s2HoMG+x
	sudlQVjcQ5hgm+jCZsb7nQrYQ6HBGGinRhMwwjfChoJMtgANLcJB5DqrlnjxQluG
	I6IDCFWwEqu0oKc31DhrHgwmunc89LNyldg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8pjg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c8264a137so4532175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572592; x=1758177392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUtZ+xnLuqe8A3qnoyRxyt10mylwZS9SqajPHtwNVZ8=;
        b=PeVraTQtj7K6n0RCc7DF3I0yLeDEml4j7vxCit9SJ3vcB2/AhCkRF7MNTUAaEVHelI
         IzIhVRaA2uojmzB8mAC049cUEUHzDUKI2LzC9KkRFW4JPfU3bPSupxk5fuer/AWTJwXZ
         aNCaqaaBdSdaikbPcSb+iv01q6hpN0y3tquGgWFPxaz/eB7n52NPme+Bp4O9OfNMEIFO
         5A+EDfI8xFTYkdzbr4E8y2DLw9Z8mKu2pQUD7BMmszKaVtsz2wINunWFKwpolpmVYdB8
         9i3ssxQuoU4tnBHs2dCPZTGujPgrIMjvUpdXsBjayTYryNd+tcwfvBZi7XvZxbnqqWBN
         Ofhg==
X-Forwarded-Encrypted: i=1; AJvYcCW4I3gzTkpKCOVNfEOtzdHMv8wI6d2IZDsEvCUlPynjHCzt8zfCNu7YEQ/B+/s0Qq3CzesFMIf01N7UVto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf5YqvaVu2uHy53NLlhklPXqYPfkZmoUHUoHzyxrxO9H5VqRt
	Hyi0h9IUOCcdTpZVOH3ZY7jn8hP0kR8ZsX2v4hcYbF5FJVQZWP4clpgw6Z9d4NV8UiLa8LvCqTE
	xrE4Bv9XDAgeDUOZsMlibO51E7YNvd5CKRHCWVaj93hNH/xDU/hUUvHZlFFJzX1Pp2SU=
X-Gm-Gg: ASbGncv/ho/333Qc7e7GqfoYw8Y2KUtMiZ/wrK4WZ8xzYJjOIuyMPQiWgPGAMbb8Xec
	4G8hNBqwjfQabTVUayv1nNBva4XTPMwItCy3TzT38bv5x0TKI925ga5VK61UKptTGv6MIafQVJJ
	OBI/cn07866juTiTDcdPF0pYzi1A3m161eX3urKoWJPuj4tte6YZ8gi5Q/aGeB0TuFMaifWBsUV
	SVeFZl8UPHm9QhrHygbpknrWaAP28Z0nVLwFd8ECAByR3NZXp5XVqtjg/iz8qVQ3PrWQ+xjX6BG
	wjpU2cxaJIrketdPDlLrTx26E4qTXaFQz7alv1CjIv2gyQzpxqED1/bYf8/qHcBP11Gmm3a8Bef
	/
X-Received: by 2002:a17:903:2446:b0:25c:19b4:7ae3 with SMTP id d9443c01a7336-25c19b48233mr14261525ad.24.1757572592285;
        Wed, 10 Sep 2025 23:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYwp5uptw/HYP+W3XfteKDOqQGwpH9u9pH0E7b1QdcfjmApuxH+jbDqCz/Mj/ZSR2U7+AbDA==
X-Received: by 2002:a17:903:2446:b0:25c:19b4:7ae3 with SMTP id d9443c01a7336-25c19b48233mr14261115ad.24.1757572591461;
        Wed, 10 Sep 2025 23:36:31 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:31 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
Subject: [RESEND PATCH v4 0/3] Fix lpaif_type and DAI configuration for I2S interface
Date: Thu, 11 Sep 2025 12:06:09 +0530
Message-Id: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXytDA2cg+AXP4
 26oU/WJe5UZbhuL7oVuazkVG7g8Mv9zeNxdqBWBzrdqH1Jn66WoLvdQKr/P0l3taqdZvKIQSJMe
 iXdg9/bEv+JCk57eSvTK0D2S/Y73VslBYU42LibW2O2sRbaUii8GVArtLOecRK6HjtSnwXjCquH
 0TxsTDGtRbWPcxHvYHPlQr616WJMWBiLeglhaMf0eY4uoVjFjClLZYbMiF8HudaG4D7PY6k+kT2
 lTFSR2+gSRlP5p5gdKb+wnivK9Qk41ZiGuV2y5uxaj75wX8v8L6Ml18BpeJlKDmYfsXVeViusBb
 abxtdd8RMIs1EcpAm89BmmGOWFd9BnSrRWn0t/3qntpMmWY0IQJJW9LBEAuG094wvcd9ZSO2JpQ
 9ieiqp6f
X-Proofpoint-ORIG-GUID: fqOPRoAWnkVKJ_MYz0Th5HvZyHQ-7fGO
X-Proofpoint-GUID: fqOPRoAWnkVKJ_MYz0Th5HvZyHQ-7fGO
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c26df1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Add support
for configuring the DAI format on MI2S interfaces to allow setting
the appropriate bit clock and frame clock polarity, ensuring correct
audio data transmissionover MI2S.

changes in [v4]:
	- Updated commit message in patch v4-0003, suggested by Srinivas Kandagatla.
	- Link to V3: https://lore.kernel.org/linux-sound/20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v3]:
	- Added Cc: <stable@vger.kernel.org>, suggested by Srinivas Kandagatla.
	- Added QUINARY MI2S case in patch 3, suggested by Konrad.
	- Link to V2: https://lore.kernel.org/lkml/20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.
	- Link to V1: https://lore.kernel.org/lkml/20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com/

Mohammad Rafi Shaik (3):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
  ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S
    interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 4 ++++
 3 files changed, 6 insertions(+)

-- 
2.34.1


