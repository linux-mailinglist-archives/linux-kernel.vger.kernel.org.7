Return-Path: <linux-kernel+bounces-822169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9FBB8335E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAD5621141
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B172E9ED7;
	Thu, 18 Sep 2025 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9BfRA69"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED842E7651
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178178; cv=none; b=Y/XQkX+Uqj8mvoXRJDdAKGlDhxyiDTc/8WWk2kqAd3W51AZ4WjEvRNAia47DP2OM0/sV2RrnI4cTl9JSg3SXjKS3F4MBp0oFKzQrq4EWlUPpfAgN9SCvwIhuK7d5z65UekDn/F4ZqKeymJrkWUjM0fyJMBq9qPk65uAN1fT/6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178178; c=relaxed/simple;
	bh=fk0TNQn7BAcvjE7TYECp7NGF/xF5QIeAzGhAHgip9EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQ9QWhgKV40kxHljdxmnjCImo7f58zNABxFPlUc+iyiJ+yq7sqINyCAFu/FoZGlqpcYV6qPtOXzyGD5uFR7dKnwgjZuD8yuRR+vm3lMYbhuJOwuyOS/04Lj9l9TO4U0WsTXnm403Q7HKvdKgFgkbXUOYURS1vMgImEVLCdkxBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9BfRA69; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3GNNJ032456
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fAG+r6LmnpS
	+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=; b=d9BfRA692SB+8TNxXbttaf9BHiN
	ZUUVcpCjH8U+uRDEsNOuw1hcbZYKGBuI1OX5rTeo+/nRAq8+A+h1z41HQaKdZMgX
	W4XaLwXuKNGKL4wd+adRS9jzZqImRNWVRnzlHRQ5Qt1fJ+bO/3XdbKQOzgfNmSsc
	DPxVl5yR/QiJ0m7blSCRD8bjS6p+XHpQGhPItGIB68TAeKZ7nk6+o4rUqeKKGtM0
	AUlfNywzxCxxs/uCNcZ6pWYDU3b5eXZ8BaIsOA0xuNezpisovgz1DAO+yuN5yLrH
	cGlZgVMMi/bj6P8d/FMEDfd1F2mJmC3BMNNf8WSF2HXvo//D9deYeVro2Tw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyn8f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7779219ccc2so823347b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178175; x=1758782975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAG+r6LmnpS+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=;
        b=Ly05qkibfyh/R68a2BM6+LOwRoqJdI/wQyYMl9hbwRY7OEl8l1AGOmaG28e3NsUvyN
         57QtBg+WQrbHzohYW3UUKuAhFW0gd/o3gEpk3MlZ1eGBDj6U0HMqEiWy80RVP0jetloR
         TyMVulfA6zv5r7Y55BvRB4KSIkpirbLh7l0SfPHqxwJhlU43GxbA1EkwX3Ph+NH5OGKN
         BZGL5Jj5SUJvq+o2RupshevGDqYm/QZgL6Z7C5eZwwlZykA9Bqi9aUlrGebqUNAOC73E
         3iG6rY80F3zcMJxVz/AS3xJEpo4kMxMrAW+uzXUT14ZXCKeeoF6nXkUEWia/iylv79dA
         V48Q==
X-Forwarded-Encrypted: i=1; AJvYcCWebpFrkgEuIN8NUz3YeGkh4PDX38OPJpXwk46TmguxfGiA6Kmh3GSWs+LTOG12gVxtScO13VIgKgYcGhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUoqrmUswmQvAlG3R/ck8wB8xJchfnmQKSP8XjUvWj1KcSgNJ
	ffmvZFNFQBBBO7N1TaHUjUgPWMhY3vNn8f9eGmFA31X8J8NwfeOYvkxPjLzys7fQYY8Jwk3y7FL
	VIAJiS7q1zYhrJQEZX5weWZQcGj16GshKbcPdP5LUNLA2ETULkX1rbrvYq7S6rbNrjqI=
X-Gm-Gg: ASbGncuVt5N6CqF9DrISfhiXmToWxenTBA3ocSXTbii7yQfBdRLIebuuKkUGQ4EX4i8
	XFvZUpgW9Lqdag9Jg/VMvlMjau4UHM6fhNo5sAym5c8d8aqW+SoniXThd0KLq7jdDfYgU1glPyz
	i7/T3SvdhiabZlFIapCp+Y+B587mfaoPyzeJX77RDFyMTZ5lpgsqrQa9c+dEExFl6NbFYLid3mb
	5Umz0yiv0aRncfu+ZUISKGMuX1vob+iSrg3lALwW7UHLamT3TOCYuanKiZ4BciesGfq/k8H9DBg
	YWpC4qmHL9+ZC7b15jMhJ4Aro5ppz73By8CexCuyGOuqXsIeMQNgOkMqPiOta1tNZ6Jmj3klyeZ
	m
X-Received: by 2002:a05:6a21:339f:b0:262:c083:bb3a with SMTP id adf61e73a8af0-27aacc777ddmr7314908637.60.1758178175025;
        Wed, 17 Sep 2025 23:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwmQHzJp7VE8ev7s4YG3cL5g9fuuOf9VLXesHRyVN7cCsWP8urp7NG7z6HzTDcRNqhM1WC+A==
