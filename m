Return-Path: <linux-kernel+bounces-838637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A554BAFCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457157AB3B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B9279782;
	Wed,  1 Oct 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VuRBuuXb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25D2D94B2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309837; cv=none; b=qAXCjsPFXaESBfskvtC++mYqhgE2fFyMcgAzFyIWozo1b6LnEyvpibqcNrZct0fzvjnE6Z3Hx9NO+gynaiWtHc9Mk/r/PA9kur4gYOM/C+WtNkE5PNmm+DnOGcjHYGYLKMCFP4YLW/7ZIBTVPMawEpzLIlT90jLZdr40YEgmKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309837; c=relaxed/simple;
	bh=qKSG5ADsXNKPjV3nlzlHBiIYrmbuMHtoYqrl7DKLOKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCU4KUbAmmVN78xl+coIKpu2AQAN7wQevDbiiuXd36lqKZogtfh9LRQc52owqAKEJBncApfwwKMTtikvtLLpZwU/kViHVMFMfaZzxjdLus0E0+n7ujbXeQf69eq1+h2hjpvsIWTh6h50GeUGygNxb1C/AmNC3OQJWid0tg+3x/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VuRBuuXb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UM6Guo020349
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o0FOP3SERm0
	lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=; b=VuRBuuXbQ25g4pw/KXGNFZSXySc
	ou3OWgN5RR5xxGX7PxtwaXLN4cFdeTN2HOzYlyzEye4fo7/xvtGhOpWQzTyizpct
	O1hJtCSQiX9+7FwwMQp5pegp0XVKBLcCtXmZcVn0hNoauDfRGA/O7i8Q/IIX8DeZ
	fULc/TENF2jFaZqnp/Jp5k8vPkMg6MPY8ezTfQL19ErTlqVv8hApxu+7KLwneT5R
	ti1KMm3fKDr6IeXJKfkHhKoXhtvdC9ybivy1TiOa2/3I3eYPBvp/TmEmChwefdHv
	VMSdA3lemdDrFsceb7TFfkC4I/1k/pYKwQWKlL8Va/J+vnABrgJL4rSywtA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5v45x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32df881dce2so7372350a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309832; x=1759914632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0FOP3SERm0lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=;
        b=O3QVoAi7rev8vcziiXKxweH52n5Z3IgGVwxZTXIw0MMpvRov4EnasyiakUITUpRwdw
         0yD0WScmgqrc00GAO7s4nVUX8OqG8b+0RIbv0JIijWrZhpH5zQv7RrNmFufinrKbL5zw
         BK+GyVJqbqM5H69/TPhiUiHOhVbOlLz8oNcqSzgk2pIg+4aPoIHpkkHn0KQ9UyvQ107C
         EWVxpDHSCQvCmbdIAx7wIe9eCvSj9+ky7cWVBsa2hEWq1ObrdGkqpqeQTXd2t2RKTU6A
         wt7o/qgBHMMT1tac8vcxelG70KC6hPO1FytNxZTWkAJF3wZ9gw/MT7ZZiRb5pqFr6Sl5
         Emvg==
X-Forwarded-Encrypted: i=1; AJvYcCVS1uvdKi4gsnrcn0/oinbaDn8awj2WKJFjcnif/EsPz0D6XUdQSLys2RH6yLYCduxWpnayyufJ/ggXxh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCWlzbIYDGeB1NXULYTt+9Q2axZstCi5+qnbaHPMbgEbA+yHJ
	FGBTfBmrTaAD3Pl+3TLK/AeLaJdwLD1ZBZiRXKWvRK6NJ9sXvjpl5Nbe742q7R4bMIAAtME2xjh
	SjwrL0DxmEgimOgMiyz3qHJo2THJEBuPEkp1ICIXBLjWs29SOQM1Zp4mkex5mEsP8JFA=
X-Gm-Gg: ASbGncuvxj5MlEgD+fPklxOLdGuOG1p4zGruZXHQ3SxqaFqYRG1SF46LrcYJaw0sq44
	jU+/STaptdScThPcZ3abjCU1zQ+6ULH/00ZFAfE5NkpT5BSOfr/KxpNwiDIS49YtqaUCH4wOq9C
	19irx7bYWEGygfWC9NI9veZEimUNC965wtZY6NSMZNzzp2da0CXi+UrxnfCGO07qj6Ow2AsyvJP
	q35IbsvoXnoFQ4Yfi4uNjCosnoj2jpFr6egxmm64OauMbQq0a82evKmCeImKTuEcO4yjQU7NkfJ
	JDcrmeJOwmKUpg+vUb35+QdA1h6xXsn/SfWG/TjkoOuJiprZQyulf2UxAEevr9JPKuriaBlhol6
	dRu17KA==
X-Received: by 2002:a17:90b:1652:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-339a6e75590mr2738740a91.11.1759309831585;
        Wed, 01 Oct 2025 02:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHrsbDPHS1HxcDO+K/KipyOuzCxhUrgWjzzx0QS2Hg/EFoTGnWxrcFhl3HffiKGv+LxmMJQ==
X-Received: by 2002:a17:90b:1652:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-339a6e75590mr2738704a91.11.1759309831072;
        Wed, 01 Oct 2025 02:10:31 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:30 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 3/6] can: mcp251xfd: add workaround for errata 5
Date: Wed,  1 Oct 2025 14:40:03 +0530
Message-Id: <20251001091006.4003841-4-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: yPdLTN2TtITADheX6CvpBhc6WpGEAZBh
X-Proofpoint-ORIG-GUID: yPdLTN2TtITADheX6CvpBhc6WpGEAZBh
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dcf008 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=-2jKClcn1S1UO4fOL_0A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX7V40ltQk5MaX
 zVE1J+iSmIV6aSmMZDNeoPwdUruJqfTk4S2V6CbEDkRqyQnmHqCJRPi3uPvfmyJzDzkRJ6VWfS9
 zTdkQSNJk3xhIPFvGoSuuEasmozhVNltNRnU4afdsQE7kjGeTsIFafk0RDKxFjXv4OfeiXyn9c2
 zjS9Tpqnr4AiCXOJs5WTHODwGaPDATF6jOMFucE8fVOH/2s052dUPjaW1sFbfuG/nhu9MhkWlXj
 GEpaWNx9t8cQI30HUd/xlJnPfQe6kmJRQKq9XmHl/u04Hu+7Wf/k9VaODIaxRMG1Zlfi5yvVL+2
 VrItrtCCIgV6TW+Q4wCeOR1mobugTqGE57M6F8X7XpWqMwOD+GsayNpA4YLndnDwUcrchq5+soX
 J3vJMtNwyVmgM3GpELBwTa+RXJoUzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

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


