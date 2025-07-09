Return-Path: <linux-kernel+bounces-723131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30AAFE349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3EA4A2015
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC517280305;
	Wed,  9 Jul 2025 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNz/8eR8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B8279346
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051286; cv=none; b=jkB0NLZhV1MKUeCGs+qDwcnCcNcELMGuAY4Lwo49VYNS7BgIxFYRxR6tPJfTAt9C6/UW3qIYw8502a8xmQI68SwlIPglm2u8e9HkceNKKKyROhDLK6y4nxcWKD1Yi6e8eZ1K3AFp1rLd+N6dVV4bRjAHFxdxk69IDwUxiawec6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051286; c=relaxed/simple;
	bh=Ikqhwjl457+pJfoW3Wqu4dj/AhK07/s4aW2ywahaukk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6Ib2LjVgzjqpZLDycAbWmawSKvc2KwjRP2WWIFOxBrbz92vuMB//Hs7WWkmhSyMOIC20WPlhDoC29G3QfU4J16EONDndsEsRFG0zuQwR5+HL/JaWskGSZVJkxz1TtWJzEl+tptpjW5kzf+T6jRX0J4D0n/ApFftsRVtF0sHpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNz/8eR8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5698Cidk030335
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 08:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bMGiynhWKxSPuqq8fZmj2e2BYO/cDjhxVXX
	/4HP0dVA=; b=nNz/8eR8lZ1FGvMqck1Y2S5lME7NXLQEOwFeoKfTl+Z1CPmkXeJ
	m8v/BgumpvK8sUg81ALVLZSvQcL80+3uPIImUqecJVOTNNGEjGjgCbHP6Rpfr+cI
	DSFyQ+7K4akT5AFkqYDVXObienidneGnm6/FWcKQEwY9CEMu0mp5YwzoXz3nmyK8
	ZxJe9h4QFuxxMMmpdOSRryYgJli5ESGufz2aTEDpijjiL4SZgH9pbHoZ5Ibcd8ev
	20ZVJRjxnB0Y5cmKEitR/tD6K+u9czawb6o6HqsiKhfrzWGUehxseepWqkSMceYL
	m6yzJHmca8RapRIgdFRB0Vzt6JWE81tm7lQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b113nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:54:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7da0850c9e5so331271585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051282; x=1752656082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMGiynhWKxSPuqq8fZmj2e2BYO/cDjhxVXX/4HP0dVA=;
        b=LFDE+/y3a+JkaN5ZME1bFHcYxr8tnRoUK1wcaxDASlC8PDM3vTvWQCrYLuLY01Jige
         pc/nBcv3pLkO9ZTtEp03qoYxz2NomYjOr4aZmk8qTRpxVSgxTc45wYfnUHWjR7I69g9Q
         Q5rljT2RZPkOr6xQff/kgsJnGyYHba9HofLTVJT/Yue90jBwP+oHJFcYJs6vk+zZ56k1
         P3FCy0tYrZNVX/V1gGvngpYIFhLFCgK7PcMrsmKYB/Z/nwGkbkEVsPWopdnYIY1Rbx/Z
         16vDBTSdRCaLAsZyF6XDPY7eUEgRfqnxXLGFtK/HH7UlA7fOSY6RgvID1cPhpcvLPhcK
         PNDw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6WbL6UhyHiZOyYDzVP4zf6qPL9w7SEn6FaOLCwBRtyfNGXcKhlXF3AfsQ9kanQhqv/+UYMwft6OgekU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+JTrhqgf5USbixPCROFAj7c1OfdG5yORdcZAHycW6fvEP8g1
	3UEouEwaZqQBwSe3BroncFn3jrDRzClSDkf1toMxExQNnYzWajXoaHjeJFgPRa7t3yfvQcXkjfd
	WpfVsSZvX2WedDTn+AvWVuoE1gVftZ38UqPgs4Y4R8yRD/0ZQG64l7g4XOyMKP0635YI=
