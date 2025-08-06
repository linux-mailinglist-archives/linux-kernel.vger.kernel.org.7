Return-Path: <linux-kernel+bounces-758160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09916B1CBCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CCC18C43C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0A28DF0C;
	Wed,  6 Aug 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yz6GLYbS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3051E9905
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504334; cv=none; b=infLUUuUP1Qidfkmc/1WNyi/Ck+uioH1LyQGg/4/NYgIdyH5wqVSUsUyUPl8n7PRyzSrH7dMhPzh4MbgAZNZ0cyyDf0W21IRUOIhoWUqeWVEaMdazXQp6OmZ+LxkAXVRwNvptPJFSkhw0Re0SaP7r5R2O8Lnz064u6DXaGBBE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504334; c=relaxed/simple;
	bh=gltay6gHOTujsw+u6lXUTehNXIZtIgzLPCEbcmXqR7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cVRSr8AWEjsXyOkcAkeNWAxbprRelz5ntcWsh1vy5XK7L/2JnsxAiuQY3BNhu/94dNiEak9lfDQZCZH/rW46kFX4cNbrV4BmCy0EYP460Y2+F5I8b+NaVLDKjB4orE2cONJGG3xv1Pfpcn+4Xci5bjSCSVMGosuzzQkIHrZbXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yz6GLYbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576AMsqD017483
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 18:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7EtcQneqFbay0S3BezmpHKQD8tPt2h3nFwN
	SuVeutIs=; b=Yz6GLYbShmltUGe3PZGOUeYoPiUFeaJqCKQq0FVjMA2B1+yMoJZ
	feQ1pfYJoFA4UW+2pCea7u9H8DBx3NmE0rVchA6iRHXM7EEZjdNgdMSx8Fu/k/oq
	xxy+P/gYIiwtgi0XYGkqTEaPmsMQyQJTxDrs25zrg0OAD7yQnikWvGvlAQk5rJkY
	aJ8OEXrjp1PQavenczvXk4NUY+A3saRLqYFjDtvIjNYdzsRCAK7hfJfVBgfYz+o3
	9i4yC9x4W+uwiJOl5fqDy/QuG9sZyPvmfeYYrSSIuWX2pchNTvERwzVOUTBukZq0
	6Ex8NsxZf0PRp1m0umihCXPbWBX0mXxQ0Jg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c5869a2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:18:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-240607653f4so832455ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504330; x=1755109130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EtcQneqFbay0S3BezmpHKQD8tPt2h3nFwNSuVeutIs=;
        b=wD/EgW7POAVMPK+V4yBhCeL0kqLZ7FNP8Q0R+i7Esnapl6z43hu2tiZ/NZ4y2U6noS
         BnrCBQnaaMfPQts8Z7TLtngdKj2k+hd3D0Sm6w6UwkC8TW+H3+D7Kg+g8BRvbMTyxgW0
         hI2Tgg4uh5fi3X0OW/veJjpR4PrKjUrlpPXGdy/br/jxgyJgMsIrENsDNwmtvPzhhrU2
         /16u1IvaALsamibbfEXlWnJhliciauGerGtBeo6/n9Zsk63cYBJ/Sn/t8JrDakdbclQG
         qwy+WDKnvjOs0IRyTWHOnWkDBgTRunttWZsKEe+Zd/DGGc+gn9cmb3nx58qicn1thIx9
         uwRA==
X-Forwarded-Encrypted: i=1; AJvYcCVyXAfT2mzoFCxNhxpfzqka/PoSneXAOK8kMiaTmPfiAZqN9oYBHUzsPJX9CJJLx0p/bRqQpVzVAmM+pFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlpxUdZ2JPgMo268oRrdrMWgFktC3rO15kCgDHAX3n2BZGCtd
	RJQFR/FmJhNpyHZDyFe1TkBJ0AVYm2/Gx//tRwN6lSSo1gY3ZLD5oMX8aQmVzRiv2LbrTjHsJZe
	Fomb+qK4GmiQLsz82d/hE0Onmv3orqZGECNSZhq6SK92ofR+Xj5VV+pAD25cC9C6df0yxfMWI+z
	0=
