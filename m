Return-Path: <linux-kernel+bounces-834112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA336BA3E69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9251C620E75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCBC2F9987;
	Fri, 26 Sep 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKGJL4ZY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA42F90D4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893447; cv=none; b=nfpe0P7ZUHfrq8Y/XjVjr+0OvAHSaAOMgdzhOGiMnnNfZ9Jd1P32+H98gAT7tmz5UmzRbJdAvdpbtgVpq0mqG9/Pvv2CJNCXiYQtFyxfdSoWv19xBt1sS9nefPp6z0sJvBRXnGdlkBaWQ/VWWKakTYC1pvGagotv264p1NjLrBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893447; c=relaxed/simple;
	bh=qKSG5ADsXNKPjV3nlzlHBiIYrmbuMHtoYqrl7DKLOKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdTwxJJQg4cNDwi+XqLo3Zs0VxAHJ108QXoRFjcm//hg/piuRBmdOLeS88A9Ojjr7pEKUqLUuYg4fpduEBacf3cGrBqRMM5yx1jweSV8MrzjSPPOiyHCs6pYR0V7W1KgCafDVZU2Pt9ec2lvkfQEPn7w0f1ZYQOSNLfJjU1D98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKGJL4ZY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vqda029048
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o0FOP3SERm0
	lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=; b=MKGJL4ZY9DYmg2Rq+RX6U6jG4qh
	n5E+DFPnGRCw/6nCRkZik+aZpMICxOatsep2wUpLunfbj7OjW+sclZCKrN2x/8QS
	cArenclZSmBfgUO0p+fqaBHZkBaqOTjR1XpcmBgaHKgtI4opZyj+wWL1zZif42cI
	zSDxcjzFA/B9NhZo57aTdy7+yB5cOHaHVPrrIzuMCXh6266MqEiUxhemB6ySZcMm
	JeC3spIQ0RjTiWG+qvxyTWtvJiWjhfPY1yuBXd1LDYK1F3VU607ME0o8JeN3iXTX
	hEPlj2MBAPDmKqH5ZEXdjiH26HBiQJd0Xing0OCpndxksRKXNub+Om+kW6g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q2y5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:30:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78117b8e49fso1051671b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893444; x=1759498244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0FOP3SERm0lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=;
        b=TkrUIfzmnpBskQWNYknFwMi15TF/e9ntWeXD9X1FGpvdO1LPCPVV5ZotKOy8oAhcEr
         0nbqGsOoQtZMAaapdZIdNwx16D2phjE+Q6eaUTeXTh9WdItFNHvJMn9+oWFPj08acZOe
         3oouKkft1sHRPwEEPfABTW6qyBpWm1wbmuMCYGS42tJv/H3Ic/EE5snkBgM1kESbRrMz
         k2/VPQnTg62s5dayjGfTjTh36M3L7bxgGHllhRW3rlax3cI+WqjcDTyKajGSRLj9UPi3
         A4DciGs9PBQnaAx7mM3tXhKlXvdAmgmWuUVo2xRtYpqA2dg6cA8sw3gNJGhFs4qCpcvn
         x+yw==
X-Forwarded-Encrypted: i=1; AJvYcCUYBk9vLAcfTaV80bSSXvTGrrwOO7tAZeGTPkjovqyoXTI+WR+tYf1MRf0DrXinnEtBqqoniV8+cE90990=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALZRjJWWBOncFWXsrArtbGKe2fc9ebi7ytP1s6d38lilTVoSr
	bygwVGnNFywa2LjMjtBQL29u9f81MV+/w0AaMuqPz/Db6IiWqb63zsv58y9t/hGTSshUOj4wd7y
	FF5BZDmluCh2MqJsJfYNRBFRuQUtm7NnOm34gCo/A9YVlUG/Rurm9CyI/m6krs8mayzI=
X-Gm-Gg: ASbGncsAiJeokXKoQRrB0ojraIymWSavqBXh3lcpqHAiyl3akTEdqQUPSQU7dKfHsRG
	hrR4Yax20Fsyd6GgUX1LzHJHDCBRmZKUY+4WpKK7UZzjOOhAsz1mf/0fY+TgdKR1AAiQhwJ5J5l
	Neml68Lwag/DZ1cVU2+InSAoAIwcY+Ze4rKVBNU08cbEzcwqEONmW0OrvXMN9z9ECe++G7Gn2hv
	en0EmVLWAox0eT2kEVUjkTYnmJhd5MaQWPmiK1z+jUEfWlRODhe5/6Um6PhJ+zTNZ9H8QeQ8Jrv
	oabGgEa0YJcbFfzyJNiU42XrFeiRyzLqFfAO+DnIzfbrFnUsdbWev1iy0kDdWps6c6W24qBhuJQ
	V
X-Received: by 2002:a05:6a21:7e82:b0:2ef:4635:4fff with SMTP id adf61e73a8af0-2ef46a02466mr4953089637.26.1758893444377;
        Fri, 26 Sep 2025 06:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcuC+aAxAqTlMVdk/vbhfZoaMeOoObmULAxinRGBkkAoWtjCKdTkyKJEMeKLUyDVjwVByb6g==
