Return-Path: <linux-kernel+bounces-883740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD61C2E385
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 529AF34A7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0942E282C;
	Mon,  3 Nov 2025 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="chcsMZ/4"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azhn15012020.outbound.protection.outlook.com [52.102.149.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DE2E62B9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.149.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207849; cv=fail; b=KA6qBVBSaqajAVlKrx496nqxuWdRKFedAj3m+wC8fsm/RcKmghkRjLsVF4fID5VKG5OaEnOBE6kofKIsSrZaUtR0j3fl09zIGi4xkg+LM8YZiOvv5oIz76gIf9EGZVdFEdG6n2U0f6KPugneihoh4/IErQPhTliGwvcnuXbjXkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207849; c=relaxed/simple;
	bh=cR9f9J7kM1m3tTTxK1yU4MYSCp3Qjnbrq/2OYJfkJAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iJifSB34GbV0ygoxpZEi6heArdtxiLcEPvTThplo7KxIrUhRWhn/+w4Ly31q9F3X8qhDMBGFdZlQdXdTRKeIjT6Vsm6OsNbla/7l6lAgu/MR/QYJrgBi9w04hDS5f/4yJfuzUtuw6FPAe4k66rspmsYsPEP68ULL8FJAQfb+NIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=chcsMZ/4; arc=fail smtp.client-ip=52.102.149.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBKXkb5yd5lR5AdvsFfKGLvgAOGgZXBSBxELs3RY2JTgE/6UPJzxEc6NBKUOr2f2xLBRKWGicF8qGwMe2Aso08c/WhPfsPteK4eySYIw9GiA0TgLjVml8AMXHS6PAhaup9LXWt60e6mojuGi2I01oJrwIcoDznWKKgjYRY8on0CniEq1SHTNkMpsQaQXqpaS/8HHuoEo/Wc1ovSkcAUssuhhRM5AeJAHs1+NRSPfQrTktZ/52KH/E5ywVIUIyK9iCRwIsYdRSg8xiOBXI03MaR7r/9oRiujb/jP1WmYxNRxBwW1VCVfFSXYs0UVIDLtW0Dt5FNfEmEpsvELQTniofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNn4VNKkE2T5zer5cmNfJxfyayvWG/GTh9hlSUEeEwE=;
 b=u5jlirzPUO07esGQ3tVatedn5WDuaOFgFNECBuanW4VoP90mFWJkUS1kfUlXc/OsGLBd99qX4X7/SFsQKPCC7mRD6c86u0vzhz5YVqw4qpqbCacUA3Up4aHyRFirbzxCEQYvfzccOGBpKO98ecnJ2r7Fc8aJ8lloq/7Y2kgGjI8QnYGoIdiWwtTq4vnY1TjXeNzGjxiCGSgjBdab51icYk3hfMQvHfe/Qkd/2JW8rf+FkbqN82cxe5wvvk4BcYsxOM2FemT+yJM2b6iXfWKY+clDetGuKb57j/HSDItx5hEc/PlLgdIWp1vzRP6eI2DLCrRfj8OrN7B9B8L0/GiPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNn4VNKkE2T5zer5cmNfJxfyayvWG/GTh9hlSUEeEwE=;
 b=chcsMZ/4u8EEVQ164jMoeG4DOEGnwYIcAYSb9awgE5HDsFUMIDQtFhGovD2ntlsnS/gXtFvfZJj7cW15U2u3HG5ttL4SrCVcaSM69l0vQxR39OhZ8H6WmqLml7YbAnUZ/V6QaUgHHnem0JQHnJSuvS2a9mhGSHow3NI+F8yS+4g=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 22:10:38 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8d) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 22:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:10:36 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 16:10:34 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 16:10:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 16:10:33 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3MAXmL915584;
	Mon, 3 Nov 2025 16:10:33 -0600
Message-ID: <20c226de-c53a-41f3-b432-6f75a6f83e75@ti.com>
Date: Mon, 3 Nov 2025 16:10:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: omap-mailbox: Check for pending msgs only
 when mbox is exclusive
To: Beleswar Padhi <b-padhi@ti.com>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <hiago.franco@toradex.com>,
	<francesco.dolcini@toradex.com>
