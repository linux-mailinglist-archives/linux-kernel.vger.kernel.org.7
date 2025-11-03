Return-Path: <linux-kernel+bounces-883270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7AC2CE35
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0924FB4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2173191B2;
	Mon,  3 Nov 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgQvNtJN"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E71F3B85;
	Mon,  3 Nov 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184390; cv=fail; b=cuqAMaZeMsSgVNjPi5/YW0OQdzcyC6oUdgHQUuOYPc5BRn0sr0UvEbWK+ULiCGykfqnhDs/kQvRzq1zN4Q/nk5FHVYEfyuM3j8Zejvl15vxxjOPQsgM+sHyCB6RdpmPfglnM7dpmRM/kLkRE5kA19WvGrUXqawEYuxrQ+pMMYFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184390; c=relaxed/simple;
	bh=NuD6GDr98ghxhoHAgqX+aOg4cBtG4hWNX1uPHOSL038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kN9uOFi2Fa0zIWQEOfZBdl74t/MT3eTxNyIvqgDsfoTjAMugwrZSyA+sibjYHhneimtrzyK/kNkAqjMQorjmHZQaqFzwcF/v/U7yoDwwRxPK7XMNiucyvHim7ks7RyE+I8vpgIF6KaqzPZ+EDTAH4932rX/dzFoKDvU267ugZDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hgQvNtJN; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXQGrwcDAdNV0o+SvM4an2N+Umoeerqstj3Pt03b+iK97gv1oltIHqa3O5eYi2wtnfVtr8o3jF3Yyucb3bPib1/+rG63NL7lBe9fic2f0QIkXyfLff0cc1FZoBD1TTeGKHxrtvgLo/3+6w5bMdmaXKuLkCBWR0jaJRzIONg3l+MZxMTLYylABc1aURsgPH2ieXhOrhuWgt12WKhZbtDGRXzyNYdRlwTCod6MWNW7CvBcQeYIl2lBMrwkPgp8eZ4M2i1pnfx9RD/ZhliDW6rcrxe361ykLbzggodZ0g47rPUtSHNJgCjTzocCd22G+Q0ZZ877COSBqrV+Ar+JpjPOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IlLZDhLEZ/3aKAfMUA0MgDfonO+/FhXlRigk1DHXF8=;
 b=CcpB09tAppKDXpGxs7wRR7yY9Zg1hMTtpqm+Sc/aIRClcvtZEenUDSs99ESglks39O+OHoS1RxC2qHXif0BEWapJYvDEsCDk6lfHEw6RdY8o3KqKXH5qyuh2Fn/uecROsAXJRdgiICFwmgd+u2Yme5wfZwlJOsSs4IEjHjStGe1Bi5qORT+e1gPziOWQqTOGuXLB5+CELRtNHRNGkTlEjRGdhYmQIgvfcPRVizFyJ5xWQv0jYMib0we195Sra6wiI4HhMcDHLyC8tb4dUuNz42PnTlX2rmaIWXB5tD9lzkQN0z+fiPqOyA0NCiIVt/7SRRLDaPMEo6qLvNUj8Or4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IlLZDhLEZ/3aKAfMUA0MgDfonO+/FhXlRigk1DHXF8=;
 b=hgQvNtJNQCKSSeTqH02BxUrUiz7Hws7mcUiCasOxR7uKpTKTjfs0kSMK3PwnjpNOC2XwCKwcI7RTHDizrmv7+TSJcGEusl61/6letMgF5aWbrax5AlqBtgyoOiXBaDs6J8bAclpycrjKHlk+fAbzq4MW4VKthCHkLxih0v2Du3KTI0+M43Ch/Lam2N2Flq+j/PPcirXJUhpqeGD8BZVWTDYt7xKFgE2b2AQowstjRMvCjePrTXuKpqdoNVPsiRWZzl2xVxYgwRLs7ldfdC2V2cLZxdLutAofOTOH77Q4b3h+kVUymqLWByT4bCyHKHfO5A/cqWKCJBIrii0cdiRj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 15:39:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:39:42 +0000
Date: Mon, 3 Nov 2025 10:39:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] i3c: dw: Add runtime PM disable quirk for Altera
 Agilex5
