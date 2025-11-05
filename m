Return-Path: <linux-kernel+bounces-885720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB19C33C48
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C5188C06F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEF2236F2;
	Wed,  5 Nov 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YBITJ44g"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B101F4188;
	Wed,  5 Nov 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309695; cv=fail; b=Mhf7lTlzIBxqOTZsSFCaJbmWAvlicJGw9m+yVCIXBdEjiUq+6EYUEHMVqt7qj4P/mWLtpNJvhfXnUtlbDWH076hpY/5Xd0Ri5L784wOiLtCJ+RPUC7UcLo4tZQXdByNyvgUFN4wYaHWvGh9Go4geqPixcceLVBr32+fWqhxQwbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309695; c=relaxed/simple;
	bh=K9zgo8W3FfBN/DeOM8CyFd2AdRNEdRP7yXVpxp2JL+A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LJm99qkxyn0hB84IHUh2RB2tctZ/2ZjRl1PIaYScF+qgsy9TxR4naduviiclsdqIR1mM9paC5tXS/zy+Raee9nOT85imj4NhwQn3MeD1aTzrfNSWctD7Vnk7vCEVC6sf7UcxBfZqfYDNiY71yryBo6/mxaJZAs5wXh9JfLuuYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YBITJ44g; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHlW+od1git9PsIxG+Wt7ISa7LcQ5My2GJ5ICW5eoh4kl/6dbAtSdkVJlxBbCJyXCYQKJpFcqiGYR2nWgV7I1rzLQCs63DH8loyFSttrXW+0a/8H/3x75kqdsmh3vECOpGrV7xErgd0kjS5rfx703eW8QPmNIUNxONDfcgAU31mYdNCQF5Tcur+5huoWPb9zXljLxnSEY1Dh24rP/CZOfLW6mKSepGywECsseFI7xyHvOBkZOt2eioYBa2DljXypeK9ImNNEjJ6NKYvt1x7S2XGa/AUPCTzrGJkGdL4qezXKY88V4M125IqWwQGMOc1v3Wk+4tEoX56EoRVrN8wteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZlcIvo/5ZS4vFTJBD7eF4XAsAO2MpyYfkOv6VRBmFI=;
 b=xNdTaRd5IiuioZ6UqCW2RQDZGk+nVhLqyupUDQ+mHxC5l8N4z/Ags+SKrbNbtIxdJ1OQ4Wv9tb3vai71bZE82dduTw4YCLp/sFcYoI12FNNQ1JwKjVk8HnBDlUykW1gr2MTQ2KHgHGbBLVSKbICb3MwFNTelYPbQeXpOZ41k4d2OWbFbOS1L4LbYILrlLa7ByCOuIMnZeYq6yymlAnLvF24iLFJd6ajKVIREq7J2eKIXiPS+nS2smX4SXhfhAB2d7aHLvDOV0Ew8uf99c/ZemOe6NTsCgw+GOG/ByZgLosJcrNcJVuxHWH9UGrvcYivcMIMnO1EtfA85oMCZNTNo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZlcIvo/5ZS4vFTJBD7eF4XAsAO2MpyYfkOv6VRBmFI=;
 b=YBITJ44gouW2WCaBiTv45VfKOr8EfBWH0vulcxEI1wDMLeiMeYAvIzrpwty3SXf5VPAR6NrpYAL+zyk4nL2X5jJEkvcz50UcbAgnQn/GViRY69RZuRHtsvBWOtHhFJdFuqHs5Z+6D8EDFRc7o/FdXOx9A49uJsoUuKM3sAHOeKJ1sY+Qmc4JXtyiddLMqWfiWaYHUYubmrvcXHr9XHF8fycucFry4VKZBJQ3NgC0Gzp+xIBOMxTM8pb2NUINuSm1+aLMMWGp5xghU6iDojLjqGbj/vj5qpF99T2Qz6np62Qj7p4aEiknLDLTOCpNuHyWoYTpFeqIDhJ3WtN126kL4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7997.namprd03.prod.outlook.com (2603:10b6:806:42b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 02:28:08 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 02:28:08 +0000
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
Subject: [PATCH v5 0/2] Enable Service layer driver for Agilex5
Date: Wed,  5 Nov 2025 10:28:00 +0800
Message-ID: <cover.1762308672.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA6PR03MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: ada927f2-b2e1-4189-cb84-08de1c12f53f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7LtO1BJnLuGJWC9lELk4QxbNUZQbmiqy3tQ/YqHqvRR75eJftNXdz4b/qEO?=
 =?us-ascii?Q?MxJotHt0qfuhll8iKMdASNSMDsBDAt48BFmiQLVhiVaZYXiDXOoRxLPEigEp?=
 =?us-ascii?Q?HrQgUZb2yBpNQ/UmsrqHZeQMmqQUIRS6CK3zXfQfF0jaoYUqB8rgiqMVpZMZ?=
 =?us-ascii?Q?cHudzBFiv/6jUUdkTOqweDyBof2ZFfzho52AsLXPC3MBk42uEvk2O10ELNgF?=
 =?us-ascii?Q?glZ+OK8I4P1Nb7st1Hcwox4ofuQEovmRp8SONMOoMbuTlVDXD7ERkLvSdwUh?=
 =?us-ascii?Q?br6qOSlFzHG6OEoncpZln60rVSMBeevfsLyJ++Dwl58YC9EKyVyto2Wvp/E8?=
 =?us-ascii?Q?aj61R8eQciI0KG7t1qFWQ2yXs1hVdu5tq3R2s0elMtfxiZDOx/wudtId4onB?=
 =?us-ascii?Q?F0bHz9moyB53e6hWINCXI18ycGDlm61Zr3k2tbnwZr8gE0pqhbVkaZDUR8IB?=
 =?us-ascii?Q?lZ0KJEcboELZAmj5KlXIMSCEa4DI10kzMtGh/i9hzs3KOLG42t7s+cF0HVQ2?=
 =?us-ascii?Q?Ul6ualND7d8cTOUsGhMkp2X0y+8lxXIevQS5Wa9vmxfgpDw9RHruhsAWvu9v?=
 =?us-ascii?Q?7dsSt41tcupua5rdQvV7DX1rYWVZqgQha6Pp15QTm/GfLeE9E3bjCchaboM7?=
 =?us-ascii?Q?HlYHbetkttyaIYkUcKux6YjP3CKGOyZY0UrY9vImj9qkTfVjT/wlJ3qswLkg?=
 =?us-ascii?Q?SpkuVXJlg7ki7MS1gxtmrCfLtNXt/ATLKB7VK86exGCICJmnSv+k7vQ1aEUr?=
 =?us-ascii?Q?z/WLEQXKWLWZPLLmRWP5yQ+awkJ/j29quxMtI90nRemiFM8gpsR9eF2Mjm4+?=
 =?us-ascii?Q?g8WgcQlBB5cuMHxeuXBbby0MFSF0V+QRQUesro6tJAMXLrQoCX5iqbDlRgYH?=
 =?us-ascii?Q?RvEk7KzUB2jj0wMOvWuU3ZMss3HAMakOzR+bOnfFyMtNvghUUJLOmf5KnVRo?=
 =?us-ascii?Q?j2UF/8yFJn7fTBQAhaCjZs13CqOXUx/XzSwiRGmB+GYZyTbo4VWu0ksGbzAL?=
 =?us-ascii?Q?xIb0a6SB42uk5/Kds8x24kJe2Ahi0Jm9jyPS945JjdptbaHNUtB9o6Hh/RmA?=
 =?us-ascii?Q?zuaW58x7dtAyFP9OSFwil3LtWQr2qt7BBej5GEiqEwgX+rsDhhPgghhjY5X7?=
 =?us-ascii?Q?BljxGKmrK5CVGjItSOQhOqqvTVObSoiqQ6Q/98CkHlZ9mfkRUY95GIUpMD35?=
 =?us-ascii?Q?ji/daWxm5SyKrLaLWWUyNLxozCBRsyB5NR/RLOjTdcYeXterufME76ZDTdgV?=
 =?us-ascii?Q?8M2EzD8hmHcncnhoEyymrDKPc8pvhltOiES7zLR1Mi98hdM2+FTk45A5XISK?=
 =?us-ascii?Q?s86XV8suVgqDIZfh3jjbsUjjw74X+VTAXgkd7w0BnigCXwGQr8fYFpqsubGf?=
 =?us-ascii?Q?unkI3baPDSSCDUHkeHeEUogVKWH9i077gnkiWb8BEvmj2jIpR0xVPbfjjPu9?=
 =?us-ascii?Q?mUHnu9rqD5DWStIr+pfP2bePy9lzO7QPuAOFQI/Kz2o+wKpZPQtStsdgwOrR?=
 =?us-ascii?Q?hyANDJrn0bvGZyd5V3mHfbdY8ThfA1f6zfk9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wa0kHboSjh3R242gBpATVtEwPj3Ch+hGh7+wfoZOUl1CVYMA/SDSEIWGzIeH?=
 =?us-ascii?Q?yswoyQyLvvbQwWeNUwXdSC3Rtpy59G3VnsnZ0NHENEixYrQg5DfJZ0thVHwX?=
 =?us-ascii?Q?hGaYIWCMji4OEfXiZvBt2AZvf5FWE60Oga7HWOTyYnv5jKp9OBa0pT2i2Tmx?=
 =?us-ascii?Q?GNlYbBFNNpx8UdRsmFb9V/etIUCXfB0VQAHCxT/5wzdD1HEb4IMSZFBDC1fw?=
 =?us-ascii?Q?LL+bgO36xr7JGDXTeqgPCBt3fta+2Y367ENpR+JyHbFlDt18F2Tz7pKMFlss?=
 =?us-ascii?Q?sOMMVYlguBr7RovamB+1DflbUsx6IJhQtpYlpa9hx/N5kPMETy0fWuD6hVhY?=
 =?us-ascii?Q?CxThBIAZ4lmoV6llcvKgN558/6dm2iWX08o74UgUiWfxqUKJ3e5REoaI46fw?=
 =?us-ascii?Q?C8Jy9Da6do14qLsgnGGXmaP+w8HWhR2/f7YHvJiJfDN6Lj3NTxiZeV5eXjPy?=
 =?us-ascii?Q?O2pqVojj+0+yiypX3nVSgGcri0nUEsOyDWSRTpx8YjRzuTQwf2Oi9WTdJRpL?=
 =?us-ascii?Q?Vq5MbAYiQZbRxCOL0a6+095qHBQ7R4UKv3i/vyxzc14ykFwpziT+wVVV08MT?=
 =?us-ascii?Q?6bxFgePIBeTfosuEGl7tqRIsvI3Pu/k3CAtXBVvRgq/h0RQBk6dl8Oot0yEL?=
 =?us-ascii?Q?YApCMUz1UgzgfxvEeehwMKg58k9Hf5ojwBC5+sd2yLo2qf5Rr3lTOOZ79csY?=
 =?us-ascii?Q?tQxQ/+4M+cpyl2zG6sQWIGFmS2IngCX/xs2IboxGJttentnJM61G9meuRphK?=
 =?us-ascii?Q?4Ltvq2Y2uerFQ//TM47OO1DkcwSZZkGMgTnBZjVhlD6fAwY1RvHEviY+TRwn?=
 =?us-ascii?Q?mbsnliHIdHcQsbS2In8s29UMKnRq+V/lYn8G9bOYwmVKvYlUUEx3PCHEboBA?=
 =?us-ascii?Q?1wsOU3eCYEV2UIpBilnKXlCObif8hXickw6OtlXVFJWMEgx8/mvVB8f+ssmn?=
 =?us-ascii?Q?ZrXhbXu1Uk43pFiGXqfAmMkjg65XjyMjZvq8O8aONYD8WNZBBmAIIYiCjhy4?=
 =?us-ascii?Q?C6ImJGau1uazbT5doUtCp1RvtGQkQUSq9ImhYSowgYJOiKd67V9p5rCvBJRW?=
 =?us-ascii?Q?A9OJA1j7lX6Iv/6eXSeAR8nGPwa7fDICWN/6SbEXuqRvQPHGL4yYzuMaXkX/?=
 =?us-ascii?Q?1zCT9ZclA6XtbvwFTfATxV91bnt1GAyjQod/eoKgqB5T99Lra0oCoT4Hi6JU?=
 =?us-ascii?Q?oWFCdDbvXnq/iFMYbreTFGubR+lKCnIAhoUsl1tIybH3oK3wI40ToOU6wU0S?=
 =?us-ascii?Q?Q7gXK+R1OubP6aSOdubSgORs4A1QoIe8Ati8f4u0kCQI4CHACZZm+vzS5f5g?=
 =?us-ascii?Q?+QKxbTBmSQ5kHFdGguRHrRjjgqGXvgz51OgTvIU/vVa/DRYCXelDh0eH9qNB?=
 =?us-ascii?Q?i3llsuazrNkhvrrje4knaRteQG82hnDjbcYHAwxj3p+KDeSQN5WhHp75pYzA?=
 =?us-ascii?Q?u72tdFSM1woAnS3hE05MU/L1veBeIj9K/T57VhukL3J+5GXeIpXOV4g2Asdm?=
 =?us-ascii?Q?f99YnutySnry5C9/umRTRJoQ4H0+haJoqCbUhXzYe4CSTauDXsOb5DO3mmS4?=
 =?us-ascii?Q?bILDVbZZPpPzlwiU/igKb2vSEjECzkL5PRgEg792VTp9Cdf5Fv6Gdcgd7vuZ?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada927f2-b2e1-4189-cb84-08de1c12f53f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:28:08.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t4tZ9LDRJ4aSKpvMAL2bguEF9VUIsXbW9P1VTwk1ztIGb+tiFMiigC7zAhmFMIWdFS8GI3FrZJbRSNcIWBNf8Zz/J4kLSQzfnuT6wSQApw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7997

This patch series introduces support for the Agilex5 service layer driver
(SVC) in the Linux kernel. The changes span across device tree bindings,
platform DTS files, and the Stratix10 SVC firmware driver.

These changes are necessary to enable firmware communication on Agilex5
SoCs via the SVC interface, similar to existing support for Stratix10 and
Agilex platforms.

Agilex5 introduces the ability for the TBU to operate in non-secure mode,
making it accessible to Linux through the IOMMU framework. This key
difference enables improved memory management in non-secure environments.
As a result, this series extends the SVC driver and device tree bindings
to support IOMMU integration for Agilex5.
---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v5:
	- Use contains enum instead of const
Changes in v4:
	- Refactor the logical check without using AllOf.
Changes in v3:
	- Remove driver changes in driver as it is fully compatible
	- Add iommu entry and rewrite the git commit message to describe
	  why the changes is required.
Changes in v2:
	- Add driver changes for Agilex5-svc compatible
---
Khairul Anuar Romli (2):
  dt-bindings: firmware: svc: Add IOMMU support for Agilex5
  arm64: dts: intel: Add Agilex5 SVC node with memory region

 .../bindings/firmware/intel,stratix10-svc.yaml     | 14 ++++++++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.43.7


