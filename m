Return-Path: <linux-kernel+bounces-878429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA8C2090E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5DF034EEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3725C822;
	Thu, 30 Oct 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aM6nyLWL"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481825B1D2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834262; cv=fail; b=bINlzfOL+JSyvZkBfs1BGJKJjBR2x2TkjwBKIxGgPT4eahYUPbFCCTbr89zW3zqF6KqP8vDBsAUKlEErJVd/N4Zeoid2Krb8kUvnR+VOO3W3rJyn8xXUpzd4FluCnlA1FyufAN1xqGe4BXpT3bejc2UU/WafYGP7rN/kmHWb7hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834262; c=relaxed/simple;
	bh=TnPfZFXcehwjr+iG2I+LOv1DyiIxFmAuGtmQ8hZIwis=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TrCyU9w7Zw3roCczr7efvdm0jAF888f+DcKNq8xgGyOq9sEmj5KCRPBfjHaVGzEVQFRkkBmE1F1x5GbM52F0rCCqOSWcjh+FgW2/7MQLz0Vsz6Ol0ihyQsq8kn+hrWpsb/gSp4gVmHKZRxEQJhnYoBHmo5Kr4im2sIZsxG0gI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aM6nyLWL; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti7kwJUyrVglEamultOEIPUhvnfvGJZYfAuf8rEdvgRHZCwIcYCcT+Vgch3k9u4fie7k/h8zPvNxmb0qQOBmUYTBL1e5Mjq7rg9D/77QIBn9PhVV+dNW58ZaNRSpbiTiR+rvvcfQ6xzrFeXuLHk+Pr4zLAIHi+6wjuzMYDOdofhXkwtgbxGzj+k5H8KQ7lDDTcx9KQR5ytzH+PAVyZJKjTSUEGMGSV0+Z/IUyjr1h9W8eOtMPzOVbssP8+BS9mNPFfeUnhu3Cy+Aqmh439h0QrConCkN8/ybLVwnVU/gudiPUZyk6CivQ1YDNvmKOJw7sHNyFQoxAfKXcXQ7Zv9wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuJTUtTOvRmcCxXNCk/9hTu+0zfey4/Hr7TCgSb3Uck=;
 b=uNdKEJk3eVp+j9PV1kB/X0VwTPQC+ugwh+djEH8jpBcWRYK1bdJILARpIGHV9vTCYO2upVtGorj30ScjqK4Gi02LvvVl0gyKza8u5ed+ypS2InYoe/QdxvvbDZOaYUFIknOCrIN7pSS8ALBGRjp/MRrDbZNCMR9h/SCGdTKReOx50crnsvJgMGoQCYGdLIebjxf3mBO7PfuuDRbNiLMRQXbbZL8rDJc4msaHzBIVLYvizkDoTe9CrwByG3AWuMtRNlsJx3IjUDI20Fx3jViLbOfsNxJC5fcZ1BNKceS0qcSoVCaWAZj5EuHLTkpHq0nSbofpBobvt9npCRwIivFSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuJTUtTOvRmcCxXNCk/9hTu+0zfey4/Hr7TCgSb3Uck=;
 b=aM6nyLWL3uCuWJEYXwr7P/sheqb1InygiL1aOpk6Qb1gCtLxBJ+u4a/g8eLngOCRbyGInPkTF60y82g1dQcPK3/46k3u8Z8mLgOb//vCx44Pka61I9bS4VLMcKJ9qisk1MN+MSS2XQblWMPLfXEaKgZ9FLf68GeXCS272On1Vs4=
