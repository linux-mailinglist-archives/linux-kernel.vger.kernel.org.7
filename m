Return-Path: <linux-kernel+bounces-868087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D51DC04538
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DBBA4F6162
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF45276049;
	Fri, 24 Oct 2025 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6Qu7Oev"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3F2652B0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761279876; cv=none; b=Ju73+e8aKqqF8Mtl2KOdrIviX44jeN6qdjrzU3QT9xKNqmHtCsjsqTTXla4duWAE3Z9r+ms8mq2B0CD0tlznHL5qxUhbOApdgFojmGzusmaSierdmwWdOnMRhqULD9qiCKOID3EexGpFrFzIhQ3mxSHiNhBUdsH42BvINcvvs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761279876; c=relaxed/simple;
	bh=tGAnsxVqZ1qFVesJkjyC9fOf0J+rr570DONtErHUzuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sboEpEIdxz+7lFmA0s9ASEorOwtnmopDn1gmQu9rK+O/lYfmXXcvpwNm+BjAF7L07+aZ4URtY16brXpUWgBV15YF64MIBxDb9Iams2NNx1WoOaKx5ZwI2/HM0D00omNoelPzT9KIc11VZ7mo2RB5Q2dT9lAgfless9IIgKmBJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6Qu7Oev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FMcQ016014
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kz1Ixhzrfamiim6k99Hz3J
	JL+7qgj8J0kxsqetjMV1A=; b=O6Qu7OevskHW2JkdvLynQZdMVSR4goEvJQiqsU
	6yN2OXgCcdaPHp6Xxs+JMIdiKtYZY+OudUgWaDxuCG8iV3BaCeQqTydEDrnMR+ea
	FU0pTK0NkyiFeQG8Nd7eX66kVZmv8SI5xP5Daz6yi8TMKlAbkx9oyHk0z3RD8oli
	LlW8m6IT8+TpOAoxYBQkiFjK0/YaIMFwgov8U6oZDiFT/ghAYo+Hj05HAxKmnbAY
	DhKxtP8IKv9ZMq+wLAKw10QpUNakpEGJ04uKfJvM4xQsdPQVIp8gDJCKIrtNK6ij
	ztFzF6jAC5k7nxao2K3Bnh8c8j9DRJFcbpm2C7oInTeh6KYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsgbwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290c9724deeso14788855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761279873; x=1761884673;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz1Ixhzrfamiim6k99Hz3JJL+7qgj8J0kxsqetjMV1A=;
        b=vKE9pDLucyQjfscrOJHYbdqMO5Z4QIiG9zye/hX1Qr2VxDDfsfuqzE1255NZJgSWVG
         kGp3qFoJ/ttTthrPHCt9T9gMDBchPZ+qrKB2akdh/DZyPz8HY0/V+kRo7r5RbF072FV7
         DRfJOHVG0rvGYd74z2DlriWtN5Qpo4jWBsX+ie4juqvOVl0/366kN7l9KCOUHMElVn4p
         jWN3Z5S4TOZHv1yrZFlhH4NsBSOmH10NuP+/WBQ5+bjfhY7zDirVxEM8l4zN3DGW0vW4
         Q7zt1uUcNQdwhm++IMy/txjdA1P5UjX7qd8jvyINrJ7IzOQPvfpV77OswadqucPmKifE
         5eTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmV3GIRJ+CzCMgCvuqRQ/Oo7LTQxLfQ9P+UTjkd9klrWGRTylDWuDBTPwvApPLb1sCgW6VmSMr/GDjr1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwnxsZjaOzmiVPAqrBEOoOjz6XyE4w52Y/HbMwdLB5hDDemqL
	/tsoGOeMVhfbPJ83OqNMgfmEIqy6MTEjMJMIdpXuwzrwIkDZhj3FOfP3iJx7N8gSYNzISPh4LFU
	SdItUqSIW/radQer7x6slY1RbSO4yrCmZ0Gia0JwMCt82rG+Xvu/Ovmo50l0oE1Xio19KRPKCu1
	Y=
X-Gm-Gg: ASbGncsk/V74I/qaI2Z+zBiCcuCGKLvrXh7EhDYBuGwI3eiQFllrEAr6B7gR2f8ndyY
	JQGODSZL7AQUi55wnaUT5WsPN94VBNtKHYaSUpC7JSQmEwIFwCzBR6jn+/Z6qRbEIors1qZzUDB
	6SBkpJxzjPwehUc/kVRpkX54UR8N63sVyaTaVielRI1BdytNGdYCzADzivKhomzJquiUOwFZOti
	kNJ2j6eNo13hsmjTYgmidr4bib1QsOTvnBQIrXQw4sY10OseAzUpl+6KHkipAB3uhLFqfxkMhq6
	EQmsey1FDmGS00nDwAea3pYEtCCKkNak9Jgdki2ziqYyX3cLzRRa6VzndAhvfWVAr+f4kO15Eae
	mvpS47MTwR1AadAWSqbt8z4I=
