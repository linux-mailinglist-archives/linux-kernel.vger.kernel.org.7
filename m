Return-Path: <linux-kernel+bounces-683834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05BAD7277
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39D21665B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BC246BD5;
	Thu, 12 Jun 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H7pJpLQx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B623D280
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736014; cv=none; b=iZ81B2sTdmdbyFh0/ypQywceaty2Hdlr3tCXV3S0Weke+fFGyhuJXu0NdQQaqyaOzBL3Hc8KTK1vaehGSQdxwPtBROeUp8n0GxHQW7D3veyM5CDY/xfqL+8zpAozTOux/Uog+BsmvHWoOG1+60oO6dsdlqiUY5V7AeeWYeKJY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736014; c=relaxed/simple;
	bh=FnYESTc3DcIkI9hMohVQTf+nyHZ4BGncS0S/+iZ8iCI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=VXywlxfKojzYy9GOZLCZaz8Sqwy+czlG4TfZ8fCwisx+Se6WBKmFX0WZ6TdXe5dqM9HAPntkvgWeLPT9SzHoPmDPCLRYoCtGqI4vpJvhiQ1XKz0hYndz4azimxc7LDwn6b6WitcdbUid3ptuoxDSjWN9cZUGRXD1ANJDB8YHf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H7pJpLQx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8Fc4X009059;
	Thu, 12 Jun 2025 13:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=T+1brjTtLxh3V2AXFc9+E8
	KS4xWSQDx97+f2le9Gc1Y=; b=H7pJpLQxBqA+ctHtWENfTOv6yL7ozGnX7lCB+w
	NEKOIsrzoRb5f13Joyi3FftTM8a8QUX5Mgdvu1Z9QioIGvd1wm7dnSf23BN5q0GQ
	KwIImeMhszsjsFaX5/ydoYMvCfLmbaXsjrYOICk1Yr8dhq+9Q1xok6DmLVSZTBYj
	KkJxUzbUC2hO4Jk7sMd1i0z9irX/zQB/6DvpgLv8VLh3SrvZ3lcGZ7qjz6mvgmbh
	h19set99A/t8UOBogT3FDQ17JeP1zL42yahv3HfN1YzDXiZ2zLAVoQZP6B2o5Drp
	V0ZVmHZwalSCYItFeDaSeq3HoSf4IyUaBj5XUkGr4MODpdCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753bvkvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkIsU005063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:18 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:13 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v4 0/5] Add FIELD_MODIFY() helper
Date: Thu, 12 Jun 2025 21:46:07 +0800
Message-ID: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/aSmgC/1XMSw7CIBSF4a00dyymQIW2I/dhGoM87E0sKGhj0
 7B3sY4c/ic53wrJRrQJ+mqFaGdMGHyJZleBHpW/WoKmNLCaHWpBGXFob+Y8BYNuIUxS3jkhedt
 SKJd7tA7fG3caSo+YniEumz7T7/qDGir/oZmTmggnu44p5fRFHh8v1Oj1XocJhpzzB+3DDmqqA
 AAA
To: Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Nicolas
 Palix" <nicolas.palix@imag.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton
	<oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <andrew@lunn.ch>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=2184;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=FnYESTc3DcIkI9hMohVQTf+nyHZ4BGncS0S/+iZ8iCI=;
 b=xZouBP9zRArppTkikHk52vKnv/VDF8IkUZQ6FlgXUpKraQ/ZWDR3LbdL5GBQGam7r8uwtydvt
 z43rhJ809e0APfbst02ptlifu9hZWGDsYGM2BFcjUAn4O2ZV86HxOIZ
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNCBTYWx0ZWRfXz6dofNTEmtXZ
 FbD2t5SbL7YDM/rCcADKQDWAWyfmP8+CiQtEnfCeCou0L3igg6FgSHnXkZd4/0Wfx2rytRZWPLW
 F0S2JybJMU1qe5+NmmeosebL6V661rW7Q1QB1GMD4/8IBRMMyohiYCgdP+0PFnRPpjcH92qvGhc
 e54RzVNv80Vjp+plUyKJrBpwZGcVHDCN+GjuMNx0RmR5obAidccoRc3EKSpE++rOfQ5JSYoO4P7
 UgpRrCj8Adm4OB0tA+0aPUwxMH453EK1l9DIR2Lv6Mb2gc07cmctbzj+gpgM5XlpYDWmYPr+4ZR
 SlcJ+ALWthNnu7eZ3Wdxd3Ks2nW+I6HcS5pRIGAK9/IiPo9NTEAVIDc4xYqdWFHhI9IvqsfdUi1
 HAzUM9eBjARnnnAZ4X0yRN6TfscLakiM9e4UY27IW+QjYzrdFaMoy1QSrSdWDEJoucha2QiD
X-Proofpoint-GUID: tPmwA4XSRPj3-r3rjLHQnd-ZR-6A550P
X-Proofpoint-ORIG-GUID: tPmwA4XSRPj3-r3rjLHQnd-ZR-6A550P
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=684ada2b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=UexEAHeDQikcoB9hcigA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120104

Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
macros. It is functionally similar as xxx_replace_bits(), but adds
the compile time checking to catch incorrect parameter type errors.

This series also converts the four instances of opencoded FIELD_MODIFY()
that are found in the core kernel files, to instead use the new
FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
the script field_modify.cocci.

The changes are validated on IPQ9574 SoC which uses ARM64 architecture.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Changes in v4:
- Add org, report and context mode for coccinelle script.
- Fix other comments on coccinelle script patch.
- Remove the FIELD_MODIFY patch as it is merged.
- Link to v3: https://lore.kernel.org/r/20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com

Changes in v3:
- Correct the order of header files included.
- Add the Coccinelle script field_modify.cocci..
- Convert the opencoded FIELD_MODIFY() variants inside arm64 directory,
  identified by field_modify.cocci.
- Link to v2: https://lore.kernel.org/all/20250410131048.2054791-1-quic_luoj@quicinc.com/

Changes in v2:
- Update the documented example for FIELD_MODIFY().
- Improve the commit message to describe the need for the change.
- Link to v1: https://lore.kernel.org/all/20250318071526.1836194-1-quic_luoj@quicinc.com/

---
Luo Jie (5):
      coccinelle: misc: Add field_modify script
      arm64: tlb: Convert the opencoded field modify
      arm64: nvhe: Convert the opencoded field modify
      arm64: kvm: Convert the opencoded field modify
      arm64: mm: Convert the opencoded field modify

 arch/arm64/include/asm/tlbflush.h          |  3 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h   |  3 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c         |  6 +--
 arch/arm64/mm/context.c                    |  3 +-
 scripts/coccinelle/misc/field_modify.cocci | 61 ++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 10 deletions(-)
---
base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
change-id: 20250612-field_modify-27139f673881

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>


