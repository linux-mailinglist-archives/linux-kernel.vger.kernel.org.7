Return-Path: <linux-kernel+bounces-735405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 734CCB08EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B371C25358
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E572F7CE0;
	Thu, 17 Jul 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjGN1Juh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D791C84A8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761410; cv=none; b=tz2j6gnOkU/FPp8+Cluhjq4BKp1loVleJ7Zf7gY9peM/Xv9LV0auS540UbUKX5PzWdRAswthfP/Z5LjmvyDd2RxE7Wffb5eIDZbO9+hjCsssOIXTwdZaPZElZ+FUvM+6XDKEAXik6VSyZChhAV6SEk+vtlwmm2m4voZuKjcRi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761410; c=relaxed/simple;
	bh=h5BQC9mByxJDY26rU4tjCerVWmoNcd7LyS6Ii5OUcRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKdaKlQwDh7LLmV8TsKV0urZGSraEcWdhCk3QPUebsDL4RiDL1nF22D3PHHRqAMUfJAXtwESZpAg3V4PeeDNgNNfz3PT4NyoGUvnrgpN3lqgkIO0ViqWzd7+LCj8gSYaGFFjCDOhk43WDj6Jt/2cH6SkFKq8KfKQFX3WXWaE5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjGN1Juh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCROV8008515
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CP6Jzze8Me6
	quyVOR0tDc8eWtyKvcOPnSUsVWLWiMeI=; b=JjGN1Juhbvrx2DCkK48QI84KfNJ
	h9kF6Hp/RYpRTMPYyB0QbwYnxcTujmCSxGb8xoQ9m5ge0BFuvYyljGg/diZTOyuU
	k+M0Fc29hkezz3K4Aw0KzN2K2TbWCQlFYXgoiQd4XUa+W3/TX0qj8Io/Rq2P5DBr
	Mffyp2YK/IvKy4MNTkS0FNYjub6IvCqMf7VZ7XJRMrJySBs8cC+dFu62vPiAintT
	9TtDtDKQfAunyjvekbt0hwU0mt2mDCCCD8bvFUjX53a74qWkdXxMCcv0M0+a36x9
	DLXIkvBAakMJA6AE/U7Exrn2t93ojlEfofJvQ8Kpdae9zCrPANLe0PS+ZPQ==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb7xs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:08 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc5137992so8885475ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761407; x=1753366207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP6Jzze8Me6quyVOR0tDc8eWtyKvcOPnSUsVWLWiMeI=;
        b=UC8Kyp4xVCcfHAHBc5isK8IRX+zrljDOLzvPJV5eZ7ipgWM4L4y+nDUJrOud3R6o9H
         7UWdRZ4mzZSxdAO6KrGSG7v6YffozFiA+Lz1d80x+MRYtTn5pQMz7nbTSLBScTP2+Rpk
         M2bOqex/HMLunspxFaaJ+JVFabw18F4XcV2nL+yXUWbPsUcmR6J1lYy1Tqwuy1rI1L/B
         O0Li3fW/G5T1Bz9PHjs2hvDAMEEuk+EgZlteVkusoIjPaVJc/Vh73r02Xkbd3BizIbso
         jMReL/PD3vw9cI2OSpgPu9KIRUuwX1e9jcdAegGWwkUdZTKrkZyNJ92p3ZYpSRlDM/V6
         hJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU31Opd+3oKrgYk2yATQYMBdiJrwLviZ02XAkKxWla9dSE/3Dq9yvx0ERIGuGmmB5xwLiCOqGlLjDN7HaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldVXvh9caeUGqPNkqYd3t9btUxDjao2r6Chdub1OYnX8sQmh2
	6y82BCFkJsFMhfEyj7WnZgDxOPr1eBbUYByKw5AG4kAvd/FPYmOB+l3qwbbwJzQ+IvvetUI1oKN
	0mGLDbacEgfVHJOpKkJkZZBvGffMVzcbQQt1zqwPLK4bq+oTkhqWIIYUteGcQaBkiZIg=
