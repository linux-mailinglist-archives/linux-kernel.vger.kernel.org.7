Return-Path: <linux-kernel+bounces-755126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717FB1A194
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B4617511C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985811C3027;
	Mon,  4 Aug 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkzzhEWM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FA1FBEB9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311355; cv=none; b=GmwfMKk9qiIx/WuKAv9f5Ul2h/pNY9h75wP+FK51Yo20L1PXohT4yzFvmD/uryQAxrOG4qHSE0FMtRkINBmaRVYX5blKjCVo9hHOTJzloEb1r60NefFqBOV6koQ0y3zsLDDcFp8d2ETRpcCzc+wL9eyRCJY/zMZxL18HYHwtQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311355; c=relaxed/simple;
	bh=5jNeAtqRlRHIfao+1ZBtyngNGOGyS2FzkafomVLdz1U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wc0TdtLbMkYVPNKXRj/wrYfzoVgrONSzbonEjxx2muC44kREZauX+ViLsuQFufatifDRoEz+ksoCILMwfxKFgM+gbO8uKt0uWLdSCX2cYpwXwdTu1wpxmKtV1QxewDkPoI7fyXj+1HVC+o79fwq+OHal6Vkbjp7Zpdz8ibzMEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkzzhEWM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749LKDU024383
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qND7eaxsDP2YPzCmQqdenq
	TRv6C53QulbhoZonDQY3g=; b=QkzzhEWMpf04esR7GHNFhWVzSRpYXF/4m6wB8g
	Jamr0hpExVesI04EoauCvUwjcrLLx5KXuSQWRyL3p2up5pK/sewZsLYa7wTez9r6
	OD6keTtzWGGZZMp4CvbswLsqbaw2WU2cNKewB7ymLBY4UL/a2/witv0RPvnSCucb
	ur+TzNpLhOI+Loem6mJN2uaMIN4d52GGUXn62bvXxx5Ro3cQf6ioIGceFDMJBCod
	GqqlXi3uB/XrRUphQxl1uQWstwYACP7L75FaMmZeS0/dzLR77UuJDJZOIudc2Her
	9bpVVOokDEX4P6EyCMlP3cjd4vvF0SzjLpkOr2nPceb1BnSA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489a0m4wxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:42:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b42218e4a59so2834631a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311351; x=1754916151;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qND7eaxsDP2YPzCmQqdenqTRv6C53QulbhoZonDQY3g=;
        b=bIemNJfXMScpzloa2rqFGyMLd8KlcF06axM3P/ULuKRLKmfNwq7HyuYI0h0vsBLaHq
         jHPsg0yvnRj3Qm9aoZo89hy2st2mjvO9kFcbJhWA/R5ed3wnmv7V/VdqWFItKEO5Q9gw
         ozFkkkBoTWgbHxrV39ybt9yolft+88NHjxapbk08cTYxWRTy49NvTZ/jeC5turRNnqPG
         Sl4ZM42MvH/Qwbc1B1+SR+dsbFEzFfMpWVrdUPHvv9m0h5OfL637s0KW74gNaoroHKZg
         Ft9EY164E32dlCa6mhyrehzH3BxMbl/6ESNl+QPRbR0dKKnYBnbTz/DB/rEMcexzOW/A
         YTdw==
X-Forwarded-Encrypted: i=1; AJvYcCUIBtxdgb5UO5RdsSE8tTqv/Ro5xcSJyQSn1hAOfXKV8UboIkTJmgNLbUMXTIYmY4ccrhK4gtbq88RCWsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31xJVXBva4V3qN45N+JWDrySQOsYe5eL8958V/JS+xdUvWAgW
	vIiWZInvkCenBq+3VkIsHb79sb0mWZNPFnqqEqfxgEOZoVvUybqghfRKm5t057mRC55jlh4e3QP
	a7SPrf7ROeSxzoxOBGuQjN38Jq+zkWY+LHppplxJfVBDjOHmR8z9FOhdk8pi+MsV4Ny0QWHOjJQ
	Y=
