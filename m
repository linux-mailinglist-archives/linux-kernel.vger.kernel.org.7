Return-Path: <linux-kernel+bounces-733826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D8EB079AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57E7189DDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63E2F3C03;
	Wed, 16 Jul 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dd3dqEwa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92D2F1983
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679236; cv=none; b=QoGv1DQ8i/G7TJV9YgUXnKRy5us6YasHDjcBZUbOXr4+IJPFVQGc2ZEGXQ5102yUzgR6CfVfVMRj7TQOAX6zcXFMLTApIffYAMmvAPkT6fZAv8tOGPCcBHwcRo/e6XFi1VVJKPWhs0fhaLs5tsPK2TthFqJYSW7IKGce3QD5OGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679236; c=relaxed/simple;
	bh=chDPFM/gKsIkCz2uGNvcZOhIr1MQ7Z5mLou4364bH0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoICkVvVWBl+cC9IV6qNhxI5QTas1+CjPO7PStFSyXeB86cuIdx2JSRN28VHaEQzucTGruFOTP825d1yVD3BZh7PCpZNh07hpZ7Q2qmLgiT5zw7PjtWyFJCYUdYQj/LAtJnZFJv5mezbUhgyMKNhMgSeweARTKQWQ/zWLHyA5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dd3dqEwa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD1Ln1001712
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7kAuUkf6gQb
	DezV71kriyxf9UqTXCD2n6sjYNZXCI88=; b=Dd3dqEwalwMaSVaOto17nsBIFoH
	6ebpDriaGWfzFfbkizbWCF2szhaSXCssVvz4e1Wu3A0fxnoVKIexgQQ0bqsS2N9w
	4lxUhw8UOiFpRM9oqNPQIS4HahBudi1UPwTjn52gEzB56FCR6FAirmiAN97IKSnL
	21aIOpBf4SW9uYAwpk65WIale+14rpyTkg7HCohYie7WQkH2Br6w8A9EtL1/m1bX
	DFiIKcOT2I+CoSyw57emozIqUVi8vNrgKhOMn8W6XmyFzMKQ29HE//XI32qQtGJb
	F54UXcoNvSINmemrsiBah+R51igZmYuGkl+79EcR/l+kgzTgczX8u2tLSZQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug384kf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso27725b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679233; x=1753284033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kAuUkf6gQbDezV71kriyxf9UqTXCD2n6sjYNZXCI88=;
        b=Bg00nP/hWlbhRYA2KJquoyUrOYEY9LNl2zcFgt9NlwUu0C3cDAEEx/jjniHdQSZOq7
         459tzQazHeOAHaxA+0lArg9JmK/Pc5LmyoXseOjDqX9XUqpsdJSDdt+NNTWgzqnHJIKp
         q3+6mQTQnG3vjrwmfdDBpEThus3ypY+lNPpizISd8uvPLzr5rv7t02OW+TPWhoBL8l/A
         DBn2mEqpFjfTfpKY1vxhLMTqFZfVyMIPVgnGFPXnZZS6fT608epdvV4xl6T/ew80kq5O
         iDCBo5h8Y9LH03Cz6FrsDSZmFhCsmy85dMQuJ1JbB6YMxVni11pCQ95o4i8ctsfOqoYi
         1Fyw==
X-Forwarded-Encrypted: i=1; AJvYcCUtv2qgUfBlJHXApR8WpRMuIvnv6HTShvqzzi0pGSKR5gro3ypBHYTVDhql/60Mx/F8Oca07S1W0b9RxsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pi+HZEgIYYqwq7ASy/0aL985AlFQfm6o5zY4x3szIGnpHBL6
	GfkY50TnVyy9EChD7Kjnrr3RMKvfhJNpiAveI5CA4IsyyjtbTmfWfAqYFHUqGZC4sZuYnE1H1q7
	tONvOVU/UZBn+ke0ghrYU5sD7owY9Yaw+yMw2HMAqAbsNKnXQm0Refe8ILPoY+4hyoKs=
X-Gm-Gg: ASbGncs5qXoUr/6Xc2MheNKOfQniKsIiG+3nrR62d7PL1pGJw0u8/to8Q5QYAAsuZPv
	YhdapRYS7V1y0q3r0NzPcW7URWMcJO+0Cjl2sWmlZ8Y9Ot3zG5xRJfhJDdyOsGIiQpDjpw4kuMG
	R33GhEo5KoKaNT6WGA1gHXaR73qQApqWNCtm7EjIeRHF7n7nNt0tK/puOSdEjk+YtiCrdcbbLbR
	CDryvomyVA/jLge0ihVthf/ZBWrO+MjUs2vmP3OBfwTL1D4P6TWtuXV1zHxqjWJgdtc7jQihsfq
	mzP8DfOtJoJcYXfz/NTkl4gy5RE8Vse40trclR88X/Ba9sFZhgr2H3AyZ4G2UtG2AEAcXHDj6p+
	CKyCRiTax7H38Zzh8rBcHt/z1LS2q8xo7lnN6AFpUTJDXoO3iBMWz5i3kbe2F
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr6035099637.31.1752679232435;
        Wed, 16 Jul 2025 08:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhWL+P4EBROycejWOKigF482qtWta4UpPGPsaG5+brLj9Rnoju1DZYfQKmw4BL4DfeSQ5H4Q==
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr6035032637.31.1752679231921;
        Wed, 16 Jul 2025 08:20:31 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd8f8sm13912054a12.38.2025.07.16.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:20:31 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: clock: qcom-rpmhcc: Add support for Glymur SoCs
Date: Wed, 16 Jul 2025 20:50:11 +0530
Message-Id: <20250716152017.4070029-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX6HkLisUzXodo
 iDTl5i4HRdzU1mJwZgzvZNHGZqaJ1IvxnwgfmscoQQtNTP1hwKts3lKM+DEXSL78ylRVSSaND59
 SlI3IZ94QKgHy3PS5wu8W5KIFih5gJZFvdtFlrqyjNMCTI5u6YJyYHzzim8tCU2IV1POdIEnzS3
 Hu+Rs+cK/HM+mhDx7s8ZGwSNqvH6UH9t5ZPH3evB9NzFspdDlaIhqHWqljgSpkQYlqUa+4VIbMM
 /sgkcUejkYIogj9fVrR3uifuN+E8miC6zgBT46aFpqbGmmmwIMAkGYcQz3K+sioxTR5K+/tyaSE
 2kcNHdCqgIth5JkuEG119CGGpNT3d38onuE1ZfiItRIWCMYDsERxljJDjfF4OYJGIxXrR371u4j
 zY3Te2c+NES1aVfw80FG1rVOvLIDCU8Bsa6rxamyNj3ePhwlTs84TmXi52gusjRkylxj9jC8
X-Proofpoint-GUID: 0Z6WY3V_dtpS6b4AqUzSWV6oyN2pvxAQ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6877c342 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RYbyPGwfGPyvG-E-d-UA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 0Z6WY3V_dtpS6b4AqUzSWV6oyN2pvxAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add devicetree binding for Glymur SoC RPMHCC

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index dcb872b9cf3e..27307e7bcfbc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,glymur-rpmh-clk
       - qcom,qcs615-rpmh-clk
       - qcom,qdu1000-rpmh-clk
       - qcom,sa8775p-rpmh-clk
-- 
2.34.1


