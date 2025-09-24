Return-Path: <linux-kernel+bounces-830249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76CB99329
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AAD4C501A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2F82D9ECB;
	Wed, 24 Sep 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aLhCZFaj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE212D8DDD;
	Wed, 24 Sep 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706896; cv=fail; b=dNO0fUYRFMrCHvgh2XPmdSx5YWJq13/WdAm1qjFBKE8Rk6P21wEP3ePUx58jQwKxrMao9PaS8FNIzKM8jq7RATUl8pPItgdsz/7lbiKAl7t0ZgCX9yXltVemaUBOI1HEUl2wLgx+BsBlvd7h75a9WFmNuzjJpUQZCV0InEpiCQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706896; c=relaxed/simple;
	bh=iQHi+15vFLbIelGkizQRrINT0RFjAjEFnJxd1LAAeLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nk/D968ox7QXZ2ytP9RQcJi5S1Wbz+P6sKyNV6bw89eeELcF1FHAwr8nLlVu89GL5CMFvGi1onZ7qLzAar4i5vIekSkd4+yW/wul+XI5yyYpsExxsZpi5W4PNp1Ti+keimElbIh27EbXGZkGgxlG4TJYTlnkCsMqfmOb9XFHXRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aLhCZFaj; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhr5rydap1nvQPTZ23CSRgtE3eSQTUYwWp7kEazQzLd0/R2JRS4giNBH47pggZX30JrmlPCtQoAoCX+JYPqrURaEqrd8rEMvSE8a/pz81lGplLVUJB6VVuWpHkCtSZsJqI6pgZ6/hQPD3fhOKymZlWqGRvyvsAdMxV3du7Gwhkb/WH2uVhgAd1aXx0qBWhXf9MR1l33MY01PwdpeC48tCFokAr2SpVNl7hOpUiEfZ7RISNnZZAru5TQhNPAZpv2pOwq+7lqt/dTsKojTJ6CZ6L6GRz7AMLByIil4NfGLOspCzf5r21m8984rmhW19Iy/gbyAexor+Gy3LyCnDTPDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th9QqMg21D3uTdyRRQEqRFK5ruIlzO4hQtaLw4ZD5VU=;
 b=J7rGt3DqAw+pCnddBVIbnOHn3sZXTtkm6v2w5v8d9NZ5j4kphwqT5GLyoHjZZDGhWnWyyWA+7rgxpj1iIGZZErYyn3ZCcQezyZQnBEIJ6FbZxoEJ0ied6XrAtueiRrZQaKC+QnCcc6ZXqMOKj+j/cIf8IF8P/mccQAKGxtAdqO2dpduwP7KX1QUd6kAvCyKaY+YAivBUYEgKL1mo5ZRCYbFdYTpNvrgTRjzH031nbs8kCtR1VIf7P6JklhX1sFcbCmsvWDlMsBHTPobIa+meBLeqxCAXFqm0N+oFN681tSwdEXkb25W30hsRlPE4TgSPSrMbRx+wFUpdD4CpMwBx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th9QqMg21D3uTdyRRQEqRFK5ruIlzO4hQtaLw4ZD5VU=;
 b=aLhCZFaj8UlTx/a3TR5WnwtD2MTY06x5sWOONAikU41ejTDb8HwgzjClduBH+vO7ebG5GAmgpfU1s8Re3OUPESWp31WJDM5fdekkRurt5CTXjuLggqkKEccG4qWjEnIW3KyIekNROi9Xaql2GE5qi7e0pM60fYhZaile7V6tLSoJcWIsPGzi0RPmGp8ThmiFvtYtMQsukoveQRkwK/dWJCSarrshELorQKAwpkk90oJ3llsW2/dJIdStTrkXqZl+Hc1O0UK1RIAnweM8c++f+XL7VfB9/noiWwgeoKt1PCltocln/tt/Se0bu1MrUoqZQJY8suRtfI+3+uDeHWH/XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6098.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:41:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:41:21 +0000
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
Subject: [PATCH v2 1/3] dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
Date: Wed, 24 Sep 2025 12:41:10 +0300
Message-ID: <20250924094112.1918444-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7996f1-4415-4233-4503-08ddfb4e850a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qt/Ui2jC62DwSumSTxpIgZ3hOfE9ZoZMRzjxzQ+uKRFBcZ9wClJfyJx2QCKo?=
 =?us-ascii?Q?JARWm7Uewx9KIij97/RU3ZgM11SW1gZf/thCb3hEawMQT2pNkP0282cxGZZn?=
 =?us-ascii?Q?S+UDzrTbN8NReA09yJmed26z1es3IY6ioiS9leteiGtw/RekfO6NsrV3XFqB?=
 =?us-ascii?Q?zfB6HeFvmRG/yLvHLb1qM/lp9qQlSg7iM2OzMpvpYvFEJExhOJ/sBUzfA3iY?=
 =?us-ascii?Q?iTCleucluSdrscgkSfdFx2oDM1XO8rapD/v4IThe92uN6VtBxwrA9grnK7d3?=
 =?us-ascii?Q?2d+UD5ljlv4Uwx+O+usH1dX9LOQkAU9DV6pgEopkW6IJRPU79DiYoTbh3Af0?=
 =?us-ascii?Q?ideKfUE4DylEF8SPGybf4hBaTy2sH3BUCC6/So3vwLoIKtRYe0E+xYrrfyBI?=
 =?us-ascii?Q?3XMqOmDtFWsHyo6+EmK/lnShLJ13IIyd1w3T4I4La7QJCMBrv+epeAxEu+nX?=
 =?us-ascii?Q?Yb8MYVMYx1iWcBVkZqasf8AYbTg9OTqaQnUoLHmVu7n5p0ptS4kK++2vYUmw?=
 =?us-ascii?Q?MqOQ83W/BxhDQSTa7lLo+ijozJI1E48Aq0ATrntf2g+8tNO3OC9onNb4/Ky0?=
 =?us-ascii?Q?Y9KusdbrOrn2PrE6BA5wanm8V7scNE5rbKKeCG586PF0TBRP/6fYyZdX0ck1?=
 =?us-ascii?Q?6DLKyRf7b1jKDtT7YnloybtCxWYGyPRpdii2ODfS4TiT7z755h2BD8CqRQn3?=
 =?us-ascii?Q?OxopTPM2sQ7sVPp4lwXoCGwpcbhTWQ8olDw4T9++/QAuNoVHig71qSt/VjNQ?=
 =?us-ascii?Q?u4TMw2xi1qq8bGS1aE8V16Wy49C+PyU8egkFWpTpHP0Z8dseHYY70b3UVCHN?=
 =?us-ascii?Q?jOlQq6nMgWSgv/yq4zlWKdcsJjgSfN+pdRqV9221BI412cbkmELF24DwOPqF?=
 =?us-ascii?Q?jRDfEIJSIr25OMaqBe5uhBjsRU5hmoBw/9O0YDWO0FNmFVf25guwMOGqEC3z?=
 =?us-ascii?Q?GXaWILDRRwU3f0lsvJ/QVSdN+cPnm4AgQl6NJa82pWheMeygOnZX063HWqAR?=
 =?us-ascii?Q?un12TobvLywV6nbZVZ9u3ZEkVAy2a3vC1SFx4dnrrkhXtCHVcLSMwyixQop0?=
 =?us-ascii?Q?tptjvaC1NcxVIpduKRAsalxam9GiXoBdc2MaFoxXziS3fkZv1n2LrIbdoLG0?=
 =?us-ascii?Q?W+Xf3haeDJ8ja4RNeWT+RlUxKK6reGAMsajzBqGbLEmt2t0mwRPrzJDu/3Bn?=
 =?us-ascii?Q?xmewFcC0ZuurQT7cOMhnwaW7j4d422a1KudCr0h08KR3Q47LTUnCtQx/JfAn?=
 =?us-ascii?Q?lKCq2Dza7qTmxHxEznfhLdbKqMVoBJgfHQkFSC9jzUNipJy7aji87sa4t3M0?=
 =?us-ascii?Q?UvP4iJCTQcmvoG0ieRUwN1cLWkmzsjf4zNWqunXbroJDKq5/Q5lGRIAUuZ/h?=
 =?us-ascii?Q?AxgRl4Nlydw/jMW+oQn9JjHXDmHrrP1/lWcUZDmrchV6PsUAZ2eITlYPQe6g?=
 =?us-ascii?Q?jQc90NZuztLbK82/6LwleP8shVcvK/yFEd0jFfvWjdLWPUECs48EtHa4SuZP?=
 =?us-ascii?Q?a3aaJFf9MjHAeDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orIwVpsJikvwCMLvFNUAep0ROMaMAfw5NS6EBFYgHPz/dJAamB0uoU8lAp8J?=
 =?us-ascii?Q?+lC0LHzbbXBTI3X1wnJNVI/NonCWw6015Ur/U5Em2rrCjT0mq+TUgojDj8MK?=
 =?us-ascii?Q?CLyIE9+Wr1C8qu6FoGsIdyxM3CgWf7O9F0Y4q2hVmIGwbCr9+aMBqPOgMl3w?=
 =?us-ascii?Q?8x6OWDNxDDwUlbJGIKKreQreV/dU+Hj9gXLqxzeI3ubFmLr6+ZjPBH/Q9Ijk?=
 =?us-ascii?Q?BSY7o6kT0d8Q2OqE6IahyIjiwkWwqM/9W8tWIzjE6Mrf7WubAotWKoFMspYW?=
 =?us-ascii?Q?YUS/ivXxmVUDxhqxVDzAzyc6o3K9MSit2fr816vzwKDWEdM6KyTrAcFw764P?=
 =?us-ascii?Q?G5ez2rLNVD58Nf0XGetMaO42oXiqUEl2VGp8Lac4lmHv/qbqbJ1hh3qWPl57?=
 =?us-ascii?Q?B/tH8EzI3Ip8Fr3M9bKvWBUNP90ARxwTV+/dyAKyT1EXeZhgqb4zsf0L1kA7?=
 =?us-ascii?Q?G/OgK9XdSqNbrrxN66SHI56CG8jndT0kcm/EK4OgRevj9it4ztlNn+1n1K92?=
 =?us-ascii?Q?jurkOWWge1XV0K/BwUCWleTmyN5BIN9wR+dypue3MGq87HGylSW227hQJYoE?=
 =?us-ascii?Q?zZvNEgOCWnOuzhm1iK0Syfti5v58n4JzjRuLxTmK+OwY1aAsOoma717Jemb0?=
 =?us-ascii?Q?htHKibgSpaE+DJbzRyGOE5pSTM2JCiMDbdkXcEqy4JLc5uFLiSrTB7/GCCXA?=
 =?us-ascii?Q?VKzeArQyT0h6We3GD88/ljFAz1oDcLDEd1hcn5d+uHNPJRZ4+L583SR1bMud?=
 =?us-ascii?Q?0KVJDqwfIcPinVxjxwCEnphELsH3jZtBWd2sPSz4eb+QCRrlLaRBhhiMQcVv?=
 =?us-ascii?Q?+gd6576o0ZtgTK/zp0wdp91W0VpzFykkt2ohrTHo9O7V50otBPCo55xi7yWl?=
 =?us-ascii?Q?VfqVCjnq8VWb3DSI+SOrKc6P7+XvK2sm7NmpK9Y0x/CJgDX7g1PbBlDTORU1?=
 =?us-ascii?Q?L+nHW572vUGErdfBEDY44sY7lu5tsPTivad3S32JK0z+M41K/FxYNlkIWwIX?=
 =?us-ascii?Q?jook+gHQmM0b9v1AbxOMZHC2xxbGxSC7CHYzKomRDAncwdaXMNPRG8sHmvam?=
 =?us-ascii?Q?93JV1e9n6CGY7/a8iP+iaOCkPMLdrahR2VY/Ej1JsMAlcxYmlA/8HAsqnMNz?=
 =?us-ascii?Q?KIrH0WaF5Z7STNzQnCG5miYRTCzMEgd2BWFQiSBkHvIQdZe6RwzE7ogckzjR?=
 =?us-ascii?Q?wImZsCZkCMXyvIqOF9eknl8Ugf+udnCHGCqBaxh5Aj+9klW4JplL2Jdgh1di?=
 =?us-ascii?Q?mNU8uP4hx7G2Tw8g49PqWwxsBIlGhPbwHFF/DSDveAfOMhYxS5prlCqH9WDi?=
 =?us-ascii?Q?FvRPd1E+N3f9yrYufXIJrJN3PgncFqx6zbCXwp94z48uVnxuTOF6mFRnvKb9?=
 =?us-ascii?Q?5qpP3nXG0Kc1vgYmndAGcKy2hJowVUgySrwpKlE8mbbYIPQOlgz13Nvf5gsl?=
 =?us-ascii?Q?uwHHXK5s92R4kMMNCV73m4LWOAzvoDA9voo4qsAexL1QKfE7pWk+fdq+BkLP?=
 =?us-ascii?Q?cTYHncTuLFo1VkvWhhDqdVvWaRTPNVgpMQ5N5QY8eEvj2ozZnTHigjps1hPp?=
 =?us-ascii?Q?x2fbS8BZfyjzpQQgnlx+aY9LKnaqZIiAhoX70ix66Vl8YsK6NIzFBk4kvHyI?=
 =?us-ascii?Q?CCYV30KLebEnFe3Uy1zPfQU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7996f1-4415-4233-4503-08ddfb4e850a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:41:21.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09Spo1DsoHS5CmS1RIwMFVXt2blL7IlG1VULYY7a2zs8uiVDx+j8jclcpJC4lquaUbmTUtboXcThiaPJDoQAYbSWwpgYP98QDFUbdm4s12Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6098

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


