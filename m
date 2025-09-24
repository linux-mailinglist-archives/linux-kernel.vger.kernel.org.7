Return-Path: <linux-kernel+bounces-830367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E579B997CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83402168145
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6832E1EE1;
	Wed, 24 Sep 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1sZffysP"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021085.outbound.protection.outlook.com [52.101.65.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2E2E1747;
	Wed, 24 Sep 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710949; cv=fail; b=YAdP0fXZd9ViM4sK8RmR1LQCDRHX6Q4u5g9i/s4J/aQlsLM4VCxrvo3ccvbt4epJxGCCtGKKDx+CsMbFRFb1cGRy4BB4qPURzpDbGPa1MFX7nR3i+ZHiYetEfGnwGfN2q/k4cP3+9baVoMiTD9qpndOFPokSrUK1GlQb45/uuJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710949; c=relaxed/simple;
	bh=iQHi+15vFLbIelGkizQRrINT0RFjAjEFnJxd1LAAeLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgNfXXi0s9E0ant0EDLKcpgPyBh+rHnuvSNUgFjgQ44Iv11ZIIsU/aIHfAQO3ivGgbIjlsHkyDeZVI2sS8XnEa2NIUDelHM5J1QsQvyB4kRb2+zML2jy+fasFxd8k7jlwND1nQ1CcyRsS6Hje/Ncxs7+RnxZ/VpvDSsEHpCma94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1sZffysP; arc=fail smtp.client-ip=52.101.65.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6sDI+tw/RPrif/dwVS6HbNBAQ06aU4LLB7Lnz+NKolNJDYAzusCDckozULDbtQ7GvYqUDdQyKPPgWdeMvKKmArsQIRWXtJmhIn98F34qhEGMHR3z70xFC+vnwpIJX4CmvAtMTAr0zUhDkDvc6RACyZ8cnrtkA4YHkZR3wW+ybsxFIZ9VgzbsjPcR55QuC1rJAqkdU9AHtYEBVIj7YgwBjEu7E3p0vL0bZat/6bANW170zIF/sfhP/i/B1PH+fk7VNjgECKrrdJfv2htuM+DPXB9x1bAYAfXKJ6FyUF4AlSLD9yf1lM+w3CqPcns9kDuf0YjxZS3jnm7KUdGG4b2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th9QqMg21D3uTdyRRQEqRFK5ruIlzO4hQtaLw4ZD5VU=;
 b=VJfM1hqrL5/TsmiA35fDaM8FIoXPKSIXUfTklPN+EbAea/U0svG+nhzTBNWeIR2A6ZzOT6FfwVOHq7qIB1GOj+lLSmnKKYj8vWupHNxE089mUN8ZGnTf4mEYznyhxReOLPYWJtJJiqsuxZSwitG6i609Gw8mF6TIqN389gggtvMmTsIemhpJm1JPmTOz+HXZQbHb+PbJML15sGt2Enxz6KLqUBbRIxLQGnUok0hUYfZ4+3OtBqiNovTGN1YUQg955c403wkMGSkVk+3ZcexJnNRcJWT+pCdmTlNVnNOGW5Q3h37cOrhiNmO8hLLdd7Jc3FZXAXRMrpsrj2Mr0PX7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th9QqMg21D3uTdyRRQEqRFK5ruIlzO4hQtaLw4ZD5VU=;
 b=1sZffysPU4Hh9b3N/CwCayuhpI74gcmr9Xhoyt44plPZBn5YF0Mf3/5FEJO//P/gm+09JVoTCWK4aCsBY09lzRJhTyeZqq6FPrklY8/T4Rbe3Fvodw97XGVhuKuPnDsAnOw6CHNS6DhwSVtEc9fwvric1oQ73+2WxwXjqKQxrhsAgB1CYTqIJnEMzri4V+GaA+51o1SOKLnTmpEgy5vj0aHvjkmVLfKWtWLZIXVbGNfK0W3nbbOWrV21cq74bV6GjG8BXDBN2mNgCoy9PNEM+j+obYVXSfjFVfqlO30eBYSCwPMcuV/q2Qtpj4TKg1uujKI4N/UJ8DPwJg/6OGmr6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10010.eurprd08.prod.outlook.com (2603:10a6:20b:64a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:48:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:48:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 1/3] dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
