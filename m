Return-Path: <linux-kernel+bounces-757410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B864B1C1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37C6188B8A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BB1221265;
	Wed,  6 Aug 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hewp2yje"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFA21CC79
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467779; cv=none; b=WEc+jHdIf6JeRrCo16AmseLFlT3PrAil+lBk6h87ajN+sTrn9wrmoYcanq94Y54OySe5VjElCE/EZ5Rzf1WQomfS3TdIP/mn/6jY1yY54BchCQxDEtd9uJue6zy1wpW3wKWqlfdNGxy4aMOsGUtJSQpwi7OlwryWjB3DKNyFvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467779; c=relaxed/simple;
	bh=8xWq6P9sR5iwmq/Cs+gKFsJ6jwcyz/+tb5GyYG9xnOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/almmgajo6LzCVMgW/Ogk26sVciP2RcNxrI36/g140qb6YA8rTpd+KXX6IyDHIKRyvz78yVw3ZN/zWxXfKccthI9mkwDHi/EOyqcrqy7H7Zko6Pp1C3/IhmxprItoWqCh/IwwN2eoc+uvoRqsu7wgRl0TreoXHm6i8w2sE9K9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hewp2yje; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766RCZt019433
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 08:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=knUnYiygC/glMirhYnFsBNISXjfP0z20npG
	9dhmwKMM=; b=Hewp2yjevG0elzb/Zof7MlkZNhDoXAm7hnHiZ7Gw7jsWIr3JNZT
	bCZeKtAieTgWvpX8hEv7esFEPQYb+U4kMc0EeQ8sea2hMqA1TXD1xL28t1de+xZ5
	Njk5lMf6djDj5qAnB4rwHIVHDFjLCkMvJYKLBqk+y2fuYjwuxLtHnwDX/QT6g4Wa
	ZSeenNdAcRYDV3qyWs44UR2CGfT/cQjIvf6ejiqPsI0TOPpwmvizFop4T+DCud/N
	CdieQgtUs5rt73x2dgGmOLY2JF8w9430lyJJFn9pdaPpA3nusVN+Uub5B25YEbVy
	j/pBkbj0sD2Yjc8X0r6FAusfLM3MRBiUiNg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6svfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:09:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31ca4b6a8eso4025949a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467776; x=1755072576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knUnYiygC/glMirhYnFsBNISXjfP0z20npG9dhmwKMM=;
        b=Ul1l9mWohVgHuvrjz/A79S9DC/i+wtyWXPCpAy+GImkzvLS9TEy2OlteVBbE9ilDCu
         Ae4zFx+QzmCRAHimoP4gb2BBSuqA4HS22c6trN61AdO2zAjSixb9+GFMOOFAjTulFgdg
         Wyo8vxWyKf3fNfvuca5qWFIiwQwZ/VaTJ4aL2pTJn+Wo1S6YSJuCKR2FadZQR6Z1XVfc
         eXX+fsQEY7b9ji10DX2DGUmKrLh+sWRvHycE4Ut/HoN09aMKOLYCWtkfYmOiSUn3PYhT
         HmWk2DIWzHPf+SsDioJ9mJL4UDIEgp3P3KyhlgRusonDsv8U7gAxGFuKcK/4fYkWk4TT
         vL4g==
X-Forwarded-Encrypted: i=1; AJvYcCXGSrokNCFp6bfoRwkXzD+c/3iZt9wNi//rgzy7mOVfAnOp3tqhC4LqsRaRQoCNmEQWQ94hP3nRTSsR5Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcr8yDAPbcIIIttoccWlWG4lbKS8KmITWWWQnPsxkIvDT7rZj
	XowH+0tBQrS+jCm9cBl1G1cMqc9bKqXfooPDXUUeEdq4UyHS+TE1XDs2zKpCFzyYJZtNLEEuwWK
	5YbRPskMMKTla4kYSes6ZM9ZUw14XxbSouRP7CYBVnttrU/z9poR0dgdk5jEuVBEHmRY=
