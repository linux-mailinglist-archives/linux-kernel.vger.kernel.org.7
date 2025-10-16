Return-Path: <linux-kernel+bounces-856186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B236FBE3628
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066AB19C34CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162031CA4A;
	Thu, 16 Oct 2025 12:33:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2092.outbound.protection.partner.outlook.cn [139.219.17.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673E41AAC;
	Thu, 16 Oct 2025 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617987; cv=fail; b=R0UOU3gKqtksULZyqLGCQLHrf4OV3PK/yJBlk/JCyfFjLvLIyh52g1oqyE1gybd/L7keiOyZtDtIUNedcvksiXc0mWNS9HyAq1+vz3DYF+GiEz6cxm39Abyegg/W7gdArv2qwALhcJO3fbfbo6+YBz/RWmZeg/k9yau+IdzjvG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617987; c=relaxed/simple;
	bh=Agyyxacqw1AaXN7uHZrvpdVnPXsfhd0AKo/2+hpH7cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMPOmk3tu9wmE3oWIKKKgEwSklbr1Ilckb0XIigX92lrxCl/t4r83tGjXwpUBw3Tflr3YvusCExmAtc+DDTe9Xj0Z929qv94AHAieDo93OM2Lhk4lrteKErJZM5I5d0MSCvjN2BaDFVB6uGUIZtCTK713YARAwgS4RC1ElcJTNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrIYADy1UGm8FT9hxAPja4bjAkz2aFhVjdMIiDt0lubDvm4tlHR9axGLWcuASqnJZAhSA1fWOPgf7kuxIh9GnD+F2/fX6LCHG/UBhgZcbpsdQNQ8r24ZnOwwe5J4zDnrNJzgopBHZxsLXVkjkYEcyb2UixzF4I8LC2oamlbkxygCOuS9PfCmhLVQlzF7/iHF+QdvH0Pj4jsELwIMhXWv/Lp+ie1YwS4s80pZyASYK8uwtHebkP6dybsjB5lBQYrT9Mcpblub+mL58YJCxFnH9tF1EqGYszyYU5+lMM96Ynrnqb5syVcHkgm8gOwZv2oBVerYTOGFpBLXZUtm7/irPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taKBOgFQs2IAIsVhlTymY0rnsRa+YYr1Ya0lQa5DyKc=;
 b=AH6Q3PufJoGkRTL7mwilS3EsPVxoeS4/HlvDESPy6Yl8i6BouhvpSkqx8WJVh4vMALJGLgQD0jXTpPKZmXuxzzlaxog3RLeX0mCYbJSxE/SnO30G2DVlDV9fjbPElikj7lR1IzlDx/x08y3xRnAhVYsXkaQSSZm3CWLF33nMgZ40u/3hOvdp/KUxfl6xUFZ2u0UPSVja9Rz95zQVkG4n+eoBdyZIz6SYckXoGRWYiAdS61bwOD6LB4EyS60m/nQ+m15rrgZKHGfly3f5e6vXNkyYLWxYigqo2xZCkhAZOMqNe8gcyC4ZrtEEKpqgGPLtLkOIRiGMIkCJN5houY+KIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:06 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite board
Date: Thu, 16 Oct 2025 16:00:50 +0800
Message-ID: <20251016080054.12484-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251016080054.12484-1-hal.feng@starfivetech.com>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7b6f1a-7a84-4a32-d9e3-08de0c8a28a1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	lpicNDCzGlNDp1qFYIcYKMTGqx35dhMkY3jG0GzLBZBrmdod+sLP12dueEHqC0nlRMnaJutMDS1GBiT4MUHkxb5R7IPLswunVCB6q4CwsUNp16ABUrsnISi7CXw8FQP7mgwPDmHCByvPT4ofzQx2IHxYlOY9noRzrbSurJ1OHCibZqEgxtySIXBQOasHZFx4Eu3zrXXs6omNM7uFQ+ClaeNeh9UFMBFPtisORwWRw3zA5byW6BRsficO/SqnlnaeT8+ZtfIZjD63fjnfOHcOWy15kPwKEhnAlUdPYfE06Anta64Y4DCJMLHwC8CJ0kI/HuP+YSODK/IaYSRguoRYtS3icHz9YpCW1iiGxOEmdf8em5WJoZty90BF632dxPYqo2p9WinseqTPCZrHPJCZIy4jboY3mi9Jf8t6An6DRgTHbUexQeCzzu0ivJAdPNVERd5P49TQb2gmzs0tyNxSB+9YZ4vbyMYK9wk+FK0BItrdrbJVcN+6N8n33llZfU61Xfl+J/R1n4/c1vXe+kgUbXpJswmkSX+oYh5f9cYxYINIxeAUTYS0T4rOvnAq4PRpZtqv2wWfl2rB7eYVNnBAsDI+/ELqm9OVHG7gCBPrd9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gr1sixIsTW8+xloru+xy3gCQs+TUYIwp4eczULINcn2YwFrxo5C9Vlg74HTg?=
 =?us-ascii?Q?VeiuYESKHeyPULEJJIX7/CclRuOeqF637hLcxFbuR1BUDfZU/Rn2Xocfj7pQ?=
 =?us-ascii?Q?3siVm4lT30GJKSWPlRY8nT76HQHoGSANhski4QdKzTgzqDWiFEybCkutfz9Y?=
 =?us-ascii?Q?cbIps6lWmPV3QlDRMOXhQodNIcsH3RPU/3U1Tv9EcA13x8e187RlV1DXHNyZ?=
 =?us-ascii?Q?8WR6eADtPre7+409hLLo2X6AwXxZnndc0IbqRLSmz08FvQZKCDTorLhLPO2y?=
 =?us-ascii?Q?NerEwbiy6hft0plIF3aMvq5RoUTDkfXlwcMdsuG25ACJ9/ZeECqi8MKcKZ19?=
 =?us-ascii?Q?YtQCqAEQKH8gzlI6uTyNwS1bTfyu76rlBhVGtSpBM/BAy2lY+FkkSGxH6qe5?=
 =?us-ascii?Q?dl9khMmsrMF8Narn6JgPGEb0/BBeriu1E1T8RwZ/d2ytYnmq2iv5WDrOuSud?=
 =?us-ascii?Q?XydvJhTr5YZilQKnkP0aJEAeJcghIAcE1D2JPGCwKRQ32EfBnjRlwoetTvbm?=
 =?us-ascii?Q?E6GFr8B1xCotv6DWTk1zW9SZlnMsKsX/yO6oO6+r8Qzx1NNfT0HxP3stNCzJ?=
 =?us-ascii?Q?0573vZPMlGrOQR8q5F5EqK2zkYX7CUTX/v5KXj95iEhfUMCau9V/qrVSJLbr?=
 =?us-ascii?Q?aL6PWmlx39nppihyMwP1mxg9Pj226+a8DhL2BnXreZhT8ER5dQn47s1IEiA7?=
 =?us-ascii?Q?KPqoOHBoCoiRdQCKI5lbi1iKa0F/BY40GNP+JEcNck4Dc372zBSSviJ6dUJU?=
 =?us-ascii?Q?BPSwV2dg0cAb2kastrqzqqBkAqe73C7PX6MEwE1cv3KXUlRO/Hi867KmrOgR?=
 =?us-ascii?Q?hgdenfKCTIWAb+ru04Iv3uuGVCn9U5uvJcd4jZiwcajMajeWlJr3x4DvTGy6?=
 =?us-ascii?Q?1lIovE52ZlPzG96ANka/ixY2MBKES4T6vawQ2sQh51KtctkIZDSEbGPEpWUJ?=
 =?us-ascii?Q?GWhmPpQnB1t1FjP79c+kBG011OfYhbl/O46Zsope5+0JYtSen4/YlsUd19ah?=
 =?us-ascii?Q?2lGlJArEtRAiD8Z04kFE0be+dq9ALWWfLnti9PB9C/7aLrrS7HGZcDFJj6iB?=
 =?us-ascii?Q?5X4entEa7M9Tyc5OuzxQlxokd5Z4/tavyceFxPF4sP2g9/xFp/O2YEKs2Mb9?=
 =?us-ascii?Q?grHIMYfOxamwnWkuUFjm//n65FU7ysIS5SJFFJf6Z9URctFfdibiXlv1vW/U?=
 =?us-ascii?Q?JMZ77cKtCKFNXJvymHICZpf8WnzFzK07m7j3dKF4DfVUsszb5B4qPnk3W0Q+?=
 =?us-ascii?Q?vbshsTOBjUFunKPwSut+8k3Zyts1/w5o0WzjqE4DWwX3fTwQwNOj0lu1Jfw0?=
 =?us-ascii?Q?WODp/RjrkHzQ87Gi/cCn3UkYdkYpcwZBCA0u6SKUzk0LPvSUO75bKSx4B1zS?=
 =?us-ascii?Q?tjL/ol9p2sz1MP4De6+TYau8tAX7mPJI1xBElU7nljcASHFCqDJzQHYOxXqU?=
 =?us-ascii?Q?dkuidsO1cioxyni7KbphHaUQU0FTzs0VV2zcLnvNGjW4CbtjNza8Lm02qhUH?=
 =?us-ascii?Q?pv7tbYrMUxffSqtgZOaEVVv6/vEEQMIqO/iptoV3QPZzFjPaNrdO/GW59BkG?=
 =?us-ascii?Q?WbUQQfN+O4uWu1mKxxDfGh4c7UIwydtqHovKOx+p7xSwqrMpThB1LaHZ94Tc?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7b6f1a-7a84-4a32-d9e3-08de0c8a28a1
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:06.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BkoaFRM4LSMlZgTCY/REd1j6szElTbMVEjFAy6lYepqWNPsZ3D+vCLFAlA1AqBN7714o37f44EkxNUvneOspK11OTjsdAChoepnjC/fzyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

Add device tree bindings for the StarFive JH7110S SoC
and the VisionFive 2 Lite board equipped with it.

JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigrade
and up to 1.25GHz. Its CPU cores and peripherals are the same as
those of the JH7110 SoC.

VisionFive 2 Lite boards have SD card version (default) and eMMC version,
which are called "VisionFive 2 Lite" and "VisionFive 2 Lite eMMC"
respectively.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 04510341a71e..797d9956b949 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -35,6 +35,12 @@ properties:
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
 
+      - items:
+          - enum:
+              - starfive,visionfive-2-lite
+              - starfive,visionfive-2-lite-emmc
+          - const: starfive,jh7110s
+
 additionalProperties: true
 
 ...
-- 
2.43.2


