Return-Path: <linux-kernel+bounces-878412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EDC20847
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2872E34DEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC50239E9E;
	Thu, 30 Oct 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DRzlAd3G"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD313777E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833616; cv=fail; b=M/Nww1EtQsBekH8JT8cAQgHGiWoFaOtSo/lNssO/R0xUAaQRMaSpUkGCl+r5WigNw/J5RiiyIxdgzkOkPs3ePb3J+0NjAbEqe4FmZX3ovlJGFHU871B5ZAUtwWnruynGi6uGhR/DYXisV+a9Wk3TOycxgy5c3Uczklle2G483DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833616; c=relaxed/simple;
	bh=48svMyJoUrSw2XefD79S+FypdASe7bhxo+UzPS7sEYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZBIjV4XnFftHwDwtZJHZx4hpYySi/rl4mJYhOpB7gSc1rNuhRtvuHyGV2DbGnibuPHZO2lRfqF4cTb12O+8CzgaKLIFhNSEtAmE5VCQ9TSFy/5LwvvruYpBYWDHc6WYyoOi6LsO7wtodvdez05FmuUQtkHUOOArJp9pTc6wuxpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DRzlAd3G; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0kdQ7uboS4QSemWete+ZkijtMhFfVKswQC25krKYJQUuPjccYSjBH+VemysaVuiP1pgqq5Xdo7AY8wI0Vx7LhObokE7VaLc6dxINRL/722myd9yOEn+TlJDlNkax0RglMusW++vlBBOGoB/uGCMwcn3VINd9IrVPmbv6xcrph+aPy7ELbBiBUHoKHla9kfzjbAGBcGOQ+H0FJMbdOwwwJNAG09my50s5pBhfIuMeFBE4gN1K12vsvE3NrjZS8uLZU5NgybIJlWIjYwP6uQjZhzQkb5PS2dQg+YcN/A9kPR8OgeR9F4y0siAHZQwJp4Du7X9q9uWV00aMHITzcJXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKsaxM2GUd9lvdVEJbVZJt40DtvVXuqRSgyg2lBDz/0=;
 b=xiDxPuoVH3riwmSagvBKLDm0k3rPnleun9WbjD21VP4hW8FKwz3ZP3Am9erWLuJT6U4NP8jsTXe4ERJ1dD528Sef3OFODByDMhE1l1gn2jjPVApD22rI/btEOx5PfiB5vDdtp2kzZZR3UgTyGPMIK+hXOE9fOmg5kJJwoFirv9efkTr0hNk/6xFOqomYei7R4y/ORfrAPC7FShYMXAm5omCLnA/D47qqgsF3rJ+kgCuKLaslqqH81DJrG/4RlGRT1kuayEBxqx8NNqo1RXjSSo0W8epDBI5cssnyVullSXwBGL5yyJunKGKYUvj+dPwqDp+s/zBFh1h8hVkmKd2wcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKsaxM2GUd9lvdVEJbVZJt40DtvVXuqRSgyg2lBDz/0=;
 b=DRzlAd3GGncsclt29LVvTz85tuW4qDH8e9EMsv6U8cCYn0ulXHDDLYOS5mN5Jp75ygBUIWHVre5cu4lPpcQTlqHghkE+ddjcKRiB9ooWdYEwXT8nbQK0lzwQI1oCIRuTlBce+LKv8y06b4nWgInnL+UUwo0w6qi1ubrUEef17xQ=
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:13:31 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::21) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 14:13:30 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:13:20 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:13:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 09:13:19 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UEDJ5M2313837;
	Thu, 30 Oct 2025 09:13:19 -0500
