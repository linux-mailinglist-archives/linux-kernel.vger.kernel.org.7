Return-Path: <linux-kernel+bounces-744510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DDB10DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DCD1CC829B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6742DEA87;
	Thu, 24 Jul 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJNUZb2M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B73292906
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367864; cv=none; b=j0oOMf9ZlPet2angkKlJy362tngMKZjmd/R9Jq5fpe4u81+Zm1XkXPaXB3EpFMoYHFI3zgvEy7XFRZsTB7Bc32/stMCzvdwE5rXwibP86550N/Xqjn8I/7KafwEWz4GtUlxa9Rrgg0dgSULt9dQojQl+gYZz+54foGVhNkhoCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367864; c=relaxed/simple;
	bh=i1slLS6fKL6k/lJjpB1zEBUCWviGCPU4GQH5Mw9K1LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6PVjwh49BA7iMX3rUq04CqNHkCqW01wyoj01L5CFRrvvv0QIGnsv9970emdiYV0fjDsbeE1k7DZc4jOxXhSjmrh6TaLJ2YHOOXIKdBFsUMu1D5burC/ZxatJK/dp4yPwT0bZAkxvzvDHUjAfuWz3BC8XlcxyDVpR5WoGyd15vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJNUZb2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9sx6R012570
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1/ClJdrWPfw
	KRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=; b=nJNUZb2MHMlazo/lHBTTkx7RVqD
	mKkM1XLOTUjLVxHwwO6ntu5k5NMLGeu3GfWfeExSsH4CoG18PYbY2sRQZwk6GepE
	kKJnegj1qnrJ9987J981svWV6MRgM5b4e7lhl0k3JWRT/0Jsiq74Mt0sZCIoFjoz
	WzunazjjNXLOQyIBbthmKudOX/0HTUd3oKj7vZgQOiexnSKaqCApet/I4mW4AXh7
	sJOhS0RpouMRpufAsY8vfP1N+Jkfgmx2iVB3rwgPS+2EazMnGYACZFEdT+/nr0Cw
	TXwOKZIkQ1w9XlFcueMIDTmmQENAQ9g9sJ6PbIXm5simWPnD8+deTD6gRRA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hy2qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:41 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53169549f5aso366647e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367847; x=1753972647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ClJdrWPfwKRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=;
        b=nhhUUry5vprNq2+/CgRNilHZ/RVAA34PXvu9GI2yiy9qiV0HmHRCrm6V9A15Avagmk
         iOaL7zKVS9xhXQRJF6vhL6ATLm9frUtXKVY+U1wXcNn5CjQyKSojn4Ije5G3UXa0jnU+
         jZWlII5SL62j1UgtPGrrewKzeQj1ffLSqC7ltcBUqR8PzXssmCP2NXOjtD/Fp2f9mIru
         JaZ5miyob9VnLkrVc+2l8UF13sk4Uc9QEkUxElnxa87i7ZGI79eSYLgJD/hsYjlAjyXt
         5dWMdg3NvO3b1mDEJGqr5086I4OlnPpurAR8Mi09n0x7pqKsKqV55p/ZcT1zkIdX1G2+
         zOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgqqYfhx3SI2Y5CtYSaW0wLeZLachwczeIHGc8qC+HOMQAGFMZAA11ku8DCuW5eRrD2SEPuNQWyL8PdHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pbWhDbu+msRTX5khtqwSpe8vhSk1mEuJIajNiORh9zhnvuN4
	2y2HMyZKfa7/uKCsLh0jYJOiE/SwiJGZlSMCScH7YcBn13ZokpfMTUtdyOHPo5VtkpCTEk9+FXi
	NvZTxseAv2lnuLYJETkmKSdrwDhWEvyfeglxQPOXLkNh7G1yQCO0zPCN1/EvhibGDk44=
X-Gm-Gg: ASbGnct9/A/OUcZPsK3j6L1Edz8aCsb+ZWxKu+ftfgmQMPVsvFQomN/4g2KgdUSFY7H
	Af8MGA+5NwZ9W9lbgxkqeJ1C52/VnRshgqoVFug2PKT1T1MAesgCRwhYMQhTGXj0/3BfTWx+35e
	8JN/UB6PIPFWEZYXF3qmnYPs+Mx85qILr0YqjA5uVKK/6uULFvM25MBf9uW3CAII9AAgS4o54jL
	ZC4HWW9twlzlImjMpz9xTpMERzt5SCJIadmVEO4awU3IjmEbCZtvQZNrAFAg+BtI342pnUoTzef
	pNcDc7T/4OCzHllrCY0pnPFZ9fPtAr7iuBCwLhKGRPB0e0rr9VRoWtR/dDhzWfyifg==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835502e0c.9.1753367846753;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFC9QgriQyVRZksDj1oB9q4RdVIKez8rc+GtzAgwBhWM1KCgo2TsHI0fM64ZXC1O2Pn7YiEg==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835474e0c.9.1753367846304;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495f02sm122856266b.2.2025.07.24.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:37:25 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:36:53 +0200
Message-ID: <20250724143718.5442-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
References: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68824535 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=x8YHxakxDffKOoiCecoA:9 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfX0BCwUPY+ToUB
 6wtQOfcf9W4eNWIxpOnDYe2p2mdq8Kzysplk6Vg+saQ4Y7tg4LcJX9fbN9T3s18aVirhlpNbtvn
 1aUy1JxRpMwKHLkv67FYGx/Y1PHEm1IFeaoUN5NYny2WOTE1z8IDifbL/4xnK++eWQwhEcEk4XQ
 7gref6ViTYflhatocI0crTNA0GD4ww6W1nfwX1Z5cGI8jsnCLplr8HSbuqQDsH1CZAiWisQGCP9
 odHBhfSdFdwJP8cVnXJXwudpOGMmAqH8BGuF7ZeHY5zW8AJpKY0qCPLqN9VqXTKSD4n16Nq/zOV
 7+CEtZb/s954DI9OFWSnx6Dpx4eIhEnh5sAOTReIWTh1GfnI7wDJYowMYHs6SIFrBAu2rhtIdJc
 dLE+UwQsFaX5KvZc+ZqFmQBELUszCBV8QztfWyhnwUMpKBAN5D3hVFeCOmosHabRGQXs14Vs
X-Proofpoint-GUID: YnJUllcP75SQl-l5fl1bYf_wNgyvOADl
X-Proofpoint-ORIG-GUID: YnJUllcP75SQl-l5fl1bYf_wNgyvOADl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111

Quote from the virtio specification chapter 4.2.2.2:

"For the device-specific configuration space, the driver MUST use 8 bit
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
64 bit wide fields."

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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


