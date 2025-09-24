Return-Path: <linux-kernel+bounces-831375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96441B9C7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE3F1780F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C02BE65E;
	Wed, 24 Sep 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJvZn3PX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FE288517
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755837; cv=none; b=DmMFVVKeECo7q8NhevFTAp4Yt3j4ZVyVXes7OVZW6MGMWXRJE8nLec85dD0xwIWywZBKmLDM+tCuFnNZ/PuLnlN1+Hqmy6G760JKcEvjdd6PWz5B2ymKtUBKwBf6evsf0FoaPGUC/doGL7fnwq2EYRYrZEmb4jrXHot/2Bnt4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755837; c=relaxed/simple;
	bh=bZ7vzZyfQX5UaLwavPV3mZ1y1L64kpa5LLrsI0ThiPU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeWKS8pquKBi34LuLklxN/EeoW29//3lz8lbeQ5QO2mHNYb8ooBQih8ZefZLNFAO8wzvqKnApqnl1pp41dezVmNZNByTO57a5ULt3BX0OwRE9jqPk18LC9XmwtJzJaH8Ps+3rJWuSPy8S28AdG8EqEO4DgPm/siJZRgKfNp6zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJvZn3PX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCiEDE024230
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cYa/YlwfkAw4Rr816M6vHs
	zMvOg2HLMgmr6PGy3HUyI=; b=VJvZn3PX7oMHbG5nTdbVOKPhmKCwVpwwgybP56
	s6ihRz9UDqHms9LVrQ5SoqlWjkdKkUmV9JUwN3K4Zai1tyxqxNSEnjtPhU8OHtha
	zUKvrV6Es8I56Ia3i/lHBBnnnm4lrtIEE4v26Z9wYniX2iHcZfwA/ghSZylpUHWU
	NjgZxV4CaKqPffLmVGgsU1L3/p+M86KoPLPlPKEO60nfG615TXUsedSh3w7Kjax8
	dJgI/PDBfHzpqA9cO+JL7Zxc2BpZcIxHbYwcQ/KU/1XMK8y9tNQgZeoLCddt5grp
	EjClTpvtSD7GE7Fwt9bF5X5CNg/93lW0wL5w2e/8zStdNTZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d1jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so5019445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755833; x=1759360633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYa/YlwfkAw4Rr816M6vHszMvOg2HLMgmr6PGy3HUyI=;
        b=uhVbyqZ27SvVMTbCDlGBy6h0R/r6OhbEMbZFdG8ycLxsqjqUMKQOpWaKYGrv/2+uPa
         bf7XkTvefMD4KRfdyxl14zpbUmaf0NCLb8aa3EG+OWO0OFNBL2PJ/fVeR2vgDYivgEv/
         vTNCAo2uItLk/rKi86DeehmEXSeetR5y56VhXIvYfkiXkI4kv5T3LvLz7skj0p2anx44
         5f71qoCXDdtCrU5AsdIUHh0Rioj1GsWC0r2MatR9lSYBthu4MV7SQKIAXt+lXHhYaat9
         PlBoux1yMfzkeTIOXUvTSFVNPsImvPakmdlPCI9wyZ5Q29L3f/7IOWdxS/pPR5g29+nR
         iAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6CW3eNBcNQ6QDmnovs8NrtY3tGxFZ1QEZ44hnNI9yjLCnyqk4+hz3LrHAXGYUfOmCPejtIKkTWMKqwNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74Hpd1pCgCdvT4i9WhuqBqnaNCe0DmccDwwBt+GVunCk+8vmJ
	Tz/86VcZVjSDMIZxXWuvHHkfbMCdUYGPQ7t0HAlLSg6ubAyLc8CKgsfr4NUlF5mwAxMqFuR09z5
	oYApnmn0gVV4A691u1uIFCY8b1ouJxuRgI+rm/tbjnTVwYU0KzrDKwETLcZ9qvWZnqD4=
