Return-Path: <linux-kernel+bounces-831443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511FB9CAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C0A3A9C20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1D2BD5A7;
	Wed, 24 Sep 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Podo1Hbm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96975258CE7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757422; cv=none; b=FEx/I9Z7XF9YE5y4kSq6rtZRm4m3aL+xFMnywlR0e6wbu6kNLmR1Uk4E04zM220I5q+Ewe18Gssr+8JYG5HHp0V95C4dkvM73Yfr5vF+Wd+OkOKuHnMWtHVVlh8kQDXlSvgRtjtiOAk974+olA0WVMOcuka6NzV292npyKEqeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757422; c=relaxed/simple;
	bh=t7uBoD+cSRGeY0frmDJc3GrPO7PyWVRw817teW4B4Uc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cfz7adGI72gDu0bNQMv4SUxw3a5aMkS7GbWx6Jo34TGgAmwB9M4vMMe75OkxUBtJUnPhnIvfgnoJdZVjaaqW6OVWw/WFwQBsc2OwOeLCOLiVDrQcnHRcg+i/wp1ugQkr57oeUMQW6wqFbuO0LMD62w/FIGyM40D0fnm7DPbARE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Podo1Hbm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODDJgI002135
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=In5B4SFUWbiVbNw+6JD72Z
	+7pTL+H4loa1+DnN9jm0Y=; b=Podo1Hbmk0Kex/9AMxoAOFKVXDzwOQ9Kk1v+9p
	Gv485gNO7rbFiXXgFdnYdhZLwwpX9scrgmy9sLfhodG5/cOx8YL3h59JAOwHyr9v
	8I1cjCZMNAiPNBSRjc4P2zBEkIKIfAkzF7AgQPYJH8VX+ycoRqJoC823Z7wMyJTt
	PDg4jKTG4MsmEincYvTr66qhD9EZ0WLnLxUNfLTNizZ5iODmla422V4q1DQLJlbl
	w+pnvMgr3vsJxHe3KvKqrqSPjYJB3ps4qZLTXoLudHEaZEW6RBI/BZGg2RJncUvT
	B2q8+quNi62hkjWoM1HMrMCAnrp69665SA4oMCF99ltYQDog==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p33v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780f914b5a4so357447b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757418; x=1759362218;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=In5B4SFUWbiVbNw+6JD72Z+7pTL+H4loa1+DnN9jm0Y=;
        b=FbG/1VTP6bMLwSvaBGGiZtw+m5AA2Ix2zEFYo2qUUn5ycTXouM8CODi4Ugc/t2OCE9
         zUBwI9CQfDZw8FQBmo0dTz/PYcfp8MBpQ/K4cimg0tfn4QN6F7BWzbWngxO4GhQFPRQy
         w3nx7WBBRJojkgVr4FJwfGMB5mNieN2W1hvlOFuV3WawySyUKo1gS42eUjkjSUj+De+k
         H6FsawAHmLFw3fzAVnbUbWDLjJrmInXUkmkFtWbzRbFb3Em4HcX3qAU5VU0WNOLIsFx1
         cEQ1MThPivT8TEE1gvmMmQ6RmcE1bil4oaDhVo0LyRdOpC2EAzQVmOQanpCwcCZV4snT
         kGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb0MG4D9VydzAMkiUhwKC3VLDr9mW2uYZYcTnEJ2d0hdq+IaBhLIU9uAuTgUVQdSkPfb1IzijEiRoYyJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvUdQ4DwvUWgUEaSxV8H+8CmjECBE9nIoonzQg5349ncylW+B
	EYY+0olLHEu3Hmbk7LNq0jb6yrT86NoR+tBf6r5jT5+uHRGLLHshXL6Xz5ugUp8wtjhsRdcuF+q
	wA8hwGBCDcKoej+IVaI7Qd+3KzPF/rM430y88/DJiClGWHJx5a6xG5CKudOAlvo5pPzE=