Message-ID: <aQjMt8ba7+7emopP@lizhi-Precision-Tower-5810>
References: <cover.1762161408.git.adrianhoyin.ng@altera.com>
 <ef57accb1c4e7239d27d04b24fdf412b8cb977b5.1762161408.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef57accb1c4e7239d27d04b24fdf412b8cb977b5.1762161408.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10349:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d61b2a-a77c-43cb-5ee9-08de1aef34c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E103YdiCN+10UIFYB0X5Zp2S3ad8+RSoRhmH9pSdWumuzd6pzgi3djHNDuxx?=
 =?us-ascii?Q?yaI+TjIf+6HeWmqpjG2tibzBw3qvvEMxs7qIZMp5KKxV5j213ZkDlMXVMROT?=
 =?us-ascii?Q?p+HvV2xoSRy/r5IHbCMk0wMpBtmLyoAwtiGxM8bGZR366SpEMdUgmRxz9AnR?=
 =?us-ascii?Q?qccBYgDW8BP5XRJsGSACeQbwMxnnVHxFT8EtY08m/RtV98SlTKeocv2vwmWB?=
 =?us-ascii?Q?fS28dUbSNbUL/ifXG2fNeTZfreSLwAcx+4V3BqMqIJ1+vk7US9ZqgUCDPofe?=
 =?us-ascii?Q?hBhvi1s+Qdj49ensAoSm7Mkv0UXUR/JYiSeifmb86YjRUvTYOofNLNZ5UsAf?=
 =?us-ascii?Q?V3ktmLsfYjLyKX+FkLarBAOs4VKLRbNXe4E/x62XVvfjvMbMl46b59B5sOwf?=
 =?us-ascii?Q?yJspFneEBY2+5rySt/dP25EtVZQ8D+yMgQ4TFeYtbXML6nzUciYgmfq2LmCw?=
 =?us-ascii?Q?TVyYaokUpSjURrty2M6QYma9XrSSTlhP4QgKG7Hwnc48zFwaeU7SL/SkKtMK?=
 =?us-ascii?Q?lXReqDlnIA1IimzFVkYO4TE65Ei1Pdj3fG5l2tBr0OWg5wczQyy8/NRWx98z?=
 =?us-ascii?Q?/0+95eTHpmgxfJq3zZhpGWC7juqKcq5bTsRZT4uLPSJK08IEEB485Q+/kF9N?=
 =?us-ascii?Q?qG9XojH3STyI7W3pCAUrw3Dk2mqfQv7EPZJRS3yd0DaemwA0iRWA7nSbwYts?=
 =?us-ascii?Q?IoSN2IwN9O8zxkIvIF6Xy5z9B2Wae/myaEk1x5rGvhPCMaEjwgSWFG8DWFDs?=
 =?us-ascii?Q?1SC1VWpmegciqQSsbqrVdpI0B8ZKrZArEfh4QoFg654vXvIRCXNowHzZcbw0?=
 =?us-ascii?Q?bYOub0g6CaNA57N36thN7/RH+CIJMVhXdPtQjKurzOndbtXihAtRDQL0FsNi?=
 =?us-ascii?Q?CfikVRUN7zdBL/ixoPSBWsdZe5hSZ1iZyBoExNm4YtokzcBGNJa+fGUo/eK7?=
 =?us-ascii?Q?Ij/xlcqfCAmM0QNJCId+5UXY5BDU0Xxn+S8/ZDCQetn/TABE0KlCMBu04wrz?=
 =?us-ascii?Q?6V3/Xj+P+CUZVvKsB4/5RfVeEvwD1KoNPUJdnqQQHs7f7PW/iV5is2Mepmwo?=
 =?us-ascii?Q?EKvEaTBy0pvvmcbNxsI8q0Irv35OAJIxwCj6H3b66IofLFIiCm98KQs+gREY?=
 =?us-ascii?Q?frizcOuBAD0qG88t+DzubJea5/9stRpL39fe96Aquhp298taTsCaVZfUJxwX?=
 =?us-ascii?Q?XwmtQ1pubBNu7mOeOX6tCgHgNk9mKc2ndXP+vTlRf1IeR+b8vA3O5miXuUq2?=
 =?us-ascii?Q?RFTfLYeGiKqQm/r05b7hiuYvR9biUKvg9Wq9tLBVz3vRg6k4lpoLd+Pgnpfr?=
 =?us-ascii?Q?0KtB+XXqe+e+6zR7RL/0Vxnhh6dowf53I/m98Ck47cWiOyHKeu9uvSokda0+?=
 =?us-ascii?Q?3ua8X11kTnVXGIWHZWNmBGgJIPxn8p3Sw6wzFknYDpMCUhOByYmwwlJ0H5lg?=
 =?us-ascii?Q?6GdbAiTNFLG57afVnzD+hYt5RAwg5xWf3pmSTIUwizC4LnjNijNCRDdwDxXz?=
 =?us-ascii?Q?Q3toET9vs8nhFF4QSU8B5GDDgOCnKgQHt9DF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qd5PAbbh5P1E2+Wok9jRke8QYo/cWzh1KWRXX6xue7bb1ntyrAB4NxH5mSdI?=
 =?us-ascii?Q?Wm4ELC6irj5wGjryStQX+U+kcyFjOqa21O2vW302GCOOTUBsaYSIlBCikz3X?=
 =?us-ascii?Q?pWj9PyPj0FyjqzpXrdQ4j+GU3FOHfRjiaVtqxzwsV9twCqLPwLgPZiKfzR1w?=
 =?us-ascii?Q?1SSGhehGF5lWzbqxrHf/j26JKFrmjbrFX7UPOZEU+QyKolEF8SFbGNQOMxm5?=
 =?us-ascii?Q?GC+rESuFUJ7eA/rZ4p83gcDZWl6Rd7cC+I15yqHerTMEeLVOmcHUfa0AOUo6?=
 =?us-ascii?Q?y8TigbK5lFmUlfaqpW7GN/44pcRC4u1AOA6hkN4+hGZ/4F3MEuzyRUaYGPuQ?=
 =?us-ascii?Q?CDVluymSG4+V/khKSJc9T5pc42IgFg6OycYSQNPPOrnOTbBe/k1egHV7v3U4?=
 =?us-ascii?Q?SeOnpxOToeEecw1G54Q8xyCKsIDEg+H7upDRYotSKmWdKpbe07lj58qkpoVU?=
 =?us-ascii?Q?0nEEbLKxnF7B3Ybbwm3tNAopxBoQFEeFAvY5llu3h0YnadH6kIIBkfFoJUHT?=
 =?us-ascii?Q?NYgXCSixvp4+qBpEbcwiLEtslOLdRtr6Am2h563viKgd935ilwJ89CEBPVCF?=
 =?us-ascii?Q?9LxSJXnoRFnoxc80j108Ef7y0ejQc1vgPKw8M8WaPV2emOuFtGPwqY8dsqEU?=
 =?us-ascii?Q?yccZXNttwkASvUivt1t+8KQ+d6RWMpovkrCNjV/0QHIp1tlqN9sfaZJrSOiZ?=
 =?us-ascii?Q?hP62nt07FMX2/SJUVAcY8j86xTFgcDWyGvQOOPsSEIjWeCTeTiiANImJ0nKK?=
 =?us-ascii?Q?F4lpGaqJl/XmF9rkj6Awtx/BZJCxOVf2lMD7igk5tX7rG7PQ2z019h8i8U8A?=
 =?us-ascii?Q?SUa4TSUU32GWNKCnc/ayKh1uCtMu9XqXedT0bY2nV5v2Igz8hss1AMSONmpQ?=
 =?us-ascii?Q?I0XGm3TCn1JHuX5osIT82dML16ce0ThhBO9x+1g9hE/qsFWu/lcV+IesJaC5?=
 =?us-ascii?Q?KQBWE7So4SUXHhBlanozNG4sfKEZDGfVpGOgXeosOqxZnDTALRrIOrXoOe+3?=
 =?us-ascii?Q?bq3WXsPs96oYDI7fZvf8CsxHdkFqx2lgMaakkXdmZeWjYyduIupd40P3g1XE?=
 =?us-ascii?Q?yPEaKKwSV9XONwmnSG/0xbaZEEdXdkhXQ8BB72PRRaHzhmNgCsyU2Jqf/8fH?=
 =?us-ascii?Q?yNWPYJDw7GugPz+SLRRJ2Mv+NnZXAg07fJSpdpbWNbXf1lyYsarpUZC1KtYN?=
 =?us-ascii?Q?uNKOHic8daktrJnytLdoCuA8mN2Qse9BOjRqaVwUxE0Rb2gDCt+5LqYiPHTk?=
 =?us-ascii?Q?p9dRkA9BDk9Eer2WzQg+alIb9UmVP8qid99pGXLpCzaobFYUtbCiwm5W26Zt?=
 =?us-ascii?Q?D45k6w4+jDGrvAh2SexMkJJO8bYTQWEBPyG9bAIVi1/C3aiZt5Y+4XEbL86g?=
 =?us-ascii?Q?NVuDeDqX6OUqCjkZiIpSxoCo9w8JmFzJ/Otqxqr3wO6V/qTZTJkZrV4IdZdd?=
 =?us-ascii?Q?KEZ1KCNQKzK689MpgLZVkSLUvhHYfPvixhMxqJ8dfDRln/w+wh1sz0eJdVts?=
 =?us-ascii?Q?+B/1hwX0+mjwo834u1TJA30ElapXynGzrJDlCeAK4IpQHx3szzcrVdwFQRWi?=
 =?us-ascii?Q?oxrY+QEz1/rUbkT5ZWpywXsbw7wa2/H2qU7KuGpt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d61b2a-a77c-43cb-5ee9-08de1aef34c8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:39:42.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu7gSgcA5Z3bQD3MQbsINxC/hId1Cdc4jqqNTRMX6+wfYVnCrVFxzNdz0BTKEDWK3HgnFqyi1dxqqewlyadjqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

