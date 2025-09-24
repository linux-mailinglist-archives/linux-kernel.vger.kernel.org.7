Return-Path: <linux-kernel+bounces-831405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6FB9C930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521304A5270
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154F286418;
	Wed, 24 Sep 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gspdbcs1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3E7262D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756657; cv=none; b=j+ec7A1lNG29CQWn3+53BWHP/xJFoNhkOSfFjqkvPOcIKXKo3usTyhv570KoyIrsQzXtHxz2kbZLpAnewwDL92xctUAZVQtbMFeSOM2n1sIuswS2k9LVSl8b8yoT4cbN0xZ6c66dgpYe8s+Jo8oi1ihKn63nzgVVuVNIxhSWjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756657; c=relaxed/simple;
	bh=kh6kEegUFtYNFJ3aS49j3X17Llncmc/V0qRsyGJYmE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=okfhp22KTAkWX4vyx25NTuX2LBby4Y0N/PiLgvkmS1i4HpWe9GEor7fMznzopb1yYaSaK0Ql2mn8/KFfr2IxityCMQ5oFW6cGl/Sj54WfWi8G/9/V9FNLFZ9P2NnrPHRtP/JR/5gIRXN0gC034h7ZIbnHrC/uM0y8qogdzsZzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gspdbcs1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCGQuZ016438
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8sKUB96w2c81cjypF1uciP
	4GhDssTJHhQe+aJF7cAs8=; b=Gspdbcs1r1rYDi3xUHRulFhyRD1qKP3U9exg+q
	bgQjWUa4Y2JQ5+YFsW0woYjzVH8T7i7sYHKhooEouMIak3VFDWQIxzsKH27lMn75
	2yvH6qB3tk7hyAEsUZxP49n2bJ0wc3Q9a6J1nPArLk8JL0RubRkREoGKuPjwZaoF
	vCOzGMLOlvgDAjFK3l/Vz6epC6/nV1rdyIb+Nx1bAS+RI2vRoHJ15BpOpleS+GTX
	HIa/qngngrIkQgYrp7T5vmTAOx5jVYNk9D7/VzGgEaE93GH+eW7RS+0sBH6dVB4Z
	4EOWdSWEQMcJNaX3ngTyGWRsAU/oQbgkyro/U/APSwyFRE4A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhusm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so3174345ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756654; x=1759361454;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sKUB96w2c81cjypF1uciP4GhDssTJHhQe+aJF7cAs8=;
        b=mQ1dqvQkYw7HdeGoyNygfBxkF4mciiR8Cx0dYb4Pf72eF4BhvF44m5AaUHg2YnP8y0
         7BhiCkJpWU3omSoxIpWZ9KjM76rb4vSqeKcs9d6ouUPb0AxVRbJ+mrX+uDidTLePLM5x
         ZIFf0ge/LruI9p6kAUlZl8m+NnaYYZiUylJnUE+cJ3HFEta12pQpPOpVejbdkgdLqm9F
         LoRJRzMUC4AykNr2GZQmFcjbikuIKPIs//JezQr+1fzmxSAG/QyKzEFcY0UtEDGfAKpr
         Qpo12ZdC3JK4rHYv383d65p/bgp2dq8fKBS9RlbJPZx5kjkmD4+XTvFq8qfFsI24YZxp
         iGQA==
X-Forwarded-Encrypted: i=1; AJvYcCXfmQHVGuS68TRb6GeCbOthYJGE3ystTrA9q4lxS36CC498KpqKvtcOZxY2a3Xz9Md92Vrf7S/bn82QDJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4QYC9PufKvz54yw2G/MOdBL2MbzYgKD+o04xYLfE/35Qm3DU
	P2IXIhPbSML2wuPVS84QdyDCvMVaYusp8+J6TLpjexwaKnpC149L028THAg96wxniu2RxSaFq+K
	05WL1Vq2v4evIaatLPaerCf8vBxNX6HT8pa5NldDudaGZymggh5FKARztgokPdyPKkpsoSEJd1r
	aeiA==
