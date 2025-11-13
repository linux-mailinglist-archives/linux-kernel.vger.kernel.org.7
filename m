Return-Path: <linux-kernel+bounces-898743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31BC55E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF953B3E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DA3164D4;
	Thu, 13 Nov 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AchGzgI/"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7C23EA8B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014424; cv=fail; b=Vnd8OdBGLviPngW60CGKe4A1RFmlll26INXJP39rhNFK/6dwFcen30reuVof2IIrAZ4HH0CIECVZROuJaM8gFYyKU9Y1JNOWfSP/UIhhoXaJWHBoagChl5PIAuP7JeBFV+rIS3XHbd1pXtKiojQhejMrdCMe3kd+aGaapfUEQRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014424; c=relaxed/simple;
	bh=IvMh2p3n0CxnbKFZ7lqhlWW6zuim2WJw2vGvi+VSwWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXvZ8MkQ9oKUTRQ6dsX1EKRuVs2v3toDzsed5sPOJ0L+w63Ekv1IZ2xEwtCVgC6p2F7Drs6ODAkrp6T1M6CqguFkVuHXmN6IxPdhiJoN9fAyVnsUqcADKAxt9AJWsig/ofKFSizpU05vYnWFGuhZbRWNorBl2Myaa3htH6DLrEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AchGzgI/; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVhvtK1iGF2f3ijmJkWL2Nz2jSp4BXXnoWYLcp4MlNaTTf9AJuFwkegJKEBV1vdJY41ZjW45/wHynGpcGDvk5y/UM2YQQfBsN3JpCFKXH15UctLzKPsDCG/wkId/3dYtCRvbAciE00St1599IhSNrIk6oygVdXNOG9fqOaL2b4Ol2iNv+0EwsYylHhtdyb0OWx12SPrSqhTrVO9WSNyDrGzkFWjl66eS0v2AAef80fHEITxlW7z6JR9ZFWxkik6D/J/unJMPrd28qODDyeW/QEoRaaglr44bmJqmhk3C72TyAlKMBnwXhmTmFjejsr0Y4pyIWnLvA1XUn31ArZKsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JsRaS9ANua2/x9DO+pOgLBjhs5V4OwBAa5L+RuN4Os=;
 b=eXAPXJt27wqeBLGWlqmj6cagqjWjeN8C0pPJB0uWD3U1KqMPIulteO1vnOxI9+b4qdM8np0Cf6Fi2/6l6B3+f3LJKVEDCVkGb+HY6wnIGJ+jPgNRPYOqmVhm4ZIL6JV5jzPy7ygHpuA4TDYPGsAtkBBiCEdJENEfZqwT+yCliJ4KKZ/XZyOf7mW4xshP3cYDGeM60reqET/UaVeALGiCNX2gkcoJBewzAkexDrS5atLuzrfbSsV/OsVLIuXE3T2b8SYfa71Iy7r8tsoxbFjWc5aXJ3JVlJEB8bze6xM1U/JpCTcKcQodXsaJMniDLxs2ncrijQ/vHekw3/T7Jqc6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JsRaS9ANua2/x9DO+pOgLBjhs5V4OwBAa5L+RuN4Os=;
 b=AchGzgI/imnvgZX07qWBCDdygq0nQu/qLWPxyZsgtVG7mh87SaJqOp2I0Nzr99WcLGjPXFN5uttJloGbeFVAsb2GicUhPeSPYsWj6x2NDNXqfDpQy5toMSO7GlwZ4KBU1TE8ga0TakqBYWcU8HGH1OUwgkF0OUz2XlH9w+XNMLU=
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 06:13:39 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::fd) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 06:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 06:13:38 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:13:36 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:13:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 00:13:36 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD6DZa73985030;
	Thu, 13 Nov 2025 00:13:35 -0600
Date: Thu, 13 Nov 2025 11:43:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Sebin Francis <sebin.francis@ti.com>,
	"Kendall Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/3] firmware: ti_sci: Support transfers without
 response
