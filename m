Return-Path: <linux-kernel+bounces-770923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF477B2807F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0373060685A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF730275E;
	Fri, 15 Aug 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SL9kp3a5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03327F16A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263912; cv=none; b=KE3WQp4TgMp4ylwojeyEZExSmSr/mx4RJc2EOL7YqI9qXwJ9BPZhqEcuL90zl+iKpYahS/ecQe5n3YzWMxIFdOi3zGgWj4JI25usjBKUF5djKbR60ggGYS15SW+qIyOx9Q9+XTa6Q4Zi75FySjDyD45YWelxhcSRADYHWAwIRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263912; c=relaxed/simple;
	bh=tZvCUIV6qFGLGvVtuK5LH9xKC+z1XirS0OHevyW3A0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2y/rfc4rfuJd1j+Mu97ESgOQUCDp6PmMMcNvXpyd6fyjfQyuMw7tuFOveyUlcB7xGDOJIkKQlBnuDKxq34+v5e391Oryxu6aynMu8OapoO2DeOBgScCkzUINZlvPEfg7AmFEryoYNVanbLihpohjyG5PuLWV5hNBCauThnNofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SL9kp3a5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9lopV007571
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eNMVupg197IOFiA3FKpm30
	vSm1X1n06imKSWoKuQpJU=; b=SL9kp3a51fm7wWCTEQthkKp2/aXb26FG/BZe2F
	HdxN/+pP0tdBoaybs7VsHgRkw3gBHQ+XhBvfusKIOLZ2Wdoa5w1p6qm3c0NPsz20
	fxySd2+9Bip5XSrWDuRBQVcorIuyU8VO7bC0OhVTSnxlACsEMAlsPbmPTRM7cekx
	1JEvZ/EbFKuTFIRwg9WL5poDajADRS7tNJfaYEvo8WOOp18aGssGYUFXaKl81mBh
	qwMDbENqEBjAgO8EDCnH1qoX/6HdrJ/LRUrAoQK/PbTvhmgfPazPesc5ezKpCyM3
	q5UujaSq9i5rTkSFu08bdCwlVBD3UWYIfk8M17in/OR31saw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4q1b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471a0e5a33so2810442a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263908; x=1755868708;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNMVupg197IOFiA3FKpm30vSm1X1n06imKSWoKuQpJU=;
        b=pjofQmk+iFkB5bCwT76amdc7nh/8ZDAAuRVdlrpXrF5TKf+wPKiPSlV6N7Jn+iQ4dB
         fJB9JVa4tY7vBCcpZbD/GYxk+HpCkzoqxlbq0kNA5lENCdy/ZLvf0w6FVtytZH+ay6+T
         FxEWs/kSNfVz6q3+lbwqzjBGP6R0aLUmi9aun3j+GfFvKcNeTgpFNuNdC0k43swDGuD4
         jqOtUZWH/AdBr9WoCxSXLswwdDTnexK7cx5KpX/F62vfwWl63zQa6M2Lhb9bKr8NNr0C
         JCkl8/DJOs65DxqYWIToerlc11ohDZmT/M2ji7ttigl9ljDZGIpK2G8MGYAvP8+DvpW6
         R3hA==
X-Forwarded-Encrypted: i=1; AJvYcCXkId9JC6Dbous9ni+4Y6Ls1HAYoluel96YBa3siPgtGUF19OUEJTWeXsscUshDskDIwbyRzMvXSMz45do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxch16P5Z4Wg30VOK/pSVLCfhvMmql/91ofodiwsIuZ5sXidSLB
	F5HjvLpwnu4BC1DT/A+5+G6XBx6zd89wi20sH93TyKeLUovKEY+21ZeufWPzcXe6yyBc+wu1zry
	6fIMTtAj0/TtgyppuWrcS9kefNp9bcONLYXZgpubv7gV7Y/+ynqcTpNN5G8Kw0s9ogIQ=
