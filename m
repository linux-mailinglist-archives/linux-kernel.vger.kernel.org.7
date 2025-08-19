Return-Path: <linux-kernel+bounces-775414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7670B2BEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D482E5230FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC131CA58;
	Tue, 19 Aug 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYlZo1TZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD827990A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599276; cv=none; b=nXime9eC/vBUIxOOhexZhRoU53nTqdh/vwOs2JIJxf75qYJ5uYRWDRQtUkatI34KD/nvdBVphTRwx86uPuC3ldvEV6zkyrAHHkDTB2TB2dqm7UhHROzMOL2IovzGJLgs4gvy2iHauF/m3QMylt52aOUWvgAPGPDxNtLZ/Cz4psQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599276; c=relaxed/simple;
	bh=XHlIDamfozF0NB3BJsqHQ2b+McMZm5vEA+kk0C9b6SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WlQHGJtAJKfiL5w8f2SdtmkvHjvOr9LXY3vOYjZurqfzkzmAB/aLGUxlX/aD1lV0wX8WilRTKIXpZsliIvLxe9g7BrQ66msbWXvy0saBywLPihFbyz9rY71jJJxg/+mKFIw8jo77R0VS5XBTT1fodlEXlzRRpf4mfxuBErP3TGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYlZo1TZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90WQD027738
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XUfhVRdQ6/3Ng5WhQWu0dh
	68glt2LJ/MwzF2hOh4lbU=; b=kYlZo1TZzLAka7bMxeRXPCD/1OktA4mIUDGxFl
	SFzBAP/Kgdd3sFXZQmOBIRoS1UDHaOmGU+yfszUmj6qyADgNgrwZJCLkRVC7vpf7
	KomcTlIzyhYTvRQjHcV3tEVe6saagNAOYUD1ZHhH807Q845sbasSzNXUV+8jmpeg
	NQJgS7pgmATZqocaGUfnG1mHqgoR4S1VOHJccydPzUJQwMGOMOX2ef4t5Hnj+yfG
	wnlaUfMk6ceTzL4cIWBGCnNw7XM+FVLORoO0ynB4v1k7CU419bGk12Sc5lJSWsZN
	HowRMOpjDOlskybuFDXfgHBHoT24UTA5VPyX+MzINnzoB87g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtgcae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f4f3ecso61514235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599273; x=1756204073;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUfhVRdQ6/3Ng5WhQWu0dh68glt2LJ/MwzF2hOh4lbU=;
        b=w+Gy1oamLlrDYzSsGmRchatzRZgY7L56MRIA8oz900Ljx73sPkJnnwqnDNnWbOEwrq
         W2YG/7lUqljDEsx/VwW1LAiyOO3H71ZdfUFnQyT/Jwua8/TDqbXIwo9h4pM+ELCLwIb2
         LvgrzX6/CwGIm/yGiY7CAqO0S2GuWlq8WoGm8lJiIGGksRINZCQXXopajJZetBYN6OJw
         6Wu93mvkWgvzmSXEKWPSlL6AetIdcVZZrTBHpUgCOJHIV6G6hdNT7kQom8gzCzoLzROm
         i0kNo3pdxjMvaWm9xpB12g6aAuiasTfirFfu5NlOgHwW+SOE5so77ttsiATXMLE0MAWR
         J7lg==
X-Forwarded-Encrypted: i=1; AJvYcCVSrgdaa5U7gbFnQW2blhyoNqr7Zo4v1lxVYHZId8JoGlHdt3h+MwxLs4X+rpmvnj2GbvJ7/nvQ1oOC9aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAo8ME0csOm8rVmLPJB9z4pZnLILyNlOwDZR+KHcXZh6s0xHQv
	Xa69te68AkO6GJTfZ4jZiT2ouebnNmYijyOiyMTon9fQ94KfTp0FfczqpVReREN9Rj1UgRLd8B7
	82mmmf5T/0CNXYBppsqBvvs/y396A2RFZ1OoIW6E2kXE6K5QNgoOeCFjPV9ghqEorHMM=
X-Gm-Gg: ASbGncsMTc1QROZsVfVh49Rf+XzRGlgsYAVJr1aeSoY+3LiwU2LyOXMw9BKYil5j8No
	w/woouVBT8EqMsV2bqdIRXRgbCsKH2XNCvU/qHqx5nsLVq6iccZx/tTnOJJKlOjMcbzs4NYOGvr
	XeoG6jVb7CTdhNcTKpQOVxcUka0hxDkBYSPNEyyryrcqWujvCrWaoQO2nzJhqfDMFt0prWV6tJP
	D5IC+fEKQwTs6LGzlOyewpFpotQzMBFEcm3VpXTklgFWt0uurbRoq0LwhaEg/pIeb7o+HBZZZSG
	gI1TNqjahnCCcE6I+tkwB+tKtFWXz2PAKQSmn4RmwblDB3bknlVt93njXjWGu7xzOwAOCGv8Kgf
	aeKppxTyHrRBeA8Jo1P5yAA==
