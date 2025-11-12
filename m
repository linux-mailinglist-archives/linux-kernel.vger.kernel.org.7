Return-Path: <linux-kernel+bounces-897563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27AC537D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89A1500578
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3733F378;
	Wed, 12 Nov 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n/zycsD6"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1C3101A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961195; cv=fail; b=aftmjbidG/rxCGNNwkWG4nFx3I9gv+27WeJ0EKVOfYt3A0uJLzlQqWvfYUg2WqlvAT9hdWEyvJym5UIzUB5kCUB3igWcy5YXcRZVjXZzNbc2oSbwizoElH9QLJaF4rdwVRyXTyDFAVdzussM/J+IAsh3ZkEeOdPfqBGLHpmWDG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961195; c=relaxed/simple;
	bh=O5fLBikLEbnIfliLG6uPY4+jXfdwVHz2TI4Y4E2tNzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HOGQ0zg3Eo63LiAfDgIIx6LQkbos0UWXeU3WNJM4GkACMnknIKIOkFxzIGWpnefk1MDYI2qfNJSVOAsKpK4ZLGC5OzY7h1ZjL2xTzANEoYrWpf9EmlwZQwlgPO1jN2mtRTHzzViwMTUndhQyrjYah71xdqLI4sbWjOg33cLTheY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n/zycsD6; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlC0axKr90hMw3SFgXzhUqPOedaktDJK/+l98/1Y/BcqwgLcd1Lobl6HLkZjcWBZd2MaV3qy2K6FpN2ovCJpBNQM067xHGgJgCI9ll5/jrR8Lxv79OjCwY5sA6n8uS09jJ1ol5l1JgAHFicDssEzG5qCDN1jYrfyzBBQhke5+tnipNM2czYYkV5moTAPTRef35QXKP905YjxSVB9cEDeYcIJHCKvAfbfG2B7z66GkeNzVJ/WH18MxW+gDrW6QtYIFwSmdSPypX40Rne6gTz7FlpBqf83KXvq94CZ3EJ6u38ZO+/5CsPNeL2WioHv6gPYYYJwjA96mKxYU68z/FhhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhlI/vSFSAspE71T0ckc8UpsUTd5b+4k64on86P2rBM=;
 b=bWnAt7t20YZXTONi9yKqkbCKmGj7rciSZ9uKceYc+cAPYDm9zHRSEETltJg1AIydQPCWH4uIa3/usKNflJe1NUqWo1JGhe14tcY9wYbqbXqfOpdsZbpeA+w+j90kcdRY7C1VLz1I7SEr2jX5Rxtjk7qJZ7hykEpvnfvlrbNvJLSyv507T6whcHImkASgcnVJTiUF5FfdE30aiHrBcSTaro/3y9R11XH3uQ7LtUBKW20QKyUzOQqPBWRgZQx/fPX2WUuXb4kQSR7UqhGlri0u6lRG/jhU4OjY/NFYECtQZ3RxzIMk0rYLBi2JXIxn33YIftioAY8tf5yqR12guYIr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhlI/vSFSAspE71T0ckc8UpsUTd5b+4k64on86P2rBM=;
 b=n/zycsD6JBrDb+pJe9oQsEpdFUMTy1CZwzzOfP24nqc2tIAPQrSszCMP8X+84lNneDqbYoVqi+8qlYakErICOE0MsLyeDWuTbEOShecgzq/aWphaFSSypwYHzxw7ntdFibztdyonvW33iZAZf3A3ivEmyb7JQkrihU6SFKj4GFU=