X-Gm-Gg: ASbGncu4/osutB68uEhVYa/15+6alapOwEd8CAYFBrylHF7nMrdF79gr6RdkMXtSeup
	rg7C41F2/u597GMW4wY4+VNajXmw6k3x28LShQIanTiGk/lxCXtbNTWD5xNpq1OnCffmfMvQObf
	93+K0Bnv2f9g3Kr0fnIt6HX1fG3U1uednV1lSXAgwDLMBV3THlrVySuS60SNBuIs4QnVgeCBqg6
	mGk/puy9XhqumG4UA+8hVO6ASbg/7xMCk3f+EXVcrGDOsobtblaR/NaNi+7mAb/c8PZKFndnCjY
	T4HjBQz2KeuTcQ0n+Hj++6puiZqsFWtEzxy5217HG7sSZ4y++p72o5AhqA90AADWAfvG3ZVFQOE
	1+J4gWIodrGJr35CnbD0HPA==
X-Received: by 2002:a05:6a20:1109:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-240d2db2d15mr2527922637.20.1755263908410;
        Fri, 15 Aug 2025 06:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtqLEwY3YCUoJbxvU9hUE86eQRwJCftdQkbRQCmCifI7oOfV2iGog3bybplfqEg7vBotQR8Q==
X-Received: by 2002:a05:6a20:1109:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-240d2db2d15mr2527895637.20.1755263908005;
        Fri, 15 Aug 2025 06:18:28 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7944e6sm1256386a12.54.2025.08.15.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:18:27 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Subject: [PATCH 0/3] coresight-tnoc: Add support for Interconnect TNOC
Date: Fri, 15 Aug 2025 06:18:11 -0700
Message-Id: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMzn2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NT3cySvPxkXRMzAyNz4xTDJAuDZCWg2oKi1LTMCrA50bG1tQD4+X3
 aVwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755263906; l=976;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=tZvCUIV6qFGLGvVtuK5LH9xKC+z1XirS0OHevyW3A0I=;
 b=/y7yCqYrQE6UiowbeO+3Y1+8kdR4PxSbc5lm7I+OXET3NFKx6udfiCilwy3Xjff35ud/O/7Zu
 0677fDQMCsXATGlVNEG6PABModwamaG4PE2RYi5Fya+6LMEzXMH3Oct
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-GUID: iEhpSr97yiLCL_vqy5hrYIxJ_QEvEuQi
X-Proofpoint-ORIG-GUID: iEhpSr97yiLCL_vqy5hrYIxJ_QEvEuQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX8GXtdH/+3OwO
 me2rkpfWEqWT9OHT07/kDGxkJ5k8fA/Tv3iDbxfKvZklaWd+2hSARq0sQbGGi1mEkYpgVVRVw9C
 BjGS6m7g+jl3lv0nq0j+rvd7nyfxkwUstcdb9zCOaGM0zMxZxufj2/Cy34rVjU+/+LsM3+xbfdk
 yDstYd5NgEv6qD+kU+ntRa6K/VBpfl/LL366LbgyEp1cEjmrPbZMhptgqsa3Q0xe6qe6J8LiOU7
 vn5YTKxFmi3rqbwOPPZqvZDb/uNTqe0k+asZ+9M/Nk1Kaw5jT9j8U/Yh5TvfXV5uXp/Wq+YRSZ0
 lFUzioVtUjgKjprRGjafi8EW6qlt+tqyf+d+Ath82wgMIeuOat4GdAcMgdUK0nivsYCmrlDYDQM
 fNaqxlRR
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689f33a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=f40Fa9qqsm2vFiWgvDIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
(Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
this block does not support aggregation or ATID assignment.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
Yuanfang Zhang (3):
      dt-bindings: arm: qcom: Add Coresight Interconnect TNOC
      coresight-tnoc: add platform driver to support Interconnect TNOC
      coresight-tnoc: Add runtime PM support for Interconnect TNOC

 .../bindings/arm/qcom,coresight-itnoc.yaml         | 108 +++++++++++++
 drivers/hwtracing/coresight/coresight-tnoc.c       | 179 +++++++++++++++------
 2 files changed, 240 insertions(+), 47 deletions(-)
---
base-commit: 2b52cf338d39d684a1c6af298e8204902c026aca
change-id: 20250815-itnoc-460273d1b80c

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


