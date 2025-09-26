Return-Path: <linux-kernel+bounces-833958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D35BA36A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1477E38553D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC22F3C15;
	Fri, 26 Sep 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="SoE0hSHn"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55E1A0728;
	Fri, 26 Sep 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884301; cv=none; b=Ehkv1JZmnA4IUp365wgRomL+xBb9UIMT0DxyJQ8ttRVjDmn9XZWdaOj1ZK1MKpcD0pCQ5/W0t0YJej2rIAUJvgglLhc0iFJ7KRKCcSEvonOVQo7LjVHbuzZepnSivsHaHWK7pzMDOu094jYGvACSWO5ogZW3FzjfsVEQ3eCGV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884301; c=relaxed/simple;
	bh=6xMqwN1K48HFPeQfpozsi+RDyW+9cDj391ewWhcbO+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJSDqzC0obvfwrKCyeDt56nT8NN15xPvrKHg0jKN3btH8Osfk48KtQfqiroqBORHr3fOjVE8W44wAvmNDSgwOy5/aGyOVJkut4vQa2xWb3Fp1OCRfxm8c3SPzhecXHMM+0lVQmeVIGjMz0kpgeUGsnSuOLREu1B/rb/8SSQuJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=SoE0hSHn; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QAiC4v1879977;
	Fri, 26 Sep 2025 12:58:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=vk
	EunV1KBQ7ghw7cGF+nRAdebricNzU4mNgjoDPs7ME=; b=SoE0hSHnfBhFdiDjtT
	C0buTrCsix/gNQsRW7e+8rsYoSTshFy1e7Nfdd0DApwd1hFOptXeJFPdvdu72BIz
	h4Xp+ttJYhL3NCUimtWE5iz6gbjWBPJ5hxxDEn9MvuNh9K+z478rsiy3OfgO/1ja
	fZGMHAlRf0vLQ/xqnTJR8DTcDLOQeTcA7kKu+MvVubeTLNn/XuQp/ikmF1krL5Sx
	7uUxLXoUPWGNroDKnCvqqRkbvE0dZ3pCZ7mPUljKpCTcE8L2fTi2DmsMJxVqv0XN
	77cX4/iOT/eWvkFCNEp6h/z7Tw5lc253nOAj4ya5KuCTwcpRa25Hb0FBNa9RRcTw
	Vmpg==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt4g84c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 12:58:11 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 12:58:27 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH 3/3] scripts: dt_to_config: fix grammar and a typo in --help text
Date: Fri, 26 Sep 2025 12:57:49 +0200
Message-ID: <20250926105749.209674-4-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926105749.209674-1-m.heidelberg@cab.de>
References: <20250926105749.209674-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-GUID: dTadPejI04EJMxz2YVdXUJ03-WsuNaFG
X-Authority-Analysis: v=2.4 cv=XdWEDY55 c=1 sm=1 tr=0 ts=68d671c3 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=GkquxFhGB3ijP0pvFI0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dTadPejI04EJMxz2YVdXUJ03-WsuNaFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMCBTYWx0ZWRfX47sOcUM42tUo
 AFNQ54RiskKCYD2Y+Tj5RlMwOlQg1gcaFO1o5frdP2rELvLL/m64N1PRzXreN8y0LXE9cCi7eSh
 5kiwnJLtEEEqJvmdV72wf3wWwZoTsgXXwhBsGdtWw2XioF0+TDbznvA8rByPOKv0cpqnG+i+rEe
 15C71gDqGXn6EjK7xFMSSSy8l4jZFsymzN11PqwEmDdEi602N1HaZiKUOGgiFZjlxLR8ktJ2c1I
 jDiqCFnD8VDO9e7ny1QX3iC/hlzi2Z0tgE+b39MmqfyLtcwfyJ7XQU5c/5AYD8pGqCTQjvsMzSb
 r8ObgPzE08PGMiA90OMYu5zwOXFMAaO5NC5ytL7EjpoSPs9toB8szLRG3iTd/y95pepayeTlCW9
 dT6Z8NI67AnowFKwlNFafOLwlpV1Cg==

- grammar: singular/plural inconsistency
- typo: "of" -> "or"

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 scripts/dtc/dt_to_config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/dtc/dt_to_config b/scripts/dtc/dt_to_config
index 299d1c2b20d7..70d6d5f06bdc 100755
--- a/scripts/dtc/dt_to_config
+++ b/scripts/dtc/dt_to_config
@@ -51,10 +51,10 @@ $num_pr_flags = $pr_flag_pos_config_test_fail + 1;
     "compatible is white listed",
     "matching driver and/or kernel config is hard coded",
     "kernel config hard coded in Makefile",
-    "one or more kernel config file options is not set",
-    "one or more kernel config file options is set to 'm'",
-    "one or more kernel config file options is set to 'y'",
-    "one of more kernel config file options fails to have correct value"
+    "one or more kernel config file options are not set",
+    "one or more kernel config file options are set to 'm'",
+    "one or more kernel config file options are set to 'y'",
+    "one or more kernel config file options fail to have correct value"
 );
 
 
-- 
2.43.0


