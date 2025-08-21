Return-Path: <linux-kernel+bounces-779778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A976DB2F8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73517401A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52A320CA2;
	Thu, 21 Aug 2025 12:43:14 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2118.outbound.protection.partner.outlook.cn [139.219.146.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180730DD36;
	Thu, 21 Aug 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780193; cv=fail; b=sVzQOmWaVLy6OwSVeo7y+C5TSzlOKy8HAZr9hwzkxhC6pxMBmem29lYYPeTD1yw6qxm6c/iDjyUsuRBE42seIlQ8ma0+P0bfRtnOliCoA6YwR9RMTsQhujGGqwhUZxLPbf4WH+Qgn90vVRcxSOngmTG8OWu2l1dVrdKlvmrasV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780193; c=relaxed/simple;
	bh=XmJWRWmEhLgX/0j+oLNW9bKGd4Qgz7j9WDZjClKtDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbW/qdyBoj7CjuooNTF4JuMNuAGfSyohYNoUzuKExim7JSPTA0zkomFcUrh9cfLWI/J+cmjywDAH3tLPEPjokY80KAr8C9JgGFs031CvQYmDKRtUmoaXbEfIdyiY/85gi3FiA2F03ewsaDZtTs0dgEsUVgUqv11qKRLCWuvUa+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2ALrT4STxTdHB9fmAWk/n7LO3OIm6lO2z2bR2H1tsjAp1vujrFwpFlZE0pNf+D9m0JjAcNHbtZh4C8XTOfgpwe1gBDYTod+gm5SP5eubQN4LkBZ7IX7UjaXVfPleRqUDdFWdWNalMzfR0724RILul+smZNuK16xa/hE9gCj6+lxSeVgjRgQZkSdT3db2gkJUMA7YGUIqfgZ9MLvJOF5/GEC0gAjKPo+TnJgTwpaJfAAaW/tZshTIH0elRr8Ajr5IhULkmLY5oVvzXONrTRLUxNHSaQy04t9UTTt8VWbBfaVEnccjFM96RD4hsII8FkSzEJmEyRzZqodYEJAHS1yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRs3MPTEXfPejapGNJ7uPwwGpLjyn2mWfrdPw0+7ebc=;
 b=k34hxxcaZEBd+l9AmWOgHx/bY25R4s00Rer6T6dDeDzUaGQzPxF/Fwx+tVcsrU4MHq5fUJwgK6OkJQUfpSyit0dCOdY/bjqGhrOTLcZbmY4TK+EOSmomC/jWjOvJA3lfjGj6A2tDE5EnoH28e+BRzryO0zdF4NwMCkE6quTJauplsQBVFGkxmlb2rqJjecqEbdQvHbaSukONrna1BcQCIcVGzBlnmuNGUwOXOIZVmI2nJQnpwP7PBJYt+XyDjU7pYsOO7Mc/i4YoBCfN8KYX2YYdJhMP12LfGC0nPnq7E81JvGxtJtlBttIwGmVV3TZkq3UjOzcvy5SBwB5PDY9Y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 10:10:28 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 10:10:28 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite board
Date: Thu, 21 Aug 2025 18:09:28 +0800
Message-ID: <20250821100930.71404-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250821100930.71404-1-hal.feng@starfivetech.com>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0057.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
X-MS-Office365-Filtering-Correlation-Id: e68d008c-ec02-4fba-4601-08dde09af446
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	d5MvaTWQyzxMBfCM80F973bpmckJdYf1RT5jX1b64AVbIcoNZTGtqNtayudiXYSQtUaeHFDV5TjaW+5afZbhVWwyJazp3ZQBFNdSoVT5P5zny6r+EsSngcj2PUIqE6LpYAvSVAUOHjUCjzI+gS2LtCVv8h9rFt17vlaIGENHFi7mUnvjqjCAnm2TsOGUlcRv/mYio3kc6lylr8IxvSZ0jBu3aq+f6ZuDJ+Wb5n7zmvZm6FceCW2Iyz8AxT+rJF719NieMILfteNn4V0XPa4jXxnq9jYRIdPVWDDJTMcKIYs2GruhH7fcc5xzm6HGObLqnHOmO2nQzj1n/3ENzjguXlg/Tx4HD3kvTRJWlKiWkACOQgQ5fuVLAK+vAdEUc5HVnEaQGuxB90Qd8iHlVBEnKXRnZv0oz1lZxDsqNnaBMfzOlgcQC9qVRL14dzf8cafmQ4NAOB8eOaXjBWM0na/G55l6K/Q3g8LaH+WEMrTAWTkX9gs/luTdy1D6qyTAnUKxErS1w2GIgkLNkk4at4CUMj0xuRnPvyqOwJp1cuFO8+O7rFjAyiO4GUVbGaT29tvanU/sF9NgFZDOZJidZJtDUCO5JyAzfAGEhpu1+aJDWBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izm4sLkDz05POqmxncg94Mmukif98Jeb+MLj/GOAPqTPCPUrzR5fAtS4Zau5?=
 =?us-ascii?Q?bHcH66pARTCPX57kVGE+f/6kw8sXPDTHm8hpPqj+fTeL8VNoEGTjAcrHwHki?=
 =?us-ascii?Q?8Ks1DgoSdESTyGQIxzJGnsAhUkMOXb+z/T1JDuqY4r7g660H9AbAlKbNg2WH?=
 =?us-ascii?Q?PEtcAkohPLB+Xe9HNI8opGGYSIYHDIqBLI6DFKubqkn6M66644CUq9AVohyh?=
 =?us-ascii?Q?2rqbO5sHzos1WOU5ILKiCspkyVRilEohU8bJqsn1r1EZgSHsmhtdEdybvWT8?=
 =?us-ascii?Q?RU+pjixxKu3WEocDee/n8PaHgkMcpGiP5pfnTnJUaglHLuQ2bcIy9bJcZJeR?=
 =?us-ascii?Q?xbtR6EkTO/wx1dlhQrn41ansLGX7cmDQ9OJQfFf47Rp1Y/vEgZDs62LTvgxn?=
 =?us-ascii?Q?0srNsZuUMP8o6dtg+65Ef5c9bJoW/PQbcwy7OLI5/pmxsR2T4ImWeb9K/DZ3?=
 =?us-ascii?Q?Hmpab8V9G5T2dDpVusg1fqL+LObG7TfMIN8Q6Mk1SEUaTVLXcRE1FbkO6d8j?=
 =?us-ascii?Q?N+ppY2fgCJ+dtrC9R4YGrnZ2yMrsGatjVEy6XeCnpC1YsRgA/gEn9f1MjK96?=
 =?us-ascii?Q?QjedNqdUTfUODjUjf5BxL4RzJ/HGV+TvUptmyAeSjyRcniT3fM1mOfm+6w7n?=
 =?us-ascii?Q?b9wY4XQHxnoWLxp7lmCz0kardTgSX7AmNDEilAf7RLczs2/r1LrW7D3Akv3g?=
 =?us-ascii?Q?iNFHwfkaVeVPH4awgL4f9iQSwRrTJoDWVs8HcbcMyy9SvVtVCeX9XoRDifvQ?=
 =?us-ascii?Q?Ppb8Lg8rJ6SpLLlWc/+NXiL75G6IYZlC4pbmWagsLVEp1dHlQnslrITu2z3m?=
 =?us-ascii?Q?3MQCyNCz0QRi3ptNC0yS5objIrmoXB15SKJBy957VWDKXc1cL1LaUi7tF/7Y?=
 =?us-ascii?Q?EMYezLXsQrh8JtmdxfbFyZxkb5wVXMv7WABuFxD24vMMuL5HmlpQdDZ6rNEc?=
 =?us-ascii?Q?+QN6CjgUWuuYJXZgKudEYC1Aopcv/8qevtyNlDZot/yo2SY6jQCkpPM0S1zW?=
 =?us-ascii?Q?l60NoeCs9iJMYFyeX0yNzcOXel7plzQVwNwiL8mDgQeOoo7L2pEI2D11tm3h?=
 =?us-ascii?Q?2jd9fIcA2fVr/zMJcXdgnwKNYxKZ5h6FF/tX2mw82PRQIjonKBs7dpFjQhv2?=
 =?us-ascii?Q?CHEN1bWt5QZ1wCoEIHqXRPW6JGjqRlsNbaiWrmgAZNxTRNStAz8wk6LMPCKD?=
 =?us-ascii?Q?pJLoXCQzBuDWTnv6rjmbA7E7+DC/XkLt9sXTl61uQjRQjXEjzYXhy0CmWby0?=
 =?us-ascii?Q?LxwRs7ayUKz7P2KMUQldi6xT/xYWjgh/7akq3PvGHnkSBrgQMFdwu5X9MAgY?=
 =?us-ascii?Q?Nt9QgSSaOdu1Wtg9d0BFPp+AOo9XIPOBSax1DF5jBgH6tOWzDfXBCrMYyn4n?=
 =?us-ascii?Q?zmbpObl1uhL4w1sSea0t6tZ69W6hS//2IKxm4HFwO7iOltFA7dlID8NsZz2J?=
 =?us-ascii?Q?ft51mvDefM5r2XpdkjjGm4MfbAvpZ48PIhNQiaYqNyxYq8tDlGgVLv5o7tvQ?=
 =?us-ascii?Q?oo/GiPIESMLKDxZ5H8HSMWJJFzVO3ksdhWGRqnqlM8PiQG0EuEenO3BaWBIR?=
 =?us-ascii?Q?rElGJQl6v2w1D+ugtsqKjCZtcX3TODNe15L7QeQnVLQfL2P0OSmenf5YwNcy?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d008c-ec02-4fba-4601-08dde09af446
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:10:28.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BB/d/tGYxC0SpssPv05wRzdRczhX2Z0tcw7hT14RWTl2KSYpvwWUZyl3+qw8S/sso6bVkFUPmipy4MNuztf5+Gs6llRNDSJV3j+aDSYBus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

Add device tree bindings for the StarFive JH7110S SoC
and the VisionFive 2 Lite board equipped with it.

JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigrade
and up to 1.25GHz. Its CPU cores and peripherals are mostly similar to
those of the JH7110 SoC.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 7ef85174353d..a2952490709f 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -33,6 +33,11 @@ properties:
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
 
+      - items:
+          - enum:
+              - starfive,visionfive-2-lite
+          - const: starfive,jh7110s
+
 additionalProperties: true
 
 ...
-- 
2.43.2