X-Gm-Gg: ASbGncvIV23d2KkrsunLPc5aIbI1RjpMvZJqrg8y00azQv+iqgfwqgf+iIsyGZktMY4
	jwttTYcvXZC62V2gt4Nj5Glvy6svaNvNtRNbo1mfJyXo93+rEqpNAeHmSbqpFTgX2uNrcscrg1T
	PdH+bhgJTG79BA//u4FcjpfyntPWhOg9h3risHuoCrC8wxiIDLK6wCDMdthRpKhiasU7lPi5dPh
	KR+zd5RyLI9omN1vN+y2feIBaV/WHnwG2LYQtOKcYirXwbcYO2gfchoPbFcZctf1DRfM5SucVIu
	37iy8VNdGdRshyt+wMQbuKTpNTnVSCN6AMoSvrHZeUj80dzSqBAS07XVcFXqj7dU4w==
X-Received: by 2002:a05:6e02:144b:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e282e65b56mr66949405ab.14.1752761406768;
        Thu, 17 Jul 2025 07:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwLDzrUusnEpv0HUYrf1+V/UgFGINfO9sa196Vx7jwWsOTv7qAHuTrm2DCVfwE5RzjtmmlSA==
X-Received: by 2002:a05:6e02:144b:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e282e65b56mr66949015ab.14.1752761406251;
        Thu, 17 Jul 2025 07:10:06 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c4dsm1391452366b.19.2025.07.17.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:10:05 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 17 Jul 2025 16:09:10 +0200
Message-ID: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o1ZAKCSQ5QqlJ1EjtRWUaod5IzrXfluQ
X-Proofpoint-ORIG-GUID: o1ZAKCSQ5QqlJ1EjtRWUaod5IzrXfluQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNCBTYWx0ZWRfXwENLNZdYdtZQ
 uOP/JAnfk5WO1cSHofsG/bctvhW77vlXAzhUgG1f05XpG2sG/FQtPTnOIHJOVipLO14MA6J2E6U
 MJz9tSaP1wOh9fu+8PUth2mXuL8z61wV7XWzOUqoRHWiue5Dz+vD1kMq3Pm4hhk6zf3FSI06pE9
 3VtwotII+poxqR/NfBj/kBM+wq5DIGWwFBt518uM/A6zrfycxWAp8GOFQL/AoLNrYZs8DsTK3LT
 DtZa16nhjjovrb2mvwbip8lJ4C2ccDJoleu44GtEh+e2iXHfMGztSLD0ceZSPolP8T6RHv1Spyj
 2j/t4ynmxyNHkl/r8lCj9os9zzuUWhDo6ITTDJ32/vNr7WJF7oLfxH4bEHIGPg3jdfXR9bj1Tjm
 twjiWBQR7jUKCLlPpcy94N3jedZVTKZDAjzvTmMUoUc/QD4DEovHdraI2bL8t9tZSN1agLgx
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68790440 cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=x8YHxakxDffKOoiCecoA:9
 a=HaQ4K6lYObfyUnnIi04v:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170124

Quote from the virtio specification chapter 4.2.2.2:

"For the device-specific configuration space, the driver MUST use 8 bit
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
64 bit wide fields."

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
---
 drivers/gpio/gpio-virtio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 92b456475d89..07552611da98 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -527,7 +527,6 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
 	struct irq_chip *gpio_irq_chip;
@@ -540,9 +539,11 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
-	gpio_names_size = le32_to_cpu(config.gpio_names_size);
-	ngpio = le16_to_cpu(config.ngpio);
+	gpio_names_size =
+		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
+					      gpio_names_size));
+	ngpio =  virtio_cread16(vdev, offsetof(struct virtio_gpio_config,
+					       ngpio));
 	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
-- 
2.43.0


