Return-Path: <linux-kernel+bounces-838636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56514BAFCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B278B3B81A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEF2D9ED0;
	Wed,  1 Oct 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hu8WF6OV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7242D97AF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309830; cv=none; b=a6OAB1ZR4qMLVa+80zU0OtFPlYgPQkGY0yG/p7E6sd+X9Bd2EhfdAUyAoVhKLGhq6St4k9ZGeZNd0q5UPVPu/CoS+FwUI3T957BbKfaXSDy+VweVf9+pt534u0u2uPcCmbQFcLYjktA4R8RPMJVq5d6iw5dD5m6C4Dp5Hhu/LzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309830; c=relaxed/simple;
	bh=+IOLF0XPvUULiaKZhdl3sSn55zuFmc8DaivaubnewwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJyzpOJ+6eLXwJKUyoG4I/fSHPPkYFVvbdZbaooXMDavkP+u+xAsOSV20jPGPhGTqXmIZdSyGdi9UfeY4lPcRueOqgn5AZ08fTlDTkeb7xEtfqMbO4ZNl2qXYgIu73W61xFkOlblEGB9loRg6qYINUqfZIx9heYRzq3Nqhvkoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hu8WF6OV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULinG5001000
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QmS6oCHS+MH
	N39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=; b=Hu8WF6OVCKn3Skl4NYACHfGx+rA
	/5DwJ2FQIQmNip1e4GJ9VczFdpAbm5sMd8lMOZLDCHU2aH/9VsHWCcm2nU76z1Ue
	i/3DDrMxjSb8YdT9/q76m5hfXz2C5y0eZtwNEjnM+eOZyhlnELgrbVb6QplFjdzu
	xuRnevkPQ609FY5UNoHxhJHtVKojXQwCc9iyFO3CIr/b7tGnStzJY/HnZ0lj6HEo
	WSmABK5V5/WdEyr0DPQwWTQKN3aaWPfz1BoeyaUmx/XwfuaWTTUpinBfPoZJTf6o
	7q575aoB6nKh1p4/k8AvXLYPtYB5NaIrEyN5RGOIszsPafPuHTV25MU8z+w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr7er2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b57c2371182so6096824a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309826; x=1759914626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmS6oCHS+MHN39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=;
        b=aN5l/q+HzRu/or3YDO3JNoVG+qexzCx6bz99fnjTjVRVY/99WRReFCab2+8a+51QNZ
         BdR7082iGrITLdhm1H1K6d0DUk6B/pP/2/V7l+w/mCnWtD8y7dhObgqQlLPSU/GdIFAb
         pddFfhc7KftY+rlPid1rogZwwWcUI+P6s5P5Mb2XMSdElfWREmLCvIOl+NdeXW9CwzuU
         aLXTUprDZyQBJGXV4nizC0Jbvj0Wjtj2vOeCZQDLpGQOorLf+0+cZQ0LIzlKXYKrzN17
         ylIifE5fxUce3OFLjutKJgZkxOdrD/9EdWuyh9GB6UqyQX6F2zrM7YP+TMunUtpsQoLy
         GWhg==
X-Forwarded-Encrypted: i=1; AJvYcCW9tP6iHZj0TgKzIK/DpMcHhNbo0arGq16zMSnULdbQoL2HkNz/+fmKhfAKwOWNcqJwIV+gvWxAYEKAxjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXLfB7cB8czfA1xV3HOseLBcQSoFZsOZ+kHHkMunX/QznM4J8
	F1W9awysSkE+P7ua5vTRJAwwrEsb8R1NdxGkeF4AVDpgPRTl7TlhEDz3wGBve9pY0BcgQWQycGT
	1bZs1e7KxPbkgzeOVt5HArRCJoFUhriZh/N8VfwZYOUeMcQvRgtZpvw8FKYps2Ndf+q8=
X-Gm-Gg: ASbGncuPznVOgCZ8XQFMezzu9zrl3YejCDkHmHzXvEIivD2JYK0SeXHbImFPpSRwHSu
	PlEbKkcsu3hrvcCcRHbYE20GPs/LjiXarArKFX23kU+D63TrFjh70etReXhHM+dS6gGEIVPZ/Om
	j8S+vPBYF/vt5W4g6r8kasrVK02oGRO9H5jP4tQvNsO9X0qzXZ4GXy2Cychw7jtnqLq9m4O5Mu6
	nRzMzknvT9dHeZd/CZ+PgldOWgZYHM02IR4c/3hIv0y8vZchljycM1+v/JhCoEJqUcRMonP6ha8
	jsN1aL3YyArpvym2za4ar2g0o0KrcwNQwIxPBfhjfSn6JdHPNyn/stGcpNZQ8h5nYNLW/031zXJ
	LctA7mA==
