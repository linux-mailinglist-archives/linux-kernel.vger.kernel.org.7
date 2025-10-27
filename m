Return-Path: <linux-kernel+bounces-872570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E63C11791
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C2C4024F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BC31D75C;
	Mon, 27 Oct 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JQprvlFQ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7D28313D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599190; cv=fail; b=VASXvr4E2V0GzYBdY0gZTv837Z5JewV76v2gYuNa1nUDggRHD9n9UYp7kGbFCVRh7YrP7YtbJskriW/p53OzAReHhZZBVhnJ79yWrf7KgGJwnNMPlMI/3DPRch54/wW10/aoP5MIW8a6pdFZ/d1GTo/ofZumYIdfSSbP1qMHl5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599190; c=relaxed/simple;
	bh=nPqMUAw1glJS7lzJ0FsnWwBGFp7jZM25QGbVnkSijWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKhnv1DRQ4+QVmardHEA+ds4FTE3yfhf81I87uWgNyl9ORIab4gSvohye4PR4gZwy7SPyj86OvpeYbjeYFModuTmeSAa5l2Lp6lG/vcEYfyULrrK8SSyFc3aaXQ3vV2/Sj5DIV09Bqgo3PuJKaG2v8K5yKlVS8zWnyfe/fqTFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JQprvlFQ; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bk7HAo6Wd342q6dR4MI48GfQCNrM+mj405rTzm5/HSuRyKv/isUlbHvUrYXzlFubCC5ItAjIZRCkBKD41Wy5K8QrNJ4J/sbBrkm0o7iIz6aMgmFYHuC7XD/MaLLKOSXkpGW9/TSbdzSAgoEqdazL0Fx2Mx5gnpcIztKth9JbpvB2v73pqSSOiXf4nQgvz2qc+JYzqFc3YvYawUywcD2aGq+5wbiFBCxAXjqmeq8oxgXPGz1VYEJAkiZyTwJP41mv8JIn1p6/lY5WNozEu3gzpUdDjRAtn9umULSloHgcb8VADhnnsVd32UohMSlReabw8kAQxIQkxNP2jcEyteYLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSJq1tsANv3mI8TCuj38R/OtmbyPTXnakX8O+dvsMD8=;
 b=npOkbN/lZ8WgQwWJ+/AINMK0vknceDBaATjXCWoefMpsDh52oRRFNtOtPS7Y6FPsM9zzNN8oxwDDL2EBKhsWLdwlEzuYmRZwQOlclce4wL5Ia+GX+JWtO3XVx0Y4LcZpEBXi9wclg/tCo1vY192nN/QX6x8N8n79LnxYYftxYYf/8SQOZWYZT0nlnfLsVZi6wrQNRW5bQEtkKBZ6LqXHE39BeRQl9ZkNi5rTMhUJ/n/gNZeBegLJ8jTeViiFSRkzpKDrmVhheMiRIAMS/FLEqw6yKj6NHXAqWPiHui5nQ/Y4yIuEmhzKQVGlCq7qlswmb42sYJ61NAOLxSTIvGWzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSJq1tsANv3mI8TCuj38R/OtmbyPTXnakX8O+dvsMD8=;
 b=JQprvlFQN5QzJiH2r6h3SDZQE70xJsx0eyRgKam0nK1DMAH3rdoNb9qDliDIVpQ5fE4TUhHJyvyMxlI4ioeWGdVgQ9Od7UHPUdolDnyIS2feei2yRkz8/LqUq0i+Ka/ss7FinmaUYZOt3G9jcCnk9UlGcSyzPWeZEseS9e8Wmi/tyudplqhZWTHtdBywy++uIKEvlTQgPdsOhMsWdgus4X8uDh1J2Im9rmKH28h8O8zN3lN3wG7PNWguwo94MSt508BdwObMVwoLXz5i0dLBCjCk1NUU40J0c5r9XH5Ms130EdPOz7bEumkujFhqZuNmRtgkBO5eYCkXvOokmw/cag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 21:06:26 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 21:06:26 +0000
Date: Mon, 27 Oct 2025 17:06:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 1/1] i3c: master: svc: Prevent incomplete IBI
 transaction