On Mon, Nov 03, 2025 at 05:24:28PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> When running compliance tests on the Altera Agilex5 SoCFPGA platform,
> it was observed that the I3C bus could enter a hung state when a slave
> device issues an IBI after the DAA process completes. This occurs
> because the DesignWare I3C master controller enters runtime suspend
> once the DAA sequence finishes, causing it to stop driving the SCL
> line. As a result, the IBI transfer cannot complete, leaving the SDA
> line stuck low and the bus in a hung state.
>
> To address this, introduce a new compatible string,
> "altr,agilex5-dw-i3c-master", that applies a quirk to disable runtime
> PM for this platform. The quirk keeps the controller enabled by calling
> pm_runtime_get_noresume() during probe and balancing it with
> pm_runtime_put_noidle() during remove.
>
> This ensures that the controller remains active and avoids bus hangs
> triggered by IBIs while maintaining normal behavior for other platforms.
>

suggest commit message

i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI

When running compliance tests on the Altera Agilex5 SoCFPGA platform,
the I3C bus can hang when a slave issues an IBI after the DAA process
completes. The DesignWare I3C master enters runtime suspend once DAA
finishes and stops driving SCL, preventing the IBI transfer from
completing and leaving SDA stuck low.

Add a new compatible string, "altr,agilex5-dw-i3c-master" and apply a quirk
that keep runtime PM always active on this platform by calling
pm_runtime_get_noresume() during probe.

