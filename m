Return-Path: <linux-kernel+bounces-844076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B796BC0EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C7E4F4330
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036424A069;
	Tue,  7 Oct 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Kz4GTXQ1"
Received: from mx-relay50-hz3.antispameurope.com (mx-relay50-hz3.antispameurope.com [94.100.134.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E78215043
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830969; cv=pass; b=IB7ZcmZxRb2sG0H9H00/5s6hy7D0DX8qBorO2Q1JGXftTPZooLbI88QTfNOe8XnsdbNZowyFm0lRHsRBHsHvtwDIs5Lz5OJJ9atlP+388l1x2SbrXYn+GMhXcymb7egqULOobZvQIrVsXhYovzInavyw8+a6gtzQauDUCHY5rsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830969; c=relaxed/simple;
	bh=Fjf5lFgW2oRQXF+1dV4AWxqlpVioDYyVUNjp/wUM344=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rVKwdpmeJjrHguHuGGlOGgvDO89y72DxU+NAT/VAEOoC7tdwD4H9LBshgP07Y/RlTKyiHF8qxfx238gDsbosoMwGpIIrl47iJbSFm25Kv1Kr3OWj177jMfDV2cTNWfCajR2uXv5+oVz8VIg7fE0c1Hny9H06QTkqoeBJl/G2mpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Kz4GTXQ1; arc=pass smtp.client-ip=94.100.134.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=4ePWzt8bowD1J+dyzThZ0RZjK2o8T35khtKdgWXWzJo=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759830909;
 b=ZBqfdWlo7qa5exW6me8r0FzAA5kHw8fQLw/KX59l38V4uF62s2VqeHuacqrtqZ+qDuwPrNvH
 TfidmFBQHUCuz3yzji71rJeQ2D6S9Lx498XxqQZ8nfi9ZyuYXgE/kvYVbkykNnHtsKl0XsG+2og
 2KAgbqAs7UwdiqmXPIdRHvh6w3Y3TfBDRmKgDf6/j8RWTMzn1FXF6giZZy2uomere5/D2kwKcU1
 zWA3B57fEY1t7znd/2NBJpsaIC5kqJYDiH1ruVoVQu83P4p/ycC8I23fqP51j5RZPK7godfXdDh
 T1xO9XZnnf/SuMxhMIraynagPHPsfVugyQKFKHFKXBU0Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759830909;
 b=LO//MV0byG16PomPjnm3tSJrWnfTb1pkbYxTYnGzcpRv2GD9N+CwpbN9ajFvIgRInR8pFHN1
 PFmtK+1p0Z5dtVAddZq5DJ5zKDdRiuk5+1B1l6GOUgCckG8oE8XIY3orCRZcQ/MADnJGTMsKcgO
 EfT+3WXdb4IYLoJYBZZNWgAMoFRrPhuPo7J2Zcmx0GTF2lOPag+WgztTJZfPDPiW1FMLjOWVQFa
 Q7MDOM5d3qflD7zhie/bkVV5s6MXi5bsTB22sj+4Lu4wgJeX2BIEGSwQDiQxqUOQ/kGmAnL/D7h
 1RHmkLLhlKuWm9igNM1pn5RauQ4dTKQ8dzN69doMVnHzw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay50-hz3.antispameurope.com;
 Tue, 07 Oct 2025 11:55:09 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D65EEA412FA;
	Tue,  7 Oct 2025 11:55:00 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] mfd: tqmx86: add board definitions for TQMxCU1-HPCM and TQMxCU2-HPCM
Date: Tue,  7 Oct 2025 11:54:24 +0200
Message-ID: <20251007095424.138878-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay50-hz3.antispameurope.com with 4cgs1x2y4Dz2nHYp
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:8d2a9cfffceae8d37dfb28105c9158a5
X-cloud-security:scantime:2.070
DKIM-Signature: a=rsa-sha256;
 bh=4ePWzt8bowD1J+dyzThZ0RZjK2o8T35khtKdgWXWzJo=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759830908; v=1;
 b=Kz4GTXQ1XlP8aZSL/F9zTESU+jF9MNsN/hzvHkTL7T7Q4fDkLD5+DYunmUhsRcBdlkNk57Op
 mytbLrYxg7rQ4yTLnlytgJnsMfAYPU0Ul2pb6yAaHELJ2y2E97JyabBLF1hN9nzMLHUt3A68Dyp
 scYPoDdQ4c3IVSQOMRAp1G+znoFSIi7+6w+/ts9MWRJVI5QTpC4iqiXjKe2Ae8AEcwZp51cLcOw
 wop0R/TsqM/OofIN/wh74rW250xznMZup6KV3gP5mSS1Vyf0jCJMczqLCydECfQiuQ/1bMyYkXb
 RvBo6HIqArICJCIA95Gnb+/M8QLuErmYcDD4LFBIJEksQ==

This adds support for 2 new TQMx86 COMs:

- TQMxCU1-HPCM (COM-HPC Mini Module with Intel Core Ultra Processors [1])
- TQMxCU2-HPCM (in development)

[1] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmxcu1-hpcm/

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 1cba3b67b0fb9..1c2fe3f912389 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -43,6 +43,8 @@
 #define TQMX86_REG_BOARD_ID_E40C2	15
 #define TQMX86_REG_BOARD_ID_130UC	16
 #define TQMX86_REG_BOARD_ID_E41S	19
+#define TQMX86_REG_BOARD_ID_CU1_HPCM	24
+#define TQMX86_REG_BOARD_ID_CU2_HPCM	25
 #define TQMX86_REG_BOARD_REV	0x01
 #define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
@@ -165,6 +167,10 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMx130UC";
 	case TQMX86_REG_BOARD_ID_E41S:
 		return "TQMxE41S";
+	case TQMX86_REG_BOARD_ID_CU1_HPCM:
+		return "TQMxCU1-HPCM";
+	case TQMX86_REG_BOARD_ID_CU2_HPCM:
+		return "TQMxCU2-HPCM";
 	default:
 		return "Unknown";
 	}
@@ -185,6 +191,8 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_E40C2:
 	case TQMX86_REG_BOARD_ID_130UC:
 	case TQMX86_REG_BOARD_ID_E41S:
+	case TQMX86_REG_BOARD_ID_CU1_HPCM:
+	case TQMX86_REG_BOARD_ID_CU2_HPCM:
 		return 24000;
 	case TQMX86_REG_BOARD_ID_E39MS:
 	case TQMX86_REG_BOARD_ID_E39C1:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