Message-ID: <1b3f183f-3923-4183-a237-861e4f886958@ti.com>
Date: Thu, 30 Oct 2025 09:13:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] firmware: ti_sci: Remove constant 0 function
 arguments
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
 <20251030-topic-am62-partialio-v6-12-b4-v9-1-074f55d9c16b@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-1-074f55d9c16b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4e0c41-336e-46ba-93f2-08de17be80ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|34020700016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmUvSlZrNEtHamdJZThIeHdOTlY2bXhWakhubHNReStNUmZPTm96a1NqR3I2?=
 =?utf-8?B?cmtMbWRIbzVQMERGWkRjUnJVdXFTVFdMWWpqUWwxb2tPZ29hdm5BZmZ2d0do?=
 =?utf-8?B?bHVCbW1tZ3RHMCtBeXBjL053cXFLRnh3LzJlUEs2THpXak0wUVRqVnAreVpF?=
 =?utf-8?B?NzVmMWcxNzE3ODhnYkJ1KzBzS1pjQ1RkZGJlODc5L2RIQ2dtb1FuZTBHZEpB?=
 =?utf-8?B?c0MyelhrSlpVTUU4VHA2UTJTN2lWL3hHOU80cmUyeFdWR0xYelBHMVRoRzAx?=
 =?utf-8?B?NVU5eGhxdWtXdmNOUGtOSnByYWNOcFZmanRzazdTSENsbGtOMGl0MHRPRXk2?=
 =?utf-8?B?Y05sL3Z2K3BVZzg1Yk1TZG95VlYxODczb1ZyZkNCeDQyZUdHc2VYYUFYZy9M?=
 =?utf-8?B?aGt5MEVhQjF3ODVvTkN2bDVGTkF6Z0xvQ3ZHUGRrcU5ZamhJQmhCMWgrRE1R?=
 =?utf-8?B?MzZDR01rZmt4bC8zZnBmNDNielpsREMxTkFZWlJPL24vSXpWL2FHZFI5cUY2?=
 =?utf-8?B?MGp4Mm13NURtZHhSQmZaRzlUVjFvYkZ3K1JpZDJOWllsdktCa2FydE02NUU3?=
 =?utf-8?B?c3pUcEI1Y1ZYVHBnVWd3MStJOFdpb0lWaDNUaW0zeldzYWtRdThKNXlBdkd0?=
 =?utf-8?B?cS9FckIyYmprRGxSUTl6UUU5bVM0eDY3c3JRNXFxTFpHckFia1QwSnZvNHJp?=
 =?utf-8?B?TitJa2dmaEluOHM4RzBKSkdyMjJEZWJnY29yTTB5M0Q0RDZ3R2xCRTN5aFE3?=
 =?utf-8?B?WjBHY1M0ZGI3d0hsK0ZWNW9maXpTdjZNTDFQWW0zOGx2Zmw2akd2OWx4MVBn?=
 =?utf-8?B?dklyc2RRL0ZZajdHTDFyT3NSTTZHbUZ0R3lKSkYvUllvVGxhK3lWMzZLRGto?=
 =?utf-8?B?aUtPYlVZakg2bzl1MTZTTXRYRkMyNlJMeFBBVVZ6WjZWcjdpMURGUTExWDRi?=
 =?utf-8?B?ZC8vcDV5ajE1YlRFUUVmVVQ0djIwUmxMakEwVXBRMUR2UjNYZTM1ZHN1UkRO?=
 =?utf-8?B?Q3R0WUhDTUROZjVuc1FxM05XWWhlL1pjVnJVOG45TzdVMFYzelJabXkzVFAw?=
 =?utf-8?B?V2RtcmRSemZnSzRMZFF4ZUdBd2RCOG5wVU16Q1lWQkg5QSsydGZNYUIvamgw?=
 =?utf-8?B?MHMyNzRDU2Z4QjFhMnI5MnptR1JNTzBkdUxjTVpaM1hqS3ZCa0g0NFczaXRL?=
 =?utf-8?B?eThMNWx2RkZpVWtNWSsvU2d6YnR6R0JtVXlHbjBLV1VFaFkyTi9VcUMxdGZC?=
 =?utf-8?B?M0xJbFJQUlNaMUJieEpVWWZPWTJhRVZpUENTdnNnNDRpYnVxdnJHNlEyQVdz?=
 =?utf-8?B?THp0RThHS2g2TGsrb25ZOEQ0K01XZG43K1pkMS92eFNBU0FHVmJxREJKRjBF?=
 =?utf-8?B?NGtKV0ZTS0J0QVlTZnYzOU1wVk1QUmhTaERrcjdTaWJ4bkNzUE9MWjdLNjFi?=
 =?utf-8?B?QVFHelhqSnp1MDI0UTJVczd1akFkS3FuV2c2aGpQR2FybmZhRDkrU2ZXTElx?=
 =?utf-8?B?QUdRRDRHN2xxUVBvbGV5M24yZHEvcFpXZ2lvNjVPUldLVjBaTDdmYXdOWUUz?=
 =?utf-8?B?WmprQjNKcm1IWG00S0JuZUdTVVY5RWhNK1kxS09mNnZIemgrM1phalpzdklG?=
 =?utf-8?B?Y1NHT1VZMzdqOGQyT25tU1hZVHBmMXZqMStPSElycU9xNC9nRUNaQ2FieGlv?=
 =?utf-8?B?MitiTDE2NkJsOStoVXhyTjRSOWxMM0drdFdwNFlNeUJxOEIxSWMxNDVjbkY2?=
 =?utf-8?B?cVljcysvVnVYcGxaZ01YdCtCRmxTZTVESkpNS2lYdldwYjBGNnZvQkgzVDlW?=
 =?utf-8?B?UjNRVms1cXk1SU1hcU1zOVdnSUZqaGhWa2ZxNTVlSC9HMW9kUmRLTUxjdEVB?=
 =?utf-8?B?NVdhQ0JGZ3hFM2JHZnBLR1l0NzhQYWhIWjRoRnlqYWFkTnRtZlllNlFFMVhT?=
 =?utf-8?B?TWpsUDRtSDl4b0RWQVNheEFlSWlqeFJsTXdCT0dMUG5iWFNzT2NHbElkSmhN?=
 =?utf-8?B?T3QrcHNsd3hkaWorMDl5a3hQbmlaSm5MQlMyOXZFV0RlOHhnMDBDVDVNKy9y?=
 =?utf-8?B?a3cwQTNERkN3bmdFdU84cENwNU55UTJYMTBHTVNOMCtKSWN0TGNSMEpxem9i?=
 =?utf-8?Q?xh/E=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(34020700016)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:13:30.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4e0c41-336e-46ba-93f2-08de17be80ce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121