Date: Wed, 24 Sep 2025 13:48:48 +0300
Message-ID: <20250924104850.1930254-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10010:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f0fd35-43d7-4c5f-fd00-08ddfb57f798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E8Xgy0wFoBM7B5/qXqqOUE2gW4vJOiyANBz63nTyTiZZCmQE3Tscm4mmQUSG?=
 =?us-ascii?Q?GA+ysBrucOThwSAN1xGtDwyB+Y6JnG2TmusWiYHAA8Fa5xlF6RXPhVYr+Q6S?=
 =?us-ascii?Q?UPsru7DLGNN+iIUyDRbL9ww/pGws93C0OwMEDgc91dt8pAhQ4HTlnmYarxh5?=
 =?us-ascii?Q?J6QaZd3D9g8dcdNOQshNkxc8owDk0eYuecSgXK7+NqpwFMfKEzJUqO4NnARz?=
 =?us-ascii?Q?n7f42BewyWUkHRQdKknj2tRzIGUp1VxhakCvnFezJnW/NIRETEDXt3jPTbAR?=
 =?us-ascii?Q?lSX+sZQK2crBSxtMKeMtGvu+90Dh1GhclUQe7XiNGBYXWBsIHklJWGQ90Gug?=
 =?us-ascii?Q?SbyYmsWR5BKevB7OunMQoV+bgb9jEip7EJSCI/sQTnLUbFMSjUWoXpoOJEKj?=
 =?us-ascii?Q?2QJq8eXdAa5ErVFof9u2dumKKABjFSTSOmEKvLEc2Zqlny3UaKW2h7SLguLo?=
 =?us-ascii?Q?N6vLejcq2mpYWbOmYvhMn8N0LTAr8Vp+YdP3fBIburdkdCWNcxUs2gKMwFTR?=
 =?us-ascii?Q?mVMmNl6XRMD5w7oCqjlUx1Grom/zr4zNsINWe60xLXwwFRcNmQdLR3Hilxpz?=
 =?us-ascii?Q?5BGqS3o0KsTrh3IWRHtCCiD1QJKji8ZMI1SeTve4WG2FiFW1Mfcy/NAbDISs?=
 =?us-ascii?Q?mkf/ixwGH6spXjy8pdEvEmnfdfZf0Oj3sEHf71LxCEx08x9cfvFW6gN2t7v4?=
 =?us-ascii?Q?nMq1hRGoDij572OSY2VHccalVe5ZdQfNC2PCMECvefzOMLPxuJgcXj6g9Y4A?=
 =?us-ascii?Q?4SAdOe6R+qR9apma895LS5ifssJ6z2ZTIQIYka7OIygDicIX00mqDAoUYlom?=
 =?us-ascii?Q?woN0ltk0Fa8y7lDSvQ6vCAgX7/aXZWEV2zUlnLEXZzd525AD/v3ecj0DshPW?=
 =?us-ascii?Q?cWnfuw3ddDBlVweIwA1E6d4pKhdPAzo8PTaBQDcP2aNNqDMqzqGb5kq07u9M?=
 =?us-ascii?Q?tD3wQ2T4x+US/b3XOyX1STwcRBYG9EiFG0iZWiFT8iG5n4Q5h60BCUUqq338?=
 =?us-ascii?Q?WDZ+smWwphoGEy5HDEfnJNDTMB2cDw34hpWt5msA57yrEehbB+onX/7Sf12y?=
 =?us-ascii?Q?dANIy1SJs1CcVXoyoJPa/1JGWRljvwYaASXF/2AKoNd+Bjky96k30BJV3zoP?=
 =?us-ascii?Q?2AFGNUrWE8ArLNk5bzIDe047pR+Co9kzgUBbwbpa9z0wYXf3PyXZCe+7G2Wt?=
 =?us-ascii?Q?cOdX5XkvZ+gYeyK1KQlU9JYSnhXXkY+XIpdfldUCnvETXzrdO7+fp0EMYwkB?=
 =?us-ascii?Q?wMPOGG1dVQwo40KaAiwUWmewxhxE+dcr/QWnuY8Tzl5y1dt2xwOCdEw3gEBo?=
 =?us-ascii?Q?ednj9pIpoGC7s9vKEIDIWuwKSh2LwIFJJB4kaDy1ZtVi+AV5F6T7zh3THYo/?=
 =?us-ascii?Q?lOZIczhTP4t0rM5QG4uRP4V0vRiL96t7Z0Ulq8CzVC1g14/KQxaWC0+17Hgq?=
 =?us-ascii?Q?j4d9c5DpwzSgVcq42PhNIAMhF8O6X0McmASsPAcG846RVx89Vi2i1lDhbZxC?=
 =?us-ascii?Q?+jhotId3n6npQto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NoahgsRIuUVwc7EmJRqsdIKvrOTRBui2441PG1Ea7E9HRKHtzsob3A4/fl5m?=
 =?us-ascii?Q?v10zeIBpr++C7Ao+6wA85zauYM+5T1ejE8eL2aEy8EFyXXoxNMMitcrVALzz?=
 =?us-ascii?Q?OL4d303xoyavmPgt+dVYPzkGjoByfmoI0v4riF5v1cbmfipjZPMhFXAHwJ1m?=
 =?us-ascii?Q?neCNOBvIwknvBvBROa8M5PXxgSv0sPMZGF4BVMC5o73pHhx0RvGfpSjIKZe7?=
 =?us-ascii?Q?fQldELAKiWcJnuI2v4iS2PukDIctgZzrUfWEirGc52HOBquXwCHv8uHsjowW?=
 =?us-ascii?Q?4Majx1M2jrhL711CeShbPozMLC+k3ZcIIQmN43GC+2/nhQzEH2KRmawReH/q?=
 =?us-ascii?Q?hhoolIl4YVsRag3aj4LEb12Zk+guCfDNZRhzspWeBM3itFkSTdikfumkRXrR?=
 =?us-ascii?Q?IlGnNq5XukpobZ97Vrz4Waz81EK2ioHuFT3i9VbCYr1yTYZSKeCrYKqztxGe?=
 =?us-ascii?Q?01KPQQuKVVQjD0pgBpu3iBzb3LGYfL335aj1ut+yRIW6X6V8nSjMaJ9uztez?=
 =?us-ascii?Q?K5S1tpk5cySXt7tO15o85uspEAqn6M7Bu4vdcG6wvUNuRmE0iagPuF35xARS?=
 =?us-ascii?Q?xoK5GuRbgxKUK4Sfc5Ov5hPKaNYyTFbovojnEWFkqo38ISHO1RqWqUmndaYR?=
 =?us-ascii?Q?7Vb+0h6+yUZVXOt1z8gYzNnusElNea0IAA8Rxj47kQx1/K8MLOYJqD3XFYdz?=
 =?us-ascii?Q?cYqCZA3gKdtiVye7EQOuDbL/gjtpSvAWbb+ma7geAaIOm+XFZfbrBe+M2VPB?=
 =?us-ascii?Q?u1EYP8hD1agaw+5eHz+C4ydVMPmE5E1OUQ2CtI80+2PT7383QLGpiB2UcbyD?=
 =?us-ascii?Q?yvmrY4zohW/K1cyCwO8oltkkUXbDfjfFu8kjVjyGCn/da+WJ/cndyoPkD7xZ?=
 =?us-ascii?Q?m86z9QB99YbeFxOKeJcXjCtv4TQsHiPHPrajELym2LKemX1Sdbz3Hr5gKulE?=
 =?us-ascii?Q?1qCfwzYUqDHhvFPFkAZVa3X47yXST5hLv3raSPuM2cC2pKHMZOKchHqKQA4N?=
 =?us-ascii?Q?LEEoRD/BIhyjD1zt3aYtieqLQZRnuW2GlZgdbFFKKF1Rv/7T4cMY2PugnpgJ?=
 =?us-ascii?Q?tgunxQenjbCl7d5Kos1oih9LQlfch93dzldIEdDvlrrEsjT4irkJN9z8obEN?=
 =?us-ascii?Q?84v7Kx3cfF3qDW4D7OaOqC6pwMk/OJKq75olzv/5G2mtTrgzN0hH7DpxzuUp?=
 =?us-ascii?Q?UroV0Jsvh5sXtnmWXOrNN3tOrmRSzP1VJg8ejKaQzr8qSwd2JQ2KGwye4IkN?=
 =?us-ascii?Q?/P+4ziOAHRx0lWYNXLT+XZ3tgrF+qnHfpWpBOu1WO7lFqtjjBWHx2R4nEtc1?=
 =?us-ascii?Q?QOeuW3odJr1WroYnVu9O+Jtw3yZHofn8Rsn+RvfrtkbhEYyG4lRyTSjGo66s?=
 =?us-ascii?Q?W1pymIbyMUaPGoRTeYiRv23JdWHib6iX3gtkYr3J/1+qxows/XKZUiofEUXE?=
 =?us-ascii?Q?MtTZZHGWaioS7Z1ABrMWL8GRMzJLRMwtzdO+OvD++D8dZRUF8oRpXcujc2oD?=
 =?us-ascii?Q?2M4DTAnhMmBmgL5U67LPk7WVEDbN3jlZj3L2Xn4vVmnYHch4ELJnpgC6XT6+?=
 =?us-ascii?Q?fK85dxP2vLR6bekSY893Be7tgWY+TRR+o9CkN6Nde81ELdIHSYd/DKxjQSpj?=
 =?us-ascii?Q?ZP/556ybsiNnxTeRU6mDrZU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f0fd35-43d7-4c5f-fd00-08ddfb57f798
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:48:59.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cesE+hwU55Ue8uXearW9Lk3qEowcoLrOCzjhoGVHMZAHpdOyxYtKPnD+opcqpB7b9SA1ckenrtIRb0etO69wvru/gelW2NtUFuLQ+N/zEGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10010

