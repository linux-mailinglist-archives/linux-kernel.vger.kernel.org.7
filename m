Return-Path: <linux-kernel+bounces-831434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E4B9CA72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807A04E341B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55D29D270;
	Wed, 24 Sep 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NigyeFxQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6612BD5A7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757115; cv=none; b=i26WoqLpMKOhM4gL+KtbLuPe2F/Qs7xQJ0DMwR1pbCm8Q7vASizdW+kWZHX7HeL4zXrnYe8FbOahLeqzcw90gLbyOoJ5uRE9lgBHuaSwRsenrpkw2d1yyDIMikDyo6/pB6f6bu6ayKuGubh8n1vHYaQu+brYt2xo/ZDOMTJM9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757115; c=relaxed/simple;
	bh=h/M+YE7D6HI61MSGhGzdJ4IOvTB8zDpewv4W5jZaG58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hf9781i7rzYSf3U0vir84jQcmQEYnczdBPTRQFJPJJtdGo+Uo9FhvGGrBL2ausMMFPy+Qb3gJrKR2Od00mzbruN2qCL/GkW/QFfjX8guvC2rM3JIBvh+8fRFtBKhpED0JnIqXHzK76HLaSt237QoK5p7qZ8n+v2cGtbXyYin6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NigyeFxQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODFGMC019923
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0TF3HRPmEBLSIpIUz7r21D
	zVHSr1wz9ZwCuRBZA9gfk=; b=NigyeFxQRTSTldguITL38UgLud76gdEw0wfHEf
	fhqR3zYC5T1ILmMYV0Z2JtBU5/KGdOdXvdr1ujeeHrh1cxkAtwnG9XayJFtPCPtn
	MuubaxZaaWF1FbwHgR1VJmnD05HlkFZEnc1Xqg/3dNoHKT3KyDtMhzcGMxYdRw3a
	Q09SXRHgQ8l1gcIfkA92a4QmYQ81tTI8hrsZalQCXc4uULUM4w0A0g+Q7RPvdJOC
	Vg07SaGKEcMP9zHMSjxCILKQ8pA3C70QaYK1t8PkBhZmGjqexodQfp++wOoWhdOD
	MCoYfV42NB/3mwEAmZhIT3bVJiZka3PmFYL644XlPkyp1org==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy9b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5516e33800so409529a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757112; x=1759361912;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TF3HRPmEBLSIpIUz7r21DzVHSr1wz9ZwCuRBZA9gfk=;
        b=QkGnu3SHfWmNxUXBFf3dsGMgt032qX5Nou3tTA/mtBE671amucUcy6FZG+VmW0IjUB
         CQEkFRR9HLeRbDEj29Z+TzCVe71RRLqsTgoUztr6zsNYesopLwkQeWkL8lKFAoNAKNCV
         k/oRDOMFbElazWaqVzOn0Id/VFvvjVnKrkxxnh1Exp5n/dbcURJBs9GjLn8wNgtwIPZO
         Id2y2g6juhsgK66yGfuBKsCTeNA+5dichihDyIU5jggmm7+7ft2OWoPji0PoqL2U+0RB
         Qz/wYeBy+dv2QLh2HxTzkpRcCfXHTPmCdKv9+DySzW/zPv0HMyhOU3RiLvvYKEwAjTM9
         tP8A==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZDq1ObWdeE4thPA6jerBc5sMc5CVRpwXdRux0nwS95xIvaQDIqet3jytBIzFN83qFUK8XxOo55oSelE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFX+BRxjItFjz0P2BC11n3VECGsZx+6veys1zuiYrOGx8uyXK
	/kmLwaEh/Usbk3roEeTAg6m+35WTv5WV5jgWS6ir1EQjuU0dCYRgU2wLINBDzaJPH178yrSwKqP
	ZwR173ZKUrPkU+DWGHBWZic6kCLnmh3vohesSFzGsAlg+M2hpDAVka38dnWOustldBU0=