X-Gm-Gg: ASbGncsoQhD0iihZdX3SC9dsxC0z1/meWX7o4JzA8YAlSJph9iyf8rd3DqImVgf7dCC
	kz33s2Z+lULHZkfGpBCm2zImOycwEI8d646+dDShA2EMfOLPLqYeY4nUHmNZ2DsnboL9EQ8EWdg
	t1HotghYstctyTDZe777VEoM4lwntpBzE/6qnz4LyXuuP2uDFxtNRbiQA7ePPKYaGZzn1F15q6B
	YSoMdDW/LZpXUQH3Yy3uv9XhXbi7rA/neuHMnaD0CunqTRXt5/4fYQUtsZLdjuBMSQ7eIKS3Ewu
	A6aDK3eeVRzdmgRRGzAfnOYZIZLXTlSm3H7WNStiQHm6/XmML7vg6W5wOmNtiZs5f1ShvYuKim6
	SzLe+th4s2evpEhg=
X-Received: by 2002:a17:902:dacd:b0:272:f27d:33c7 with SMTP id d9443c01a7336-27ed45e7b1cmr15474415ad.0.1758756654082;
        Wed, 24 Sep 2025 16:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLOFJEMfmqYE2I0X8NTp04g+0odPKBsvb/FFRbpVvIIynbyA0XvTKOEx2K0bAYTptvE+S6+w==
X-Received: by 2002:a17:902:dacd:b0:272:f27d:33c7 with SMTP id d9443c01a7336-27ed45e7b1cmr15474085ad.0.1758756653599;
        Wed, 24 Sep 2025 16:30:53 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882284sm4122655ad.69.2025.09.24.16.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:30:53 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add rpmh regulator support for Kaanapali
Date: Wed, 24 Sep 2025 16:30:46 -0700
Message-Id: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZ/1GgC/y2NWw6DIBQFt2L4LglCfOBWGj8ucFHSiu0FmybGv
 ZfWfk4yZ87OElLAxIZqZ4SvkMIaC9SXitkZ4oQ8uMJMCtkIXff8Fh+ccNrukFfinWosIoLyvmd
 l8yD04f3rXcfCBhJyQxDt/K0skDLSXyR8buUvn/ap2nVZQh4qQOmkEOW0a53stUIL3svGGeU69
 LrWAqwwLRuP4wPKBphrxAAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756652; l=785;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=kh6kEegUFtYNFJ3aS49j3X17Llncmc/V0qRsyGJYmE0=;
 b=g+HdfxOzxLd28NuS5/JD5a/2uLK5z/TbbKyjoC1yO+7g4q2xqdbXGv3h+Q/Z7NAjWEossF052
 2hGsh7fx77kCuY/wMGRdlWwii69l2h4QJSe158ndFATxVAqpIukQJin
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47f2f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2c85Y0ljqCixjCLaVhIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: phe4Cl80v0k28JzspZKmvkRlPSmUI_Ps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXzKntls/Krtz+
 MmTSYbXlbthg68zOpbL8D5Bnbw+bkoU4IsLWRjQfHf9qs7j/s4I62kRLCGKEHCbWlbTTnzrUqoR
 FJxkKbdSba5pB8XimSMyhQ4Q/gkbYO9EJgH5W2KTlmgnw+KHVVet6haZyw9Nvnm0GFWP/hdJ7nG
 GAmgVfknqohkg780b8XEk4TH3/UeQDx2Yh1e83Rb0EY8wTKYbcW7JEF7Pbi+6vg5Zm6d3Ay3cft
 +4nra88JtlK5nxIpTHC+XPHy1H77xGkN750QOS0SjGBF9vqOhRiaJcedrzIp+R5IiGdYwsFGpWt
 KFF7cCRE9ihrzPNOHETRGOEU4LPMGUvY2XG4Smsa4xh/eymh5yz79mzcTRpE33DpYyHwihmCvta
 hLHYG5i8
X-Proofpoint-ORIG-GUID: phe4Cl80v0k28JzspZKmvkRlPSmUI_Ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Add rpmh regulator support for Kaanapali by adding PMR735D PMIC.

dependency:
https://lore.kernel.org/all/20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com/#t

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jishnu Prakash (2):
      regulator: dt-bindings: qcom,rpmh: Add support for PMR735D
      regulator: rpmh-regulator: Add RPMH regulator support for PMR735D

 .../bindings/regulator/qcom,rpmh-regulator.yaml           | 14 ++++++++++++++
 drivers/regulator/qcom-rpmh-regulator.c                   | 15 +++++++++++++++
 2 files changed, 29 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-knp-regulator-735ceeea3ff8

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


