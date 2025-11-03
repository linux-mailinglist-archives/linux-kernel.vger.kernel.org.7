Return-Path: <linux-kernel+bounces-883073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265AC2C6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5560D4F1D94
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078F30BF73;
	Mon,  3 Nov 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fl6gsY48"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazhn15013037.outbound.protection.outlook.com [52.102.140.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B793280CE0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.140.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180316; cv=fail; b=QBMhw4IHrUr164FEME5Vhb83rPwzErrSKMpkDUDxKkQ+J+421bqvfi1sfbN5qByxn8JJ/lyqn8sVT0HzH7XKvtHiS7SqCuVnuYUXYPawzxXk348XRjvB2UZjMZWFN5DboUrtOqhWmWC8BTlxxseHZs5oWj3vQ8B2SZJJW2TfUJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180316; c=relaxed/simple;
	bh=pGxsbIt42W57zrgbfvXPMPaBYYwwXAMNaa7dTaHGUHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q2DqOLutEm6cHfokT4+CnexIM6NFrpct/UeedL3Bwsib3pOyDSkVs5yDg4Y4hv6bM8s/XbmdiNP7oDyhXeHzifm3m9uB/TE3ytVxQbP++UOHcWBoVQdFk9upNj8t8Ujdz2NA5I5/5qzMrLV6NBoWLpqAw3U+dpBT0KQy7oM2ePY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fl6gsY48; arc=fail smtp.client-ip=52.102.140.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyBsYZcCW+jj9f4Gj06SXcnkVnEOFcgeo8Cqw/I3xgF64xafy2pwW6kJacEajiuJasYOEKHaVS5uveFjAeRuQnJgMoiZl6VZ1fpDPT1EgiB5uU8Bq1JNwudpbpiMjoCYvzuQfD0wM2shrn0J1DbsIW8CRCrQlrvwa8WC1A7Qduy4UVkTWwJRNuHfsBavE8PlWAz/v7p4swzYTb2vDKqYbNWgWgF1RDfMwAIDz6+ArA2RzAHwv2dIW8kDtklW9o4Cq/1iADc5hImivhricbdg/OsCP3r6kT3ul1qb4zpITIOTWDdlDBEbrlzELiQYtAqhBa2AijDGm9i0GPrnnnobmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ6h5JvDK7PntbZPN4wPJ2xOn8cxcniNpMrSxrMF9Hg=;
 b=dOTyjOVhL/pSKD1pKfYbY4XA68WjaUdDb4TF5/Jv5WugLlDpZHAslEa3+X5Is72O7QyjFBFRzl+5FZJEGRt0kJftsPsx6Mx4HXfHO6vGiUWJOonDrEsghG+RegFwTCLa88m6Kl1pb/9CGmyv4VXfUPZBjss8VBCViC3WwtQM5NvImWoNQa1SfDxdsR0/dWYQuAi08jmSfX3MuLd8DmVFzKmhnlZEVfBP9+9Y1AcVK+rjfZbOs+9l+EJVRKS4BdRquRP9oboTjI1/Fdzq1YdYNh1K6vR0ZnQa3yoqkukeexucK9e9iW74J2IXClKuXDhxmGnrU/rKDdRLGxpFVjuIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ6h5JvDK7PntbZPN4wPJ2xOn8cxcniNpMrSxrMF9Hg=;
 b=Fl6gsY48imPnZH9vHNXbnSZafFLbDX2X5U+AXxbL4gWBH9oMu7/NZcqgHMW5CoRK1p6aUlbRjQF5ZMWQmMdDuXOETAEtJkLXYkpFwvUe/78fIbACFnmOfOkBvMpWXQnryQd3Le1necslwkh03Cn6Ncp08yUgPfNsrZYq//SyxMU=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by CY8PR10MB6442.namprd10.prod.outlook.com (2603:10b6:930:52::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:31:50 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::9d) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 14:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 14:31:50 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:31:45 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:31:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 08:31:44 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3EViWN269051;
	Mon, 3 Nov 2025 08:31:44 -0600
Message-ID: <b4966bd8-d7d3-4794-99b6-45425eb0a4d0@ti.com>
Date: Mon, 3 Nov 2025 08:31:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: omap-mailbox: Check for pending msgs only when
 mbox is exclusive
To: Beleswar Padhi <b-padhi@ti.com>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <hiago.franco@toradex.com>,
	<francesco.dolcini@toradex.com>
