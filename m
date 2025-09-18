Return-Path: <linux-kernel+bounces-822162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E02B8330D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0891C814ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42DA236A73;
	Thu, 18 Sep 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq1ZLBeY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C825761
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178156; cv=none; b=CZWmqARUYGX9oBzH6IkMaqj+kdxi2ZvdLDcnSuWy5zPzgPBqoT0RCY6SDp5B9cNnoF0+OxxbkW/eIH1wYToEVWA+9L6tNYq1t63TNhWeZt6rIgm3WAQJdF6qVm4MW5sqyRaAgAlM2ojc5UpbX/AYHLcDchEaqyZ8zuD03bY5uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178156; c=relaxed/simple;
	bh=ErcDCir/FL2L27V2yhCvXo9PV0YbnBMQYjljKFP6sN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCjew2u5Uotn72YSyX6NOQcN73q9yWrEFtjavm/ps7CyNTyfhR2wCUdJA/oFYkBUOGvnzWoRGABhEDDmy2XyARMGlcnwWcchGzmRoJyNCo2WwyJ9WvWX9ib4oqczxTeAI/d48eDgIuRL2QEnhfRBNwBem5etlLRyna1UXe4USbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq1ZLBeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMDGkB009462
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oIn4sFdMvxF9JDi10QHzfu83QzlIJxyUB2t
	s4/QNXqI=; b=Fq1ZLBeYlag9+wqxoNVEt/DMXQGYMfkrk/3sfP/PP+be+o1ojAf
	vkEthibH226hUUW22oI6qSbzxDId41hBM/VXmVZIwQdZdtPLQhnCteDg9G/ByIN2
	bN2f2zoU6XweTnylEhNe8C/rjt/1iFRA0LF2wRpPYIXhNNLxzwINLW2MoP7KdaeO
	6ITUMnPUCzMDusK/aw6QMm/Kh7uvDQXCwZtTN2GeUz5Ag8eX7dNBS39aIjq56jDZ
	yXkQ3B8pl+5mhulqVaZetsW6HJnjSSv4gQNtlhQZIuzu71rJQRpdz2MlaXTbzevH
	o1X9Lm0mTWvTW9R+wjOoXPSNwQSsgeJMRrA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1wbmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b52047b3f21so438688a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178152; x=1758782952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIn4sFdMvxF9JDi10QHzfu83QzlIJxyUB2ts4/QNXqI=;
        b=KTrmvgnvaUB2aRhhjUngJ9Yt1hoI1r0FerqhTub/89zc88zjSCZQI/wkAnwi9pvP2j
         xUhevKmG8zxDI8jTDCr36upeydIWnSVDbNBBk3P3T0fDp2Qm3JmuZZvrZHfbeIr7JkX1
         UqEWtw86xjOdbvezsZ3ar9d9UaqCzJs8IKalA2MfkhHS/VtrPHuukFYLCzXWE/+qHyMj
         IBCHS9BM2kIVfdPKz2IO98WvQo95tekvFBfLt2bIcINoN3qR6bUMYAO/MQ2DwGm21vIQ
         NCA8YJ5SSm2zdbu/SU//psBOiOlFnVjdingWFZwBqAwa7tY6KmOJ780NvTqxg9bOgqZb
         4XUw==
X-Forwarded-Encrypted: i=1; AJvYcCVFHHUcCZVqxxxlTu+qH/Huv2FwMr4pOestmpkt+UywJ+wj7KEFQHz2Ypc3QXWw7IFopUxFISuaJFjKU4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMMKQ+FA8MKt+FH+A9G64EBXLChn6Km1ntQAfKssG/UEjADP0
	POh2ioGI2IqQaHgDDNaZSAuiqJ7NESm+FqUf1bsgKUSronjXJ351eYn+oJLhCwIvVgyxvHB8zVd
	eQes7Ya1o30qoTshWvC64F2CuxXh9Met5mSAarXr19WnKb/eQWECyV08EAlLM7f+8sB3PVPBNir
	g=
X-Gm-Gg: ASbGncu/YYlz1oMoCv9uyYHXN0x1f9nUOOHCmLKfoupmi20RmP7Rg9wJuD8Sdf6AbiY
	giLki+m8EKlG0nSHVQEfetcQCqQnkusLiRibryFheNst/r1wsm90xv2lNngNqNT3Z1lIKvCSxho
	k/rR+Us34zCtQz/T8j6Y2rnlinbZubsype5BuOfQn1AaZ0ZmIEMRKQl3E79ROvsmoiJHBdT+OWz
	wzVLpx4p5882XNNOud8e2exC+gRou/uJLyA2HZ+foPrrXVjgclJ6ssL3b0bt1t9e2p1fuopibEO
	XSqybe4t520sTzvNz8elw/YKgqOwP25ih1lN5SWfQJu4/tCUZycPfNEOJy7AvLypXxQXqVIJlOs
	u