Prevent bus hangs triggered by IBIs on Agilex5 while maintaining keep the
same behavior on other platforms.


> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..5913822648ca 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -228,6 +228,7 @@
>
>  /* List of quirks */
>  #define AMD_I3C_OD_PP_TIMING		BIT(1)
> +#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
>
>  struct dw_i3c_cmd {
>  	u32 cmd_lo;
> @@ -1592,6 +1593,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>
> +	/* Keep controller enabled by preventing runtime suspend */
> +	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
> +		pm_runtime_get_noresume(&pdev->dev);
> +
>  	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &dw_mipi_i3c_ops, false);
> @@ -1617,6 +1622,10 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
>  	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>
> +	/* Balance pm_runtime_get_noresume() from probe() */
> +	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
> +		pm_runtime_put_noidle(master->dev);
> +
>  	pm_runtime_disable(master->dev);
>  	pm_runtime_set_suspended(master->dev);
>  	pm_runtime_dont_use_autosuspend(master->dev);
> @@ -1761,6 +1770,9 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>
>  static const struct of_device_id dw_i3c_master_of_match[] = {
>  	{ .compatible = "snps,dw-i3c-master-1.00a", },
> +	{ .compatible = "altr,agilex5-dw-i3c-master",
> +	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
> +	},

use const struct to get better extenable.

struct dw_i3c_drvdata {
	u32 flags;
}

const struct dw_i3c_drvdata altr_agilex5_drvdata = {
	.flags = DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
};

...

{ .compatible = "altr,agilex5-dw-i3c-master", .data = &altr_agilex5_drvdata, }

Frank


>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
> --
> 2.49.GIT
>