CC: <hnagalla@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
References: <20251103201111.1417785-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251103201111.1417785-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ2PR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a4a20a-9cae-4e2b-e1e4-08de1b25d0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|82310400026|376014|7053199007|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFBQcHR1YjBYUXJjeUVWVG1iSFJCM0ovY2g2bnFSbWFiSXdBaWRSenpINXlt?=
 =?utf-8?B?UEtWUjg4VFVHNmlYbG1MNnZaNmJZTW05YzY5dG5ML0xjd1Q1V2RmYUhnaGY0?=
 =?utf-8?B?NjlmbVNLdGZkUjVrUXN0L2F2U0x1d0ZNdWxOOEduRS9pY1ZHMklUWDgrUFIy?=
 =?utf-8?B?WmV4SE5OWWZEalZ3VE1vOG1SOXlnVjRMV0REWWVuVWdEOVYrd0ZpWGxmRmFy?=
 =?utf-8?B?eFpFMXBLT3RLUjNkSEhrd2huRU1hNmZLNVNmdHNOajVZc2NUSFBsSEFsWkFo?=
 =?utf-8?B?RkFLU2l0a0daVWdKZG1zYzFNU1JBSmZjUlVaejl1bXZnbkJVeEVvQUZndlo2?=
 =?utf-8?B?QWlmK3E3b2pBVVhlc0FvTU1sTk9mVnNGaTJ0QVZWb09yeEUvR254SExDTmhh?=
 =?utf-8?B?R0tQT05PZXFFUURKMXFLQy9hWnFkU1IyRlhKQklIZlYzblkxakwyZjg2Qmph?=
 =?utf-8?B?bmd0M0w2eSt6ODlzNDlzamRFTE40bjlJVVhWZ0VUbTN4YlppTSswNm9VOUZF?=
 =?utf-8?B?WGV3Q2J2NFBPTENxNWJnK28rbWVsQ1NRSnpMczdNQ0JzTkNNcXVBdERtNHZp?=
 =?utf-8?B?ZGhBQm8zby9QL3ExcnBPRnYxbHoyUS9KQklDTlFaRXViV1lxaExjV0lGUEM2?=
 =?utf-8?B?bkxtd1JQUC9hRHhCMWlnOUtYdjhrUGdzTUJvRlRYOWQwVUNrVllzei84dk11?=
 =?utf-8?B?R1VuaUtmQXJFTjFacjVTNy94bEExeUwxVGFKeHFMc3BDWEtDdkhXcjVyNGpz?=
 =?utf-8?B?eFI2YW1rUGdNdW9ZZW0wd3ZlL1JWWXRGV2pqOTNySXY5ZEFsakZvNG1yalYx?=
 =?utf-8?B?VjErOFh4aEFldVZGZGVIMFZFczhhOEJ2NFBaZHdXcWZUU1d0YllSL3RwcXcv?=
 =?utf-8?B?NkVkZWg2QU1YTmN2NEI1c0p5WG1qc0JaNHlRVTVMR08yUVNiZVdTcVI0OFhr?=
 =?utf-8?B?Z0lqYnRhZ29PRHdkMWdRa1R0N3JNMlJ2SlRxM1BSemFJNk1rTFZZbWpDL2FM?=
 =?utf-8?B?NWpod3hGSFpHVXlJSy9FcDZFMkZsazVrSG9Tbjd4VDJDVHBrZDRZc3RRbmtv?=
 =?utf-8?B?T2hVV3pTRHpDcTNzM25KV2FmZll2U3N3bGhWZlpJYWxtLy9ZYjVOQzU1Ym9B?=
 =?utf-8?B?UEtuckNlRGg0a2c2UkttUGtFYlZVdnRuemRrSWU0SEVyYWU3S0VCK014aHlj?=
 =?utf-8?B?Rmx2U0hWaVZBTUdSOUpTV3FrU2VjUVRCSTBGMWQ0RUtWQUpyN3BvdFYrQUth?=
 =?utf-8?B?Y0s3OU1BM3BORGY4YjlvOXRFK0kxL0tYWHd4TnNYUnJVRHV6NEFobXRJU2RI?=
 =?utf-8?B?azRnaWRzWU1ORnlCdmpHY2RacmR1c0lXT3NhN21hUWhKWkpGRGsyRHcvZWRv?=
 =?utf-8?B?ZjJQM1p6b05qM0dHM0JuZCtINGMydUxVWVIrdWUxUVV3Z2Vlb0laZXpTUTlF?=
 =?utf-8?B?dXJpYVFZZzRXSXhKSml0NjJ5SkdXaWFGTlJCcDJCcW53aHBobkg5QXkzVXQx?=
 =?utf-8?B?OG12R1N4bXEvYkE5WUIxSmg0TVc5Z0ZJV2lIR1JqRGwwbjdTeG9pMzB0OW9P?=
 =?utf-8?B?QStPOXVtOURXNjhBWUMyMFZHbVRmL0JSejdqbXgvczB1bXQyY2pHSSs4REtB?=
 =?utf-8?B?RmtQSlMzakNUdTUvYkdYSkRrSkNmM0swV3JGSWFHRjM2VXladzhmZGpYcVdr?=
 =?utf-8?B?aEFIM2pJVDBiVVdVOFRTeWJUcEV6SjFNTFhKb1g0T0J2TkhZQTVuVVZzQTBN?=
 =?utf-8?B?QTYyeFpOa1NCTERGK3BsVkt2N1RPcWFyTHFlY1NuVCtqNkpKTWFjd3kwM2ZV?=
 =?utf-8?B?MkdVOWZqZWNyYkZ1cUtTM1JVanozNEZVSGsxMFNpalNMZzVJb0phTVBRQjVv?=
 =?utf-8?B?N1FjbldYV21RVWh1TnExMUNIQTdWLzZsZE95VXJqRnhpTExtL01PMjlBVEZV?=
 =?utf-8?B?bER4N0d1bHVxTWUvUENnWHdPODlFV3NzV2RDZFAwTjVGcGwzSjFja0pVWnBi?=
 =?utf-8?B?YlI4Mks5UmVtWGdxWUZ5NVBwaWZzOEY3d0tINVppQzVhSjI5Tmc0cm94YVI2?=
 =?utf-8?B?RXF0bVl6dXZUeFBXUmwvMHQ0NzY5ck1DNlpEdFJ5bmE0ckk4dmthQkJTVnA3?=
 =?utf-8?Q?k24E=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(82310400026)(376014)(7053199007)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:10:36.5499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a4a20a-9cae-4e2b-e1e4-08de1b25d0f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060

