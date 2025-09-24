Return-Path: <linux-kernel+bounces-831445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C14B9CAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B32D3AA0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741B2C029F;
	Wed, 24 Sep 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hCmuuGg4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA94283FE9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757423; cv=none; b=CuOn15Of3bG1GU0r5/nIU1feb610rc9VB9nUx8IT4yuU5JF6y5KSBJJuC67vgPMWRa4Su5+P82kWpALwOBiOJnfjMjkbFa0/1mBCUt8Pres/ba75OdizR5l3dEM0JL5spZ9B8J+ipzIf1/XheHTri8nYvzXCtsS7BHoz87lAkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757423; c=relaxed/simple;
	bh=6CSXlCZwl15wpvD4tnn4P+V9Gu48Alpev3pff07bAQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAWFiUXsQNP5GJXorwEot0G0DXXCI3fZWm0wp+NIc/KWssne9e5nka0IErab91kQfL5oDNQpdMqegkIOXhOMvcB5kWMHw7nDzj1vCU0u+iuY1AsfhYSAOF0EM2mqQORbHSzztQBSMfoLJc7YDqQRU/C+zAJNVWYYpyKC3PSmOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hCmuuGg4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCeTWG016436
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h74aNk7MomfcVP5U+yv9902v1K2etOMKqpcz1QWtIc0=; b=hCmuuGg4/qdsfiPd
	AE/M7auyVnfT186ipCbKXHTq7rrgTWqZgJpLIDOfHGfISNDBBmqLmZDedy4VHZeZ
	sMSfc62lionCadMuzCZXIoWy1dJrvg6gqWYWFD254OPk3N59rG4gMovj1CqKVm/G
	XlSW4qANs7+AEL8/2v5lK6GJkSF362xuDhwitkEUszFsTMJxpJLsCy5Hx0PCjcyd
	qhvlw+aVQmXKrvtg2A4v9Yik7DU7Zms6ya4XERBKxiy1PCJ0JZoCY/oKdOIX+oEr
	4WTMnQqT55LiZSV++jm17k/5gIhMBi7BW3m7pM0kzuVlS5kefb8isKTjnM/FClwy
	rPlzTw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhvtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781044c8791so3236b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757421; x=1759362221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74aNk7MomfcVP5U+yv9902v1K2etOMKqpcz1QWtIc0=;
        b=p43OsN2l7DeHC1nwX1KlGRF1WMGi4lY+uFCJJXTzXWUyY/R4zZR93XRZuqBCc2tALC
         CVFV/OBjvyoM2SGrMUuKejAnaEj9b3nrFJct9Zs8vvz3LAGqyiPUjuCHHOs2t5+kZ6nO
         Y8DEsGOswviriOC7VKxuYvM56QxfAjZuRXT48Or1BzOpBxRXCrBtEKZwvcCL+IlCZyBB
         iei2AxcjR+SEYO/dQdCZTLs6ExTx+Q1auvh/LGZtxWGevCduKt2glu6fSa+zI2xxdnxe
         7N7zAgQE/zGGopywyFa6vkenQlRh5HyqmMbVAWzNCH7F2Hpw/WrIMG97L3HeA/tNKWtM
         /Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWQSDmH+TmUrjtKZGn2BGNbeUJEPWuKzZ+kz6reVIaK0wDMypHwKeNKtB+HibzMDQKGsQcDWQleJo3X9W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqQkCLc+DRpsNLU2pcd0dQ6ddRwRlFJgauP3+oeehDUO8YQrd
	nznu584oO7Bh8k11RpgN09dP8DX7/HbkYCqKwZpUhyRvORATNdVobUAdHWAq2/todAzjS/OpHyb
	Ed6UN8SqXU3cxIS46MpXVg5vSOZiPgu9BMPvBNa3LToM3nCs3947wKopXI9w//TstT8M=
