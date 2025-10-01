Return-Path: <linux-kernel+bounces-838638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB2BAFCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149FB1892D60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F562D979D;
	Wed,  1 Oct 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkKu3oVJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A792D8DD4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309844; cv=none; b=Tz2zNMN66qOklE8qOEGmY4ukdTXyl7cKSEEyaSi+ENa9Oop79yCtTj7+wb5TN1AJGrP9evyFxyP2QGoXlH35FnjoBJUwIGUaJRsS/hJHiKHmWj1tvSwZ1JmfwmzN/9ZwBGhbFVwJK0J3xtXcVrYV2KrfNx2vMkdQeIfX6dAiNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309844; c=relaxed/simple;
	bh=fk0TNQn7BAcvjE7TYECp7NGF/xF5QIeAzGhAHgip9EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHt2EEjwgzZhNo8PGkmm/HGhHiekDWuCvgA8mbZMHfRdnelRfPy9oA0VKkjb0Ts1f0DCO/lrp3Ck6ZRYdHLlM74PBxCwwzigQnTqn3WerjkTguxGedaVWmvFZwL7faGIALBYT7W+pLPaBH0oX/OWgtybRXGD04806O5JalwCcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkKu3oVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917nf6Z017574
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fAG+r6LmnpS
	+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=; b=hkKu3oVJtxvzo3nFqAJrrxfSJLE
	28BuXxUzHcSkSHXTyMerNXvBT5bHeFlM5XKs56aBIzz1VdSCv0KnnggLO1/WFvs8
	JDWtQxcnEHIEVrFzrAsZlgrtPeIqBG5Sv1haLYyBl4bgEmXHybknUcjOFDZzWySP
	pXIbPiVy2STV9xuZfyh1buXnufB14ZlxX8E4zW7/Vy2+Z7cXWJVvy5NTrRPcWLsL
	Own9aUI4Xftjsh/UgvkQWP66ChC0fpP8NfLy1TysqVh77ARg9L66EOffPJtUE/+P
	keSWizTq6L3Qt1hjfHBc86kTT0//OjX2rKO7sUWth8P1gzsVvc4RZsyvhbw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tv5g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so10622797a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309840; x=1759914640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAG+r6LmnpS+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=;
        b=GygNtyZNEmVnPkR6SOsUAaBW0Q1ExQuZCDu86HAOjR70wYKbpyS6GBk/kyKpSVc+Pn
         AsmYgV880mBm5k4C7P6oW5fjNBkWurslXORMiTfbLr1y5+BV2RQ4ieND2U4Q3KpFvWL9
         dz/a1qkOqUV/wBuV7qXQ0Hiyz1dGZKnrdc/fXIa+iSeCu6JhwR9ctfF76Vm2+DwrrQsB
         /g6fPCqWSgms4RelO3aY0KOTwl4SIOVnXtJ31gaEzzGICx8YOVrkrweo5hA2ea/3p4Y/
         Wx8Ki2jL7shnrjjiHzO4tTDLrllI1SWzsTEXgLNUHCPtZCxhx0qBZq7PLYMA665oZ48i
         BzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb/zN+XhEOfW3PDz+vGRp1uxs0XVIWXcBJrRbcJYpfKz6yysmAfTtBAUc9UAgHvGswWw7h/P5Vp+IOxNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagQzKMn6Ib59zhY0t+/V2mryckJq3//3zo79cImRvgmlakarz
	fHWbehrs+iQF2DaduVQT9lgHu6iErWyvbsm83RXZrCNX2JKymSGeCsAhTWqVr9Fc8QpPZWDBed3
	iDeyv/ICS2dwd/PHJm8m1JB7tr4Dkk0RjaDlh8sf59aEuyJL1MUkKBEtFC++CahBWhZ4=
X-Gm-Gg: ASbGnct7HPPmvUI2XMS58hBoyqnAkRUenkvAFcno3ZE/RrezbxXjm1mHbAlsFLM3V2I
	REIrQ4Qj6xJmTZ/K/DcyO2Emgtz3INpvWMNNY5m9Sn7WweNbLlvb2Q9FllhC7seJJTYe9oaQw2O
	oe5MVhWFqHLCvQ8VKwoVUsaOduoQxP+0c0eKWb/YXoCgV/9RAz1QORBKCEMbc0K951fr9TFUAb0
	hV5Uk+jwgSC3aMG25khAw8NYEjvqG245Bms9Wdd9R1K75hvIyWEfafro/DxkluSdeqWeDsXacas
	rI7CtIE2aHgIYL01TFFPboW0YSkMhxFSe+Qikj0Q0fvj2JaPi4Ee7NKvm1W5ALmHyPBCxWM0gP/
	/SoOtzw==
X-Received: by 2002:a17:90b:4a8c:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-339a6e906d5mr3004494a91.4.1759309839812;
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG2Oc1zqD7w/nvyX6L05+vrpzpYRsOhSjBhkqgqLwDY6UG69cDOCWgjGqXzaNuipkL6H6UfQ==
X-Received: by 2002:a17:90b:4a8c:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-339a6e906d5mr3004460a91.4.1759309839344;
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 4/6] can: mcp251xfd: only configure PIN1 when rx_int is set
Date: Wed,  1 Oct 2025 14:40:04 +0530
Message-Id: <20251001091006.4003841-5-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfXwD0MNLXe/7aO
 EfCD+EGiQ18tpiQaL1vJLhCBIPml7oTnDeaqd3xzQZXluxZ0ADmftVSAJv6SXtA+JA2C0CDdFdE
 EJlEuN4vOEJ1IQD4YPExC5/ATlQlhwHHBOr2eWa8m5pKJD3bYZmhmWfZrh9t02LD6EpcqtdpN8P
 msuehPMuVMbUeMwImBu4cYvSqyZ1mRrm9v/0Sq83wjAfSP2pwR4GgxJeEc/GJU1AOX6MjmyWrIx
 3+w4gRpCdurW0KFOOCP9BlsWq1uMKZ+839OwNSV4ag6ZS0Q8SI/g2BoKMrq6c+2nLYTSNYyS9JF
 ko+oHV2OK4mpENvVyrggBSFpoMWFj8whZsWPY0Gjeaqov4ZILtbtvBPztkgXJx8biAAt1c6JkcT
 ML9sERz89Rzppjcdb0MnP0vgSNfWLA==
X-Proofpoint-GUID: TRPpt9UB_y85SweP8bV93YSW7fZRMF4m
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dcf011 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=Zr3td6iJmGh5AMeZqZgA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: TRPpt9UB_y85SweP8bV93YSW7fZRMF4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

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


