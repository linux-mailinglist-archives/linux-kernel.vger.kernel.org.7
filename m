Return-Path: <linux-kernel+bounces-831353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F25B9C6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02703A9C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69C1F4C98;
	Wed, 24 Sep 2025 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hs46tpna"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7D296BAA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754984; cv=none; b=ETjqZYZXRynkbk5Qu6A2D4hVI2OSDVrg+6EWAZiWpplEa2O7mB6Rd8JLvYN3PeYcCQ7PkVCWmG3+Ss6JWr1l0KBOoRk+VC1ZTYEo3xGhxgHrM2upT8jngAyKIxzzJjoSlr/T7HYo7dnVrucHvMQDlIv2USF99g1BMQSHCgnlJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754984; c=relaxed/simple;
	bh=nRwt3nntfCFNmkA6WdE1w/AtgfXKpttU/xX/NO2gXrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BvuoifHj7K7rKymuLjwZREoaOnobI30Q0gEF7F8yHclVhgBBo9kQX2lanaCsTtU4q0JMPvfpgazIOuWQ3/1bvYESC/oX314wxFiLTzwAJcpyBqzrqnuGNnkZQCsdcwSFootma6mfI5eghi3RdcbhXGUpbDJbCt2aiui5z302AjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hs46tpna; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCbHp3023766
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EEovNlQ5bCPkreL3sup3qN
	aWRrg/nYl3xLCiUK/1dNU=; b=Hs46tpna14/OGE0V9YcY97RUaYeJLUyDn72uTr
	K7Sz99NcAV3n9R7PTw8T1PcD0CeXeMP5mAFaX+fYdOqVHFDGEbOwg3n48IKK/6+P
	MAokNF9EwG4Bg5lE/r6nYxyl+KXNR9I7BcJChFtWGufjRqGYniw505cO/t7Y4HIb
	1bRuiFyvIV7dgesLaI30y2BdKUEwbptk7QVR1qrPm5gRVLNVjq0YIOHBn1Z5TptV
	AoamAudkg8IoiHUgXQd1XnPc4RIJbc1rwXA17kdcE+yhWGiWzM6ikPw9sNniEVfj
	+HqFCZO3Ma8PnEJg3Z9Bwvjk/m/jnn/ZNsDRHamPqyYKFirg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:02:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268141f759aso2594805ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754979; x=1759359779;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEovNlQ5bCPkreL3sup3qNaWRrg/nYl3xLCiUK/1dNU=;
        b=cJ2VrMrf9g3YqjSlCSzz0SG6h6cloOkt5YIUEssN+7tj7vF2CKW7y0Q+hXVqvWZP2G
         bwzCJt3UP4ve8uzID/GW1+/Us66qn6VqJMixUy6R8c6s1cPHW7y25LU3PCIj6qT3D8Fm
         Zbf9zfxG+tUvWQwWAjv6Y5Wlb4Nh0P8RNXWdvCVcn2W0W9vps6GECnEr5ejMzJ9RdMZt
         /AeF6QBoF/j7F0NRD9zW77WCwln+Bk/B0PYQ1Gc6eR+Ng5nnz3Z+KpBDf+SGmCR6xkm3
         hbsX/mBSMwuG8OTCETBjGwC7Zy27KQCbZ3zwKYwtOErSWAn64YJlY93/5tnGCgBalHO0
         rIJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2hFvyX6slbRKYFL7YbYpfjcGwClVYLYMa2lirc/jxL90F/okUE2mH4hoG1esj4Dl+AuCUbJCDESU8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjzntsEaYbtBGanWl40+heqcx8wA0WrMk6jLhx8m6PgxVGc7k
	qaPWD1qzKHnOp3BxamF/GztJXfhrQtmQmX3ZnDpXQszChdoqw/Ha/IteU9Y4FkpCWo1VavujZ0i
	b/LIkDB0aKEkY+hzrVvwbTpWWshzB/oF0crTtc7vFWO2t1syn2JVAXnDj8Q/GEEcH2RI=
