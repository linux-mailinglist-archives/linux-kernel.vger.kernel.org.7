Return-Path: <linux-kernel+bounces-831379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE0B9C81C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2CE189FE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCF2C158B;
	Wed, 24 Sep 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pliUjvMV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7C29B8E5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755888; cv=none; b=BqZdAVsJSRNmsYWBmcuWZMzgm1W2z0SJ5c9uW+yjLeSqymr8dPhr4NybcX6/Pnnrn+x3oTbejfTP2+BHF1uMjsJnvbVyS5qyJvQsxSmgeSkWeXjwaxdH0+40LKxwoagnP2q51qxdLw1js8in5yO88UZx7IHXDWuksG1PVMrabh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755888; c=relaxed/simple;
	bh=P6AXEUovjelcMpdRLAsDPVjZOskIoYD55lWsBJZnkA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lWrHUyGhy+v2yTGAfJH3t9+YklTm6fHZvRbddEfo3OoXcDDHA75IrsLwsDYobmxtAzqfRhOpE6pnndhlepH3KfOKcZDQuEqNr4DbC5Ish0xwR2sWwxfNMRzWOaf+fwRBEIsE+b+dTkdIcR38xqyVxHhaSoyhA7sP8e/IlYeGdz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pliUjvMV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODMWEO023756
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kOzDHRFaT0midnTDgk3Xix
	Iv1b2jJlohJ2hcb2gOtjI=; b=pliUjvMVKkr+cc/LurJEFUiPp7rOUvGgeGwfmZ
	iTWl7xN8VOskQwEH/7sVWqEz/O/y45xT3zZzH1Bpgm5wFLZnwYc/rlwi5O7i218D
	vKHA89rbscJApiy/Sp+2OFpBuEycvJczGBzN93nEE8UrxHzqACNB+afMc/P5kmvF
	U8NjXvIcFRENrppC3iYeMvIfzwaYgozm10TrOJtoncNtZHpyWwyW2bhOwHhMi5pM
	FDq8I+hoc0cQ6dvWOa+XJ1UaHnANpu1WGVgf0RK2hkoe+dENUYZWRJ2kkxfLXmZ3
	HigFn69H3AvdCvHs5V8WGH8vV52V6cn9gOfuXFa4s5xGWrMA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d1p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b521995d498so218379a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755884; x=1759360684;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOzDHRFaT0midnTDgk3XixIv1b2jJlohJ2hcb2gOtjI=;
        b=pYzvKDR09ZDhmC0xwqHgg8HGKU7oOjVKcnO4rP7mCJYFeTCAMzTEdQmltLgx6S3SWW
         b9Xc4qdDQoOr+MHJwvB/8dh0/msRA+24p357hIhfhGs8oRFx9i53u6fvTsimaXdlvW+Z
         cvTpewwsD8/oHA2zboTCo+PB7owwTDpqxlbFpJcK+9ii50HZeQ/MKFH1uKZxs/LSd/tR
         ho52BZT3xA6OdcwUmmim2+YJAWvKLS+QeGX0DII9uWvuMbH9PGgzZSLDsFazD8XmnCWe
         k6bh72Lt+2XwhbtXzfE8qeH8esCj2YPTBcsskXkN+0gpxp71EK4ZnM1vIxiqxxK5YFAp
         s9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVf98OecOYvGG5Z4GlCspWF3L0i/YL5bSdNaPb/lxyWu2wr+BkuwpqZ7OYKaHOyWiOgoYgWKqxqGO210LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYGIXIvFtMvM2bFCpn3XvSuggzzzgE602yxIsRkj8GtPkRu9I
	3h/PUOR4rsL77sigakkVfVYa+MNnBVKgWWRq1mvsJHXBE+q5O8F7bP3B/GWGT4MYZsqMqJhmVYL
	tCjPOTHvDSPeHFiRDlo6b9pnqnCqOjqjKn/nKLbiFvK6//0n+rEF1P++B1dDY37YO3HQ=
