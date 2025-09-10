Return-Path: <linux-kernel+bounces-810506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E9B51B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EAC17E7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB9322A1A;
	Wed, 10 Sep 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/eNaZ+d"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39731D386;
	Wed, 10 Sep 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517920; cv=fail; b=XaFUM5/l92EkjZ6L1M3DudVW8vkJ1N1sDUWH3IYj93hktLh+OUaCXiwJ8eqJM3ExHnEvLVTKHI+6Zavy8CKfyNNJm+rvc9umw0bJhsAGIlMSyj/Hwc0KhlQztTuW5RdPkJVqf/nZfUxV6+7OuLZrdCNjdaoEug1w6TVs6RvjAXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517920; c=relaxed/simple;
	bh=0d7wdEChV7idboDeb0tyFKqOn+9/miDYT/1N9bPF94A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c9kyBq+fTfoXUMq9gZoi+LboOsA1+C2JOFFJ8nLOQBcP3fewjdB5BiBuupy7s7oGx6+vshbFTOdO39vHm1T2tb0zXWfLtgnXVxVckC/UfNE5koye23+fvpikaabchIOvmK5HBWa56ohVRAyvWWKAkJSVV6b0J8vJm3QfPdG58zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/eNaZ+d; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISVyYwpvxIWLZhl8x50LSvUkSjc4WR+MpDYqbl/3M977gO1ywNAY2FO7idlCorD2jdHVNe/lVqIiXKhFziEKINCl51vQ0+ZdR/WXXzqPUTzHsj9KrEJl67N39vMYERk5IjdrHAY4gH9WUPzfG8qNvFkGr/Xf0Q8Ea8UxntLBWAuzJo7jy0GezPuCpuFh/erJkEpIYPmbiSiHKQh8vYMzzCFxSse2uGkTwYPB+Q22YmQy2td389UKBazIYIzVERPA1EWGNGMo4aXYShYyJkKrigoVdp/MK2zj7aVn7hBMoAGkYtGdHAlCflbecNrUi6A0qJH1qY5rEbnyWG5sF4Exjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6Y5RI7Kln+YEc8OpxqtIZn1/EQxfICTzb7RkoLwzU8=;
 b=RJc0nYjWwo5P0l/AYCGatACk8Y8loiD/YVVuRtRzm2S+Op7li9eH88sSPq7/vsJzWgAFffhcA7LHkziEWeqE/eedpWTGWndsFVRUr+BKqGUqsmqhWCBitr7MLfoBIV/PPY7pOMA32tR095P2ON+nMF4Df3EfFYcXBt7CY6iO6k/mEpwq6HK6Gwgjy5K6qE8GT0bygznQquU8Sq3wk3S271iQ/Cm3Xz7OHhrRhMiwK+o9oGvZICMheOQaW2WNn7n+KKw8RBWgpbLMFFppOgWU0FL+csC/lM7WBaZeMXRmI315lJbDiVdHAvH/1kNCsSgD2VvcklB6/XvplIV+33Mu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Y5RI7Kln+YEc8OpxqtIZn1/EQxfICTzb7RkoLwzU8=;
 b=j/eNaZ+dpqKgy8QWDNxhLK6Ni35cdDhIi/5JUuLvHETkXq6hqO1dj00FkwFnM4mfH5TsYV6hyfqoYMeKBu6DWjZwmM50YVmVYp0T5jP/Fm6GoRZO4YySd2dkuddB6iFJXBrUKvUB0R9IwxMHG6YPM6d5XoU/ctV6w/d9oFvEY7R4jEFnje0+GoySc0Qgae8F7fgEwejceOBa+tnXegensHEVCvlTO2IoUMM4Db8uhQ/T7jBW047IOEPfNI2JkxkZc5QOjivef82bPDZztgLA60Uoi37OVFBiE/heS9DVDCmDdfnAyOqhIVpr16JzpcVHGJQFmXXYe9xtV27pxGFWtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 15:25:13 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 15:25:12 +0000