X-Gm-Gg: ASbGncv77aR8xzxqwQVbKZYZH9hWqtDAFJyBmT3FmKayZpQPHsAChP9tNjWP9oq4h/m
	cE7qjnGNJ0Q2GwvRkV06EHVES0OURro1bH7zoKtMXPBNbaIoNaR8KmpUy3lq8BuCEI05dPBokKx
	c3+iKPdLS1RiwonoSW6dahA7Sa8Ajg0o3yZCuPD994Cg6ASImzVXvCUNlPOnoRFjVF/rXGNKsgD
	lvBcvIFu9JII+pk0V77oxK6Q6n3G896OSa0vOQ7UkI8q5WVoMSIZgDJmO3oAqiBZPN4r4MPUl3q
	5Cwtb/RiAceuhP/L0ewo7xN/o/1kTNGhFrKHHiuZzKP3ZqnYe3cLMmQYWHLBlH3kRPRkfD0mYxD
	2S3NX0elVfxpoeITFIB8=
X-Received: by 2002:a05:6a20:1584:b0:240:1e63:2dfd with SMTP id adf61e73a8af0-240314b5221mr3282866637.29.1754467776492;
        Wed, 06 Aug 2025 01:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/5kf0TugUCngV86DUYMPF7cCHvVqLqvFAR0R+lx9ixwaYadjeYK63pbWIUa3NO/Pp3Vw4g==
X-Received: by 2002:a05:6a20:1584:b0:240:1e63:2dfd with SMTP id adf61e73a8af0-240314b5221mr3282829637.29.1754467776090;
        Wed, 06 Aug 2025 01:09:36 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm14856195b3a.18.2025.08.06.01.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:09:35 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: tingwei.zhang@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v1] coresight: tpda: fix the logic to setup the element size
Date: Wed,  6 Aug 2025 16:09:31 +0800
Message-Id: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DOCS5888NgJx1dQxuIClc4sT8xtn0Tn3
X-Proofpoint-GUID: DOCS5888NgJx1dQxuIClc4sT8xtn0Tn3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX9S05Y8roGHpP
 8LdIPWbzbKKD0/DHNmN5N5E5dQI50AODy+YpN60XFLLcnr6Rx5lTKjnn253cF7yzMvVvacXcq0w
 4RrUm63uMAr1udr2b1h7L6VxoNEpXOrs7BWBrI2zh/P3qFxaZpzeupFTYytZegNcKEHWA7wFPI4
 QBuzYRNY+NnPnI/Y+QFA1LHNTBYlrL0Fh29Zd8zGvvNcl7VbtStIBoxZlWhmuhD1qZpnO7TXF98
 VRRCo9Wn8s5mWBbX3ywK/LG5Q+/AoTN51w5jZxXby7KDbkNE/5xcC8TYqNdm3zSgtnCKGxsjbRN
 eZziV6rEx5Iin1obeSAkG0mN1LOd4mj+wmHNzHHJ/ofZ4T8FFxAnWi+NJ4dZrqB5IARbzKC2+hI
 eoCJWrsF
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68930dc1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=eYArMgjR2MFx1z2CNlUA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

Some TPDM devices support both CMB and DSB datasets, requiring
the system to enable the port with both corresponding element sizes.

Currently, the logic treats tpdm_read_element_size as successful if
the CMB element size is retrieved correctly, regardless of whether
the DSB element size is obtained. This behavior causes issues
when parsing data from TPDM devices that depend on both element sizes.

To address this, the function should explicitly fail if the DSB
element size cannot be read correctly.

Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB element")
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 0633f04beb24..333b3cb23685 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	if (tpdm_data->dsb) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
 				"qcom,dsb-element-bits", &drvdata->dsb_esize);
+		if (rc)
+			goto out;
 	}
 
 	if (tpdm_data->cmb) {
@@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 				"qcom,cmb-element-bits", &drvdata->cmb_esize);
 	}
 
+out:
 	if (rc)
 		dev_warn_once(&csdev->dev,
 			"Failed to read TPDM Element size: %d\n", rc);
-- 
2.34.1