X-Gm-Gg: ASbGncuqnv1nOWQlcCP2czOjBxQEcqU+1GBwC9ZvFB6DMNKrAcPFcY1tGOEZ3kQPCwt
	wGqpcLAyt4/N2Q3u77HkAFSggK8NaniN73HV/9sIq4rzY0fqpRj39yMMK1d0TsTBHERuDoSduFy
	ZnzOZqIAeaO9tkqOZZCQBkPQJk0DpNmlz/CyrSNqdChvAx+9Pqqy+jp0vdxaoiz/7yB2Bq0HdMW
	vVqqLLsr6TBiuPv0rRTWs2DJKCJdWON1fS3K6SK4f11fto0DIdYdeHZzGwD/4wD9p8WGAyNjR9n
	xMWieCQnoU1EO32aIKqq54Sqxl0Omwy/H93Qh7g6z0BOpaZG0JUup97NgPnZDsXh+zg=
X-Received: by 2002:a17:902:f68a:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24246f5af77mr145455435ad.22.1754311350808;
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG07rzuN1fGkVlEDwaXMjcJKT4QW5T0QWL8B3N6dJhvgGjnkR3R+HIt1As8+4jwK2M5o5BtGQ==
X-Received: by 2002:a17:902:f68a:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24246f5af77mr145454915ad.22.1754311350374;
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm108876365ad.34.2025.08.04.05.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 0/3] EDITME: cover title for mdtloader-changes
Date: Mon, 04 Aug 2025 18:11:48 +0530
Message-Id: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyqkGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMT3dyUkpz8xJTUIl2IfLGuZWJyoqlpqkVymrG5ElBfQVFqWmYF2Mz
 o2NpaAFv6VxZjAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754311345; l=840;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=zP+SLmOOtTIzO9h/zziRzrIH5ayjpiu27qhU5x3QZj4=;
 b=rX93wR4WgVYLlBcmB1rP7toMI/2qOHb6pLI8G7KQoJvGrWbEZfhFvr4DTzgeHlDFnC12NCLsJ
 n3B4pD+68yEAYtaMDGR+A80oiHxe30L8LX/YjdLYpSdQVaMP+ZMUXf1
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=JOM7s9Kb c=1 sm=1 tr=0 ts=6890aab8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mWPGPCZChkjDq24jzmIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: qGVq7XYtS6LhQcuTvUQkr0nHERWS1y3_
X-Proofpoint-ORIG-GUID: qGVq7XYtS6LhQcuTvUQkr0nHERWS1y3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX7C8ZPHjKcRJy
 yHwqCc19JqT5XRsMdqhOX/4Nzj5tgjHPOPa4vmrnsDf9H3DwfQDYIvUCdtamq3YO+yuHmCH6b/J
 QngCg/iQuzj8e/BhXY/1uJGAryt3ZVBU0u8NjJnyx+Gr73kOY7HJeIHyeIigw8+qEbuGPo2mHxZ
 49BZMbwQP8rqkc4dmreK3GPU27tPywltWcvNz86sjQjC21u5AArNAgjpneEl0LEIwAwR03BMFsJ
 pmqOOaA0RD4p01C1xieC1HV3KP5Vo0R4dXR35UlC8mF/bGx9Fa9I6VREdf6SCI0M9Lr4NIiopQe
 wIxQPkOHaB36MI6r6BdPAlIEnY6qKLmLufAlaFTOTE88rrSXWf1C4KQO3Ru24kt+gGx5NlEH2By
 0RRk+cGu7n1RguDoJiCVR5Y1NTM2EVF7cP6Ysi3Ts4Snk+30iS25xfQmnmJ/nrukUScx/e1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=823 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069


---
Mukesh Ojha (3):
      soc: qcom: mdt_loader: Remove unused parameter
      soc: qcom: mdt_loader: Remove pas id parameter
      soc: qcom: mdt_loader: Fix check mdt_header_valid()

 drivers/media/platform/qcom/venus/firmware.c |  4 ++--
 drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
 drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
 drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
 drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
 drivers/soc/qcom/mdt_loader.c                | 22 ++++++++++------------
 include/linux/soc/qcom/mdt_loader.h          |  7 +++----
 7 files changed, 21 insertions(+), 25 deletions(-)
---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250804-mdtloader-changes-9aca55e8cf37

Best regards,
-- 
Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