X-Gm-Gg: ASbGnctoJdTMd8f1eCVFIIwVr16CxhWpMrLhd0dL28jFOFZ6tH0lRzgAotrMAKWB7fk
	GdOqPrMudZS0BilpnEDy2zsDiDQKtjZKrDGDqFDwS3NMCOpHHAmi8ixnxpa1gynXtfCNQDQVKJD
	igwl3zqjVuGoysdSLiETZ/e/o6djmzaxeSd8+zUm2IkZuwMUdJ2xA38ERhHMehfji3tBNy+d0Hv
	FEgihi4hBj1MtTDm+Iqxen2pG5K//pEo2hm89ClI8EarQubDG4fsD6S62YoT2rHadpF98uPPn5E
	jRGW04v6NpUI4GTElQiywEqow9Z0kOVUIboHohVWBFUkb5aAzudmS1+vxg==
X-Received: by 2002:a05:620a:2a07:b0:7d4:4552:600d with SMTP id af79cd13be357-7db7b125507mr230425185a.7.1752051282489;
        Wed, 09 Jul 2025 01:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGruPdO8SfeX4B3rqtkzSwhb89RfhR5zaYsiZv4ITt4IGj64rrbJiYQzyRkwvHJUDoEgEdw==
X-Received: by 2002:a05:620a:2a07:b0:7d4:4552:600d with SMTP id af79cd13be357-7db7b125507mr230422385a.7.1752051281908;
        Wed, 09 Jul 2025 01:54:41 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:3186:b629:3be8:a0d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285bdf8sm14997874f8f.87.2025.07.09.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:54:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org
Cc: lumag@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] gpu: drm: bridge: anx7625: Fix NULL pointer dereference with early IRQ
Date: Wed,  9 Jul 2025 10:54:38 +0200
Message-Id: <20250709085438.56188-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686e2e53 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=bu6cTATwPyPPLne475MA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA3OSBTYWx0ZWRfXzj4sKTw/jXet
 0FBx3CLUjlKfLy5QZkR8seEjdPwCdDNZCHxH8spswmolEeiOJUeCrtbzaPF3v+3cyngwsDBS9ig
 zSOn4ZDKPO01zp5RBlXXGMrPJgfHzedxAOTINy4Qe3JQ9CXGpRTpR3f6f6TkhY0mAXbjdktZDN3
 wBPz+4kj2iIGws4WM4nr6emB1ELwzWR2VdqQgL5bgtv7cr6k9vKfbUJWugocT5g4B4GSrMT5fzG
 XIlnzw4hBKYcXBVvaDZXhwy4bLrwSB8N38HKHMaYyD3PqQqQ6M7YEphmoMHyjOtoDYXVRUP/Jsy
 IxaDGHWkltuNmLsZws6pPFyDKF+kab0Lw0uBj6cTw4cnwKw476cJ/D4cMP8xb8fr11tu5vjNLoL
 az/W9JAPhqH5PXmts2dyq9HvTDwvj7LGjB5U2ihEklM+2Ub+DZdOvCPKDR13ZwQ6czDoIQDs
X-Proofpoint-GUID: gYlsuffke_v9dsnfNVTe72w174HqCMVE
X-Proofpoint-ORIG-GUID: gYlsuffke_v9dsnfNVTe72w174HqCMVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090079

If the interrupt occurs before resource initialization is complete, the
interrupt handler/worker may access uninitialized data such as the I2C
tcpc_client device, potentially leading to NULL pointer dereference.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 5a81d1bfc815..0d8f4cc05387 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2678,7 +2678,7 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(dev, platform->pdata.intp_irq,
 						NULL, anx7625_intr_hpd_isr,
 						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
 						"anx7625-intp", platform);
 		if (ret) {
 			DRM_DEV_ERROR(dev, "fail to request irq\n");
@@ -2747,8 +2747,10 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 	}
 
 	/* Add work function */
-	if (platform->pdata.intp_irq)
+	if (platform->pdata.intp_irq) {
+		enable_irq(platform->pdata.intp_irq);
 		queue_work(platform->workqueue, &platform->work);
+	}
 
 	if (platform->pdata.audio_en)
 		anx7625_register_audio(dev, platform);
-- 
2.34.1