X-Received: by 2002:a17:90b:4c4b:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-339a6ea6944mr2853281a91.15.1759309826229;
        Wed, 01 Oct 2025 02:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bOT3MEqE41+QlxIP2fM85SUvDyvlyXBiaARdM+M1zo58jJX+wcMITxe2A+o0XfcEuLOxPQ==
X-Received: by 2002:a17:90b:4c4b:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-339a6ea6944mr2853241a91.15.1759309825769;
        Wed, 01 Oct 2025 02:10:25 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:25 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 2/6] can: mcp251xfd: utilize gather_write function for all non-CRC writes
Date: Wed,  1 Oct 2025 14:40:02 +0530
Message-Id: <20251001091006.4003841-3-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX00l+rdxjLYXx
 oNYMWATc3799Jop+gfLLpcOmWxaBRa5FDc129/hxDfQvRK3XFfdok3bRU/qbU5d+D2KqKVh6hXp
 2/nVWWZkaRJEsEfy5mAM+D46jm+X8/wfqWqNTYK4dsnPccfhQ9H9Dbgtz6rb6jT+XzKG7h8SJKc
 k/dR1Au4giy5CrsOs18V9Vgnoy8cTw+0Tfbm/XYGWeUH9QSMg6+R6K5OLlm7hUBVl4dXrHSx+pi
 51pZhUERodDapZLV2GOn7iI5XuqhybfzGQ1jCM/ZJRx0N777CNa0fSWha8dDm+MiFNch7Es1CXi
 XkHOU+zuAdeHbWE5MoGPOM4dce1LLsGM/AwiCpRhgf3RXTUunR7gQc2svb4zSaecm8ukRVCxi09
 7I4E9dWA9fXTZjEUsvDKa+52RKZWfQ==
X-Proofpoint-ORIG-GUID: xPeVKwY1g9T_4m2lI6SniQWYH5ChV_cR
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dcf003 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=lCqp9tVl3zhOgjhhuWQA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: xPeVKwY1g9T_4m2lI6SniQWYH5ChV_cR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

This is a preparation patch to add errata workaround for non crc writes.

Currently for non-crc writes to the chip can go through the
.gather_write, .write or the reg_update_bits callback.

To allow the addition of the errata fix at a single location use
mcp251xfd_regmap_nocrc_gather_write for all non-CRC write instructions,
similar to the crc regmap.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 8c5be8d1c519..e61cbd209955 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -12,14 +12,6 @@
 
 static const struct regmap_config mcp251xfd_regmap_crc;
 
-static int
-mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
-{
-	struct spi_device *spi = context;
-
-	return spi_write(spi, data, count);
-}
-
 static int
 mcp251xfd_regmap_nocrc_gather_write(void *context,
 				    const void *reg, size_t reg_len,
@@ -47,6 +39,15 @@ mcp251xfd_regmap_nocrc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
+{
+	const size_t data_offset = sizeof(__be16);
+
+	return mcp251xfd_regmap_nocrc_gather_write(context, data, data_offset,
+						   data + data_offset, count - data_offset);
+}
+
 static inline bool
 mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 			       unsigned int reg)
@@ -64,6 +65,7 @@ mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 	case MCP251XFD_REG_CON:
 	case MCP251XFD_REG_OSC:
 	case MCP251XFD_REG_ECCCON:
+	case MCP251XFD_REG_IOCON:
 		return true;
 	default:
 		mcp251xfd_for_each_rx_ring(priv, ring, n) {
@@ -139,10 +141,9 @@ mcp251xfd_regmap_nocrc_update_bits(void *context, unsigned int reg,
 	tmp_le32 = orig_le32 & ~mask_le32;
 	tmp_le32 |= val_le32 & mask_le32;
 
-	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg + first_byte);
-	memcpy(buf_tx->data, &tmp_le32, len);
-
-	return spi_write(spi, buf_tx, sizeof(buf_tx->cmd) + len);
+	reg += first_byte;
+	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg);
+	return mcp251xfd_regmap_nocrc_gather_write(context, &buf_tx->cmd, 2, &tmp_le32, len);
 }
 
 static int
-- 
2.34.1


