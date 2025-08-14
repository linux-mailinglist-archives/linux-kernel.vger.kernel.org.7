Return-Path: <linux-kernel+bounces-768724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D5B26489
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DB27B4B92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC02FABEB;
	Thu, 14 Aug 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="l52o50km"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE772F39C3;
	Thu, 14 Aug 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171791; cv=none; b=GGEG3HV2wR1Bhtyda4gyPMFKj9pLZV8jMezZogUm1etRpQPpnwJzD3YB372eHW/KRPn5W/5Iq96ky6wQESpAPHKbw6w51s+K4SPuYq/pWWsKWyp7wo4G3H9oJlof6hnPyjzErdKm5U4Ak9z3yyJwuKtuZznERhK1FoQgtImdxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171791; c=relaxed/simple;
	bh=upg5JXhZmmO3FSdjgRQHF5NKe2rl1q3xV1hXDjIVTkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaVImTLUKZjwD6Fs2qekA9nD3Q94DAzp48tq6fXdUTjrenKXNJ33eOJkIjAOiU0FObg1ZE8M2QRamx/hlD0LQdaEoOwDq0sACeoqj99E2SmosByFsdgZeTwsllq6jNAbDx80A8JwijDjsTj+e9exbIzH7HlbYXkfWCJ52iMm41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=l52o50km; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57EAw6TS2274087;
	Thu, 14 Aug 2025 13:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=BE
	yDH2oXAwii9qcOUqMXBqBnedSlZHxU+h9s7+WfNso=; b=l52o50kmL9b/P1xJL4
	l9L/7geDRKauwf9iZX39OPwLlFI9CXbNgrobAF3EFZr6KNIK2L99rIInW5jpXwIo
	M38Ed05DAvfKY4xIqk0E0i/eRLW+7qlrmrsyptLJlb1RFmuiNB9WPB8OMGGzv7mj
	yjo717mD3BtgwQmq+Fu+yo8M7hnMv3eJlN7R220vY+pjJMfRvqQlHmX0gjHDYbaM
	C6tPXxzJZszFtzA5cPJlV5FpWzbm5yo0EfTa2PdROUS+sUx8LXEQ4WXO9jYnIMb+
	ACQur8MV2hIzuMHFVTeLYKmriDeCBSQ2fqAr9IduMNBcbOukHHiEYgto/2LNzW8B
	KNIg==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 48fqcpryv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:16:28 +0200 (MEST)
Received: from KAN23-025.cab.de (10.100.0.18) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 14 Aug
 2025 13:16:42 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>
CC: Markus Heidelberg <m.heidelberg@cab.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Christian Eggers <ceggers@arri.de>,
        Alexander Sverdlin
	<alexander.sverdlin@gmail.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] eeprom: at25: support Cypress FRAMs without device ID
Date: Thu, 14 Aug 2025 13:15:31 +0200
Message-ID: <20250814111546.617131-3-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814111546.617131-1-m.heidelberg@cab.de>
References: <20250814111546.617131-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-ORIG-GUID: 6ZdVIAaDRQQe1cOv17wH31CWj4VXTz9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA5MyBTYWx0ZWRfX7obF2Me047TK
 7ahLkXO3c1in7crCSIIEFeP3jY/XR06YqZGxjqhsdjJarBry0DCppUDPfMNrRdW2yWPn2obkcC/
 e/2Bw5yC8+F8kcUxrHB6MOs0axVMeNt9rOoDplFA03XZkaEreYcOGs/NHsZKMhYQ9yqy+v/1fD0
 pq6kU8Rv9HGn3LegazwoNHzFBPUbcipkEgp+jeyKpwbdnAj+BPf6th6LWp1tNvfTpKRQNWiImHB
 jHZgEhccncSGvrDyhQmFoM071LUWcxUktUUZwhe597DDnK7VaUndnBl4iP2HzB1rabBgSz7bdau
 KSpesu+1LyyYr5HCtnweP8cRDZMPtLpzCBvijlB+QFo0NiCU+TrXUR06NWN4xk=
X-Authority-Analysis: v=2.4 cv=bctrUPPB c=1 sm=1 tr=0 ts=689dc58c cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=K2GD-7p5giEA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=rCJ37w5iS5YF4Iu26g0A:9
X-Proofpoint-GUID: 6ZdVIAaDRQQe1cOv17wH31CWj4VXTz9k

