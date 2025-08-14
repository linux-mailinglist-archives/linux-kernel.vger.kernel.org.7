Return-Path: <linux-kernel+bounces-768696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03FB26442
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C29E5E22F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34B2F39D1;
	Thu, 14 Aug 2025 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="zhtAFILE"
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639B2E9EDB;
	Thu, 14 Aug 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170921; cv=none; b=LWkCvg9td7Q+8dVNsbV//lk2PGjNeqJHH6S5yE88a4gGYGrPNsTe7LTyI2cEBuOiAgtY/1yLTFqT8K4WQnfz3g1sabO1lUKSk9MDlh4vYI7XW0mIK4sythAvr94JPFnMexiXA3XvOS7ULR5d+xJa7Sf25dxAxCs1v29ksCrCJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170921; c=relaxed/simple;
	bh=wpGGVHhLjE6n4GKS18ugJuxE8ffwkBgiBgUXM59+b10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6X0LsFpJryqNIGW4tNELuKrcF9SJeCpgVgZpGVv3s+CCICWFXNr+Knzwg1p6053j23CpkX56NDTHR7lylCbpT9xrZ4Ad04OW2yud75VaaMMfe2xBdN0JytqUJm9APhqkgR4B3fXhkVxuooyPaKeQnAJb/QwGIrqLnsNFMaSzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=zhtAFILE; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57EBGRg22316998;
	Thu, 14 Aug 2025 13:16:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=GB
	jorvDA3HPkIVr2+0nQydEbz/Zfef6zsEQ4v5OuB9E=; b=zhtAFILEg9roBYf8Ey
	2RVAqpV//ZBT9GrL2DvBxH3ezh/ETilmySdCg1y6gT9y++tG1hjX7u95RwY9Goxz
	BdsyPjZEZrp+QbajgkEdRMjIMtBIpLtlyVWV4EvjYHVY3onp3mMTMUYhyJoiiFo8
	UiEyveuTROGn1+pC8/v/zd0PVvkukNsDGV1Agw191Q0ipOBf4Tf1HxkMA/HOzIhv
	swJ07ZpGSkF+tsGNZBSXIOcfoz6yHJElotvnmX5wHdBl/gdnjrmzsGgjDnFYVfhH
	X7Jzcvnvh1gyxF5LIOnFy3Ks57H3wiMgl+uXfNJ9HDD2scqimbgTpzkZc9zOaDzV
	LYKQ==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 48fq5w10wh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:16:27 +0200 (MEST)
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
Subject: [PATCH 1/3] dt-bindings: eeprom: at25: use "size" for FRAMs without device ID
Date: Thu, 14 Aug 2025 13:15:30 +0200
Message-ID: <20250814111546.617131-2-m.heidelberg@cab.de>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA5MyBTYWx0ZWRfX6Tuoi0+xX3Ln
 wO2Y2JsohVJM8jgPQumTzm7xByRDqSj45QwN160+Y85KiNF2QAaJyoGZf4Wo3G+sEVtxL1o2drU
 Uhss827ckYuTvgFsapuA5rxUtqJybl63vbodO3L/pMO+JrZYxhLB9ymxcj5MyN6JoTOTkFspYv5
 jOnlv9s9+lOG+93wpb9RMrIt0SjUhVDDJPNrZh7ixW5EpmGytB0CA0k5C1Lhqcl3YrJRjn+tdme
 iN+3pWI0keQ8nn4rO4hWecaSxgHy48RZO3uhcJtbpGZNXb43w8fNK+ExFIvexuuBF97zwHDv4X2
 ShGnQbRH7UMEBVh/tGuYmWv/vwP4Qt9eR99eh7ln1a9a2Q8jXi0ukA9xGqmzYI=
X-Proofpoint-ORIG-GUID: 85cKqEuc4ri-QMem8YHXBn0DopdlwJdT
X-Authority-Analysis: v=2.4 cv=eMkTjGp1 c=1 sm=1 tr=0 ts=689dc58b cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=K2GD-7p5giEA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=8QyJCB_uBBKMM_hJN28A:9
X-Proofpoint-GUID: 85cKqEuc4ri-QMem8YHXBn0DopdlwJdT

Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab.de/
Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index c31e5e719525..d6fe84091ad4 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -56,6 +56,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Total eeprom size in bytes.
+      Also used for FRAMs without device ID where the size cannot be detected.
 
   address-width:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.43.0


