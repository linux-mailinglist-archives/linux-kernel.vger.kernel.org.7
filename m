Return-Path: <linux-kernel+bounces-883788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06342C2E6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DFCE34BEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02213002DD;
	Mon,  3 Nov 2025 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Z6AK9mJb"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CC2FE593;
	Mon,  3 Nov 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213188; cv=fail; b=qzSF3LQySlJI33BB6sij/C/WLWR05KDuR64Nm+z3mn7sIL/FymQQ2DL7FFDV9cWi1xzy9g1RXovtD/flQ8J/lwoRZ3QsfRMgEyT8Gs8m6I5jTPtY9zgGJYZc6SYL06mg4Zmw9ijpNWrjeAlOL55Nf3+lvGwg6sJbmQwZcH77UBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213188; c=relaxed/simple;
	bh=nGsjwHNqoE4rq/xXEIQFXnZ9f2Zl+dEV29N9fpAWiWA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPGPjay2ExVZb4qzu8To9ozZEDWnzme20Sokl5DMlrg9senQgfD/AC2ZqjJ05CuJfShek2VDgCNmguIRlYdtPlynDghQXrde7LcytsdRXOmE0EU95yChT2oUfoibkkWYc7ttR9xOpp0YAgyNM0Id+rL2jpWCOrloFUQKq7LxSV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Z6AK9mJb; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3CxgDn5gxZBt1AzA7UpQZ5aRx7mG4arJNHtaiU14lPFiyOyvU7h/rkOASJ4j2RQ9+mGdqne+XHF4sffubL6w97kOIXz1edacvmEAobSSIxP1GHz1YZ6vXg5xXgReUdgY8rvmLaRZGJ6nscU8o6gQmZ8tz2Tcw+V3fe4yzEKhfXqnZgxmFlBjPfi2Q5927X8/P9+rvEYs9d7GSsoaWpy4whu/FP1ir293iFDO4wXwscfZ1a3a+g+47Wr6sOF85q+b1DzXjEYhy06LboqTVrJBWjA5asxyglbhKZcPGVRBzaxb8NREixzWUd53BtZMoMj2tan3xTFvljFSXpx4j92Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWBsmDjjS+l2TvWx1q9DtJvXY2rmDEeI4E9dDn0D1Uw=;
 b=YdILVqQiNuQoBTdVQfnZuwxR0VJl7NsXjR8snQV8In+HMVtCuiVJBhDt6NaQpOvpRXtZ8cZA/2iEt7rwGp6PtVmiWY+0JSxEhxLiEyN7VLWamXIE9/XPwygis4utEWcN4SAWiaJ72hX1iHqGxxCnKARLkl4aM+oDViKBBmSiUvWWKyKqNKjksojcReF+OLBt2F5mLlph2mJ+AaneKXhZ94PWNQ1SdeJ9HfoJ231LqPVrGSu7C2lcBqJS0pgCtfAguZWQb6t0BYBF64Y45sG6cxgrBRTc5OCcCSLhYWFnFwtTDeSz1xK5SfP4h2PrOAIZlZEtULNyU+JllGqZGRk3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWBsmDjjS+l2TvWx1q9DtJvXY2rmDEeI4E9dDn0D1Uw=;
 b=Z6AK9mJb8t5a/6j91CFSnBo8DinTU5dlUeHf/gWjtwuHwzq//32ihgf8CYVPoOcciIKrRKz7IHVwFI/XlzRFAy53vDDjpL5alxXaVWJAcKMYcLox4iN45yU29hdL4FPyxzpCL84mbaiFKQdFtYHWNb/MDZ99b1vXcUexJKQUPv99gSxFuk4rWNwN2tLhe9oql13XEEbLQDOgfHS5JvaKt5xWEYNVSIQMUKkjCSAvBbEk7u2Ti4BnAsQEKBjZ4LBGOFFnivWVO2PKll3guL/rZ5irwWN1B7MVOasNGbbi3HDgHaHns16pBsv5IB5/C5C2OyixukEXydybzuTaM30HXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6538.namprd03.prod.outlook.com (2603:10b6:303:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:39:40 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Mon, 3 Nov 2025
 23:39:40 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for Agilex5