Received: from MN2PR06CA0025.namprd06.prod.outlook.com (2603:10b6:208:23d::30)
 by MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:26:29 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::11) by MN2PR06CA0025.outlook.office365.com
 (2603:10b6:208:23d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:26:27 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:26:18 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:26:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 09:26:18 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACFQHOa2875701;
	Wed, 12 Nov 2025 09:26:17 -0600
Message-ID: <bc987a5f-ee3f-4722-92e5-056bef4d84f9@ti.com>
Date: Wed, 12 Nov 2025 09:26:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] firmware: ti_sci: Remove constant 0 function
 arguments
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
 <20251103-topic-am62-partialio-v6-12-b4-v10-3-0557e858d747@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-3-0557e858d747@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MW4PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a743f75-1823-47d6-2734-08de21ffd94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGFwZEdnV25Odk1IV2I4aVJ5elBOMjdWVUNKUGlpYXlseG1PR2o2emQzZFJU?=
 =?utf-8?B?TVJiOWp2eGNUYUpEZk0rd0VrcEZQNVozUmlhdjE0MTZXT2hxQW5TR1pPZXh0?=
 =?utf-8?B?RzlvRE9WbHFNUzRSdVIrdmVBZUVuNkJvTHJHZkdNRFBCYTFYVWlpdXZlWlJm?=
 =?utf-8?B?aEs3REVQeDVRNnd4WEdRSktJSGI4YjN1cUNvWUYxMEIzUkxrSDNJQktKM3k2?=
 =?utf-8?B?WnlyMzVMdE12YVl0YklUSlNDdFZLOTRvdVYzWVJhRHd5c0dZbXdJSTYwSWF0?=
 =?utf-8?B?S3paRDFSV2NKaDE3c01YVGlXb2hpUjBlZkNIS21veW1xQ3hUZnpCNS9UL0VO?=
 =?utf-8?B?WVlkSUNrS0lnVFpOeFlYT0RoeDEyeW9pVUw1cW9MNTduYnBxVnFOdGc1a0tP?=
 =?utf-8?B?b3NQMWNQSzB2amlzeWVVdnZVRnhDYkk5MTdGTE9JQVJzTjdacHBqRGtTaThH?=
 =?utf-8?B?MFpXQitUcFBtT013SldJK245VFRKZEJxYi9xYzBtMDY0OWU0SU1abjFMbW5Y?=
 =?utf-8?B?R2ZVQ3A1Q3hPZmhUU0V2eDlTRW5HMmRidVlwdU9mM3cwUnJPS0QvQ0VrOEtL?=
 =?utf-8?B?MlRkQlJOdUZJbTBsVklybTI0ejFmM3k3RFR2M1o2NFFsOWl0c0RYcktVd3Rl?=
 =?utf-8?B?UEZ3bDFha0sxZlhORGpaWmVJOHcva0tPV091cGVKN3ptTmJuYm9NWmdvZlph?=
 =?utf-8?B?Y0V6WnR2YldtNHI3VE5Kc3BPcUZMcWladDY2TkU1Rkx3N0JiaEtsWWIwc3Ft?=
 =?utf-8?B?aGRLTjVKSGZVRFM1YURMeFVTd2hrREhVTFdQM21YalN4ZER0b1hBQ0hLWmZG?=
 =?utf-8?B?Sk00YjdwNXFjb0gweXJyT1Y5L3I1WXhTUHlJRXppM0Y5emZNMGJWYTBvcXR3?=
 =?utf-8?B?TThZQnc4VThkSGVUN3dZa3VzMUllRWcxYmRtR292RkRpMFBaT29jZjFhSmha?=
 =?utf-8?B?ZWsvSWthTmY1M1FjSldjbHFES0Y1MU9ObXpWTnY3ejUwbXRjSGlXUWlBSnNH?=
 =?utf-8?B?RE8rTElNaVI5TDNXNXFBU201a1VXZ2hyVjRLdXJoSDhQZWt4cUFwaldWaTB6?=
 =?utf-8?B?Si8vajBXbjNJVGVVUm5PaHE5M3BuQzA5b2Flb1MybUZxcjkxUnJEeUpTMTJO?=
 =?utf-8?B?Mkw3MzNXaWxHS3B1dlRCb0JlcHROVlkzME9uYm9ENFpvY0FoY1l0eU0zd3dw?=
 =?utf-8?B?dHFDNk9wK3pyUXlqZUcyNnZjL2EvRExlbXBxSndQNkYrLyszbmNXSlFINTVr?=
 =?utf-8?B?S25xTlcrdlJ3Y3ZCNjQvTHlEWmYzQWZQVUkxQkVRYytIbGpPeUNQR3JsNTd4?=
 =?utf-8?B?NHU5NEhFTDVNcVF5bkNVenpFbDN2aEEwTVlld2FrTXNBOUFkcWliOURsZURD?=
 =?utf-8?B?K1d1R3RXSGhLWXlxaCtDSkhSNDRCQlJsMmxpQTdGT3BFcSswOTdBTGpEL2pS?=
 =?utf-8?B?NFpGZkFHOFdSS1A1SUFBdUdqRk1yTmEybmRKaVArSmdoaWNVQ0IrS3VXUXRD?=
 =?utf-8?B?cUpPOVVJN3plTkxobjc0UFlPczkrREF0SHdLMUdQYXJSODZIeHhDWXBTOWZB?=
 =?utf-8?B?bW1jMXZ1eThWTmZBU3lzMXV4WWx6TCtHRGhpa2JFZWVNL0cyQUpucHZRSksr?=
 =?utf-8?B?ZWVCcVU3UlNjQ2lLR2tPdTRUYkg4S3lGY2lDeWNaTDZMcUxmY1ZIZGp2MVVK?=
 =?utf-8?B?WXhMdXRmRHFYVGFma0wvNFhIdlFyNFVwNnByV3hwdHpQOGNEUk90TWx5Z3Fx?=
 =?utf-8?B?bXJjNTdVR1BDUUlPVXBXQ3JjM3VjL0JZOXN6QVFobVMyeFVUOVN6ZWFKMVZW?=
 =?utf-8?B?NlVUM0FGQ2o4dEllN0tvRm0wNzhWa0xRNXFHWDVzSm1pcWZib2dVOHhnLzlQ?=
 =?utf-8?B?djhDQWhGRTlHTTU2dml3VjVRR0lDV3pUaW1YZ3pHMzJpbU40TDg4T1o1bWF1?=
 =?utf-8?B?andYYnhvVTBSd0N1VkZPcVMwUGU3YjZtQlhQdE90eE9LNU4reGREdTZSWU55?=
 =?utf-8?B?NVZCWmdVSlg4TXpydm10akZBL2tIUTR5aVllZDE4NG10ZExJdTNUZUxLNjNN?=
 =?utf-8?B?czlxSXV2TkRBY2xYTTY4RGw2T0haR3E0bmVIdVB3STNJT1lXWGdnZ3pqdUlx?=
 =?utf-8?Q?HOkw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:26:27.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a743f75-1823-47d6-2734-08de21ffd94b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419

On 11/3/25 6:42 AM, Markus Schneider-Pargmann (TI.com) wrote:
> ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
> debug_flags which are always 0 for the caller. Remove these arguments as
> they are basically unused.
> 

Does that matter? The functionality is still available and when we do
use those arguments we will just have to revert this patch.

Andrew

> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 811507ded63ac784ad6c6ad77b2f827768f3f3c7..023c603ae58cb5df176c66eec429bd0b4037b798 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1664,14 +1664,10 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
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
>   	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
>   			TI_SCI_FLAG_REQ_GENERIC_NORESPONSE :
> @@ -1702,9 +1698,9 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
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
> @@ -3729,7 +3725,7 @@ static int ti_sci_sys_off_handler(struct sys_off_data *data)
>   
>   	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
>   
> -	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO, 0, 0, 0);
> +	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO);
>   	if (ret) {
>   		dev_err(info->dev,
>   			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> @@ -3768,8 +3764,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
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


