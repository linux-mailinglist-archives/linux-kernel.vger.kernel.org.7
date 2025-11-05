Return-Path: <linux-kernel+bounces-885708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65464C33BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E4D3B5F94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBB221269;
	Wed,  5 Nov 2025 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="raiC+vuV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E500EACE;
	Wed,  5 Nov 2025 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308417; cv=fail; b=gAiYZih5YkY8DNLnIp+SleBzfwghKsXqhJdQ2+87lTM6rFcwg/om9YCbrgbe0SDk8LEsJfQWRjKYgSztC5HOK+f/9tElNz6MFf6+emAo4xYmxio6xyM8y9wdLjJTBuDqnGCtmYlUhF9tkYASPDvOGn+73OXjFFZsF6xdz5kZrmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308417; c=relaxed/simple;
	bh=mRhl/fhKxkw61G/lpt44KHwBeE5VN4M7jM+8YdoqZzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vx9E9dyTp2io3i8IAY+fJNDHkdbs5G8okotisSQvQPAryctG9ykL8mAnnJGX/F6ftL56p60HrTB63oNkd4FAW8E3ks7q3SjsR6Jt1FRRENDqgoGRmpMR3UYQ1WUK34RmC3FiWSn+mHPEqGRPNBw1xOb/AuQi+X9DpL8TJjFum5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=raiC+vuV; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8YMqF+MbHBxAJ6R5DhMXdzwHY2wbcI+jUA+4+dWX1wU+gJ8WRAtyIhPjnYo5fWSp2ez4KJswpPKWgqPxxmxycETQRzlCa3n4ouPiuatNJQ3voEPxxFpfrzsW1//LCS/DpuvIAsZZGllG0nlucoE3gfHCe27tqknA3H4M2qWCVEA5QowtT/uHCIO/c7wrFWCR8WX5n/mgfUMzUjFfuUKPiDQvyJW1nhERAGpv558GVhhVsCB1O7I798jJ7Kyt3xVZw92ZrX0vU95Tj8uqE121eBpbho13g3D4/2566WLDOtpiVcGqSQT50d+UY+JA0eZ0jAlOjwbbIRjf5udLu8MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ/aYHjWVFzI5tk53M4T2nZIFT9y1m8RQrqqZGeYntE=;
 b=QA35b7WChRrvaMSLauWL2LmRp0/+Sfdt6Ny3sqJhs09u9R1X4AQyj6oEjyPa3anRqTm6nOOZ8RIG2qbmPY/5fZF37nGAeI94I3Ij6hDuAEJk56VVBSEVcnBEbdumDilOtS9tF4ZmngUHfi1W5dKZn5ewe2cLUvEzTYq8LSELax1GbluMgoBRai7G8p5V5Efv6TvLhmSjjUe1rv2WLhjXctb1TskK44MUpYIzVFsZqjYFHkAFf0X+0QMCWF8JQrN06UAAvZozF+uhceFZ9+vCISv7NJ93ZpcryKeZiOyBhLvT6Vi974BtFv7fzaZMo9t7PL7mQqNrqRw/BkEj7NTgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ/aYHjWVFzI5tk53M4T2nZIFT9y1m8RQrqqZGeYntE=;
 b=raiC+vuVFydZOhUt7C6z0us+O/Sok0yye92bytwh05DqHICdyJiF8F2Y3hgH9GyyGmJsHJgirkvBCPCgGyTZAqyXt19DZRMzC4MJkqIf8jxv1c8PH3ChyosZ94gHtW1F6ADFwsXg/supwCeq6D+oDFT7UYndHgPXehHUYCmpfbLDnRmh6i2YtWGD3ale7WlumYgmsHb0AYj78FwVIq4CJk41Q+ykBK6QJVgvs6ALanoE5THb+BMq9NN6PSDWjYRI+QVttQx6ZbGR/uFTEPDYsbRNBnrK540RH0dwQ1NsAWzJ+EMmogxGkFdjFa7PlkZUy4sXBtbz39V9ppEB65gGmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7190.eurprd04.prod.outlook.com (2603:10a6:20b:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 02:06:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 02:06:50 +0000
Date: Wed, 5 Nov 2025 10:07:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: imx: cleanup most gpmi related CHECK_DTB
 warning
Message-ID: <aQqxXuOei/wtOBar@shlinux89>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ec1d6b-780e-4843-d18c-08de1c0ffbaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcyh36eZ7SnKJS4PmFQYIhHRxj2SrS+i43HUjpSvc6lOgad518nekUPqzP0o?=
 =?us-ascii?Q?CofQrHtdEJpQuicqN6lw2Gn0kBUQJbPH4VxcvAGflqJwdsY6zlTIHNS1onSa?=
 =?us-ascii?Q?/s+WNe4tTJhDco+nlItZuJlTEYH9uGzv/k0RJ0zevtCdBwWlnTpaD/WWPsMO?=
 =?us-ascii?Q?mFOHyMJcqeW7ohAyPdFXYFdjmzHJlKK0nqezCc854+3aAkuk93iKRVSO+qxv?=
 =?us-ascii?Q?K1Oe6kSTb4VG4fsIZvzuEoC95n7IRZlNVWUVXJI1YajrzRiJ637m5TjCkSG0?=
 =?us-ascii?Q?K5h6B2UgN3DNdUuEzRl2OQMqkbyV1YczD1LXbnvqTCsrTy55E19dclwvWtWt?=
 =?us-ascii?Q?J9Ol88g0N2wYQLb8i7+ozeGO5DlilSk1/KGkxAhDOHV20UhDvYFgz+vcDyR4?=
 =?us-ascii?Q?KOmCGfsc6SkTxRvR8y0zwHyl49BHID7Qp578erJGZ7zWusx9yjk5O5zhl3+W?=
 =?us-ascii?Q?iF/UBcY+8WqfYU5kDyIt0CHWj7FfdrO/MrbDZoEf24lcnMVET64arFrfl5z4?=
 =?us-ascii?Q?XPLeBRlNKc9hP0DZkbWx2NXk6Uy2eAYQjn/RMuwc9Q4xdxclPPZOgG1UVgbW?=
 =?us-ascii?Q?VTqU74y336/fimzIXb3S4aMM1psPGIU71KMyz8HSR5Lsx636KMkxh4AcFqu/?=
 =?us-ascii?Q?//HXG4oFXPMNUuVybbxFPFa+1RYbnODOC+uKJvHLNAMYsKrgBfo9moQBQziw?=
 =?us-ascii?Q?8UkCPKQAJlfN/fKJTSQB5qqlFUZd/yjOPxFqYTazHLeQe6sKpjhvboOZKmLy?=
 =?us-ascii?Q?FWBRbXmbudhZXT1MjSD/mV0dmup8hAar1azBGlvtrvtmWkv5LCtOs7t7cPNG?=
 =?us-ascii?Q?7YigbzS6zIUCYi9GrmEhyXU5i2C86iu3Pq17QWLRlguknxwUOKC0mTNH1G42?=
 =?us-ascii?Q?zDlCweTHQjwc1XPx6BhR02Z7+yiMCqqjdohBybDzm2aBQUqKp5zEUr/qtx1w?=
 =?us-ascii?Q?YsqOyq8MqwnxJw193PJYuJOU9qPKFfvf7kpZdP16id8Xo2bRaiWKBp7hQ4oe?=
 =?us-ascii?Q?wOjri281fDNVz2701oaXYR4I7JG2VY2Gaqyb7/kuT4S6KDFj+MqshaQoXOqQ?=
 =?us-ascii?Q?Ow2PDkrM8GHX92HqHh0PcRQn+Gt0ZM/fhcmYWWRqW3CmjM8fX/HmGRCSUkA3?=
 =?us-ascii?Q?tKEcootspnC9bsSSOXmMWOErKBkeFx/BXhFAfKdAprGDvpoZ517Q1yLQN1aP?=
 =?us-ascii?Q?KczfzOT/rAqw2QbikDPN4E79vZt5zKlh5ZeJz3ZC9NAuO6K7T6ersyLqIRKQ?=
 =?us-ascii?Q?Nsm9xv+QvpDJL7OwTD1ZAPQ/Q5zZw4kwknbe248pOn1WClqoqpUuCy7hN4FA?=
 =?us-ascii?Q?DWvazTA6d79UylIa3SXzSglZadwusqjmyipR5Sgbl63RTrdYEh+CEkyu80Qn?=
 =?us-ascii?Q?Aj5neJiJGpIKLzzsKVtrIijLG1ccbLJGU8IeuVWE4eHn/0JDZYlvCLmIvsJW?=
 =?us-ascii?Q?uYkb3sA1LdFhh9thmqoZLcvJ7X0Xck//LGa5bPRy8bfUTCHlwerUDwzlDhTC?=
 =?us-ascii?Q?ii5OXIoJHOcouJkzaZNTM0WOFufRGkh7OxmM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAliUfH41SFWnN8x0EmnhfQNJtHfkDFyBQpn3dewCzBfvWKbe9OAB9MZYZ31?=
 =?us-ascii?Q?TPhy242C3nQquwiNu3Lj3kZBzo1I4f8o2bgBRKnbfNDWZS7mHdaEsUK4YSie?=
 =?us-ascii?Q?wX/HJ5lR/q7dn25vsKaiolC0ozKLpOA2K1/GwI1wbLpk/J9Wq0J+GK6lksEt?=
 =?us-ascii?Q?6CjQaDw/dajnb45FbwSrtEUewQqb7Vi7QbzndnOyRD8/n0GBIcedGKy/R7Ff?=
 =?us-ascii?Q?LZBkHq4DYQ51UatrMcAnUAYnesT3PmBYk5qMO9LIdlB02jodv9GlpyLq6ImU?=
 =?us-ascii?Q?U872vee4pU9Ix/uNOLBX/4MSeSIHA5gLtvBQxl37uitE9tmuUFCr4pYBntkd?=
 =?us-ascii?Q?3z6nRDxWMnVPmlRvL/ZWr8x0DcFOdDNfr9qo/2+IiGrI2f9zb7JlCeZkpbPV?=
 =?us-ascii?Q?EJ5fak0fCYwKywD2IyKRZXdT/uJ26auSa6hJYpGah9kW0bl1u2pMqbWUsVct?=
 =?us-ascii?Q?CbeUKFy4SoJDnSgFk5KHaYILJUSlKB1X7YJiuJNqc6nwOiO77hB++Vz8l170?=
 =?us-ascii?Q?GyEdteF30g629ph7vJQ21qe1Es4FcyL940G4ECpIJntT0Jbc21MKOBOtApX2?=
 =?us-ascii?Q?ifAgzTyWPfNcpe3OrA4fYU6VImWgHEQIkxsxvRhxwcxcaj6p2TgKvVIw6k70?=
 =?us-ascii?Q?tGSH70U7I4HtHLWaUKnT3ebZeJhAcC1XDz3rsE9mxpyrePDCEJfDUpnIpATW?=
 =?us-ascii?Q?tLNYijHGhs/Mi+4SzfQI84AtUuxcv6nWk0CDOlr14BD/dIEJ4IxaFMQGOpeN?=
 =?us-ascii?Q?z6ZY0HR5NjEyhzUhseUjnxkpt0hbx96pvzg55gUAB2wfv2em63BJTnJQcPVI?=
 =?us-ascii?Q?z5SXXGqHCJiwX8XhW/KMB2HztOgJ/ooejKvgZe6HS0xiZ4tczOUoq30WeKFQ?=
 =?us-ascii?Q?cL8aur/1ZaGSDjGIqc3WHwDmUXXQb65/MMs037ZBj+UkXAnlhsQbeERH1ck0?=
 =?us-ascii?Q?XvIDVHTQrjgV3XYXKUjnHDeBwZ+UneXzvlSPbMqyge8F3XeL0CqugchzfNro?=
 =?us-ascii?Q?HHjbaoNqmyxkbGDouXfqLo0fjcwNYkARRFR9rZ90Q5pr0tk21ZbqX4x4XEEa?=
 =?us-ascii?Q?/YjYwNhed4gkdzIFSfAl1C7FrBalbLB3N7Ks7aWwzWXq6hoYRuLXcE3NFT+J?=
 =?us-ascii?Q?2irABczd6Ra3Qt8o9fZjV70cxmPY13I4jgIfBOutTfWDu3I9A7kdNCr70Laz?=
 =?us-ascii?Q?E2kbYe3Lw6UtIxEZSJrDn/u5TMQlHH2+aBNnftsebrVQF2tNHoZUtYvzOkvJ?=
 =?us-ascii?Q?1txbyZA7P2PpJwf5TtLHz7hAXEbNQYEFZfz7UrdbpzEhTLjY+XhHIQJMLK33?=
 =?us-ascii?Q?wFCb/FOVYfyXEa7TYxhKL7voYGimK1O/362fJOnY9kX7S+zjqAWyplHEw3zj?=
 =?us-ascii?Q?J65Xi+bK4WRPosGfsmqUPGCWo6PEvsJ4Mp4ldXDSxtS1cUPXLSh2/ylfTEHz?=
 =?us-ascii?Q?Pdc9UN9NKXrzPXtIOhDzbFtpqQwcS3aXOu9uJ4V2xIa61BJoJUIznscY5Y2F?=
 =?us-ascii?Q?2dM3HV+fb0aTcWmH+x112NuhH+yRrFajdp3QLD0Z9vUYIsSWbyJNMN+M7v32?=
 =?us-ascii?Q?LdIljMCCcTU0/iwAHGN2+YRzjc4uscN2I0e90AAc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec1d6b-780e-4843-d18c-08de1c0ffbaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:06:50.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x12fJ3O18fMAkUDm+lG2C4G9l256jOCW3qaGF4wJqwcdBSIikEEdEHiHogtECHyj9l7/Qgh3xXXv+yyorUkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7190

On Tue, Nov 04, 2025 at 05:27:11PM -0500, Frank Li wrote:
>Only few warning left because original data is wrong
>arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): nand@0:nand-ecc-step-size: 0 is less than the minimum of 1
>
>driver will leave default value when these value is 0, but binding require
>start from 1.
>
>Since 2019 year, commit
>        (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
>        NAND related property is preferred located under nand@<n> even though only
>        one NAND chip supported.
>
>NAND related property should be located under nand@0. This format already
>support quite long time, so it should be safe to switch to modern format.
>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
>Frank Li (3):
>      ARM: dts: imx6qdl: add '#address-cells' and '#size-cells' for gpmi-nand
>      ARM: dts: imx6sx: update gpmi #size-cells to 0
>      ARM: dts: imx: move nand related property under nand@0
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