X-Gm-Gg: ASbGnct0CCLaVxXQRBckhogejqO90/OvgWF5/8PMepUDcF5oxsp5fOVM+JKVZOZ2bIO
	LEXj2SoRyAIIkjQK5iv6bmuhyqUuNjTbmG/8dhFRbpX4evfScYahOw1eUKOVQ8JtFpPrcalrDDM
	3gsmBkBgTRcmIlqi9CKD6GuKtmnSMa6TRbDqMmduadFGKCBQIcbGiFikUL+UZFhNZDCTskVlv1W
	xd53isJZ109yEqc6EAqrVfPzyaVq7BGcz25AQXXmQHUkCVw4o81wEzBslTd1Xr5XpNM6dABmD2p
	zC8qGTUBsZSviFiH236TkhJRvs/8Zm3ZtQKvOOv9FNul9w5jzM4jOLGCjxEYCz0yyXhyPQd+TTS
	a38ubBIQ50+UWneA=
X-Received: by 2002:a05:6a00:170d:b0:77f:2140:9685 with SMTP id d2e1a72fcca58-780fce1f6edmr1769866b3a.9.1758757418201;
        Wed, 24 Sep 2025 16:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDlOrNCje4Yf6Bti8pW+x17hT253jff+SFz9WfQJSBDEqdRLA+UARXeByWoA+aLojWJr5O1Q==
X-Received: by 2002:a05:6a00:170d:b0:77f:2140:9685 with SMTP id d2e1a72fcca58-780fce1f6edmr1769847b3a.9.1758757417745;
        Wed, 24 Sep 2025 16:43:37 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b64599sm192088b3a.70.2025.09.24.16.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:43:37 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] dt-bindings: leds: Add bindings for Kaanapali PMIC
 peripherals
Date: Wed, 24 Sep 2025 16:43:32 -0700
Message-Id: <20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSC1GgC/x3MQQqDQAxA0atI1g2MI1brVUoXY0w1FMchKaUg3
 t20y7f4fwdjFTYYqh2UP2KyZUd9qYCWlGdGmdwQQ2zDLTb4ygXLKoTFQ+Rw7aiPHbVNDd4U5ad
 8/7/7wz0mYxw1ZVp+lzXZmxWO4wRd7X2weAAAAA==
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757416; l=653;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=t7uBoD+cSRGeY0frmDJc3GrPO7PyWVRw817teW4B4Uc=;
 b=VQhNc+8yRnhOFDbwK6RZoyv2w/g1+PdrKQffBcjCCY+Crg3fyOgSPav9opyPXX6Srem+8r6DS
 PKd+UiruCN8C4iS2nf+4Tc/RovOGdSPPK6/k3QePF4PR1n2P7Ja74zS
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 9B7_ylx_xbyuDFXJobpkOUSQPpYguGo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX1ChjjF8kNaDi
 c6frHD2aWrWwaTPy4xlIqsdDvRYUNoQtxg74U4zrdYUGosAzNOmIqZxRbNni0P6qq2RhHhGsLYn
 dHkRhzgmDjf86YtS6PM2LLsRI5Ra9MHFDKVkzCJgQI6TgTYO7QkbHMk0o9P5CxZmAx1klPPAMJx
 QSQHrcAM1Ljv6iiemzfaFpo2lq5+SHlnfN6S+u57htqZpgWasyshPEcyi2WPDLhymYRLUCLvnvW
 CrT/LaYd6XAZafR/UHDSDUJILkM7kZNnhlj25dE3G6e8tAhIXzrlRI/FXplf5MVN6maETzfhZX0
 Gcr7wYY5HEICE1MZG0u1xJclw5ciBE1Grz+JvO2H5XLkcZhcOP07LlIxgNKBB6rznF76dPQEehb
 vLTcYSbC
X-Proofpoint-ORIG-GUID: 9B7_ylx_xbyuDFXJobpkOUSQPpYguGo7
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4822b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=w1v-58I_rqdrY5_ohRUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Add bindings for flash led and PWM devices present on Kaanapali PMICs.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jishnu Prakash (2):
      dt-bindings: leds: leds-qcom-lpg: Add support for PMH0101 PWM
      dt-bindings: leds: qcom,spmi-flash-led: Add PMH0101 compatible

 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml       | 1 +
 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250923-knp-pmic-peri-e067c827c531

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