X-Received: by 2002:a17:903:2b06:b0:272:f9c3:31fb with SMTP id d9443c01a7336-290cba4dbb5mr344374375ad.58.1761279873241;
        Thu, 23 Oct 2025 21:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw6FT4ACDLV4j5sAg4XbeH0ScrROVimqV0RjPACCbizARSrEerK8lT2E4YB5UHI9gIweZj7A==
X-Received: by 2002:a17:903:2b06:b0:272:f9c3:31fb with SMTP id d9443c01a7336-290cba4dbb5mr344374085ad.58.1761279872753;
        Thu, 23 Oct 2025 21:24:32 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd0576sm40259805ad.67.2025.10.23.21.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 21:24:32 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v3 0/4] Add the support for SM8750 Video clock controller
Date: Fri, 24 Oct 2025 09:54:21 +0530
Message-Id: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX/+mgC/32NXQ6CMBCEr0L22ZL+UAGfvIfhoZZFNhGKXW00h
 LtbOYDJZJJvkplZgTESMpyKFSImYgpzBnMowI9uvqGgPjNoqa1sdCt4amorRaIeg/ciaXE0Sl2
 NqYbatZB7S8SB3vvmpcs8Ej9D/OwXSf/Sf2tZUlRW1c4aKbFS58BcPl7u7sM0ldmg27btC5eLV
 Zm5AAAA
X-Change-ID: 20250829-sm8750-videocc-v2-6311b334f7a9
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX19e5RW2ng8jH
 w7atmnSdfrsGhEUDkbf+AOA+n3QHglm7sJH6MlS39BX8+5BTQQhxvOmGhG10jsRFTobrG4ManGP
 sVxQA8szS2aLgko7Sy1+q/Xe1PKU4XtG8BQFGDBJ+mN+1MLb8Z/0Cx5sZFl9NZjyDeL1JvTcuTo
 odNf/hhBsEJD4liq2MbOsi3W1A2cuSVBhHdH160JCJkBgIUl+VEN4u7ZfpJhrSe5oN8vWjYmZox
 VNIEbTabBfwEOue5Om1COVeTrsSmJOBJ7yotdS0k7esxI1T2vZ0sRv1mOFUDGYW7lwpnippzs6O
 eVMM4BIPKmCl1caAFcCVRxf47MS1+rHKLvZBC9GxDQglPlGgRbYz3JxXpIDThqcVWvd5ESlpPqH
 JpXvXjM9smWwgw1m2tGFzDsW+D8vMw==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68faff82 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=1P1wqcGgztCMLUttUvsA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VEycJb4apAALWPxNU-z_0VAYKT1FcH4s
X-Proofpoint-ORIG-GUID: VEycJb4apAALWPxNU-z_0VAYKT1FcH4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

Support the Video clock controller for SM8750 Qualcomm SoC. It includes
the extended logic for branch clocks with mem_ops which requires the
inverted logic.

Changes in v3:
  - simplify the logic for handling branch mem ops for non-invert
    and invert logic [Dmitry]
  - Due to the changes in the branch mem ops the ECPRICC which also
    requires branch mem ops are updated to align to the new code.
  - Update to use new _desc infra and use 'regmap_update_bits' to align for
    better readability [Konrad]
  - Link to v2: https://lore.kernel.org/r/20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com

Changes in v2:
 - Update the commit message for the invert branch mem ops [Dmitry]
 - Update the email to 'oss' and also update copyright.
 - update the RB-by tag from Rob.
 - Link to v1: https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (4):
      clk: qcom: branch: Extend invert logic for branch2 mem clocks
      clk: qcom: ecpricc-qdu100: Add mem_enable_mask to the clock memory branch
      dt-bindings: clock: qcom: Add SM8750 video clock controller
      clk: qcom: videocc-sm8750: Add video clock controller driver for SM8750

 .../bindings/clock/qcom,sm8450-videocc.yaml        |   5 +-
 drivers/clk/qcom/Kconfig                           |  11 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-branch.c                      |  10 +-
 drivers/clk/qcom/clk-branch.h                      |   4 +
 drivers/clk/qcom/ecpricc-qdu1000.c                 |  30 ++
 drivers/clk/qcom/videocc-sm8750.c                  | 463 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8750-videocc.h    |  40 ++
 8 files changed, 559 insertions(+), 5 deletions(-)
---
base-commit: 3cace99d63192a7250461b058279a42d91075d0c
change-id: 20250829-sm8750-videocc-v2-6311b334f7a9

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


