Return-Path: <linux-kernel+bounces-771268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB3B284E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A47B37A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7282309DDF;
	Fri, 15 Aug 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFttS+lY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692A5464F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278667; cv=none; b=bhhxrGFPUFG9LuHD1gEbTnyNL1DDJkBatjJLi4UBPSDyxBVMrILDCJadBpHMwBOMTtGyvKriN77wShPBYdzB7Dl+prf+2zsCi7r8P5bqRvuIM6wmug38oxVqiFxV1RuXQliZDkJi/SFkFFNXeSrbxFF6RcgHAIHs7ZMCa8vvJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278667; c=relaxed/simple;
	bh=/LB1x4MuYCAm4u9ZYS/2Z2F9Vv22NA/IaCMMGFomePc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1gJTViIZsfwWu6LJmgEuyp1JLSBzKqm3957Z2fiedUoXFsOJkZxZ1jRM4sC1nexxxH6BVZXsemRar5yTo+ayN7cUagFW1AaoF250tJhJxaBrv5wBX7hqceVAR33BsRDUFBMzcZJrL6fAG/o6923jDWpRsOqKW3xBuFda+rsTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFttS+lY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJFZV022210
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3x6BuZcuYvtL28nrF1fEIU06Y2Cx3qSZPx1
	q+SLHa/I=; b=NFttS+lYGJ4HkhxFyLnAE9QA7jZYFyR7yQpMmE5ox3E+eJyMzkc
	JGm9yyHNHpzQKBFALNPvNrMKDGJEkc4Ho1rrHsd7P8VOTv+3ph5meiUHmK8pUuZc
	y9rrfGskjdJIp8bPEsvV43cs2nIpKvF/uulAm95Gjfy2/iNoaY/3+sho3UtLtFaC
	BLUAVvLe6G0MCT5p/804a6UOVKNq2witAroElcVUg/JfwXJt3XjhaJmzpidqEUVR
	QBmS6Jlgl5AmcVNUHAf1nwKnFcLSDkTpLxb3ieZpF+Bw4cgl1RIGegvISJRuDBhQ
	hMOBkvQBDFlr3P4+NXr/Eo+KOCrX7CPyxDw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmknkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so45908295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278663; x=1755883463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x6BuZcuYvtL28nrF1fEIU06Y2Cx3qSZPx1q+SLHa/I=;
        b=GDQ6H45kHyYqfGyyWxiz9koHq2751AFTuYoL8Z9pPFYb6/DhACyL9jTgYcLvJiNhc3
         8TsOQMLeNWlCBXCjy8n2x4LSqd/C/cNw7yTOv9WD06Fq+iRptTR9+JI6Hzw+ikNRmq9w
         R5jYyymRI27iEChUNuYoV86o9XNJ2l3oRA4Y6TCQaoQocWyCPckeCw/U3djcH9EY60Y4
         GCYvmRDeEt2JKkkoK8ssdmmt2XGC8bPpd8j/miFgkOzRUdaL0/4zvYQc6OmjvAbFmJqB
         nqK1IoMyIj4BKQ8ZsHUv2t75U2n5EMTHDZI+hWjZSDw5BesG4vjmX7tAkTbI0GFIGG6S
         nd3A==
X-Forwarded-Encrypted: i=1; AJvYcCUZLduSDgBez4X9IbTiTIGWg+YsHfN5cE+9RGuIiyEqN5f/ARAiQGgER9ho6YNKaJzCPkavJqqDjnzWjws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXYGTuZGmlZdBCdV7fvmjF4MdqLeAC6m8PRdyNf5VoaCO/8QP
	lZZggrnh9aPp9Qo1PDOLm5AydJ7SiwmjU9VUCf0Y+xsfLwlTV889xGxlYVPNTQXKf8M29ul/diV
	Xu89OUPcOXUjVamXTvrZHXOFub9vYt5khYv84GUmg2YYdOomiilOw/fYU9pAZMGrzdAw=
X-Gm-Gg: ASbGncs74LDQUwkZcVT44S8+9I/6QfMhm4cuSe5yJ+UMh3YXqin8LeIJ0aL2/9fO7SM
	HLbWHPgbzSomLp1RvwlaqpvCkmJ6biLiDFTJ1OFXWHSQxBZ3+nr+zp0okjGuXM/WaDxXHla25Qx
	gtWt8y3La19Tmu+02QXG1cMqFxbSE6pwmHecfy9eL5OsNcL4m8YHqt+Vn3s4aYvqPGTM0tp2YA6
	1YNSF2vV3r8JRk802an8p/Qr5MqxbMkfQCwE6+aPHZe33n91p4cFSZ4VrC2ZnBgXX5qR2ctojMJ
	sMeoKAN4+yMqSuYVByjaN6L5y5h1YckWTkeqBjxiiN4NS0LLfd7JzSY3zOtK/MMZyzT5hgKu48Z
	O
X-Received: by 2002:a17:902:d485:b0:242:c66f:9f75 with SMTP id d9443c01a7336-2446d9827b2mr40064975ad.55.1755278663138;
        Fri, 15 Aug 2025 10:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5M8anx90Lfv7XqfVtWP0jnq8FQcm1RoCJc/Do3JlKqE7ilXwZ5DRXQ5mWQJWHelWdjx8PWA==
X-Received: by 2002:a17:902:d485:b0:242:c66f:9f75 with SMTP id d9443c01a7336-2446d9827b2mr40064585ad.55.1755278662684;
        Fri, 15 Aug 2025 10:24:22 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadff5asm18404025ad.42.2025.08.15.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:24:22 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, kernel@oss.qualcomm.com
Subject: [PATCH v5 0/2] Handle shared reset GPIO for WSA883x speakers
Date: Fri, 15 Aug 2025 22:53:51 +0530
Message-Id: <20250815172353.2430981-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfXwZRggjCj50R8
 q0cD8UaJdsbu+aoojrhqo7LNNHV+oG/5TaLtGjODCdPH7MeHUU1Wh535Y9EK+WeneAlTEy3VQd+
 YQ8ZT1kDVTCmHT35YZapeMrC76GMBzpRPvVQUm23Xa2kxM3BBs8WJIDY841zT7ePtXRgw+l3QYh
 OsHUeoVbD0yuArTgugSI63lw6SirRC+BcKOgXpOuVyyox8UwVt1jw+i6VTyB7O/qLABgh74Bj5d
 rI2sK+VWUgnJsb7vrf2HVJQGh0pdbXitGR51sDVCWzezraVgbejEQTSAjgsemOnHx222AxNHnLH
 BEbCNPUGCMgxfS9zBlBu66gQ2/a+HyDfRXZDyKEl3zSXJIPs0gzqDgo4VxZ8j+J/zXLNi9pDmHK
 cWs1Crzl
X-Proofpoint-GUID: OMdxQ_dj3LIU6qUk4-adgUpWN2xVBekw
X-Proofpoint-ORIG-GUID: OMdxQ_dj3LIU6qUk4-adgUpWN2xVBekw
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689f6d48 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fihhyCgpykPbXYUG4mgA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
To handle such cases, use the reset controller framework along with the
"reset-gpio" driver.

Tested on:
	- QCS6490-RB3Gen2

changes in [v5]:
	- Removed multiple error logs and used proper shared reset API.
	- Link to V4: https://lore.kernel.org/linux-sound/20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com/

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
 2 files changed, 59 insertions(+), 9 deletions(-)


base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
-- 
2.34.1


