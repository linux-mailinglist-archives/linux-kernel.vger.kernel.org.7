Return-Path: <linux-kernel+bounces-831446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E3B9CB02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028CC1B25740
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2A296BDF;
	Wed, 24 Sep 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XaHniraV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58399283FE9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757447; cv=none; b=S+k6/FRVVOdJf6rogDXfPQeSjEbhf8RttyTBuWe7ahCZhJnRXRDlpZL0ns/i4V6PZm59IzACQV+dTL/deVcsigIhc0jTgpNLoEEgUY91a9qchr++8fwx5DgY1tapDE3O5D6m3X71KBUuKaWPKo+fkrav9ha30daq4SZXObPFcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757447; c=relaxed/simple;
	bh=ST7vOr29TDO9i9RP8IbSrNRO7LJ0DeNCOw/G8G8H0bg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vzc3naWYPCm26msjLCIfYquoznIsldPNTfreg6Yyjl7W1FK4WWs+/qooUh38y9twMuuNTY1g5i8i7GWGL8/QDpnwuPdqzH03dEwrw3in5DxLE4HdW5HXksEefdxEmT0yWn8JwQfJNkoW0AXGM5djBlQSA4jUYp5FfgYuJxG/0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XaHniraV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONeKIw027919
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=obb4lO5267TXksQoWvciqc
	u5t4/H8CEqGSV3VieHmJc=; b=XaHniraV7tn4fi/dWo9Td/Sp+rB7RvsDXrkSJJ
	NmtVDmvAWfn3XtJs31YegkWOKpr8tWQ/YxnRfOA29joHSbMR+xsTNQzeh+WV7Fqk
	pK1YSjbmXfcbJa8UttiXy21nVZYbDL/TTfhL56mzTqC2WU7uKxFaxxtYEnIn0fA2
	JTP6MNF6wSrACBAabxtRNiBYySm5CiK/MMjNY7a37D7boWA3r5+1mlbMGNgbiTdD
	CrbiNL9unb+Fb0Bmg7UEpB5wEjKdhdLT9SsMHX6HSNEVnSzR4B5PaWCRz7ZPkaR0
	Mvx/khd8m5Fn1kT/eJ2P5Z8/gzB0fEgrp8Jg/o2766SW5cWQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxdx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3305c08d975so335538a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757443; x=1759362243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obb4lO5267TXksQoWvciqcu5t4/H8CEqGSV3VieHmJc=;
        b=Hcm9Ugr9b+mszQ5PnDBKvzD8oAfhOAlTi+El4h7EZUEli7Wac32rtGsWI8mc6kHB90
         kjhtOuapWmmEFNLxzgw4UtGRYE0O61xzeoymUJKIIaVR0KwqX/2opUp4uvWmFtdCySfx
         fNQjFXAothXOEBIiue8I3vyJthhYaUamI1QWkztAtQUi3ZMQs7gKtkTH5UOwgZUrzWPh
         33NXSQsJoNhtLJYvw+xPdq95QOnkjVx3qhInkUF1Asb6Ey6vnzR9LpQ3iD0pSiKpL1KZ
         2XfO0Y2gfKcQpKhpXiNrGFKfpc1fM0HtzBJ44AzF2+M4cexzmSTDHIPA0GOWRZEyXReQ
         SfNA==
X-Forwarded-Encrypted: i=1; AJvYcCVZUaKwESDGfcDj+VoRrfAC8M6Zf6E1y6F9R2vbDNieLC61RTMbsmMOSKMFsJq9YNwvelpD4ix6saCae9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVqUfIirlhLtN7cTqlYjE0p25UwIQCvPaQOJfTRAiDXeR4Lfp
	tk8KnQf7RqQMg2c6Oxhp5b0r8Mu4AxMZ6THcUGUOCtYeTLx52SukQBZ5AtVXJF57c5Dk/ujo5lK
	yhs2PjGL4w6Sc3VzPttonKnJSVFmTICLz6PM5EQ6Kl8/+adnAe+ImKMMn9dCCgt+knVE=
