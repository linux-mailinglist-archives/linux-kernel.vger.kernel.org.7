Return-Path: <linux-kernel+bounces-768723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F00B2648B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39601CC1D29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28232F99A6;
	Thu, 14 Aug 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="CtMVTgbN"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEEE2F39D8;
	Thu, 14 Aug 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171790; cv=none; b=p+W3dIYlG0a4fS39S/DuI4ZlY5ZNfZnJva0g4pGuX+Tr1XZi13vnQpFWp2ziXde1h4sMJYl0pssWBPZRJirGSaKUtIIpr/I8Qb+LDtcmJ+CXlSOhRGvgcyDo3aV72Invh/qn86+fOFIq4ToNfmGgQ6zF25vMnzm/+035Wra7FkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171790; c=relaxed/simple;
	bh=MPsbVqQ1BUP3yVgmL+E6RR4UbMs+l8z2Xhj9FN/RhTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsy3kwq1YZrI7gAPm7G+jiJD9uIYT4vemhW/E3DEXVNDIy6rUOvBcQqZ5MfkYEvInZu9sw+qugGs1z9DpR5QH/BKB9Ilgn1BDHgJ77Kpkz0l2N1MeJLAaMV9Ffwb3cyWTCfWiIJwWzeIw2vi0lwQHIadCjHXMX6jwzPtH57Xo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=CtMVTgbN; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57EAw6TT2274087;
	Thu, 14 Aug 2025 13:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=Ri
	sNjk6GkS+k71+3EtfCKvjlJdsfL2I8vNugJNfplWo=; b=CtMVTgbNAGkTaMKCiI
	8F6YpmTcBaU2AW6ZCqlcWRV9mCt3hv98vPJb3AxheliL4Rp4m/ZrpvZxp87uApDO
	U3i0NT9PJ18IYWKtEYes7VFFw9can+FptQteROSyNmr9+zx/qGKiJL63x8zlMYXt
	/Pu3Nh0M2FLEhBd585irLT2Yvb8hBVr0RJ1Z+uTKwv7McppveW8YZj5PXFIVOnS+
	I0ZpIH3hak3/IDGh0YI2yHNFHrKsdq3Y9HNzde9O6XeAvuuL8DuxuKO9zpI/ft0/
	6tDCkL6+xAsbpzTtEWg+xPmCNJ/NL9zF1BHpHM+02pkmcxybdL9ZW+2UH9cSw6ya
	Vm8Q==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 48fqcpryv2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:16:28 +0200 (MEST)
Received: from KAN23-025.cab.de (10.100.0.18) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 14 Aug
 2025 13:16:43 +0200
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
Subject: [PATCH 3/3] eeprom: at25: make FRAM device ID error message more precise
Date: Thu, 14 Aug 2025 13:15:32 +0200
Message-ID: <20250814111546.617131-4-m.heidelberg@cab.de>
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
X-Proofpoint-ORIG-GUID: tlkgeSqEmLwMhe9rMO4G6JAdvae55LTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA5MyBTYWx0ZWRfX0tqB4F4flIdg
 RuTrfeM4yD1BwgUGOKktQ0/FoGWk0hIrnr7qlBu8rol1srzRSZX4W+udKtkeyb0EhqXz0+QzX7Q
 KM/Bjejz0R7wDvK4Cn1XfBpA0MWVab03NEJRkbjhLKTKS/5NsqkokaGJoJrLSWnlbC/7DAzqznZ
 ws4Ljzcqn3p2NADRE1lwlF/tmyuEPs7dDyDgE13wKN0A5kqgjVRuiJifPiv4Gw+d7AOWusaq7CV
 qR31IxXgoGCXQXKELUuqN2ty8eVfRLImE8Bt/7mnYvkdtOW734Kxej1UqkjM1tRmOE9T/mirCMU
 Nqyojpox5LTF2vlJoYxXelMayKTAXfPV1PtcDqFJX4x9GswsRk6NEE/H+R8HP8=
X-Authority-Analysis: v=2.4 cv=bctrUPPB c=1 sm=1 tr=0 ts=689dc58c cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=K2GD-7p5giEA:10 a=2OwXVqhp2XgA:10 a=VCfmM45KO3mYAKdcRPcA:9
X-Proofpoint-GUID: tlkgeSqEmLwMhe9rMO4G6JAdvae55LTM

The error description would be wrong in case the "size" Devicetree
property is missing for an FRAM without device ID.

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index c90150f72836..e2868f7bdb03 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -399,7 +399,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 				id[j] = tmp;
 			}
 		if (id[6] != 0xc2) {
-			dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
+			dev_err(dev, "Error: no Cypress FRAM with device ID (manufacturer ID bank 7: %02x)\n", id[6]);
 			return -ENODEV;
 		}
 
-- 
2.43.0


