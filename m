Return-Path: <linux-kernel+bounces-858208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19CBE94CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF53188DB37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A0393DDE;
	Fri, 17 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qwgabcb0"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04B335074;
	Fri, 17 Oct 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712286; cv=fail; b=d6oc2SvL5IPnT2OfZDit+WRsO0/I000wb0jaZmzVXvYZRq5acT73a6MVXso5LglDn1OVPsc3B9UhDrpJ8RhwOwdsjPGag2AcWZtFfCwjDu3e9nIEZ+t9kTEaYv2hoZmJGv6QWO6GwV0pf1wmck0ckzuJ0mhlfr/8BDN8TGtiIbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712286; c=relaxed/simple;
	bh=t6R619Un/llP8zNQSsS9Mr61S2GZ/ATQCS5lJ/1FWTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBkGN5UnFu6d4NBtDUjYQnLKjjcVd4sq2evW4CMAGZPH0PnJC6+Ep/r1lfS43B3jgbAt94ajPWxYCjl4M/n3ildwiIaP1ODJt1Nu0htVi1ZBvAjC42k/WBEJKL3x2UVaVWhC2HYwVzBOMJGh/4IZukLl5cyZYpqJJGBtqhtyimE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qwgabcb0; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=motA2VISUGHNvFnlWkXlJGQQa107rlmiONMTVIPvpvLoVflXNxRkPBUBzEr6I9tHuDVFNdqmiaVAqZ+ihrk4TVAm+wLc5LBPDdwA19WdhEMNrY1sFoo3uUlr10J/IeDAfaWP6dB11W1SISgUnANeSrNN5KyDmf+cxxsWG7Ryyo4QFJ0m4PXK+xO8MJztNkO2rXE/Yi84Ggtp65SSdfa9E4xpsH07p6WaO95sapXO601KS4YddwzFOm58N/Sr2EGlPQ60YBMzGGJ+cbJLmws8u/JXSQmPp2iTaF33aPasgAacRjmpbmUG1RrD+x6uN0f362CC/Xc1w0SSRQXWQWegfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxF7rfRcIjbtKTEznRyvxt6lz4eb6dSpOqS0g8lXSkg=;
 b=ZZlGHt092sftXGuuo1DVkZ7TIQ8JNyX8dNDYQFXZ7o8zMIR/NQxqfYKl7LNEJ4rwC7zFhQdBYhpytjFDSql7V74xcJ6JKTQwrOJmWs3vmJQ89HBmC2hLWVo7+bIqoJhGZaW5+zS1ptqRLJAqbt11jDpuD/5g6T768WPWeOsrNx0exuDkXLWB6i3uHHEQd+yGrmLI9H0WFaarN/3pmk+flNhRrXO855LRf5sYD86bGNmDqVewBdOQ+GdjeEnQEkrKNccBI7WM1uFOjTPRzWnyI0VDKbza3+IaUANoS/Z/8zBaOqlg+G/sRGXBHwL7x5j1Z3xUjr5iKfae8uf6hKrDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxF7rfRcIjbtKTEznRyvxt6lz4eb6dSpOqS0g8lXSkg=;
 b=Qwgabcb0GzCicIIkWZljKGglYiEA0CJYWrYtjwVC05x9D2+juPUvvXCVaqUXEDD6NZbsL+M89T2UXUHeYznxHo5jfSxVMRjD2xo0CMf/HSGslUaq8W+EdAyB8XR8E4JLQneRyIRl0kK1HOUWOJen1dWS61jW9q3TMlcU3CgVB7EK97RkT7FymhfkpWVo0kK8CdQYG4sntTt2Bru8GnPYbujBGsAdATO7YiwmUTfjaBsgFJIZaQ2jlgWUZ9JgFGnRopIoNekYgJaFMK0tVlgUo5enCwjMPv02fIpNa3EEoFxM6S4OmpoxfrFyuKZNKPFGhfEzS/7st11gpX5Jj7Wm/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB11522.eurprd04.prod.outlook.com (2603:10a6:150:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 14:44:40 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:44:40 +0000
Date: Fri, 17 Oct 2025 10:44:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 4/8] reset: imx8mp-audiomix: Drop unneeded macros
Message-ID: <aPJWUDXmGkb8QGMz@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH0PR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:510:f::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB11522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f128546-338b-46df-3f75-08de0d8bb3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y7l9pTYkveThQ2hFsas67aXEheRGo6EbzidjaugEr/nveWF3O7e5A6iPV5SZ?=
 =?us-ascii?Q?Y5WcIZttEnFeCEklMQoogMqHSHgMP7nK6ruq8F0YIIePHBV9oCp26AYCW2OI?=
 =?us-ascii?Q?OnDEr9fb5GAUVd+tC9broTEjVjp70Mve6LFiPnIhzHHfNKOoTzH+ngjbAOkd?=
 =?us-ascii?Q?yXIXmSoQcS8Vat/CucnKTBolSGRFtupVPAfXMu+EJ4xo/Jgv4aycPjQWRaTB?=
 =?us-ascii?Q?nRNOJInSc5eoNrFyYjcOzoFLmgW/pAixTW4ulhPkSXt6goqDQe54+AHgjJ6O?=
 =?us-ascii?Q?GQWfr/dq+wQo9YTlj6bB6cLmPWVvb1U9aoHoW3m4c+F8Sxpue52pmVIa/wGF?=
 =?us-ascii?Q?iCQZVzPutp0KHQVMpiBvGpHDZ4/GIu/u0GcL4xvcB3FWMgJKSuiobEuwL/AC?=
 =?us-ascii?Q?HviVGIGjGfjQkF7KTpCEqRlzPjubaZedUJERV4J7YSYjdbJ13mYIze5uAb2j?=
 =?us-ascii?Q?hMSDGeZNbwjharv2N28ghz7J36/MrnEyN0kQ8vb7K4M1MBypMpLIa8A8GSlr?=
 =?us-ascii?Q?QS3TcXfxV+AgBKNNe32BQOIn6zr/GoHiaHEnNwHbTGzE/HKijtU8k4jHjTbG?=
 =?us-ascii?Q?fuJ7ccBj/MelxgHB7kRTeCb7upPHkLp+Z/1avHyVfsXpqooCLluaql4ESM8A?=
 =?us-ascii?Q?jytvopgIeUF9LF9lgo4AHoL7QNhKUipFt+GKKyrLdAfXZDAaJRkI5J3wQo+O?=
 =?us-ascii?Q?4msAfK8UetrkdXAIGM4Y8PCih/ZBQqEWTJw9noizPfhKzbZn9z1ThsA+nOf4?=
 =?us-ascii?Q?cIcm7JXQjAV+3doyV2e+4OrefY+IJ+902ILCs0QcvvOqb6GHDGM6yMj5pJSE?=
 =?us-ascii?Q?Su0ig9MOa7H7d7COLAwkzqFpDHsjSZcNFD+86PB51B2fOHmcYNks6VhgOhRL?=
 =?us-ascii?Q?UB/VObjaUfbNpUXutjUL6uCT3lOV4/tLFckNhmpnawWV6MWI2nJVSePDndiC?=
 =?us-ascii?Q?LGYR0ioXXz5HNKFBLJ3AGIzpkQSV/XAM+M/c8y3PyftPlbKKpZBOGrrC1zQQ?=
 =?us-ascii?Q?fPZix39ipUBfyby6ZcDN1zrkHwEG4LIH9DA9+5ZUZ5mCSFr2d48B4FOOI+Td?=
 =?us-ascii?Q?2RNfKV1UZhC8ZMX1JWCb37wgMjJRP+stR5QDDnBbrdmrhBTEPqLLXHSoTVSM?=
 =?us-ascii?Q?v1nQuy0JoSKoIGhd5veMilrYrEqKiQcd9c6szJFTUa8yaNYvB3OUScIxvvXz?=
 =?us-ascii?Q?0ZTwAUUaz5i3aufmjuMozpcH5gnNLwnhRSCJ0MzB6Av7eRvi/cO/u4J6Il4J?=
 =?us-ascii?Q?Dcd5i/Zsyu/bhNbRrFeq0I+cKuOiAgCBeGlqaPQYzA7UGwpOuZxWUeWomq6+?=
 =?us-ascii?Q?jFkCuDMJAxPjgNma8w+GvmU/E1EMaduvG6Nh3m1AhiqwFwB6AkINKNqVjRWp?=
 =?us-ascii?Q?HaHXyV63h5O/0geqcBR8tf+CwQ7Xk6+AhOcfVifX9s0Iz52o0UnjO3xAvp9k?=
 =?us-ascii?Q?cbW7jIr+N2rrnlHghK0eBbWabQeO68F4wzJMq0DC2Alj5ngR/y9VXFedPZ9k?=
 =?us-ascii?Q?yS1vPwqMVoLpMhg+ftgUxToavbSrFXcOpIZ6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uyhuijXY2F+UblIYJkxVaUoYZo/CtTiDlOtbTKC1jcaJ2EBJx8xFpnzYFAB?=
 =?us-ascii?Q?xP/JAGh58N46V0SkJj7+zzXGCORhPkhCJmItlRDg1hQcVd+yF15Dx3MmviXk?=
 =?us-ascii?Q?hmtCeeR5fU4MKUqaY245mRAp3W3chFXX9vAFXbixsCH9ZzR65znN1qsM2h+O?=
 =?us-ascii?Q?jHQ0DVJ7Sgmzr8x8bIYaI42Fz4bixBNFs9UT0M5aOlvmFd7dyvZJ7yA++gwg?=
 =?us-ascii?Q?HDkgC2d5rCP3YuQa7PeP0kxUx6NsdSyK0L2OJB4LQEadjFZ7Q5snB5aZ4A6o?=
 =?us-ascii?Q?gk1naW8T8+nq345SrrkK8PvifTGQ9qq4cFD+Hvl1gTBIJ44oPUGAUmSN05Gv?=
 =?us-ascii?Q?O0qXeLO6CVR5H+161damjVGuMTCUCRBEdCMvO/NjyDamDmVJvkt0dxFU6liL?=
 =?us-ascii?Q?8rulIzzkXGmSRUUJetdc9EZgVJVupLtsCXq+AOQ4SgzlWT2B4WBkvvZcvPf0?=
 =?us-ascii?Q?mwDByXE+j+SMiz7Hz3jKUEZZE8rK9JtseWUjymiKbt6qtyX1gn2Ouui6ubpX?=
 =?us-ascii?Q?v3no2XEoUpqMrXG+q1w3yqwdBYQBxu8RZh8ZUotdWZPUhb9ESs5eipHXZk3i?=
 =?us-ascii?Q?y0i6af5jm6APMUVAA5sJG58ESgpBMH1q9VuzSTlYRby5K0sy2V99RJMWkI/N?=
 =?us-ascii?Q?AnZ1pc4YkGDptDGXGyTtZkgLfgpMO5mNrWZo9ZIQ+M77oNYRXlGkuAC9fQdN?=
 =?us-ascii?Q?BGMFCrW9Y7lbWoDNjPeVWrqBA8N2PXd5nqacDZzlSpIOSdeoypkfHpOyl+Qc?=
 =?us-ascii?Q?zgx4boWFyvAkq4pEotKvRNp/1vIOLyYUOkvOO8S5cQzGnv9S+6T6qzBph2L7?=
 =?us-ascii?Q?5+KRJPRDs77kV7iZv/Eh6CwWhPhLTJ+yMnVq2cdK5zgFNVbBsJ8SYUJFUKgq?=
 =?us-ascii?Q?aid/dwCdw3jasqBM/Ri/nRly6tLhWjDD5ecOOOINQJugqr9FlQxu3KxGb1aL?=
 =?us-ascii?Q?rjat2aUqcX4O4G66z3hq8qkHO85+K2tUjXhUZY+3WJijWGS1NQIkDuSL4EUK?=
 =?us-ascii?Q?gRGSAdOd+q6yBoNJ4yPsNyPj9JsljnYRb3Fn5gGFzXwl/a3Ej5mdK8RXOu7C?=
 =?us-ascii?Q?mT37/C/JgcP1p7NxaqrKesrbAPvTfPbtlxrblOGDeT/NlWwMqO2ljFvqgCrf?=
 =?us-ascii?Q?HF9+xpUrI5fa9jmZ+hFOfmV8l4XaDehTcE6//ozwbT7aqev42Q7JUbsTtS5c?=
 =?us-ascii?Q?P9ID/Ih/tuxHp4VHUM5XXu49AWtGQvqFieXWh3EQ+E5xRgf+h9ZotliFsUIN?=
 =?us-ascii?Q?1ZvEiy1hIXFcZNf8LyfQUFb009KtKwHyaYMeDFIgsIfNLrekaRwFoZb3Znbv?=
 =?us-ascii?Q?Yz2Z4gv/20UPgTxYSz4bsnKhPCuyLCVqOEUjnZDEyDB8TKJF12DqMh8h8WxY?=
 =?us-ascii?Q?knxWK9VN7IAW1Y9wQucM48orAzf7i+5++BJsLUgaAxHmN1G8WmSxmlwc//K3?=
 =?us-ascii?Q?9J4DkLr0SKfBGe6ZS0mXMdAJT/twrtvM+W+QfK4QZszMGDxvz7Ethtd9ryl8?=
 =?us-ascii?Q?yOKm47KIeln6W2B9SoLxj6SpRyAh5m7x8J0VdjmIT8CbLh6dMxTt3553cCx7?=
 =?us-ascii?Q?LQdLPU4c2t0HZSi5yUU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f128546-338b-46df-3f75-08de0d8bb3e4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:44:40.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zTTkZr/IGCPHWQQMWIx5iFShFQf2AMYerq8oEVcJa5CsIBfbeoPqLMj4dnH0MB8zmeh0YH1dL2WtHXMOoLSAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11522

On Fri, Oct 17, 2025 at 04:20:21AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The macros defining the mask values for the EARC, EARC PHY resets,
> and the DSP RUN_STALL signal can be dropped as they are not and will
> not be used anywhere else except to set the value of the "mask" field
> from "struct imx8mp_reset_map". In this particular case, based on the
> name of the "mask" field, you can already deduce what these values are
> for, which is why defining macros for them doesn't offer any new
> information, nor does it help with the code readability.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---

Register define still prefer use macro.

So far const string, hexvalue prefer use value if only use once.

Frank

>  drivers/reset/reset-imx8mp-audiomix.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index eceb37ff5dc5..e9643365a62c 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -14,11 +14,7 @@
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
> -#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
> -
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
> -#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
>
>  struct imx8mp_reset_map {
>  	unsigned int offset;
> @@ -29,17 +25,17 @@ struct imx8mp_reset_map {
>  static const struct imx8mp_reset_map reset_map[] = {
>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
> +		.mask = BIT(0),
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
> +		.mask = BIT(1),
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
>  		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
> -		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
> +		.mask = BIT(5),
>  		.active_low = false,
>  	},
>  };
> --
> 2.43.0
>