X-Gm-Gg: ASbGnctCXJuDu/pJB0Hu6eYKA0hAlymuGpRxYa0tQiikQ3WXOB7TjcTKOPtEZg1cTl+
	jLPyN8ksDFqVKUJdpM5VY35BNQxShvoMMTAucsdxAFZAujlzzkJpccDNsoJj0QMkRhGyHu22tAb
	qZTcZSf54fUk8LHudztG4l1zSlIhJ94vAolPn63wkU1PSYx55DVUNhQF0GFLV+VipoAUFiGMOhA
	R3pSKnplmr8+xAdCeVMpAZqeLwbGR2/HGmz37WjsnSNzqQNDRh6Wq6l26DJkym0sQH6mrU6KMst
	wpuGq5XjyhCPtJ92D49XL8UH0oHWs7anipCrKjKsGGI7F1DDsJZgcg1fy0xEv9d2J4hayNljKu1
	6FuVVZaFumk9WEDw=
X-Received: by 2002:a17:90b:1d92:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-3342a2c0fcemr1354048a91.23.1758757443242;
        Wed, 24 Sep 2025 16:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TxC32/4r64+xVuO2ZdIoa+1ml3rjX8myfrrzn8Wie45klXhgJClDIMGhR2jHJwNtuCEvmQ==
X-Received: by 2002:a17:90b:1d92:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-3342a2c0fcemr1354020a91.23.1758757442765;
        Wed, 24 Sep 2025 16:44:02 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347453dc35sm206983a91.16.2025.09.24.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:44:02 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v2 0/2] dt-bindings: leds: Add bindings for Kaanapali PMIC
 peripherals
Date: Wed, 24 Sep 2025 16:43:52 -0700
Message-Id: <20250924-knp-pmic-peri-v2-0-32316039db2f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiC1GgC/12Nyw6CMBREf4V07SVtAUFX/odhUcpFGu3DXiQaw
 r9bSNy4meQkM3MWRhgNEjtnC4s4GzLeJZCHjOlRuRuC6RMzyWXFT7KAuwsQrNEQ0hCQH2vdyFp
 XhWBpEyIO5r3/XdvEnSKELiqnx+3FKpowbsXR0OTjZ/fOYqv/FOWfYhbAoaxLUQxN33eDvHii/
 PlSD+2tzVOwdl3XL5aP7brKAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757441; l=884;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=ST7vOr29TDO9i9RP8IbSrNRO7LJ0DeNCOw/G8G8H0bg=;
 b=rBA8xpzV+0eQ4YNHV7IuTbVY3dKaHO80pQiG0Ef78uayvrSTLAr4lmDSUQXmke1FCU0vC3Ghy
 iH9uJwaCn6GDSf1Fuf9ILkZ9MUOHjO5BErHSEpKrqkyrznC3eAS9AwZ
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d48244 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=w1v-58I_rqdrY5_ohRUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 21lH7WDFegEK8P0NoQUenBmOtiIiAAay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX0bNJOLDyCCEB
 S1tViACRS3taMxdRHGXOVn/1VNhM2BNbpb0nC/z2T+icyyVDO0WTU+5DiXVcIW+W0RX6yzmmsEo
 ILCjTjJLmfZTNqwCw7Rk0iyKq/wam6TJ9M76TfVQkkTc2yzTufhqPafPa9yguByX0LrCRrfudJH
 1Ofi8wY7G2jDxUsmP3YTyaY/48GDwNtEPcJuJFnjDJxIWMBrw8JwLbd9v1thpsMejl5s7YAGziD
 Uq3sxsIStXxi+sp7/1or9/f10V70NgRWlJD47MLUy1DnPhyebjhA1z+ZL7DLa3fyfjb8NoL9fvN
 CjwswLwhg2l+9lahb+vTy4x+bqj/lzfl07PZbYOgVnFnCWB2ZY/660ZiNyT+ik2woYtmoFvd9Uu
 2Voytuqd
X-Proofpoint-GUID: 21lH7WDFegEK8P0NoQUenBmOtiIiAAay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Add bindings for flash led and PWM devices present on Kaanapali PMICs.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com

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


