Return-Path: <linux-kernel+bounces-766184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2AB24371
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9FB164599
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E22DFA3E;
	Wed, 13 Aug 2025 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WWCU/c9p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3827E05E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071759; cv=none; b=u9AJpzEH4ueuYhl7xBaCvqvINtxzPzRHJ+LYyVfJvJqRTPoS4UVD2TZ1EHLU3KgxedY2JKKwbISWYEM9og60hgtswxV0wLwN1mmoL3A4pcQmQLsodf6hRZlsfQY4tZakE6Y3z2CP6fImHHcz/4zZxCMKzCuZLvEFlqdso8YFip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071759; c=relaxed/simple;
	bh=N/EFTl//MUVpepPSVYfso39VLXLEkNVBQ8GJWEUsU5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eRW8zQDB+Q4C9K+TvnXQ8FjEAyVlLTapeqxj0cEY1AdmTHNnKUPTKeKzS3GybaiX1RS2Aj9ChaHh7CtawApTZSFfGp2U2gxxrGEEwgmuy0GBcccVbJAoR6jXlyOEOCmytttwjNxqjIP5793Hu5o2FgvnLAvTyw0GUAJhXbGxEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWCU/c9p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mNKv008768
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PbxeIGNssb8EQVu2gX91Sa
	Cd/YhbWEN2gAOYLERC55E=; b=WWCU/c9pA94DPQT4oid+EvX0oHaVGN8N/YvZw5
	yN06bSa7E/pAw4xrLqm0kzDM8QH8Dbca4+egb1J3s3ZMrbNqKITeEvXq0xQbKQQx
	73eYmz+VNY86VhMkq+CrJreT4AlfROUUTOAM3uQx3a1xFlm2fZnvLDpTHl9Ki3BV
	ABGsxuHsWM8G97Ajc+pmMf7/pggACSUsqiQ2Y4bEOb1AU2+qlpLR/JFPGyvhUvbp
	gIJRukHGosjDEU8Om4I7dfcVtdlwG9w6r34ORRyZFmhfHv3O/N+aTLywj8lQQYuK
	BYVtiYG7TLNcTArRSzuNbc8UeuqsmI5ittEp//vLu1zRYBlQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4exq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:55:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bc511e226so6257091b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071755; x=1755676555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbxeIGNssb8EQVu2gX91SaCd/YhbWEN2gAOYLERC55E=;
        b=ofHhu3Q1ZiM0RTRNBDkmepn2Lav2HTy76O4tVtjMxkEm+eoIK/WRtm5QkgbB6ckS1Y
         6ihT045C01vhnXatbhIoW3bWYq2K/KJrdRLzJKKWJ1fmG9pHitVXnsB1c23axkbVX9fD
         xs4y+eazkrJx0bP9znMRDCt8SpONpUOZdOvkF4wUZdr11dvjKgjUcdu010oL8eOnSNbl
         D9vKnFEbGaElkvNX5y29PqlnkREPJFOCCCEmdTJz0EaLlDGJFZPxqgavKAx6KZ++mVNU
         OQlCxDFyCWhjR10zeWfQDWHoJgK6+sXZFoOTS3vRo0hLJgILsnDhH/iGOAi7JXk/V7Wv
         aBUw==
X-Forwarded-Encrypted: i=1; AJvYcCU2EdqjbGtJxRGrmgaRAfP9tZvCYHoVjcjyOGVFvRYuJtQxYtc4Qu7W8isLhSlKCuEsUsiz0cyJgsk1Ilw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gv3WItvhCHrIRpJyYoc0MVjE4ISXaYjFK3bdZtie/CXFX69/
	jhvVhZNzSnG4MecpBxp8KNRN+pycaAi6ecQn9bT6sIOpC9ZwW140tVmQuR1N0gYAO5AmlsBfTdS
	DbqQVqSYve2Rszy2JR9VuMMVf44heHIVaGsEPLVhI4XTZOBVhAFZT8/Owxdlo1rZud4Q=
X-Gm-Gg: ASbGncuNN3eQEXzlnSMWWAWPYpjyc1Tkvupr7ooA4SeVbxv3jLKVfUn+MpvRz9VWCKk
	wQ4tsbUb3uVyW4cWXnR60CkiUuOch4Ice9SlmqggzkSDTRkdbbR1jAoa2MIqDaGtWIFaF/7Ep0+
	bkd8ShOA1LWtp9aL+EjAdZf425jvkVpJLg6kCxbp0rOFGDS9N51gGyjHhikwP0cc6LQmY3Iv1U9
	HT88uf1vcSXmXNRj08f20n0840PyprJ4Ko0k7nyZLBwVS2qD6wzOTDCp8PrU5xJu7vy6497QuaR
	fJk2xIxBmZa38Aiy/Zz93lOKi/2E2XUMKG5y7HAApVyWU5xtB157Ct14kkNAIvQn
