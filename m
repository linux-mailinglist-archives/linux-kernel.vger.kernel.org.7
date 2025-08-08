Return-Path: <linux-kernel+bounces-760744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00CBB1EF91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0041C26F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645B22B8D0;
	Fri,  8 Aug 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vd+dM0Hf"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94820F069;
	Fri,  8 Aug 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685558; cv=fail; b=pq7IX2807zmvYTSh391edGrYzh9vRuH6Vr9kK3Y2npcN/pWV+tOREeRx6+CqGYWPCXDsLrM8eR2CxKp6QdPhMZNOZwCZqT72S1YDpfsvuvLwXDUVpITFrbXk7GvEwwNPCJhO9FUadQweBMJR3MWPJIra+vb7bG3E17/mJjPaNQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685558; c=relaxed/simple;
	bh=5bu7jn6F8BBDSuwmpmDxrRzEtDBi24LJmZrGOO3e5qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aATfOfZ/6KjsSXOiwNK46gtCltqYqb8jhXosmtmMIaPe8fs+t3BcSiBjAgrm2qnbduRGDqOOwbATz7AyanwnGtXlqijmvWvllHsYGrg+olfB3zSeU23TAku26/+w4hw6gqzbF31Ivl29tPOrtj4x7P0xbQ/lpvM3EAu9LMoqe/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vd+dM0Hf; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9xZDqGarsk3vZHfSp3bKg93C4u5QPjnpq5BFKWk1htO+0DpY/e2nKott/yMtc2y3mqvN8q4rw7TvwwvQFZybKjNvV7JPyHbPNkIea2Gjs0cfh8uwPQn3CrBNKbNaHDLkmVCg0Y+QMI+M/XE9WVhL8KI8UguRoAS4v5P5AyKBomqTnIZca2a1T9ytAum06EOXKKkYwc+9l+3hzt/u9i+0CQvUXpGMKAmStlc6r68VtjnF9+79URLzREBsuRalLEJY+yAC+0uyJsJNPx6FUFxteZWs6OmNb6EH+yv7p+NcMbnfktOBHxckowwBl8eNAgqbFIldwzg6eQl8tVVJNsRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4op+qYy2y2wRETrnYvW/vGso7kb+xRJ5tBO8mlNdMg=;
 b=y0luEPbM4is1nAYNDPMFJwTGxQB0+V6RdaRzdOg+ASq5jcyM71TghHccozZ+2sgl5lhAFGzLWtOOj8LCYBSjrQhizUkSuQQWwqNRW/qcaSDjC2ggUaRAQoNBjgfc1sPQRtB5HiOxS7ZhkUhu9wZrPcUIM8Hzbn/5G3f4LFYTdeq335tPL5TeHZgDq5V21z+HKFMnLYjcv5v7g1SeP0A/7LaH8vLwUNHwoAR1B5sBY8dJgT2pnnSonJT59cEWO1TQM/DHDH6aJgh4hrifIzytNgQVcGVlRrChloE4qZi781QGfQeksYwhGa3Iy1CBqR3MzQJglLk+6RJVeOIdVQGVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4op+qYy2y2wRETrnYvW/vGso7kb+xRJ5tBO8mlNdMg=;
 b=Vd+dM0Hf1Vc/noAMUkx4D4T7mUP9n0D2u0FD30DyduH29vegEm88vonjwIIOAoLQhbGaJNY7ey+yQ4sty0Jtabo0LUk9aD87LVnyP3fKa49ForW4J+2lqwHlOloPaSi4DqIxMr6OFoVSD8xuDlrfYpKi+EZodSW9M0jqL3QRWkyctFdUbIjQc7/xJcLwHShfrFQWQCDMaVZR4CEGmQQcsn0QJGy3ZzgPKXIGh86dR2Z/xm3HCGfYrXEPVJ7vpVHnQjpLe7e30XkOlKLzdN47SG2ooMi2KNGlVUjM2O0/l0TkYLcyf8astu230CLaJ8+cp/N8UpMLtgm5yBa9B5a8PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10537.eurprd04.prod.outlook.com (2603:10a6:150:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Fri, 8 Aug
 2025 20:39:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 20:39:09 +0000
Date: Fri, 8 Aug 2025 16:38:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, broonie@kernel.org,
	lee@kernel.org, vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v3 2/2] mfd: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <aJZgY0DhHSxUGvWx@lizhi-Precision-Tower-5810>
References: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
 <20250808132033.3996614-2-aman.kumarpandey@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808132033.3996614-2-aman.kumarpandey@nxp.com>
X-ClientProxiedBy: PH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:510:5::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10537:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4ca877-f3a3-4628-1ee4-08ddd6bb9fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udy0VTaLakiWDXTk6aTZZvtvAFYQGbCJ/YUsTutkHIZ3N62Z77IZ3iIL7TOF?=
 =?us-ascii?Q?fP8a00nIPHRfkW/Og0xkSMqPVAfG1TKvvMDhFnVWrQIjf0Tqjr/my8Zs+No2?=
 =?us-ascii?Q?AiLa6ujuhvn9jizJGaBb2mq+UkgQHwY0+SV2aGRJnir1Ub6wUgHObPY7fV8l?=
 =?us-ascii?Q?8YLiYH51zmrlF1FO3/EfF9smrdf+LsSFIfbhfhRjT3ZvmAsB+7xOqzE5GOn2?=
 =?us-ascii?Q?eLzmAVBEw2Yotv10BLlOEW+Z87yV8qMkV625CyK3sLoH/ZZBydT/5X9j2JTs?=
 =?us-ascii?Q?iYD/+h8rGsqm9WcR/t30WjcICm2n1ICxHio8eHBVXoIebJpnnwIRY45BwpkJ?=
 =?us-ascii?Q?kCTjWT8fflIcVdjrVIJVvUfNpmPUzYF6EvEhm4u8G/0W1AFr9uTt7c0YMlt2?=
 =?us-ascii?Q?5oVc9de9g3+PsChdNaWGyzKqHhjTNDOzAVZB4HABSmf5T4x16kphROqX6fOr?=
 =?us-ascii?Q?hq+JGF6tHFj+kpzG93uZjjHYKSVxYaLrgu1tk1GI4e21QAvXrUEN6CgNlIdJ?=
 =?us-ascii?Q?zCf1ktyNQ+ymHkqVZSVX68i2tYa6ePwnuXWLzkdSacKHZSlQW+QWTDg6iCFr?=
 =?us-ascii?Q?Shqtazjn6/9vHhG0awjNh1wbkZ1Cj8XDUSEuoLirJKTHmbDei3HzkF6rIkjl?=
 =?us-ascii?Q?SFo0RMSkSeWHoboi1qQd+mxxHbcZTWHAW+F54TJBbQ9UePhyaJxAdKYLAppn?=
 =?us-ascii?Q?jcpYNnJCNVGJZqiVSfHSGQYNzHQquS8E8lQ3rYrqvKZJ9htRDNEywr0whtbJ?=
 =?us-ascii?Q?Ap0dvHNPaBtIQtilVeqiTsMcSoZBVwHJ1QJGUuxz0mdm8g87jYW1ct6sDXMw?=
 =?us-ascii?Q?l0gisaFqGfUA5enYZDPf8Q6xPiywx9kRUx7kTC8bolSI/sDRxKN1QfzmdTA+?=
 =?us-ascii?Q?FKdJX6foPSuIyTn1veR0atBY7tMmuCnmayGgf50LVjeSQqE6nGe7nNsJI/eT?=
 =?us-ascii?Q?m6mTxuFByudEXR1d4RpvOrFo4qSNiUjDWxhDAZBG8YY4g4EI4/V2njbLCDCI?=
 =?us-ascii?Q?fsTRzqgKCQGJqPjzSF5wjBkwCvZk2YFw3Y/VfJnALKknwv6/tkxjzAe6kQSw?=
 =?us-ascii?Q?umFz18NzuEhGFLJlWxLzkDNEE9UnLK5N/UB2wgeqsBFba8HxaWQ+wQe6R3df?=
 =?us-ascii?Q?G9TWBeWe0+yrZIkHJJ/p61qQfHJ87IfH8mYSEqbzaFXHhbLZWK4WaPgrTIdR?=
 =?us-ascii?Q?Etcr14RYzcZEZSi0qCWoAuDIbbUMtASQZWMwEvJmRV6GIUCZJ8N5cYlQbhoH?=
 =?us-ascii?Q?ZCDq1m0h11J+qDKMV2kV2JrMapQoquLWtxHHugOSWS2k0PlcB+5LdBhJXBPS?=
 =?us-ascii?Q?0RaPAb924sXUyD7Mmuj/tUmMJZcVB+X4nfczSqULpeplWKgCnyn1DKa3mHMq?=
 =?us-ascii?Q?cA548stB1pdxnyq8DCs6R+aF70NUkoCmDjb7kb5tPDfetaH2zPcVXVK8QxQ5?=
 =?us-ascii?Q?9mvPcz56jgDw56RfAUcua/DL6NR5u8Y+d9FiFamypvZ/FqVH8IqvxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C327edidDauQ6yAP3IwbTQXF2mwB3GFIXgw+lM9I5iZ1WBVplqPMTkJFS/7/?=
 =?us-ascii?Q?heCoc2mG/+i687SkKm2PlFK84p2/z7j9TKg/2S/wVxbFFTYQB/Cxhk590Unh?=
 =?us-ascii?Q?wJI2VOp58JLTsp+VgvfZV61PtnzGu5QlMOUUWblujiaGVBhFaK7cJc+9xpSG?=
 =?us-ascii?Q?SKdNKHSLTpOi+CkLEPP3DI1YCF7hAqFFO9t4HBkNZicJoRa19pJGib0nSO3B?=
 =?us-ascii?Q?oiBaMeh1L2dTu7S+nMMX+Y/fwrrnGFeFmAPFdf5k6BI1AjMfDCLi8f3NT1GK?=
 =?us-ascii?Q?ZM/A5ldiy/pSQ3LLmIFueVJKvf1YIpeROQn361HiUGXOXyHR0gxPbOJpWZuP?=
 =?us-ascii?Q?DVxApS+hAH1hXcLYK4eb8hPkIm8kE0u49OaITJVPBSb0oy+emkrLTOZ4J8WV?=
 =?us-ascii?Q?br8trS2LmRbQtjX/kiZFCKxrhpRMheQ84xLDIHGFqXFEzTTYT8I9t24aWnyk?=
 =?us-ascii?Q?8Zu0+pNeetGx3KRZIC/zU3ICvsQep/p3bPKqhDdU+MV9aJ8GOmtIgUFXaeQR?=
 =?us-ascii?Q?hlrbCkuIp6pBZiqfa/hYHSjqbljOUZiS+89N091eU1qvAC3tE4xN69jo8D8c?=
 =?us-ascii?Q?QtRnOpFnYDT9xUbGOyTaE0JgNonbR5Z6TZmPiVnTpJWiztnHvjXMFiDDMKrR?=
 =?us-ascii?Q?h2lrQKwbR/gLuU0IdASMVxBbNlPMm5vMIgfD6Zm6lQvBEEXQ++CInmuPXMlG?=
 =?us-ascii?Q?H4iK4jdk4hNqRA/CBGVX0+ybzFBRk1j5KsEG4B2HYA3I/22FYRMrIswACpwf?=
 =?us-ascii?Q?cDsoGHEq5/CRNVSGQt09CLEtA7edRGPkIJh8CMKncBFj1Nt5oVHP47ezs4rh?=
 =?us-ascii?Q?sFf3i97ZVcoeCQQhWiySSicUospiDLOOXzXD/XhNKbyRevnDiwi9k17qiduG?=
 =?us-ascii?Q?avRL9G4coOQl6jreH448e8ZewL8jiZYO0cUvCgoqvGxP3TOHM7RAteQTdrFn?=
 =?us-ascii?Q?8Z3Hx8/FBiAzH2XYPzkrbViHIEpteiQmDn/o2UMOlMbDYOyK38KuygJrnwo6?=
 =?us-ascii?Q?nsrAhjT2FvCFHzoJDGzMbdIWH8OONYjEe/6/Bat4CPil1X9hYCTX1U+qIN6t?=
 =?us-ascii?Q?7vrSUZMLm0E4VLCMGcQc8bH/Foj+cApK2aWBoSVe9VtanemV6d4RXYezUJSm?=
 =?us-ascii?Q?agR9oUHD1XuP0TqYSleRdwgpFKC8GWawKV2iz++i6ffF5ijlxYZz+SPsIVRi?=
 =?us-ascii?Q?dVDXLTccQv8WlWBNbUSNwxTj9AeLhZS6Q9c03H729IBJ8FAuJP1MsJnmPogV?=
 =?us-ascii?Q?baXDiDBmthNx70Fk5sVFRG/FtixGt87XumpXD9Hic9QTy+heXAYoZs7w4Gr9?=
 =?us-ascii?Q?70Fdkzni78BzyKejjtZ8mgEoKeXFPq0z6ScMeFRzJxRQBAq8IkzAwiZmbwoo?=
 =?us-ascii?Q?8Yfn8edVPvBUfveuoy8NvdY1YxQ2GUEQ9PEUHH52MlESftOnC+tNXPaxZT5t?=
 =?us-ascii?Q?b3zvSXczC+p6IO4slPm/Doj5YL9CbqjBrAmoO9+mVcyJ7Q6c0g3KIEUfAinu?=
 =?us-ascii?Q?7omm+fZwyGO2uMOOQ1/q3rapCJY3O/ssil3+FKUqxiKsD/sc8d/59BIZlPn+?=
 =?us-ascii?Q?yYAJlzLrMa5nb/goevett7Eti7itEgXgnbAAubzb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ca877-f3a3-4628-1ee4-08ddd6bb9fd7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:39:09.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6KtJ7WmFtnYcOavkUdtK9MFBCqsd7nrnipo7r73AB8lWNC66K/QL9m7mc1OTmsrm6lPs80drk/74xTD/SN3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10537