X-Received: by 2002:a05:6a21:7e82:b0:2ef:4635:4fff with SMTP id adf61e73a8af0-2ef46a02466mr4953037637.26.1758893443806;
        Fri, 26 Sep 2025 06:30:43 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:43 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 3/6] can: mcp251xfd: add workaround for errata 5
Date: Fri, 26 Sep 2025 19:00:15 +0530
Message-Id: <20250926133018.3071446-4-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX7uM73PnqRCfW
 J/cs7XOxSBl9j8iBAmPTsGwC0zaWBA+mz+1E1n5khkIgRZ32mQPWXpgJR42L7F1SPfMFvCkLMsk
 K2Qf5UrFjp/YB2k6Gz9ZGvFLOU5QoAFDPYIKvGNQ5clO1So9XFV9SII7ffz/+5IC6D6dqeRYQvk
 9t6BRYZlVhjBLi2s2LZUUalHTvsBjGyMzH++WKVWiCsoSfjxOabGYY+hwaQ+HzFy/aeFdSXVa5q
 eIpuefo8dhFoSvfNK0J9562HEty2rqqjApDUwEzUVFBOdVfEB4Qy7yuZZNd056R5FJCL6n69VDT
 qW2PtFUao/SAgwkDOwnVDxScVR6VkWmc9IebUS9X2/ueZO/8a11uHeTpGABDkwchtdn3g9op07G
 WCRtfNDS5DEyq4k2RWo8hzdhikUTag==
X-Proofpoint-GUID: snaKBeUT10tWVz5CrbSyfAXYhNv1VfM1
X-Proofpoint-ORIG-GUID: snaKBeUT10tWVz5CrbSyfAXYhNv1VfM1
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d69585 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=-2jKClcn1S1UO4fOL_0A:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

According to Errata DS80000789E 5 writing IOCON register using one SPI
write command clears LAT0/LAT1.

Errata Fix/Work Around suggests to write registers with single byte write
instructions. However, it seems that every write to the second byte
causes the overwrite of LAT0/LAT1.

Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 89 +++++++++++++++++--
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index e61cbd209955..70d5ff0ae7ac 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -13,9 +13,9 @@
 static const struct regmap_config mcp251xfd_regmap_crc;
 
 static int
-mcp251xfd_regmap_nocrc_gather_write(void *context,
-				    const void *reg, size_t reg_len,
-				    const void *val, size_t val_len)
+_mcp251xfd_regmap_nocrc_gather_write(void *context,
+				     const void *reg, size_t reg_len,
+				     const void *val, size_t val_len)
 {
 	struct spi_device *spi = context;
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
@@ -39,6 +39,45 @@ mcp251xfd_regmap_nocrc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_nocrc_gather_write(void *context,
+				    const void *reg_p, size_t reg_len,
+				    const void *val, size_t val_len)
+{
+	const u16 byte_exclude = MCP251XFD_REG_IOCON +
+				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
+	u16 reg = be16_to_cpu(*(__be16 *)reg_p) & MCP251XFD_SPI_ADDRESS_MASK;
+	int ret;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to MCP2518FD Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
+	 */
+	if (reg <= byte_exclude && reg + val_len > byte_exclude) {
+		size_t len = byte_exclude - reg;
+
+		/* Write up to 0xe05 */
+		ret = _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len, val, len);
+		if (ret)
+			return ret;
+
+		/* Write from 0xe07 on */
+		reg += len + 1;
+		reg = (__force unsigned short)cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE | reg);
+		return _mcp251xfd_regmap_nocrc_gather_write(context, &reg, reg_len,
+							    val + len + 1,
+							    val_len - len - 1);
+	}
+
+	return _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len,
+						  val, val_len);
+}
+
 static int
 mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
 {
@@ -197,9 +236,9 @@ mcp251xfd_regmap_nocrc_read(void *context,
 }
 
 static int
-mcp251xfd_regmap_crc_gather_write(void *context,
-				  const void *reg_p, size_t reg_len,
-				  const void *val, size_t val_len)
+_mcp251xfd_regmap_crc_gather_write(void *context,
+				   const void *reg_p, size_t reg_len,
+				   const void *val, size_t val_len)
 {
 	struct spi_device *spi = context;
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
@@ -230,6 +269,44 @@ mcp251xfd_regmap_crc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_crc_gather_write(void *context,
+				  const void *reg_p, size_t reg_len,
+				  const void *val, size_t val_len)
+{
+	const u16 byte_exclude = MCP251XFD_REG_IOCON +
+				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
+	u16 reg = *(u16 *)reg_p;
+	int ret;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to MCP2518FD Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
+	 */
+	if (reg <= byte_exclude  && reg + val_len > byte_exclude) {
+		size_t len = byte_exclude - reg;
+
+		/* Write up to 0xe05 */
+		ret = _mcp251xfd_regmap_crc_gather_write(context, &reg, reg_len, val, len);
+		if (ret)
+			return ret;
+
+		/* Write from 0xe07 on */
+		reg += len + 1;
+		return _mcp251xfd_regmap_crc_gather_write(context, &reg, reg_len,
+							  val + len + 1,
+							  val_len - len - 1);
+	}
+
+	return _mcp251xfd_regmap_crc_gather_write(context, reg_p, reg_len,
+						  val, val_len);
+}
+
 static int
 mcp251xfd_regmap_crc_write(void *context,
 			   const void *data, size_t count)
-- 
2.34.1


