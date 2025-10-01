Return-Path: <linux-kernel+bounces-838634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8294BAFCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C67CA4E29D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F232D948F;
	Wed,  1 Oct 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cs3KW9wy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9B2D836A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309820; cv=none; b=ObtowICEgW6qA5ilVXIg1RfDHZ0s2/SnWjO+c1KjjAW/j8UIIh92qzcefAgUqkkCJrt34vhAW0/NphmoXF2xBUdrLAd3YlQqao2PBZOfvJrztKLrp5nhED4tcVna67FB8RkLyi1vgxZELBCdaab7oHyQpRiYSJPvKPH5aYfoezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309820; c=relaxed/simple;
	bh=UyVEvwAYo4fSvnzb0e/4dzS8EsEpGI3fDXNtQzwqMU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kp/gKBx0GUXNKK7mNg02DBajcUd7d8q9D9rOqgTYB3sTjcoxajvguj7sxTeqvmXY8zxKhteRqGso7T9tIMn0EWpgIofwnyMpg7FoDFagMiadiNFDSqeS1jnL3JiZUoS+1VoPfI4CGDymqsZz4c7e+QPbBfQ8abtVovl2+RoUmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cs3KW9wy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULoJZg030669
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lNeRLPEUYWV5BSZQOFcWupcqoxEfdoUY9Dt
	Rc7VMxGo=; b=cs3KW9wyJxuoqwMzScpV8dL+thIIjvu4hqq0lU8UHHZDID0Squf
	u0f6v2bf5PAtCCUa7usQ6Tc8IozfVwPXE6RqPoKyXblRhpfy9YVtbQhXrsOFU0Ju
	WbLrMmJEdeOMjYYiKuMFLKpcxQ/A+G4g8EFm+1aApDri3bdDLBDEDsnYjIFuVGHX
	4/6TO+AWtB0bc3i366FBqi+u7uC5iUV6dEIk5q4YXog18MySutsy+47AlE1WKI42
	+LqyZCCzK2DZ6qmcZ8UJ+Fw0Bqa5d9q5f/JuP0iyYwDJ69uPbQG4F+5xJPsmM+Ie
	5//HKF+une5/7fOn8OsFXwEm1MrxMNXcKDw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdkqg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-286a252bfbfso79670365ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309815; x=1759914615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNeRLPEUYWV5BSZQOFcWupcqoxEfdoUY9DtRc7VMxGo=;
        b=uEJKs5LM/mi6pDTWmFuik7kFtAswyy2SXITjGJz177K4Mmz17N3tXD5FAWyC5sF9Kv
         AfRehM/rQoc7xaTl8x5qoVdAZNSXAsmzkBfO321TZNcPSgBoDDOa0J3ob+trU1lMUrJS
         8EEs9pUUGCpZvfT5Y+nH8N446xt0kma16FG/JDcL/rFXIMymTryckfjRu4ECBF/YNn+R
         AlB0mhm0yYPcZ/ApbickR20oDB5dyTv2tHipGL/AXAi3cHJEUsagznkWXupmf4c/UFUd
         +yFo/jPv+ldE1hp3ucBaokF7ke0QY9CRWaDXsCh2KbLf/MoBtX8k/j4xJvCblud4Xhn4
         +z0w==
X-Forwarded-Encrypted: i=1; AJvYcCVe03282JfRadjqjOwfIql1YpBcnCom3QsDeS9aoG0DWVkvp3fR8nBcpABvgilyY5W1IxTreu1Rg/JJQ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHMPz1YY0w3J3c/YRMm8Gphs/l77y82nTGInrZPLoaGuD7Quf
	+UUs0tNCZe0zf5xiNboIup5aMJTipgnJXtIPDBzcxFK2Ce8Hh3pMdCL8sWbYCijPQRKlBvbl6rT
	MYMWJ1GkqwSioGHEsP2Y5IE9/cZypxCK0ySmj/hEoeVVnR9k2tH3l48ylC/Jt5xrdjVs=
X-Gm-Gg: ASbGnctRZnTtwOYwitWA6j13rb5Vpuf7PwCxlJMJbqeiA6pSiMOp9C5wmafh00z+pcg
	jYIJtlA8cgBc9ibEbfzGpx8zbx+6t+TwI7Yfq62wUGtoijEac0Qx2lsLykDzTJBRXosmyRRo21h
	0kQ/fZXPUfoQalOVsS5uvMwJMe/niPOqcZDTxa4YFUcYC5ovDkkQ+KYIRYEtoB69uIggAvKDyME
	pnVAndhUDkYG3PQ6iyJog40q0ggDQCIyWJZEL59Q/Cbta6j20zCpJebEMOLuHRuEDukWjHYmZYO
	qA9jsLkPP9Vgs4b9klAwimWdSBLGhIzwKzarkAvYs5MpjXYbjex3ZX8bVqeruZpitL53qvkg51j
	24cqR2w==
X-Received: by 2002:a17:902:cecd:b0:25e:37ed:d15d with SMTP id d9443c01a7336-28e7ecaf7e2mr34346165ad.0.1759309814979;
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfNj7f557yGS4zV0OIPzKADeCcll3WFCIzqLMSWFr6e1FWj582ctC461ZTnDu2IPH09h6TZw==
X-Received: by 2002:a17:902:cecd:b0:25e:37ed:d15d with SMTP id d9443c01a7336-28e7ecaf7e2mr34345945ad.0.1759309814463;
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
Date: Wed,  1 Oct 2025 14:40:00 +0530
Message-Id: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k0D6xmaWrS8gLSm8trYqMaKdD2vs-hU3
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dceffa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=O1qDPIM8N228WRSNLNwA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: k0D6xmaWrS8gLSm8trYqMaKdD2vs-hU3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX/31ikgUZKKU1
 7Bl1ksvYrZy5jPg+usbh8bp0BMr9DBinl2V2kNnmJogOzrlUxY/ebRm47oPaOZvE8Kml4qpmIPD
 MqVN31AhNeROQ4R9Mvw+LccEZxv4VW4lqFin4fzDOf1McGdr4Reavo7g/5AFvNKhqlY+6jImRC1
 3bFjAsETK6gGFKUKSsMvIXwGwWkg/4dXkNQesmPrfsW9BQMWaMjYLQHn3fHneAOI+CV/8TjmZMT
 mYNkWqS+GCdd/zHA3CRixuedJzpCJ/GdUpKe5M11Vb/FcPgkGIMilcaBLG4KL4d6GrTnVuMWT2O
 9pspFrG+mzTe0DNU/ZmiaSnb1njLg80UUAUeUKMtLKhC3UMMHEdouiDtnA40laEkY1IWYs0nr7F
 rJD2mUTGo/7vLDkMxzrCYx+maS4Zww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

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
Changes in v6:
- Simplified error handling by directly returning regmap_update_bits() result.
- Added Acked-By tag.
- Link to v5: https://lore.kernel.org/all/20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com/

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
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 273 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 ++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
 5 files changed, 335 insertions(+), 66 deletions(-)

-- 
2.34.1