X-Gm-Gg: ASbGncuN1xhzfekQznl91igbh1tGAZgoqZNDdctg35BiRMMa0+qylm0bIptrHJIUXP+
	avSC42l4v3Vmsfk+WGfSybG3VcLv6JuWvrfjll3e4E8q5dNNqakvYmkcIL17GiNKfLYAd5WHrea
	UE8D59R5htw3t8vTZi0MTTdsPIDecvCrirLLeh2CoWDo5i2hkMSZgp0sP3wsvWo3FU641/VDi+E
	DEysjvgaJZ0z0zV8iSuTpGfDf3c75V45eqHFcubs8G+wp8yoOE+y3onx01RcTH8J+y/rxEz96fx
	JyO9eDxqlR71QQPb8wV1a1Oq4C+S6fK7n+caCDj5vBpme6dAO0wEuJvSTbsYz5onSSHz9RK4idS
	9
X-Received: by 2002:a17:903:2f81:b0:234:ef42:5d65 with SMTP id d9443c01a7336-242a0bfe495mr48029005ad.52.1754504330348;
        Wed, 06 Aug 2025 11:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1Jjp74fSOAUZPkCo24NljY5UCf/PFKkDfQbKzSbRPxCaZMFEt+QxieBL3ATAUpTk1S+I4mg==
X-Received: by 2002:a17:903:2f81:b0:234:ef42:5d65 with SMTP id d9443c01a7336-242a0bfe495mr48028645ad.52.1754504329772;
        Wed, 06 Aug 2025 11:18:49 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm20235186a91.34.2025.08.06.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:18:49 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
Subject: [PATCH v4 0/2] Handle shared reset GPIO for WSA883x speakers
Date: Wed,  6 Aug 2025 23:48:16 +0530
Message-Id: <20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zwikw3aE5os4L1-ESssltShCwf2aiIta
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=68939c8c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PJR2aAOtTfpWL2UOpAQA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Zwikw3aE5os4L1-ESssltShCwf2aiIta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX5adqLo3Ye3lG
 L9iEjTM8QlK3BaEv4uk0gBHAiR/jbFTzXqYU0zSNn9+IS+LzNxNZ1KDTAlF9ksiUDUzhTv9ThWG
 tiN0Jzr81rUNHlCU/UcSORs9p1ins2g0rcj4V/5HeI/a/jIPeZHctHfP95QyxX+s50g/C7lxqGI
 O7jMMU50zOLxXiWAN5XiTssPIu2KY/0tQoMzuU9hLMSYrepiksMG46Lji1Q7vOB9QAf6+p0+t7U
 fzHCOIVtsmFXm5hM4XZcmm7/flfskp0YHruN+2SvApXr5nRgoikAcPdfTTQMPgTBSNmBySgKgMs
 e95br6Ylh32hl0tqUEsoCq+UXymzNlq/MeSpPrDsI39kxMkVt6rkQPlS0pTWxFh1w5Nx88WOcmE
 DVFTHt/I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
To handle such cases, use the reset controller framework along with the
"reset-gpio" driver.

Tested on:
	- QCS6490-RB3Gen2

changes in [v4]:
	- Dropped v3-0002 patch, which is not required.
	  Fixed with proper error handling for failure cases.
	- Link to V3: https://lore.kernel.org/linux-arm-msm/20250727083117.2415725-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v3]:
	- Created separate patch for devm action to safely disable
	  regulator.
	- cleanup the v2-0002 patch.
	- Link to V2: https://lore.kernel.org/linux-sound/20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Addressed the review comments from Krzysztof, Dmitry, Philipp.
	- Used devm_reset_control_get_optional_shared_deasserted() api.
	- created deasserts/asserts functions to handle reset gpios.
	- Register devm action to safely disable the regulator on device removal.
	- Link to V1: https://lore.kernel.org/linux-sound/20250620103012.360794-1-mohammad.rafi.shaik@oss.qualcomm.com/	

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
  ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers

 .../bindings/sound/qcom,wsa883x.yaml          | 11 +++-
 sound/soc/codecs/wsa883x.c                    | 57 ++++++++++++++++---
 2 files changed, 60 insertions(+), 8 deletions(-)


base-commit: b7d4e259682caccb51a25283655f2c8f02e32d23
-- 
2.34.1