Date: Wed, 10 Sep 2025 11:25:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Message-ID: <aMGYUALGv283tnV7@lizhi-Precision-Tower-5810>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9eaa6a-9e27-4df7-c069-08ddf07e3c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSowDCa4ETQohbK26C9A5pjwfjA5EnXLIoDDzKHovqHs5Cm8smzKHmyTPig6?=
 =?us-ascii?Q?ucABkTKifRPRw+XGeGTfvnRaCNG0p785mQv7RbTrLkaVcSD6mfc6LqdY2qhk?=
 =?us-ascii?Q?p2R7q2UsRXOIw908QR7SQd3lejAgfPMgPZjz5iKbc/vydrTv6QVvoJuBtuOE?=
 =?us-ascii?Q?GA0z6KEidbLZNlSO7SMdOlKTvXlFowHSkP0nB5dRR5OeBOOm/yveYZniWzcp?=
 =?us-ascii?Q?wapnWiFrUfTnE9IWjvUJ8cRJoB9ROlTLHwXT6qvG1ITF57nuQB3BjlA/9lOj?=
 =?us-ascii?Q?nYWode8hKlqQyUoMM4U7RZ2ek1Lp+Z3CkQHXXVnio6XHu9mY5tpL9r9DLlcW?=
 =?us-ascii?Q?3EcojZaJnYCx00ZvZmyEaksVHL0Ll+FACy28oAOY5BChcfEH0KC0uo/W9bSb?=
 =?us-ascii?Q?y+0K9LhsPvvFBFnwnJ8Q7shgkmjtmXwR/CgsnayZeH7KSmtTFpW0x9XJ0Mu5?=
 =?us-ascii?Q?TKeuJSPpx+AtEsbA1FQ6x5ow2d1MZM8qAFlaYtYz/BaefSHKb5BTu1+7XC33?=
 =?us-ascii?Q?KWG8PCVlO41OkGObr1EI0sgaAqZ8PV/iCbWWaJ4Iefr9CdJ3OGmLnBpaPnNr?=
 =?us-ascii?Q?cWATNY5dSw9kJEznkFJMYI/M6vKBmeWhh7hICvdDOnSXYmBV9TQjYtKgvCBI?=
 =?us-ascii?Q?tQKT4vTfPQNjOUfdbCCxRQUaOsfMKwu0HT3LYpcV2xqj/yIpLbs6dqbJhw/6?=
 =?us-ascii?Q?rMK5O4LtYnLyhWqX46SPZMNVI2vyUsVaVk5tiqnoBsFMcV2xUXdv6Yk+tVmD?=
 =?us-ascii?Q?hMi6H3v1GNNkWFehQdZZxM6eKVKJ5NRkoBBscpyCtg2BPTfZotzbFGD5ECTw?=
 =?us-ascii?Q?knvdLS/MHqHmJ5DM4NXPoAjNsc5dmPZc+vjQGEApz1OjmfIpfuWV+ptnkJ0E?=
 =?us-ascii?Q?URV3hCK3M0NlgxM5NVNk7VMV1++hzWiMN1UWbE3RGX0J1f6N2rkYB8DCp2m8?=
 =?us-ascii?Q?0inkIGwxSfE1WohhAcSu3Q2hsJY1Q95CzwOXrU7SHkudTm3BgeJX6Bbx0T+i?=
 =?us-ascii?Q?uoYfLJJdAAOZxlg5p6ENIcn/7qj+1QKCAJF4keSUkorAg0OIKpmjSPcGyyvj?=
 =?us-ascii?Q?OyNkqjlqDr4CjgTfH1VUHHP5Dk9JMF+WVtpgRHuyGaDAQ7N13Onsja0/sgmF?=
 =?us-ascii?Q?2EBwnM+gQ49sYKejMhjUVxm6u5Ac99a82gzkix2w9LwofNeaRE5f3B0L6aha?=
 =?us-ascii?Q?ZR05WwhKUX3stH5UuhejwJQgKS0lGNe8WliKkkHp4vPceoDqFoLJUwuJ32lW?=
 =?us-ascii?Q?7kiVNYCFVHUTJpEg+ZVcK4dcq5bUtn+GEVrZ7/pefYAVBrZo+fENmMnLI6kw?=
 =?us-ascii?Q?Yq7+KaMHIctVqu7um+tFCd2L1Lo9yhqswS2JnsAsBAaY2yt8h1/nr3tVDJ+8?=
 =?us-ascii?Q?UpxicTQREwQrwed+kwyxckdigLcujWv4dqcm7igQzwkn+vL7uX2uq3LtZerj?=
 =?us-ascii?Q?2HtyUiH9AWqQspEsn33moyHdvLu5jj9Eoq0c6g+z04/bOYKbPPJjD2Ubzvyh?=
 =?us-ascii?Q?E6YqmIUhI1RvENA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTubacjT3+Vna37dWxHUm91byQdVzzD22KycUg2ddt5LZCURxx8+ORZkjW6u?=
 =?us-ascii?Q?nk58wZYl4BDE4GiRTU7SGcPfLheyL+Q3UwZjIGQ4cbFgHTWNm0VVQvxr1tb6?=
 =?us-ascii?Q?Kiu5b/27IK1FqbLTujmD2AGW7PvHHhWPRmZtpKu0vvox5Z+Jo2NdfGCNYfVG?=
 =?us-ascii?Q?eB6c1oICxwsREQgeAel34JwAcV93oi74Vwzn2F47xTZgflwTTrI+C6WCuwtE?=
 =?us-ascii?Q?RlA74d0Hbwl1a8eHHSuCD5DF6W1iEObty9PwSrv0AfsrKWqMZH0HT0UNf2g0?=
 =?us-ascii?Q?ZzJWw0+ecvdS6EmSYXdfmAZsD7n8EsUH0trBw5udO9UMy4iiFAoBmkl46+n/?=
 =?us-ascii?Q?RQgBLBvqf4dq5XsR2HvgStvgE+Hu8IaiJc+mh/vFII8CqcdVJ2VpyyOPjT8z?=
 =?us-ascii?Q?BIlUDXRPbvcPDxJ8D4bcA9DpE18yUpO4v5kxQlE+sP9NNNKsTcOHd7DDIk9a?=
 =?us-ascii?Q?xYng7RA0kkaeqBIJsPeIZuoRADKWVFbc4yNXbPpB0b6stauHtpX/jUF1TRb5?=
 =?us-ascii?Q?jflfGFP7E9kOUFURCNX98ST4qnRvQ3Czud8Vl7QMF2efHY9l7mG1NabCFwLa?=
 =?us-ascii?Q?LKQngmARSXsjXMxqFtTUk86UA93RPUoxvQeRAZtqRQbg/DD5tc88lbtUU7ef?=
 =?us-ascii?Q?Fn9AXa2HgjBZA0mmwuN1gByHbzvH9mOKs3u9My6unD8X6KfYS3GzEV10MEPn?=
 =?us-ascii?Q?DF9mntAgMQd+Sr7bsZfwhkQx3PjO45Ro/IKYW8lQS2XHZjJTFqbMn9ak1wMa?=
 =?us-ascii?Q?wo2GfpvPO2kAR+nfm3ZdlSNREBoYecMAjeHy55wzy6NAk1A1GjzlNxzGElcw?=
 =?us-ascii?Q?+trxuwigSGTfuXXaNuMUnYTDBjpaLCXCq4vojo1U3skNO1XoW+YHw6v2pVUc?=
 =?us-ascii?Q?kGmn5QZRa4b3H8Hplgon3snyODMAkG4QBzA+XdjkM1Nw9x/nRV1zMku9o2P4?=
 =?us-ascii?Q?TQpwhW5aw4KygQGDkIvhS5zYHcnpB41SdIjPsroOrC99dMGkZVkEoNgUgwr5?=
 =?us-ascii?Q?CBNyPeiLcNnFmMoDG53sVRD4kaFLZ1X2FRAY59HZ1Dl5IxetGWwyHv/t6kVk?=
 =?us-ascii?Q?GOWcO0ac6ug27lHQFSPmEyWQwtNJiiYbSPB9A3fbFoUQqCX2dWcspF++V/CL?=
 =?us-ascii?Q?ijAqghHFQErEt3zE7RgGSnLgOH0dj6J0YeEBASix32zTGHNp7d96YcTZaCMt?=
 =?us-ascii?Q?AgyRCRe1jev+cKdFVFHKtO3pFXNFBZZIyXxf7Kh/LYcHxDxIiuWxETjBjrSF?=
 =?us-ascii?Q?XANgPbKnQIjgEV7MrVP/HtdZltKtxrubtEbydGD5CACbkZEkYb1z7RYm0ein?=
 =?us-ascii?Q?Puz9PpG/NXD9NdwWfIlZk6SUjqzSXvFBzQWTaOyImVnyuTwWQW7cI1ql2KTv?=
 =?us-ascii?Q?OSBE8l5JFYuIRY/uKYtOZw42DoKWnKsS7sAmk4h5eA/NN6DCktNRJ6HwE+Pw?=
 =?us-ascii?Q?7MbBE31N1qy+HTgvvDq3nV5KDuzb+k8heC1keJYACwx0YrE/9MED1ZIDxjig?=
 =?us-ascii?Q?CuF8xctvGR0aJT65H6gDr/Kp/MZopwYKP+y/NsK9+6fF+iHz1rpXyqxVFkWw?=
 =?us-ascii?Q?kwnzY/nQyCEUpH6FRF8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9eaa6a-9e27-4df7-c069-08ddf07e3c6f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:25:12.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVBUYweM3WvCmK8ZHYiQMxP36saA5xKrXeE6BptkGLZklITe8gUnfr04G4gmw2Pn5RTseAwENP0/lOOj0+4u6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678