Received: from SN7PR18CA0014.namprd18.prod.outlook.com (2603:10b6:806:f3::26)
 by IA3PR10MB8162.namprd10.prod.outlook.com (2603:10b6:208:513::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 14:24:16 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::b5) by SN7PR18CA0014.outlook.office365.com
 (2603:10b6:806:f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 14:24:15 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:24:06 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:24:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 09:24:05 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UEO5kY2326151;
	Thu, 30 Oct 2025 09:24:05 -0500
Message-ID: <d3209c85-dc30-4f9a-8ea5-3c3e19330afd@ti.com>
Date: Thu, 30 Oct 2025 09:24:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
 <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA3PR10MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: c775bbdc-41ec-4d6d-9ecf-08de17c0011d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|34020700016|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTZDYXRkT2xrNE94T3lOVTNXN016a2pzeklwdkVRUlpCMXBKSUxTQUhGb3dE?=
 =?utf-8?B?VHZSQldhUDZrZVhuSHM0NG1NcU5oVC9vMFpBRDh4ME5FckJET1IwU1ZYZEdz?=
 =?utf-8?B?VGtIRndhTVRQQ0FnKzZ5L053MjE5YTZPQU1CamdTS2hnR0Y3VWdISitDVi93?=
 =?utf-8?B?dWtvZ0xhMDJZWUU1WGdXeExQZGgxc21QTVA1TFB5NDFsVDRzUGJRaXoyWCtL?=
 =?utf-8?B?R0ttOTJsb0JJbGRJSkpVbER0L2l2QW95blREUHhKU0xpc2RVUm90ODZqSzFp?=
 =?utf-8?B?YlczU1ZqVDFYYU9yYVBOcFVZc0RwT0J6a1ZoVnpoeGczS0gxRlJUNUZGcjRT?=
 =?utf-8?B?SEFhd21scFM2eUttWjFDR0JaNE9OUzY1TnZncjBIaFdIeUV6RDZBTHdyOWxr?=
 =?utf-8?B?NWFHanZKRi9GR0FqS3dMcTJFVE56cW9TNmVtLzZMZ2hEN3RiSGUvRkRXT3J4?=
 =?utf-8?B?SkRGTkI0M0NJaUsvamNNN3Q4Sm5OWVNmOThiNkc1Z0M3ZWNJMVBjQUhQLzV2?=
 =?utf-8?B?SFljR1c2TUZZb3pnV3FLZkhjMHRadENBMzA0UUVabFpQcFpwM2txU1FLWXc1?=
 =?utf-8?B?clB5UllBNm1IdE9hSitSYzM3Rmh2QlNBYlc4cllCQVlwd0hGUjZUUzhoY0dO?=
 =?utf-8?B?M3pURk9nUk9ONUY2REQweml5QkJKaFRBd2FrUjgxWDVBblZSZXB4VmxleXp2?=
 =?utf-8?B?MzJZenVwZHlWNUZ6LzhBRFZFVjM1Z3hMb1Bqa21jRE93U3NuZjJZcFI1RkVu?=
 =?utf-8?B?ZU9uZmNHZVlZSlB3dUR3Qzk5eC9EakVQVzA3QXdubnFQVXJwNzloTk14RnVs?=
 =?utf-8?B?WkQ3dHdZNjdOYUpTcjk2V1FnVDExczRxa0FHY1BVZDcxNEF6Y2Y4YlE4cENy?=
 =?utf-8?B?QUpsZ0swL2UySWFPT25YWnJhK3RuWld3bzExT0txc1RzVzBYaEZDTDdqNVNX?=
 =?utf-8?B?eU84QzFVdUxac29tZkx1UUV4MGUyN1ZaUXlOKzV4bElnRnpsOUhiYmx2azlC?=
 =?utf-8?B?MEVaNTdxdTZsYTg2SHVQOGZidEhsbWw5Y3dCQUdsRDU5amhyczNROURQeGxK?=
 =?utf-8?B?ZHlRQzZGbXlML1JETlpkelZuOTJKMnFnT1RZU3crNWJicXRyNzNUODF5R3NY?=
 =?utf-8?B?NVZCb2xsRFY0cEtYSkc0L0JETTlyam9qVnNUWEJrZ3UrYytFVW5LdDFLb1dh?=
 =?utf-8?B?Q2dNNFhjdWQ4ZEt6TjN4eTRIQnJocnh3ZjVpbW1oUVc2WDlrQW1pTHJRR2lO?=
 =?utf-8?B?czRjaTRDdm5Bd21nVVIvS1dwMWNCVHpYUXZvMy9KUncxTk9IeGRoR3c3RFpE?=
 =?utf-8?B?YjE2cGJNbVpWK2tEZHkxOGVpQTJ2aG93VTNocUhTYnMwNjdBMjR4bjhOWVdp?=
 =?utf-8?B?aUNzdnZhQkg5KzFkeDlqeWtiblVObzZsTWVPYXhMa2RvMEFVOEdlSFZmRFQz?=
 =?utf-8?B?VU1QTWhXMnpTcHpEQ1ozVm15WUpWa1JodEllKzRsd1g5M2swOUR0UXo0K1ZK?=
 =?utf-8?B?cEs3WE5vcHFwZll3LzI3ZE54eUNiWEhTTTh5N1VGOUVQaXI2d3JkMzVualJ4?=
 =?utf-8?B?bjZFSDBhUGJWMlM0OEkwcFRmR000c3F3UGNhNVFteStuTjQwQTdzbndvZWlu?=
 =?utf-8?B?eCt4M1ZGcmN2L2lvYVV6SDBVZjV3aVNBTWtkVmZVWWFwSW9VeHR4TlFYUE84?=
 =?utf-8?B?USs4QUFFTWNLck1NR0VPb2VWeEt2b1dXcjlLNExQVFBqaWhmdkp0d2o0SjdN?=
 =?utf-8?B?TzNXWGExZ0FPQWFtc2lNRzY4VFh6b1lnV0VSOUM4eHk2eFcxRk55TktmL1pn?=
 =?utf-8?B?MERqSmtoVFRJcHVvNmprMGFBSUZzbld3eWR4UWgrd1h2Nmpld1c4cFBWb09n?=
 =?utf-8?B?TXhkdWs5ZS9BbENFYWphVlVNSGU0U1hZbEFVR2U2Q0pmVUNuTFUyOXJ2OHFX?=
 =?utf-8?B?dFVoUWFWNFVJWHY1Q21NNDE5cEdHZE9JbCtDM20zN1VWaThMQkpWRUlsSmo1?=
 =?utf-8?B?cUhNREdtOGFSTUhxYzA0cTV5bW81Mlc4NW9pejVmSUJhclNNUTdEeDVtRnQz?=
 =?utf-8?B?MXQ2aEpUb3VZSTFHWGtLdG05NDV3NXBYNXE3KzUzSFk0OHhmNVZNSzNGazhC?=
 =?utf-8?Q?PaE8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(34020700016)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:24:15.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c775bbdc-41ec-4d6d-9ecf-08de17c0011d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8162

On 10/30/25 4:26 AM, Markus Schneider-Pargmann (TI.com) wrote:
> Add support for Partial-IO poweroff. In Partial-IO pins of a few
> hardware units can generate system wakeups while DDR memory is not
> powered resulting in a fresh boot of the system. These hardware units in
> the SoC are always powered so that some logic can detect pin activity.
> 
> If the system supports Partial-IO as described in the fw capabilities, a
> sys_off handler is added. This sys_off handler decides if the poweroff
> is executed by entering normal poweroff or Partial-IO instead. The
> decision is made by checking if wakeup is enabled on all devices that
> may wake up the SoC from Partial-IO.
> 
> The possible wakeup devices are found by checking which devices
> reference a "Partial-IO" system state in the list of wakeup-source
> system states. Only devices that are actually enabled by the user will
> be considered as an active wakeup source. If none of the wakeup sources
> is enabled the system will do a normal poweroff. If at least one wakeup
> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
> message from the sys_off handler. Sending this message will result in an
> immediate shutdown of the system. No execution is expected after this
> point. The code will wait for 5s and do an emergency_restart afterwards
> if Partial-IO wasn't entered at that point.
> 
> A short documentation about Partial-IO can be found in section 6.2.4.5
> of the TRM at
>    https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/firmware/ti_sci.h |   5 ++
>   2 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 4db84a92a517b0aa7bb8d47e809d9848a16e2cc4..f2922fccfbe748a436cb9aa0a8c8e5f48db02ef9 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -6,6 +6,7 @@
>    *	Nishanth Menon
>    */
>   
> +#include "linux/dev_printk.h"
>   #define pr_fmt(fmt) "%s: " fmt, __func__
>   
>   #include <linux/bitmap.h>
> @@ -3663,6 +3664,116 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
>   
> +/*
> + * Enter Partial-IO, which disables everything including DDR with only a small
> + * logic being active for wakeup.
> + */
> +static int ti_sci_enter_partial_io(struct ti_sci_info *info)
> +{
> +	struct ti_sci_msg_req_prepare_sleep *req;
> +	struct ti_sci_xfer *xfer;
> +	struct device *dev = info->dev;
> +	int ret = 0;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
> +				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
> +				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
> +	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;

This whole function is almost identical to ti_sci_cmd_prepare_sleep() other
than you use a different mode here, which this different mode can be passed
into ti_sci_cmd_prepare_sleep() just the same. Only other difference would
be the NORESPONSE flag which you could just check "mode" passed in and
use the right flag for the mode.

> +	req->ctx_lo = 0;
> +	req->ctx_hi = 0;
> +	req->debug_flags = 0;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +
> +/*
> + * Iterate all device nodes that have a wakeup-source property and check if one
> + * of the possible phandles points to a Partial-IO system state. If it
> + * does resolve the device node to an actual device and check if wakeup is
> + * enabled.
> + */
> +static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
> +{
> +	struct device_node *wakeup_node = NULL;
> +
> +	for_each_node_with_property(wakeup_node, "wakeup-source") {
> +		struct of_phandle_iterator it;
> +		int err;
> +
> +		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) {
> +			struct platform_device *pdev;
> +			bool may_wakeup;
> +
> +			/*
> +			 * Continue if idle-state-name is not off-wake. Return
> +			 * value is the index of the string which should be 0 if
> +			 * off-wake is present.
> +			 */
> +			if (of_property_match_string(it.node, "idle-state-name", "off-wake"))
> +				continue;
> +
> +			pdev = of_find_device_by_node(wakeup_node);
> +			if (!pdev)
> +				continue;
> +
> +			may_wakeup = device_may_wakeup(&pdev->dev);
> +			put_device(&pdev->dev);
> +
> +			if (may_wakeup) {
> +				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
> +					wakeup_node);
> +				of_node_put(it.node);
> +				of_node_put(wakeup_node);
> +				return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int ti_sci_sys_off_handler(struct sys_off_data *data)
> +{
> +	struct ti_sci_info *info = data->cb_data;
> +	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
> +	int ret;
> +
> +	if (!enter_partial_io)
> +		return NOTIFY_DONE;
> +
> +	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
> +
> +	ret = ti_sci_enter_partial_io(info);
> +

No need for newline here.

> +	if (ret) {
> +		dev_err(info->dev,
> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> +			ERR_PTR(ret));

Why cast this int to a pointer before printing it out?

Andrew

> +		emergency_restart();
> +	}
> +
> +	mdelay(5000);
> +	emergency_restart();
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int tisci_reboot_handler(struct sys_off_data *data)
>   {
>   	struct ti_sci_info *info = data->cb_data;
> @@ -3941,6 +4052,19 @@ static int ti_sci_probe(struct platform_device *pdev)
>   		goto out;
>   	}
>   
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO) {
> +		ret = devm_register_sys_off_handler(dev,
> +						    SYS_OFF_MODE_POWER_OFF,
> +						    SYS_OFF_PRIO_FIRMWARE,
> +						    ti_sci_sys_off_handler,
> +						    info);
> +		if (ret) {
> +			dev_err(dev, "Failed to register sys_off_handler %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +	}
> +
>   	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
>   		 info->handle.version.abi_major, info->handle.version.abi_minor,
>   		 info->handle.version.firmware_revision,
> @@ -3950,7 +4074,13 @@ static int ti_sci_probe(struct platform_device *pdev)
>   	list_add_tail(&info->node, &ti_sci_list);
>   	mutex_unlock(&ti_sci_list_mutex);
>   
> -	return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
> +		goto out;
> +	}
> +	return 0;
> +
>   out:
>   	if (!IS_ERR(info->chan_tx))
>   		mbox_free_channel(info->chan_tx);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 701c416b2e78f8ef20ce6741a88ffa6fd4853b2d..09eaea54dd5cabce72dd1652c9603e3ab446b60c 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -595,6 +595,11 @@ struct ti_sci_msg_resp_get_clock_freq {
>   struct ti_sci_msg_req_prepare_sleep {
>   	struct ti_sci_msg_hdr	hdr;
>   
> +/*
> + * When sending prepare_sleep with MODE_PARTIAL_IO no response will be sent,
> + * no further steps are required.
> + */
> +#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x03
>   #define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
>   	u8			mode;
>   	u32			ctx_lo;
> 