On Fri, Aug 08, 2025 at 04:20:33PM +0300, Aman Kumar Pandey wrote:
> Add support for the NXP P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841)
> family of multiport I3C hub devices. These hubs connect to a host
> via I3C/I2C/SMBus and provide multiple downstream target ports.
>
> This driver adds the core support with separate drivers adding support
> for I3C hub and regulators.
>
> The driver supports:
> 1. I3C/I2C communication between host and hub
> 2. Transparent I3C/I2C communication between host and downstream devices
> 3. Configurable target ports (I2C/SMBus or I3C)
> 4. MCTP device support
> 5. In-band interrupt handling
> 6. On-die regulator configuration
>
> P3H2440/P3H2441 support 4 target ports;
> P3H2840/P3H2841 support 8 target ports.
>
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
>
> ---
> V1 -> V2: Cleaned up coding style and addressed review comments
> V2 -> V3: Added mfd device support for i3c hub and regulator.

need re-run get_mainstainer for your patch, at least
Mark Brown <broonie@kernel.org> is missed.

> ---
>  MAINTAINERS                                   |   1 +
>  drivers/i3c/Kconfig                           |   1 +
>  drivers/i3c/Makefile                          |   1 +
>  drivers/i3c/hub/Kconfig                       |  10 +
>  drivers/i3c/hub/Makefile                      |   4 +
>  drivers/i3c/hub/p3h2840_i3c_hub.h             | 380 +++++++++
>  drivers/i3c/hub/p3h2840_i3c_hub_common.c      | 782 ++++++++++++++++++
>  drivers/i3c/hub/p3h2840_i3c_hub_i3c.c         | 345 ++++++++
>  drivers/i3c/hub/p3h2840_i3c_hub_smbus.c       | 627 ++++++++++++++
>  drivers/mfd/Kconfig                           |  12 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/p3h2840.c                         | 129 +++
>  drivers/regulator/Kconfig                     |  10 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/p3h2840_i3c_hub_regulator.c | 163 ++++
>  include/linux/i3c/device.h                    |   1 +
>  include/linux/mfd/p3h2840.h                   |  22 +

You need 3 patches
1: mfd related change
2: regulator change
3: i3c/hub change

>  17 files changed, 2490 insertions(+)
>  create mode 100644 drivers/i3c/hub/Kconfig
>  create mode 100644 drivers/i3c/hub/Makefile
>  create mode 100644 drivers/i3c/hub/p3h2840_i3c_hub.h
>  create mode 100644 drivers/i3c/hub/p3h2840_i3c_hub_common.c
>  create mode 100644 drivers/i3c/hub/p3h2840_i3c_hub_i3c.c
>  create mode 100644 drivers/i3c/hub/p3h2840_i3c_hub_smbus.c
>  create mode 100644 drivers/mfd/p3h2840.c
>  create mode 100644 drivers/regulator/p3h2840_i3c_hub_regulator.c
>  create mode 100644 include/linux/mfd/p3h2840.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b33e90030188..220978128696 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15484,6 +15484,7 @@ L:	linux-kernel@vger.kernel.org
>  L:	linux-i3c-owner@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> +F:	i3c/hub/*
>
>  NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
>  M:	Jonas Malaco <jonas@protocubo.io>
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index 30a441506f61..254c50c3d33a 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -21,4 +21,5 @@ menuconfig I3C
>
>  if I3C
>  source "drivers/i3c/master/Kconfig"
> +source "drivers/i3c/hub/Kconfig"
>  endif # I3C
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> index 11982efbc6d9..ea01bdda938d 100644
> --- a/drivers/i3c/Makefile
> +++ b/drivers/i3c/Makefile
> @@ -2,3 +2,4 @@
>  i3c-y				:= device.o master.o
>  obj-$(CONFIG_I3C)		+= i3c.o
>  obj-$(CONFIG_I3C)		+= master/
> +obj-$(CONFIG_I3C)		+= hub/
> diff --git a/drivers/i3c/hub/Kconfig b/drivers/i3c/hub/Kconfig
> new file mode 100644
> index 000000000000..9d3e1a29e744
> --- /dev/null
> +++ b/drivers/i3c/hub/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2025 NXP
> +config P3H2X4X_I3C_HUB
> +    tristate "P3H2X4X I3C HUB support"
> +    depends on MFD_P3H2X4X
> +    help
> +      This enables support for NXP P3H244x/P3H284x I3C HUB. These hubs
> +      connect to a host via I3C/I2C/SMBus and allow communication with
> +      multiple downstream peripherals. The Say Y or M here to use I3C
> +      HUB driver to configure I3C HUB device.
> diff --git a/drivers/i3c/hub/Makefile b/drivers/i3c/hub/Makefile
> new file mode 100644
> index 000000000000..9dbd8a7b4184
> --- /dev/null
> +++ b/drivers/i3c/hub/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2025 NXP
> +p3h2840_i3c_hub-y := p3h2840_i3c_hub_common.o p3h2840_i3c_hub_i3c.o p3h2840_i3c_hub_smbus.o
> +obj-$(CONFIG_P3H2X4X_I3C_HUB)	+= p3h2840_i3c_hub.o
> diff --git a/drivers/i3c/hub/p3h2840_i3c_hub.h b/drivers/i3c/hub/p3h2840_i3c_hub.h
> new file mode 100644
> index 000000000000..bcd99004a844
> --- /dev/null
> +++ b/drivers/i3c/hub/p3h2840_i3c_hub.h
> @@ -0,0 +1,380 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2025 NXP
> + * This header file contain private device structure definition.
> + */
> +
> +#ifndef P3H2840_I3C_HUB_H
> +#define P3H2840_I3C_HUB_H
> +
> +#include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +
> +/* I3C HUB REGISTERS */
> +
> +/* Device Information Registers */
> +#define P3H2x4x_DEV_INFO_0					0x00
> +#define P3H2x4x_DEV_INFO_1					0x01
> +#define P3H2x4x_PID_5						0x02
> +#define P3H2x4x_PID_4						0x03
> +#define P3H2x4x_PID_3						0x04
> +#define P3H2x4x_PID_2						0x05
> +#define P3H2x4x_PID_1						0x06
> +#define P3H2x4x_PID_0						0x07
> +#define P3H2x4x_BCR						0x08
> +#define P3H2x4x_DCR						0x09
> +#define P3H2x4x_DEV_CAPAB					0x0a
> +#define P3H2x4x_DEV_REV						0x0b
> +
> +/* Device Configuration Registers */
> +#define P3H2x4x_DEV_REG_PROTECTION_CODE				0x10
> +#define P3H2x4x_REGISTERS_LOCK_CODE				0x00
> +#define P3H2x4x_REGISTERS_UNLOCK_CODE				0x69
> +#define P3H2x4x_CP1_REGISTERS_UNLOCK_CODE			0x6a
> +
> +#define P3H2x4x_CP_CONF						0x11
> +#define P3H2x4x_TP_ENABLE					0x12
> +
> +#define P3H2x4x_DEV_CONF					0x13
> +#define P3H2x4x_IO_STRENGTH					0x14
> +#define P3H2x4x_TP0145_IO_STRENGTH_MASK				GENMASK(1, 0)
> +#define P3H2x4x_TP0145_IO_STRENGTH(x)	\
> +		FIELD_PREP(P3H2x4x_TP0145_IO_STRENGTH_MASK, x)
> +#define P3H2x4x_TP2367_IO_STRENGTH_MASK				GENMASK(3, 2)
> +#define P3H2x4x_TP2367_IO_STRENGTH(x)	\
> +		FIELD_PREP(P3H2x4x_TP2367_IO_STRENGTH_MASK, x)
> +#define P3H2x4x_CP0_IO_STRENGTH_MASK				GENMASK(5, 4)
> +#define P3H2x4x_CP0_IO_STRENGTH(x)	\
> +		FIELD_PREP(P3H2x4x_CP0_IO_STRENGTH_MASK, x)
> +#define P3H2x4x_CP1_IO_STRENGTH_MASK				GENMASK(7, 6)
> +#define P3H2x4x_CP1_IO_STRENGTH(x)	\
> +		FIELD_PREP(P3H2x4x_CP1_IO_STRENGTH_MASK, x)
> +
> +#define P3H2x4x_TP_IO_MODE_CONF					0x17
> +#define P3H2x4x_TP_SMBUS_AGNT_EN				0x18
> +
> +#define P3H2x4x_LDO_AND_PULLUP_CONF				0x19
> +
> +#define P3H2x4x_TP0145_PULLUP_CONF_MASK				GENMASK(7, 6)
> +#define P3H2x4x_TP0145_PULLUP_CONF(x)	\
> +		FIELD_PREP(P3H2x4x_TP0145_PULLUP_CONF_MASK, x)
> +#define P3H2x4x_TP2367_PULLUP_CONF_MASK				GENMASK(5, 4)
> +#define P3H2x4x_TP2367_PULLUP_CONF(x)	\
> +		FIELD_PREP(P3H2x4x_TP2367_PULLUP_CONF_MASK, x)
> +
> +#define P3H2x4x_CP_IBI_CONF					0x1a
> +
> +#define P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG			0x1b
> +#define P3H2x4x_ALL_TP_IBI_EN					0xff
> +#define P3H2x4x_ALL_TP_IBI_DIS					0x00
> +
> +#define P3H2x4x_IBI_MDB_CUSTOM					0x1c
> +#define P3H2x4x_JEDEC_CONTEXT_ID				0x1d
> +#define P3H2x4x_TP_GPIO_MODE_EN					0x1e
> +
> +/* Device Status and IBI Registers */
> +#define P3H2x4x_DEV_AND_IBI_STS					0x20
> +#define P3H2x4x_TP_SMBUS_AGNT_IBI_STS				0x21
> +#define P3H2x4x_SMBUS_AGENT_EVENT_FLAG_STATUS			BIT(4)
> +
> +/* Controller Port Control/Status Registers */
> +#define P3H2x4x_CP_MUX_SET					0x38
> +#define P3H2x4x_CONTROLLER_PORT_MUX_REQ				BIT(0)
> +#define P3H2x4x_CP_MUX_STS					0x39
> +#define P3H2x4x_CONTROLLER_PORT_MUX_CONNECTION_STATUS		BIT(0)
> +
> +/* Target Ports Control Registers */
> +#define P3H2x4x_TP_SMBUS_AGNT_TRANS_START			0x50
> +#define P3H2x4x_TP_NET_CON_CONF					0x51
> +
> +#define P3H2x4x_TP_PULLUP_EN					0x53
> +
> +#define P3H2x4x_TP_SCL_OUT_EN					0x54
> +#define P3H2x4x_TP_SDA_OUT_EN					0x55
> +#define P3H2x4x_TP_SCL_OUT_LEVEL				0x56
> +#define P3H2x4x_TP_SDA_OUT_LEVEL				0x57
> +#define P3H2x4x_TP_IN_DETECT_MODE_CONF				0x58
> +#define P3H2x4x_TP_SCL_IN_DETECT_IBI_EN				0x59
> +#define P3H2x4x_TP_SDA_IN_DETECT_IBI_EN				0x5a
> +
> +/* Target Ports Status Registers */
> +#define P3H2x4x_TP_SCL_IN_LEVEL_STS				0x60
> +#define P3H2x4x_TP_SDA_IN_LEVEL_STS				0x61
> +#define P3H2x4x_TP_SCL_IN_DETECT_FLG				0x62
> +#define P3H2x4x_TP_SDA_IN_DETECT_FLG				0x63
> +
> +/* SMBus Agent Configuration and Status Registers */
> +#define P3H2x4x_TP0_SMBUS_AGNT_STS				0x64
> +#define P3H2x4x_TP1_SMBUS_AGNT_STS				0x65
> +#define P3H2x4x_TP2_SMBUS_AGNT_STS				0x66
> +#define P3H2x4x_TP3_SMBUS_AGNT_STS				0x67
> +#define P3H2x4x_TP4_SMBUS_AGNT_STS				0x68
> +#define P3H2x4x_TP5_SMBUS_AGNT_STS				0x69
> +#define P3H2x4x_TP6_SMBUS_AGNT_STS				0x6a
> +#define P3H2x4x_TP7_SMBUS_AGNT_STS				0x6b
> +#define P3H2x4x_ONCHIP_TD_AND_SMBUS_AGNT_CONF			0x6c
> +
> +/* buf receive flag set */
> +#define P3H2x4x_TARGET_BUF_CA_TF				BIT(0)
> +#define P3H2x4x_TARGET_BUF_0_RECEIVE				BIT(1)
> +#define P3H2x4x_TARGET_BUF_1_RECEIVE				BIT(2)
> +#define P3H2x4x_TARGET_BUF_0_1_RECEIVE				GENMASK(2, 1)
> +#define P3H2x4x_TARGET_BUF_OVRFL				GENMASK(3, 1)
> +#define BUF_RECEIVED_FLAG_MASK					GENMASK(3, 1)
> +#define BUF_RECEIVED_FLAG_TF_MASK				GENMASK(3, 0)
> +
> +#define P3H2x4x_TARGET_AGENT_LOCAL_DEV				0x11
> +#define P3H2x4x_TARGET_BUFF_0_PAGE				0x12
> +#define P3H2x4x_TARGET_BUFF_1_PAGE				0x13
> +
> +/* Special Function Registers */
> +#define P3H2x4x_LDO_AND_CPSEL_STS				0x79
> +#define P3H2x4x_CP_SDA1_LEVEL					BIT(7)
> +#define P3H2x4x_CP_SCL1_LEVEL					BIT(6)
> +
> +#define P3H2x4x_CP_SEL_PIN_INPUT_CODE_MASK			GENMASK(5, 4)
> +#define P3H2x4x_CP_SEL_PIN_INPUT_CODE_GET(x)	\
> +		(((x) & P3H2x4x_CP_SEL_PIN_INPUT_CODE_MASK) >> 4)
> +#define P3H2x4x_CP_SDA1_SCL1_PINS_CODE_MASK			GENMASK(7, 6)
> +#define P3H2x4x_CP_SDA1_SCL1_PINS_CODE_GET(x)	\
> +		(((x) & P3H2x4x_CP_SDA1_SCL1_PINS_CODE_MASK) >> 6)
> +#define P3H2x4x_VCCIO1_PWR_GOOD					BIT(3)
> +#define P3H2x4x_VCCIO0_PWR_GOOD					BIT(2)
> +#define P3H2x4x_CP1_VCCIO_PWR_GOOD				BIT(1)
> +#define P3H2x4x_CP0_VCCIO_PWR_GOOD				BIT(0)
> +
> +#define P3H2x4x_BUS_RESET_SCL_TIMEOUT				0x7a
> +#define P3H2x4x_ONCHIP_TD_PROTO_ERR_FLG				0x7b
> +#define P3H2x4x_DEV_CMD						0x7c
> +#define P3H2x4x_ONCHIP_TD_STS					0x7d
> +#define P3H2x4x_ONCHIP_TD_ADDR_CONF				0x7e
> +#define P3H2x4x_PAGE_PTR					0x7f
> +
> +/* Paged Transaction Registers */
> +#define P3H2x4x_CONTROLLER_BUFFER_PAGE				0x10
> +#define P3H2x4x_CONTROLLER_AGENT_BUFF				0x80
> +#define P3H2x4x_CONTROLLER_AGENT_BUFF_DATA			0x84
> +
> +#define P3H2x4x_TARGET_BUFF_LENGTH				0x80
> +#define P3H2x4x_TARGET_BUFF_ADDRESS				0x81
> +#define P3H2x4x_TARGET_BUFF_DATA				0x82
> +
> +#define P3H2x4x_TP_MAX_COUNT					0x08
> +#define P3H2x4x_CP_MAX_COUNT					0x02
> +#define P3H2x4x_TP_LOCAL_DEV					0x08
> +
> +/* LDO Disable/Enable DT settings */
> +#define P3H2x4x_LDO_VOLT_1_0V					0x00
> +#define P3H2x4x_LDO_VOLT_1_1V					0x01
> +#define P3H2x4x_LDO_VOLT_1_2V					0x02
> +#define P3H2x4x_LDO_VOLT_1_8V					0x03
> +#define P3H2x4x_DT_LDO_VOLT_NOT_SET				0x04
> +
> +#define P3H2x4x_LDO_DISABLED					0x00
> +#define P3H2x4x_LDO_ENABLED					0x01
> +
> +#define P3H2x4x_IBI_DISABLED					0x00
> +#define P3H2x4x_IBI_ENABLED					0x01
> +
> +/* Pullup selection DT settings */
> +#define P3H2x4x_TP_PULLUP_250R					0x00
> +#define P3H2x4x_TP_PULLUP_500R					0x01
> +#define P3H2x4x_TP_PULLUP_1000R					0x02
> +#define P3H2x4x_TP_PULLUP_2000R					0x03
> +#define P3H2x4x_TP_PULLUP_NOT_SET				0x04
> +
> +#define P3H2x4x_TP_PULLUP_DISABLED				0x00
> +#define P3H2x4x_TP_PULLUP_ENABLED				0x01
> +
> +#define P3H2x4x_IO_STRENGTH_20_OHM				0x00
> +#define P3H2x4x_IO_STRENGTH_30_OHM				0x01
> +#define P3H2x4x_IO_STRENGTH_40_OHM				0x02
> +#define P3H2x4x_IO_STRENGTH_50_OHM				0x03
> +#define P3H2x4x_IO_STRENGTH_NOT_SET				0x04
> +
> +#define P3H2x4x_TP_MODE_I3C					0x00
> +#define P3H2x4x_TP_MODE_SMBUS					0x01
> +#define P3H2x4x_TP_MODE_GPIO					0x02
> +#define P3H2x4x_TP_MODE_I2C					0x03
> +#define P3H2x4x_TP_MODE_NOT_SET					0x04
> +
> +#define ONE_BYTE_SIZE						0x01
> +
> +/* holding SDA low when both SMBus Target Agent received data buffers are full.
> + * This feature can be used as a flow-control mechanism for MCTP applications to
> + * avoid MCTP transmitters on Target Ports time out when the SMBus agent buffers
> + * are not serviced in time by upstream controller and only receives write message
> + * from its downstream ports.
> + * SMBUS_AGENT_TX_RX_LOOPBACK_EN/TARGET_AGENT_BUF_FULL_SDA_LOW_EN
> + */
> +
> +#define P3H2x4x_TARGET_AGENT_DFT_IBI_CONF			0x20
> +#define P3H2x4x_TARGET_AGENT_DFT_IBI_CONF_MASK			0x21
> +
> +/* Transaction status checking mask */
> +
> +#define P3H2x4x_SMBUS_TRANSACTION_FINISH_FLAG		1
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SHIFT		4
> +
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_OK		    0
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_ADDR_NAK		1
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_DATA_NAK		2
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_WTR_NAK		3
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SYNC_RCV		4
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SYNC_RCVCLR	5
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_FAULT		6
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_ARB_LOSS		7
> +#define P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SCL_TO		8
> +
> +#define P3H2x4x_TP_BUFFER_STATUS_MASK				0x0f
> +#define P3H2x4x_TP_TRANSACTION_CODE_MASK			0xf0
> +
> +/* SMBus transaction types fields */
> +#define P3H2x4x_SMBUS_400kHz					BIT(2)
> +
> +/* SMBus polling */
> +#define P3H2x4x_POLLING_ROLL_PERIOD_MS				10
> +
> +/* Hub buffer size */
> +#define P3H2x4x_CONTROLLER_BUFFER_SIZE				88
> +#define P3H2x4x_TARGET_BUFFER_SIZE				80
> +#define P3H2x4x_SMBUS_DESCRIPTOR_SIZE				4
> +#define P3H2x4x_SMBUS_PAYLOAD_SIZE	\
> +		(P3H2x4x_CONTROLLER_BUFFER_SIZE - P3H2x4x_SMBUS_DESCRIPTOR_SIZE)
> +#define P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE	(P3H2x4x_TARGET_BUFFER_SIZE - 2)
> +
> +/* Hub SMBus transaction time */
> +#define P3H2x4x_SMBUS_400kHz_TRANSFER_TIMEOUT(x)		((20 * (x)) + 80)
> +
> +#define P3H2x4x_NO_PAGE_PER_TP					4
> +
> +#define P3H2x4x_MAX_PAYLOAD_LEN					2
> +#define P3H2x4x_NUM_SLOTS					6
> +
> +#define P3H2x4x_HUB_ID						0
> +
> +#define P3H2x4x_SET_BIT(n)				BIT(n)
> +
> +enum p3h2x4x_tp {
> +	TP_0,
> +	TP_1,
> +	TP_2,
> +	TP_3,
> +	TP_4,
> +	TP_5,
> +	TP_6,
> +	TP_7,
> +};
> +
> +enum p3h2x4x_rcv_buf {
> +	RCV_BUF_0,
> +	RCV_BUF_1,
> +	RCV_BUF_OF,
> +};
> +
> +struct p3h2x4x_regulators {
> +	struct regulator *rcp0;
> +	struct regulator *rcp1;
> +	struct regulator *rtp0145;
> +	struct regulator *rtp2367;
> +};
> +
> +struct p3h2x4x_setting {
> +	const char *const name;
> +	const u8 value;
> +};
> +
> +struct tp_setting {
> +	bool pullup_en;
> +	bool ibi_en;
> +	bool always_enable;
> +	int mode;
> +};
> +
> +struct dt_settings {
> +	bool cp0_ldo_en;
> +	bool cp1_ldo_en;
> +	bool tp0145_ldo_en;
> +	bool tp2367_ldo_en;
> +	int cp0_ldo_volt;
> +	int cp1_ldo_volt;
> +	int tp0145_ldo_volt;
> +	int tp2367_ldo_volt;
> +	int tp0145_pullup;
> +	int tp2367_pullup;
> +	int cp0_io_strength;
> +	int cp1_io_strength;
> +	int tp0145_io_strength;
> +	int tp2367_io_strength;
> +	struct tp_setting tp[P3H2x4x_TP_MAX_COUNT];
> +};
> +
> +struct smbus_device {
> +	struct i2c_client *client;
> +	const char *compatible;
> +	int addr;
> +	struct list_head list;
> +	struct device_node *tp_device_dt_node;
> +};
> +
> +struct tp_bus {
> +	bool is_registered;	    /* bus was registered in the framework. */
> +	bool is_slave_registered;
> +	u8 tp_mask;
> +	u8 tp_port;
> +	u8 local_dev_count;
> +	u8 local_dev_list[P3H2x4x_TP_LOCAL_DEV];
> +	struct i3c_master_controller i3c_port_controller;
> +	struct i2c_adapter *smbus_port_adapter;
> +	struct device_node *of_node;
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub;
> +	struct list_head tp_device_entry;
> +	struct mutex port_mutex;      /* per port mutex */
> +};
> +
> +struct p3h2x4x_i3c_hub_dev {
> +	struct i3c_master_controller *driving_master;
> +	struct i3c_device *i3cdev;
> +	struct regmap *regmap;
> +	struct mutex etx_mutex;      /* all port mutex */
> +	struct dt_settings settings;
> +	struct tp_bus tp_bus[P3H2x4x_TP_MAX_COUNT];
> +	struct p3h2x4x_regulators rp3h2x4x;
> +	/* Offset for reading HUB's register. */
> +	u8 tp_ibi_mask;
> +	u8 tp_i3c_bus_mask;
> +	u8 tp_always_enable_mask;
> +	bool is_p3h2x4x_in_i3c;
> +	struct device *dev;
> +};
> +
> +/**
> + * p3h2x4x_tp_smbus_algo - add i2c adapter for target port who
> + * configured as SMBus.

I remember need indentent to align -

> + * @priv: p3h2x4x device structure.
> + * @tp: target port.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_smbus_algo(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub, int tp);
> +
> +/**
> + * p3h2x4x_tp_i3c_algo - register i3c controller for target port who
> + * configured as I3C.
> + * @priv: p3h2x4x device structure.
> + * @tp: target port.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_i3c_algo(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub, int tp);
> +
> +/**
> + * p3h2x4x_ibi_handler - IBI handler.
> + * @i3cdev: i3c device.
> + * @payload: two byte IBI payload data.
> + */
> +void p3h2x4x_ibi_handler(struct i3c_device *i3cdev,
> +			 const struct i3c_ibi_payload *payload);
> +#endif /* P3H2840_I3C_HUB_H */
> +
> diff --git a/drivers/i3c/hub/p3h2840_i3c_hub_common.c b/drivers/i3c/hub/p3h2840_i3c_hub_common.c
> new file mode 100644
> index 000000000000..1ca887ad8e2b
> --- /dev/null
> +++ b/drivers/i3c/hub/p3h2840_i3c_hub_common.c
> @@ -0,0 +1,782 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + * This P3H2x4x driver file implements functions for Hub probe and DT parsing.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/p3h2840.h>
> +
> +#include "p3h2840_i3c_hub.h"
> +
> +/* LDO voltage DT settings */
> +#define P3H2x4x_DT_LDO_VOLT_1_0V                1000

