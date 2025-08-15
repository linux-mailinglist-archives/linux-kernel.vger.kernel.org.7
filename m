Return-Path: <linux-kernel+bounces-770679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B16B27DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB03AE58E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA12FFDF0;
	Fri, 15 Aug 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="BHVkfmRH"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3C2FCBEC;
	Fri, 15 Aug 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251957; cv=none; b=Oi6u7gl42H86Xi7HTf9EdQaY2nBHGFgfvRC0zLc3UGHCa6UgIn/ScGxI+lu4jR0o0S5PTx2J/28BpVuH4wXswBU22LK7y+CE887bwnzMVPOQyTy8HvCuqMADjOXuQ245NKqI856+4at5knr9cN/uxhw9gCytZguluL6FO/NAaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251957; c=relaxed/simple;
	bh=JrZBB9SjSEr3RHgKI0yjaY++p4/8sPNT9N7zdkldrT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eycBiiSkFAvXJ9q5gJJ66unzr/BtXkDA3hGQ++aa/9YlhbTye1ghjJ+DBhZCG5dyhoAcvtTKNDxzxnrqhwZlK0Ocd+Tmwr2KQMSfsS4WTuYYr1R/zC6beMBBs3MW8/qZJIpnsKm2dN/nVFOel0awfDQM1J/UqntIAaNKv5rWKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=BHVkfmRH; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F9wt85265753;
	Fri, 15 Aug 2025 11:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=ws
	dFspxcJ7fT6GiwQeEWt/cQe22eZH3hxAMd5rKDcBQ=; b=BHVkfmRHJKg4eyRlXI
	Ty5U+k72lnVs63h4rr55WUCy0w2FfvBpVGl3sLJD45FvefMjrmiWvTlrwNwaEjkW
	cV95Z928DP8/FVyIGA+JujMthNpRRupgPrErMAxP1HuDbPvXL5SHahAcAIJW4p7C
	7vrQ/EaldVpKQNu1s7h5PH6Kw4eh+E4BnDoT11WxARtfx7w6vrWcNF/h87MnlqvZ
	sIQGS3f8hLGPQAIBX5qR6vyN0K1lQkVVXbsn4QkVPam4MNUVhRGASwhhHp8watr8
	Apu19SmeN0G7z/u2q1hnu4AXDnZ5g2VZAWUSZejX/+yyPWfrsrtudIMFeMHHGqEo
	7A6A==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 48fqcpsbfb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:58:56 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 15 Aug
 2025 11:59:11 +0200
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
Subject: [PATCH v2 1/3] dt-bindings: eeprom: at25: use "size" for FRAMs without device ID
Date: Fri, 15 Aug 2025 11:58:36 +0200
Message-ID: <20250815095839.4219-2-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815095839.4219-1-m.heidelberg@cab.de>
References: <20250815095839.4219-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-ORIG-GUID: xJzdvML5RlH9LQ9zc2t49L7GhaIygMk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA4MCBTYWx0ZWRfXxh0tlf4dDdSC
 ODfMyG0CSXhG6+iqanpSqdlnkR7+hzxYxRpMmNmEIDBmJmLyTJBXU0uPO3AjfNdRZ6sEToIIp5n
 GE0yMhkvPV4dSP5tJwOUAFvrre6dGpfd2oUDJwQbqqxWUAODobDcq4AjLvDYkqjuj6pC7V1WF2C
 CfrZm2AhLxSr/vo+R5eyWJvUs3FSTjST54KVEdHgS0rF7+8X6Qhe8EtAOaagJlpUlYseM8f5Gwt
 C7YVA5S9acuda5NNj43GikC/Wb/OKQ2OMfBVGJR6GjADKA8zyjok/X4Sq1ADC8TDZ2U9NY+uYFu
 mgp0DVwuy6qVRmkwWfBLiREvVudPNXYBRO3afXujJ4zLCyfJpnHIhcLFZWyBaI=
X-Authority-Analysis: v=2.4 cv=bctrUPPB c=1 sm=1 tr=0 ts=689f04e0 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=WIdweGkvO5YuuAzG6HcA:9
X-Proofpoint-GUID: xJzdvML5RlH9LQ9zc2t49L7GhaIygMk1

Not all FRAM chips have a device ID and implement the corresponding read
command. Thus the memory size, which is contained in the device ID,
cannot be detected and has to be set manually as it is done for EEPROMs.

Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab.de/
Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 Documentation/devicetree/bindings/eeprom/at25.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index c31e5e719525..00e0f07b44f8 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -56,6 +56,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Total eeprom size in bytes.
+      Also used for FRAMs without device ID where the size cannot be detected.
 
   address-width:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -146,4 +147,11 @@ examples:
             reg = <1>;
             spi-max-frequency = <40000000>;
         };
+
+        fram@2 {
+            compatible = "cypress,fm25", "atmel,at25";
+            reg = <2>;
+            spi-max-frequency = <20000000>;
+            size = <2048>;
+        };
     };
-- 
2.43.0


