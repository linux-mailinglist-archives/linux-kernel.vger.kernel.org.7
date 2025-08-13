Return-Path: <linux-kernel+bounces-766554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E081EB24807
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AB71BC3A40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0672F657D;
	Wed, 13 Aug 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V2I4hYAC"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39682F0693
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083284; cv=fail; b=fC69jSx1KJqLLLko2dQJVu4jkjZKyKp2U+h4TnSfc3RXlvVG8zXTM9TSy0BHZ/mRaBbTP7hNHwzKeeQK/YTBn7LZwweJuXevGmyrADXUQwzaFUA2YJJO4ZuHcL/qNHW10z+EyAnLUewbsIxwxblEs0kfqM9V50rWQtb5xQ1oJlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083284; c=relaxed/simple;
	bh=NxhfXKDqCss66XGWk+2FaNKCTFNjcfs70O45uhd7E4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjsXc+ISjkcoYofZc8lKoNSdUYS/VYQYVGkMujBcIvF4nEPoXG7kuiZnjWCnXAOUtdfcCV8D+ElnYruXQEoY5NENKnwDjP/PkroHqyrrsVP9D+Xv+2kdOtV4nHVMpykR9J2VMZduHwvaKE1Ft2MJMyIFH05GbYfdNGN+9Zlp/jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V2I4hYAC; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV9zuK9yB+/cn0v1VjUefLcG2hGZifoKEFWLRbmu6eBTXGYXplo79+SzV4TU6+vRIf+EUlhzCz4vLwkw5nzH6WjttJ5BfLQPhQP9BLjj8KEcIMoAr9LG61V+C1u6dKkdkI9aU7SEfSJpOtgpC367YGrxYIeYMaTQwSx8htwduJ218I/dFUo3EKUdh+BDZOEboshGK9ov/0h9JkG0632gP9bJTYpCrYxnK6P6KOcfQjC0wNfRfec20jTyJLgEBVjSw7+A+rUDhP9HkbTleth3iySrlyggFMHmDNzxIbfLPeRa6Kkle15vE/fqZpPjoTM564Fpnyejupf1hjef5pYMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoEQAW4RhxJ5jcF+F1Gn+NmJxdNYjZGbSCja1E3D6S8=;
 b=c1jDtlIHg/p+iIdbkswdjPg4gBMxeASHr3ia+BQPV1Fww2nzvPjJggZPUwTgzJFHR35/3ar3bQEFnCyxtK21aLv/LtgCkIrPA9hdDgrZCsGmXQMy5aQZIRfNULCE3dJlDkoR6Y0WgU32r9JNm//QzywTs1N3ECrcFkuaNT4qN+eB8yCu3Ggy06fIXC/d001nUBakKmD+0Ch7fZCO6C0zRZXkbYdktsKa97ez7NvJ0OFfDwXvgRS0pKvEYM98zB2a/DLvqEO7nT8wqFqfxn1ePoWSWJXRftLF0lPOs0Vd6La3X8e6HxCn2hiDe2H5tOXSay2ROoKb55HlGDX1idnrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoEQAW4RhxJ5jcF+F1Gn+NmJxdNYjZGbSCja1E3D6S8=;
 b=V2I4hYACVa+HdAIttgQn+7aTnQb1newEcE6Ob6WIUsrXIhyY2s8IFw6MWSU6CSdthqmo5r9x+RYANK6fP/goL6wD1goPpVcW5zJB6sVfS5gVVgfLZXZ7p9NXdpJ6u4uZAPLiXKV+wkpCs/pBOONcENmnfPzjKIOdPYy9Evcxcb6HuUgL4stWAaaSzFvcbgXGilVIqW+vETNP6kMAZ78HRT6Vk6BEhhsdZ2Vqd8TDVzghv6FIUo8mhwx+eBgpi/27ktKVC90e4ogWSq1yjZAH9TU5RP6eaQENZPumxjcPmj2qZp0xQTBHj2ra4NWAHiEQSsomReXBwyfSybGxOi5A7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PAXPR04MB8528.eurprd04.prod.outlook.com (2603:10a6:102:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 11:07:59 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 11:07:59 +0000
Date: Wed, 13 Aug 2025 14:07:56 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] mfd: simple-mfd-i2c: add compatible strings for
 Layerscape QIXIS FPGA
Message-ID: <d7uflpa6tqhreqqbe4veqd7gik4p5oydonpc5nd5snw2bp63k3@iabo5bmcxqdr>
References: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
 <175395237951.1066658.3222139000178153711.b4-ty@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175395237951.1066658.3222139000178153711.b4-ty@kernel.org>