On 10/30/25 4:26 AM, Markus Schneider-Pargmann (TI.com) wrote:
> ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
> debug_flags which are always 0 for the caller. Remove these arguments as
> they are basically unused.
> 

They might not be used today, but the TI-SCI command does support
passing them, so why remove that ability from the wrapper function?

Andrew

> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 49fd2ae01055d0f425062147422471f0fd49e4bd..24ab392b4a5d0460153de76fe382371e319d8f2e 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1661,14 +1661,10 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
>    * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
>    * @handle:		pointer to TI SCI handle
>    * @mode:		Device identifier
> - * @ctx_lo:		Low part of address for context save
> - * @ctx_hi:		High part of address for context save
> - * @debug_flags:	Debug flags to pass to firmware
>    *
>    * Return: 0 if all went well, else returns appropriate error value.
>    */
> -static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
> -				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
> +static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode)
>   {
>   	struct ti_sci_info *info;
>   	struct ti_sci_msg_req_prepare_sleep *req;
> @@ -1696,9 +1692,9 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
>   
>   	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
>   	req->mode = mode;
> -	req->ctx_lo = ctx_lo;
> -	req->ctx_hi = ctx_hi;
> -	req->debug_flags = debug_flags;
> +	req->ctx_lo = 0;
> +	req->ctx_hi = 0;
> +	req->debug_flags = 0;
>   
>   	ret = ti_sci_do_xfer(info, xfer);
>   	if (ret) {
> @@ -3689,8 +3685,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>   			 * internal use and can be 0
>   			 */
>   			return ti_sci_cmd_prepare_sleep(&info->handle,
> -							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
> -							0, 0, 0);
> +							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);
>   		} else {
>   			/* DM Managed is not supported by the firmware. */
>   			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
> 