CC: <hnagalla@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
References: <20251103075920.2611642-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251103075920.2611642-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CY8PR10MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4219cd-9472-4e9c-d4c3-08de1ae5b9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|82310400026|376014|7053199007|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWR4emt0TzBhZjRTNDlTREpaYjI2RE1QVG1yaEFjTHJtWkFQTk5rakoyN3Vx?=
 =?utf-8?B?QkZnSVRaT09UbUFNT0VEc3Y0elkvSHhacGN1WmxHUTA2VDc3UEJQWEZqdmJI?=
 =?utf-8?B?VWJ0SkR0dm0zRXRBMzUzQ3kwci9aVWFCQWlZb0x5TFdkdlB2MUZvaE5pTzJN?=
 =?utf-8?B?L0xlT3gxdWVIdHZOS3Z1QWRDTFp2ek50eXFUM1VPNDg5YmxHdmZKRDVSR2VY?=
 =?utf-8?B?ejNGYUpoZmprZE1GZlYvVW1sdWFtQTNHOTFYTlZFYm5lWm8wTURvV0JLajZk?=
 =?utf-8?B?WEcrTk5Cbzc3ZVpEalJTWERyZE52NlYyakUxYmg3NGlYMDZxbFhVWXNLWWRq?=
 =?utf-8?B?VHdXeC9QYjFRamNHK1BSVWdHaHdVdGhvTWlwQ21VRkw2MURlWlp4TGhYRDJh?=
 =?utf-8?B?SzZ6d1JSRlFMNWtzVTBTb1dMSDFxVWFmeHhCSFkvVWY0SzhudUhNNlJkQk13?=
 =?utf-8?B?ZXJ3OVZDNVFwSGh5UTVLM3V2S1VuTVNVMmJMNnM1MFNoL1FrcFJpc2Z4UXZ5?=
 =?utf-8?B?Zk5FajAvRnNCdmdrN3c5bzdvSWRyVGpZOWZOUHVyUXk4S2ZKemlibkN0aGx3?=
 =?utf-8?B?T29uT3FtaGI2RC90Tmp3eUQ4TGhYczNOdTFuVDBnRi9TcDBiVWNCdDVkMWVH?=
 =?utf-8?B?QlZsemJEWTE1Ulk5YVBUa3RBQklIQnpmS1hQUThYZGt0ZDFMQ1lINlBBbkRJ?=
 =?utf-8?B?Wnl5V3ZldzVyclJqenNwdXRXZFZrWDdGa1N3TU94VHVJM1BCcmZVY2NrVUgr?=
 =?utf-8?B?L1hnakFScGtpQWNjV3hBcExPUWFUWkI1YkVuVm92ZnVBQ2wwYnljU25xdFJi?=
 =?utf-8?B?WHRFc25OQnhIY0RXMmV2NFpjN0lhLzJPdnRzYkQ1WXc1VGZydWQ0Z3d4Z0Z2?=
 =?utf-8?B?Q284bnZlb2NncEVRekNuRnBMTkNiYVc3bXRkZXZ2ZXBQYXRjekJUYVRPTWNl?=
 =?utf-8?B?UkJCRUJKVEFPTEZmTjkrRkxTM2ordmFuVXFJRmpwWWllcG1GQU1qeGR0TXVC?=
 =?utf-8?B?SW0xNHZRYW4xbUxlQ1ltbzkxa3JFYjNtQzcveHZtUmQ4WG9iczJNa1VhaURR?=
 =?utf-8?B?WHl0WHZrUkxZY25vbHJQdFdSRkh5WUtYSnNlNUJ0SG9kSDRzMFJqVmlSQURL?=
 =?utf-8?B?ek9vaGFqZ1ByNXVlTVhmN0RPQm9vdmNNS2p0K3VWampjVlVwcUlMM3Y1eEJ6?=
 =?utf-8?B?bXFIbTFHUjNnYW9QNWZYRFEyYjlmaVdxbE5wLzdlS2t4MW5ncTA5MmRjSDlK?=
 =?utf-8?B?TnJqNlp2Kzd2WWZuNUFMdFVwSWlpSG5TNXhkZXR5cHg0OHJ6WjZvRjMrQ1Zw?=
 =?utf-8?B?V09sTWNWM2V4U2FXeTluNWR0T2JCcE9WZ21qaGlHWnNLT1hDSW1zMEJLOURP?=
 =?utf-8?B?ckxCTXdwenU3aGNaaGFqWFVWaVorNGdiYmR3ZkJKOGpXUkp1Z0gwUjRhcjNt?=
 =?utf-8?B?SW1HVTd1OFQ2MEtQMFgwWGUzckViSU03K29kWnZHOXpRZXZuZFUzNEpyY2Mw?=
 =?utf-8?B?ZFBVZVZEMGI4dG40R29yYUdGak9QWUYzUC9XZkppSkVMT1BEVjA0aXRkYnRQ?=
 =?utf-8?B?ajNoN1RJdjQ2RHlma3RxWDBGRkF6MHhwelNYMk1UYmVWai9iS2V4ZHpEYzZu?=
 =?utf-8?B?N0hlK2gvODFEMENsVkJoU2h0cGQzVHFyY2NmTXFGWFR0OUdoa0tsU1I0ZHVv?=
 =?utf-8?B?SThYSGUxSExZTWI1cjNoMGljSnExR0NMaGRNTGE1KzNra045TS9rMGpINS9P?=
 =?utf-8?B?RUZxTXZ1MXVUSXAwTVJla2o5cHlKcndZWVYxSEpRNXdRMUtDbDNtNnR1Wmp5?=
 =?utf-8?B?SFdTb0w1Y093dXlCY0VmZktnRlQreFYvczRMam4vRFBXT2dlUngyeDNnUkxu?=
 =?utf-8?B?d2VGcmpSb1lpRVU4eDh5eE5PR0tBVU5oWDg4NGY2c1NZQWNBY3piWDFhUXNx?=
 =?utf-8?B?NXQxMUYxOUpRcW5kN2Uva1lSRDNrcXRsWjFrem9ZN0VlM0NBZDJCZ296Zkg3?=
 =?utf-8?B?cFU2TUlEM1lEQmFVNTBOOUp6a2lLNFFrOURoMGVvTFRoWlI2Y0t6VnJ5WjNG?=
 =?utf-8?B?V2N6L1F0bmZHRlExQkpkY2d1Um1FNHdXemFhR1lXR3doNmdic0FENGxvblVw?=
 =?utf-8?Q?tfeo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(82310400026)(376014)(7053199007)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:31:50.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4219cd-9472-4e9c-d4c3-08de1ae5b9e5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6442