X-ClientProxiedBy: AM8P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::21) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PAXPR04MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2ce782-b825-43fa-e58d-08ddda59a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SAqK/ssKNQ+BwhX645Halfw1djFDGmVkgSsjEzeOVuaIN8fPVn0w2reVq3CK?=
 =?us-ascii?Q?xLxU7wmJjuZtXr9gMNG5S5fgrKjR0KK73PGi8K0l8+aArFj5Xpjcn1rZ+TFX?=
 =?us-ascii?Q?+OgdUTGLaQmkKM+d9dMuc8MtMRjHMAzpcss9lq3wjZM43NDiyi+JhldphGZn?=
 =?us-ascii?Q?A7ATlOcR3slNKxuwL72+rqnFumbRVOxVQqjKEYn/GlmfkTK3xHD28bU39NvU?=
 =?us-ascii?Q?DpJccu+i/9J8xtVjom4XuObV9QMOgVRJwcvYAPZEbK9J9k4AHYkSnBW5Umnc?=
 =?us-ascii?Q?eqYRIKAsl2ZZM0rE5BKEWnQtA1hnREHUfpkf+S/F34se7MsI7ZOW82NLnw/d?=
 =?us-ascii?Q?TT+qOPPUr8dbqgVgjh8FJzTi/BSXGvSZszocgq6Hz7+Fpaz1aKJ8oredTIO5?=
 =?us-ascii?Q?Opvp+fIuKdSA+Q2hfKn5HoR+jdwOBZFd9wl0orbPRy8qQyDKIDupyx4GlBMe?=
 =?us-ascii?Q?RhBFdvSp0C2ySnAFhsZ7h3GQ+2Sdzd41rwoo0RUnXIkWLQBTdVDsyYc1eejC?=
 =?us-ascii?Q?mMNf7vtJptIyJ9fXL0O4gTCv79ROEywPiBKVwLuQ1R8xi38GIzrDl9OoMpTw?=
 =?us-ascii?Q?loDRJlKZ84/dSN5qA5gVMpMdFA8BXFMU1UCnzWidud7prwnBTk9MXKAl+oFM?=
 =?us-ascii?Q?fj79g318z+hzjNR/JbY0D10byeqsv+I/EMvCEZ3YfNqf7OA+pnPzIshquVv6?=
 =?us-ascii?Q?ZbtO/pYZo3rrDfGUGA6mErkEjYUNdA/bZ9FtyXuR4YTAvZ+OfjLmq6D1DOaW?=
 =?us-ascii?Q?fUXFCF2RG3TOj2SJeAST7jTa7mhZES6/p9M085T6XtQqd1MjB9k2vseubL2E?=
 =?us-ascii?Q?gIRD0M2tosCDogiax+MGxW8dJ3S/5ICw2lsxIoqXeEFNNBCt5vVOPHqbpzWr?=
 =?us-ascii?Q?y21qdcomeYT1GGzkTnDVLLjiKqYMn0rDZuEU9+jd4c4lEFtCNzDh2Ykujc94?=
 =?us-ascii?Q?sAjvjvzv+xknU0VuCgJ6DXcj0pR+VSL0I4gfdYXconBJSClc+ggv2h+Qn17h?=
 =?us-ascii?Q?qvZ9l/uMK9XQtL/f+5G6KKb8r96kNeJNxQlEUA5C4PyoQYTbmMhrwIyvkoBN?=
 =?us-ascii?Q?YjgEZsMFE+S+QOvzsgLthEHq1Pg5X1Z3fOQQvoapset4ENEW533AdT59Nwye?=
 =?us-ascii?Q?HYqwfaQACoYKQEkRh7AEwFYZfeIUf8614aik5FQlQeEzjlEovv2eHoWTR5YN?=
 =?us-ascii?Q?dDWg0pWCVQE+iP1mKOapTwhbgjOmVhA5EcsQROGtFNGw11Z/VXz+EW+nU7yk?=
 =?us-ascii?Q?HUoChMik3HiHJRYufhO6XbA5UeD5xcIFHJ0uz0Cu4SORiB4TShF93lojCda1?=
 =?us-ascii?Q?/+yZ1JYPn7q9tWXEsl1LJQdsZo4yfptE3nx66ParEMDP6pTeBL6cARsXXScf?=
 =?us-ascii?Q?T20RLOQRvf5HNLXC1anOoSN+wsLKniQ1uXjuo0WM+3owBHT1DxE10rQb4spR?=
 =?us-ascii?Q?7yHhxv8iBm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZTPWqzYgcyO4a47HEOYxkmK+PDRIzcOlfXFYy5LNiIw2+9AMAJwZcpJQyWa?=
 =?us-ascii?Q?aRisGQcVKSx0ZEee0OjrnBCfHimcGlH3m6jWGs5u+rJKQbtAVfnVA+QJxgHU?=
 =?us-ascii?Q?UGfCD4X3z2mB6MJkSbWOYjSDGmaavm7d/ocaY6pZDXGPQTBSJEV5XZsYUtc/?=
 =?us-ascii?Q?c0zyCddhHjuPgEVliVS12UNZiTKSW8K0grfa16EHfgHzST8Ukezegwce3R8+?=
 =?us-ascii?Q?gZ/5eBZdrovgXaEqU+1adZ7aPV34A8WRZpK6MJvnTD6uk7reDqiminu0KawN?=
 =?us-ascii?Q?3uC5DSGjBdbqEN+anbOebPwzcjery8/Qe44VviT9zyFjcwNqo9o1yNcoOPjr?=
 =?us-ascii?Q?PO9L9leIAFNj6q4qkDrrpfjtQonHwMAOPC7V5FWZPVIRSHCdgqolL2jsfFDM?=
 =?us-ascii?Q?ZLk+SLJhG05rwfYp1UB47i/wFm8wxwFfEYHd0NYIPOR3x8+Cu273sRHTd380?=
 =?us-ascii?Q?yi0z35VuBtU9eQRQzDCj1tVfThL9S4WDWHHUN8bH29wVaR4otPSW/1LV3eRz?=
 =?us-ascii?Q?QRwf1pFSfiukUPAAKI8CZMf3C/eQKWyxyEV1CJsT3QIYCpuxUzCblxjiVTik?=
 =?us-ascii?Q?XduJIWJhwc2V3w0o27qxHt7mcx30sEp30FXcfjJDTtzkgmSalvkb7jkM3s8/?=
 =?us-ascii?Q?0BJhZKkAd374Qg/x66kC8QEnK+2TOmm9pxH8RnkLAjL9TCoAlXo9xRBt+Awc?=
 =?us-ascii?Q?wMPX5ZOmJq9WcmZrJZeiSCh2BXBbdXHbwqEBDO0CPjoob19ll2je3pquJ8QS?=
 =?us-ascii?Q?jojXEXXFJYtkVDgLMjrP5FBzonGMaKfaaTbOQ03SIEW8z0cpz3cPnVCQB0lD?=
 =?us-ascii?Q?LzjO14zAFMwKVo1xKBqusUkPwfg5hNTx7Cx2mRQFaanw9iQ62mBrmpUFlwJE?=
 =?us-ascii?Q?m7Qj9dFXfNQCHWN6l88H4t3KRKQbUYaFFhhxYFtbk0Q7t4uD9Jp7J+YIubCO?=
 =?us-ascii?Q?sAIeOn8heEhy4Q/a6iDhAJ6Vxjn0kk8tNMyO+CCqukvDFMGxUfNzDQDCeIOX?=
 =?us-ascii?Q?cwNJxKjJh8B+TSamI+hNL0pmvHv/L+zQsiFVsJ8AGcyqCNWxJhwKj82kjaw/?=
 =?us-ascii?Q?SJau9cUXR54db329unUzVpnF9uT/oWFAdELGZZqM0b7ltH9NWiZwC1dzjsF5?=
 =?us-ascii?Q?IypmbwIPn5QtP2w0voQDS1tyl6ucBno4226ayHkRO+5/e0hoIEKbKOpJz4if?=
 =?us-ascii?Q?C3vO4ZZ4iukNEKErNVN6O0p3SXOyW8PvUt7r8+yZijQpvLptnAhXxADtvutj?=
 =?us-ascii?Q?2WP/yVW4Rzj5WqbVhlnuBzFEt4cEj1JWU/wBNs/QmGNArdOU+Fs0x2sRion6?=
 =?us-ascii?Q?xgW90zj1AKrieI2SSP3klXRggOZuE01z1ehKlJnTOolhBnMdgIy4GGCXTXft?=
 =?us-ascii?Q?QG4Emf3gCIOFkGU317/6p59uiLo1AibmyCdnGNpIVoNPDiZDAzfloPrhIfBt?=
 =?us-ascii?Q?CJ2/gAN/dIqs10MlD22mLpz3NbMOTnkNkGDkE1G+ONh5FxmL5xbPgGlcGyF0?=
 =?us-ascii?Q?NVLigbf+6EFxDLUK6JKwL6W7O2zmvptwZCHkog2zVSgBsmv5vHMNR5FCu14B?=
 =?us-ascii?Q?6wJ7z3G4xVqo2tRDBKdMUtc0RznHtIID5R0+6/fb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2ce782-b825-43fa-e58d-08ddda59a9a0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:07:59.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqhEItWrvfwdKHueJnxrn0MocQWUZGC3yxMge2PkqldFcLHzUnRcYUozoLDd+rVIOJdofy++mgDfspTL8yjAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8528

On Thu, Jul 31, 2025 at 09:59:39AM +0100, Lee Jones wrote:
> On Mon, 07 Jul 2025 18:31:20 +0300, Ioana Ciornei wrote:
> > The QIXIS FPGA found on Layerscape boards such as LX2160AQDS, LS1028AQDS
> > etc deals with power-on-reset timing, muxing etc. Use the simple-mfd-i2c
> > as its core driver by adding its compatible string (already found in
> > some dt files). By using the simple-mfd-i2c driver, any child device
> > will have access to the i2c regmap created by it.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] mfd: simple-mfd-i2c: add compatible strings for Layerscape QIXIS FPGA
>       commit: d3a09d5e5ce66a91acfdbcf09d7193d2167b69c9

Hi Lee,

What tree should this patch be present in? I did seach
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for it but no
luck.

Thanks!

Ioana