Not all FRAM chips have a device ID and implement the corresponding read
command. For such chips this led to the following error on module
loading:

    at25 spi2.0: Error: no Cypress FRAM (id 00)

The device ID contains the memory size, so devices without this ID are
supported now by setting the size manually in Devicetree using the
"size" property.

Tested with FM25L16B and "size = <2048>;":

    at25 spi2.0: 2 KByte fm25 fram, pagesize 4096

According to Infineon/Cypress datasheets, these FRAMs have a device ID:

    FM25V01A
    FM25V02A
    FM25V05
    FM25V10
    FM25V20A
    FM25VN10

but these do not:

    FM25040B
    FM25640B
    FM25C160B
    FM25CL64B
    FM25L04B
    FM25L16B
    FM25W256

So all "FM25V*" FRAMs and only these have a device ID. The letter after
"FM25" (V/C/L/W) only describes the voltage range, though.

Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab.de/
Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 drivers/misc/eeprom/at25.c | 67 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 2d0492867054..c90150f72836 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -379,37 +379,49 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 	struct at25_data *at25 = container_of(chip, struct at25_data, chip);
 	u8 sernum[FM25_SN_LEN];
 	u8 id[FM25_ID_LEN];
+	u32 val;
 	int i;
 
 	strscpy(chip->name, "fm25", sizeof(chip->name));
 
-	/* Get ID of chip */
-	fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
-	/* There are inside-out FRAM variations, detect them and reverse the ID bytes */
-	if (id[6] == 0x7f && id[2] == 0xc2)
-		for (i = 0; i < ARRAY_SIZE(id) / 2; i++) {
-			u8 tmp = id[i];
-			int j = ARRAY_SIZE(id) - i - 1;
+	if (!device_property_read_u32(dev, "size", &val)) {
+		chip->byte_len = val;
+	} else {
+		/* Get ID of chip */
+		fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
+		/* There are inside-out FRAM variations, detect them and reverse the ID bytes */
+		if (id[6] == 0x7f && id[2] == 0xc2)
+			for (i = 0; i < ARRAY_SIZE(id) / 2; i++) {
+				u8 tmp = id[i];
+				int j = ARRAY_SIZE(id) - i - 1;
+
+				id[i] = id[j];
+				id[j] = tmp;
+			}
+		if (id[6] != 0xc2) {
+			dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
+			return -ENODEV;
+		}
 
-			id[i] = id[j];
-			id[j] = tmp;
+		switch (id[7]) {
+		case 0x21 ... 0x26:
+			chip->byte_len = BIT(id[7] - 0x21 + 4) * 1024;
+			break;
+		case 0x2a ... 0x30:
+			/* CY15B116QN ... CY15B116QN */
+			chip->byte_len = BIT(((id[7] >> 1) & 0xf) + 13);
+			break;
+		default:
+			dev_err(dev, "Error: unsupported size (id %02x)\n", id[7]);
+			return -ENODEV;
 		}
-	if (id[6] != 0xc2) {
-		dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
-		return -ENODEV;
-	}
 
-	switch (id[7]) {
-	case 0x21 ... 0x26:
-		chip->byte_len = BIT(id[7] - 0x21 + 4) * 1024;
-		break;
-	case 0x2a ... 0x30:
-		/* CY15B116QN ... CY15B116QN */
-		chip->byte_len = BIT(((id[7] >> 1) & 0xf) + 13);
-		break;
-	default:
-		dev_err(dev, "Error: unsupported size (id %02x)\n", id[7]);
-		return -ENODEV;
+		if (id[8]) {
+			fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
+			/* Swap byte order */
+			for (i = 0; i < FM25_SN_LEN; i++)
+				at25->sernum[i] = sernum[FM25_SN_LEN - 1 - i];
+		}
 	}
 
 	if (chip->byte_len > 64 * 1024)
@@ -417,13 +429,6 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 	else
 		chip->flags |= EE_ADDR2;
 
-	if (id[8]) {
-		fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
-		/* Swap byte order */
-		for (i = 0; i < FM25_SN_LEN; i++)
-			at25->sernum[i] = sernum[FM25_SN_LEN - 1 - i];
-	}
-
 	chip->page_size = PAGE_SIZE;
 	return 0;
 }
-- 
2.43.0