Message-ID: <20251113061334.wqluum2u4joye64z@lcpd911>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
 <20251103-topic-am62-partialio-v6-12-b4-v10-1-0557e858d747@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-1-0557e858d747@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CY8PR10MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c273e8a-ccc3-4fce-29d0-08de227bc961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bg8GX78gJA9RcL45D0+BYfdO79K5m6/cSatLBd0qT+7USzXIZC4UHKqQj1hb?=
 =?us-ascii?Q?VrpQbrwTsjwY2EFZxcKArQKycS9Q2eJhGzDJLy9hrR7ZIVtTxJ9uJX+LAArQ?=
 =?us-ascii?Q?Vmw3tO3RvLKod2r1OaCxAQNN/1dYnZDo8Lt5lesXNb+LKu5kmHIs9MJBicAa?=
 =?us-ascii?Q?RVsRjNnnV8OgQ5z4uvIWG8Pfijvj9AxnjVULO3757Tu9/GFlCZYYkR81+KnS?=
 =?us-ascii?Q?Cg35OMxUT7Sd4pmRNVuokkH3kg0+5yqgQMTbh8tQwACKmUL6H3/ZZ/StZ1QE?=
 =?us-ascii?Q?f8YTIFriOLBRrk+Trhk7dIUvdTChXnTdXcyb3G5TjJELqFp0ttUmY1nAwAYT?=
 =?us-ascii?Q?bYUMU8/whjyXBhqu4E70nYcryAbiz5oXiAxklIqmu00uSwY4FnxnAmW5G6g7?=
 =?us-ascii?Q?VpJix0jgaHyJc9VR7+ZeJYOuu6Rd+b9zCS+xACBwmtz3h8BzuFx3gZ83U7TH?=
 =?us-ascii?Q?sj5Zmk/QBJlhFXT/lkNp1+AgGml4Eg/4QRHZ6x5rcyWTYDF+NvyosErobZzI?=
 =?us-ascii?Q?Q5+Yj2S3R0HjnN4z5J/y3TKjWperAiKG7T/uFPTL83bFImncSG0I7qfaQvDa?=
 =?us-ascii?Q?tjN2FZ62PVQtAxyr4Z1P1f5XLw+BJiDJ3+jJ/MUo1FuUTo5tdV8GOULUWsDR?=
 =?us-ascii?Q?1P7YxEdlr23JYrSOf2yWzWK9RgFFHkLxuP/mrqH3IfdCZbZM7yiOxs0zTlLo?=
 =?us-ascii?Q?8j4EJO3/4vVM4AVon8SA2+Bsv6RjVjpuXp6GeeDLJXiYNUBA6/y3lVaMQygm?=
 =?us-ascii?Q?zSHgm3SkohYIIm0rsH10IIWqOeboD12Ue/dKw71di7PUWB4nZeHedDiRyasc?=
 =?us-ascii?Q?Q1npAscGXCcsXsgXSX9SJ+0FwqdHRBoitlp+1IiHyNoVyu1OH/OG/oj1PEAT?=
 =?us-ascii?Q?dm0SR8715cP99/yBWcRowFbY1NmaMIkqPNbJE4A/5BuJdVmUTM6CEgDquKPD?=
 =?us-ascii?Q?LxQ+SlZ79TxMrKM064uFmSPkcaFF2WDa1ULgQghI9g61yDmRay4dXZYjJaR9?=
 =?us-ascii?Q?dQ70xVGUi9OZKE+oNrpwikoADjcu3aC9aW7BnS/HyLljFFJu7GlG69inEM4r?=
 =?us-ascii?Q?VnefLYFp5kuCr0D4FIDDgIbFrriuTNgrVhbd51n6jIl5lfJissHyMP10n9bv?=
 =?us-ascii?Q?DkWgtQraWSZ0j7tZNZHReisJNfW9s9v4AKSDdbRVrDYqt1Bk4LH39nTNHueb?=
 =?us-ascii?Q?5ZjUb2vqx0glTw6CRUt9BLXoMAEsSlp48sqQZopXSsUsmCRUb+82IjgXDgUX?=
 =?us-ascii?Q?wLtwaYlsmU5VW22FazG1rh7oASpuOdYFuCD8bfSY37ij5Ie0HCRNbTzZL+y9?=
 =?us-ascii?Q?3+fvzC/zgG2oLOm1uvNV+k814jQAkDD4Q7afCQ2Q3JlS46hYtPQyptplAEza?=
 =?us-ascii?Q?M1yJuqZCMT5f8S6bvKVwlPthTpiLjppoxHC1qlILS50NKPCEjCrZlEbcQBF6?=
 =?us-ascii?Q?0ucQhU8TPULScezvmemYk1sajfyN09yISbbpIp1pdFym3En0PNbUcTq6q479?=
 =?us-ascii?Q?3Q2JKW4TqjzPq8WaQtSey8V0syZnWJjfjOG6GcUdYzblr3tAwW4diZbkEo+3?=
 =?us-ascii?Q?Zzh1xavfaElG4WfcYYM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 06:13:38.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c273e8a-ccc3-4fce-29d0-08de227bc961
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586

On Nov 03, 2025 at 13:42:19 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> Check the header flags if an response is expected or not. If it is not
> expected skip the receive part of ti_sci_do_xfer(). This prepares the
> driver for one-way messages as prepare_sleep for Partial-IO.
> 
> Reviewed-by: Kendall Willis <k-willis@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 49fd2ae01055d0f425062147422471f0fd49e4bd..2585cb82d1ad8e3d79bca458a2b86cc81a3e627b 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
>  static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  				 struct ti_sci_xfer *xfer)
>  {
> +	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
> +	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
> +						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
>  	int ret;
>  	int timeout;
>  	struct device *dev = info->dev;
> @@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  
>  	ret = 0;
>  
> -	if (system_state <= SYSTEM_RUNNING) {
> +	if (response_expected && system_state <= SYSTEM_RUNNING) {
>  		/* And we wait for the response. */
>  		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
>  		if (!wait_for_completion_timeout(&xfer->done, timeout))
>  			ret = -ETIMEDOUT;
> -	} else {
> +	} else if (response_expected) {

Makes sense to me for one sided communication messages like partial IO
which is essentially a power off.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