On Wed, Sep 10, 2025 at 10:28:18PM +0800, Peng Fan wrote:
> Add debugfs interface to read System Manager syslog info
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/sm-misc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
> index fc3ee12c2be878e0285183e3381c9514a63d5142..4678d76b7dd6907533b5131c15ff0edcb66f43b2 100644
> --- a/drivers/firmware/imx/sm-misc.c
> +++ b/drivers/firmware/imx/sm-misc.c
> @@ -3,12 +3,15 @@
>   * Copyright 2024 NXP
>   */
>
> +#include <linux/debugfs.h>
> +#include <linux/device/devres.h>
>  #include <linux/firmware/imx/sm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/scmi_imx_protocol.h>
> +#include <linux/seq_file.h>
>
>  static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
>  static struct scmi_protocol_handle *ph;
> @@ -44,10 +47,43 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
>  	return 0;
>  }
>
> +static int syslog_show(struct seq_file *file, void *priv)
> +{
> +	struct device *dev = file->private;
> +	/* 4KB is large enough for syslog */
> +	void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
> +	/* syslog API use num words, not num bytes */
> +	u16 size = SZ_4K / 4;
> +	int ret;
> +
> +	if (!ph)
> +		return -ENODEV;
> +
> +	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
> +	if (ret) {
> +		if (size > SZ_4K / 4) {
> +			dev_err(dev, "syslog size is larger than 4KB, please enlarge\n");
> +			return ret;

suppose it is never happen, you pass down size to misc_syslog, it should
never write data more than size.

I am not sure what means of misc_syslog() return value. Generally it should
be how many data in pointer 'syslog' if return value > 0.

So seq_hex_dump() should use ret value. Then only dump validate data,
instead of the whole buffer.

Frank

> +		}
> +	}
> +
> +	seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
> +	seq_putc(file, '\n');
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(syslog);
> +
> +static void scmi_imx_misc_put(void *p)
> +{
> +	debugfs_remove((struct dentry *)p);
> +}
> +
>  static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>  {
>  	const struct scmi_handle *handle = sdev->handle;
>  	struct device_node *np = sdev->dev.of_node;
> +	struct dentry *scmi_imx_dentry;
>  	u32 src_id, flags;
>  	int ret, i, num;
>
> @@ -98,6 +134,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>  		}
>  	}
>
> +	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
> +	if (!IS_ERR(scmi_imx_dentry))
> +		debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);
> +
> +	devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
> +
>  	return 0;
>  }
>
>
> --
> 2.37.1
>