X-Received: by 2002:a17:903:1b04:b0:240:84b:a11a with SMTP id d9443c01a7336-245e045d719mr27783375ad.17.1755599272904;
        Tue, 19 Aug 2025 03:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkTrBxR/KyTC6Y/uomVmhYDGXtvfmzqkiXxTlXuSZLzj8nMvj3e+2tNVfCfiHbyyASg7A3w==
X-Received: by 2002:a17:903:1b04:b0:240:84b:a11a with SMTP id d9443c01a7336-245e045d719mr27783065ad.17.1755599272479;
        Tue, 19 Aug 2025 03:27:52 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3eef8fsm2499643a91.18.2025.08.19.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:27:52 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Subject: [PATCH v2 0/3] coresight-tnoc: Add support for Interconnect TNOC
Date: Tue, 19 Aug 2025 03:27:42 -0700
Message-Id: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ9RpGgC/12Myw7CIBBFf6WZtTRAX8SV/2G6QKB2EguVqUTT8
 O9il25ucm5Ozg7kIjqCc7VDdAkJgy8gTxWYWfu7Y2gLg+Sy40p0DDcfDGt7LofGipviBoq7Rjf
 h++hcx8Iz0hbi58gm8Xv/C0kwznpplGunQdtGXgJR/XzphwnLUpeBMef8Be4yqRWhAAAA
X-Change-ID: 20250815-itnoc-460273d1b80c
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755599271; l=1208;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=XHlIDamfozF0NB3BJsqHQ2b+McMZm5vEA+kk0C9b6SM=;
 b=7C6M4/UOPx5g23jPQPBAf62HvnTMhZrJOK1dyo2JQfFc3IumuNoX1xYONxfzKsr/SIhyPRB+Y
 uzpmlgMQzCrDHokCxhGOakwF+xq32r0XeI8ruflGjYU3OPvVakR8Mqz
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-ORIG-GUID: yhc00_exB4kAMIyFbvTeSJ82WjJ3o2Ny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX25FaHjOgVNbc
 YIU4CwilDV6hUb/lc/q8teeHuryrh7CjHOo3+Q+ssLbiYhH4aTuDDhWy+HCgUc5v7XAQOgVPDxp
 l8BsULmA8C77XEa6I6csmtN7Imn7ZT+FFsalQ4Ngw2bgbCuYKcaucRTe2FOlo6dVyqQ6inCHH4b
 AT9AHKzZ9bxkvkXIZ2ZpkAU9NS4EBjiad+CcAzd8yXEKNXmCljc8G5LcJiKLwrIegKq6X/8RXkE
 Ukpwr2E93OrKtuEqWXxyf6eolNXMtv9htOyvBKgrgAyJ26B7nhSJuajeizdi85uKSr+WFTqSyB2
 dbbW6DjGVsTWG5CLQQh1A8kGIfZBGZ519Vy2+UHS71t967YeMdmc9kFkuSekBHGdBq5gXVmnlrX
 n5KcNZLQ
X-Proofpoint-GUID: yhc00_exB4kAMIyFbvTeSJ82WjJ3o2Ny
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a451a9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=s8j_kBg_6ddNrZYoh_kA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
(Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
this block does not support aggregation or ATID assignment.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
Changes in v2:
- Refactor the dt-binding file.
- Change "atid" type from u32 to int, set it as "-EOPNOTSUPP" for non-AMBA device.
- Link to v1: https://lore.kernel.org/r/20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com

---
Yuanfang Zhang (3):
      dt-bindings: arm: qcom: Add Coresight Interconnect TNOC
      coresight-tnoc: add platform driver to support Interconnect TNOC
      coresight-tnoc: Add runtime PM support for Interconnect TNOC

 .../bindings/arm/qcom,coresight-itnoc.yaml         |  96 ++++++++++++++
 drivers/hwtracing/coresight/coresight-tnoc.c       | 147 ++++++++++++++++++---
 2 files changed, 226 insertions(+), 17 deletions(-)
---
base-commit: 2b52cf338d39d684a1c6af298e8204902c026aca
change-id: 20250815-itnoc-460273d1b80c

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