X-Gm-Gg: ASbGnct91IjHqXpkORpu3XsPQpfeBgnqqRK4Hv6XKEo3AU3VWnOjM5Shg7WuCAnQMdS
	bHL8L+WQM0hS8CGO1Cts+c0wT6LqyNS97gCkumjJrgUAcxlJwP79k17P586p033EyVAmmbROMQt
	zbESePuwaC786I9sh1im8vpJsFKocrO/gA19R7Z74TjWUiOkbYtFLSAbfdBIEX5714d2VbSphHL
	8o5ZB9kDdxWuH2skWE8upGFqg4JiATuB9WGtQw2d+pIwd2BmWmHkfcS6KWSGX5tvAKI+UzyZZJs
	9NN6Dyoytycw6p/OeZ+MNAMPehgT+im0hTx3SGGcr5g9Ek9FO2PH3EIp4jFAtFXzos5DksQvQ2j
	Ux+oHtlcfKWy6vrc=
X-Received: by 2002:a05:6a20:7f99:b0:24c:dd96:5500 with SMTP id adf61e73a8af0-2e7c5089ad2mr1405280637.11.1758757420683;
        Wed, 24 Sep 2025 16:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdCe0j5CR4NDWA6456FRnN4l/jjecqJTFbVlhKpwlC7CmhUhcUtXBR9LkhZzDu07Wsd2uVKw==
X-Received: by 2002:a05:6a20:7f99:b0:24c:dd96:5500 with SMTP id adf61e73a8af0-2e7c5089ad2mr1405253637.11.1758757420237;
        Wed, 24 Sep 2025 16:43:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b64599sm192088b3a.70.2025.09.24.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:43:39 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:43:34 -0700
Subject: [PATCH 2/2] dt-bindings: leds: qcom,spmi-flash-led: Add PMH0101
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pmic-peri-v1-2-47413f8ddbf2@oss.qualcomm.com>
References: <20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757416; l=900;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=/+orHcqdoCJiYis1BeSN59ik+XCNFok4pl/dlM9EI5c=;
 b=z99WCkBgPuSR7Ka1AneTYCNVrG8aURUdIjBbvNJ/OjMWWtA9dLXxnQzPuwbV4fpBLrZvq0N8n
 tHxQq9Ww+JICGc5rCuQazqbUKGXQ2zHqaAgCP2wMY7itPMv979fla+p
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d4822d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RkQeGxZFYsPkH16At1YA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: KNDDAy5qH-jy7Aom4ZS2ucD0do_VImvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXzfnnkbyRp6MU
 wI1/tWvRNks2wyEEj2vemkj4aDWNgcM7nzvp7SfxMcPsWqPo0fnfw0rKtEAolGk71I6eWzxc+3M
 t7PumNQ/KfCZYIveAVXm1X7Y7L8qMxrNz4LOtYb6QIgLEtYI+4XZeC7IDOVVWMhpN/IAZau6+V5
 IuBLmFSnjoOyPwvzwE/n+cgTQDgaRbcCcOA5wTlALnxA7dYivyOAAiyTRj4yQ4ZkjOg5+Ptdubf
 b6ModWB68YyaNa7uQpGzijOazFvT808wp59WGCJVMs+/jy2wzKueZh3170A4uVkTCXjeMoaReyz
 DrXdUeH5/NBBEtnzXenc+S4OnHtgZuRL31C9pffSnyosWKCDoTTf5Za7yjk+Yedj136XNW//JJU
 gr4U+kMI
X-Proofpoint-ORIG-GUID: KNDDAy5qH-jy7Aom4ZS2ucD0do_VImvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Document compatible for PMH0101 Torch and Flash LED controller.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
index bcf0ad4ea57e..0df3e460a792 100644
--- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,pm8150l-flash-led
           - qcom,pm8350c-flash-led
           - qcom,pm8550-flash-led
+          - qcom,pmh0101-flash-led
           - qcom,pmi8998-flash-led
       - const: qcom,spmi-flash-led
 

-- 
2.25.1