Date: Tue,  4 Nov 2025 07:39:27 +0800
Message-ID: <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762135710.git.khairul.anuar.romli@altera.com>
References: <cover.1762135710.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|MW4PR03MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 3015b0f4-2a73-41a2-df77-08de1b32418c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMAmg4k3wFhseF6XYxo0BIBoPaGe+04I1dA1UlnRddtaZEPJPLqXWMefVORK?=
 =?us-ascii?Q?hH8l77FuAbcgFlq3GVDIe21OKqnb6/PecYlCpZFtRbKIkYjCJdlI0fvlGN3W?=
 =?us-ascii?Q?QKDAdam8/ANxvKYgfysZkINiVb6b0xeKvNpHA7EnbzFPylBpYgu6Ibunw8BL?=
 =?us-ascii?Q?mvOBct3CtlT3xPkrDF5GFizFhndqZCJ7OPqP6t2lZ5p1LKKmaZKsnhdnJ+0B?=
 =?us-ascii?Q?iFYNYiYx4oDlvWM7CfXqAXThlm94zfRG1mSc+TXHXsLpRKLmahKlwjDoNh/K?=
 =?us-ascii?Q?2KszxV518T9Oys1qYt/NoAGEH7PAPV7TEhwrWUPtGZpEznKpXQqpo96PeMAH?=
 =?us-ascii?Q?z9AEEod98pAEcBXnq29N3OGkvZJElhOaMCSZhNy5kOQcZ7cnl7OoJ+cFCbW7?=
 =?us-ascii?Q?ALtZwl71krQmW8LR3CQp07vNv2/R5mwL4yHrdV/eij+flVJ0PEi2PwpYffEQ?=
 =?us-ascii?Q?ykrzg1bJWRK4bxus8FYP9LtATZChWTFYHYHv/xLEqeh1rnS3mS9R9w/LHyr8?=
 =?us-ascii?Q?bI0ia5KFfovKIKLSi3Q1Gm9DKDB0MIrccfk+cP2z6wZGWP26gw/1xt0y2wrT?=
 =?us-ascii?Q?NSHikes0TY5ZYW67ErzkUmkEqQRh1KkFo73/bEzKTBxHNNYaRsC9ksLkKx2Z?=
 =?us-ascii?Q?53pTEnrEU+O0BfViCkP4bFSi6ju9WvW4nhcUhGBG/udUr9xsRTyArL4AiUBP?=
 =?us-ascii?Q?M0Esu0HhPt2/OQwQ6MDeHpqAV6NrNdK1ewNGXSzGW53fIFwE0a6iQThDWUTZ?=
 =?us-ascii?Q?OwV14FCE4rESIfl8LPeGUfsAdgtswSWhBqbSBEtOZu6NjyrQolqi8+wRIfLp?=
 =?us-ascii?Q?WUHwpVtHGDa/atMXJJb7NYI6h/CK62Pq52gV8I2A/+wntTZmrz3gAlCFAy51?=
 =?us-ascii?Q?HBIi/hyA6lTLx4CF+qYMZlML5sKpwmbxGCntLCfZt/ZZVwYUJoHmcwk1cS6E?=
 =?us-ascii?Q?Tv35197bSweYbRGoy3E1PiJIHpHysg/Wd2nu31/g7fOhOdSv1G2AwYItaySg?=
 =?us-ascii?Q?AIvEdoHISGmGFXJdsUHgT3vdNjaJ74Tc6hS0xtJ3ss9hmNBEINjdAAzmpiwQ?=
 =?us-ascii?Q?3DgDtCQ+JhtcfoFOTReICtvcSWSwIilgbmP8GqdgFJyPElRAFrW4nmv5y6s7?=
 =?us-ascii?Q?iZlxlZZOhJT8ov7cP31W0D2zQf7HwHWyOScqNPfLp7rylU0GzGwXL1E/e5a3?=
 =?us-ascii?Q?MMOzgSZ7V6jiC/Peiwh0kLhj3LGY6wX/SfQLZpISNa2hW7+TL3N6j7Dhfgb0?=
 =?us-ascii?Q?BbBukJqsZFDM4LDKIkX7KqoFrAnSsZZfaX3/mVXE/xmO3IDlOX2PN2gNpiiX?=
 =?us-ascii?Q?Y76aoaDDfVbbwrg99+WINR+XNpqlFOAtp6IUTr1KdlxTeCZklJAhvFtacPBV?=
 =?us-ascii?Q?//BIQwOW0UB+frqL07736RClZ7gx2RsC30Zy3CzzLO06RbSlwPw9jht8ab63?=
 =?us-ascii?Q?awqdyAKK+/NYxmmyBKtjeMnNOtKnbeA/VIQHPiJqJRAIb2WlCDJNN26S0nj9?=
 =?us-ascii?Q?1iD/GBM6PC/xAhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dD4bSr8VPV1UE2cdB5KBrDDOEfFViNsoe2dwiyP0ZVFWRgqTGc/cY11hyR1?=
 =?us-ascii?Q?CjvkPQ9037rtJoebep5IjzvAdrv//Tl/mE90Bj7ZaHNlO8MuCK8g9TQDDmLl?=
 =?us-ascii?Q?t1lf/uQF8uqnL3GhrKvchawWTI2bobhDuIjAm+lEZpY7FwG7XZhMA7KVLC09?=
 =?us-ascii?Q?se0VIRln1Lsj8H3eNGjtjiSMvgIdW/Oc1C06o/0t357XfKQhPm/vJAyTAyQW?=
 =?us-ascii?Q?uxFO8slW3ELjAvzAWyj+3yrpg+ZqIhvlKBlZ+ymysk0HpQiEbfi/ljPCV+IJ?=
 =?us-ascii?Q?/2ymk0dH0cXU3aSd1DrxKxf44O26KBiYTLOyM89D9J4RatWJ0QKCeYLnad4u?=
 =?us-ascii?Q?DevgK6rWcxqzYxNz4HwkgQrfSBs1dgIizhbrLQImhVDsdWrnyn9wArxLQHcv?=
 =?us-ascii?Q?dhwyYrP0LzwES2gCZnL57LyL0v3CmD5kzEPnyGDV0E65CSAiAcBD+JPeRjDH?=
 =?us-ascii?Q?Ohq7sRQd8dYgl82mP2qkYZgvelNHMW54RUQfkkokbjFLJ24uFu2/WGbaljNa?=
 =?us-ascii?Q?7RBU1o8oxc0nIo/UUMScE1oUY8GIRlcBzOUL1aw45dfTUc8PQMYEHf7Uao2I?=
 =?us-ascii?Q?ZpQh7EQY2xaCACySdGI+UazaUi9zNTrP6XeTFwjsOyiqs1Gtq2YP/oWwlC/A?=
 =?us-ascii?Q?9bgd8nI0H3MpSa1YCibaXjjfGN9AUdcsLCPlkTN0Zxv54IivHtXBf1pNtc7b?=
 =?us-ascii?Q?jgIGvGkzhAHyKOxr5aC0zQ2w64dvma3VJLnGIO5fUwfgjoJCEY3DDMM6cfO9?=
 =?us-ascii?Q?wnaPCUYAsgQxt/koDGHxxV698AaYbWVFHZXUa8DcvQ7WhJvj0/0roVvAOkiW?=
 =?us-ascii?Q?eddI+0s5P84FCwgnmzRi5ueDIpP4MH5jQhTDVRJ7dQTCTofFTz/Kl1ltbBSH?=
 =?us-ascii?Q?LPrlNogEa4Gig+Bgvzqi4d/Q/BMH2u9m1xZ6cjGZKxyRgt02XZL7t+oKfxGT?=
 =?us-ascii?Q?cj1hqQ83rMnviKLCUVy4c8BdcCRlhAlhL9XKbV3kBMDW+3vB/PCz0ByAhTQF?=
 =?us-ascii?Q?Toi9KVLZzMgCkQnDfOyaczhD3bcbRQbkAqRHniNxDro4sbmDPtobrQOdqTEH?=
 =?us-ascii?Q?DuZIPVE9/DpGwXjZacnLPow31BtXlqtfY5eCtplqVrUpe3VV6Kj3ksAzjPoP?=
 =?us-ascii?Q?3tdOQm5+XMZf1db3oHplDzUgEpAmCMvMm6SfC9d3OSGSritLOWQHi9UZbQoN?=
 =?us-ascii?Q?XMt2Yd8787YGtl2wz0S8uLZYXjAvnkkkQNnUmVJaHqspAyC9fp1XD7tt2aHB?=
 =?us-ascii?Q?eOqphdH0+W56pHM6e/6clvVgGg4Un0BG1ZkLGq6KfHpLg+3EXSyQ2T5nXXAd?=
 =?us-ascii?Q?jyNlC+chY3rTh4k3DGY9Zzu9wfc/AYPVzW1rEoliVOmI3rtrCJaJBGZOv9oV?=
 =?us-ascii?Q?DKzaqlNG/cQYsuRzwU0bt9uUmNGxQLnJ0kiLCtrxkOH248RDcDSKx6/x5nax?=
 =?us-ascii?Q?/1BseCFlrNdaNW9Z4vfc2hir7IaU294aXUTYfN9iAh6gJm0RwUTDb2U1TowX?=
 =?us-ascii?Q?1svlmuj8A1/2MF22yoMWxhu9AywvrgsGAWDVdgxkWGIHWCXLYROWWzYoh+DZ?=
 =?us-ascii?Q?/gNPRJOCi42JyW1l//u2wd+PHQjgwSOl8I3viScQWvdU6x1OGLIiPNEabRat?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3015b0f4-2a73-41a2-df77-08de1b32418c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:39:40.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shpUfJ1a9bz3Zw9QPj3HIlJmP+ZJQSRuAboFhOfu/8KceM81yWVQh+y0svGQHa7L36gA06lw9Jczx0jOiX2YMNwaobE8xmocA0uxip02LDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6538