X-Received: by 2002:a05:6a21:9988:b0:24d:56d5:369e with SMTP id adf61e73a8af0-27a9303eedfmr7041375637.3.1758178151906;
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4ZviaMBDQpPBzymkzbRdb3vIBqhk21yMuf1H3uqYvz9E+DUhiRUnBAG+10J0W1XlZwNOlmQ==
X-Received: by 2002:a05:6a21:9988:b0:24d:56d5:369e with SMTP id adf61e73a8af0-27a9303eedfmr7041357637.3.1758178151501;
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 0/6] can: mcp251xfd: add gpio functionality
Date: Thu, 18 Sep 2025 12:18:57 +0530
Message-Id: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jmXy-Brk8z2MM3-Mm4jbmKbNSs8U6vdA
X-Proofpoint-ORIG-GUID: jmXy-Brk8z2MM3-Mm4jbmKbNSs8U6vdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwHc9P3ZaKV9p
 3lAp68Rcg0+d44u+HYaqDYQdqpkmxPdc03xt8Gn0qppkoHB7DrUMnW29xvzG69ZcAGmsnWD1EvU
 08y5QxdezmAVG9IlXKO/dQOkTHOdQoc2snEyUKV7EQK1lcEzEhiczb6cWv73zKDcbxFIzIvWX5q
 WK2e7+Rdl1/LyR82cHswlCKZfGF+3YLl69VuxPrGUpsWO2Xe8pcqXB49QF94LvtHtlz3GkVdy1w
 T/s8rLc6DNm7eRnBHI2AyOEwg2lxgAnjGZDPpIA6ZIiqmOg4fI+UzvdJbH22D4tISZ4COwLnjBr
 Ke0FAj7WoEchTSsc82Xev+/D3UpTV+A9vQ2jhQW8gY6nhnxgN7R3WEwcKqfKlgUoHF076bMEt5m
 deSg0+wv
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbab69 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=8f9FM25-AAAA:8 a=Do27b2NNzWYMqhJ2O6UA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi all,

The mcp251xfd allows two pins to be configured as GPIOs. This series
adds support for this feature.

The GPIO functionality is controlled with the IOCON register which has
an erratum.

Patch 1 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-3-c26a93a66544@pengutronix.de/
Patch 2 refactor of no-crc functions to prepare workaround for non-crc writes
Patch 3 is the fix/workaround for the aforementioned erratum
Patch 4 only configure pin1 for rx-int
Patch 5 adds the gpio support
Patch 6 updates dt-binding

As per Marc's comment on below patch, we aim to get this series into
linux-next since the functionality is essential for CAN on the RB3 Gen2
board. As progress has stalled, Take this series forward with minor code
adjustments. Include a Tested-by tag to reflect validation performed on the
target hardware.

https://lore.kernel.org/all/20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de/
---
Changes in v4:
- Moved GPIO register initialization into mcp251xfd_register after enabling
  runtime PM to avoid GPIO request failures when using the gpio-hog
  property to set default GPIO state.
- Added Tested-by and Signed-off-by tags.
- Dropped the 1st and 2nd patches from the v3 series as they have already been merged.
- Link to v3: https://lore.kernel.org/linux-can/20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com/

Changes in v3:
- Implement workaround for non-crc writes
- Configure only Pin1 for rx-int feature
- moved errata check to .gather_write callback function
- Added MCP251XFD_REG_IOCON_*() macros
- Added Marcs suggestions
- Collect Krzysztofs Acked-By
- Link to v2: https://lore.kernel.org/r/20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com

Changes in v2:
- picked Marcs patches from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
- Drop regcache
- Add pm_runtime in mcp251xfd_gpio_request/mcp251xfd_gpio_free
- Implement mcp251xfd_gpio_get_multiple/mcp251xfd_gpio_set_multiple
- Move check for rx_int/gpio conflict to mcp251xfd_gpio_request
- Link to v1: https://lore.kernel.org/r/20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com

---
Gregor Herburger (5):
  can: mcp251xfd: utilize gather_write function for all non-CRC writes
  can: mcp251xfd: add workaround for errata 5
  can: mcp251xfd: only configure PIN1 when rx_int is set
  can: mcp251xfd: add gpio functionality
  dt-bindings: can: mcp251xfd: add gpio-controller property

Marc Kleine-Budde (1):
  can: mcp251xfd: move chip sleep mode into runtime pm

 .../bindings/net/can/microchip,mcp251xfd.yaml |   5 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 292 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  10 +
 4 files changed, 355 insertions(+), 66 deletions(-)

-- 
2.34.1


