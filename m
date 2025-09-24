Return-Path: <linux-kernel+bounces-831389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF963B9C876
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1111BC3E28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9D28B4F0;
	Wed, 24 Sep 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGj2TUpa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102527E1AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756269; cv=none; b=t2LaaVIr7EjeZP6tJDEhgkHKA7Ap8aTlFxZ8UU0kIhMMrE2dYIzw6to2zKaFZi77OYLHOt3l7MND0DZWfZHnhOzgk23I4txjemEbIKGLs5ys6Jh8nFJGEgK3Kykjo/7OYUOnx4GVvu4DxBi+ytJcaoTXv++IaQkCWTQQ0Utk+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756269; c=relaxed/simple;
	bh=mTfVTgvSGDQYS4dMJifAjU/6hmANPLDQIL/o0pGn4sU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYow5xLOmbFMDHsknXFJ7iSBPMPsFednfWFSv4U2ZZPeJkDj9uMEsiox08xa8lWJdnu4lyi13NbA86QQjK3RlLnR64B/f77WK21NP4kK5CnYF50K9xXh3VtkVVjce54R0jNGcKqhGNbIQlq6AP+eXwLDQ2rLBBle1H7or5Gpt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGj2TUpa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCwCPv017456
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KZNciS4xoZfftnPqYXRVX1
	EdzFS/TnwpUdZGiTkk/xo=; b=EGj2TUpaVGpZ5tAQWyrIQHlWmzqhr8hTR3EeAH
	3Odz2mmt+PPa0ETeRJHsSIy6R6Uvv6thRgcaGYChQv/1ueZi7AnAeqnWfc3T9PWh
	jO2A29JEQEgMl/etWTwNqvRh8HFEdAyS9HAWp4HxofVK8BX+qMwxXOkyYAsB1oOV
	qEeOoglBrbBjLlTjGDUny/jKYFo0TATGJO/ocML0dYcYfB8X51HGVPH/1BeeM9oV
	5rYxix3D+eIbaA0Wv2KqWwaNnq7N7vCryoXubzyuPsxKoDIhDxMoxa09AJkGT7RQ
	TQnnH+Sw2z2MvDp+49BPjJEc0aQ5FNy4kVDHIj2uQ1HQS8Rg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjybv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2e48a829so535264b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756267; x=1759361067;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZNciS4xoZfftnPqYXRVX1EdzFS/TnwpUdZGiTkk/xo=;
        b=u5v0KwyC6+qbO8jpaCOf0LMfPwCc4JBSvxbXXgM0YWRsdJyq+ekrw6BV1E3k7Xweql
         k7NMnpIysiBz8P4wJrPV8Co/PvgkO0ZcmwqxwSYineVNGzzf2HrbwPYNhpkDdDdVfdch
         7F5kCcebiOS/EvBgH5/z8cqO7Ux4l9roB3gjflLto0x+/QdkwobIi50rZu185MRmRSTI
         HvUiBvCoVPj1ZyOazYNZfLcpK0DMEpmIgxBgAdmv4h3nKwZxQkx1DHaMlRwNJkMG2QsQ
         6ZNYkRHh0IYscYiroIYm6K5dI986c1ekmta6f34ocAhhsNiEMzyWhusqfUDFS91ZQDWU
         S6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1C9RjaHdQCoS26yGPb/i3YOkXC2gWk/xXJoIFthp5wiqayeuMgI+k61N69KHZMGvmewM3fDMDrcwyuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEz90QU2RmuY7SY+sDe/ECZPBrXubn3m5tL6MVmH3IxTcaaJU
	EXiBOnVKA0cFbCjPSq1nyco938hn7P7YeBq73T4KDoVp/qwyLBMk4iUyz6XptwoupOGioX5h/yR
	nV1593+0gRE5/q/grxac8Lfpj1UOw0RAyH6gIgNaGtcf7sYJpJBquSTwy8i46sCDMwog=