X-Gm-Gg: ASbGncvpJAo8KpX3FGX2I/b0NXXIimClyziXY3xcPeVZUckBMrfDTBm5R5UvUe8OXc/
	xYtarqR9+PuQDXLBdw/nlNzNeMtCaoh9ZbnR7VHZSSpXDL2T2CbGoIj80BzkV6b+tY6wOEhNP0I
	hNqVqGc/Vc+T72VnvrWe1rAh/hUnzMcbxp6yX4c2aYN/WNdlJswW2qrg5TJf9YUUP3U16CffNG5
	V1fJm/WPAMvFOPCNsWs+4uNl2lu/p+vzlbA8Lg19ekmeWQQCpSf4hId+wIZgllprDEQvnW4SFk5
	aYAtk2JsjYTwiGAWoAdhuG0G2EsOc8i3cvF0y1lsDQgN9oB5ube9rFlCvjYWSUGAJAMFWgNJ5ZU
	QDlITe0winXm0lg0=
X-Received: by 2002:a17:902:e5cf:b0:24b:164d:4e61 with SMTP id d9443c01a7336-27ed49d0775mr13252855ad.13.1758755884148;
        Wed, 24 Sep 2025 16:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69RWSfsU8xQba5OXZo1Jgnzy7tY9QZgxSf523NT/+wl9+n2c15dD6eIcX76OrUzuJIJoeHg==
X-Received: by 2002:a17:902:e5cf:b0:24b:164d:4e61 with SMTP id d9443c01a7336-27ed49d0775mr13252585ad.13.1758755883648;
        Wed, 24 Sep 2025 16:18:03 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm4321385ad.25.2025.09.24.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:18:03 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add Qualcomm SM8850 socinfo
Date: Wed, 24 Sep 2025 16:17:45 -0700
Message-Id: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABl81GgC/x3M0QqDMAxA0V+RPC/QinN0vzL2ENt0BrFKIiKI/
 75ujwcu9wRjFTZ4Nico72KylAp/ayCOVD6Mkqqhde3dBf/AqaxoS5SEOfTZdxT6ziWo/aqc5fi
 /Xu/qgYxxUCpx/B1mso0VrusLZ4eoWHQAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755882; l=517;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=P6AXEUovjelcMpdRLAsDPVjZOskIoYD55lWsBJZnkA0=;
 b=IMtStwtT6lWe09AN9ji6KK8Q6jx3xg9YIdQU5ADGt0w/2nYTotYNyFKoV+qkS/cbuqeAQgqWV
 dMoiCY5oa1OBFU/8Alu8Asfnc6qzRfBkG8eU8wjesJ3W7xtUf3/W9Su
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47c2d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=18LhJySMsoz4s2Uj1UYA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tBRuA0g3EJpdDCdLvqH-0OFrJqnRpL8I
X-Proofpoint-ORIG-GUID: tBRuA0g3EJpdDCdLvqH-0OFrJqnRpL8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXw3NiAq5bydWL
 qhyiHYakISLMHCe9ZbPiAkIJvdDs/FmTGe/1rwMKaLnmZClCAwdUfBjUc7Ct6NKodNlnV9O6oVw
 ia/wC8jDB7nvP2zUBEu7MmrJ7cE/pXvfwSaY1CixYz8s9KVS1W/NdRGTyeUuJrkQkQt9vuytuwA
 ivggM3nZ0/gS2cz9P4GRt5owYzScN6r77xobaA5Pz5Jj5SZh8ZK10+4HJWozyTFdSWbeiR1wudO
 wt/Ky2guaD4uXrO0IHbzLYqJ+f5nyQOnbVRJ6SfD+ZqVMmklZ0N5c03zJ5v0qOf1UjUT61igVPS
 vabVzpJE5j2TRjAEXBAOFq+aRmafOhEwGUS7XDGzcEfRRFcCG4AxW6j8uxM3I7jGdk39eg5Zvez
 zLwfGLEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Add socinfo for Qualcomm SM8850 SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (2):
      dt-bindings: arm: qcom,ids: add SoC ID for SM8850
      soc: qcom: socinfo: add SM8850 SoC ID

 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-socid-f96f14a9640d

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


