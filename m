Return-Path: <linux-kernel+bounces-831478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D83B9CC76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F122E26B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEBC84A35;
	Thu, 25 Sep 2025 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHjGhZkr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339498F6F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758580; cv=none; b=rhcYzc/WT6UrdPagsd42tZBavEaPF8KEGfT6gtw7W2InRU5hSKcZZSV1Mg8QmAxWWi7lZjqHIiJVwxGhTukbKxvom0hZIUR0llg4n14iNzPa6Tto/yqBdjp2oBDeHuStcwyIpwD5XZJUf58Y+eg6ROYhVSz1fp85u9bjaai+2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758580; c=relaxed/simple;
	bh=WBOdnGCqtO8/DJkdBoR28EHJL+lRE3iOJ/Mmmvw684U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XDt6nvtTabID6KJYqf8QQyU0eJQa8wevuZxH1KOVVpeQWybyDXWD8KsyacyEYez5uPgfSeNXJTZOZsVuaS1i3O9WOb8k4GW6u2h/LrfwyusrYVOk4lCiauGBkCoRFwuzCQ4M+3Wu3G0uZ/fdjwR4yLQ+XqlzfGFqtGqrHXwrVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHjGhZkr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCgSDX027848
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FVDJLdbn7C6FBvhh2FmnyA
	hinN5l1LuKxaCC0VoE73I=; b=NHjGhZkrpyzFeyJAR43y0NKgVD/KJ8vyVnwa+C
	GVVC7JOBE1gTnYtrsY8t9Qgw8hGXUAFue2bJ36crMqBgt25ccZakEA35hNSftrPe
	LS5VBLPPOaFolDjcfLrlKDbbIKohOI64g3hMRtO9Duypgr4aMv87mMiCV5zrw5rd
	HYKygtEErPrg0GwWDZAfHXK59OY3Yybx8GL2sb9tgqyBbkzEM22fYzB87LcjY6NC
	i9nJkSgNVkrxeinZyCjUFk6jUvOpY9RPSp+myPdiNQ8ARwYOwbutlm2TU2yR2OEY
	sQfsFr56fsWvVjSwajYMTbA1QLj4Fj2ARd9ee6YR3oWklweg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxfam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eca7298d9so7106455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758577; x=1759363377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVDJLdbn7C6FBvhh2FmnyAhinN5l1LuKxaCC0VoE73I=;
        b=ApmNjftW5z7M71yUVkdVW8MVBxhuJBXUTXOiiuS9+t2HHBDKV3PYZlS5MYEikMrTH0
         BIYyYaCfdemifAMPA1Xf7tQW3jQmCmR5Qmatw2ocPcxH4mMZ9Nsoo5T2Le6+cwB/46+x
         J6dVEFg8sE5zAV/KdgN+KiG7nKFwFVOSZhynHVKiOGbwmdPUE6ckQTLhj9BQ2curBN+h
         aWe89dZogK0YJ1r+jqQgSwSNFt3PUtYkl/zJWFWOjResEzC367I9iCPAV2jhqEDQutD/
         MYgy58cCH0TwHtjsM4bJJLLNDBEzVhFGUA6ggdJaWae2tWmc0cXMjfaxRKbwBirwxw3m
         r9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWiF/Kdbi2qYCeY9rgcQVAB96heqU1cy7QtcDMXUf3lNCQ/BYcrBWiZ8KsaM44VsPaPUgrus3ziOwVWKcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2jFWsT4iqMBorm5kTvkwpnxK4PhayPQVDKi48nB+ZmnsvAt/
	IMevDW+rhn9xsIjdoCpuY5qgET7YGeb9GcnGp0+MH/gutk1BCu5rUmzkfY81TfTZjDmoSeyhDLF
	Be0eYDy3HF1iLbX6vEa6bPZZyWNDJtXYpRHM6NpfCIo1QGQ6WTBo87zphgXjbBH4SSNw=
X-Gm-Gg: ASbGncsBI/O9ClGrFWoUzkOKvec1JgCgmjGU4NnPjKK+85gwdrMT3Q6VapJG7daYrzj
	SvDV9cIjUyrxXXM/OFbQD/SQjVBb1Nb5qY51GsFL0mA6xyOK3c4YVompzNxqPLldR5tmWLN25Ww
	1hFY/R/hvd5q8GCK1hRwkxAs4fxUWX3vwKjR6kgU1SiNT2eYe0Mdhx60mOkEvUg0gBLfGRRhf66
	wTwh01FBj3tttPaJfheDg+Ri5fL0xx1yLuTZoKMbS42tI+mGcOk/vRQsZMhOM4mjfXOCG9uo9PT
	oygt/uwCg5AF4WALGlBFmSxYf0FjCFZMSQxnIlvhSoP8IwqC484fYn4GO3JBdZQdkyKnxy6R1JX
	42un06u5G27g6ru8=