X-Received: by 2002:aa7:88d6:0:b0:76b:ffd1:7722 with SMTP id d2e1a72fcca58-76e20fe52ffmr3695000b3a.24.1755071755277;
        Wed, 13 Aug 2025 00:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFejr+/favLOO8iLHlOBozznAzz7xZoBuIk5htMdciv+yIGlKh80pmUms50GL2E13VJAOM9w==
X-Received: by 2002:aa7:88d6:0:b0:76b:ffd1:7722 with SMTP id d2e1a72fcca58-76e20fe52ffmr3694973b3a.24.1755071754778;
        Wed, 13 Aug 2025 00:55:54 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm31395754b3a.65.2025.08.13.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:55:54 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v4 0/7] Add support for Clock controllers for Glymur SoC
Date: Wed, 13 Aug 2025 13:25:16 +0530
Message-Id: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOREnGgC/x3MQQqDMBAAwK/Inl1Ig5LYrxQPIa7p0piUjYoi/
 r2hx7nMBYWEqcCzuUBo58I5VXRtA/7tUiDkqRq00r2yD40hnssm6GP2H/Q5rZJjJMG9w36w1sx
 KW2cmqMFXaObjn7/G+/4BxyDCIGwAAAA=
X-Change-ID: 20250812-glymur-clock-controller-v4-59887f028a7d
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: uTVpAJ9V9LfjXyLdBg1dpYwWK-bJLp_V
X-Proofpoint-ORIG-GUID: uTVpAJ9V9LfjXyLdBg1dpYwWK-bJLp_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX7W67wnFe2NiH
 nzzUQD/662u6h0S+dHHwKJMJCedlxLtZez8T46i7rIZ5p+JJJF1XIXKbj9qa88RqS09Pe0oZSUS
 9e9OKFZDB+LkckJBFLKlxGDXCXs0VEmSWDttTWZcyLLDR63niZW4VgcCplZPzRIHLAGgexWr3hP
 HeoGXS9M9xHYxL/ymChRcQMqOVVXNA8OwM8f4FjleytQVxOejDLL0Gtgxm1LO4g5+VEp0DQyVtz
 c90vf3RV3R0PdFSpM5o8yY9F+YVo5plt2MoFKcAKuKTfedT7aCwvMUnRAK7hdiyatKg2fZI89Bt
 i1gYgOyHZP8FAHCtVqySpjqnn8IvaI6NaM7jbhEcqk8NmFJUjLJQ8z16KLGKPOVvzs1zXSH2q6V
 HwP7SW4E
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c450c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9iZiYaJo2d43-za_6isA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

Introduce the support for Global clock controller(GCC), TCSR and the RPMH clock controller for

Qualcomm's next gen compute SoC - Glymur.

Device tree changes aren't part of this series and will be posted separately after the
official announcement of the Glymur SoC.

Changes in v4:
 - Update the commit message for all dt-bindings to incorporate "Glymur SoC".
 - Add the xo parent for the TCSR CC clocks[Abel]
 - Update the GCC driver to cleanup dfs_rcgs as part of 'qcom_cc_driver_data'[Dmitry]
 - Add RB tag from [Konrad]
 - Fix the broken previous patchset links.
 - Link to v3: https://lore.kernel.org/lkml/20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com/

Changes in v3:
- Update the commit message for all the dt-bindings [Krzysztof]
- Update the commit message as required.
- Link to v2: https://lore.kernel.org/all/20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com/

Changes in v2:
- Drop second/last, redundant "bindings" in TCSR and also align the
  filename [Krzysztof]
- Update the year to the copyright [Krzysztof]
- Align to the new Kconfig name CLK_GLYMUR_GCC/TCSR [Abel, Bjorn]
- Use qcom_cc_probe() for tcsrcc [Dmitry]
- Add RB tag from [Dmitry] to patch #5
- Link to v1: https://lore.kernel.org/lkml/20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com/

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (7):
      dt-bindings: clock: qcom-rpmhcc: Add support for Glymur SoCs
      dt-bindings: clock: qcom: Document the Glymur SoC TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for Glymur SoC
      clk: qcom: rpmh: Add support for Glymur rpmh clocks
      clk: qcom: clk-alpha-pll: Add support for Taycan EKO_T PLL
      dt-bindings: clock: qcom: document the Glymur Global Clock Controller
      clk: qcom: gcc: Add support for Global Clock Controller

 .../devicetree/bindings/clock/qcom,glymur-gcc.yaml |  122 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    3 +
 drivers/clk/qcom/Kconfig                           |   17 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    6 +
 drivers/clk/qcom/clk-rpmh.c                        |   22 +
 drivers/clk/qcom/gcc-glymur.c                      | 8616 ++++++++++++++++++++
 drivers/clk/qcom/tcsrcc-glymur.c                   |  313 +
 include/dt-bindings/clock/qcom,glymur-gcc.h        |  578 ++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       |   24 +
 11 files changed, 9704 insertions(+)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250812-glymur-clock-controller-v4-59887f028a7d

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