In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
mode, enabling Linux to utilize it through the IOMMU framework. This allows
improved memory management capabilities in non-secure environments. With
Agilex5 lifting this restriction, we are now extending the device tree
bindings to support IOMMU for the Agilex5 SVC.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
Changes in v3:
	- Add iommu property.
	- Add logical check where only Agilex5 required iommus
	- Rewrite the commit message to explain why this changes is 
	  needed.
Changes in v2:
	- Reprase commit message to exclude iommu
---
 .../firmware/intel,stratix10-svc.yaml         | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..094973494098 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -34,6 +34,7 @@ properties:
     enum:
       - intel,stratix10-svc
       - intel,agilex-svc
+      - intel,agilex5-svc
 
   method:
     description: |
@@ -54,14 +55,25 @@ properties:
       reserved memory region for the service layer driver to
       communicate with the secure device manager.
 
+  iommus:
+    maxItems: 1
+
   fpga-mgr:
     $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
     description: Optional child node for fpga manager to perform fabric configuration.
 
-required:
-  - compatible
-  - method
-  - memory-region
+allOf:
+  - required:
+      - compatible
+      - method
+      - memory-region
+  - if:
+      properties:
+        compatible:
+          const: intel,agilex5-svc
+    then:
+      required:
+        - iommus
 
 additionalProperties: false
 
-- 
2.43.7


