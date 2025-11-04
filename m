Return-Path: <linux-kernel+bounces-884076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5BC2F4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858BD3B5519
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2892609FC;
	Tue,  4 Nov 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dlBEgmDY"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azhn15012031.outbound.protection.outlook.com [52.102.149.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3CC4400
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.149.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230540; cv=fail; b=ilwAOdlc9N4Ii8pzJfQFHQGL6cxBGCIpd1NHNcRBZPJG+5Geg8R/2K/xiSEzujxUj2qQ4ICgQdt3bFX5OMefhonp2ZD8jbhqaRHthDk+ozPsd6VycSnaGh4Klyr5w3SMVhAR7EgSowDjNr+BkRTMQSI4f0RhmYyp3QKnzUhAieQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230540; c=relaxed/simple;
	bh=q//2OdYLVH2vkgd5oSlu2ghfviIB9aXa9pC28uQXOFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jWujrA23SZu3AxGR8dUwRyOMcsgveOJSVINWcu5+YecnRJrCWxL4D0dYnUhYs1ZZpWDwj7H20uWHC7tUEgtPdHNPc19b0Hg7gI+rGBlzBaUl/HT2MhK8e4uU1j5EDNbtcky3j+XX8u5rit1WIZVdxeasvnLkWLptHdTWqapTPFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dlBEgmDY; arc=fail smtp.client-ip=52.102.149.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaEA5UeQo3mxdvCJZ29TZlLjFe/TfhGDZK2jdq5eKdWxrpWHdwGHv97gygMc2SBfRPe3Y2ZGduwPYx45Dstsm+wIoh7BmnWuuunasDGvhR6f8MHIr7gAnkvWLFMnY1scTnvMb1yxPxke08XVYvwyGjdsHxko75AlB3kv7x2L03uS9BCBA6hAH/XW0aIrXFT/yQC0OD+z7xy3EEUtRCLlXoaDFRlX9Aya1300uC2bId6LAuQEBYXWJ6bSASmaWIBXCH+EiTF61h6+Ed19MegAFsc5VwSfieHCLRVF/up2Gnb7JT97npQRL6doLX9Hel6zYLGO2unF56RzFKGvBarbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w4j0mjWxQX0m1CQn0UOtVEWE6xG5GOmftF+T3kYVEc=;
 b=iMCQENkRI6e3hjUQ1D22iMCSf7mO/8o5kPyqbDYmD6RNUOI3PEJ45UZPKXCrLdD6zrn3gzwakx96dj2JBfwS0xs67mD7Utvl43Ia8YySO6AeQwHGxuMZ7gqESlG4gYTiHMUmrI2M/zOQOT9Tghbf6pJNQ+iMt7/LepUU/6HDdNoxY7G+Ks5uhMRRQmL3Rdje0yzdxUomY4x+Ga/5nPckP/DflOcB7pnX3TXyrWh35mkMiI9ZSgkWdUQCrV6yzVUGEj79YBwrom8WAQ7WzRgaxFQTmEwHh0GIStzMCIgMLviofC3eaLaPdBlTVGMh7Cf6mTDGBnlyGwqcsOeganwAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w4j0mjWxQX0m1CQn0UOtVEWE6xG5GOmftF+T3kYVEc=;
 b=dlBEgmDYhkuR7m7mCWLwzMVgMSaxhrcLOFBgow2T1O9VAh62DlTaVtHojmdJ62sB3aq9J0lfLsCNkyy1HFnylV39FaXV2CeFq2qZYm+xb1Odh1wdXSwWOaDZ3/qZfvZY4x470rZkfGV7oc++mEYW8n7wgIouCnkwlXSeH3Uf2QM=
