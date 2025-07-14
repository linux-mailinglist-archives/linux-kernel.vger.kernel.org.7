Return-Path: <linux-kernel+bounces-729249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4CB033D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A167AB549
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AAD19307F;
	Mon, 14 Jul 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOO7aGet"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D91891A9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454223; cv=none; b=h8Wu82rrrcDWhexnaZoX1PCO2vHKG08OE+P9Hc44/JxZaqSvwC1M2OBFa3PGhTstZXsgHyqA60UVYUAcj4gMxuruj6gI/NRWo07Wzj5OI1hVKjH7KqngoqwHNKMN7uVNeo/1UpM6zoXJaP/5x0knjFTfP0kG+2/fT2CngNOgvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454223; c=relaxed/simple;
	bh=6ti6WK3uD8rSgx1+MJL0OTBiXFAh+a7/YuzQpoRdCak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGH5qwPc6k7l9e0mIh0o4U+EE52j8g/Rc4ZAx7eAEsbdKDrwaPMp5DeP+hdLlzG3ZfUd47SgJw1H2A64cTRNl7DlNW4mkd3qVqLBGI1cEthzPbJIrVY2BKqxi1e+TinwyRf8xvHg6Kp6+gZx/gPNeno6pA0rg2ufeXlYnH2clWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOO7aGet; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLff2B026371
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=; b=kOO7aGetcaOOn6EB
	Dd7pX87VNVIXtpo/51n/LvG/uFmmmpkLbdVj7S/Y9a9ZhTOK4ld2Bjnjrzl6IUzq
	GmCpxnf/jviR9foVmIJj2CtNvPOOiyv5I36XiuGm5UuuwNghtWV/3KXpP+2bL4I8
	9nMzl2y+YLlDGgywqnKV+fkahjtIaZFOEt5tE8KTNMXuR35hlsBSYQ5t/yo04DrM
	IO7f6N8xUHnQZwZNzJ0ENlYTVkvLYObRtZuZ81+ifVBVv8G145g05Sy6wgiMBU2A
	5KkPqJx7znQLXJUtYZkC+7yKhEB8Nve9jrd704GrpVTfECzhUI1WfjdrDR8ucZpj
	o0+8qQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvxaug7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234fedd3e51so35802555ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454220; x=1753059020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=;
        b=h/rOJrNep3HZD9QU6kVoVDE9i5Zr4rSnqPEs+sYsCtJxmz5gZLGN24KChOnNRFuGS4
         uNCLKA5ujG0n0hSiSfZOGmIpYn1yshXJnCH3TjpU6R/Iuy3hSqhK9f1cxEPxhxezq/e8
         +lB8xHkLFIpe47FRE1OTMbY8wpNgMC+KYu14WhfkuF6lx8lx0R8EsMSMjliA5x6c1V3m
         UCmDKMAbmnHHED9SeNiM4O/6ozEFi/cFwwppIfbKIN5YKmzWQnfGO4xukAyCGYdcWicJ
         NBcTykgXHQMBD28hGsjngKE/nvq0pk2ybKvlR5Pym0pheojCygysV/v7hSoA5eBGxnm+
         lxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9dPP7pbZrfZx/4l/nVhU/Ukolr1f4U8fHe3Rg+1JExMLNBddKp+6FwuEh6f2w9vje504otdroHGhO3v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5efzPaXZXMMROjoW8nuG7MsYf1gSam89fXrz26g/vtVxpuXK0
	UsIPBxepSi1svlXmA5Wg53xY7wcDyj7kfjJKgVD71okQ5/OJIgON+rs2V8OXAwq4US9Wzte0Y17
	umsgQKespAcrbIz7MHn8y9HQjbZTQXS5/7XiHX5JWfkI0UBA7vMTTc0cybK3nd3xhBw==
X-Gm-Gg: ASbGncsZ7KLR/z2R7D3XzuHNn9Y5N5RIx/YUAgTqicEJbxd9KIH0TJEl346ltGrb4iW
	tOn+jkbJYHWQ1l25btmTMv5QyheDst7Jh3VjKZdWNblxr6plhXkwUq+dALFNjJ3Ye8AgIiXLWVE
	ia1BOvzRfBf/f0osLOuW8nLDnraEFNUBcLInHrKiTOv2m2QuHIT0SiE6fJLtUskY3cU3Eirwa/Z
	nxcxK7JHt2Ch9m9LLH4KVS+ioQf0UJQu8zbQyO938vRo/VeId8zQbALGNdh0Y77fM9O25ZotNY8
	j2iX3vTRe13wy0Fa8Rc5R0EpujGjmtTFCfSP5nyKgy5jb2Jj7542eguo7q7grBRukt4wEzdBDBl
	876TKChsvJCdCS9B4lwsxfGU=
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151935ad.43.1752454219754;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/mJiuun06sM2rMzoQb2znJePjSbapMiG5DW5Qq5P5rJEhFEAxnwJjdWQYDnBpyFcOi0O4OQ==
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151455ad.43.1752454219307;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:18 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:13 -0700
Subject: [PATCH v6 01/12] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-1-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: tmAKP1cJlT7xVflGHGkvFoeuhj2rXnlq
X-Proofpoint-ORIG-GUID: tmAKP1cJlT7xVflGHGkvFoeuhj2rXnlq
X-Authority-Analysis: v=2.4 cv=achhnQot c=1 sm=1 tr=0 ts=6874544c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX6bBy/TFMIyH9
 aUdIfiTAo5L5bMAq9uikVf6m3hUf/r9Nr5LCWo2DEJl/Y3bPHWXpyE/UjOCcFU8ZUxOP6em3usB
 eBNdKKYokbVXnQRVSpPejrBRM9ANtLfjwyKy0f1uMASYameGL2uM9vS/cto56LuAso4scSRAllh
 blWXvEagN2e/CJ75TKkUGO4UUEMGMLTRv/Yda++LciLGpDGj8XQ/XYbiXt3GvPPcldL44Yd7VyB
 6VNJhKn4m0YKOEzIRbAzaETuBJWoa8zrvHG3LigVhuhwJVerwiJXI4A8vTTm6fqdzZI7Lte6wwO
 M/72NdNZtYX8YTjf4ectCjFs88EQ90RMA/h22uwo9cUBE+IIFbLWjMmO3b0hAOBAR3v3uwhGFKq
 p5qgj9pW4Mym8/KKnXaRWx69t/WrOreoPL2pn2/LpU+imrwYef4kw/vZw9PBlK2O/cETen2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad..133447f25065 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


