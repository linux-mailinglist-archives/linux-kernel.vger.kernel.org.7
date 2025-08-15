Return-Path: <linux-kernel+bounces-770678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8EB27DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C731CE6677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D642FFDEF;
	Fri, 15 Aug 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="Jy0V77Vr"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBD2FCBF0;
	Fri, 15 Aug 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251957; cv=none; b=JVd0mHBpy+BfDgPD+NlIi9cHx3cCtw7FYNX/HLyVfOwVa0fQtaRZK928kYMfKy3te/An0KFFXUgs8+Ng74N6PrKBtaciyB+BB3s22nyCRFZjUsdtP2c2XdiGRB7dSx0qyH5rLWA7NSrPkuBh5k7KNTdZwmUW63bl7eMvvNlAaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251957; c=relaxed/simple;
	bh=bFtem6bal3ozKFQIhj24cxDStk8G+Bf8rrvgaQg9RkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqbXRuXkCrsyDD2X6CuXpYD3A5Vn72a9Fzg8whs5WSRWvZQ8g5KrXc8AJ9lfRmoR5tFN1y2T4lf0a0xpl2xeBiN/dqHnrWRyRCGzu1Vz89oxCMwDrpRL8Hy7kbisMbkG79PayUNJWmQO16NsbfK9+BeAVbdjiyuGa0dkFrmEbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=Jy0V77Vr; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F9wt87265753;
	Fri, 15 Aug 2025 11:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=Ys
	PmJmggYIdtvpY+JvdYm/4kgr5qIWEnATsmjZlXaWA=; b=Jy0V77VrkuETI8CNR/
	TOgyuRF1jXtQw76yaJ1unQxncP2e/v2P+RwQBpWS4qCE7Y2qzxoXHwgM+0fzMoCe
	kbkU135io0iQW5Do4h29XDxThlWtsaZmDRqfOx/1KT6hKt6EJw5nFskj93uFuwis
	byUUZ3dNabJSnOAadGXU/oB3vDLMFlDY+0rBnLYYFfjV5Tbv9PDHES/eG+fsOomi
	TQ2jho/ZXoSTUI5zMLsXr+1zjDqd9aR/XJVY8u+n4WtOeJ1RUaTdZcSD2YHZCeFP
	DZe2kLWSYhhxxufsx/k8rgbEqnV2xgwYYYj0jM7zgmjlgQAxNhK2Ck32ChQS/AZS
	6VNg==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 48fqcpsbfb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:58:56 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 15 Aug
 2025 11:59:12 +0200
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
Subject: [PATCH v2 3/3] eeprom: at25: make FRAM device ID error message more precise
Date: Fri, 15 Aug 2025 11:58:38 +0200
Message-ID: <20250815095839.4219-4-m.heidelberg@cab.de>
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
X-Proofpoint-ORIG-GUID: FOP4TzmLZxLnHahOUlaOhnkgUB9CJtuu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA4MCBTYWx0ZWRfX2vxfAdB/6vLZ
 I5TCKJDPQ4SMKBypCyIQuKK9obAMoKu11pWaqZKHEX7L5mqAvQa+OSE/r/8sJCd4tbKrzG4WE14
 KdhDdclwiXB8HuhR9+j6qsz1vnYPHRhUQaiAjNyac6RgGgE+QG+PpJj8lFZiXJHffHSnHv66ov8
 q+ov8oOvLP43U9USjLhvM8L5kBonnWLnXYfkAFZFRycJ4p3TJRbbMn1rRHabtwo9zTG+f9zLKKG
 CV1jB3USGuHKL5Z7Gh5cnWXfY18gCNmrPBn3cvJcqCAXgE+3dkyHN7uH55LyhHQiChgf615nTTP
 NCLJAdmE5zsdg3HLC74IePy3ikbYtUSNvjEjrcxyFXJmhwrR8V335D2gw9uWX4=
X-Authority-Analysis: v=2.4 cv=bctrUPPB c=1 sm=1 tr=0 ts=689f04e0 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VCfmM45KO3mYAKdcRPcA:9
X-Proofpoint-GUID: FOP4TzmLZxLnHahOUlaOhnkgUB9CJtuu

The error description would be wrong in case the "size" Devicetree
property is missing for an FRAM without device ID.

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
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