Received: from BN8PR15CA0010.namprd15.prod.outlook.com (2603:10b6:408:c0::23)
 by MN6PR10MB7424.namprd10.prod.outlook.com (2603:10b6:208:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 04:28:54 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::25) by BN8PR15CA0010.outlook.office365.com
 (2603:10b6:408:c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 04:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 04:28:52 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:28:49 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:28:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:28:49 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A44SkxE1295392;
	Mon, 3 Nov 2025 22:28:46 -0600
Message-ID: <97f1abc9-7e1c-4d13-a46f-451612f94a4d@ti.com>
Date: Tue, 4 Nov 2025 09:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: omap-mailbox: Check for pending msgs only
 when mbox is exclusive
To: Andrew Davis <afd@ti.com>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <hiago.franco@toradex.com>,
	<francesco.dolcini@toradex.com>
CC: <hnagalla@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
References: <20251103201111.1417785-1-b-padhi@ti.com>
 <20c226de-c53a-41f3-b432-6f75a6f83e75@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20c226de-c53a-41f3-b432-6f75a6f83e75@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN6PR10MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e69541a-0324-4e6b-fbc9-08de1b5aa8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|34020700016|7053199007|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU9BUlAzUmFrNFdlVVZjdVBzYlhKL1pCckZFU1EvQ1lMY2pHT3BGOEhnR0lP?=
 =?utf-8?B?bWNSSDBUSnJ2Q0xqM1NGdkJIVEtTbU5ucytBcjE5dlArdG1BYmY3ZnYvNW5s?=
 =?utf-8?B?aGdZTUFCanVKU3VYZFBBKyttMnIwOWlqOFM5N3g1b0c0dzRJZFlYNmgvTmtI?=
 =?utf-8?B?cVZWK1R0eW5CcFQxMGZFcnRUK0EwcDJzSm9tNTZ6S0NkdGtSenRSL0FtdVh6?=
 =?utf-8?B?dFA1MmRXendnLy9EMW96TkZHWWh6RktEZURWSitZQWpYcUQwempvMk01NTdm?=
 =?utf-8?B?TEFuSHdVeXRHRnd4OVBPc3BBRTA0MGFXZnhDQlNNTHpoMTl4NmxFdXdLRHhp?=
 =?utf-8?B?TXZETENtMmVaam9odzhOd2xVUW9vVE1kNkNqVGNqUldORm5leGN4V0V3Z1Jh?=
 =?utf-8?B?a09seWxDSmF1VE1Uc0pyQ1FmMGlSb1ZrWFZOZ21pWm9TSlBuQm9rcjB1akFW?=
 =?utf-8?B?aXVxUWxrMGkrNDVielJQZWVxei9JZk4raWs4MmhnWkpmSUkrdDJBU2xaa3JW?=
 =?utf-8?B?elVpNHdNLzRBMEw1V05TOXJGS1dDL2hqZlFlOFFMTDB4MXhWcDAvU21IVTlY?=
 =?utf-8?B?RXZaeS9XMm5PaE15T0VEM1NYWjJ5dFphVFROL0lXTGliS1Zic0lpN2EvdVlk?=
 =?utf-8?B?djlUN3hZVEoreHFiRTBCVC9PS3Erc0hSQitVZFRiMzROUnZGQTNPNVQ0amJ1?=
 =?utf-8?B?aWhmZXhUZGdFTVk2M3RWUzJjdG5iS2FERUYvY3ZyRnVxUDEwakUxcmM1ZnIv?=
 =?utf-8?B?a2NKcFoxaU9MTHB3UUo3MkZKMDhnMW5jdWpieWg4eDhHZHpvQXh1Y3hBcnJa?=
 =?utf-8?B?dFo1WmRVS0ZMRXI0ZnhnSDRkOXVJTkw2U1pHdWs0Mi9FNHZDUXZEbzd5THds?=
 =?utf-8?B?UGVxd0xENEZrd0pDNVZXVS9RcmNmZlIxcUNaOGNMQ2FjTkNCNVdRK25RYTBZ?=
 =?utf-8?B?aW5CeWltbjdBekp2NzlGenl0b21pajJDckt4OEUydXZKaVVtL2I2SGMvNHN1?=
 =?utf-8?B?TlQ0Mnd2WHloU04wQTJKODJxYVM0RVRvS3VnNXlZSk45bVkzUXhoS1lSbDRC?=
 =?utf-8?B?VWNTYzRHMG9aZHh0YThpNW1mUm5BOGVrQU1GbGJwZHdXTE9FMkJ0VDVvY2Jj?=
 =?utf-8?B?K3dwVlRzVk5yekxhV1FJZUNKT2gwVERvNUluUnVseUtVM0I2UDNZcThsa2Vv?=
 =?utf-8?B?ZjFzbExQV0RSeGlsTWtKNmZoeVlFUVNzbm5tRURwOGlsZzcwd1ZaY3VTL3Jw?=
 =?utf-8?B?VUNlMFFmNWNGTXJxSTd0OTFETnNscWlBVW9Vb0xibnlVR0lSdWxnclFyOGJY?=
 =?utf-8?B?SW03QktpRHNnMFN3cDEzTnljZm5BVGUyTUp4ME9PZFd1SlN6Y2EzLzFwUkMy?=
 =?utf-8?B?S1hHMFErUlVOVVI4czZCQ2IwYS9PVHNvMlAyR2syeHkwUVZBbWZER3BGNFpk?=
 =?utf-8?B?eFNyMTR5TWt4OVk5b2N6N2FUQ3dmSEtSTHhQZ2VBdFlvaVNvS0lDWjluQmRs?=
 =?utf-8?B?MkNSL3FRVFdrK2FpMW03VzEzY09jWmcyUTJQMVBrMWJOUjlwUmRuSlVKb3c2?=
 =?utf-8?B?aUlzMzBVSmpHbVB2TDE4ODdDeEZVQVQvLzFPRVBUL0NwRTJWNE1BSXo0SUxL?=
 =?utf-8?B?U0VxbmdPUWw2ckpwZ2J5SDBCL1pHM2hIeGlPcmdyRGZ3a2FxVE9ReURzTzIw?=
 =?utf-8?B?dUk1NStkNWNXZFdxKzlWY1BsNDJMeE9tNEZTT3RrNlJtaEZSK2dJWTlmZ3NV?=
 =?utf-8?B?dlBxY2NFR1JSdXRSZ2l1dmpPeGV6ZGcxZlpYeWZFNkVaaERkcnBwZHk0OXM4?=
 =?utf-8?B?N1FJMWNXWS9HTW1BVDluT29CNVJpeXhJdDR2QUhyT1NBSkZVOXRvU3k4VVJU?=
 =?utf-8?B?cGJLa0ZwZnZFbUtpQkhBRFZZMWJoU0Z0Q2cxZ0RjT2gzdFZWVUdSTTQvVzBY?=
 =?utf-8?B?bkpWZy8xNDYvWnhtRkI1TW5qcnE5UzZZeTVnazZYSFlXZFI1Q3NjS2ttWFR5?=
 =?utf-8?B?dUhmNVdDVjNST1YySFRtNTRzTVU3YjBzOTFkdFl0Z2hjRWhyTml6WTZxUVJT?=
 =?utf-8?B?clBHQkorNW5oSWdza0lwcUQwSlAycThKNVMyS1paOXZNdHl4Q0VGbTM4Vjg5?=
 =?utf-8?Q?bisk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(34020700016)(7053199007)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 04:28:52.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e69541a-0324-4e6b-fbc9-08de1b5aa8c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7424


On 04/11/25 03:40, Andrew Davis wrote:
> On 11/3/25 2:11 PM, Beleswar Padhi wrote:
>> On TI K3 devices, the mailbox resides in the Always-On power domain
>> (LPSC_main_alwayson) and is shared among multiple processors. The
>> mailbox is not solely exclusive to Linux.
>>
>> Currently, the suspend path checks all FIFO queues for pending messages
>> and blocks suspend if any are present. This behavior is unnecessary for
>> K3 devices, since some of the FIFOs are used for RTOS<->RTOS
>> communication and are independent of Linux.
>>
>> For FIFOs used in Linux<->RTOS communication, any pending message would
>> trigger an interrupt, which naturally prevents suspend from completing.
>> Hence, there is no need for the mailbox driver to explicitly check for
>> pending messages on K3 platforms.
>>
>> Introduce a device match flag to indicate whether the mailbox instance
>> is exclusive to Linux, and skip the pending message check for
>> non-exclusive instances (such as in K3).
>>
>> Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware")
>> Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l/
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Hiago De Franco <hiago.franco@toradex.com>
>> Please help in testing the patch on Toradex platforms.
>>
>> Testing Done:
>> 1. Tested Boot across all TI K3 EVM/SK boards.
>> 2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
>> 3. Tested mbox driver probe & device boot on AM57x-evm (OMAP5 based).
>> 4. Tested that the patch generates no new warnings/errors.
>>
>> Changes since v1:
>> 1. Use device_get_match_data() in probe and store result for re-use.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20251103075920.2611642-1-b-padhi@ti.com/
>>
>> Changes since RFC:
>> 1. Skip checking pending messages instead of flushing
>> them explicitly for K3 devices.
>>
>> Link to RFC Version:
>> https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/
>>
>>   drivers/mailbox/omap-mailbox.c | 35 +++++++++++++++++++---------------
>>   1 file changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
>> index 680243751d62..17fe6545875d 100644
>> --- a/drivers/mailbox/omap-mailbox.c
>> +++ b/drivers/mailbox/omap-mailbox.c
>> @@ -68,6 +68,7 @@ struct omap_mbox_fifo {
>>     struct omap_mbox_match_data {
>>       u32 intr_type;
>> +    bool is_exclusive;
>>   };
>>     struct omap_mbox_device {
>> @@ -78,6 +79,7 @@ struct omap_mbox_device {
>>       u32 num_users;
>>       u32 num_fifos;
>>       u32 intr_type;
>> +    const struct omap_mbox_match_data *mbox_data;
>
> Not a fan of this, you could have stored just the relevant
> flag from the match data here in the instance data, not a
> pointer to the whole const struct. 


Umm, will this scale up? What if tomorrow another field
gets added to the match data struct, why should we
manually have to maintain those fields in this struct
instead of holding a pointer?

> The issue being now you
> have the same info stored in two places, `intr_type` in the
> match data above, and intr_type on the line above that.
>
> Looking more into it, the use of `intr_type` doesn't need to be
> stored in each mbox's instance data either, but that is an existing
> issue. 


Yup, now that we have the pointer to the match_data,
we can remove the `intr_type`. A cleanup for another
day though.

Thanks,
Beleswar

> For now I don't want to hold up an otherwise good bugfix
> over that, but we will want to come back here and clean some of
> this up next cycle, for now,
>
> Reviewed-by: Andrew Davis <afd@ti.com>
>
>>   };
>>     struct omap_mbox {
>> @@ -341,11 +343,13 @@ static int omap_mbox_suspend(struct device *dev)
>>       if (pm_runtime_status_suspended(dev))
>>           return 0;
>>   -    for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
>> -        if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
>> -            dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
>> -                fifo);
>> -            return -EBUSY;
>> +    if (mdev->mbox_data->is_exclusive) {
>> +        for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
>> +            if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
>> +                dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
>> +                    fifo);
>> +                return -EBUSY;
>> +            }
>>           }
>>       }
>>   @@ -378,8 +382,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
>>       SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
>>   };
>>   -static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
>> -static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
>> +static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1, true };
>> +static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2, true };
>> +static const struct omap_mbox_match_data am654_data = { MBOX_INTR_CFG_TYPE2, false };
>>     static const struct of_device_id omap_mailbox_of_match[] = {
>>       {
>> @@ -396,11 +401,11 @@ static const struct of_device_id omap_mailbox_of_match[] = {
>>       },
>>       {
>>           .compatible    = "ti,am654-mailbox",
>> -        .data        = &omap4_data,
>> +        .data        = &am654_data,
>>       },
>>       {
>>           .compatible    = "ti,am64-mailbox",
>> -        .data        = &omap4_data,
>> +        .data        = &am654_data,
>>       },
>>       {
>>           /* end */
>> @@ -449,7 +454,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
>>       struct omap_mbox_fifo *fifo;
>>       struct device_node *node = pdev->dev.of_node;
>>       struct device_node *child;
>> -    const struct omap_mbox_match_data *match_data;
>>       struct mbox_controller *controller;
>>       u32 intr_type, info_count;
>>       u32 num_users, num_fifos;
>> @@ -462,11 +466,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
>>           return -ENODEV;
>>       }
>>   -    match_data = of_device_get_match_data(&pdev->dev);
>> -    if (!match_data)
>> -        return -ENODEV;
>> -    intr_type = match_data->intr_type;
>> -
>>       if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
>>           return -ENODEV;
>>   @@ -483,6 +482,12 @@ static int omap_mbox_probe(struct platform_device *pdev)
>>       if (!mdev)
>>           return -ENOMEM;
>>   +    mdev->mbox_data = device_get_match_data(&pdev->dev);
>> +    if (!mdev->mbox_data)
>> +        return -ENODEV;
>> +
>> +    intr_type = mdev->mbox_data->intr_type;
>> +
>>       mdev->mbox_base = devm_platform_ioremap_resource(pdev, 0);
>>       if (IS_ERR(mdev->mbox_base))
>>           return PTR_ERR(mdev->mbox_base);
>