X-Gm-Gg: ASbGncuGAUGyRURrgTjFdupLve/Ls1sQQCRPm74MIlb2VZ/4J6sk7tVz+2l1KtGZ3y2
	DMDRzdB73l3bfK5ROPFYhXWK44mjt4RAriKu3ZvsZZco3BG5D0jpk/2uKyy+8+/CVX8k7qxxs/E
	WO9gvynGUxhf+i7g7S01xb0kPdMW9XuokNRB/llijKkI7wyq1qwn6cpJ8i+JBXn0jyv9/favPtU
	VIGwVaRjJ4UHxsB0UyHXa4zlSjeiEMRcGF0wxuwlebPZbzwL7OtMjCIkoNcIpMzVQEPjecCS5So
	t2B7czeY2hUgGANkI8HGLYGgmk0Vq8vj2B1HYnMXhfNbLFYLNNpFxeo+N21I5f1RnnEdpP9tRcZ
	wnz+5/8ojvzpDIcg=
X-Received: by 2002:a05:6a00:4f89:b0:77e:cac4:446e with SMTP id d2e1a72fcca58-780fcf0c79bmr1746152b3a.31.1758756266780;
        Wed, 24 Sep 2025 16:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8pZDBqMmBGUYCq5JA6tZWwAcXM/OTJCyVhBNbzZ8u7884rMNBKHjRuMnFGdMkg5lXMtDJQQ==
X-Received: by 2002:a05:6a00:4f89:b0:77e:cac4:446e with SMTP id d2e1a72fcca58-780fcf0c79bmr1746129b3a.31.1758756266349;
        Wed, 24 Sep 2025 16:24:26 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca6dsm194173b3a.8.2025.09.24.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:26 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:24:22 -0700
Subject: [PATCH] dt-bindings: watchdog: Document Qualcomm Kaanapali
 watchdog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-watchdog-v1-1-fd8f3fa0ae7e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKV91GgC/x3MwQrCMAyA4VcZORtYi1Lmq4iHrEvWIHYjGSqMv
 bvV43f4/x2cTdnh2u1g/FLXpTaEUwe5UJ0ZdWqG2MdLP4SEj7rim7ZcpmXGQc5RSJLkkKAlq7H
 o57+73ZtHcsbRqObymzzJNzY4ji8O+rzIdwAAAA==
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756265; l=1025;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=mTfVTgvSGDQYS4dMJifAjU/6hmANPLDQIL/o0pGn4sU=;
 b=vh2YAAt0+hRveOEVepPOWT2IBEK3RQNJ2Hj16CUoLVIIbLSbTX1JqcSp1y8XZUqj4oKCif9+g
 jF3FskmXJ/2D0SgUkwxFnVNQ0Pooa28J/IXvvBuVuS6WIJ3ijbC9S2h
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: RU0BFzc7dJC6UwOWrUGfQMtgDvAmCgcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXybWoed8EI1QV
 uBzJ2MDDJkpgEljQMYJHOqGg+ZU02Q+qvgiLEDiGjS0CHZblYgD9DIJZQh4p2BWVRfh9zgHT+x0
 zPRRTT8GJVBgA04xGGRM8wlz4d+nn1nuYb7PMr97Y2T4q6HO6UlKOUp+DeyMbPqXWXvKUXAWZgP
 rjqNyPFbiCtSTAYZGkYgdRDGFtyUAtGR06yIvfi22KAk0cLllJgbK02qHDPQGT8hudit4PG4cj7
 FxAhGAFcVwDhrb3ZIzWr8VD4jOPeZAjyKB4BfQyYXtUJfEZEK5E4L1sDkijn4DxdJ0erF12b8PW
 JeuxNsH1ubDeVbdllQOAIbeXdFCRsbeZ/Ytrq2DeWjBFA9eqx1W5UD7ZFFcBtFEi39Y7iJVN3RN
 bbhzrd4s
X-Proofpoint-GUID: RU0BFzc7dJC6UwOWrUGfQMtgDvAmCgcL
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47dab cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eTIQKQMR0C5kcNTfsesA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Add devicetree binding for watchdog present on Qualcomm Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 49e2b807db0b..54f5311ed016 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq5424
               - qcom,apss-wdt-ipq9574
+              - qcom,apss-wdt-kaanapali
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-watchdog-9f42faf7fc17

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