use tab to align 1000 with below lines

> +#define P3H2x4x_DT_LDO_VOLT_1_1V		1100
> +#define P3H2x4x_DT_LDO_VOLT_1_2V		1200
> +#define P3H2x4x_DT_LDO_VOLT_1_8V		1800
> +
> +/* target port pull-up settings */
> +#define P3H2x4x_DT_TP_PULLUP_250R		250
> +#define P3H2x4x_DT_TP_PULLUP_500R		500
> +#define P3H2x4x_DT_TP_PULLUP_1000R		1000
> +#define P3H2x4x_DT_TP_PULLUP_2000R		2000
> +
> +/*  IO strenght settings */
> +#define P3H2x4x_DT_IO_STRENGTH_20_OHM		20
> +#define P3H2x4x_DT_IO_STRENGTH_30_OHM		30
> +#define P3H2x4x_DT_IO_STRENGTH_40_OHM		40
> +#define P3H2x4x_DT_IO_STRENGTH_50_OHM		50
> +
> +/* target port mode settings */
> +static const struct p3h2x4x_setting tp_mode_settings[] = {
> +	{ "i3c",		P3H2x4x_TP_MODE_I3C },
> +	{ "smbus",		P3H2x4x_TP_MODE_SMBUS },
> +	{ "gpio",		P3H2x4x_TP_MODE_GPIO },
> +	{ "i2c",		P3H2x4x_TP_MODE_I2C },
> +};
> +
> +static const struct i3c_ibi_setup p3h2x4x_ibireq = {
> +	.handler = p3h2x4x_ibi_handler,
> +	.max_payload_len = P3H2x4x_MAX_PAYLOAD_LEN,
> +	.num_slots = P3H2x4x_NUM_SLOTS,
> +};
> +
> +static void p3h2x4x_of_get_dt_setting(struct device *dev,
> +				      const struct device_node *node,
> +				      const char *setting_name,
> +				      const struct p3h2x4x_setting settings[],
> +				      const int settings_count,
> +				      int *setting_value)
> +{
> +	const char *sval;
> +	int ret;
> +	int i;
> +
> +	ret = of_property_read_string(node, setting_name, &sval);
> +	if (ret) {
> +		if (ret != -EINVAL)
> +			dev_warn(dev, "No setting or invalid setting for %s, err=%i\n",
> +				 setting_name, ret);
> +		return;
> +	}
> +
> +	for (i = 0; i < settings_count; ++i) {
> +		const struct p3h2x4x_setting *const setting = &settings[i];
> +
> +		if (!strcmp(setting->name, sval)) {
> +			*setting_value = setting->value;
> +			return;
> +		}
> +	}
> +	dev_warn(dev, "Unknown setting for %s\n", setting_name);
> +}
> +
> +static u8 p3h2x4x_pullup_dt_to_reg(int dt_value)
> +{
> +	switch (dt_value) {
> +	case P3H2x4x_DT_TP_PULLUP_2000R:
> +		return P3H2x4x_TP_PULLUP_2000R;
> +	case P3H2x4x_DT_TP_PULLUP_1000R:
> +		return P3H2x4x_TP_PULLUP_1000R;
> +	case P3H2x4x_DT_TP_PULLUP_250R:
> +		return P3H2x4x_TP_PULLUP_250R;
> +	default:
> +		return P3H2x4x_TP_PULLUP_500R;
> +	}
> +}
> +
> +static u8 p3h2x4x_io_strength_dt_to_reg(int dt_value)
> +{
> +	switch (dt_value) {
> +	case P3H2x4x_DT_IO_STRENGTH_50_OHM:
> +		return P3H2x4x_IO_STRENGTH_50_OHM;
> +	case P3H2x4x_DT_IO_STRENGTH_40_OHM:
> +		return P3H2x4x_IO_STRENGTH_40_OHM;
> +	case P3H2x4x_DT_IO_STRENGTH_30_OHM:
> +		return P3H2x4x_IO_STRENGTH_30_OHM;
> +	default:
> +		return P3H2x4x_IO_STRENGTH_20_OHM;
> +	}
> +}
> +
> +static int p3h2x4x_configure_ldo(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	int ret;
> +
> +	p3h2x4x_i3c_hub->rp3h2x4x.rcp0 = devm_regulator_get_optional(dev, "cp0");
> +	if (IS_ERR(p3h2x4x_i3c_hub->rp3h2x4x.rcp0)) {
> +		p3h2x4x_i3c_hub->rp3h2x4x.rcp0 = NULL;
> +		dev_dbg(dev, "cp0-supply not found\n");
> +	}
> +
> +	p3h2x4x_i3c_hub->rp3h2x4x.rcp1 = devm_regulator_get_optional(dev, "cp1");
> +	if (IS_ERR(p3h2x4x_i3c_hub->rp3h2x4x.rcp1)) {
> +		p3h2x4x_i3c_hub->rp3h2x4x.rcp1 = NULL;
> +		dev_dbg(dev, "cp1-supply not found\n");
> +	}
> +
> +	p3h2x4x_i3c_hub->rp3h2x4x.rtp0145 = devm_regulator_get_optional(dev, "tp0145");
> +	if (IS_ERR(p3h2x4x_i3c_hub->rp3h2x4x.rtp0145)) {
> +		p3h2x4x_i3c_hub->rp3h2x4x.rtp0145 = NULL;
> +		dev_dbg(dev, "tp0145-supply not found\n");
> +	}
> +
> +	p3h2x4x_i3c_hub->rp3h2x4x.rtp2367 = devm_regulator_get_optional(dev, "tp2367");
> +	if (IS_ERR(p3h2x4x_i3c_hub->rp3h2x4x.rtp2367)) {
> +		p3h2x4x_i3c_hub->rp3h2x4x.rtp2367 = NULL;
> +		dev_dbg(dev, "tp2367-supply not found\n");
> +	}
> +
> +	/* Set the regulators volatage */
> +	if (p3h2x4x_i3c_hub->settings.cp0_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET &&
> +	    p3h2x4x_i3c_hub->rp3h2x4x.rcp0) {
> +		ret = regulator_set_voltage(p3h2x4x_i3c_hub->rp3h2x4x.rcp0,
> +					    p3h2x4x_i3c_hub->settings.cp0_ldo_volt,
> +					    p3h2x4x_i3c_hub->settings.cp0_ldo_volt);
> +		if (ret)
> +			dev_warn(dev, "Failed to set CP0 voltage (ignoring)\n");
> +	}
> +
> +	/* Set the regulators volatage */
> +	if (p3h2x4x_i3c_hub->settings.cp1_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET &&
> +	    p3h2x4x_i3c_hub->rp3h2x4x.rcp1) {
> +		ret = regulator_set_voltage(p3h2x4x_i3c_hub->rp3h2x4x.rcp1,
> +					    p3h2x4x_i3c_hub->settings.cp1_ldo_volt,
> +					    p3h2x4x_i3c_hub->settings.cp1_ldo_volt);
> +		if (ret)
> +			dev_warn(dev, "Failed to set CP1 voltage (ignoring)\n");
> +	}
> +
> +	/* Set the regulators volatage */
> +	if (p3h2x4x_i3c_hub->settings.tp0145_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET &&
> +	    p3h2x4x_i3c_hub->rp3h2x4x.rtp0145) {
> +		ret = regulator_set_voltage(p3h2x4x_i3c_hub->rp3h2x4x.rtp0145,
> +					    p3h2x4x_i3c_hub->settings.tp0145_ldo_volt,
> +					    p3h2x4x_i3c_hub->settings.tp0145_ldo_volt);
> +		if (ret)
> +			dev_warn(dev, "Failed to set TP0145 voltage (ignoring)\n");
> +	}
> +
> +	/* Set the regulators volatage */
> +	if (p3h2x4x_i3c_hub->settings.tp2367_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET &&
> +	    p3h2x4x_i3c_hub->rp3h2x4x.rtp2367) {
> +		ret = regulator_set_voltage(p3h2x4x_i3c_hub->rp3h2x4x.rtp2367,
> +					    p3h2x4x_i3c_hub->settings.tp2367_ldo_volt,
> +					    p3h2x4x_i3c_hub->settings.tp2367_ldo_volt);
> +		if (ret)
> +			dev_warn(dev, "Failed to set TP2367 voltage (ignoring)\n");
> +	}
> +
> +	/* Enable the regulators */
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rcp0) {
> +		ret = regulator_enable(p3h2x4x_i3c_hub->rp3h2x4x.rcp0);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable cp0 ldo\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rcp1) {
> +		ret = regulator_enable(p3h2x4x_i3c_hub->rp3h2x4x.rcp1);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable cp1 ldo\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rtp0145) {
> +		ret = regulator_enable(p3h2x4x_i3c_hub->rp3h2x4x.rtp0145);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable tp0145 ldo\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rtp2367) {
> +		ret = regulator_enable(p3h2x4x_i3c_hub->rp3h2x4x.rtp2367);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable tp2367 ldo\n");

Do you need disable previous enabled regulator?

> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int p3h2x4x_configure_pullup(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	u8 mask_all = 0, val_all = 0;
> +
> +	if (p3h2x4x_i3c_hub->settings.tp0145_pullup != P3H2x4x_TP_PULLUP_NOT_SET) {
> +		val_all |= P3H2x4x_TP0145_PULLUP_CONF(p3h2x4x_pullup_dt_to_reg
> +						    (p3h2x4x_i3c_hub->settings.tp0145_pullup));
> +		mask_all |= P3H2x4x_TP0145_PULLUP_CONF_MASK;
> +	}
> +
> +	if (p3h2x4x_i3c_hub->settings.tp2367_pullup != P3H2x4x_TP_PULLUP_NOT_SET) {
> +		val_all |= P3H2x4x_TP2367_PULLUP_CONF(p3h2x4x_pullup_dt_to_reg
> +						    (p3h2x4x_i3c_hub->settings.tp2367_pullup));
> +		mask_all |= P3H2x4x_TP2367_PULLUP_CONF_MASK;
> +	}
> +
> +	return regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_LDO_AND_PULLUP_CONF,
> +				  mask_all, val_all);
> +}
> +
> +static int p3h2x4x_configure_io_strength(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	u8 mask_all = 0, val_all = 0;
> +
> +	if (p3h2x4x_i3c_hub->settings.cp0_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val_all |= P3H2x4x_CP0_IO_STRENGTH(p3h2x4x_io_strength_dt_to_reg
> +					      (p3h2x4x_i3c_hub->settings.cp0_io_strength));
> +		mask_all |= P3H2x4x_CP0_IO_STRENGTH_MASK;
> +	}
> +
> +	if (p3h2x4x_i3c_hub->settings.cp1_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val_all |= P3H2x4x_CP1_IO_STRENGTH(p3h2x4x_io_strength_dt_to_reg
> +					      (p3h2x4x_i3c_hub->settings.cp1_io_strength));
> +		mask_all |= P3H2x4x_CP1_IO_STRENGTH_MASK;
> +	}
> +
> +	if (p3h2x4x_i3c_hub->settings.tp0145_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val_all |= P3H2x4x_TP0145_IO_STRENGTH(p3h2x4x_io_strength_dt_to_reg
> +						 (p3h2x4x_i3c_hub->settings.tp0145_io_strength));
> +		mask_all |= P3H2x4x_TP0145_IO_STRENGTH_MASK;
> +	}
> +
> +	if (p3h2x4x_i3c_hub->settings.tp2367_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val_all |= P3H2x4x_TP2367_IO_STRENGTH(p3h2x4x_io_strength_dt_to_reg
> +						 (p3h2x4x_i3c_hub->settings.tp2367_io_strength));
> +		mask_all |= P3H2x4x_TP2367_IO_STRENGTH_MASK;
> +	}
> +
> +	return regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_IO_STRENGTH, mask_all, val_all);
> +}
> +
> +static int p3h2x4x_configure_tp(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	u8 pullup_val = 0, ibi_val = 0;
> +	u8 smbus_val = 0, i2c_val = 0;
> +	u8 gpio_val = 0, i3c_val = 0;
> +	u8 i, mode_mask = 0;
> +	int ret;
> +
> +	/* TBD: Read type of HUB from register P3H2x4x_DEV_INFO_0 to learn target ports count. */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (p3h2x4x_i3c_hub->settings.tp[i].mode != P3H2x4x_TP_MODE_NOT_SET) {
> +			if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C)
> +				i3c_val |= P3H2x4x_SET_BIT(i);
> +			else if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS)
> +				smbus_val |= P3H2x4x_SET_BIT(i);
> +			else if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_GPIO)
> +				gpio_val |= P3H2x4x_SET_BIT(i);
> +			else if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_I2C)
> +				i2c_val |= P3H2x4x_SET_BIT(i);
> +
> +			mode_mask |= P3H2x4x_SET_BIT(i);
> +		}
> +		if (p3h2x4x_i3c_hub->settings.tp[i].pullup_en)
> +			pullup_val |= P3H2x4x_SET_BIT(i);
> +
> +		if (p3h2x4x_i3c_hub->settings.tp[i].ibi_en)
> +			ibi_val |= P3H2x4x_SET_BIT(i);
> +	}
> +
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_IO_MODE_CONF,
> +				 mode_mask, (smbus_val | i2c_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_PULLUP_EN,
> +				 pullup_val, pullup_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG,
> +				 ibi_val, ibi_val);
> +	if (ret)
> +		return ret;
> +	p3h2x4x_i3c_hub->tp_ibi_mask = ibi_val;
> +
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_EN,
> +				 mode_mask, smbus_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_GPIO_MODE_EN,
> +				 mode_mask, gpio_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Request for HUB Network connection in case any TP is configured in I3C mode */
> +	if ((i3c_val) || (i2c_val)) {
> +		ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_CP_MUX_SET,
> +				   P3H2x4x_CONTROLLER_PORT_MUX_REQ);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable TP here in case TP was configured */
> +	ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_ENABLE,
> +				 mode_mask, (i3c_val | smbus_val | gpio_val | i2c_val));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int p3h2x4x_configure_smbus_local_device(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	u8 target_buffer_page, hub_tp;
> +	int ret = 0;
> +
> +	for (hub_tp = 0; hub_tp < P3H2x4x_TP_MAX_COUNT; hub_tp++) {
> +		if (p3h2x4x_i3c_hub->settings.tp[hub_tp].mode == P3H2x4x_TP_MODE_SMBUS &&
> +		    p3h2x4x_i3c_hub->tp_bus[hub_tp].local_dev_count) {
> +			target_buffer_page = P3H2x4x_TARGET_AGENT_LOCAL_DEV + 4 * hub_tp;
> +			ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR,
> +					   target_buffer_page);
> +			if (ret) {
> +				dev_err(dev, "Failed to configure local device settings\n");
> +				break;
> +			}
> +
> +			ret = regmap_bulk_write(p3h2x4x_i3c_hub->regmap,
> +						P3H2x4x_CONTROLLER_AGENT_BUFF,
> +						p3h2x4x_i3c_hub->tp_bus[hub_tp].local_dev_list,
> +						p3h2x4x_i3c_hub->tp_bus[hub_tp].local_dev_count);
> +			if (ret) {
> +				dev_err(dev, "Failed to add local devices\n");
> +				break;
> +			}
> +		}
> +	}
> +	regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	return ret;
> +}
> +
> +static int p3h2x4x_configure_hw(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = p3h2x4x_configure_ldo(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_io_strength(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_pullup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_smbus_local_device(dev);
> +	if (ret)
> +		return ret;
> +
> +	return p3h2x4x_configure_tp(dev);
> +}
> +
> +static void p3h2x4x_of_get_tp_dt_conf(struct device *dev,
> +				      const struct device_node *node)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	struct device_node *dev_node;
> +	u64 tp_port;
> +
> +	for_each_available_child_of_node(node, dev_node) {
> +		if (of_property_read_reg(dev_node, 0, &tp_port, NULL))
> +			continue;
> +
> +		if (tp_port < P3H2x4x_TP_MAX_COUNT) {
> +			p3h2x4x_i3c_hub->tp_bus[tp_port].of_node = dev_node;
> +			p3h2x4x_i3c_hub->tp_bus[tp_port].tp_mask = BIT(tp_port);
> +			p3h2x4x_i3c_hub->tp_bus[tp_port].p3h2x4x_i3c_hub = p3h2x4x_i3c_hub;
> +			p3h2x4x_i3c_hub->tp_bus[tp_port].tp_port = tp_port;
> +		}
> +	}
> +}
> +
> +/* return true when backend node exist */
> +static bool p3h2x4x_is_backend_node_exist(int port,
> +					  struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub,
> +					  u32 addr)
> +{
> +	struct smbus_device *backend = NULL;
> +
> +	list_for_each_entry(backend,
> +			    &p3h2x4x_i3c_hub->tp_bus[port].tp_device_entry, list) {
> +		if (backend->addr == addr)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int p3h2x4x_read_backend_from_dts(struct device_node *i3c_node_target,
> +					 struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub)
> +{
> +	struct device_node *tp_node;
> +	const char *compatible;
> +	u64 tp_port, addr_dts;
> +	int ret;
> +
> +	struct smbus_device *backend;
> +
> +	if (of_property_read_reg(i3c_node_target, 0, &tp_port, NULL))
> +		return -EINVAL;
> +
> +	if (tp_port >= P3H2x4x_TP_MAX_COUNT || tp_port < 0)
> +		return -ERANGE;
> +
> +	INIT_LIST_HEAD(&p3h2x4x_i3c_hub->tp_bus[tp_port].tp_device_entry);
> +
> +	if (p3h2x4x_i3c_hub->settings.tp[tp_port].mode == P3H2x4x_TP_MODE_I3C)
> +		return 0;
> +
> +	for_each_available_child_of_node(i3c_node_target, tp_node) {
> +		ret = of_property_read_reg(tp_node, 0, &addr_dts, NULL);
> +		if (ret)
> +			return ret;
> +
> +		if (p3h2x4x_is_backend_node_exist(tp_port, p3h2x4x_i3c_hub, addr_dts))
> +			continue;
> +
> +		ret = of_property_read_string(tp_node, "compatible", &compatible);
> +		if (ret)
> +			return ret;
> +
> +		backend = kzalloc(sizeof(*backend), GFP_KERNEL);
> +		if (!backend)
> +			return -ENOMEM;
> +
> +		backend->addr = addr_dts;
> +		backend->compatible = compatible;
> +		backend->tp_device_dt_node = tp_node;
> +		backend->client = NULL;
> +
> +		list_add(&backend->list,
> +			 &p3h2x4x_i3c_hub->tp_bus[tp_port].tp_device_entry);
> +	}
> +
> +	return 0;
> +}
> +
> +static void p3h2x4x_parse_dt_tp(struct device *dev,
> +				const struct device_node *i3c_node_hub,
> +				struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub)
> +{
> +	struct device_node *i3c_node_target;
> +	int ret;
> +
> +	for_each_available_child_of_node(i3c_node_hub, i3c_node_target) {
> +		ret = p3h2x4x_read_backend_from_dts(i3c_node_target, p3h2x4x_i3c_hub);
> +		if (ret)
> +			dev_warn(dev, "Skiping DTS node %s", i3c_node_target->name);
> +	}
> +}
> +
> +static int p3h2x4x_get_tp_local_device_dt_setting(struct device *dev,
> +						  const struct device_node *node, u32 id)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = of_property_read_variable_u8_array(node, "local-dev",
> +						 p3h2x4x_i3c_hub->tp_bus[id].local_dev_list,
> +						 sizeof(u8), P3H2x4x_TP_LOCAL_DEV);
> +	if (ret > 0 && ret <= P3H2x4x_TP_LOCAL_DEV)
> +		p3h2x4x_i3c_hub->tp_bus[id].local_dev_count = ret;
> +	else if (ret == -EOVERFLOW)
> +		dev_warn(dev,
> +			 "local Devices list is out of range or invalid\n");
> +
> +	return ret;
> +}
> +
> +static void p3h2x4x_get_tp_of_get_setting(struct device *dev,
> +					  const struct device_node *node,
> +					  struct tp_setting tp_setting[])
> +{
> +	struct device_node *tp_node;
> +	u64 id;
> +
> +	for_each_available_child_of_node(node, tp_node) {

for_each_available_child_of_node_scoped() otherwise need call of_put_node()

> +		if (of_property_read_reg(tp_node, 0, &id, NULL))
> +			continue;
> +
> +		if (id >= P3H2x4x_TP_MAX_COUNT) {
> +			dev_warn(dev, "Invalid target port index found in DT: %lli\n", id);
> +			continue;
> +		}
> +
> +		p3h2x4x_of_get_dt_setting(dev, tp_node, "mode", tp_mode_settings,
> +					  ARRAY_SIZE(tp_mode_settings),
> +					  &tp_setting[id].mode);
> +
> +		tp_setting[id].pullup_en =
> +					of_property_read_bool(tp_node, "pullup-enable");
> +		tp_setting[id].ibi_en =
> +					of_property_read_bool(tp_node, "ibi-enable");
> +		tp_setting[id].always_enable =
> +					of_property_read_bool(tp_node, "hub_bridge_en");
> +
> +		p3h2x4x_get_tp_local_device_dt_setting(dev, tp_node, id);
> +	}
> +}
> +
> +static void p3h2x4x_of_get_p3h2x4x_conf(struct device *dev,
> +					const struct device_node *node)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +
> +	p3h2x4x_i3c_hub->settings.cp0_ldo_en =
> +				of_property_read_bool(node, "cp0-ldo-enable");

where use cp0_ldo_en? after change to regulator driver, cp0_ldo_en is not
needned.

> +	p3h2x4x_i3c_hub->settings.cp1_ldo_en =
> +				of_property_read_bool(node, "cp1-ldo-enable");
> +	p3h2x4x_i3c_hub->settings.tp0145_ldo_en =
> +				of_property_read_bool(node, "tp0145-ldo-enable");
> +	p3h2x4x_i3c_hub->settings.tp2367_ldo_en =
> +				of_property_read_bool(node, "tp2367-ldo-enable");
> +
> +	of_property_read_u32(node, "cp0-ldo-microvolt",
> +			     &p3h2x4x_i3c_hub->settings.cp0_ldo_volt);
> +	of_property_read_u32(node, "cp1-ldo-microvolt",
> +			     &p3h2x4x_i3c_hub->settings.cp1_ldo_volt);
> +	of_property_read_u32(node, "tp0145-ldo-microvolt",
> +			     &p3h2x4x_i3c_hub->settings.tp0145_ldo_volt);
> +	of_property_read_u32(node, "tp2367-ldo-microvolt",
> +			     &p3h2x4x_i3c_hub->settings.tp2367_ldo_volt);
> +	of_property_read_u32(node, "tp0145-pullup-ohms",
> +			     &p3h2x4x_i3c_hub->settings.tp0145_pullup);
> +	of_property_read_u32(node, "tp2367-pullup-ohms",
> +			     &p3h2x4x_i3c_hub->settings.tp2367_pullup);
> +	of_property_read_u32(node, "cp0-io-strength-ohms",
> +			     &p3h2x4x_i3c_hub->settings.cp0_io_strength);
> +	of_property_read_u32(node, "cp1-io-strength-ohms",
> +			     &p3h2x4x_i3c_hub->settings.cp1_io_strength);
> +	of_property_read_u32(node, "tp0145-io-strength-ohms",
> +			     &p3h2x4x_i3c_hub->settings.tp0145_io_strength);
> +	of_property_read_u32(node, "tp2367-io-strength-ohms",
> +			     &p3h2x4x_i3c_hub->settings.tp2367_io_strength);
> +
> +	p3h2x4x_get_tp_of_get_setting(dev, node, p3h2x4x_i3c_hub->settings.tp);
> +}
> +
> +static void p3h2x4x_of_default_configuration(struct device *dev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(dev);
> +	int tp_count;
> +
> +	p3h2x4x_i3c_hub->settings.cp0_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.cp1_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp0145_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp2367_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp0145_pullup = P3H2x4x_TP_PULLUP_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp2367_pullup = P3H2x4x_TP_PULLUP_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.cp0_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.cp1_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp0145_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	p3h2x4x_i3c_hub->settings.tp2367_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +
> +	for (tp_count = 0; tp_count < P3H2x4x_TP_MAX_COUNT; ++tp_count)
> +		p3h2x4x_i3c_hub->settings.tp[tp_count].mode =  P3H2x4x_TP_MODE_NOT_SET;
> +}
> +
> +int p3h2x4x_i3c_hub_probe(struct platform_device *pdev)
> +{
> +	struct p3h2x4x_dev *p3h2x4x = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *node __free(device_node) = NULL;

you just cp pointer from dev->of_node, needn't __free(device_node)

> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub;
> +	struct device *dev = &pdev->dev;
> +	int ret, i;
> +
> +	p3h2x4x_i3c_hub = devm_kzalloc(dev, sizeof(*p3h2x4x_i3c_hub), GFP_KERNEL);
> +	if (!p3h2x4x_i3c_hub)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, p3h2x4x_i3c_hub);
> +
> +	p3h2x4x_i3c_hub->regmap = p3h2x4x->regmap;
> +
> +	if (p3h2x4x->is_p3h2x4x_in_i3c) {
> +		p3h2x4x_i3c_hub->i3cdev = p3h2x4x->i3cdev;
> +		p3h2x4x_i3c_hub->driving_master = i3c_dev_get_master(p3h2x4x->i3cdev->desc);
> +	}
> +
> +	p3h2x4x_i3c_hub->is_p3h2x4x_in_i3c = p3h2x4x->is_p3h2x4x_in_i3c;
> +	p3h2x4x_i3c_hub->dev = dev;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	p3h2x4x_of_default_configuration(dev);
> +	mutex_init(&p3h2x4x_i3c_hub->etx_mutex);
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_init(&p3h2x4x_i3c_hub->tp_bus[i].port_mutex);
> +
> +	/* get hub node from DT */
> +	node =  dev->of_node;
> +	if (!node) {
> +		dev_dbg(dev, "No DT entry - running with hardware defaults.\n");

how it is possible?

> +	} else {
> +		p3h2x4x_of_get_p3h2x4x_conf(dev, node);
> +		p3h2x4x_of_get_tp_dt_conf(dev, node);
> +		/* Parse DTS to find backend device on the SMBus target mode */
> +		p3h2x4x_parse_dt_tp(dev, node, p3h2x4x_i3c_hub);
> +	}
> +
> +	/* Unlock access to protected registers */
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +			   P3H2x4x_REGISTERS_UNLOCK_CODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to unlock HUB's protected registers\n");
> +
> +	ret = p3h2x4x_configure_hw(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure the HUB\n");
> +
> +	if (p3h2x4x->is_p3h2x4x_in_i3c) {
> +		/* Register logic for native vertual I3C ports */
> +		for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +			if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C &&
> +			    !p3h2x4x_i3c_hub->settings.tp[i].always_enable) {
> +				ret = p3h2x4x_tp_i3c_algo(p3h2x4x_i3c_hub, i);
> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +							    "failed to register i3c bus tp %d\n",
> +							    i);
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (p3h2x4x_i3c_hub->settings.tp[i].always_enable)
> +			p3h2x4x_i3c_hub->tp_always_enable_mask =
> +					(p3h2x4x_i3c_hub->tp_always_enable_mask |  BIT(i));
> +	}
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_NET_CON_CONF,
> +			   p3h2x4x_i3c_hub->tp_always_enable_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to open Target Port(s)\n");
> +
> +	if (p3h2x4x->is_p3h2x4x_in_i3c) {
> +		ret = i3c_master_do_daa(p3h2x4x_i3c_hub->driving_master);
> +		if (ret)
> +			dev_warn(dev, "Failed to run DAA\n");
> +
> +		/*
> +		 * holding SDA low when both SMBus Target Agent received data buffers are full.
> +		 * This feature can be used as a flow-control mechanism for MCTP applications to
> +		 * avoid MCTP transmitters on Target Ports time out when the SMBus agent buffers
> +		 * are not serviced in time by upstream controller and only receives write message
> +		 * from its downstream ports.
> +		 */
> +		ret = regmap_update_bits(p3h2x4x_i3c_hub->regmap,
> +					 P3H2x4x_ONCHIP_TD_AND_SMBUS_AGNT_CONF,
> +					 P3H2x4x_TARGET_AGENT_DFT_IBI_CONF_MASK,
> +					 P3H2x4x_TARGET_AGENT_DFT_IBI_CONF);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to data buffer full config\n");
> +
> +		ret = i3c_device_request_ibi(p3h2x4x->i3cdev, &p3h2x4x_ibireq);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request IBI\n");
> +
> +		ret = i3c_device_enable_ibi(p3h2x4x->i3cdev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to Enable IBI\n");
> +	}
> +
> +	/* Register logic for native SMBus ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS) {
> +			ret = p3h2x4x_tp_smbus_algo(p3h2x4x_i3c_hub, i);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						    "failed to add i2c adapter for tp %d\n", i);
> +		}
> +	}
> +
> +	/* Lock access to protected registers */
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +			   P3H2x4x_REGISTERS_LOCK_CODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to lock HUB's protected registers\n");
> +
> +	return 0;
> +}
> +
> +int p3h2x4x_i3c_hub_remove(struct platform_device *pdev)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = platform_get_drvdata(pdev);
> +	struct p3h2x4x_dev *p3h2x4x = dev_get_drvdata(pdev->dev.parent);
> +	struct i3c_master_controller *tp_controller;
> +	struct smbus_device *backend = NULL;
> +	struct i2c_adapter *tp_adap;
> +	u8 i;
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rcp0)
> +		regulator_disable(p3h2x4x_i3c_hub->rp3h2x4x.rcp0);
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rcp1)
> +		regulator_disable(p3h2x4x_i3c_hub->rp3h2x4x.rcp1);
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rtp0145)
> +		regulator_disable(p3h2x4x_i3c_hub->rp3h2x4x.rtp0145);
> +
> +	if (p3h2x4x_i3c_hub->rp3h2x4x.rtp2367)
> +		regulator_disable(p3h2x4x_i3c_hub->rp3h2x4x.rtp2367);
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		tp_adap = p3h2x4x_i3c_hub->tp_bus[i].smbus_port_adapter;
> +		tp_controller = &p3h2x4x_i3c_hub->tp_bus[i].i3c_port_controller;
> +
> +		if (p3h2x4x_i3c_hub->tp_bus[i].is_registered) {
> +			if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS) {
> +				list_for_each_entry(backend,
> +						    &p3h2x4x_i3c_hub->tp_bus[i].tp_device_entry,
> +						    list) {
> +					i2c_unregister_device(backend->client);
> +					kfree(backend);
> +				}
> +				i2c_del_adapter(tp_adap);
> +			} else if (p3h2x4x_i3c_hub->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C) {
> +				i3c_master_unregister(tp_controller);
> +			}
> +		}
> +	}
> +	if (p3h2x4x->is_p3h2x4x_in_i3c) {
> +		i3c_device_disable_ibi(p3h2x4x->i3cdev);
> +		i3c_device_free_ibi(p3h2x4x->i3cdev);
> +	}
> +
> +	mutex_destroy(&p3h2x4x_i3c_hub->etx_mutex);
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_destroy(&p3h2x4x_i3c_hub->tp_bus[i].port_mutex);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver p3h2x4x_i3c_hub_driver = {
> +	.driver = {
> +		.name = "p3h2x4x-i3c-hub",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = p3h2x4x_i3c_hub_probe,
> +	.remove = p3h2x4x_i3c_hub_remove,
> +};
> +module_platform_driver(p3h2x4x_i3c_hub_driver);
> +
> +MODULE_AUTHOR("Aman Kumar Pandey <aman.kumarpandey@nxp.com>");
> +MODULE_AUTHOR("vikash Bansal <vikash.bansal@nxp.com>");
> +MODULE_DESCRIPTION("P3H2x4x I3C HUB driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/i3c/hub/p3h2840_i3c_hub_i3c.c b/drivers/i3c/hub/p3h2840_i3c_hub_i3c.c
> new file mode 100644
> index 000000000000..8903bc48a88c
> --- /dev/null
> +++ b/drivers/i3c/hub/p3h2840_i3c_hub_i3c.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + * This P3H2x4x driver file contain functions for I3C virtual Bus creation, connect/disconnect
> + * hub network and read/write.
> + */
> +#include <linux/mfd/p3h2840.h>
> +#include <linux/regmap.h>
> +
> +#include "p3h2840_i3c_hub.h"
> +
> +static void p3h2x4x_en_p3h2x4x_ntwk_tp(struct tp_bus *bus)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = bus->p3h2x4x_i3c_hub;
> +
> +	if (p3h2x4x_i3c_hub->settings.tp[bus->tp_port].always_enable)
> +		return;
> +
> +	regmap_set_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_NET_CON_CONF, bus->tp_mask);
> +}
> +
> +static void p3h2x4x_dis_p3h2x4x_ntwk_tp(struct tp_bus *bus)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = bus->p3h2x4x_i3c_hub;
> +
> +	if (p3h2x4x_i3c_hub->settings.tp[bus->tp_port].always_enable)
> +		return;
> +
> +	regmap_clear_bits(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_NET_CON_CONF, bus->tp_mask);
> +}
> +
> +static struct tp_bus *p3h2x4x_bus_from_i3c_desc(struct i3c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
> +
> +	return container_of(controller, struct tp_bus, i3c_port_controller);
> +}
> +
> +static struct tp_bus *p3h2x4x_bus_from_i2c_desc(struct i2c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i2c_dev_get_master(desc);
> +
> +	return container_of(controller, struct tp_bus, i3c_port_controller);
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller(struct i3c_master_controller *controller)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->p3h2x4x_i3c_hub->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller_from_i3c_desc(struct i3c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->p3h2x4x_i3c_hub->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller_from_i2c_desc(struct i2c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = desc->common.master;
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->p3h2x4x_i3c_hub->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*update_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
> +				struct i3c_master_controller *parent)
> +{
> +	struct i3c_master_controller *orig_parent = desc->master;
> +
> +	desc->master = parent;
> +
> +	return orig_parent;
> +}
> +
> +static void restore_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
> +					struct i3c_master_controller *parent)
> +{
> +	desc->master = parent;
> +}
> +
> +static int p3h2x4x_i3c_bus_init(struct i3c_master_controller *controller)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	controller->this = bus->p3h2x4x_i3c_hub->i3cdev->desc;
> +	return 0;
> +}
> +
> +static void p3h2x4x_i3c_bus_cleanup(struct i3c_master_controller *controller)
> +{
> +	controller->this = NULL;
> +}
> +
> +static int p3h2x4x_attach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->attach_i3c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static int p3h2x4x_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->reattach_i3c_dev(dev, old_dyn_addr);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static void p3h2x4x_detach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->detach_i3c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static int p3h2x4x_do_daa(struct i3c_master_controller *controller)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	down_write(&parent->bus.lock);
> +	ret = parent->ops->do_daa(parent);
> +	up_write(&parent->bus.lock);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return ret;
> +}
> +
> +static bool p3h2x4x_supports_ccc_cmd(struct i3c_master_controller *controller,
> +				     const struct i3c_ccc_cmd *cmd)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +
> +	return parent->ops->supports_ccc_cmd(parent, cmd);
> +}
> +
> +static int p3h2x4x_send_ccc_cmd(struct i3c_master_controller *controller,
> +				struct i3c_ccc_cmd *cmd)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +	int ret;
> +
> +	if (cmd->id == I3C_CCC_RSTDAA(true))
> +		return 0;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	ret = parent->ops->send_ccc_cmd(parent, cmd);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return ret;
> +}
> +
> +static int p3h2x4x_priv_xfers(struct i3c_dev_desc *dev,
> +			      struct i3c_priv_xfer *xfers, int nxfers)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int res;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	res = parent->ops->priv_xfers(dev, xfers, nxfers);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return res;
> +}
> +
> +static int p3h2x4x_attach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->attach_i2c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static void p3h2x4x_detach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->detach_i2c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static int p3h2x4x_i2c_xfers(struct i2c_dev_desc *dev,
> +			     const struct i2c_msg *xfers, int nxfers)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->i2c_xfers(dev, xfers, nxfers);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static int p3h2x4x_request_ibi(struct i3c_dev_desc *dev,
> +			       const struct i3c_ibi_setup *req)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->request_ibi(dev, req);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static void p3h2x4x_free_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->free_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +}
> +
> +static int p3h2x4x_enable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->enable_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static int p3h2x4x_disable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->disable_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static void p3h2x4x_recycle_ibi_slot(struct i3c_dev_desc *dev,
> +				     struct i3c_ibi_slot *slot)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->recycle_ibi_slot(dev, slot);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static const struct i3c_master_controller_ops p3h2x4x_i3c_ops = {
> +	.bus_init = p3h2x4x_i3c_bus_init,
> +	.bus_cleanup = p3h2x4x_i3c_bus_cleanup,
> +	.attach_i3c_dev = p3h2x4x_attach_i3c_dev,
> +	.reattach_i3c_dev = p3h2x4x_reattach_i3c_dev,
> +	.detach_i3c_dev = p3h2x4x_detach_i3c_dev,
> +	.do_daa = p3h2x4x_do_daa,
> +	.supports_ccc_cmd = p3h2x4x_supports_ccc_cmd,
> +	.send_ccc_cmd = p3h2x4x_send_ccc_cmd,
> +	.priv_xfers = p3h2x4x_priv_xfers,
> +	.attach_i2c_dev = p3h2x4x_attach_i2c_dev,
> +	.detach_i2c_dev = p3h2x4x_detach_i2c_dev,
> +	.i2c_xfers = p3h2x4x_i2c_xfers,
> +	.request_ibi = p3h2x4x_request_ibi,
> +	.free_ibi = p3h2x4x_free_ibi,
> +	.enable_ibi = p3h2x4x_enable_ibi,
> +	.disable_ibi = p3h2x4x_disable_ibi,
> +	.recycle_ibi_slot = p3h2x4x_recycle_ibi_slot,
> +};
> +
> +/**
> + * p3h2x4x_tp_i3c_algo - register i3c master for target port who
> + * configured as i3c.
> + * @p3h2x4x_i3c_hub: p3h2x4x device structure.
> + * @tp: target port.
> + *
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_i3c_algo(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub, int tp)
> +{
> +	int ret;
> +
> +	p3h2x4x_i3c_hub->dev->of_node = p3h2x4x_i3c_hub->tp_bus[tp].of_node;
> +	ret = i3c_master_register(&p3h2x4x_i3c_hub->tp_bus[tp].i3c_port_controller,
> +				  p3h2x4x_i3c_hub->dev, &p3h2x4x_i3c_ops, false);
> +	if (ret) {
> +		dev_warn(p3h2x4x_i3c_hub->dev,
> +			 "Failed to register i3c controller for port:%i\n", tp);
> +		return ret;
> +	}
> +	p3h2x4x_i3c_hub->tp_bus[tp].is_registered = true;
> +
> +	return 0;
> +}
> diff --git a/drivers/i3c/hub/p3h2840_i3c_hub_smbus.c b/drivers/i3c/hub/p3h2840_i3c_hub_smbus.c
> new file mode 100644
> index 000000000000..3416cbfd5675
> --- /dev/null
> +++ b/drivers/i3c/hub/p3h2840_i3c_hub_smbus.c
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + * This P3H2x4x driver file contain functions for SMBus/I2C virtual Bus creation and read/write.
> + */
> +#include <linux/mfd/p3h2840.h>
> +#include <linux/regmap.h>
> +
> +#include "p3h2840_i3c_hub.h"
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +static void p3h2x4x_read_smbus_agent_rx_buf(struct i3c_device *i3cdev, enum p3h2x4x_rcv_buf rfbuf,
> +					    enum p3h2x4x_tp tp, bool is_of)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(&i3cdev->dev);
> +	u8 slave_rx_buffer[P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE] = { 0 };
> +	u8 target_buffer_page, flag_clear = 0x0f, temp, i;
> +	struct smbus_device *backend = NULL;
> +	u32 packet_len, slave_address, ret;
> +
> +	target_buffer_page = (((rfbuf) ? P3H2x4x_TARGET_BUFF_1_PAGE : P3H2x4x_TARGET_BUFF_0_PAGE)
> +							+  (P3H2x4x_NO_PAGE_PER_TP * tp));
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, target_buffer_page);
> +	if (ret)
> +		goto ibi_err;
> +
> +	/* read buffer length */
> +	ret = regmap_read(p3h2x4x_i3c_hub->regmap, P3H2x4x_TARGET_BUFF_LENGTH, &packet_len);
> +	if (ret)
> +		goto ibi_err;
> +
> +	if (packet_len)
> +		packet_len = packet_len - 1;
> +
> +	if (packet_len > P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE) {
> +		dev_err(&i3cdev->dev, "Received message too big for p3h2x4x buffer\n");
> +		return;
> +	}
> +
> +	/* read slave  address */
> +	ret = regmap_read(p3h2x4x_i3c_hub->regmap, P3H2x4x_TARGET_BUFF_ADDRESS, &slave_address);
> +	if (ret)
> +		goto ibi_err;
> +
> +	/* read data */
> +	if (packet_len) {
> +		ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap, P3H2x4x_TARGET_BUFF_DATA,
> +				       slave_rx_buffer, packet_len);
> +		if (ret)
> +			goto ibi_err;
> +	}
> +
> +	if (is_of)
> +		flag_clear = BUF_RECEIVED_FLAG_TF_MASK;
> +	else
> +		flag_clear = (((rfbuf == RCV_BUF_0) ? P3H2x4x_TARGET_BUF_0_RECEIVE :
> +					P3H2x4x_TARGET_BUF_1_RECEIVE));
> +
> +	/* notify slave driver about received data */
> +	list_for_each_entry(backend, &p3h2x4x_i3c_hub->tp_bus[tp].tp_device_entry, list) {
> +		if (p3h2x4x_i3c_hub->tp_bus[tp].is_slave_registered &&
> +		    slave_address >> 1 == backend->addr) {
> +			i2c_slave_event(backend->client, I2C_SLAVE_WRITE_REQUESTED,
> +					(u8 *)&slave_address);
> +			for (i = 0; i < packet_len; i++) {
> +				temp = slave_rx_buffer[i];
> +				i2c_slave_event(backend->client, I2C_SLAVE_WRITE_RECEIVED,
> +						&temp);
> +			}
> +			i2c_slave_event(backend->client, I2C_SLAVE_STOP, &temp);
> +			break;
> +		}
> +	}
> +
> +ibi_err:
> +	regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
> +}
> +#endif
> +
> +/**
> + * p3h2x4x_ibi_handler - IBI handler.
> + * @i3cdev: i3c device.
> + * @payload: two byte IBI payload data.
> + *
> + */
> +void p3h2x4x_ibi_handler(struct i3c_device *i3cdev,
> +			 const struct i3c_ibi_payload *payload)
> +{
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = dev_get_drvdata(&i3cdev->dev);
> +	u32 target_port_status, payload_byte_one, payload_byte_two;
> +	u32 ret, i;
> +
> +	payload_byte_one = (*(int *)payload->data);
> +	payload_byte_two = (*(int *)(payload->data + 4));
> +
> +	if (!(payload_byte_one & P3H2x4x_SMBUS_AGENT_EVENT_FLAG_STATUS))
> +		goto err;
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	guard(mutex)(&p3h2x4x_i3c_hub->etx_mutex);
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG,
> +			   P3H2x4x_ALL_TP_IBI_DIS);
> +	if (ret) {
> +		dev_err(&i3cdev->dev, "Failed to Disable IBI\n");
> +		goto err;
> +	}
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (p3h2x4x_i3c_hub->tp_bus[i].is_registered && (payload_byte_two >> i) & 0x01) {
> +			ret = regmap_read(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + i,
> +					  &target_port_status);
> +			if (ret) {
> +				dev_err(&i3cdev->dev, "target port read status failed %d\n", ret);
> +				goto err;
> +			}
> +
> +			/* process data receive buffer */
> +			switch (target_port_status & BUF_RECEIVED_FLAG_MASK) {
> +			case P3H2x4x_TARGET_BUF_CA_TF:
> +				break;
> +			case P3H2x4x_TARGET_BUF_0_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_1_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_0_1_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_OVRFL:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, true);
> +				dev_err(&i3cdev->dev, "Overflow, reading buffer zero and one\n");
> +				break;
> +			default:
> +				regmap_write(p3h2x4x_i3c_hub->regmap,
> +					     P3H2x4x_TP0_SMBUS_AGNT_STS + i,
> +					     BUF_RECEIVED_FLAG_TF_MASK);
> +				break;
> +			}
> +		}
> +	}
> +#endif
> +err:
> +	regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG,
> +		     p3h2x4x_i3c_hub->tp_ibi_mask);
> +}
> +
> +static int p3h2x4x_read_smbus_transaction_status(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub,
> +						 u8 target_port_status,
> +						 u8 data_length)
> +{
> +	u32 status_read;
> +	int ret;
> +
> +	mutex_unlock(&p3h2x4x_i3c_hub->etx_mutex);
> +	fsleep(P3H2x4x_SMBUS_400kHz_TRANSFER_TIMEOUT(data_length));

why need sleep here?

> +	mutex_lock(&p3h2x4x_i3c_hub->etx_mutex);
> +
> +	ret = regmap_read(p3h2x4x_i3c_hub->regmap, target_port_status, &status_read);
> +	if (ret)
> +		return ret;
> +
> +	if (status_read & P3H2x4x_SMBUS_TRANSACTION_FINISH_FLAG) {
> +		switch (status_read >> P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SHIFT) {
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_OK:
> +			ret = 0;
> +			break;
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_ADDR_NAK:
> +			ret = -ENXIO;
> +			break;
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_DATA_NAK:
> +			ret = -EIO;
> +			break;
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_ARB_LOSS:
> +			ret = -EAGAIN;
> +			break;
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_SCL_TO:
> +			ret = -ETIMEDOUT;
> +			break;
> +		case P3H2x4x_SMBUS_CNTRL_STATUS_TXN_WTR_NAK:
> +			ret = -ENXIO;
> +			break;
> +		default:
> +			ret = -EIO;
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +/**
> + * p3h2x4x_tp_i2c_xfer_msg() - This starts a SMBus write transaction by writing a descriptor
> + * and a message to the p3h2x4x registers. Controller buffer page is determined by multiplying the
> + * target port index by four and adding the base page number to it.
> + */
> +static int p3h2x4x_tp_i2c_xfer_msg(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub,
> +				   struct i2c_msg *xfers,
> +				   u8 target_port,
> +				   u8 nxfers_i, u8 rw)
> +{
> +	u8 controller_buffer_page = P3H2x4x_CONTROLLER_BUFFER_PAGE + 4 * target_port;
> +	u8 target_port_code = p3h2x4x_i3c_hub->tp_bus[target_port].tp_mask;
> +	u8 target_port_status = P3H2x4x_TP0_SMBUS_AGNT_STS + target_port;
> +	u8 desc[P3H2x4x_SMBUS_DESCRIPTOR_SIZE] = { 0 };
> +	u8 transaction_type = P3H2x4x_SMBUS_400kHz;
> +	int write_length = xfers[nxfers_i].len;
> +	int read_length = xfers[nxfers_i].len;
> +	u8 addr = xfers[nxfers_i].addr;
> +	u8 rw_address = 2 * addr;
> +	int ret;
> +
> +	if (rw) {
> +		rw_address |= BIT(0);
> +		write_length = 0;
> +	} else {
> +		read_length = 0;
> +	}
> +
> +	desc[0] = rw_address;
> +	desc[1] = transaction_type;
> +	desc[2] = write_length;
> +	desc[3] = read_length;
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, target_port_status,
> +			   P3H2x4x_TP_BUFFER_STATUS_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, controller_buffer_page);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_CONTROLLER_AGENT_BUFF,
> +				desc, P3H2x4x_SMBUS_DESCRIPTOR_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	if (!rw) {
> +		ret = regmap_bulk_write(p3h2x4x_i3c_hub->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +					xfers[nxfers_i].buf, xfers[nxfers_i].len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_TRANS_START,
> +			   target_port_code);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_read_smbus_transaction_status(p3h2x4x_i3c_hub, target_port_status,
> +						    (write_length + read_length));
> +	if (ret)
> +		return ret;
> +
> +	if (rw) {
> +		ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap,
> +				       P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +				       xfers[nxfers_i].buf, xfers[nxfers_i].len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function will be called whenever you call I2C read, write APIs like
> + * i2c_master_send(), i2c_master_recv() etc.
> + */
> +static s32 p3h2x4x_tp_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	int ret_sum = 0, ret;
> +	u8 msg_count, rw;
> +
> +	struct tp_bus *bus = i2c_get_adapdata(adap);
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = bus->p3h2x4x_i3c_hub;
> +
> +	guard(mutex)(&p3h2x4x_i3c_hub->etx_mutex);
> +	guard(mutex)(&bus->port_mutex);
> +
> +	if (p3h2x4x_i3c_hub->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_disable_ibi(p3h2x4x_i3c_hub->i3cdev);
> +		if (ret) {
> +			dev_err(p3h2x4x_i3c_hub->dev, "Failed to disable IBI, ret :- %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	for (msg_count = 0; msg_count < num; msg_count++) {
> +		if (msgs[msg_count].len > P3H2x4x_SMBUS_PAYLOAD_SIZE) {
> +			dev_err(p3h2x4x_i3c_hub->dev,
> +				"Message nr. %d not sent - length over %d bytes.\n",
> +				msg_count, P3H2x4x_SMBUS_PAYLOAD_SIZE);
> +			continue;
> +		}
> +		rw = msgs[msg_count].flags % 2;
> +
> +		ret = p3h2x4x_tp_i2c_xfer_msg(p3h2x4x_i3c_hub,
> +					      msgs,
> +					      bus->tp_port,
> +					      msg_count, rw);
> +
> +		if (ret)
> +			goto error;
> +
> +		ret_sum++;
> +	}
> +
> +error:
> +	if (p3h2x4x_i3c_hub->is_p3h2x4x_in_i3c) {
> +		ret =  i3c_device_enable_ibi(p3h2x4x_i3c_hub->i3cdev);
> +		if (ret) {
> +			dev_err(p3h2x4x_i3c_hub->dev, "Failed to enable IBI, ret %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	return ret_sum;
> +}
> +
> +static int p3h2x4x_tp_smbus_xfer_msg(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub,
> +				     u8 target_port,
> +				     u8 addr,
> +				     u8 rw,
> +				     u8 cmd,
> +				     int sz,
> +				     union i2c_smbus_data *data)
> +{
> +	u8 controller_buffer_page = P3H2x4x_CONTROLLER_BUFFER_PAGE + 4 * target_port;
> +	u8 target_port_code = p3h2x4x_i3c_hub->tp_bus[target_port].tp_mask;
> +	u8 target_port_status = P3H2x4x_TP0_SMBUS_AGNT_STS + target_port;
> +	u8 desc[P3H2x4x_SMBUS_DESCRIPTOR_SIZE] = { 0 };
> +	u8 transaction_type = P3H2x4x_SMBUS_400kHz;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 2] = {0};
> +	u8 read_length = 0, write_length = 0;
> +	u8 rw_address = 2 * addr;
> +	int ret, i;
> +
> +	/* Map the size to what the chip understands */
> +	switch (sz) {
> +	case I2C_SMBUS_QUICK:
> +	case I2C_SMBUS_BYTE:
> +		if (rw)	{
> +			buf[0] = data->byte;
> +			read_length = ONE_BYTE_SIZE;
> +			write_length = 0;
> +			rw_address |= BIT(0);
> +		} else {
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (rw) {   /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = ONE_BYTE_SIZE;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			buf[1] = data->byte;
> +			write_length = ONE_BYTE_SIZE + 1;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = 2;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			buf[1] = data->word & 0xff;
> +			buf[2] = (data->word & 0xff00) >> 8;
> +			write_length = ONE_BYTE_SIZE + 2;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = data->block[0] + 1;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			for (i = 0 ; i <= data->block[0]; i++)
> +				buf[i + 1] = data->block[i];
> +
> +			write_length = data->block[0] + 2;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = data->block[0];
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			for (i = 0 ; i < data->block[0]; i++)
> +				buf[i + 1] = data->block[i + 1];
> +
> +			write_length = data->block[0] + 1;
> +			read_length = 0;
> +		}
> +		break;
> +	default:
> +		dev_warn(p3h2x4x_i3c_hub->dev, "Unsupported transaction %d\n", sz);
> +		break;
> +	}
> +
> +	desc[0] = rw_address;
> +	desc[1] = transaction_type;
> +	desc[2] = write_length;
> +	desc[3] = read_length;
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, target_port_status,
> +			   P3H2x4x_TP_BUFFER_STATUS_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, controller_buffer_page);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_CONTROLLER_AGENT_BUFF,
> +				desc, P3H2x4x_SMBUS_DESCRIPTOR_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	if (write_length) {
> +		ret = regmap_bulk_write(p3h2x4x_i3c_hub->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +					buf, write_length);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_TP_SMBUS_AGNT_TRANS_START,
> +			   target_port_code);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_read_smbus_transaction_status(p3h2x4x_i3c_hub, target_port_status,
> +						    (write_length + read_length));
> +	if (ret)
> +		return ret;
> +
> +	if (rw) {
> +		switch (sz) {
> +		case I2C_SMBUS_QUICK:
> +		case I2C_SMBUS_BYTE:
> +		case I2C_SMBUS_BYTE_DATA:
> +			{
> +				ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap,
> +						       P3H2x4x_CONTROLLER_AGENT_BUFF_DATA +
> +						       write_length,
> +						       &data->byte, read_length);
> +				break;
> +			}
> +		case I2C_SMBUS_WORD_DATA:
> +			{
> +				ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap,
> +						       P3H2x4x_CONTROLLER_AGENT_BUFF_DATA +
> +						       write_length,
> +						       (u8 *)&data->word, read_length);
> +				break;
> +			}
> +		case I2C_SMBUS_BLOCK_DATA:
> +			{
> +				ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap,
> +						       P3H2x4x_CONTROLLER_AGENT_BUFF_DATA +
> +						       write_length,
> +						       data->block, read_length);
> +				break;
> +			}
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
> +			{
> +				ret = regmap_bulk_read(p3h2x4x_i3c_hub->regmap,
> +						       P3H2x4x_CONTROLLER_AGENT_BUFF_DATA +
> +						       write_length,
> +						       data->block + 1, read_length);
> +				break;
> +			}
> +		default:
> +				dev_warn(p3h2x4x_i3c_hub->dev, "Unsupported transaction %d\n", sz);
> +				break;
> +		}
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(p3h2x4x_i3c_hub->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static s32 p3h2x4x_tp_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> +				 char read_write, u8 command, int size,
> +				 union i2c_smbus_data *data)
> +{
> +	struct tp_bus *bus = i2c_get_adapdata(adap);
> +
> +	struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub = bus->p3h2x4x_i3c_hub;
> +	int ret, ret_status;
> +
> +	guard(mutex)(&p3h2x4x_i3c_hub->etx_mutex);
> +	guard(mutex)(&bus->port_mutex);
> +
> +	if (p3h2x4x_i3c_hub->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_disable_ibi(p3h2x4x_i3c_hub->i3cdev);
> +		if (ret) {
> +			dev_err(p3h2x4x_i3c_hub->dev, "Failed to disable IBI, ret :- %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret_status = p3h2x4x_tp_smbus_xfer_msg(p3h2x4x_i3c_hub,
> +					       (u8)bus->tp_port,
> +					       (u8)addr,
> +					       (u8)read_write,
> +					       (u8)command,
> +					       size,
> +					       data);
> +
> +	if (p3h2x4x_i3c_hub->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_enable_ibi(p3h2x4x_i3c_hub->i3cdev);
> +		if (ret) {
> +			dev_err(p3h2x4x_i3c_hub->dev, "Failed to enable IBI, ret %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret_status;
> +}
> +
> +static u32 p3h2x4x_tp_smbus_funcs(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
> +			I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_WORD_DATA |
> +			I2C_FUNC_SMBUS_I2C_BLOCK  | I2C_FUNC_SMBUS_BLOCK_DATA |
> +			I2C_FUNC_I2C;
> +}
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +static int p3h2x4x_tp_i2c_reg_slave(struct i2c_client *slave)
> +{
> +	struct tp_bus *bus = i2c_get_adapdata(slave->adapter);
> +
> +	bus->is_slave_registered = true;
> +
> +	return 0;
> +}
> +
> +static int p3h2x4x_tp_i2c_unreg_slave(struct i2c_client *slave)
> +{
> +	struct tp_bus *bus = i2c_get_adapdata(slave->adapter);
> +
> +	bus->is_slave_registered = false;
> +
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * I2C algorithm Structure
> + */
> +static struct i2c_algorithm p3h2x4x_tp_i2c_algorithm = {
> +	.master_xfer    = p3h2x4x_tp_i2c_xfer,
> +	.smbus_xfer = p3h2x4x_tp_smbus_xfer,
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	.reg_slave = p3h2x4x_tp_i2c_reg_slave,
> +	.unreg_slave = p3h2x4x_tp_i2c_unreg_slave,
> +#endif
> +	.functionality  = p3h2x4x_tp_smbus_funcs,
> +};
> +
> +/**
> + * p3h2x4x_tp_smbus_algo - add i2c adapter for target port who
> + * configured as SMBus.
> + * @p3h2x4x_i3c_hub: p3h2x4x device structure.
> + * @tp: target port.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_smbus_algo(struct p3h2x4x_i3c_hub_dev *p3h2x4x_i3c_hub, int tp)
> +{
> +	struct i2c_adapter *smbus_adapter;
> +	int ret;
> +
> +	smbus_adapter = devm_kzalloc(p3h2x4x_i3c_hub->dev, sizeof(*smbus_adapter), GFP_KERNEL);
> +	if (!smbus_adapter)
> +		return -ENOMEM;
> +
> +	smbus_adapter->owner = THIS_MODULE;
> +	smbus_adapter->class = I2C_CLASS_HWMON;
> +	smbus_adapter->algo = &p3h2x4x_tp_i2c_algorithm;
> +	smbus_adapter->dev.parent = p3h2x4x_i3c_hub->dev;
> +	smbus_adapter->dev.of_node =  p3h2x4x_i3c_hub->tp_bus->of_node;
> +	sprintf(smbus_adapter->name, "p3h2x4x-i3c-hub.tp-port-%d", tp);
> +
> +	i2c_set_adapdata(smbus_adapter, &p3h2x4x_i3c_hub->tp_bus[tp]);
> +
> +	ret = i2c_add_adapter(smbus_adapter);
> +	if (ret) {
> +		dev_warn(p3h2x4x_i3c_hub->dev, "Failed to register i2c adapter for port:%i\n", tp);
> +		devm_kfree(p3h2x4x_i3c_hub->dev, smbus_adapter);
> +		return ret;
> +	}
> +
> +	p3h2x4x_i3c_hub->tp_bus[tp].is_registered = true;
> +	p3h2x4x_i3c_hub->tp_bus[tp].smbus_port_adapter = smbus_adapter;
> +	return 0;
> +}
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 392b60c7c8dc..9f850a86ca2c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2414,5 +2414,17 @@ config MFD_RSMU_SPI
>  	  Additional drivers must be enabled in order to use the functionality
>  	  of the device.
>
> +config MFD_P3H2X4X
> +	tristate "NXP P3H2X4X I3C Hub Device"
> +	depends on I3C
> +	select MFD_CORE
> +	select REGMAP_I3C
> +	help
> +	  Enable Support for NXP P3H244x/P3H284x I3C HUB device using I3C/I2c
> +	  communication interface.
> +
> +	  This driver provides support for I3C Hub and regulator, additional
> +	  drivers must be enabled in order to use the functionality of the device.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index cdbd3ef0c462..2fa6a5bf6a73 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -294,3 +294,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>  rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> +obj-$(CONFIG_MFD_P3H2X4X) += p3h2840.o
> diff --git a/drivers/mfd/p3h2840.c b/drivers/mfd/p3h2840.c
> new file mode 100644
> index 000000000000..535c9a272ce7
> --- /dev/null
> +++ b/drivers/mfd/p3h2840.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + * P3H2x4x i3c hub and regulator device.
> + */
> +
> +#include <linux/i3c/master.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/p3h2840.h>
> +
> +static const struct mfd_cell p3h2x4x_devs[] = {
> +	{
> +		.name = "p3h2x4x-regulator",
> +	},
> +	{
> +		.name = "p3h2x4x-i3c-hub",
> +	},
> +};
> +
> +static const struct regmap_config p3h2x4x_regmap_config = {
> +	.reg_bits = P3H2x4x_REG_BITS,
> +	.val_bits = P3H2x4x_VAL_BITS,
> +	.max_register = 0xFF,
> +};
> +
> +static int p3h2x4x_device_probe_i3c(struct i3c_device *i3cdev)
> +{
> +	struct p3h2x4x_dev *p3h2x4x;
> +	int ret;
> +
> +	p3h2x4x = devm_kzalloc(&i3cdev->dev, sizeof(*p3h2x4x), GFP_KERNEL);
> +	if (!p3h2x4x)
> +		return -ENOMEM;
> +
> +	i3cdev_set_drvdata(i3cdev, p3h2x4x);
> +
> +	p3h2x4x->regmap = devm_regmap_init_i3c(i3cdev, &p3h2x4x_regmap_config);
> +	if (IS_ERR(p3h2x4x->regmap)) {
> +		ret = PTR_ERR(p3h2x4x->regmap);
> +		return dev_err_probe(&i3cdev->dev, ret, "Failed to register I3C HUB regmap\n");
> +	}
> +
> +	p3h2x4x->is_p3h2x4x_in_i3c = true;
> +	p3h2x4x->i3cdev = i3cdev;
> +
> +	ret = devm_mfd_add_devices(&i3cdev->dev, PLATFORM_DEVID_NONE,
> +				   p3h2x4x_devs, ARRAY_SIZE(p3h2x4x_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(&i3cdev->dev, ret, "Failed to add sub devices\n");
> +
> +	return 0;
> +}
> +
> +static int p3h2x4x_device_probe_i2c(struct i2c_client *client)
> +{
> +	struct p3h2x4x_dev *p3h2x4x;
> +	int ret;
> +
> +	p3h2x4x = devm_kzalloc(&client->dev, sizeof(*p3h2x4x), GFP_KERNEL);
> +	if (!p3h2x4x)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, p3h2x4x);
> +
> +	p3h2x4x->regmap = devm_regmap_init_i2c(client, &p3h2x4x_regmap_config);
> +	if (IS_ERR(p3h2x4x->regmap)) {
> +		ret = PTR_ERR(p3h2x4x->regmap);
> +		return dev_err_probe(&client->dev, ret, "Failed to register I3C HUB regmap\n");
> +	}
> +
> +	p3h2x4x->is_p3h2x4x_in_i3c = false;
> +	p3h2x4x->i2cdev = client;
> +
> +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
> +				   p3h2x4x_devs, ARRAY_SIZE(p3h2x4x_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to add sub devices\n");
> +
> +	return 0;
> +}
> +
> +/* p3h2x4x ids (i3c) */
> +static const struct i3c_device_id p3h2x4x_i3c_ids[] = {
> +	I3C_CLASS(I3C_DCR_HUB, NULL),
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i3c, p3h2x4x_i3c_ids);
> +
> +/* p3h2x4x ids (i2c) */
> +static const struct i2c_device_id p3h2x4x_i2c_id_table[] = {
> +	{ "nxp-i3c-hub" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, p3h2x4x_i2c_id_table);
> +
> +static const struct of_device_id  p3h2x4x_i2c_of_match[] = {
> +	{ .compatible = "nxp,p3h2840", },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, p3h2x4x_i2c_of_match);
> +static struct i3c_driver p3h2x4x_i3c = {
> +	.driver = {
> +		.name = "p3h2x4x_i3c_drv",
> +	},
> +	.probe = p3h2x4x_device_probe_i3c,
> +	.id_table = p3h2x4x_i3c_ids,
> +};
> +
> +static struct i2c_driver p3h2x4x_i2c = {
> +	.driver = {
> +		.name = "p3h2x4x_i2c_drv",
> +		.of_match_table = p3h2x4x_i2c_of_match,
> +	},
> +	.probe =  p3h2x4x_device_probe_i2c,
> +	.id_table = p3h2x4x_i2c_id_table,
> +};
> +
> +module_i3c_i2c_driver(p3h2x4x_i3c, &p3h2x4x_i2c);
> +
> +MODULE_AUTHOR("Aman Kumar Pandey <aman.kumarpandey@nxp.com>");
> +MODULE_AUTHOR("vikash Bansal <vikash.bansal@nxp.com>");
> +MODULE_DESCRIPTION("P3H2x4x I3C HUB driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index b3513900ccb5..966317b21276 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1005,6 +1005,16 @@ config REGULATOR_PF8X00
>  	  on the NXP PF8100/PF8121A/PF8200 PMIC. The module will be named
>  	  "pf8x00-regulator".
>
> +config REGULATOR_P3H2X4X
> +	tristate "P3H2X4X regulator support"
> +	depends on MFD_P3H2X4X
> +	help
> +	  This driver provides support for the voltage regulators of the
> +	  P3H244x/P3H284x multi-function I3C Hub device.
> +
> +	  Say M here if you want to include support for this regulator as
> +          a module. The module will be named "p3h2840_i3c_hub_regulator".
> +
>  config REGULATOR_PF1550_RPMSG
>  	tristate "Freescale PF1550 rpmsg regulator driver"
>  	depends on RPMSG
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index c284babb2345..8feeacb67d2c 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -201,5 +201,6 @@ obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
>  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
> +obj-$(CONFIG_REGULATOR_P3H2X4X) += p3h2840_i3c_hub_regulator.o
>
>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
> diff --git a/drivers/regulator/p3h2840_i3c_hub_regulator.c b/drivers/regulator/p3h2840_i3c_hub_regulator.c
> new file mode 100644
> index 000000000000..f01dbc0aa691
> --- /dev/null
> +++ b/drivers/regulator/p3h2840_i3c_hub_regulator.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + * This P3H2x4x driver file contain functions for enable/disable regulator and voltage set/get.
> + */
> +#include <linux/regulator/driver.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/mfd/p3h2840.h>
> +
> +#define P3H2x4x_LDO_AND_PULLUP_CONF				0x19
> +#define P3H2x4x_LDO_ENABLE_DISABLE_MASK				GENMASK(3, 0)
> +#define P3H2x4x_CP0_EN_LDO				        BIT(0)
> +#define P3H2x4x_CP1_EN_LDO				        BIT(1)
> +#define P3H2x4x_TP0145_EN_LDO					BIT(2)
> +#define P3H2x4x_TP2367_EN_LDO					BIT(3)
> +
> +#define P3H2x4x_NET_OPER_MODE_CONF				0x15
> +#define P3H2x4x_VCCIO_LDO_CONF					0x16
> +#define P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK			GENMASK(1, 0)
> +#define P3H2x4x_CP0_VCCIO_LDO_VOLTAGE(x)	\
> +		FIELD_PREP(P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK, x)
> +#define P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK			GENMASK(3, 2)
> +#define P3H2x4x_CP1_VCCIO_LDO_VOLTAGE(x)	\
> +		FIELD_PREP(P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK, x)
> +#define P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK			GENMASK(5, 4)
> +#define P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE(x)	\
> +		FIELD_PREP(P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK, x)
> +#define P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK			GENMASK(7, 6)
> +#define P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE(x)	\
> +		FIELD_PREP(P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK, x)
> +#define P3H2x4x_LDO_COUNT					4
> +
> +struct p3h2x4x_regulator_dev {
> +	struct regulator_dev *rp3h2x4x_dev[P3H2x4x_LDO_COUNT];
> +	struct regmap *regmap;
> +};
> +
> +static const struct regulator_ops p3h2x4x_ldo_ops = {
> +	.list_voltage = regulator_list_voltage_table,
> +	.map_voltage = regulator_map_voltage_iterate,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +};
> +
> +static const unsigned int p3h2x4x_voltage_table[] = {
> +	1000000,
> +	1100000,
> +	1200000,
> +	1800000,
> +};
> +
> +static struct regulator_desc p3h2x4x_regulators[] = {
> +	{
> +		.name = "cp0",
> +		.of_match = of_match_ptr("cp0"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.volt_table = p3h2x4x_voltage_table,
> +		.n_voltages = ARRAY_SIZE(p3h2x4x_voltage_table),
> +		.ops = &p3h2x4x_ldo_ops,
> +		.type = REGULATOR_VOLTAGE,
> +		.owner = THIS_MODULE,
> +		.enable_reg = P3H2x4x_LDO_AND_PULLUP_CONF,
> +		.enable_mask = P3H2x4x_CP0_EN_LDO,
> +		.vsel_reg = P3H2x4x_VCCIO_LDO_CONF,
> +		.vsel_mask = P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK,
> +	},
> +	{
> +		.name = "cp1",
> +		.of_match = of_match_ptr("cp1"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.volt_table = p3h2x4x_voltage_table,
> +		.n_voltages = ARRAY_SIZE(p3h2x4x_voltage_table),
> +		.ops = &p3h2x4x_ldo_ops,
> +		.type = REGULATOR_VOLTAGE,
> +		.owner = THIS_MODULE,
> +		.enable_reg = P3H2x4x_LDO_AND_PULLUP_CONF,
> +		.enable_mask = P3H2x4x_CP1_EN_LDO,
> +		.vsel_reg = P3H2x4x_VCCIO_LDO_CONF,
> +		.vsel_mask = P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK,
> +	},
> +	{
> +		.name = "tp0145",
> +		.of_match = of_match_ptr("tp0145"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.volt_table = p3h2x4x_voltage_table,
> +		.n_voltages = ARRAY_SIZE(p3h2x4x_voltage_table),
> +		.ops = &p3h2x4x_ldo_ops,
> +		.type = REGULATOR_VOLTAGE,
> +		.owner = THIS_MODULE,
> +		.enable_reg = P3H2x4x_LDO_AND_PULLUP_CONF,
> +		.enable_mask = P3H2x4x_TP0145_EN_LDO,
> +		.vsel_reg = P3H2x4x_VCCIO_LDO_CONF,
> +		.vsel_mask = P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK,
> +	},
> +	{
> +		.name = "tp2367",
> +		.of_match = of_match_ptr("tp2367"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.volt_table = p3h2x4x_voltage_table,
> +		.n_voltages = ARRAY_SIZE(p3h2x4x_voltage_table),
> +		.ops = &p3h2x4x_ldo_ops,
> +		.type = REGULATOR_VOLTAGE,
> +		.owner = THIS_MODULE,
> +		.enable_reg = P3H2x4x_LDO_AND_PULLUP_CONF,
> +		.enable_mask = P3H2x4x_TP2367_EN_LDO,
> +		.vsel_reg = P3H2x4x_VCCIO_LDO_CONF,
> +		.vsel_mask = P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK,
> +	},
> +};
> +
> +int p3h2x4x_regulator_probe(struct platform_device *pdev)
> +{
> +	struct p3h2x4x_dev *p3h2x4x = dev_get_drvdata(pdev->dev.parent);
> +	struct p3h2x4x_regulator_dev *p3h2x4x_regulator;
> +	struct regulator_config rcfg = { };
> +	struct device *dev = &pdev->dev;
> +	struct regulator_dev *rdev;
> +	int ret, i;
> +
> +	p3h2x4x_regulator = devm_kzalloc(dev, sizeof(*p3h2x4x_regulator), GFP_KERNEL);
> +	if (!p3h2x4x_regulator)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, p3h2x4x_regulator);
> +
> +	p3h2x4x_regulator->regmap = p3h2x4x->regmap;
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	rcfg.dev = dev;
> +	rcfg.dev->of_node = dev->of_node;
> +	rcfg.regmap = p3h2x4x_regulator->regmap;
> +	rcfg.driver_data = p3h2x4x_regulator;
> +
> +	for (i = 0; i < ARRAY_SIZE(p3h2x4x_regulators); i++) {
> +		rdev = devm_regulator_register(&pdev->dev, &p3h2x4x_regulators[i], &rcfg);
> +		if (IS_ERR(rdev)) {
> +			ret = PTR_ERR(rdev);
> +			dev_err(dev, "Failed to register %s\n", p3h2x4x_regulators[i].name);
> +			return ret;
> +		}
> +		p3h2x4x_regulator->rp3h2x4x_dev[i] = rdev;
> +	}
> +	return 0;
> +}
> +
> +static struct platform_driver p3h2x4x_regulator_driver = {
> +	.driver = {
> +		.name = "p3h2x4x-regulator",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = p3h2x4x_regulator_probe,
> +};
> +module_platform_driver(p3h2x4x_regulator_driver);
> +
> +MODULE_AUTHOR("Aman Kumar Pandey <aman.kumarpandey@nxp.com>");
> +MODULE_AUTHOR("vikash Bansal <vikash.bansal@nxp.com>");
> +MODULE_DESCRIPTION("P3H2x4x I3C HUB driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index ef6217da8253..f43feda2fc09 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -77,6 +77,7 @@ struct i3c_priv_xfer {
>   */
>  enum i3c_dcr {
>  	I3C_DCR_GENERIC_DEVICE = 0,
> +	I3C_DCR_HUB = 194,
>  };
>
>  #define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
> diff --git a/include/linux/mfd/p3h2840.h b/include/linux/mfd/p3h2840.h
> new file mode 100644
> index 000000000000..4e3c737eb8a8
> --- /dev/null
> +++ b/include/linux/mfd/p3h2840.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2025 NXP
> + * This header file contain private Reg address and its bit mapping etc.
> + */
> +
> +#ifndef P3H2840_H
> +#define P3H2840_H
> +
> +#include <linux/types.h>
> +
> +/* Reg config for Regmap */
> +#define P3H2x4x_REG_BITS					8
> +#define P3H2x4x_VAL_BITS					8
> +
> +struct p3h2x4x_dev {
> +	struct i3c_device *i3cdev;
> +	struct i2c_client *i2cdev;
> +	struct regmap *regmap;
> +	bool is_p3h2x4x_in_i3c;
> +};
> +#endif /* P3H2840_H */
> --
> 2.25.1
>