X-Gm-Gg: ASbGncues2gMoR9y9TaZi6+HerY2/bSbR1ipeL7FZJ6hPHe0IUrXkNEnM0klyCwV9CM
	X4WskUHh4gCDn7DmgCnBhJ5lLD0M1OCSUFAcCexwjauyWRpSxRcTv7c3pDcZM6LwaKOtoXhAMpp
	pCd7t8TxZKa4wfMldDYAKNE7kCa1dMPV+nt7HTAUS9UdW7WcVdCexYPGuXiVfkJWneFKn0Vv/jo
	pgr2PLIEuVJ5wRLDGE7LXtL3wQHRIz0GJygrjSrLrcmYpRm2ataryjnww8cbH9Q2hURgyXar5xa
	rfLMJ59tVSLU8zJjjVPUbiCf/hxcY4XAFS8DPEopMZ+2Juv8+fc39Sal4CukNRHZOB88OZRQ0he
	jH1/4gCXjQ212DsU=
X-Received: by 2002:a17:903:78e:b0:269:9ae5:26af with SMTP id d9443c01a7336-27ed49d2c58mr9052705ad.13.1758755833494;
        Wed, 24 Sep 2025 16:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRkzT6M07G9l1gLomwbTaMNgnrfjjd3aHGRwNGyWdAz1cnH5Pua65v227ovxIpszjWLy8YkQ==
X-Received: by 2002:a17:903:78e:b0:269:9ae5:26af with SMTP id d9443c01a7336-27ed49d2c58mr9052555ad.13.1758755832995;
        Wed, 24 Sep 2025 16:17:12 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm3892125ad.108.2025.09.24.16.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:17:12 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/3] power: qcom,rpmpd: Add support for Kaanapali
Date: Wed, 24 Sep 2025 16:17:05 -0700
Message-Id: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPF71GgC/x3MQQqDMBCF4avIrB3QaFviVcRFTCZ1KMYwI6Ug3
 t3Y5Qf/ewcoCZPCUB0g9GXlLRW0dQV+celNyKEYTGMejTUGPyljDhifnW1tH8PL91DiLBT59z8
 ap+LZKeEsLvnlnq9OdxI4zwvzzlfRcQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755831; l=819;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=bZ7vzZyfQX5UaLwavPV3mZ1y1L64kpa5LLrsI0ThiPU=;
 b=bfdzGlAywR+6gVqy6RQiPTKGLFSjSfgL0KX0z9Lctgj3wlXQev4gxSq+0wcBd49uQbszgp+0K
 nD2JAyMCZL+AvFue+GYBn8KeJafTFqikUg7E9OiyoWopFccU4STBZ6S
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47bfa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hsnQhQ_IG91HmfWgDXAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: er3vuZn8vclbiW0J6FEx-z3ViEClxC18
X-Proofpoint-ORIG-GUID: er3vuZn8vclbiW0J6FEx-z3ViEClxC18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX7jRHYokyHi4L
 ne25WdcfgnMvtoElQuXoSsoXbfnGsY2fHaUukw05OAjjQK9wluR4gkVx/WJI1Xypty6Pnp7Ut9I
 CWhyEs7S57gNNmKP0l4nRw8kCbOa0BSduqOOnTkek9b/u8knIcfApfwi43CaRHGF5CtoDljF4zU
 NTQKVWgkJeLwmHkEbFwxXSx99VNfZdQatu1UVgm8LO5ENawk6TR3cXIFU19hReVq030UKrosZmW
 6LNyMyOP2KVhWsJgZySp4FJ/AgTdOEdhKQu4UPMHyDvFN+5DqG272qXcE3lXP9mhTO1P5d122kv
 wzMnlyZBe2IcESDLBS2hEVR9DLnbgGa4FZYiEHzvh2/vRZvueaXWV8RMotNBdKIu5Jq/4vKI2z/
 vld5UkbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Add rpmpd support for Kaannapali Platform including RPMh power domains
and new RPMh levels.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jishnu Prakash (3):
      dt-bindings: power: qcom,rpmpd: document the Kaanapali RPMh Power Domains
      dt-bindings: power: qcom,rpmpd: add new RPMH levels
      pmdomain: qcom: rpmhpd: Add RPMh power domain support for Kaanapali

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 28 +++++++++++++++++++++-
 include/dt-bindings/power/qcom,rpmhpd.h            |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-pd-f639194fd7c4

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