X-Gm-Gg: ASbGnct9TE9eWEWjOLwKN4tVwmua+P3uNj+Nz75MY0FGztOxqBUH6Fb5+5tO0+GZROD
	d0sVqrhtjFg9gl2aLDI+hPxv5xEzJ9z5acK19gWyN6M85jqe27/Jh9GHxwXMGb1O9tz+aAnN0Eu
	JhB6OUOOrtL96Auz0A/EjQ+nwvZENAL5oacGqpnC2QhIXYWtdM7eCX+Ys5m0IV16NWL10eBZvID
	mYBmHZzgboSEY80YEhfuEoV3FuNVRXP3avvq3a/1rXNV5MyG2GrRcOIkHyaqyaBr63QzBrMuyth
	jiG7/Wd85Y+sX8MFR84GBj5NRLY86TDJ9nBYDnNlFDBPw8YveC/qc9RqvlAYWE2gX3imYnVFq4m
	36VihQe9jQIUN1O0=
X-Received: by 2002:a05:6a20:938e:b0:252:525c:2c2c with SMTP id adf61e73a8af0-2e7c7500160mr1824687637.14.1758757112400;
        Wed, 24 Sep 2025 16:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG27SNNEo7XFBRYDt8iP2aB3NjvPMLv0tyORjPFSP5krdWqSm9v+h+GvSXA7/UKhqgsODYJaw==
X-Received: by 2002:a05:6a20:938e:b0:252:525c:2c2c with SMTP id adf61e73a8af0-2e7c7500160mr1824656637.14.1758757111696;
        Wed, 24 Sep 2025 16:38:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c0709csm177056b3a.81.2025.09.24.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:38:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/3] Add Crypto support for Kaanapali SoC
Date: Wed, 24 Sep 2025 16:38:26 -0700
Message-Id: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKA1GgC/x3MQQqDMBBA0avIrB1IImLtVYqLJI51KMYwI9Ii3
 t3Y5Vv8f4CSMCk8qwOEdlZeU4GtK4izT29CHovBGdea3nb4SRmj/PK2ouko2ObRhCk6KEEWmvj
 7n72G4uCVMIhPcb4Xi9eNBM7zAuTggIV1AAAA
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757110; l=817;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=h/M+YE7D6HI61MSGhGzdJ4IOvTB8zDpewv4W5jZaG58=;
 b=k+uJbL7n+ABJU0CdxxToAbgHkIkpiy7+s0NQex/HEk2EqUTeK0YRJRnpIER4U11Tu2BsNzTqf
 qPSJZ14jp0BBgwDp5BbSr3LVUgA5Xz6dsX3XYm3ER890/eeg0J7ndyY
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: VhnvcIxFmHg6n0-gLvbct67GLPPwxWGs
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d480f9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7VnHweOnuvEr4eq_jGUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: VhnvcIxFmHg6n0-gLvbct67GLPPwxWGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX5/k2h/FXrKYP
 TdcQtxgSgGps4jfNM1kUQim2AAJInY25iDx7hyjkVFITEW/iel1h9YZVk+UsaEaSA0HQ8tTurn3
 2mH2fTMgF38qjAc083Uqhch1CH4IUJl7qVQ3Ltq/AdjzvAoHofrCkGlDyx8HS/vJR4M1LFYbapY
 XBZB7FCjKknCTgrQGsbZeA6JSWw4k176BsBRpA4C9JdZHlFprJYx3MLioAwzEbKty4VxXQyeryr
 P1AtCmgXo2ZunKfSd6NxHMQrE748efllqHgxwSOtEs9ZRmY2hz1wQM47Aejm0hh4L1ioP2pT54b
 xd4USxsr6whkanmaaTu9gCln15/V0CQX7mUPJ4zrJe1d2tk5WnqCcBaubPQYGHAIQI4pAO50jhq
 zgKcOsfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Add Crypto support for Qualcomm Kaanapali Platform including True Random
Number Generator and Qualcomm crypto engine.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Gaurav Kashyap (3):
      dt-bindings: crypto: qcom,prng: Document kaanapali RNG
      dt-bindings: crypto: qcom-qce: Document the kaanapli crypto engine
      crypto: qce: add support for QCE major version 6

 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml  | 1 +
 drivers/crypto/qce/core.c                               | 3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-crypto-07eb1383bfc2

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