On 11/3/25 2:11 PM, Beleswar Padhi wrote:
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
> 3. Tested mbox driver probe & device boot on AM57x-evm (OMAP5 based).
> 4. Tested that the patch generates no new warnings/errors.
> 
> Changes since v1:
> 1. Use device_get_match_data() in probe and store result for re-use.
> 
> Link to v1:
> https://lore.kernel.org/all/20251103075920.2611642-1-b-padhi@ti.com/
> 
> Changes since RFC:
> 1. Skip checking pending messages instead of flushing
> them explicitly for K3 devices.
> 
> Link to RFC Version:
> https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/
> 
>   drivers/mailbox/omap-mailbox.c | 35 +++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 680243751d62..17fe6545875d 100644
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
> @@ -78,6 +79,7 @@ struct omap_mbox_device {
>   	u32 num_users;
>   	u32 num_fifos;
>   	u32 intr_type;
> +	const struct omap_mbox_match_data *mbox_data;

Not a fan of this, you could have stored just the relevant
flag from the match data here in the instance data, not a
pointer to the whole const struct. The issue being now you
have the same info stored in two places, `intr_type` in the
match data above, and intr_type on the line above that.

Looking more into it, the use of `intr_type` doesn't need to be
stored in each mbox's instance data either, but that is an existing
issue. For now I don't want to hold up an otherwise good bugfix
over that, but we will want to come back here and clean some of
this up next cycle, for now,

Reviewed-by: Andrew Davis <afd@ti.com>

>   };
>   
>   struct omap_mbox {
> @@ -341,11 +343,13 @@ static int omap_mbox_suspend(struct device *dev)
>   	if (pm_runtime_status_suspended(dev))
>   		return 0;
>   
> -	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
> -		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> -				fifo);
> -			return -EBUSY;
> +	if (mdev->mbox_data->is_exclusive) {
> +		for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
> +			if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> +				dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> +					fifo);
> +				return -EBUSY;
> +			}
>   		}
>   	}
>   
> @@ -378,8 +382,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
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
> @@ -396,11 +401,11 @@ static const struct of_device_id omap_mailbox_of_match[] = {
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
> @@ -449,7 +454,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
>   	struct omap_mbox_fifo *fifo;
>   	struct device_node *node = pdev->dev.of_node;
>   	struct device_node *child;
> -	const struct omap_mbox_match_data *match_data;
>   	struct mbox_controller *controller;
>   	u32 intr_type, info_count;
>   	u32 num_users, num_fifos;
> @@ -462,11 +466,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	match_data = of_device_get_match_data(&pdev->dev);
> -	if (!match_data)
> -		return -ENODEV;
> -	intr_type = match_data->intr_type;
> -
>   	if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
>   		return -ENODEV;
>   
> @@ -483,6 +482,12 @@ static int omap_mbox_probe(struct platform_device *pdev)
>   	if (!mdev)
>   		return -ENOMEM;
>   
> +	mdev->mbox_data = device_get_match_data(&pdev->dev);
> +	if (!mdev->mbox_data)
> +		return -ENODEV;
> +
> +	intr_type = mdev->mbox_data->intr_type;
> +
>   	mdev->mbox_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(mdev->mbox_base))
>   		return PTR_ERR(mdev->mbox_base);