Message-ID: <aP/ezI2mTDo5hig7@lizhi-Precision-Tower-5810>
References: <20251027034715.708243-1-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027034715.708243-1-yschu@nuvoton.com>
X-ClientProxiedBy: CH0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:610:e7::9) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a55f911-cd94-4742-a749-08de159cb101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psXyiL93XQzR82tlnnUDBgJOve23mYe/Tzvkc/8Q0zSJXHegDMMmBWR9KS2R?=
 =?us-ascii?Q?MmRDA5BtrEmgUjJUe+KJlmn0yMpfTGWJk2QjPAZIK23oKJXWvoDa7mK/11dc?=
 =?us-ascii?Q?8vWvPhpBe5HAFo4Zb4yhVARvV0G2Spwkck9szVZ6ag4EYEaiIZNxteJ+ZNK1?=
 =?us-ascii?Q?GFgbXbmDmCqWYtUIy0oxZzIHbdtGeoTX1RVPDw7AdMcX0AQWUrz3xhaXkPCv?=
 =?us-ascii?Q?7yCDb23QvneigHFBDcG5bgz8zuz2kSqe54XS9psoabC/INRnth9wIHjGA/Yx?=
 =?us-ascii?Q?1we+cOFd+deOkCwnLROwT1+AXzXFSQBRzhwbMCsESqUzV6K1vPnm3Vh9F7LS?=
 =?us-ascii?Q?nReUKLI58UpbELdFUrDnj7a5Xm22GSVwB6gcvxGTCW9EACx6koU2DbXdhAkm?=
 =?us-ascii?Q?15E56pRDVs3kQw9eqEPFtvdpfra7Uzar35Nmm/utDABmeZArO9rYpqcaMqCD?=
 =?us-ascii?Q?+FaS4j+mY2+Eyz6bBKsqCM7vq4TMroip7umXmwWefFgXipe/ZEKrC5mZA4eC?=
 =?us-ascii?Q?NJET7zCgeQhn1MPiJfLeFZch1ClO/BrMs4dGi2IZ/ZJHJg5jeMAVSKWnucUv?=
 =?us-ascii?Q?zcFkCInz3gpKOTmU+/7FsQhpEAa7mmPCi+Jn3OtMDntPYFkRq2+4xvsdRWgW?=
 =?us-ascii?Q?4FCpiqfV8CPB7WUxH/1y2DQWUHebjk9GKjO0aIFV247o31eQiRg5nDxjZaty?=
 =?us-ascii?Q?ay+k4APatq1QgNJJlaLPjg9QvcWtgndl+NlxXKp8I5PUjWhkzsOED6nyB4SD?=
 =?us-ascii?Q?reB8vSpPOWHJJV8O5WhpP9DkPa4bNpDJwGNgbs4+j+8FwH9werqhhDPx8q83?=
 =?us-ascii?Q?obBjPIvSiCLJTXVU4n+u6MLywCusvliuHoOdMnOwcCK7wQ+h9bFpTrGxmpGe?=
 =?us-ascii?Q?VwaFCYhs3wTM20cxesgBwKwzJurB9baM3jAzJwIVkPiJhNc0IA8zeNM0TnFz?=
 =?us-ascii?Q?t7OTaXxneSJTSHFJnT5l0a64vWVThvMe1+/ntUbaKj8ITTHciAgSRsPqK42J?=
 =?us-ascii?Q?vPriKtujurGTeTiNmbpuxu075YrRoa4hAUl1C/ahofOqy8XlBsOnWVyjAEX9?=
 =?us-ascii?Q?2CtP8V4ldAStq8ZFsznCAVn2HepP5fdE1pOCDjUxV//mwii7OL5iCJg/VIfd?=
 =?us-ascii?Q?H1TKAADBvvqVo4ITTxGCnHCrOnzkPxwAKmcV+BoNbGDaq9MLKWl03fk745qh?=
 =?us-ascii?Q?aTKhf9cs5S52BmDO1mUeO/RL+6xSAhJ/eEaZBKghNZM02WM6JnhNgcqL4jsv?=
 =?us-ascii?Q?/jda96xclAHKlfqYqvBAX05YGTA4I5vIx6m/vRQUd79Zyc1BDfaNTq7Us2X3?=
 =?us-ascii?Q?kyavg5xCLXjFmgJKTU8CSIZOmXCu79fJwTVlI2FG0FMZe5ouRpcx2Wm2YcPF?=
 =?us-ascii?Q?UYH8ji009eiIK6uxWA+Q5A/ON0sidzEfxJedUCmY60hA3t6f2ZN6BhCk8tKx?=
 =?us-ascii?Q?/mTBNEDzGI/1VDGOxTQ6LqB6DAo+egTbdJChCUoxgo1WWbmsFZLkStRzb7qN?=
 =?us-ascii?Q?aU8nfQ0VL3NMQYwAPJhznW6mcKJ9dJSl4gBU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnVviTyGD6lSHkvNRBnLmQPwyNGAFdpjJ+PtD+LU6Il5/z6VuGSOt4h2mGNB?=
 =?us-ascii?Q?7697lqkIx0BUXd26k1guydnvix+gA8w2frGk8DGWwcxlhpKnLIe/X+qTFBOl?=
 =?us-ascii?Q?6xmmeEDU4cl64pYwS/ebuJ5FuIpDvZOKBbIAVRyU3YP6Tf+Yj9+5uXBc9B7q?=
 =?us-ascii?Q?II4vg2Wmjv6gd51bi8ZmxZaQtF1tEGTSZ21MP5p/tRxLlyeaYquf/JbCKAbd?=
 =?us-ascii?Q?Qx/lgEsasHxpvWfbxom4DWdYN6Azp1PFrk9+l45MV6b9xzd1AzFCC3DSDUcD?=
 =?us-ascii?Q?OldFMP2arOXXHajBsDD3eJrspDNwlwz+TNCp11jN8TSsWuh6r6IPBYZe3Ma2?=
 =?us-ascii?Q?Rmom0SwCZ4BAPF4MnGbL9XsEeer5EDvv/9jY89i1mN+Bge0M5OQGyx0HchE1?=
 =?us-ascii?Q?yL6bYQpAsm8U2vY/RFkSE/o7+qRofRCtN+uCaPPHY4+STKSMQ9PIsh25f1tr?=
 =?us-ascii?Q?O+yuBB77e/Vs+04RImhjyBnSkAoZfHIYYO+fCHE9AKWQbxU4v0iOr0EkZAdu?=
 =?us-ascii?Q?l4mwoqDTddP5Y1vH1ZGHeO+Pq253DBxAR9ey605FG6vrHjBtWHiOOWOft9b/?=
 =?us-ascii?Q?AAe4MvBWJb/nWnmHftVHnMUGZaw6Qb2r0D1akh1q0gaP5cJ5RCLk9QeyOATm?=
 =?us-ascii?Q?d4N2kC5unZTKqdOD/kJBqF4qkrsC9YU2CVShJ3s/P/vxny27ox22DSRjczjA?=
 =?us-ascii?Q?4Hpr5ltCWgmM+M6FM2FG8I1kND6iE/gR69lSAOSTfZ3oe0Nm7hfwDJ9d5STO?=
 =?us-ascii?Q?fusw9NYgxLuvcRYGyaKmgNEp9HEpjvkq5Aj872PUQpOq+jOT7itiSBsnQ2Cw?=
 =?us-ascii?Q?mtIkEmkUz4FCtAURC29WyrQ7HyQ5C39imsPODZ3R/aHweUKwHdmYb/hzcXsu?=
 =?us-ascii?Q?u39GBB3vZU+wRC+K5GYh1LxEwiz9uKpFL9Ax8Rby8vAPy241q15/JqPLksq1?=
 =?us-ascii?Q?p9sNio1obmWj4uY4oQpq++j8bzSoxPwZnMldUt2gy01aw+t8HrJHuCshF8fj?=
 =?us-ascii?Q?XB3LLHbhOV27eQusxZbtNLeUPXDD4jv9VpSz5YWKCqb3AJnASSig3LPwudmT?=
 =?us-ascii?Q?GgN6LFO92qmd9XfBr2OASAxAHe+hLU5qwyocEmuEh4ejTL0IO3kukB632HH0?=
 =?us-ascii?Q?zWwlHjIOUzgCltOMdgJNwhyJey9uWjuw0OCxBU6jLl8ogZJePqvwRZ04mkVm?=
 =?us-ascii?Q?ojvZJMIy/bwmqZByT46WYsXQ6/F4huyFA5E+HGPdn4bK0cXWEysYCEb6KhGz?=
 =?us-ascii?Q?zuX1sy+rBkV8XkXLs/sg/e8rCVF8CCAi//xY4oVz8nolGI3zacQjz86cCixX?=
 =?us-ascii?Q?PC8DAmSEBG7fyGJKWq4Pmcnrs8ailzYGrwgXwzM+EttAeRgsVxCkOxdjwcja?=
 =?us-ascii?Q?Y4JgLKFoLB+foNPZpqm2h06XRFmhsf+CRGU/3iGm1GUu7rC9r95sPS7bMzg7?=
 =?us-ascii?Q?UsRo2B+t5qa/CI7vqNgo92ZpuA/KBIJavJkVz+WvieRaPGGvichLxsbufbr8?=
 =?us-ascii?Q?xbuDtGvIWgHVj/u3mZ3FQ32zdrOAc5QmSJaDpTTFlybMC6IlXMtutVsGreA5?=
 =?us-ascii?Q?hSs/YHV4bZeUGjHMPdk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a55f911-cd94-4742-a749-08de159cb101
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 21:06:26.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z/Qk4rXf2kBEEvmx/7HCN5H/GrKQi9dMYgg7aQDnSxH/KJIkxK/JBs6+G/FEvzyQEImIcMJ8MGCrg/1OY151A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649

On Mon, Oct 27, 2025 at 11:47:15AM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> If no free IBI slot is available, svc_i3c_master_handle_ibi returns
> immediately. This causes the STOP condition to be missed because the
> EmitStop request is sent when the transfer is not complete. To resolve
> this, svc_i3c_master_handle_ibi must wait for the transfer to complete
> before returning.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v1:
>  * do not touch coding style change
> ---
>  drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 9641e66a4e5f..e70a64f2a32f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -406,21 +406,27 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	int ret, val;
>  	u8 *buf;
>
> -	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> -	if (!slot)
> -		return -ENOSPC;
> -
> -	slot->len = 0;
> -	buf = slot->data;
> -
> +	/*
> +	 * Wait for transfer to complete before returning. Otherwise, the EmitStop
> +	 * request might be sent when the transfer is not complete.
> +	 */
>  	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
>  						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
> -		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
>  		return ret;
>  	}
>
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot) {
> +		dev_dbg(master->dev, "No free ibi slot, drop the data\n");
> +		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
> +		return -ENOSPC;
> +	}
> +
> +	slot->len = 0;
> +	buf = slot->data;
> +
>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
>  	       slot->len < SVC_I3C_FIFO_SIZE) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
> --
> 2.34.1
>