X-Received: by 2002:a17:902:e88d:b0:263:b8f:77dd with SMTP id d9443c01a7336-27ed4a5ec57mr16017015ad.57.1758758576431;
        Wed, 24 Sep 2025 17:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDia2gmtmkvCVOrNQm+dLiZu+nms2zkdbZoHc/NFzjpKjXRmJZ2zf89NbxCNarVMVoCxn2Qg==
X-Received: by 2002:a17:902:e88d:b0:263:b8f:77dd with SMTP id d9443c01a7336-27ed4a5ec57mr16016615ad.57.1758758576011;
        Wed, 24 Sep 2025 17:02:56 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm4807215ad.52.2025.09.24.17.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:02:55 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/6] media: qcom: camss: Add Kaanapali support
Date: Wed, 24 Sep 2025 17:02:47 -0700
Message-Id: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeG1GgC/x3MQQqDQAyF4atI1g2MsS7sVYqLOBNrKE4lKSKId
 3d0+cH/3g4upuLwqnYwWdX1lwvqRwVx4vwR1FQMFKgNHRF+84KRZ0xNktDKs6NmhFIvJqNu99O
 7Lx7YBQfjHKdrP7P/xeA4ToMmEEFyAAAA
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758574; l=1899;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=WBOdnGCqtO8/DJkdBoR28EHJL+lRE3iOJ/Mmmvw684U=;
 b=r4eDTZd32hxHigyWyEa52AxJeKsEUWCWng3+hmyr9O8xR4vdHrn/0zAUu9fBaojanEFuQxsky
 Q071JVU2c8nDO1WcSYps9UiWc+7pL/dwA4h5x+vNynWx19+elT4mvly
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d486b1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=BuH3vWvutgcbvWnSHJkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: BXNmG2y_pQf3euGBO_C22vp3nv6xuk_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX4jl57N54qdHt
 6gFKNWjWvWoCOmU15mbCnBs7HKa0knv5YaILDqo4ojbHaOLpDeUqHmo48PHyZPPfGBGzWPQVHur
 ftySj986WVEjRX/9WGxhfZScPpm+q/NwmDPG+2v80VBcihbZzfcYLDG5JyZEZjHDYi2+k0kGilt
 MxJpilx8CXKe+tznh1RcIpp0SbJaj0KS0yfCalR5dPDnJcAANtEpQCdhQ+1sjIyKgEo6eVhX84X
 7xqBUxg0BCpz0sNDQOvtVkYdpsqmwqiv/4OV6aApLcioIqa3pdCGEeSD3Ry1UYAh+cFkbFjfDKR
 5Eb376B47nIctqH1e+/EGMCn/GIjBTF0OhhrHC7xPMAkdXKSXjsP1khTuioJFuCwjzwqyrjuhk9
 HZZ+pbpO
X-Proofpoint-GUID: BXNmG2y_pQf3euGBO_C22vp3nv6xuk_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Add support for the RDI only CAMSS camera driver on Kaanapali. Enabling
RDI path involves adding the support for a set of CSIPHY, CSID and TFE
modules, with each TFE having multiple RDI ports.

Kaanapali camera sub system provides

- 3 x VFE, 5 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE Lite
- 3 x CSID
- 2 x CSID Lite
- 6 x CSI PHY

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Hangxiang Ma (6):
      dt-bindings: i2c: qcom-cci: Document Kaanapali compatible
      dt-bindings: media: camss: Add qcom,kaanapali-camss binding
      media: qcom: camss: Add Kaanapali compatible camss driver
      media: qcom: camss: csiphy: Add support for v2.4.0 two-phase CSIPHY
      media: qcom: camss: csid: Add support for CSID 1080
      media: qcom: camss: vfe: Add support for VFE 1080

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |  17 +
 .../bindings/media/qcom,kaanapali-camss.yaml       | 494 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-1080.c    | 379 ++++++++++++++++
 .../media/platform/qcom/camss/camss-csid-1080.h    |  25 ++
 drivers/media/platform/qcom/camss/camss-csid.h     |   9 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 138 +++++-
 drivers/media/platform/qcom/camss/camss-csiphy.h   |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-1080.c | 156 +++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |  15 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 347 +++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   2 +
 13 files changed, 1575 insertions(+), 11 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-cam-d3de05e4923f

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