Introduce reset capability to EN7523 device-tree clock binding
documentation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..a8471367175b 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -64,8 +64,6 @@ allOf:
         reg:
           minItems: 2
 
-        '#reset-cells': false
-
   - if:
       properties:
         compatible:
@@ -85,6 +83,7 @@ examples:
       reg = <0x1fa20000 0x400>,
             <0x1fb00000 0x1000>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
     };
 
   - |
diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
new file mode 100644
index 000000000000..211e8a23a21c
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,en7523-reset.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 iopsys Software Solutions AB.
+ * Copyright (C) 2025 Genexis AB.
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ * based on
+ *   include/dt-bindings/reset/airoha,en7581-reset.h
+ * by Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+
+/* RST_CTRL2 */
+#define EN7523_XPON_PHY_RST		 0
+#define EN7523_XSI_MAC_RST		 1
+#define EN7523_XSI_PHY_RST		 2
+#define EN7523_NPU_RST			 3
+#define EN7523_I2S_RST			 4
+#define EN7523_TRNG_RST			 5
+#define EN7523_TRNG_MSTART_RST		 6
+#define EN7523_DUAL_HSI0_RST		 7
+#define EN7523_DUAL_HSI1_RST		 8
+#define EN7523_HSI_RST			 9
+#define EN7523_DUAL_HSI0_MAC_RST	10
+#define EN7523_DUAL_HSI1_MAC_RST	11
+#define EN7523_HSI_MAC_RST		12
+#define EN7523_WDMA_RST			13
+#define EN7523_WOE0_RST			14
+#define EN7523_WOE1_RST			15
+#define EN7523_HSDMA_RST		16
+#define EN7523_I2C2RBUS_RST		17
+#define EN7523_TDMA_RST			18
+/* RST_CTRL1 */
+#define EN7523_PCM1_ZSI_ISI_RST		19
+#define EN7523_FE_PDMA_RST		20
+#define EN7523_FE_QDMA_RST		21
+#define EN7523_PCM_SPIWP_RST		22
+#define EN7523_CRYPTO_RST		23
+#define EN7523_TIMER_RST		24
+#define EN7523_PCM1_RST			25
+#define EN7523_UART_RST			26
+#define EN7523_GPIO_RST			27
+#define EN7523_GDMA_RST			28
+#define EN7523_I2C_MASTER_RST		29
+#define EN7523_PCM2_ZSI_ISI_RST		30
+#define EN7523_SFC_RST			31
+#define EN7523_UART2_RST		32
+#define EN7523_GDMP_RST			33
+#define EN7523_FE_RST			34
+#define EN7523_USB_HOST_P0_RST		35
+#define EN7523_GSW_RST			36
+#define EN7523_SFC2_PCM_RST		37
+#define EN7523_PCIE0_RST		38
+#define EN7523_PCIE1_RST		39
+#define EN7523_PCIE_HB_RST		40
+#define EN7523_XPON_MAC_RST		41
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_ */
-- 
2.51.0


