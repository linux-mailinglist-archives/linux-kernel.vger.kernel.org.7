Return-Path: <linux-kernel+bounces-834109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C81EBA3E52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2531C02377
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEFB2F6164;
	Fri, 26 Sep 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDvH8+yN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA0267B07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893430; cv=none; b=HA6xmcKj96N9misZ+d9uiIMCddlpDPfA+fCzRaIXoE6+/3FZaJMC0/YzTCHmvzTwv5P5lZetnEtIhqNMAY7EmIlC4Wf75ftHN2ZwzSV+l8xHESgYZ/fIBSdAKluC9rxWTswVBjwqGCA/4iXK+0o/uoSxoBECTvdTHZ9a7dRkApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893430; c=relaxed/simple;
	bh=sBL5VFqjA7dAOE+3fWCfFfyRLa+xg3ZQNoJJ1E1miiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LJMbK1za9pZyp1XWjjYIgh/W88wiE2tJHzj2Gw0FjwbyVxePMXBr+VbzRqVHpxpiBZqxevvpXeMneRaUTgfCGvOQqPOV1OlIME1cADn0TRnM6XnIargcTg9ujUStrj70/H5Jc7pIGWHYLenPYcEfb5DFZ4yHiPpG/otaQboG9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDvH8+yN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8w2vK030416
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uoKwV0Sq51MNwidirUMq5Xk0YmJQ4zILgpI
	xT3e4Fyg=; b=FDvH8+yNzzEOiwaXKTY8sPYfIV8PHWJJ1jDY2JYdvEQphR4FCZ1
	naDyl/KhmBWPSkMWSbNDcMYCJMddHfoeVoZmfWPEU7Ne+envdUOvVFwmf1yfWpSX
	9VE3lBM9sG8nPokgnMWH5hBu9Iym62wzx8cBbJzz8GqdtRclAG4Wn/1oJliXTneQ
	EMeAK8Q0V931PWLUnuh4XBU4HZuT5zQWrgrdjBbyIo9zinqOThj6c/0l3LT0xWga
	tG52d9M4VGR+xojl9fURcPeHr02paFtCFihu6C3Ed8nC0C33eiLCnBX9krwatCMi
	RbYDmIWtTmx2RkEwSMhXJI25i0Jkg1zuXMA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db322y45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso1718587b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893427; x=1759498227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoKwV0Sq51MNwidirUMq5Xk0YmJQ4zILgpIxT3e4Fyg=;
        b=IG3maf+7YQPCaO5Y3od6sX680Ngq5mC/ONpa/EnccSedOWwbZ9HAy6mvejAe8R3dT8
         hMiRMqnPcZKWkyoW3RpEDiWVezce824AQXSmf7mb1VT5oN58yBBveKG5vOoQf7YeeLMn
         35yCmp8VRUfkhvGQgsu6BNqoNTE92wDuujeIXibW3VmSUCKY1BfPddGVluP1XWV0qTKJ
         rjNfpnDDAMUXPusQDOhW4nT7hlOaBXaQrtr6d80sUO3sHjooKlsosGNRGYqXRvXmlm8k
         v/54EsCRSse+7/02UNixJ28aT/zitIG5zSg7zM9lYcZEFXilKxPhDq8r76PViO+FhpR1
         x9og==
X-Forwarded-Encrypted: i=1; AJvYcCW5EfvMV2/mR5MTqL/MrTJXIdXteCiaZFfIysceXynmxUXi5YfwovDOTrotPnCxAoDp3PxWciw9N4WmiWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDaRJFFAfx4i30JeF2h4HV0g81TZs8WCstVCxdwQp5mVl8tHo
	hl35UiwxXDcoRiXx4cI5BEo8HgX3kAc0wJn9ZI7NYr0Bpfd3CRiUbvAUrM/uk7Ehon6cbPhQXl1
	tlsGs6LFvgCI+yGhcwiTYscTTVGFKaEr23/1KdSGSQ9nnmCcPjJ1FzAjJ7s7akuj4Xtg=
X-Gm-Gg: ASbGncu1An2Z/rT/G0wsXvdmfCjr5R1nurEn9w/cX1gG1tRsorHRFRXV8yyKdub5Wa7
	yS12l8o4u18x7Mz2kY9wrQidiheZFxRCjvnwTxHM9i8zWmadzQAnpGVJr12rC4L3EF+Viiqgnd/
	JlpdGJscn9Y+4jiqe9pHIIhcl8FZA3hkjUIXcHLU2P/C9rv0h0JbUFcFIv+c8Qh6SNgHGNTm1iO
	D46dlam/QyLdKWklMd1wGiWKTV6705zqlWSHWIdY86Vo7QbZr7wkHSGcI8fd2dzF8KQFx8qPCiS
	sraQN/7eRTCXptP1+h1m9WlFXhtvVxOTTZcIOX2DMi5K2Mpvx8H+p9GsOukXgE10M5XQviPaNCu
	4
X-Received: by 2002:a05:6a00:6601:b0:77d:a490:269c with SMTP id d2e1a72fcca58-780fced43b4mr5805001b3a.29.1758893427092;
        Fri, 26 Sep 2025 06:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGumQSX5BQbxqGqsIJENyb3Nbz5wMeh4B8GMjP3A1nfNcTm/05iiJIt6Wzbgdo06eK/BjzVQ==
X-Received: by 2002:a05:6a00:6601:b0:77d:a490:269c with SMTP id d2e1a72fcca58-780fced43b4mr5804958b3a.29.1758893426364;
        Fri, 26 Sep 2025 06:30:26 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:26 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 0/6] can: mcp251xfd: add gpio functionality
Date: Fri, 26 Sep 2025 19:00:12 +0530
Message-Id: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d69574 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=dBwfbOYln0D7H48MSAAA:9 a=OpyuDcXvxspvyRM73sMx:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: ZXzhMVv00KRx2QsD0xM1xbKo6zmWCj9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX7FlQEfvYEU7P
 /w20R5T5JIyZ3GBMBl4fx9kgN/NW8XQJVCBaQBXyEFgVUc0POWKAcmLMqtW5Wc0i0rdGMChfeVr
 w/qm00C0p1f3N8zNqgaxgacM09IhfrtNUdzOvMXEkJ/vCdJersAPNLbu+mj4PbkqqjhYoJ2Ivcn
 UpmUPyvg/e1E1sCwwkbt37hQ8OLVKPkJE1GB4bOir/vnaMQApyJRVAdMKtgDgMrkumfNBGCw2rU
 YMjE4PG9K9h2jmCEW49h5E4mQzLOEV3OBwRKaVo6X1mqtY46D7nkQIgsdUpd0psONsl73qztjXp
 dXRsh3v+RdoOJjDZvZmf9jmeVcozMqho5Y+gWoRpviQZxkqxzzINVehoaVZ1oiKbmsGsiFpS9iy
 hqPQ/K4IB+Vik7zKqtfbm92W+7nTyw==
X-Proofpoint-GUID: ZXzhMVv00KRx2QsD0xM1xbKo6zmWCj9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

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
Changes in v5:
- Removed #ifdef GPIOLIB and added select GPIOLIB in Kconfig
- Rebased patch on latest baseline
- Resolved Kernel Test Robot warnings
- Link to v4: https://lore.kernel.org/all/20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com/

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
 drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 285 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
 5 files changed, 347 insertions(+), 66 deletions(-)

-- 
2.34.1


