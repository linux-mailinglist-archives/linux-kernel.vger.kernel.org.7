Return-Path: <linux-kernel+bounces-897025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC57C51D53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31FAF4F5518
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636E30B51F;
	Wed, 12 Nov 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nRdj4TJZ"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B5306B3E;
	Wed, 12 Nov 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945165; cv=fail; b=D8puEP4187DnR1t/7RnFoA35+ix+MIGXnAds/vBRNGMqdZE0/mSZzm5AqoBZVKdN6EN4OWRcDqw8B1H2jFfOZiaQD7JeaDrNgSUG5PKgr2dlPQbO6nRHp8dVzf2/TPd2GOPDLtB/4lQqLaV6YE+Vj/LcGG4mDWIFE+yB6vJIq98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945165; c=relaxed/simple;
	bh=zndHTbTmL414IrQyu67y/ssUmiWrQuM+qp4JusxSRtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6LBOvl8BAXpF1gBSKdfULg8R3ZQWuJE9dSL2E5rpPyhArSSVe1u17ICmBNt0/JLdmFwlsllq5m/54qRdebXIgjUAzPcQTU9MIkBXzeyDl7jsPm+9G7pgSl/d9oB1p6Eb06HDeJ1QreLkkzzeYttBDKF0kD0zCZKp8arxAjsuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nRdj4TJZ; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAMezb1EIWg3FKPPrv/j2H6a6NgKHoh/g0NNBh1dJT1+UuiMeSmUijAyOJ3i7JCB3UE5SleiogGcWKyrLvixXv6JImCSZsZpMsp507DqgyU6LTpIWjg3rGt9QGYC0gb+Rcihif2ddqInkhCDczAFMl2X9iuP+Q3vyQlsPdQV8knNWywJQouO8t3n0Nj2KUqAN3xXeGeMD+mFmLA+tZfkmEcUJr4tL3+cj2iJNB5NQ6w7fYXFG/vjzpnj6psNh3Ez/06N/uyx03XYn6tGUQctZW1O99nX8ioMqr+jMcrozgdKrLOX/d/fbdESX0mOUuWpcwxQ/1CdQFuDDd3pHJHXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BbbgG9scaIhLqiE6rY8VUUmCCxoi9aNG8W/Q91p7aI=;
 b=J6YsAsniNXdQnP8KQxJQ5KDmjvTwDZ4roqzFTDV43NO1g+pPMo+bsG9/3tVWUC1unZvLBxSukv4nirF8l8pcx1c1wg1tV25mc+Nwki+5+BJVyWlLIuAteLcLKcEoCkLlL/UxwPRY4CKLdBkrcQCqfpxopcZ7SzIuj70JFoMkUTPrFA9yChDPiOHcVt2szcZne5wVSZuvQEfdsiJwxJU2L5OxvKNY1LfguWSxjDE3ZA1oe16iCwPM7CDr9m8knoPPPCZGPQDFHXtfnklB1FTklgyM1o/iRDL3d/rJuKm6efAOIALpwGXZTr0y7Va/sXewJLMAxG7L3qTKQUksMMQgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BbbgG9scaIhLqiE6rY8VUUmCCxoi9aNG8W/Q91p7aI=;
 b=nRdj4TJZJe89vd/K0gsA6CTlDJV2haww0WWar1YHxJuuyXemy9slnEI2fwSQXV+iayos2Qwwur5/xixeqkk87JeMM2+HA+6m9D/XmzVgd1D89bB1EGGRMUFR3C16QjZIn6GVTbO4rSH7UbZ7AQIksJmyh2qXUOByFvYIK6Jf5Ikeccxdlt5MvD6tyecRlmJu6dXSb0oYFgEHE9NXPL+KWsmczoNUBiszu2qieTC4t3mRc26K/t6LqmQAsPVdKFzeHQarSWI0SF2AG5NbtbSp6w3jjwgjRSobzsKfvA7s7/y11Fm+XzXOSWxBIbepVBnN1XDC3Wj1GlSob5PVSNgdPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH8PR03MB7271.namprd03.prod.outlook.com (2603:10b6:510:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:59:21 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 10:59:19 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v3 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
Date: Wed, 12 Nov 2025 18:56:56 +0800
Message-Id: <20251112105657.1291563-2-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH8PR03MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 433d0acc-7139-458c-aafa-08de21da876a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KbcAP/cwzu5Ehc9cDaBw3xPajCHI70YOePOHplJYZjdZSbnqQz7L6fVy4NZ?=
 =?us-ascii?Q?fvOvTiqgsJVKARJY8K4/2PWJazjFvYBjxXJ4j+jHZbjNktIZEXc9z2+UXPU3?=
 =?us-ascii?Q?/6ZaayK32a1RLn+2G8bWj2yyEFoM9J2KWDvZgAgPhfyV5LmR0uR0PAnrD2xN?=
 =?us-ascii?Q?8ZcKGTiKFohbZnxo9YHYasmcWIF+n99nITj6eSCGRQVMfrswIciqaF+NVLUv?=
 =?us-ascii?Q?/oK+l6lCagSd71abvGlmk/JYQPKLPSH3iTxILFCwxQXhaobEqIUvlouJ/U+C?=
 =?us-ascii?Q?NjM0nzE2hgj8/wqZd80lFi30fzEN0OHIXlfIruZIbtGcEe3b/4WBdwaPUl1j?=
 =?us-ascii?Q?MjJjpqo4hZwA1lxS6BoIr+uSN3vBNFWa7qXFeJzIsoZnnZWP21W3Uq/9QAp4?=
 =?us-ascii?Q?yMVwtrcS02vIyhRcQL/8gTgG9PHtwEkEohEUEywCOdomRc30HSRV3VkF8pTZ?=
 =?us-ascii?Q?ErZf+XRGvtvri0neRltBP7L5JDQYDhO3zMZgqL+OBJQlzeWk9drcztfrp2sP?=
 =?us-ascii?Q?G/f2PxgZihTyO1dgm5q0uMgpIUOBESIUKkb5/PWAk4IQH6rLN22jmYLH6YXt?=
 =?us-ascii?Q?OMJczPisCO0F9excllQODgCjcPmGwKhq0aLibB6FLcsYx+bEb/iwiv75Zb5L?=
 =?us-ascii?Q?FkC4T/sdiPDBmYGm7hWinJXLmRLPTI5+yxaEhIhewpTlCLXh1dnZyf+DitA3?=
 =?us-ascii?Q?n2OEJIGY76D7mNc+B1X14danFy0RVIsmneGY2LhWBlYCtAfHnG1oNw7ER1h1?=
 =?us-ascii?Q?k0lT3x0KvS6TxbmWK9sTLKrKS0n/nbuXwfoTN/pUBalTXOiov7+H4+p/A96A?=
 =?us-ascii?Q?L+4u2vVDNG8l7cPLgFh1hdIRv7IjexHp00wAYoXlhKnJFtoIJ8vavQ29Jr81?=
 =?us-ascii?Q?JPJNqIQc7XObsGXFslmBBdIQv/+wFWCNs7cwwg4qNa6SvSOR9o7w+ZnM6q7Q?=
 =?us-ascii?Q?h+VbGRhTTo95xf0LIt/3oenaMRTWHxFt+2uwrpOIkRYAQD/wTt3nkdETIH4T?=
 =?us-ascii?Q?Ip3hFL4PwnGnic0p6WIhwTx56w85xK1UQ2aacd9aOBHonfCOGdMc859kz5dJ?=
 =?us-ascii?Q?F+MckHqIGsz33JY6Cm5Sr5mIU/8Zc+3Ci2f5+vzLVQgFNhMxGrOvds1zm7Qt?=
 =?us-ascii?Q?5zh3VzwXK01RTrL5sgRODPyYrNKUBwClBmBZAm0ay51oHZmalyJjdlTV/Rb1?=
 =?us-ascii?Q?vYeiFsZbN7IwT0LkpJNa01U9j6vwSGjnONYFeXV9gstKqcCiXoLMPtvO2Zri?=
 =?us-ascii?Q?QBy0iLDAe7SotNsPGOYQGIMYUc8GWi5Qlf+4SAocSzojUzn1Z2QaxwlL41rC?=
 =?us-ascii?Q?5CHUwIgF5WqHVLdItWDRUnxALC+zDswarTIUSrvemFVb4ybWGi9JxNhwdhew?=
 =?us-ascii?Q?hHY6W0iYgA8hebUBbaYAnBPopAVEbbv4P2so0FOCYgAGOLYoxMzYSEHU/CZ/?=
 =?us-ascii?Q?LYDYQ/WIhwCi/0hhDiYv4gTaorYf0VWQ2AVJ2sNpo/t9cc/vCpj5Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpb0QRY0DLmJFVsxFlw3dqHYlFQIX+0j8jLjx7O9Ejdfwazb/1BVAvJ0wY+j?=
 =?us-ascii?Q?ZJJ17MI1fWWowO2breFyROewD2hH7joPY0b8y5ETqt9HYjuSTVhZvo2I4V85?=
 =?us-ascii?Q?QEX/UiNqvWrFCdogwtxxEcnMPBrZoKpgCwhRAkjRPMur3WXQcTCU1EI+8uhz?=
 =?us-ascii?Q?+NnHyTuaMk1l9zDNqT8wwJxnyn96kN9TwaB2XF/RJ7cAOX3VkRwbayThwl6A?=
 =?us-ascii?Q?GZt3ogkBEA7HkM4euJ0+C5Gpce8ajvF74mtTfu/CNWj+lWPLs+ZvckQduAuv?=
 =?us-ascii?Q?9W2st/pnWxfsDfhZOkgUq61LZJ2rtRYUQcd02z/efNbealRdinWQ9/f54zQ/?=
 =?us-ascii?Q?/qTMVB/LJVXh/Xo/Pg6Bgi5lmXnYl8HZKx31BoSR2gvDhjK9dtBnY7OHBEOQ?=
 =?us-ascii?Q?hUWXtb+PHr6L4/1ZV0/at02BgebC6QTI4L8JfplwAe/DCZ7roAMhIjEeSisK?=
 =?us-ascii?Q?rMZApobA3UuiR+CCMAeqTXzSv75/FBLfPxvCaiQPfBTUMscVT0dgG6t88+fM?=
 =?us-ascii?Q?t4QPdL7nZPSvxkGBuV1sAysdhxmNv9zpwZNJXVQfmdeb7IQtEk14XKlQ5fB+?=
 =?us-ascii?Q?UHGxO5V3MkI4U1tgDzKk+hcqL3SW8OgZiWmZpm7PAuzBLYkbRvIEWvzqTc+H?=
 =?us-ascii?Q?JAu5Zj3iszMzc5NcCdezINCJONjurD7XYYDE63cVHL5jxAaKWGLlQuTZ+M+k?=
 =?us-ascii?Q?yho1pUtm4XyJz4B/5k+BjiHFgDW8y9EHJrUEms3HCPrBsIr7ikBhLKbcoJF2?=
 =?us-ascii?Q?fN8LeDOFnQc55FuB7yD5v30ZTIsHaXnQeZ8xpk0iZoQFYRKad73GyjP4VM4D?=
 =?us-ascii?Q?pGikuZ+j3Ao886YTAuzHUFP2QnAj7wdQM5xsP/VdCKEGIyAttYe3o3wnO3o5?=
 =?us-ascii?Q?xQDEWw2C59kUE/vge3+l6iWKa5FM+uRHOLXoIK+aqLIE2YwhJ3y/hibpSPY2?=
 =?us-ascii?Q?ScGuT/IpJjtKL2LAzDZWeiwsc5D4N8s+yUWnP2VzW+QIZvg1zTQiKI4uNsE7?=
 =?us-ascii?Q?9WF0gbGY3t97wCcVixecO2JYLPMTYR8ADNwN/4bx0+AkixG1yppeS3dFE/W2?=
 =?us-ascii?Q?XADszo+h4uCe0fHZx/XzPjwv3Lo3gES5MKm1bdfSQgDNgA/k5MyjpHaPiFbP?=
 =?us-ascii?Q?YcSzhHTZf6zn27QH8NtNdx22mLPSyhDIR/QhHq9cmh14nw9E1kzjL3RPSfKo?=
 =?us-ascii?Q?/9eiHRQebxE2yjDkjqRiXFTqppGZEHxVguDZ6PEbTR5Qqjbdkyd/ZJNeFXzY?=
 =?us-ascii?Q?9OTn2d47FVzsLNnlkG7OcJy7LY2+xFOHILemLkbnTcTB/ktJCQJU/99WwxvB?=
 =?us-ascii?Q?x0WiSemX5UpFLKLPL51JtMjEXWngP3aHLe3SNGhlyIGNPWnrLu8GHCiVWCyv?=
 =?us-ascii?Q?1+SCxCt3yVCpqkE8LlR5aZZ2/kmKoufBUKH/xE+n4UZKBiq3rmciL1+iAKDf?=
 =?us-ascii?Q?BvjSjPe5hbIcnhYY2DAU8vzkp0oB6jgQQX88qcEHk12rWUu8sNuRoID+SCWk?=
 =?us-ascii?Q?b8WZEJf1rDZt1eY5SVamJaTdfij+ry3uLuX+6UVN8+L1wtdVASOX4D5ZEzso?=
 =?us-ascii?Q?v5U+MOFbPs+SN/on7CPOVRjDLYlMZiA+/6cSsNz0UDop9V8TqDjjENRU6YhZ?=
 =?us-ascii?Q?Noc6z9hgxd5ZFp7I4IMbhUGgJVOgIx9aUvg5G5tW6FUh?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433d0acc-7139-458c-aafa-08de21da876a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:59:19.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpvSAagFMcG3+ZCSUDa1HSuDXbdjLGk+qHSie1rljulIScYPFVtb0mD5p0dMMMcvVThJyg//l9jDynoI8v08ubsmM1Cs3/fd9k78r35dZgUO0XQdsw0rYk/ThrGQqaRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7271

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add compatible string for Agilex3 SoCFPGA board, which shares the same
architecture as Agilex5 but with two fewer CPU cores.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
v3 changes:
 - Add missing agilex5 fallback.

v2 link:
https://lore.kernel.org/all/e9d398bacb299c996f14c9993bf041a9a6740cbf.1762840092.git.niravkumarlaxmidas.rabara@altera.com/

v2 changes:
 - Add separate agilex3 compatible instead of using agilex5 context.

v1 link:
https://lore.kernel.org/all/51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com/

 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index cf7a91dfec8a..c918837bd41c 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -21,6 +21,12 @@ properties:
               - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
+      - description: Agilex3 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex3-socdk
+          - const: intel,socfpga-agilex3
+          - const: intel,socfpga-agilex5
       - description: Agilex5 boards
         items:
           - enum:
-- 
2.25.1