X-Received: by 2002:a05:6a21:339f:b0:262:c083:bb3a with SMTP id adf61e73a8af0-27aacc777ddmr7314870637.60.1758178174617;
        Wed, 17 Sep 2025 23:49:34 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:34 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 4/6] can: mcp251xfd: only configure PIN1 when rx_int is set
Date: Thu, 18 Sep 2025 12:19:01 +0530
Message-Id: <20250918064903.241372-5-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cbab80 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=Zr3td6iJmGh5AMeZqZgA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: fw1MrJjM1mAAUVIC_gHBLEN1jwOmC67B
X-Proofpoint-ORIG-GUID: fw1MrJjM1mAAUVIC_gHBLEN1jwOmC67B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9hHDIywV7I2V
 6nJMng3BgF9x02nkmvn8oMKOjBU0Rm50vaoZZGsOT+I0TtEW+wK1KRhkXvWv0AzIh8oa0/TZLSk
 6o0D1n/V4J3CTUaxctq8GsTZD0PeBtnbAPsW4HahFqZLaUojijkpRtrto3HsAsXdCNveOXG/fG8
 oumx09CSVzZuRcF7eDBu307utQX9L3RVNTj3vlOpxk7GhSnVUAnAKp7UM2trubis8Pv+PAr3hZX
 0JD2P94v/vt1k8/onnfnNk0bbCXUTLTwblrGZiAWnH9UXsdyAEjfT4Noj1cKTCPL7l6xtJd1OPb
 gAZtlXjfnLRtzu2DiRYHCvbolTL4bdU2GRrlbfoU41wyvkBFKySvyQinEKwRklBkuhLgvsW7VWL
 HPhcJPc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

When rx_int is used th mcp251xfd_chip_rx_int_enable and
mcp251xfd_chip_rx_int_disable function configure both PIN0 and PIN1. To
prepare the support of the GPIOS only configure PIN1 with
regmap_update_bits.

This way PIN0 can be used as GPIO while PIN1 is used as rx_int
interrupt.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 +++++++------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  6 +++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f9eabb1810cf..ea41f04ae1a6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -608,23 +608,21 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_chip_rx_int_enable(const struct mcp251xfd_priv *priv)
 {
-	u32 val;
+	u32 val, mask;
 
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input/RX Interrupt
+	/* Configure PIN1 as RX Interrupt:
 	 *
 	 * PIN1 must be Input, otherwise there is a glitch on the
 	 * rx-INT line. It happens between setting the PIN as output
 	 * (in the first byte of the SPI transfer) and configuring the
 	 * PIN as interrupt (in the last byte of the SPI transfer).
 	 */
-	val = MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_TRIS1 |
-		MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	val = MCP251XFD_REG_IOCON_TRIS(1);
+	mask = MCP251XFD_REG_IOCON_TRIS(1) | MCP251XFD_REG_IOCON_PM(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, mask, val);
 }
 
 static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
@@ -634,13 +632,9 @@ static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input
-	 */
-	val = MCP251XFD_REG_IOCON_PM1 | MCP251XFD_REG_IOCON_PM0 |
-		MCP251XFD_REG_IOCON_TRIS1 | MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	/* Configure PIN1 as GPIO Input */
+	val = MCP251XFD_REG_IOCON_PM(1) | MCP251XFD_REG_IOCON_TRIS(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, val, val);
 }
 
 static int mcp251xfd_chip_ecc_init(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index dcbbd2b2fae8..bd28510a6583 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -335,13 +335,19 @@
 #define MCP251XFD_REG_IOCON_TXCANOD BIT(28)
 #define MCP251XFD_REG_IOCON_PM1 BIT(25)
 #define MCP251XFD_REG_IOCON_PM0 BIT(24)
+#define MCP251XFD_REG_IOCON_PM(n) (MCP251XFD_REG_IOCON_PM0 << (n))
 #define MCP251XFD_REG_IOCON_GPIO1 BIT(17)
 #define MCP251XFD_REG_IOCON_GPIO0 BIT(16)
+#define MCP251XFD_REG_IOCON_GPIO(n) (MCP251XFD_REG_IOCON_GPIO0 << (n))
+#define MCP251XFD_REG_IOCON_GPIO_MASK GENMASK(17, 16)
 #define MCP251XFD_REG_IOCON_LAT1 BIT(9)
 #define MCP251XFD_REG_IOCON_LAT0 BIT(8)
+#define MCP251XFD_REG_IOCON_LAT(n) (MCP251XFD_REG_IOCON_LAT0 << (n))
+#define MCP251XFD_REG_IOCON_LAT_MASK GENMASK(9, 8)
 #define MCP251XFD_REG_IOCON_XSTBYEN BIT(6)
 #define MCP251XFD_REG_IOCON_TRIS1 BIT(1)
 #define MCP251XFD_REG_IOCON_TRIS0 BIT(0)
+#define MCP251XFD_REG_IOCON_TRIS(n) (MCP251XFD_REG_IOCON_TRIS0 << (n))
 
 #define MCP251XFD_REG_CRC 0xe08
 #define MCP251XFD_REG_CRC_FERRIE BIT(25)
-- 
2.34.1