On 11/3/25 1:59 AM, Beleswar Padhi wrote:
> On TI K3 devices, the mailbox resides in the Always-On power domain
> (LPSC_main_alwayson) and is shared among multiple processors. The
> mailbox is not solely exclusive to Linux.
> 
> Currently, the suspend path checks all FIFO queues for pending messages
> and blocks suspend if any are present. This behavior is unnecessary for
> K3 devices, since some of the FIFOs are used for RTOS<->RTOS
> communication and are independent of Linux.
> 
> For FIFOs used in Linux<->RTOS communication, any pending message would
> trigger an interrupt, which naturally prevents suspend from completing.
> Hence, there is no need for the mailbox driver to explicitly check for
> pending messages on K3 platforms.
> 
> Introduce a device match flag to indicate whether the mailbox instance
> is exclusive to Linux, and skip the pending message check for
> non-exclusive instances (such as in K3).
> 
> Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware")
> Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l/
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Please help in testing the patch on Toradex platforms.
> 
> Testing Done:
> 1. Tested Boot across all TI K3 EVM/SK boards.
> 2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
> 3. Tested that the patch generates no new warnings/errors.
> 
> Changes since RFC:
> 1. Skip checking pending messages instead of flushing
> them explicitly for K3 devices.
> 
> Link to RFC Version:
> https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/
> 
>   drivers/mailbox/omap-mailbox.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 680243751d62..b90ce9d60a80 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -68,6 +68,7 @@ struct omap_mbox_fifo {
>   
>   struct omap_mbox_match_data {
>   	u32 intr_type;
> +	bool is_exclusive;
>   };
>   
>   struct omap_mbox_device {
> @@ -336,16 +337,21 @@ static const struct mbox_chan_ops omap_mbox_chan_ops = {
>   static int omap_mbox_suspend(struct device *dev)
>   {
>   	struct omap_mbox_device *mdev = dev_get_drvdata(dev);
> +	const struct omap_mbox_match_data *mbox_dev_data;
>   	u32 usr, fifo, reg;
>   
> +	mbox_dev_data = of_device_get_match_data(dev);

Fetch and store this in probe in the mdev struct, no need to re-fetch this every
time we suspend. Also use device_get_match_data().

Andrew

> +
>   	if (pm_runtime_status_suspended(dev))
>   		return 0;
>   
> -	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
> -		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> -				fifo);
> -			return -EBUSY;
> +	if (mbox_dev_data->is_exclusive) {
> +		for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
> +			if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> +				dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> +					fifo);
> +				return -EBUSY;
> +			}
>   		}
>   	}
>   
> @@ -378,8 +384,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
>   };
>   
> -static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
> -static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
> +static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1, true };
> +static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2, true };
> +static const struct omap_mbox_match_data am654_data = { MBOX_INTR_CFG_TYPE2, false };
>   
>   static const struct of_device_id omap_mailbox_of_match[] = {
>   	{
> @@ -396,11 +403,11 @@ static const struct of_device_id omap_mailbox_of_match[] = {
>   	},
>   	{
>   		.compatible	= "ti,am654-mailbox",
> -		.data		= &omap4_data,
> +		.data		= &am654_data,
>   	},
>   	{
>   		.compatible	= "ti,am64-mailbox",
> -		.data		= &omap4_data,
> +		.data		= &am654_data,
>   	},
>   	{
>   		/* end */


