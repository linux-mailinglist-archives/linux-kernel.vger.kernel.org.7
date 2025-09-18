Return-Path: <linux-kernel+bounces-822167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8532B8334C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B56D1C822BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB12E2DCD;
	Thu, 18 Sep 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LRUsp5o2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6142E7621
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178173; cv=none; b=raCT+xJHpF8MYVnYB/jZt9lFlN5c+eBc6OgjHwuOS2iVdgCkObbYyCWa919BECb/gV6RH2eLJ3Fe0FFS3tpWaX+S1gCGFr0L0P0/EZUgNMsrPwWWeNWXwvxlLThNG5+hyjhP4qRsyKsXUOUQarnyLUyz65EYacm97UaO0zy9cdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178173; c=relaxed/simple;
	bh=/4kbUwnniL554GVUNwVLXBqnCaR/My4fabOkFQKK6oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSMZuCbvLoO9WPPQzG3FSJeaIvZHoSTO99rGx+5LfmLd1xTBTCdsKlNJFkcgZveLvEMd+6QAam36ezL0PidZi5tR0AayXv3vYsfftWdJOIABlO10PrGJJ1SXYMrhkqEfcTln3OMYjdaJKESExHgWMp5Xsj2ZnhtD57RfkW8K8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LRUsp5o2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I2wc3v019524
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NnvOmJJvaiJ
	dkdV0XAgXRx/iMwwsotajiWEilazX6Rg=; b=LRUsp5o21t5z1kKnrb/8bDIx+/B
	FQCTlxML4MLx7FQRYb3IUzPQ0K05ryQkcnHvCSA1EM2JDbp+DkM5FDlS/0WFycT5
	jJEkD3urgo43Ayb/J+fAswFGcSkCon/ee1nTCrRLqv+QOIhnEppq8PmWGTAi8Kkb
	HFXZXiu5vKHNLZqWTh1M9wovWMeSzCAa2fBk6Z5JeIwVRHWLc1q0AgMjTcz8YC10
	PGi6e5hvZcusXwpzykGo5r5NogSXQ0LgBu6AV4nVk8ETtCxXkV7fK9mqKy5OobNg
	r/EL2CtazimZ0UGKJlyRs/E8Y7XGrtpF1DvYhlfxhYR12Zs4yV+tZVTL59Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1wbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7725b77b795so667425b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178170; x=1758782970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnvOmJJvaiJdkdV0XAgXRx/iMwwsotajiWEilazX6Rg=;
        b=hVVXZBgypTpphKlGgMu+uAUGPJo9VZ8QdHas5KHppkcoHX4G3HYcE0TrOq2T9J2xlh
         1FksPKhNlg26gSOHkr+BvFmCrNFZ+ZljukujDMDG+n56VbPvs6xUQ1wHevp5GRNiWxIx
         zUfMXSMowhUy+BNZrRiAKi/05oCSfHdLr4Zyh/xiZeDR/Hxhtl/AuxF/g6u6Npz7RkTv
         3aEnRkhr20fiOPQoY8Bz+R11iwo0stfK9I/uTkPdu5gkmK4/llCpay7Xn8SCLkz5IaDd
         IvuYy9olsjc+A5WAz2B2SBjatyN7HNnfYX5oY/2xoGMsI5uwuVQnHU3Yhid2cCsPPUjl
         IBGA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUjanR6h5AZwTtkM3jTGNhJmtsGR6ltRDbEjOjidM+nsrb8ZXhZD6JIbpKmhZHk5wf9cPx5IdfdhqwhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ol6RAtWAWjnO0y7xQ2Xtl3ryLl0+VpSj6dL2dWJUFyArcHtI
	PsEGiaJiUGuvPIg/jaatbrvYIU8q8YfPJtfjpxhExO4MCQrHQE8YWkx4wAxNXqaY9CrVTvGeXht
	noNmC7WbZJb5puT8P/O4qoeCdCHy/Bx7Lt9tdVAjSYEHBi/IV4phWxGFgFnagklmMBhA=
X-Gm-Gg: ASbGnctoN6oKKLDudN8JyZQkal3glVVoNYOS0o7BxWxpWtIubDUOQOI7zFTQkl8jryk
	3CC3KH8NkB51nWkJmcASfpXjTKt2OAPfGFnOHgHkzXGxXe/rMDZBPk0wlVDoqMXc3rC9zftCjuK
	IHXZIRm5CCJfAnljUvMzG0RTN1fX1lruou3qa7PrvXvdPzdFoiwgpAfLJ9oWHnmPPO16wM8GO5M
	f1UkUc0OXW8sqy8UCyiQBj4z3Pd9Ber088ITyku50dpqNR2U9QhE4huIVOEEgHXn6j7NvtOww17
	CUBmF48dHyvxLqaVPt9u1KUKBYzAQBkBgkSGKnWVGYvv1eb7kym5MHm0aZxu7W4dMAzOJuCgRIR
	B
X-Received: by 2002:a05:6a00:a24:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-77bf6fcf42amr4802542b3a.3.1758178169616;
        Wed, 17 Sep 2025 23:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7sRaE02ggQe01SKwGhQlmhie7T/BAQTw4FIQVNZcr6uyfDFZZxhM/OJpvcp1IJ6Q2Ip3U1g==
X-Received: by 2002:a05:6a00:a24:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-77bf6fcf42amr4802516b3a.3.1758178169129;
        Wed, 17 Sep 2025 23:49:29 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:28 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 3/6] can: mcp251xfd: add workaround for errata 5
Date: Thu, 18 Sep 2025 12:19:00 +0530
Message-Id: <20250918064903.241372-4-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: Sl5yKxwT1pTzCgJcFxTPGuQABan-nuGk
X-Proofpoint-ORIG-GUID: Sl5yKxwT1pTzCgJcFxTPGuQABan-nuGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxN8LwSG9omUD
 0odDCsMyoSfI07H9tfB2MT/aEJHNhLYO+nrNKrTItseNEPCFI7i6+V1WurJNhFes2wAS0nWzlcF
 Cj1QHlYsuESJHSSJBXoRDTQZkry6T11suHOxnhq1zj8d/Tk3Gcj0Wp54wxZPafoBENdxsUGd8Rd
 o/47DBkdGhfygOfc/TaLQoD5qvK+3kaWyTHrsVuGMVlkRzcNZT3FS0+rJ/QFEVY6vlW3vJRJktJ
 1ucfjPAoJDugWrDXuqZMf385+FdV0PCT0VVG+FXZfFxd7usMCHKRi8+lzHlkjyBVC9YDxkaaJgO
 FVZhnc7D8DTr8SlQCXGDMFhZNndrf+lU6lhYbLCHAgFK1ISZWE3Bg7g3tIcCSfBEcCIAt7UQGXP
 4nhDdrvk
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbab7b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=-2jKClcn1S1UO4fOL_0A:9
 a=IoOABgeZipijB_acs4fv:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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
index e61cbd209955..bc24a837bcd0 100644
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
+	u16 reg = be16_to_cpu(*(u16 *)reg_p) & MCP251XFD_SPI_ADDRESS_MASK;
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
+		reg = cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE | reg);
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