X-Gm-Gg: ASbGncufh3I2T9dTGY1PPYZsVgC0q/bgQhKxF/r44ZFdEPgNlt9fV4ItBO862gUozEJ
	YZlmCShSU8iVbGbx7y/dRhWFQFl35QqhM5aJOkoxihFQvH8Hn+EA8cc5FQ7HpWdXk54/6On9uZ2
	MB2uHvxQ9xu8YwZZuwiA0tL7DnF2DFijRhc68akRI8ufOEEnqudFxdDhOkvw8KjAUxZGCpdEBM4
	8VhY5OQk5N6IoZT8pydcVV+IYeQ+DTsAjxoznDvRBQFn8dRxIAfGSBppMR9pOqP6Qdk+xORA5RG
	sdLYuTKVVqevOTh94L3G9Zu0TJ2betZ7t0A3HwwJ2NXtIOevZNrA03SfZ65ns9zykGGZcbMCawT
	39bFYSQAZDPkcwkU=
X-Received: by 2002:a17:903:2f86:b0:269:aba0:f095 with SMTP id d9443c01a7336-27ed4a3164cmr13375615ad.35.1758754978354;
        Wed, 24 Sep 2025 16:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWqE9Wz0InuUFJtaOLtEVLSMSYQX4VVL8nUER9WUlygGTuSzRC5iSu6J+VMjwX8Wrz59nCxg==
X-Received: by 2002:a17:903:2f86:b0:269:aba0:f095 with SMTP id d9443c01a7336-27ed4a3164cmr13375285ad.35.1758754977922;
        Wed, 24 Sep 2025 16:02:57 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347472e49esm153255a91.21.2025.09.24.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:02:57 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Kaanapali SoC
Date: Wed, 24 Sep 2025 16:02:43 -0700
Message-Id: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJN41GgC/x3MQQqDQAxA0atI1g04Q6Xaq5QuZtJMDaVRMiIF8
 e7GLt/i/w0qm3CFe7OB8SpVJnWESwM0Jn0zyssNsY1dO4QbfnRG0YWNJlWmBa89RRpCLqXrwbP
 ZuMjvv3w83TlVxmxJaTxH31Q9hn0/AAGLlWt7AAAA
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754976; l=1027;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=nRwt3nntfCFNmkA6WdE1w/AtgfXKpttU/xX/NO2gXrE=;
 b=EKTtxLaFS4Vb7zFVZ6YgHLsegqHVof070b+u26o6+YUPBWf6OZaQ5doirxHO8+yJ1pnli1Wtn
 sfLmYF8ecc2Cib0kjFMyxMCNLhVG3LN80QJDYYxRNgeTVTtEBRRBqNd
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d478a3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_cDidGYXCDOhaqYtY5wA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: EiizNBd-N29xAE-szlTihPWxSFTmXdCm
X-Proofpoint-ORIG-GUID: EiizNBd-N29xAE-szlTihPWxSFTmXdCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX9T1GN2QtXboQ
 2OpSLZfrPUR8Wb+kWudw1b6rvRuZQYs2mgH3c0SNc2VvIRIInGSNDo7hT4/muFcTQdOpLW6tEoV
 gzVHg0BIGUIeiUiGe1pxhNHE01bcJfCbLjt7cxsoZxDYXKQxtkCshU1qEgDjnVsLn1WGOPCvrjM
 IxpbpQLoo2aevxUmdfmYcWz0s6BXAZcwth8D9qmZ7KOyo6cfkZt+9aAVNj/RLIPxhwmI7pMzE4m
 e+V1Q7ckcXH/ecbDVeUQI6qkFGCt4XoLIbHRmJ7OHUSotkdZjxD1eh7gI5ENNWJfEUtSWRt7wuz
 s+8YXrwQUwKfFNt+s3jYxfDjc/KV7Nd0pSQNFDcodajzvpcm+ZIuwVQQicqmwafZlyVUlMUAZJx
 aM6H3Z7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.
This yaml file depend on Kaanapali gcc patch header file:
https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  126 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2154 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


